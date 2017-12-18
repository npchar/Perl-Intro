#!/usr/bin/perl

#First there is two additionnal modules to load every times you are writing a perl script.
# It will help you understanding mistakes you wrote, and try to keep your code clear !
use strict ;
use warnings ;


# major difference between perl and python :
# ------------------------------------------
# Python phylosophy: "There should be one — and preferably only one — obvious way to do it."
# Perl phylosophy: "There’s more than one way to do it, but sometimes consistency is not a bad thing either."
# https://en.wikipedia.org/wiki/There%27s_more_than_one_way_to_do_it


# Perl is easy : there is only three different variables : "$", "@array", "%hash". 
# That's all ! You can combine it, play with it, using particular function or using "low level" programming.
#===========
# i) $string
#===========
# Perl can store, integer, float, character into $string
# theoritically, the size limit of a string is you RAM memmory.
# (with "use strict") we should intialize our variable with "my", it protect from new declaration later.
my $FileName = "Somefile-whatever" ;
# my $FileName = "20" ;
my $stupidAction = $FileName + 10 * 2;
my $ExtensionFileName = "superFile" ;
# There is many ways to concatenate string (http://www.perlmonks.org/?node_id=964608), depending the context I use :
my $NewFileName = $FileName . "." . $ExtensionFileName ;
$NewFileName = "${FileName}.${ExtensionFileName}" ;
# If you wondering if there is a difference between '," or `... yes there is ! http://www.perlmonks.org/?node_id=401006

# ======================================================
# ii) arrays are string with an index (begining by zero)
#=======================================================
# could be seen as a table with two colums: the index number and an associated $string
my @table = ( "unknown", 23, 0.2, 10e-24 ) ;
# we can access elements of the table by their index numbers (starting at 0)
$table[0]= 0 ;
# We can slice easily part of the table :
my @subTable = @table[1..3] ;

# Manipulation of perl array with function:
#------------------------------------------
# shift: remove and return the first element of the array (https://perldoc.perl.org/functions/shift.html)
# pop: remove and return the last element of the array (https://perldoc.perl.org/functions/pop.html)
# push: add an element at the end of the array (https://perldoc.perl.org/functions/push.html)
# unshift: add an element at the start of the array (https://perldoc.perl.org/functions/unshift.html)

# ======================================================
# iii) hashes 
#=======================================================
# You can see it as table (such as array) but instead of a numeric index, they used a $string as key and a $string as value.
# To say it differently, it works by pairs of keys/values : every  $string value of the %hash have a unique $string key

my %AwsomeHash = (
      'Jeannie Longo' => "Cyclist",
      'Rosalind Franklin' => "Chimist",
      'Sarah McNair-Landry' => "Explorer" ,
      'Cindy Lee Van Dover' => "Biologist") ;
#We forget Marie Curie..., we can add it just like this :
$AwsomeHash{'Marie Curie'} = "Chimist" ;

# =====================
# Read, write, print functions
# =====================
print "\nPrint Part :\n#===========\n" ;
print '$FileName is' ; 
print $FileName ;  # ("\n" means new lines)
print "\nAs you can see, perl will not add space or new line character... you should care !\n\n" ;
print "\"\$stupidAction = \$FileName + 10 * 2\" return: $stupidAction\n";
print "$FileName is working\n" ;
print "\"$FileName\" is working\n" ;

print "\nPrinting \@rray :\n#===============\n" ;
print '@subTable have ', $#subTable, " entries+1  !\n" ;
print @subTable, "\n" ;
my $subTableAsString = join( " ", @subTable) ;
print "$subTableAsString\n" ;

# if you want to read inside a file :
#------------------------------------
# One recomended way to open a file :
# Change the $FileName accordingly to the name of your file:
print "\nReading/printing :\n#================\n" ;
$FileName="data/AwsomePersons.tab" ;
open my $IN, "<$FileName" or die "Unable to open $FileName !\n" ;
# $IN is a reference to a sort of Filhandle object I guess, it's not a regular string and is not subject to "use strict" !
# For a visibility purpose I'm using the following syntax :
open IN, "<$FileName" or die "Unable to open $FileName !\n" ;

# We will read inside the file and print the content :
# print "Printing content of \"${Filename}\" : \n" ; 
my $lineCounter=0 ;
while(my $line = <IN>){ # Here, the $line is initialized every new line found in the IN file (default behavior)
	print $line ;
	$lineCounter++ ;
	
}
print "$FileName has $lineCounter lines.\n" ;
close IN ;

print "As you can see, we didn't add the \'\\n\' after printing lines. This is because file contains already this character at this end of each lines.\nThis is definitely something important you should remember ;)\n" ;

# if you want to write inside a file :
#------------------------------------
open OUT, ">${FileName}.lineCount" or die "Unable to open ${FileName}.lineCount !\n" ;
print OUT "$FileName has $lineCounter lines.\n" ;
close OUT ;
#That's it !

# ===========================
# Loop : for, foreach, while
# ===========================
print "\nLoop Part :\n#===========\n" ;
print "For loop: \n" ;
for (my $i=0; $i <= 9; $i++) {
       print "$i\n";
}
#the lazy way with foreach :
print "Lazy \"for loop\" with foreach: \n" ;
foreach my $i (0..9) {
       print "$i\n";
}

print "\nPrinting \%hash:\n#==============\n" ;
# print the content of our %AwsomeHash :
print "Content of the \%AwsomeHash \n" ;
foreach my $i (keys %AwsomeHash){
	print "The awsome $i is a $AwsomeHash{$i}\n" ; 
}
print "Content of the \%AwsomeHash, second times \n" ;
foreach my $i (keys %AwsomeHash){
	print "The awsome $i is a $AwsomeHash{$i}\n" ; 
}

print "\nThe order is random but consistent inside a run... if you re-run this script. There is no warranty that keys of \$AwsomeHash will be in the same order.\n" ;
print "Content of the \%AwsomeHash, third times (sorting) \n" ;
foreach my $i (sort keys %AwsomeHash){
	print "The awsome $i is a $AwsomeHash{$i}\n" ; 
}



# print "
# ==========================================
# Exercise : Crossing and Storing information
# ==========================================
# I would like to produce one resume sentence for every person listed in the AwsomePersons.tab or AwsomePersons-add.tab
# This resume sentence should contain the Name of the person, as well as his age if alive or since when this person his dead.
# I would also like to see his occupation.

# We have to types of file :
# A first one listing peoples and their occupation. (Because I am messy, there is an additionnal one, where you will find new persons. You will fix it !) # It's funnier like this !
# A second is providing information about Birth/Death date, ...

# " ;


