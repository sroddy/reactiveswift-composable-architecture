import CoreLocation

/// A value type wrapper for `CLLocation`. This type is necessary so that we can do equality checks
/// and write tests against its values.
public struct Location: Equatable {
  public let rawValue: CLLocation?

  public var altitude: CLLocationDistance
  public var coordinate: CLLocationCoordinate2D
  public var course: CLLocationDirection
  public var courseAccuracy: Double
  @available(macOS 10.15, *)
  public lazy var floor: CLFloor? = nil
  public var horizontalAccuracy: CLLocationAccuracy
  public var speed: CLLocationSpeed
  public var speedAccuracy: Double
  public var timestamp: Date
  public var verticalAccuracy: CLLocationAccuracy

  @available(macOS 10.15, *)
  public init(
    altitude: CLLocationDistance = 0,
    coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0),
    course: CLLocationDirection = 0,
    courseAccuracy: Double = 0,
    floor: CLFloor? = nil,
    horizontalAccuracy: CLLocationAccuracy = 0,
    speed: CLLocationSpeed = 0,
    speedAccuracy: Double = 0,
    timestamp: Date = Date(),
    verticalAccuracy: CLLocationAccuracy = 0
  ) {
    self.rawValue = nil
    self.altitude = altitude
    self.coordinate = coordinate
    self.course = course
    self.courseAccuracy = courseAccuracy
    self.horizontalAccuracy = horizontalAccuracy
    self.speed = speed
    self.speedAccuracy = speedAccuracy
    self.timestamp = timestamp
    self.verticalAccuracy = verticalAccuracy
    self.floor = floor
  }

  public init(rawValue: CLLocation) {
    self.rawValue = rawValue

    self.altitude = rawValue.altitude
    self.coordinate = rawValue.coordinate
    self.course = rawValue.course
    self.horizontalAccuracy = rawValue.horizontalAccuracy
    self.speed = rawValue.speed
    self.timestamp = rawValue.timestamp
    self.verticalAccuracy = rawValue.verticalAccuracy
    #if compiler(>=5.2)
      if #available(iOS 13.4, macCatalyst 13.4, macOS 10.15.4, tvOS 13.4, watchOS 6.2, *) {
        self.courseAccuracy = rawValue.courseAccuracy
      } else {
        self.courseAccuracy = 0
      }
      if #available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *) {
        self.speedAccuracy = rawValue.speedAccuracy
      } else {
        self.speedAccuracy = 0
      }
    #else
      self.courseAccuracy = 0
      self.speedAccuracy = 0
    #endif
    if #available(macOS 10.15, *) {
      self.floor = rawValue.floor
    }
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    if #available(macOS 10.15, *) {
      var _lhs = lhs
      var _rhs = rhs

      return lhs.altitude == rhs.altitude
        && lhs.coordinate.latitude == rhs.coordinate.latitude
        && lhs.coordinate.longitude == rhs.coordinate.longitude
        && lhs.course == rhs.course
        && lhs.courseAccuracy == rhs.courseAccuracy
        && _lhs.floor == _rhs.floor
        && lhs.horizontalAccuracy == rhs.horizontalAccuracy
        && lhs.speed == rhs.speed
        && lhs.speedAccuracy == rhs.speedAccuracy
        && lhs.timestamp == rhs.timestamp
        && lhs.verticalAccuracy == rhs.verticalAccuracy
    } else {
      return lhs.altitude == rhs.altitude
        && lhs.coordinate.latitude == rhs.coordinate.latitude
        && lhs.coordinate.longitude == rhs.coordinate.longitude
        && lhs.course == rhs.course
        && lhs.courseAccuracy == rhs.courseAccuracy
        && lhs.horizontalAccuracy == rhs.horizontalAccuracy
        && lhs.speed == rhs.speed
        && lhs.speedAccuracy == rhs.speedAccuracy
        && lhs.timestamp == rhs.timestamp
        && lhs.verticalAccuracy == rhs.verticalAccuracy
    }
  }
}
