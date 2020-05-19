import CoreLocation
import ComposableArchitecture

extension LocationManagerClient {
  #if os(iOS) || targetEnvironment(macCatalyst)
  public static func mock(
    authorizationStatus: @escaping () -> CLAuthorizationStatus = { fatalError() },
    create: @escaping (_ id: AnyHashable) -> Effect<LocationManagerAction, Never> = { _ in fatalError() },
    destroy: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    dismissHeadingCalibrationDisplay: @escaping (AnyHashable) -> Effect<Never, Never>,
    heading: @escaping (AnyHashable) -> Heading?,
    headingAvailable: @escaping () -> Bool,
    isRangingAvailable: @escaping () -> Bool,
    location: @escaping (AnyHashable) -> Location,
    locationServicesEnabled: @escaping () -> Bool = { fatalError() },
    maximumRegionMonitoringDistance: @escaping (AnyHashable) -> CLLocationDistance,
    monitoredRegions: @escaping (AnyHashable) -> Set<Region>,
    requestLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    requestAlwaysAuthorization: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    requestWhenInUseAuthorization: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    significantLocationChangeMonitoringAvailable: @escaping () -> Bool,
    startMonitoringSignificantLocationChanges: @escaping (AnyHashable) -> Effect<Never, Never>,
    startMonitoringForRegion: @escaping (AnyHashable, Region) -> Effect<Never, Never>,
    startMonitoringVisits: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    startUpdatingLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    stopMonitoringSignificantLocationChanges: @escaping (AnyHashable) -> Effect<Never, Never>,
    stopMonitoringForRegion: @escaping (AnyHashable, Region) -> Effect<Never, Never>,
    stopMonitoringVisits: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    startUpdatingHeading: @escaping (AnyHashable) -> Effect<Never, Never>,
    stopUpdatingHeading: @escaping (AnyHashable) -> Effect<Never, Never>,
    stopUpdatingLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    update: @escaping (_ id: AnyHashable, _ properties: Properties) -> Effect<Never, Never> = { _, _ in fatalError() }
  ) -> Self {
    Self(
      authorizationStatus: authorizationStatus,
      create: create,
      destroy: destroy,
      dismissHeadingCalibrationDisplay: dismissHeadingCalibrationDisplay,
      heading: heading,
      headingAvailable: headingAvailable,
      isRangingAvailable: isRangingAvailable,
      location: location,
      locationServicesEnabled: locationServicesEnabled,
      maximumRegionMonitoringDistance: maximumRegionMonitoringDistance,
      monitoredRegions: monitoredRegions,
      requestLocation: requestLocation,
      requestAlwaysAuthorization: requestAlwaysAuthorization,
      requestWhenInUseAuthorization: requestWhenInUseAuthorization,
      significantLocationChangeMonitoringAvailable: significantLocationChangeMonitoringAvailable,
      startMonitoringForRegion: startMonitoringForRegion,
      startMonitoringSignificantLocationChanges: startMonitoringSignificantLocationChanges,
      startMonitoringVisits: startMonitoringVisits,
      startUpdatingLocation: startUpdatingLocation,
      stopMonitoringForRegion: stopMonitoringForRegion,
      stopMonitoringSignificantLocationChanges: stopMonitoringSignificantLocationChanges,
      stopMonitoringVisits: stopMonitoringVisits,
      startUpdatingHeading: startUpdatingHeading,
      stopUpdatingHeading: stopUpdatingHeading,
      stopUpdatingLocation: stopUpdatingLocation,
      update: update
    )
  }
  #elseif os(watchOS)
  public static func mock(
    authorizationStatus: @escaping () -> CLAuthorizationStatus = { fatalError() },
    create: @escaping (_ id: AnyHashable) -> Effect<LocationManagerAction, Never> = { _ in fatalError() },
    destroy: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    dismissHeadingCalibrationDisplay: @escaping (AnyHashable) -> Effect<Never, Never>,
    heading: @escaping (AnyHashable) -> Heading?,
    headingAvailable: @escaping () -> Bool,
    location: @escaping (AnyHashable) -> Location,
    locationServicesEnabled: @escaping () -> Bool = { fatalError() },
    requestLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    requestAlwaysAuthorization: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    requestWhenInUseAuthorization: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    startUpdatingLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    startUpdatingHeading: @escaping (AnyHashable) -> Effect<Never, Never>,
    stopUpdatingHeading: @escaping (AnyHashable) -> Effect<Never, Never>,
    stopUpdatingLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    update: @escaping (_ id: AnyHashable, _ properties: Properties) -> Effect<Never, Never> = { _, _ in fatalError() }
  ) -> Self {
    Self(
      authorizationStatus: authorizationStatus,
      create: create,
      destroy: destroy,
      dismissHeadingCalibrationDisplay: dismissHeadingCalibrationDisplay,
      heading: heading,
      headingAvailable: headingAvailable,
      location: location,
      locationServicesEnabled: locationServicesEnabled,
      requestLocation: requestLocation,
      requestAlwaysAuthorization: requestAlwaysAuthorization,
      requestWhenInUseAuthorization: requestWhenInUseAuthorization,
      startUpdatingLocation: startUpdatingLocation,
      startUpdatingHeading: startUpdatingHeading,
      stopUpdatingHeading: stopUpdatingHeading,
      stopUpdatingLocation: stopUpdatingLocation,
      update: update
    )
  }
  #elseif os(tvOS)
  public static func mock(
    authorizationStatus: @escaping () -> CLAuthorizationStatus = { fatalError() },
    create: @escaping (_ id: AnyHashable) -> Effect<LocationManagerAction, Never> = { _ in fatalError() },
    destroy: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    location: @escaping (AnyHashable) -> Location,
    locationServicesEnabled: @escaping () -> Bool = { fatalError() },
    requestLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    requestWhenInUseAuthorization: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    stopUpdatingLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    update: @escaping (_ id: AnyHashable, _ properties: Properties) -> Effect<Never, Never> = { _, _ in fatalError() }
  ) -> Self {
    Self(
      authorizationStatus: authorizationStatus,
      create: create,
      destroy: destroy,
      location: location,
      locationServicesEnabled: locationServicesEnabled,
      requestLocation: requestLocation,
      requestWhenInUseAuthorization: requestWhenInUseAuthorization,
      stopUpdatingLocation: stopUpdatingLocation,
      update: update
    )
  }
  #elseif os(macOS)
  public static func mock(
    authorizationStatus: @escaping () -> CLAuthorizationStatus = { fatalError() },
    create: @escaping (_ id: AnyHashable) -> Effect<LocationManagerAction, Never> = { _ in fatalError() },
    destroy: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    headingAvailable: @escaping () -> Bool,
    location: @escaping (AnyHashable) -> Location,
    locationServicesEnabled: @escaping () -> Bool = { fatalError() },
    maximumRegionMonitoringDistance: @escaping (AnyHashable) -> CLLocationDistance,
    monitoredRegions: @escaping (AnyHashable) -> Set<Region>,
    requestLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    requestAlwaysAuthorization: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    significantLocationChangeMonitoringAvailable: @escaping () -> Bool,
    startMonitoringForRegion: @escaping (AnyHashable, Region) -> Effect<Never, Never>,
    startMonitoringSignificantLocationChanges: @escaping (AnyHashable) -> Effect<Never, Never>,
    startUpdatingLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    stopMonitoringForRegion: @escaping (AnyHashable, Region) -> Effect<Never, Never>,
    stopMonitoringSignificantLocationChanges: @escaping (AnyHashable) -> Effect<Never, Never>,
    startUpdatingHeading: @escaping (AnyHashable) -> Effect<Never, Never>,
    stopUpdatingHeading: @escaping (AnyHashable) -> Effect<Never, Never>,
    stopUpdatingLocation: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in fatalError() },
    update: @escaping (_ id: AnyHashable, _ properties: Properties) -> Effect<Never, Never> = { _, _ in fatalError() }
  ) -> Self {
    Self(
      authorizationStatus: authorizationStatus,
      create: create,
      destroy: destroy,
      headingAvailable: headingAvailable,
      location: location,
      locationServicesEnabled: locationServicesEnabled,
      maximumRegionMonitoringDistance: maximumRegionMonitoringDistance,
      monitoredRegions: monitoredRegions,
      requestLocation: requestLocation,
      requestAlwaysAuthorization: requestAlwaysAuthorization,
      significantLocationChangeMonitoringAvailable: significantLocationChangeMonitoringAvailable,
      startMonitoringForRegion: startMonitoringForRegion,
      startMonitoringSignificantLocationChanges: startMonitoringSignificantLocationChanges,
      startUpdatingLocation: startUpdatingLocation,
      stopMonitoringForRegion: stopMonitoringForRegion,
      stopMonitoringSignificantLocationChanges: stopMonitoringSignificantLocationChanges,
      startUpdatingHeading: startUpdatingHeading,
      stopUpdatingHeading: stopUpdatingHeading,
      stopUpdatingLocation: stopUpdatingLocation,
      update: update
    )
  }
  #endif
}