=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, состоящий из отдельных токенов.
Токен - это отдельная логическая часть выражения: число, скобка или арифметическая операция
В случае ошибки в выражении функция должна вызывать die с сообщением об ошибке

Знаки '-' и '+' в первой позиции, или после другой арифметической операции стоит воспринимать
как унарные и можно записывать как "U-" и "U+"

Стоит заметить, что после унарного оператора нельзя использовать бинарные операторы
Например последовательность 1 + - / 2 невалидна. Бинарный оператор / идёт после использования унарного "-"

(Использованы перловские приоритеты)

=cut
use 5.010;
use strict;
use warnings;
use Data::Dumper;
use diagnostics;

BEGIN {
	if ($] < 5.018) {
		package experimental;
		use warnings::register;
	}
}
no warnings 'experimental';

sub tokenize($) {
	chomp ( my $expr = shift );
	die "Не хватает цифр в выражении" unless $expr =~ /\d+/;
	my @res;
<<<<<<< HEAD:chat/lib/tokenize.pl
	
	@res = ($expr =~ /[\*\^]|[-\+]|[\/]|[\(]|[\)]|\d*[.]?\d(?:[eE][-\+]?\d+)?/g);
	if ($res[0] =~ /^[\)\*\/\^]$/) {die "NaN";};
	for (0..$#res) { #string processing
	
		#Unary operors processing
		if ($res[$_] =~ /^[-\+]$/ and (!$_ or $res[$_-1] =~ m{^(?:[-\+\*\^\/\(]|U[-\+])$})) {$res[$_] = 'U'.$res[$_];}
		}

	for (0..$#res) {
		
		#Is unary operators correct?
		if ($res[$_] =~ /^U[-\+]$/ and ($_ == $#res or $res[$_+1] =~ m|^[-\+\*\^/\)]$|)) {die "Not a number after unary operator (".($_+2)." element of expression)"}
		
		#Numbers processing
		if ($res[$_] =~ /\d*[.]?\d+(?:[eE][-\+]?\d+)?/) {
			$res[$_] += 0;
			if (($_ != $#res and $res[$_+1] =~ /\d/) or ($_ and $res[$_-1] =~ /\d/)) {die "Too many operands but no operators ($_ element)"}
		} 

		#Is binary operators correct?
		if ($res[$_] =~ m|^[-\+\*\^\/]$| and ($_ == $#res or $res[$_+1] !~ /\(|\d|U[-\+]/) and ($_ == 0 or $res[$_-1] =~ /\)|\d/)) {die "Binary operator has less then 2 operands (".($_+1)." element)"} 

	}

=======
	my @arr = split /(?<!e)([\+\-\*\/\^\(\)]|\s+)/i, $expr;
	my $pref_is_oper = 1;
	my $pref_is_pow = '';
	for (@arr) {
		unless ( /^\s+$/ or $_ eq '' ) {
			if ( $_ eq '+' and $pref_is_pow ) {
				push @res, "#+";
				$pref_is_oper = 1;
				$pref_is_pow = '';
			}
			elsif ( $_ eq '-' and $pref_is_pow ) {
				push @res, "#-";
				$pref_is_oper = 1;
				$pref_is_pow = '';
			}
			elsif ( $_ eq '+' and $pref_is_oper ) {
				push @res, "U+";
				$pref_is_oper = 1;
				$pref_is_pow = '';
			}
			elsif ( $_ eq '-' and $pref_is_oper ) {
				push @res, "U-";
				$pref_is_oper = 1;
				$pref_is_pow = '';
			}
			elsif ( /^\d*.?\d+e?[\+\-]?\d*$/i) {
				push @res, 0+$_;
				$pref_is_oper = '';
				$pref_is_pow = '';
			}
			elsif ( /^[\+\-\*\/\^]$/ and not $pref_is_oper ) {
				push @res, $_;
				$pref_is_oper = 1;
				if($_ eq '^') {
					$pref_is_pow = 1;
				}
				else {
					$pref_is_pow = '';
				}
			} elsif ( not $pref_is_oper and $_ eq ')' ) {
				push @res, $_;
				$pref_is_pow = '';
			} elsif ( $pref_is_oper and $_ eq '(' ) {
				push @res, $_;
				$pref_is_pow = '';
			} else {
				die "Неверное выражение: ".$_;
			}
		}
	}
>>>>>>> 51b034f8fbd0efbe38a264c96f0ff670077eb81c:homeworks/calculator/lib/tokenize.pl
	return \@res;
}

1;
