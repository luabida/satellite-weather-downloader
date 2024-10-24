# Create app celery to start _downloader
from celery import Celery
from celeryapp import delay_controller as delay

app = Celery('beat_weather')

app.config_from_object('celeryapp.weather.config')

# Beat tasks schedules
app.conf.beat_schedule = {
    'fetch-copernicus-data-for-brasil': {
        'task': 'fetch_copernicus_brasil',
        'schedule': delay.get_task_schedule('fetch_copernicus_brasil'),
        'options': {'queue': 'weather.fetch'},
    },
    'fetch-copernicus-data-for-foz-do-iguacu': {
        'task': 'fetch_copernicus_foz',
        'schedule': delay.get_task_schedule('fetch_copernicus_foz'),
        'options': {'queue': 'weather.fetch'},
    },
}
