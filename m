Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6183C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922FA206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgEEUyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:54:47 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:40852 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEUyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:54:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 66E1910054F00;
        Tue,  5 May 2020 20:54:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: play38_c63f55c33806
X-Filterd-Recvd-Size: 3100
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 May 2020 20:54:45 +0000 (UTC)
Message-ID: <5b68825bf74fb0df287d2c4df239dc08f8577cba.camel@perches.com>
Subject: Re: [kernel.org users] [PATCH v2] checkpatch: use patch subject
 when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, users@linux.kernel.org
Date:   Tue, 05 May 2020 13:54:43 -0700
In-Reply-To: <20200505204015.44ibvg4bapnalrct@pali>
References: <20200505132613.17452-1-geert+renesas@glider.be>
         <1b0b4e6562cbbf4621e71042e511ae3cd0b542f6.camel@perches.com>
         <20200505204015.44ibvg4bapnalrct@pali>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 22:40 +0200, Pali Rohár wrote:
> Hello!
> 
> On Tuesday 05 May 2020 12:57:37 Joe Perches wrote:
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index eac40f0abd56a9f4..3355358697d9e790 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -1057,6 +1057,10 @@ for my $filename (@ARGV) {
> > >  	}
> > >  	while (<$FILE>) {
> > >  		chomp;
> > > +		if ($vname eq 'Your patch') {
> > > +			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > > +			$vname = '"' . $subject . '"' if $subject;
> > > +		}
> > >  		push(@rawlines, $_);
> > >  	}
> > >  	close($FILE);
> > 
> > There's a less cpu intensive way to do this,
> > for small patches, on my little laptop it's a
> > few dozen milliseconds faster, and for very
> > large patches multiple seconds faster to use
> > the following patch:
> > 
> > Substitute Geert's patch with the below but:
> > 
> > Acked-by: Joe Perches <joe@perches.com>
> > 
> > ---
> > 
> >  scripts/checkpatch.pl | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index f0092104ff7b..29786a097862 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1062,6 +1062,7 @@ for my $filename (@ARGV) {
> >  	while (<$FILE>) {
> >  		chomp;
> >  		push(@rawlines, $_);
> > +		$vname = "\"$1\"" if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/);
> 
> Hint: You can use qq operator to make code more readable (no need to
> escape quote character). And maybe you should match Subject as
> case-insensitive and expects at least one space after colon.
> As a Perl developer I would write above code as:
> 
> +		$vname = qq("$1") if $filename eq '-' && $_ =~ m/^Subject:\s+(.+)/i;
> 
> Anyway, what would happen if subject line contains quotes?

Hi Pali.

bad things... ;) so your suggestion is better.

But/And checkpatch uses parens for if statements.

cheers and thanks, Joe

