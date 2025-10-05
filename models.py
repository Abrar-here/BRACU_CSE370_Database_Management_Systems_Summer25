from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from sqlalchemy.sql import func


db = SQLAlchemy() 


features = db.Table(
    'features',
    db.Column('Event_id', db.Integer, db.ForeignKey('event.Event-id'), primary_key=True),
    db.Column('Pet_id', db.Integer, db.ForeignKey('pet.Pet_id'), primary_key=True)
)


class User(db.Model, UserMixin):
    __tablename__ = "user"
    User_id = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(100), nullable=False)
    Email = db.Column(db.String(100), nullable=False, unique=True)
    Password_hash = db.Column(db.String(255), nullable=False)
    admin = db.Column(db.Boolean, default=False)

    def get_id(self):
        return str(self.User_id)

    event_registrations = db.relationship(
        "EventRegistration", back_populates="user", cascade="all, delete-orphan"
    )

    @property
    def events(self):
        return [reg.event for reg in self.event_registrations]


class Admin(db.Model):
    __tablename__ = "admin"
    User_id = db.Column(db.Integer, db.ForeignKey("user.User_id"), primary_key=True)
    Admin_level = db.Column(db.String(50), nullable=False)

    user = db.relationship("User", backref="admin_relation")


class Adopter(db.Model):
    __tablename__ = "adopter"
    User_id = db.Column(db.Integer, db.ForeignKey("user.User_id"), primary_key=True)
    user = db.relationship("User", backref=db.backref("adopter", uselist=False))


class Pet(db.Model):
    __tablename__ = "pet"
    Pet_id = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(100), nullable=False)
    Breed = db.Column(db.String(50), nullable=False)
    Age = db.Column(db.Integer, nullable=False)

    Image_url = db.Column(db.String(255), nullable=True)
    Adoption_status = db.Column(db.String(20), nullable=False, default="Available")
    User_id = db.Column(db.Integer, db.ForeignKey("user.User_id"), nullable=True)

    adopter = db.relationship("User", backref="adopted_pets", lazy=True)
    events = db.relationship("Event", secondary=features, back_populates="pets")

    def is_available(self):
        return self.Adoption_status.lower() == "available"
    


class Feedback(db.Model):
    __tablename__ = "feedback"
    feedback_id = db.Column(db.Integer, primary_key=True)
    Content = db.Column(db.String(300), nullable=False)
    Date = db.Column(db.Date, server_default=func.current_date(), nullable=False)
    Rating = db.Column(db.Integer, nullable=False)
    User_id = db.Column(db.Integer, db.ForeignKey("user.User_id"), nullable=False)

    user = db.relationship("User", backref="feedbacks")


class FeedingSchedule(db.Model):
    Schedule_id = db.Column(db.Integer, primary_key=True)
    pet_id = db.Column(db.Integer, db.ForeignKey('pet.Pet_id'))
    feeding_time = db.Column("Feeding_time", db.Time)  
    food_type    = db.Column("Food_type", db.String(100))  
    notes        = db.Column("Notes", db.String(255))      

    pet = db.relationship("Pet", backref="feeding_schedules")


class Event(db.Model):
    __tablename__ = 'event'
    Event_id = db.Column("Event-id", db.Integer, primary_key=True)
    Event_Name = db.Column(db.String(100), nullable=False)
    Date = db.Column(db.Date, nullable=False)
    Location = db.Column(db.String(200), nullable=False)
    Description = db.Column(db.String(300), nullable=False)

    event_registrations = db.relationship("EventRegistration", back_populates="event", cascade="all, delete-orphan")
    pets = db.relationship("Pet", secondary=features, back_populates="events")

    @property
    def users(self):
        return [reg.user for reg in self.event_registrations]


class EventRegistration(db.Model):
    __tablename__ = 'us_registers_for_event'
    User_id = db.Column(db.Integer, db.ForeignKey("user.User_id"), primary_key=True)
    Event_id = db.Column(db.Integer, db.ForeignKey("event.Event-id"), primary_key=True)

    user = db.relationship("User", back_populates="event_registrations")
    event = db.relationship("Event", back_populates="event_registrations")

class MedicalRecord(db.Model):
    __tablename__ = "medical_record"
    record_id = db.Column(db.Integer, primary_key=True)
    pet_id = db.Column(db.Integer, db.ForeignKey("pet.Pet_id"), nullable=False)
    description = db.Column(db.String(255), nullable=False)
    date = db.Column(db.Date, nullable=False)

    pet = db.relationship("Pet", backref="medical_records")
