Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E396F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="CVuzlkRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgF3Vht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgF3Vhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:37:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:30:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so20171906qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5EMuGF306H+8MVBaWM0r+rGzFzFrlYDXGMThC9HfD4=;
        b=CVuzlkRbGxcrGQk88QUs7Tk5iS78bBLcpFuKyvp3XajOVHCPbZdyPTp86/unda5k5j
         dzghI3xEj/ExjNk4Ne2mTEsY63nRHrFuQfaIcZrV+6MflMDNZBcbhLZmAI/WwWlNCjsz
         2M87hwgFPODrfWf196lE2NAcze08Hd/lyoeNAwDHnPJW0inSlI6ufZDuFeQV6L0HTBTT
         i6Vgax5ZiWEscxUdrX9hLY5wOPxD1CGs7ImMfiecSMcE+KMVdvxTcP/NZe7poOhqK7XM
         dGTKgpf2cIL38jvWVIfLUAz2UhW/Ee9VExtEnkl31piwwc1/OtbcFu+1IJZ2wsbFi9Oa
         NxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5EMuGF306H+8MVBaWM0r+rGzFzFrlYDXGMThC9HfD4=;
        b=IFRxFWX2sLoFgy6xmLP6zPx85olsJHa1ka+5Fr3ZS4PqDqrA3SeuCFr48ZS0UZhnVy
         RU0NjfpCwMME3ZF6LTDK4c1zhGJZEg3ICP2WEiNCbsMCSSq5h8UDTbYNTEjorOigOw4d
         WDoYDGYeePfm4BN26aAFoPHIMaWMW3XVlHF4fBCF2mXhYkSupzwXNvk0rAvsMrY+sv0J
         nYRharjLv6ZwuZOOf9tP4tSGr0vpKcnYAxfeLEMqHRJ1DX+O64RWTefdwoxZjaf5T+oG
         DPohXTmnzyxVqDgOP9sFJtvHBUAtLIF30JThsqWyQ+bPWAbLkP2P3pj5XP9Qvdmji+Kb
         6xlg==
X-Gm-Message-State: AOAM532GQ65KZHVY3op1q9ZQvZf2tzal3RsT9dMt+ejbCo5nos+9qWHZ
        87FAqtE6YEMZcIf+yrguRcXN+yxqH5LXYP3ND1VZtw==
X-Google-Smtp-Source: ABdhPJwWO1R9i1wl8MgcDzCK99YlU9Z+CbqF2VkRE+FU0jHeiGGtc1krNP9QFqj9mxYwxQ/bQKqY86nI0ZiWwDimUnA=
X-Received: by 2002:ae9:ed86:: with SMTP id c128mr22482794qkg.475.1593552620158;
 Tue, 30 Jun 2020 14:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200630143525.13869-1-quentin@isovalent.com> <39ba164ba44be848feac831f2f21effca92bfc96.camel@perches.com>
 <CAC3GErHpyyA8eQUyP6s_H6csvbKfHXHi50Ky6A1PhU+A6waCeQ@mail.gmail.com>
In-Reply-To: <CAC3GErHpyyA8eQUyP6s_H6csvbKfHXHi50Ky6A1PhU+A6waCeQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 30 Jun 2020 22:30:09 +0100
Message-ID: <CACdoK4Kqx3e5om=OH2D4QWSSHp-y0AOakiPjDG-ViqHz27d_=w@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: prevent reporting C99_COMMENTS error for SPDX
 tag in .c file
To:     Vadim Bendebury <vbendeb@chromium.org>,
        Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 at 18:20, Vadim Bendebury <vbendeb@chromium.org> wrote:
>
> On Tue, Jun 30, 2020 at 7:47 AM Joe Perches <joe@perches.com> wrote:
> >
> > (adding Vadem Bendebury who added the tolerance test)
> >
> > On Tue, 2020-06-30 at 15:35 +0100, Quentin Monnet wrote:
> > > When checkpatch.pl is invoked with "--ignore C99_COMMENT_TOLERANCE", it
> > > reports C99-style comments found in the code, by matching on the
> > > double-slash pattern "//". This includes the leading slashes before the
> > > SPDX tags that are now used in a majority of C files.
> > >
> > > Such tags are commented with the double-slash on purpose, and should not
> > > trigger errors from checkpatch. Let's ignore them when searching for
> > > C99-style comments to report.
> > >
> > > Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> >
> > I think this unnecessary as perhaps those that want no
> > c99 comments likely _really_ want no c99 comments.
> >
> > > ---
> > >  scripts/checkpatch.pl | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 3cacc122c528..67f350c580ea 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3983,7 +3983,10 @@ sub process {
> > >               }
> > >
> > >  # no C99 // comments
> > > -             if ($line =~ m{//}) {
> > > +             if ($line =~ m{//} &&
> > > +                 !($rawline =~ m{// SPDX-License-Identifier:} &&
> > > +                   $realfile =~ /\.c$/ &&
> Do I understand this right that with this change in the check would be
> applied to .c files only? .h files should be included.

The idea is to exclude (from the search for C99-style comments) the
SPDX tags at the top of source code files. The convention in kernel
code is that .c files use C99 comments for those tags, but .h files do
not and use "/* */" comments instead (details and motivation in
Documentation/process/license-rules.rst). So having "//" at the top of
a .h file is not conventional and should always be reported; whereas
the idea for the current patch was to ignore it for .c files.

All "//" comments not identified as an SPDX tag would still be
reported by checkpatch, whether in a .c or in a .h file.

> > > +                   $realline == $checklicenseline)) {
> What is the purpose of the above check?

This is for the "at the top" part. Because the SPDX tag is expected to
be at the top of the file (Unless I am mistaken, $checklicenseline
typically equals 1 for .c files). So with the patch, we consider a "//
SPDX-License-Identifier:" string at the top of the .c file as a SPDX
tag (and do not report a C99_COMMENTS error), but not if it is in the
middle of a file.

[...]

Thank you Joe and Vadim for your feedback. My intent is to use
checkpatch on a third-party repository where we mostly follow kernel
style (including for SPDX tags) and do not desire "//" comments. I
found it strange to have this option to report C99_COMMENTS errors
that would raise a high number of false positives on the kernel
repository (or for the repo I work with), hence the patch.

But if the feeling is that there is too little value in the change, or
if it goes against the intent of the reports for C99-style comments,
there's not much to do but to drop the patch. I can't imagine adding
new command line options for such a corner case.

Regards,
Quentin
