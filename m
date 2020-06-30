Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3792074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NF/vD/8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgF3W1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3W07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:26:59 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:26:59 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s20so4819271vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbGXuOfSs3SrhfGmixjAA7HW6MvnNruHqNQ7aQ/L0IE=;
        b=NF/vD/8AXpdGaDqEJYQA3NKa9GL5IsMBqMyfRB9D+WMKuxgRmn5tfrM2qqo/ZN7zBf
         ZZU1EXKKxYBK7xmyoQ+GMYkqjPozbBqcpEUlMRGUKTozz8QR6TV67RDLOO6JI8aBreYD
         c7SE9+nMjTA5IRz9HLMiPwMad5289iVRbMfLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbGXuOfSs3SrhfGmixjAA7HW6MvnNruHqNQ7aQ/L0IE=;
        b=nlAVGW/6+M8kz6rfNRE7T7J+LAvWnG6FMauuORCKu0C1kFNQt5XZGCILwF5ly5OZrY
         3WxiPM99g/fvTusVpyaoIOe88cQoo5Yae8o5kuikeQSET1m6Uef95cXT7CVJTZiVKJOe
         HsW/mjWC6nQ+3hCuk3BfOn8TaM30zV+lD0No0Amwt3u008+hWjKiiKjetvtnjF6tLoOD
         lc+08Q/Y+4r9yXRNNp5vWpBXek+S3uJDGHEKALpEhPEd/Z92kRvpPlI3LiTP1u4rFl3i
         dxfae6dri2NX1ZR9mcckP7mIjh0R+aKRbzdRcGQl1fY+mW6V40Eq4+JKtqpElJ+q8SEn
         vm7g==
X-Gm-Message-State: AOAM5322K5U8Ig+waHb/IcL5elkO5kxi217OIj8Gx0bWl9xWN9fsc39e
        2fE4W0nPxZTYj9MUPmR8CzsdZAtV2ss=
X-Google-Smtp-Source: ABdhPJxFbUp8NOIoZ0qB+5vJpFAJxCHGqhOUs+/mEI1sQ7jgZVgpdFYfujLtBQPJHhWmTQS1adusEQ==
X-Received: by 2002:a67:f8c6:: with SMTP id c6mr5995419vsp.184.1593556018098;
        Tue, 30 Jun 2020 15:26:58 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id h18sm525242vsg.16.2020.06.30.15.26.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 15:26:57 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id q69so4962436vkq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:26:57 -0700 (PDT)
X-Received: by 2002:a1f:974d:: with SMTP id z74mr15548435vkd.40.1593556016828;
 Tue, 30 Jun 2020 15:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200629171529.558003-1-daniel.thompson@linaro.org>
 <CAD=FV=W9rdEsO1jP-kg6OetXmZO+kC9LenZM=CdxjUvv8BEU4g@mail.gmail.com> <20200630150527.odqvmzmsddzty4zx@holly.lan>
In-Reply-To: <20200630150527.odqvmzmsddzty4zx@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Jun 2020 15:26:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UvBEW_XhsbgdSRYqPLywFDQg=nh0bX=UMtERBoxW9hmg@mail.gmail.com>
Message-ID: <CAD=FV=UvBEW_XhsbgdSRYqPLywFDQg=nh0bX=UMtERBoxW9hmg@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Resolve races during kgdb_io_register/unregister_module
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 30, 2020 at 8:05 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 29, 2020 at 02:03:52PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jun 29, 2020 at 10:15 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > Currently kgdb_register_callbacks() and kgdb_unregister_callbacks()
> > > are called outside the scope of the kgdb_registration_lock. This
> > > allows them to race with each other. This could do all sorts of crazy
> > > things up to and including dbg_io_ops becoming NULL partway through the
> > > execution of the kgdb trap handler (which isn't allowed and would be
> > > fatal).
> > >
> > > Fix this by bringing the trap handler setup and teardown into the scope
> > > of the registration lock.
> > >
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > ---
> > >  kernel/debug/debug_core.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > > index 9e5934780f41..9799f2c6dc94 100644
> > > --- a/kernel/debug/debug_core.c
> > > +++ b/kernel/debug/debug_core.c
> > > @@ -1117,9 +1117,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
> > >
> > >         dbg_io_ops = new_dbg_io_ops;
> > >
> > > -       spin_unlock(&kgdb_registration_lock);
> > > -
> > >         if (old_dbg_io_ops) {
> > > +               spin_unlock(&kgdb_registration_lock);
> > >                 old_dbg_io_ops->deinit();
> > >                 return 0;
> > >         }
> > > @@ -1129,6 +1128,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
> > >         /* Arm KGDB now. */
> > >         kgdb_register_callbacks();
> > >
> > > +       spin_unlock(&kgdb_registration_lock);
> >
> > From looking at code paths, I think this is illegal, isn't it?  You're
> > now calling kgdb_register_callbacks() while holding a spinlock, but:
> >
> > kgdb_register_callbacks()
> > -> register_console()
> > --> console_lock()
> > ---> might_sleep()
> > ----> <boom!>
>
> Thanks.
>
> I very nearly didn't press "Send" yesterday because I was worried I was
> rushing it too much (in order to avoid forgetting it ;-) ). Should have
> listened to myself!
>
>
> > I'm a little curious about the exact race we're trying to solve.
> > Calling unregister on an IO module before register even finished seems
> > like an error on the caller, so I guess it would be calling register
> > from a 2nd thread for a different IO module while the first thread was
> > partway through unregistering?  Even that seems awfully sketchy since
> > you're risking registering a 2nd IO ops while the first is still there
> > and that's illegal enough that we do a pr_err() for it (though we
> > don't crash), but let's say we're trying to solve that one.
>
> I didn't follow all the possible paths. Utlimately the
> (un)register_callbacks() functions use a flag variable without a lock
> and that can interact in lots of different ways.
>
> To be honest none are especially likely because the normal case is to
> register once during boot and never unregister. However we can trigger
> register/unregister from userspace so I think they can happen
> in parallel.

This is for kgdboc or one of the other IO modules?  I do know that, at
least for kgdboc, we have the "config_mutex".  I won't promise that
there are no bugs there but in the very least it should mostly prevent
a host of these types of issues.  ...so I guess you'd have to in
parallel be spamming a register of a non kgdboc IO module together
with an unregister of kgdboc?


> Double unregister can lead to some especially nasty schedules...
> although they still remain pretty unlikely since we need the double
> unregister to coincide with a breakpoint:
>
>
> kgdb_unregister_callbacks()     kgdb_unregister_callbacks()
>   .                             .
>   test flag                     .
>   set flag to 0                 .
>   .                             test flag
>   .                             spin_lock()
> *** kgdb trap ***                 .
>   . paranoid dbg_io_ops check     .
>   .                             dbg_io_ops = NULL
>   . stop other CPUs
>   . try to use NULL dbg_io_ops
>
>
> I have drawn the kgdb trap in the first column because otherwise things
> get too wide but the trap could trigger on any CPU in the system and
> provoke the problem.
>
>
> >
> > Looking at it closely, I _think_ the only race in this case is if the
> > one we're trying to unregister had a deinit() function and we going to
> > replace it?  If it didn't have a deinit function:
> >
> > cpu1 (unregister)                 cpu2 (register):
> > -----------------                 ----------------------
> > kgdb_unregister_callbacks()
> >                                   spin_lock() <got>
> > spin_lock() <blocked>
> >                                   if (old_dbg_io_ops) <true>
> >                                     if (has dinit) <false>
> >                                       print error
> >                                       spin_unlock()
> >                                       return -EBUSY
> > <finish unregister>
> >
> > The above is fine and is the same thing that would happen if the
> > whole register function ran before the unregister even started, right?
> >
> > Also: if the unregister won the race that should also be fine.
> >
> > So really the problem is this:
> >
> > cpu1 (unregister)                 cpu2 (register):
> > -----------------                 ----------------------
> > kgdb_unregister_callbacks()
> >                                   spin_lock() <got>
> > spin_lock() <blocked>
> >                                   if (old_dbg_io_ops) <true>
> >                                     if (has dinit) <true>
> >                                       print Replacing
> >                                   init new IO ops
> >                                   spin_unlock()
> >                                   if (old_dbg_io_ops) <true>
> >                                     finish deinit of old
> >                                     return true
> > WARN_ON() <hits and shouts!>
> > dbg_io_ops = NULL
> > spin_unlock()
> > if (deinit) <true>
> >   double-call to deinit of old
> >
> > So in this case we'll hit a WARN_ON(), incorrectly unregister the new
> > IO ops, and call deinit twice.
>
> To be honest I was simply working on "it is racy" and "there's not a
> good reason to allow that", especially as we start to develop tools to
> bring races to the surfaces someone will yell at us about it sooner or
> later ;-).
>
> Of course, implementing it correctly would have been better...

Yeah, still wouldn't hurt to try to figure out how to make it cleaner.  :-)

-Doug
