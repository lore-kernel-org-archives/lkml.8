Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA601C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BC320776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0YYUmlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2Ocp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2Oco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:32:44 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B734C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:32:44 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b11so2069975qtt.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hp4UBDWhXpaJ5XcgBn9I6XZII2k5uXrv6CfpSnKpGCY=;
        b=Z0YYUmlI2antJ2wtfp61lpvCB3kZFm1sJI62GSLiOWUkkNA6scWg3NFXqdEapLoHJb
         2U9QtaJXIyWi8Mh+RUyJOABCIPu1QFhcKyLafpS/pru9onoPb71HJ5pEh4XkITt9Rl4H
         AiphofRyRGUwpvNnZPCGGZoxuLDFNK4os19Ct+MdJl001aFAUro9JpkfQkY3wsWPRCIO
         fBH+xjpOX7UE/x+kcorsVNJ/Syr7HpyTpymMVTjewiFgaqRzeTima8yBq3dWNSF1FPMl
         SVBxFgSilxdpa4w0hNMvRBlpvWNiljIhW+aO1aPBLXQZI0bWlNvT/Lb9Ta0XzyxX7V1+
         xvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hp4UBDWhXpaJ5XcgBn9I6XZII2k5uXrv6CfpSnKpGCY=;
        b=pfRvC2yyWlIhn4Kfjj6whnSVSmz9tJm7l8nxU15Ydf98hnpVgL3osWkPLu6OqkEypE
         abxK6I0TihyeqCIxzVI3HH6/Ww6Ik5hoeBFx/wsvvGxw6Vs5EOlcqcpUaz/sLSyhgBqX
         sWfQAaozyx7lr9FGTPsGqc+Aberu+NJ4HUdkiKEHSfHfSFbGL8zT/6TwifQox/5Iygl9
         liNAs9OAEY/IYi7bYbhYZ6CepC4dTycFC2skRdI3ZMCDUlTJMOLJQWXHvIeWvuccDIZk
         oYKxzsGXE6Qwwm/P0T/4ohL4OF80xlk+DLFummN9cAhj0cpTVb6VRnDnoTT7gVBGLT6n
         3hmw==
X-Gm-Message-State: AOAM533DjJfyXlMy9J5icDzdBOp/vnWMbhkTO/H2NTcshPYGe7l3CpBE
        N08wyrMDISkPNxglvQNx7wdnD+/20O2pBFyGd1yzsA==
X-Google-Smtp-Source: ABdhPJyBodJx5W7uxaxdbBY4lWqNP3JroXGMXvOewc5Jg/3OHh8drNIw+iFVwuxlYgrFhRtBW5WfVIEbw0Ed9xyOOsw=
X-Received: by 2002:ac8:260b:: with SMTP id u11mr9173767qtu.380.1590762763237;
 Fri, 29 May 2020 07:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000840d4d05a6850c73@google.com> <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
 <20200528161143.GF2869@paulmck-ThinkPad-P72> <878shbols9.fsf@nanos.tec.linutronix.de>
 <20200528204839.GR2869@paulmck-ThinkPad-P72> <CACT4Y+bVPSZVkWJquu5gk11ymhirsFvVFYHkexjqgBkgga379w@mail.gmail.com>
 <20200529140521.GA2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200529140521.GA2869@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 May 2020 16:32:31 +0200
Message-ID: <CACT4Y+YMo7ouRZRcD12HOnH5rJPYM1bH4DO6ODJm-=tO2WhQvw@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in idtentry_exit
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:05 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 08:20:12AM +0200, Dmitry Vyukov wrote:
> > On Thu, May 28, 2020 at 10:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, May 28, 2020 at 10:19:02PM +0200, Thomas Gleixner wrote:
> > > > Paul,
> > > >
> > > > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > > > On Thu, May 28, 2020 at 03:33:44PM +0200, Thomas Gleixner wrote:
> > > > >> syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com> writes:
> > > > >> Weird. I have no idea how that thing is an EQS here.
> > > > >
> > > > > No argument on the "Weird" part!  ;-)
> > > > >
> > > > > Is this a NO_HZ_FULL=y kernel?
> > > >
> > > > No, it has only NO_HZ_IDLE.
> > > >
> > > >   https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10
> > >
> > > OK, from the .config, another suggestion is to build the kernel
> > > with CONFIG_RCU_EQS_DEBUG=y.  This still requires that this issue be
> > > reproduced, but it might catch the problem earlier.
> >
> > How much does it slow down execution? If we enable it on syzbot, it
> > will affect all fuzzing done by syzbot always.
> > It can tolerate significant slowdown and it's far from a production
> > kernel (it enables KASAN, KCOV, LOCKDEP and more). But I am still
> > asking because some debugging features are built without performance
> > in mind at all (like let's just drop a global lock in every
> > kmalloc/free, which may be too much even for a standard debug build).
>
> It is an extra WARN_ON_ONCE() with a simple comparison, but on almost
> every kernel entry/exit path.
>
> So not something you want in production, but much lighter weight than
> any of the tools you listed above.
>
> Full disclosure:  It usually fires for new architectures or for new
> timer hardware/drivers.  Which might allow you to enable it selectively.


This sounds reasonable. I've enabled it:
https://github.com/google/syzkaller/commit/3905eaae004605f4ec4dab83e6883173796118c8
syzbot will pick up within a day or so. Then crashes will have any
additional checks captured.

The arch/hardware is quite old: x86_64/GCE. It also booted for me in
qemu without warnings.




>                                                         Thanx, Paul
>
> > > > > If so, one possibility is that the call
> > > > > to rcu_user_exit() went missing somehow.  If not, then RCU should have
> > > > > been watching userspace execution.
> > > > >
> > > > > Again, the only thing I can think of (should this prove to be
> > > > > reproducible) is the rcu_dyntick trace event.
> > > >
> > > > :)
> > > >
> > > > Thanks,
> > > >
> > > >         tglx
> > >
> > >                                                         Thanx, Paul
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200528204839.GR2869%40paulmck-ThinkPad-P72.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200529140521.GA2869%40paulmck-ThinkPad-P72.
