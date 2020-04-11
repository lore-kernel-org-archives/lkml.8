Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2883C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EB920709
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgDKKMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 06:12:43 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:47232 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbgDKKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 06:12:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 87517AF9E;
        Sat, 11 Apr 2020 10:12:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: anger88_8be99fb1f4239
X-Filterd-Recvd-Size: 5516
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 10:12:41 +0000 (UTC)
Message-ID: <6403ebf6b928d94268e00d52371c6aec912c3335.camel@perches.com>
Subject: Andy? checkpatch $stat question (was: Re: [PATCH] checkpatch: check
 for missing \n at the end of logging message)
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Sat, 11 Apr 2020 03:10:36 -0700
In-Reply-To: <215f2a43-6677-04cd-f376-bd7cd051b626@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
         <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
         <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
         <215f2a43-6677-04cd-f376-bd7cd051b626@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft:  checkpatch internals question for you below:

On Sat, 2020-04-11 at 08:48 +0200, Christophe JAILLET wrote:
> Le 10/04/2020 à 21:53, Joe Perches a écrit :
> > On Fri, 2020-04-10 at 12:46 -0700, Joe Perches wrote:
> > > On Fri, 2020-04-10 at 19:35 +0200, Christophe JAILLET wrote:
> > > > Le 08/04/2020 à 04:14, Joe Perches a écrit :
> > > > > This works rather better:
> > > > > Perhaps you could test?
> > > []
> > > > I'm looking at some modification done in the last month that could have
> > > > been spotted by the above script.
> > > > 
> > > >       ./scripts/checkpatch.pl -f drivers/usb/phy/phy-jz4770.c
> > > > 
> > > > correctly spots the 3 first cases, but the 3 last (line 202, 210 and
> > > > 217) are missed.
> > > > I don't understand why.
> > > It has to do with checkpatch's single statement parsing.
> > > 
> > > This case:
> > > 
> > > 	if (foo)
> > > 		dev_warn(...);
> > > 
> > > is parsed as a single statement but
> > > 
> > > 	if (foo) {
> > > 		dev_warn(...);
> > > 	};
> > > 
> > > is parsed as multiple statements so for the
> > > second case
> > > 
> > > 		dev_warn(...);
> > > 
> > > is analyzed as a separate statement.
> > > 
> > > The regex match for this missing newline test expects
> > > that each printk is a separate statement so the first
> > > case doesn't match.
> > > 
> > > Clearly the regex can be improved here.
> > So on top of the original patch:
> > ---
> >   scripts/checkpatch.pl | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index f00a6c8..54eaa7 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -5675,8 +5675,8 @@ sub process {
> >   
> >   # check for possible missing newlines at the end of common logging functions
> >   		if (defined($stat) &&
> > -		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> > -		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
> > +		    $stat =~ /^\+\s*(?:if\s*$balanced_parens\s*)?($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> > +		    $2 !~ /_cont$/ && $2 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
> >   			my $cnt = statement_rawlines($stat);
> >   			my $extracted_string = "";
> >   			for (my $i = 0; $i < $cnt; $i++) {
> 
> Hi Joe,
> 
> This fixes the use case for  drivers/usb/phy/phy-jz4770.c
> 
>      ./scripts/checkpatch.pl -f drivers/usb/gadget/udc/tegra-xudc.c
> 
> is missing line 691.

Turns out checkpatch also considers a close brace
followed by another statement block a single statement
so that test could be:

		    $stat =~ /^\+\s*\}?\s*(?:if\s*$balanced_parens\s*)?($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
		    $2 !~ /_cont$/ && $2 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {

But that seems odd and I wonder if Andy agrees
so I have a question for Andy about the use of
ctx_statement_block and its implementation.

It seems that $suppress_statement should be updated
when the cond return value does not start with { so
that code like

struct foo *
function(
	 int arg1,
	 long arg2,
	 struct bar *baz)
{
	[implementation...]
}

allows skipping the creation of a new $stat for each
line of the function arguments.  Instead there would
be just 2 $stat blocks created, one for the function
with its args and implementation, another for just
the implementation with braces.

Perhaps this is proper, but perhaps the $line_nr_next
return value should be updated in ctx_statement_block
instead.

Also a $stat that starts with a close brace is odd
and probably not good.

Thoughts?

---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 54eaa7..8ef95b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3558,7 +3558,10 @@ sub process {
 			($stat, $cond, $line_nr_next, $remain_next, $off_next) =
 				ctx_statement_block($linenr, $realcnt, 0);
 			$stat =~ s/\n./\n /g;
-			$cond =~ s/\n./\n /g;
+			my $condcnt = $cond =~ s/\n./\n /g;
+			if ($cond !~ /^.\s*\}/) {
+				$suppress_statement = $linenr + $condcnt;
+			}
 
 #print "linenr<$linenr> <$stat>\n";
 			# If this statement has no statement boundaries within

