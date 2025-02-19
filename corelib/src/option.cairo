use array::ArrayTrait;

enum Option<T> {
    Some: T,
    None: (),
}
trait OptionTrait<T> {
    /// If `val` is `Option::Some(x)`, returns `x`. Otherwise, panics with `err`.
    fn expect(self: Option<T>, err: felt252) -> T;
    /// If `val` is `Option::Some(x)`, returns `x`. Otherwise, panics.
    fn unwrap(self: Option<T>) -> T;
    /// Returns `true` if the `Option` is `Option::Some`.
    fn is_some(self: @Option<T>) -> bool;
    /// Returns `true` if the `Option` is `Option::None`.
    fn is_none(self: @Option<T>) -> bool;
}
impl OptionTraitImpl<T> of OptionTrait::<T> {
    #[inline(always)]
    fn expect(self: Option<T>, err: felt252) -> T {
        match self {
            Option::Some(x) => x,
            Option::None(()) => panic_with_felt252(err),
        }
    }
    #[inline(always)]
    fn unwrap(self: Option<T>) -> T {
        self.expect('Option::unwrap failed.')
    }
    #[inline(always)]
    fn is_some(self: @Option<T>) -> bool {
        match self {
            Option::Some(_) => true,
            Option::None(_) => false,
        }
    }
    #[inline(always)]
    fn is_none(self: @Option<T>) -> bool {
        match self {
            Option::Some(_) => false,
            Option::None(_) => true,
        }
    }
}

// Impls for generic types.
impl OptionCopy<T, impl TCopy: Copy::<T>> of Copy::<Option<T>>;
impl OptionDrop<T, impl TDrop: Drop::<T>> of Drop::<Option<T>>;
