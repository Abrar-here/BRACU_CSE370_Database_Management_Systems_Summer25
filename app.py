import os
from flask import Flask, render_template, redirect, url_for, request, flash
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from dotenv import load_dotenv
from datetime import datetime, time
from functools import wraps


load_dotenv()
app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'dev-secret')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

UPLOAD_FOLDER = 'static/images'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


from models import db, User, Admin, Adopter, Pet, Event, EventRegistration, Feedback, MedicalRecord, FeedingSchedule
db.init_app(app)

from forms import RegisterForm, LoginForm, PetForm, FeedbackForm, MedicalRecordForm, FeedingScheduleForm, EventForm, ManageEventPetsForm

login_manager = LoginManager(app)
login_manager.login_view = "login"

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not current_user.is_authenticated or not current_user.admin:
            flash("Admin access required.", "danger")
            return redirect(url_for('events'))
        return f(*args, **kwargs)
    return decorated_function


@app.route('/')
def home():
    featured_pets = Pet.query.limit(5).all()
    return render_template('home.html', featured_pets=featured_pets)

@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm()
    if form.validate_on_submit():
        if User.query.filter_by(Email=form.email.data).first():
            flash("Email already registered!", "warning")
            return redirect(url_for('register'))
        user = User(Name=form.name.data, Email=form.email.data,
                    Password_hash=generate_password_hash(form.password.data))
        db.session.add(user)
        db.session.commit()
        return redirect(url_for('login'))
    return render_template('auth/register.html', form=form)

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(Email=form.email.data).first()
        if not user:
            flash("Email not found!", "danger")
            return redirect(url_for('login'))
        if not check_password_hash(user.Password_hash, form.password.data):
            flash("Incorrect password!", "danger")
            return redirect(url_for('login'))
        if form.role.data == 'admin' and not user.admin:
            flash("You're not an admin!", "danger")
            return redirect(url_for('login'))
        login_user(user)
        flash(f"Welcome, {user.Name}!", "success")
        return redirect(url_for('home'))
    return render_template('auth/login.html', form=form)

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('home'))


@app.route('/feedback', methods=['GET', 'POST'])
def feedback():
    feedbacks = Feedback.query.order_by(Feedback.Date.desc()).all()
    form = None
    if current_user.is_authenticated:
        form = FeedbackForm()
        if form.validate_on_submit():
            fb = Feedback(
                Content=form.content.data,
                Rating=form.rating.data,
                User_id=current_user.User_id
            )
            db.session.add(fb)
            db.session.commit()
            flash("Feedback submitted!", "success")
            return redirect(url_for('feedback'))
    return render_template('feedback/feedback.html', feedbacks=feedbacks, form=form)

@app.route('/feedback/delete/<int:feedback_id>')
@login_required
def delete_feedback(feedback_id):
    if not current_user.admin:
        flash("Only admins can delete feedback!", "danger")
        return redirect(url_for('feedback'))
    fb = Feedback.query.get(feedback_id)
    if fb:
        db.session.delete(fb)
        db.session.commit()
    return redirect(url_for('feedback'))

@app.route('/pets')
def pets():
    available_pets = Pet.query.filter_by(User_id=None).all()
    my_pets = []
    if current_user.is_authenticated:
        my_pets = Pet.query.filter_by(User_id=current_user.User_id).all()
    return render_template('pets/pets.html', available_pets=available_pets, my_pets=my_pets)


@app.route('/add_pet', methods=['GET', 'POST'])
@login_required
def add_pet():
    if not current_user.admin:
        flash("Only admins can add pets!", "danger")
        return redirect(url_for('pets'))
    if request.method == 'POST':
        name = request.form['name']
        breed = request.form['breed']
        age = request.form['age']
        status = request.form['status']
        file = request.files.get('image_file')
        filename = 'default_pet.png'
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        pet = Pet(Name=name, Breed=breed, Age=age, Adoption_status=status, Image_url=f'images/{filename}')
        db.session.add(pet)
        db.session.commit()
        flash(f"{name} added successfully!", "success")
        return redirect(url_for('pets'))
    return render_template('pets/add_pet.html')

@app.route('/delete_pet/<int:pet_id>', methods=['POST'])
@login_required
def delete_pet(pet_id):
    if not current_user.admin:
        flash("Only admins can delete pets!", "danger")
        return redirect(url_for('pets'))
    pet = Pet.query.get_or_404(pet_id)
    db.session.delete(pet)
    db.session.commit()
    flash(f"Pet {pet.Name} deleted successfully.", "success")
    return redirect(url_for('pets'))

@app.route('/adopt/<int:pet_id>', methods=['POST'])
@login_required
def adopt_pet(pet_id):
    pet = Pet.query.get_or_404(pet_id)
    if pet.User_id:
        flash(f"{pet.Name} has already been adopted!", "warning")
        return redirect(url_for('pets'))
    pet.User_id = current_user.User_id
    pet.Adoption_status = "Adopted"
    db.session.commit()
    flash(f"You have successfully adopted {pet.Name}!", "success")
    return redirect(url_for('pets'))

@app.route('/medical_records/<int:pet_id>')
@login_required
def medical_records(pet_id):
    pet = Pet.query.get_or_404(pet_id)
    records = MedicalRecord.query.filter_by(pet_id=pet_id).order_by(MedicalRecord.date.desc()).all()
    return render_template("pets/medicalrecord.html", pet=pet, records=records)

@app.route('/medical_records/add/<int:pet_id>', methods=['GET', 'POST'])
@login_required
def add_medical_record(pet_id):
    if not current_user.admin:
        flash("Only admins can add medical records!", "danger")
        return redirect(url_for('pets'))
    pet = Pet.query.get_or_404(pet_id)
    form = MedicalRecordForm()
    if form.validate_on_submit():
        record = MedicalRecord(pet_id=pet.Pet_id, description=form.description.data, date=form.date.data)
        db.session.add(record)
        db.session.commit()
        return redirect(url_for('medical_records', pet_id=pet.Pet_id))
    return render_template("pets/add_medicalrecord.html", form=form, pet=pet)

@app.route('/feeding_schedule/<int:pet_id>')
@login_required
def feeding_schedule(pet_id):
    pet = Pet.query.get_or_404(pet_id)
    schedules = FeedingSchedule.query.filter_by(pet_id=pet_id).order_by(FeedingSchedule.feeding_time.asc()).all()
    return render_template("pets/feeding_schedule.html", pet=pet, schedules=schedules)

@app.route('/feeding_schedule/add/<int:pet_id>', methods=['GET', 'POST'])
@login_required
def add_feeding_schedule(pet_id):
    if not current_user.admin:
        flash("Only admins can add feeding schedules!", "danger")
        return redirect(url_for('pets'))
    pet = Pet.query.get_or_404(pet_id)
    form = FeedingScheduleForm()
    if form.validate_on_submit():
        schedule = FeedingSchedule(pet_id=pet.Pet_id, feeding_time=form.time.data, food_type=form.food_type.data, notes=form.notes.data)
        db.session.add(schedule)
        db.session.commit()
        return redirect(url_for('feeding_schedule', pet_id=pet.Pet_id))
    return render_template("pets/add_feeding_schedule.html", form=form, pet=pet)

@app.route('/feeding_schedule/delete/<int:schedule_id>', methods=['POST'])
@login_required
def delete_feeding_schedule(schedule_id):
    if not current_user.admin:
        flash("Only admins can delete feeding schedules!", "danger")
        return redirect(url_for('pets'))
    schedule = FeedingSchedule.query.get_or_404(schedule_id)
    db.session.delete(schedule)
    db.session.commit()
    flash("Feeding schedule deleted successfully.", "success")
    return redirect(url_for('feeding_schedule', pet_id=schedule.pet_id))


@app.route('/events')
@login_required
def events():
    events = Event.query.all()
    my_registered_events = [reg.event for reg in current_user.event_registrations] if current_user.is_authenticated else []
    return render_template('events/events.html', events=events, my_registered_events=my_registered_events, is_admin=current_user.admin)

@app.route('/event/<int:event_id>')
def event_detail(event_id):
    event = Event.query.get_or_404(event_id)
    return render_template('events/event_detail.html', event=event, registered_users=event.users, pets=event.pets)

@app.route('/admin/events')
@login_required
@admin_required
def admin_events():
    all_events = Event.query.all()
    return render_template('events/admin_events.html', events=all_events)

@app.route('/event/<int:event_id>/manage_pets', methods=['GET', 'POST'])
@login_required
@admin_required
def manage_event_pets(event_id):
    event = Event.query.get_or_404(event_id)
    form = ManageEventPetsForm()
    form.pets.choices = [(pet.Pet_id, pet.Name) for pet in Pet.query.all()]
    if request.method == 'GET':
        form.pets.data = [pet.Pet_id for pet in event.pets]
    if form.validate_on_submit():
        selected_pets = Pet.query.filter(Pet.Pet_id.in_(form.pets.data)).all()
        event.pets = selected_pets
        db.session.commit()
        flash("Pets updated for this event!", "success")
        return redirect(url_for('admin_events'))
    return render_template('events/manage_event_pets.html', event=event, form=form)

@app.route('/add_event', methods=['GET', 'POST'])
@login_required
@admin_required
def add_event():
    form = EventForm()
    if form.validate_on_submit():
        new_event = Event(Event_Name=form.name.data, Date=form.date.data, Location=form.location.data, Description=form.description.data)
        db.session.add(new_event)
        db.session.commit()
        flash("Event created successfully!", "success")
        return redirect(url_for('admin_events'))
    return render_template('events/add_event.html', form=form)

@app.route('/event/<int:event_id>/delete', methods=['POST'])
@login_required
@admin_required
def delete_event(event_id):
    event = Event.query.get_or_404(event_id)
    db.session.delete(event)
    db.session.commit()
    flash(f'Event "{event.Event_Name}" has been deleted!', 'success')
    return redirect(url_for('admin_events'))

@app.route('/register_event/<int:event_id>', methods=['POST'])
@login_required
def register_event(event_id):
    event = Event.query.get_or_404(event_id)
    existing = EventRegistration.query.filter_by(User_id=current_user.User_id, Event_id=event_id).first()
    if existing:
        flash("You are already registered for this event.", "warning")
    else:
        registration = EventRegistration(User_id=current_user.User_id, Event_id=event_id)
        db.session.add(registration)
        db.session.commit()
        flash("Successfully registered for the event!", "success")
    return redirect(url_for('event_detail', event_id=event_id))

@app.route('/unregister_event/<int:event_id>', methods=['POST'])
@login_required
def unregister_event(event_id):
    registration = EventRegistration.query.filter_by(User_id=current_user.User_id, Event_id=event_id).first()
    if registration:
        db.session.delete(registration)
        db.session.commit()
        flash("You have unregistered from the event.", "info")
    else:
        flash("You were not registered for this event.", "warning")
    return redirect(url_for('event_detail', event_id=event_id))


@app.route('/admin')
@login_required
def admin_dashboard():
    if not current_user.admin:
        flash("Access denied!", "danger")
        return redirect(url_for('home'))
    return render_template('admin/admin_dashboard.html')


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
