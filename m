Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 01:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B95B2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 01:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFEBCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 21:02:09 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:44340 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgFEBCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 21:02:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0364C181D337B;
        Fri,  5 Jun 2020 01:02:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stove24_4914aaf26d9b
X-Filterd-Recvd-Size: 5730
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jun 2020 01:02:06 +0000 (UTC)
Message-ID: <d111107687395f9a98ae8f074b599fee1be14f99.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 04 Jun 2020 18:02:05 -0700
In-Reply-To: <202006041503.C9BFD40255@keescook>
References: <202006031618.DA25142@keescook>
         <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
         <202006041503.C9BFD40255@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-04 at 15:08 -0700, Kees Cook wrote:
> On Wed, Jun 03, 2020 at 05:39:47PM -0700, Joe Perches wrote:
> > On Wed, 2020-06-03 at 16:19 -0700, Kees Cook wrote:
> > > My codespell dictionary has a lot of capitalized words. For example:
> > > 
> > > MSDOS->MS-DOS
> > > 
> > > Since checkpatch uses case-insensitive matching, I get an undefined
> > > variable warning and then empty suggestions for things like this:
> > > 
> > > Use of uninitialized value $typo_fix in concatenation (.) or string at ./scripts/checkpatch.pl line 2958.
> > > 
> > > WARNING: 'msdos' may be misspelled - perhaps ''?
> > > +       struct msdos_dir_entry *de;
> > > 
> > > This fixes the matcher to avoid the warning, but it's still a rather
> > > silly suggestion:
> > > 
> > > WARNING: 'msdos' may be misspelled - perhaps 'MS-DOS'?
> > > +       struct msdos_dir_entry *de;
> > > 
> > > So I'm not really sure what to do with this ... filter out bad
> > > suggestions instead?
> > 
> > Hey Kees.
> > 
> > Maybe this?
> > 
> > btw: My codespell dictionary file moved to
> > /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt
> 
> Yeah, mine too. I think I may have added a symlink to my filesystem to
> work around this.
> 
> > and I had to use --codespell --codespellfile=(above) so
> > maybe there should be multiple lookups for this file
> > like the array below.
> 
> That seems like a good idea.
> 
> > Are there other standard codespell dictionary locations?
> > ---
> >  scripts/checkpatch.pl | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 5f00df2c3f59..52aa0dd53d80 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -59,7 +59,7 @@ my $minimum_perl_version = 5.10.0;
> >  my $min_conf_desc_length = 4;
> >  my $spelling_file = "$D/spelling.txt";
> >  my $codespell = 0;
> > -my $codespellfile = "/usr/share/codespell/dictionary.txt";
> > +my $codespellfile;
> >  my $conststructsfile = "$D/const_structs.checkpatch";
> >  my $typedefsfile = "";
> >  my $color = "auto";
> > @@ -716,7 +716,20 @@ if (open(my $spelling, '<', $spelling_file)) {
> >  }
> >  
> >  if ($codespell) {
> > -	if (open(my $spelling, '<', $codespellfile)) {
> > +	if (!defined($codespellfile)) {
> > +		my @csfiles = ("/usr/share/codespell/dictionary.txt",
> > +			       "/usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt");
> > +		foreach my $csfile (@csfiles) {
> > +			if (-f $csfile) {
> > +				$codespellfile = $csfile;
> > +				last;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (!defined($codespellfile)) {
> > +		warn "No codespell typos will be found - codespell dictionary not found\n";
> > +	} elsif (open(my $spelling, '<', $codespellfile)) {
> >  		while (<$spelling>) {
> >  			my $line = $_;
> >  
> > @@ -2963,13 +2976,21 @@ sub process {
> >  			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> >  				my $typo = $1;
> >  				my $typo_fix = $spelling_fix{lc($typo)};
> > -				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
> > -				$typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
> > +				$typo_fix = $spelling_fix{$typo} if (!defined($typo_fix));
> > +				$typo_fix = $spelling_fix{uc($typo)} if (!defined($typo_fix));
> 
> This won't catch stuff like:
> 
> Cambrige->Cambridge

Huh?  Did you test this?

$ git diff scripts/spelling.txt
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index d9cd24cf0d40..43c3332935fe 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -251,6 +251,7 @@ callibration||calibration
 callled||called
 calucate||calculate
 calulate||calculate
+Cambridg||Cambridge
 cancelation||cancellation
 cancle||cancel
 capabilites||capabilities

$ cat test_spell.c 
// SPDX-License-Identifier: GPL-2.0-only

/* This is a test.
 * Cambridg
 */

$ ./scripts/checkpatch.pl --strict -f test_spell.c 
CHECK: 'Cambridg' may be misspelled - perhaps 'Cambridge'?
#4: FILE: test_spell.c:4:
+ * Cambridg

total: 0 errors, 0 warnings, 1 checks, 5 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

test_spell.c has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

> because neither "cambrige" nor "CAMBRIGE" is in %spelling_fix. And the
> original text is lost due to the //i. :( I'm really not sure what to do
> with these things in codespell. Lower case everything? Throw away
> anything not all lower case?


