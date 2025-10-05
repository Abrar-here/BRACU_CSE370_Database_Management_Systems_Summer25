from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import (
    StringField, PasswordField, IntegerField, SubmitField, SelectField,
    DateField, TimeField, TextAreaField, SelectMultipleField, widgets, BooleanField
)
from wtforms.validators import DataRequired, Email, Length, NumberRange
from wtforms.widgets import ListWidget, CheckboxInput



class RegisterForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired(), Length(min=6)])
    submit = SubmitField('Register')


class LoginForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    role = SelectField('Role', choices=[('user', 'User'), ('admin', 'Admin')])
    submit = SubmitField('Login')



class PetForm(FlaskForm):
    name = StringField("Pet Name", validators=[DataRequired()])
    breed = StringField("Breed", validators=[DataRequired()])
    age = IntegerField("Age", validators=[DataRequired()])
    status = StringField("Status", validators=[DataRequired()])
    image = FileField("Pet Photo", validators=[FileAllowed(['jpg','png','jpeg'], 'Images only!')])
    submit = SubmitField("Add Pet")


class FeedbackForm(FlaskForm):
    content = StringField('Message', validators=[DataRequired()])
    rating = IntegerField('Rating', validators=[DataRequired(), NumberRange(min=1, max=5)])
    submit = SubmitField('Send')


class MedicalRecordForm(FlaskForm):
    description = StringField('Description', validators=[DataRequired()])
    date = DateField('Date', format='%Y-%m-%d', validators=[DataRequired()])
    submit = SubmitField('Add Record')


class FeedingScheduleForm(FlaskForm):
    time = TimeField('Feeding Time', format='%H:%M', validators=[DataRequired()])
    food_type = StringField('Food Type', validators=[DataRequired()])
    notes = TextAreaField('Notes')
    submit = SubmitField('Add Schedule')


class EventForm(FlaskForm):
    name = StringField("Event Name", validators=[DataRequired()])
    date = DateField("Date", format="%Y-%m-%d", validators=[DataRequired()])
    location = StringField("Location", validators=[DataRequired()])
    description = TextAreaField("Description", validators=[DataRequired()])
    submit = SubmitField("Create Event")

class MultiCheckboxField(SelectMultipleField):
    widget = ListWidget(prefix_label=False)
    option_widget = CheckboxInput()


class ManageEventPetsForm(FlaskForm):
    pets = MultiCheckboxField("Select Pets", coerce=int) 
    submit = SubmitField("Save")
