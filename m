Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2419C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B589D2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgH1IEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:04:11 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:39466 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727911AbgH1IEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:04:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C0F65100E7B43;
        Fri, 28 Aug 2020 08:03:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheep46_3417ebf27074
X-Filterd-Recvd-Size: 2491
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 08:03:56 +0000 (UTC)
Message-ID: <bb42e56210148307bd7eaaf3da1823ce04a9849b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in
 git
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Aug 2020 01:03:55 -0700
In-Reply-To: <234290e5-b8dc-22c7-d26f-60a02844ce0a@rasmusvillemoes.dk>
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
         <234290e5-b8dc-22c7-d26f-60a02844ce0a@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 14:23 +0200, Rasmus Villemoes wrote:
> On 25/08/2020 02.09, Joe Perches wrote:
> > If a file exists in git and checkpatch is used without the -f
> > flag for scanning a file, then checkpatch will scan the file
> > assuming it's a patch and emit:
> > 
> > ERROR: Does not appear to be a unified-diff format patch
> > 
> > Change the behavior to assume the -f flag if the file exists
> > in git.
> 
> Heh, I read the patch subject to mean you introduced a way for subsystem
> maintainers to prevent running checkpatch -f on their files, which I
> think some would like ;)
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 79fc357b18cd..cdee7cfadc11 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -976,6 +976,16 @@ sub seed_camelcase_includes {
> >  	}
> >  }
> >  
> > +sub git_is_single_file {
> > +	my ($filename) = @_;
> > +
> > +	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
> > +
> > +	my $output = `${git_command} ls-files -- $filename`;
> > +	my $count = $output =~ tr/\n//;
> > +	return $count eq 1 && $output =~ m{^${filename}$};
> > +}
> 
> Isn't that somewhat expensive to do for each file? Why not postpone that
> check till we're about to complain that the file is not a diff (haven't
> looked at how such a refactoring would look).

It's necessary because you need the --file option set _before_
analyzing the file content.

Oddly, I didn't receive this email directly so I couldn't reply
to it earlier.

