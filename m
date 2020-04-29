Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B784C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE0F206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTqjBVFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD2Dam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbgD2Dam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:30:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464D0C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:30:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g10so396745lfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TI7CerNdrp5A6O6fiQbGr7STfYhiESWfFVCA8vmVU0=;
        b=wTqjBVFa2uRyEmnvVl4u3zFHwlO3ljDd+Ngp1Nc8E9g2ZTKEkLULHqU7JTmLSZbok0
         AKpFmxRbN29ag2mFg+6DJ8/DWKcqgt2UWaX9+UUn9345IzE/Emvj9KqpY+BTN2gQVHMI
         wdQhxCHVzK8MjNgEz55RVRPAOjej81ee5PPRv/N51QYyohwPGx/HLkn0Vhmeo2MoBDj2
         jz+ljZcJa28H6iLIszjZKSkbuzJaJPxvk0uBKPe08e4Lkb0ihSdiFPttj/B4STFpWQgU
         WsFrICY4Cl9ptZdDclvWcrhJh9iQ/DQ5G60wI/FkkpFMfiQLnlVWtKDo/10nAj0USx5C
         4Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TI7CerNdrp5A6O6fiQbGr7STfYhiESWfFVCA8vmVU0=;
        b=WaPDmNAdasPItuRktpoFL6WDddcvAlD8/ekvKyLm5kxl8g+Likb8YcIeDpu9YC6APc
         Ada2M38AFcBVamYqLwFAz9NPzFHXhiZbnBMExq0itW1AW8i9Gf/Wt/rHp65bjXmltvT+
         KPXLU2NK+B0d6f5sGJQAioJk8idyQDiHHl5I5BTV4FxCUVotkyR8euLs847ChBplVIGD
         qwk5buq0GZdKAIbPt8geU7AtHifpZKpqbX32KdV3hMkLEHd5cZcQeSR80X90p1CmapSX
         pcOchjrWl35YFCbSBZ36FfRgqAFRjDgBfpOsRJ1v0qUkXMhHnWLYKF1Io0aJyy1MQVhm
         3CrA==
X-Gm-Message-State: AGi0PuZD5zABJoQBRWfANoXAcshncMHIp9CqAsaCUap2m8ICWNe2NC0Q
        Hn/A1YKnQjqdVD0X+Ez1i5YLAopWhKunSwN94phsBQ==
X-Google-Smtp-Source: APiQypIhu+D+NYyGc6aDVaCL3fwrGr6QHRs63cH7J5+S0wtewoZYpKa1DgGyMfdDUkXZCWbyAaELX35gTx3GXZa+Bh8=
X-Received: by 2002:a19:f719:: with SMTP id z25mr21987672lfe.63.1588131039305;
 Tue, 28 Apr 2020 20:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200429023104.131925-1-jannh@google.com> <20200429024648.GA23230@ZenIV.linux.org.uk>
In-Reply-To: <20200429024648.GA23230@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Apr 2020 05:30:12 +0200
Message-ID: <CAG48ez3UsadMEHac-muTMvCgLPNV=BnFjn2sNWm59iQ-hxF+rw@mail.gmail.com>
Subject: Re: [PATCH] epoll: Fix UAF dentry name access in wakeup source setup
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        NeilBrown <neilb@suse.de>, "Rafael J . Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 4:46 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Apr 29, 2020 at 04:31:04AM +0200, Jann Horn wrote:
> > I'm guessing this will go through akpm's tree?
> >
> >  fs/eventpoll.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 8c596641a72b0..5052a41670479 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1450,7 +1450,7 @@ static int reverse_path_check(void)
> >
> >  static int ep_create_wakeup_source(struct epitem *epi)
> >  {
> > -     const char *name;
> > +     struct name_snapshot name;
> >       struct wakeup_source *ws;
> >
> >       if (!epi->ep->ws) {
> > @@ -1459,8 +1459,9 @@ static int ep_create_wakeup_source(struct epitem *epi)
> >                       return -ENOMEM;
> >       }
> >
> > -     name = epi->ffd.file->f_path.dentry->d_name.name;
> > -     ws = wakeup_source_register(NULL, name);
> > +     take_dentry_name_snapshot(&name, epi->ffd.file->f_path.dentry);
> > +     ws = wakeup_source_register(NULL, name.name.name);
> > +     release_dentry_name_snapshot(&name);
>
> I'm not sure I like it.  Sure, it won't get freed under you that way; it still
> can go absolutely stale by the time you return from wakeup_source_register().
> What is it being used for?

The one user I'm aware of is Android; they use EPOLLWAKEUP in the
following places:

https://cs.android.com/search?q=EPOLLWAKEUP%20-file:strace%20-file:uapi%2F%20-file:syscall%2Fzerrors%20-file:sys%2Funix%2Fzerrors%20-file:prebuilts%2F%20-file:mod.rs%20-file:libcap-ng%2F%20-file:tests%2F&sq=

I see timerfds, /dev/input/event*, some other stuff with input devices
and video devices, binder, netlink socket, and some other stuff like
that - nothing that's actually likely to be renamed.


Searching on cs.android.com for places that parse this stuff, there
seems to be some code that uploads it as part of bug reports or
something (?), and some parser whose precise purpose I can't figure
out right now:
<https://cs.android.com/android/platform/superproject/+/master:frameworks/base/core/java/com/android/internal/os/KernelWakelockReader.java;l=210?q=%2Fwakeup_sources%20-file:sepolicy%20&ss=android>

(Arve might know what this is actually good for.)


Anyway, I don't think that name is actually particularly critical to
the correct functioning of the system; and the bug is a memory
corruption issue, so we should fix it somehow. And adding
infrastructure to power management so that it can invoke a callback to
figure out the (potentially, under rare circumstances, changing) name
of a wakeup source seems like a bit of overkill to me.
