Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9A3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E764204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgFWQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:48:27 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:57326 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732640AbgFWQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:48:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8432B56F39;
        Tue, 23 Jun 2020 16:48:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing87_140dc2a26e3d
X-Filterd-Recvd-Size: 4319
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 16:48:20 +0000 (UTC)
Message-ID: <895052df95b2fc85b07e5a493fbb1ff415d8f62c.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: fix CONST_STRUCT when
 const_structs.checkpatch is missing
From:   Joe Perches <joe@perches.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 23 Jun 2020 09:48:19 -0700
In-Reply-To: <20200623103740.25876-1-quentin@isovalent.com>
References: <20200623103740.25876-1-quentin@isovalent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Tue, 2020-06-23 at 11:37 +0100, Quentin Monnet wrote:
> Checkpatch reports warnings when some specific structs are not declared
> as const in the code. The list of structs to consider was initially
> defined in the checkpatch.pl script itself, but it was later moved to an
> external file (scripts/const_structs.checkpatch), in commit bf1fa1dae68e
> ("checkpatch: externalize the structs that should be const"). This
> introduced two minor issues:
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -770,7 +770,7 @@ sub read_words {
>  				next;
>  			}
>  
> -			$$wordsRef .= '|' if ($$wordsRef ne "");
> +			$$wordsRef .= '|' if (defined($$wordsRef) && $$wordsRef ne "");

perl is a weird language and the $$wordsRef ne "" test
isn't required as the append will work even if the
thing being appended to isn't defined.

You can read the perlsyn docs
http://perldoc.perl.org/perlsyn.html
or
https://stackoverflow.com/questions/2166575/when-is-it-ok-to-use-an-undefined-variable-in-perl-with-warnings-enabled

so perhaps remove the test and improve the additional
$typedefsfile use too
---
 scripts/checkpatch.pl | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b06093777fd8..9210267a7771 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,7 +62,7 @@ my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
-my $typedefsfile = "";
+my $typedefsfile;
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
@@ -770,7 +770,7 @@ sub read_words {
 				next;
 			}
 
-			$$wordsRef .= '|' if ($$wordsRef ne "");
+			$$wordsRef .= '|' if (defined($$wordsRef));
 			$$wordsRef .= $line;
 		}
 		close($file);
@@ -780,16 +780,18 @@ sub read_words {
 	return 0;
 }
 
-my $const_structs = "";
-read_words(\$const_structs, $conststructsfile)
-    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
+my $const_structs;
+if (show_type("CONST_STRUCT")) {
+	read_words(\$const_structs, $conststructsfile)
+	    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
 
-my $typeOtherTypedefs = "";
-if (length($typedefsfile)) {
+
+if (defined($typedefsfile)) {
+	my $typeOtherTypedefs;
 	read_words(\$typeOtherTypedefs, $typedefsfile)
 	    or warn "No additional types will be considered - file '$typedefsfile': $!\n";
+	$typeTypedefs .= '|' . $typeOtherTypedefs if (defined $typeOtherTypedefs);
 }
-$typeTypedefs .= '|' . $typeOtherTypedefs if ($typeOtherTypedefs ne "");
 
 sub build_types {
 	my $mods = "(?x:  \n" . join("|\n  ", (@modifierList, @modifierListFile)) . "\n)";
@@ -6660,7 +6662,8 @@ sub process {
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
 # and avoid what seem like struct definitions 'struct foo {'
-		if ($line !~ /\bconst\b/ &&
+		if (defined($const_structs) &&
+		    $line !~ /\bconst\b/ &&
 		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
 			WARN("CONST_STRUCT",
 			     "struct $1 should normally be const\n" . $herecurr);


