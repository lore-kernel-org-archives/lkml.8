Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC84C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA7D20720
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLZ0c6sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgF3PFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgF3PFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:05:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF572C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:05:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so20567261wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poYoL3/cPKc6YhvMgtbNki5IwtSkTfG/5fz26J/b5EY=;
        b=QLZ0c6sYgoLXlJU/0+4TBPm+a52qjmwCWNqqBEQ7vybjlPlDjSvgYOYbAJRNF6yO4s
         hbacKvijQkCv4ZXUnBbmr3302V+UxFcstJot+CeLbAlFkVUZ5pP7O4zCh5yGjVC3hXIf
         8qkr7bRobTSPbFfwF2UUZgX97oFRINcsO1E/VPdW5isXuJ2I0d2ce1sDovbRoWE2tla9
         uJbPsCscMzT24iubhrW0p8g4t1T1Iwc3Iv6G8dNe+STQ+tqMi33AFYBBOUp00sRRbA1U
         a3rE4sH3yxy4r4FVEjIIDZ4aTquh7eMCiYSsbHeD/T65n0fCH9WW4DNuVWFpCTiQSNd+
         AEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poYoL3/cPKc6YhvMgtbNki5IwtSkTfG/5fz26J/b5EY=;
        b=bl4bH1zuiXqkdvHTONknHxm/yKh1+BQ/tCksAYExi1NyLMdaPIHt8pzWRm4QpZJzCg
         0f2U93aiptBL3jv33TpSqWctZ1UYbYqXZaYB4Rdulg47+PVdhsluAiQGUgCicsKw98eo
         KykP9fJH2Q2EneedS24FPuE+xeraCQzgILSWIjXg0Fsu1uvWEObd7MYJZPsSquICXHWF
         mei1zVSsewpauUziviYJ4PvA05MQkihXRMNUMV1aVZVZi62pLUb3txybNi+4p5bkboh6
         EomE6R2OnY4hkFT8/kCat51XvkaHy41D5Z0ZrHKel+BpB4mxAjcLL8UgacschxO25a7V
         baGA==
X-Gm-Message-State: AOAM5330p0s+lMl21KK9ooYWhKGzXFRcpYnw/XJOyTu2ede4JyGZEi06
        f6A2xYbFxpihVcAyFXqljB9NrA==
X-Google-Smtp-Source: ABdhPJxqMeRRkCyDXXkEXcH0waLw/3C6DKn+MmgX9gTvC0ivxHY7K1TyZL8YHtUW7murrlapa65Utw==
X-Received: by 2002:adf:8067:: with SMTP id 94mr21259012wrk.427.1593529530221;
        Tue, 30 Jun 2020 08:05:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v66sm4045169wme.13.2020.06.30.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:05:29 -0700 (PDT)
Date:   Tue, 30 Jun 2020 16:05:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH] kgdb: Resolve races during
 kgdb_io_register/unregister_module
Message-ID: <20200630150527.odqvmzmsddzty4zx@holly.lan>
References: <20200629171529.558003-1-daniel.thompson@linaro.org>
 <CAD=FV=W9rdEsO1jP-kg6OetXmZO+kC9LenZM=CdxjUvv8BEU4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=W9rdEsO1jP-kg6OetXmZO+kC9LenZM=CdxjUvv8BEU4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:03:52PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 29, 2020 at 10:15 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently kgdb_register_callbacks() and kgdb_unregister_callbacks()
> > are called outside the scope of the kgdb_registration_lock. This
> > allows them to race with each other. This could do all sorts of crazy
> > things up to and including dbg_io_ops becoming NULL partway through the
> > execution of the kgdb trap handler (which isn't allowed and would be
> > fatal).
> >
> > Fix this by bringing the trap handler setup and teardown into the scope
> > of the registration lock.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/debug_core.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 9e5934780f41..9799f2c6dc94 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -1117,9 +1117,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
> >
> >         dbg_io_ops = new_dbg_io_ops;
> >
> > -       spin_unlock(&kgdb_registration_lock);
> > -
> >         if (old_dbg_io_ops) {
> > +               spin_unlock(&kgdb_registration_lock);
> >                 old_dbg_io_ops->deinit();
> >                 return 0;
> >         }
> > @@ -1129,6 +1128,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
> >         /* Arm KGDB now. */
> >         kgdb_register_callbacks();
> >
> > +       spin_unlock(&kgdb_registration_lock);
> 
> From looking at code paths, I think this is illegal, isn't it?  You're
> now calling kgdb_register_callbacks() while holding a spinlock, but:
> 
> kgdb_register_callbacks()
> -> register_console()
> --> console_lock()
> ---> might_sleep()
> ----> <boom!>

Thanks.

I very nearly didn't press "Send" yesterday because I was worried I was
rushing it too much (in order to avoid forgetting it ;-) ). Should have
listened to myself!


> I'm a little curious about the exact race we're trying to solve.
> Calling unregister on an IO module before register even finished seems
> like an error on the caller, so I guess it would be calling register
> from a 2nd thread for a different IO module while the first thread was
> partway through unregistering?  Even that seems awfully sketchy since
> you're risking registering a 2nd IO ops while the first is still there
> and that's illegal enough that we do a pr_err() for it (though we
> don't crash), but let's say we're trying to solve that one.

I didn't follow all the possible paths. Utlimately the
(un)register_callbacks() functions use a flag variable without a lock
and that can interact in lots of different ways.

To be honest none are especially likely because the normal case is to
register once during boot and never unregister. However we can trigger
register/unregister from userspace so I think they can happen
in parallel.

Double unregister can lead to some especially nasty schedules...
although they still remain pretty unlikely since we need the double
unregister to coincide with a breakpoint:


kgdb_unregister_callbacks()	kgdb_unregister_callbacks()
  .				.	
  test flag			.
  set flag to 0			.
  .				test flag
  .				spin_lock()
*** kgdb trap ***		  .
  . paranoid dbg_io_ops check     .
  .				dbg_io_ops = NULL
  . stop other CPUs
  . try to use NULL dbg_io_ops


I have drawn the kgdb trap in the first column because otherwise things
get too wide but the trap could trigger on any CPU in the system and
provoke the problem.


> 
> Looking at it closely, I _think_ the only race in this case is if the
> one we're trying to unregister had a deinit() function and we going to
> replace it?  If it didn't have a deinit function:
> 
> cpu1 (unregister)                 cpu2 (register):
> -----------------                 ----------------------
> kgdb_unregister_callbacks()
>                                   spin_lock() <got>
> spin_lock() <blocked>
>                                   if (old_dbg_io_ops) <true>
>                                     if (has dinit) <false>
>                                       print error
>                                       spin_unlock()
>                                       return -EBUSY
> <finish unregister>
> 
> The above is fine and is the same thing that would happen if the
> whole register function ran before the unregister even started, right?
> 
> Also: if the unregister won the race that should also be fine.
> 
> So really the problem is this:
> 
> cpu1 (unregister)                 cpu2 (register):
> -----------------                 ----------------------
> kgdb_unregister_callbacks()
>                                   spin_lock() <got>
> spin_lock() <blocked>
>                                   if (old_dbg_io_ops) <true>
>                                     if (has dinit) <true>
>                                       print Replacing
>                                   init new IO ops
>                                   spin_unlock()
>                                   if (old_dbg_io_ops) <true>
>                                     finish deinit of old
>                                     return true
> WARN_ON() <hits and shouts!>
> dbg_io_ops = NULL
> spin_unlock()
> if (deinit) <true>
>   double-call to deinit of old
> 
> So in this case we'll hit a WARN_ON(), incorrectly unregister the new
> IO ops, and call deinit twice.

To be honest I was simply working on "it is racy" and "there's not a
good reason to allow that", especially as we start to develop tools to
bring races to the surfaces someone will yell at us about it sooner or
later ;-).

Of course, implementing it correctly would have been better...


Daniel.
