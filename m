Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CAFC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF31720C56
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599005395;
	bh=ue8KFmWAURt4lhvOfblC/6hWxuPhGkaF5B0T2fLxa7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x4b5hd1NW7+QOwPg+JpMK9KWpaVGghJz9WpJLuL9UKVNVvI5sfVMQndTarkrR4bVJ
	 XqjQ7F2xyQQZQoSnlZSFcurHHFluKGDsbMLe53mzBLnwCMAKuMIWRAKqc2QsoLNbRX
	 tL+HhPzSJmtNgkkq8d0XQbi2sC4WKnSZSqogzBGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBAJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBAJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:09:50 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD2020C56
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599005388;
        bh=ue8KFmWAURt4lhvOfblC/6hWxuPhGkaF5B0T2fLxa7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TMu2S3IzHfz+o6ohiqDLBmmcmE/E3rINy8vvAXGieza4ImIhAEf776UnghnDuHvzd
         5RUSUwl4gq1gDaK4mi1DBXXH+ZDeKELWu02LXQKCNxeqTYN929b+1mZTWtyLPaPna1
         +yVVQs19uJk+DPC0V7/4RRNdHi/w9iCHs5rjuS/c=
Received: by mail-wm1-f42.google.com with SMTP id v4so2767089wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 17:09:48 -0700 (PDT)
X-Gm-Message-State: AOAM531Y70Z0hh4+kK4oisbmPW8Qd713xH/Gp3RACpGDUL0lLifqSRJe
        pR1i6+9BKzOD9v3PIZtVpeikTzDoSM7lDR6HJ+OqRA==
X-Google-Smtp-Source: ABdhPJyyfibJgmTm5WYzNGqNFdu9nOVgGk+6VQWbLUP3cCSoL53YNiq4XcCEUyla/kGQQVBTYc7jpCQ/5AYmCiDL+Ho=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr4078821wmc.138.1599005386776;
 Tue, 01 Sep 2020 17:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
 <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
 <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com> <87k0xdjbtt.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k0xdjbtt.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Sep 2020 17:09:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com>
Message-ID: <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com>
Subject: Re: ptrace_syscall_32 is failing
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 4:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, Aug 30 2020 at 08:52, Andy Lutomirski wrote:
> >> > [RUN]    SYSCALL
> >> > [FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
> >> > [RUN]    SYSCALL
> >> > [OK]    Args after SIGUSR1 are correct (ax = -514)
> >> > [OK]    Child got SIGUSR1
> >> > [RUN]    Step again
> >> > [OK]    pause(2) restarted correctly
> >>
> >> Bisected to commit 0b085e68f407 ("x86/entry: Consolidate 32/64 bit
> >> syscall entry").
> >> It looks like it is because syscall_enter_from_user_mode() is called
> >> before reading the 6th argument from the user stack.
>
> Bah.I don't know how I managed to miss that part and interestingly
> enough that none of the robots caught that either
>
> > Thomas, can we revert the syscall_enter() and syscall_exit() part of
> > the series?
>
> Hrm.
>
> > I think that they almost work for x86, but not quite as
> > indicated by this bug.  Even if we imagine we can somehow hack around
> > this bug, I imagine we're going to find other problems with this
> > model, e.g. the potential upcoming exit problem I noted in my review.
>
> What's the upcoming problem?

If we ever want to get single-stepping fully correct across syscalls,
we might need to inject SIGTRAP on syscall return. This would be more
awkward if we can't run instrumentable code after the syscall part of
the syscall is done.

>
> > I really think the model should be:
> >
> > void do_syscall_whatever(...)
> > {
> >   irqentry_enter(...);
> >   instrumentation_begin();
> >
> >   /* Do whatever arch ABI oddities are needed on entry. */
> >
> >   Then either:
> >   syscall_begin(arch, nr, regs);
> >   dispatch the syscall;
> >   syscall_end(arch, nr, regs);
> >
> >   Or just:
> >   generic_do_syscall(arch, nr, regs);
> >
> >   /* Do whatever arch ABI oddities are needed on exit from the syscall. */
> >
> >   instrumentation_end();
> >   irqentry_exit(...);
> > }
>
> I don't think we want that in general. The current variant is perfectly
> fine for everything except the 32bit fast syscall nonsense. Also
> irqentry_entry/exit is not equivalent to the syscall_enter/exit
> counterparts.

If there are any architectures in which actual work is needed to
figure out whether something is a syscall in the first place, they'll
want to do the usual kernel entry work before the syscall entry work.
Maybe your patch actually makes this possible -- I haven't digested
all the details yet.

Who advised you to drop the arch parameter?

> ---
>  arch/x86/entry/common.c      |   29 ++++++++++++++++--------
>  include/linux/entry-common.h |   51 +++++++++++++++++++++++++++++++++++--------
>  kernel/entry/common.c        |   35 ++++++++++++++++++++++++-----
>  3 files changed, 91 insertions(+), 24 deletions(-)
>
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -60,16 +60,10 @@
>  #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
>  static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
>  {
> -       unsigned int nr = (unsigned int)regs->orig_ax;
> -
>         if (IS_ENABLED(CONFIG_IA32_EMULATION))
>                 current_thread_info()->status |= TS_COMPAT;
> -       /*
> -        * Subtlety here: if ptrace pokes something larger than 2^32-1 into
> -        * orig_ax, the unsigned int return value truncates it.  This may
> -        * or may not be necessary, but it matches the old asm behavior.
> -        */
> -       return (unsigned int)syscall_enter_from_user_mode(regs, nr);
> +
> +       return (unsigned int)regs->orig_ax;
>  }
>
>  /*
> @@ -91,15 +85,29 @@ static __always_inline void do_syscall_3
>  {
>         unsigned int nr = syscall_32_enter(regs);
>
> +       /*
> +        * Subtlety here: if ptrace pokes something larger than 2^32-1 into
> +        * orig_ax, the unsigned int return value truncates it.  This may
> +        * or may not be necessary, but it matches the old asm behavior.
> +        */
> +       nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
> +
>         do_syscall_32_irqs_on(regs, nr);
>         syscall_exit_to_user_mode(regs);
>  }
>
>  static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>  {
> -       unsigned int nr = syscall_32_enter(regs);
> +       unsigned int nr = syscall_32_enter(regs);
>         int res;
>
> +       /*
> +        * This cannot use syscall_enter_from_user_mode() as it has to
> +        * fetch EBP before invoking any of the syscall entry work
> +        * functions.
> +        */
> +       syscall_enter_from_user_mode_prepare(regs);

I'm getting lost in all these "enter" functions...
