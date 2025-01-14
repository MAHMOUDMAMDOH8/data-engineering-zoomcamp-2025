from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
import pandas as pd

connection_string = f'postgresql://root:1234@172.18.0.2/nyc_trip'
engine = create_engine(connection_string)
engine.connect()

G_trip = pd.read_csv('./green_tripdata_2019-10.csv')

taxi_zone = pd.read_csv('./taxi_zone_lookup.csv')

G_trip.lpep_pickup_datetime = pd.to_datetime(G_trip.lpep_pickup_datetime)
G_trip.lpep_dropoff_datetime = pd.to_datetime(G_trip.lpep_dropoff_datetime)

G_trip.to_sql(name = 'green_tripdata',con = engine ,if_exists='replace')

taxi_zone.to_sql(name='taxi_zone',con=engine,if_exists='replace')
