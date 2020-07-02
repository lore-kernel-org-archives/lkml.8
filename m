Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FA62084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593714077;
	bh=od8CmWPiX+a0VrEI4SwvSaUzn0AzEAmUSBqAuGCGkB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FFS2AF/teIutwlrEj1imHCJuJdxifll9bWLg20A7uX+u3dL6/bRy9PVJh+lHD1VQB
	 9UekcZAPJUxpLIqW96tUoCqIo3T97vW2I3XT2g9Osso1xX7bZWz9RpCoqHkCtj791J
	 m0LoTDlK1r2j61ibyWxndaSXC01I1qK0QQu5Ksr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGBSVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgGBSVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:21:15 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D58208D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593714074;
        bh=od8CmWPiX+a0VrEI4SwvSaUzn0AzEAmUSBqAuGCGkB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K7q/s1pkoeNSbBojHMLagRhr4Dj/a2u38lhFSiU8fOOTJmFUme+3YyDC3GgeJJB7t
         zn+hUkS5pGr5NxpjBxBcf4KLVx23LDAl/xl7PWCiSKNA213QOkGHW2Hb5m6fVKbAvE
         HDeaH/bUqRfK6bX4FDMZs7OjFyj3yB8krr08Wiuk=
Received: by mail-wr1-f49.google.com with SMTP id o11so29636165wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:21:14 -0700 (PDT)
X-Gm-Message-State: AOAM530u6H+JwhI1lmMQzgt/pww2r0P2ZBGsVgBhP8uocUD9dvOPiPrU
        ACLilij8D8jVhQRW8F10A3PEjyfcJlpVLj1imp9RsA==
X-Google-Smtp-Source: ABdhPJzEhBH1ffttnZPRpbcHbobLvjR1vE71YHh7AFe4Fuvdna7p8xEMjd79Y8fq57+aIH8V/IqAOaDp0gNfBNk5zQU=
X-Received: by 2002:adf:a111:: with SMTP id o17mr32330321wro.257.1593714072771;
 Thu, 02 Jul 2020 11:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <87imfwd5f6.fsf@nanos.tec.linutronix.de> <8DD3180E-0E69-4FD6-92C3-311AAB3F688F@amacapital.net>
 <87d064d13p.fsf@nanos.tec.linutronix.de> <CA+G9fYvVEMVaF=qzhCpJ8NMb1-VN4cEh6sw8P_eNFCLQYOjCzA@mail.gmail.com>
 <20200702150250.GS4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200702150250.GS4800@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 2 Jul 2020 11:21:01 -0700
X-Gmail-Original-Message-ID: <CALCETrVM8YNdssYF38hB=Sg3BgwiFaaBYfz3AeBqVYP3biucLg@mail.gmail.com>
Message-ID: <CALCETrVM8YNdssYF38hB=Sg3BgwiFaaBYfz3AeBqVYP3biucLg@mail.gmail.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 02, 2020 at 07:57:54PM +0530, Naresh Kamboju wrote:
> > I have reported this warning on linux-next and now it is happening on
> > linux mainline tree.
> > May I know , are we missing a fix patch on linus 's tree ?
> >
> > - Naresh
> > ---
> > While running selftest x86 single_step_syscall_32 on
> > i386 kernel linux 5.8.0-rc3 kernel warning noticed.
> >
> > steps to reproduce:
> > --------------------------
> > perf test
> > and
> > cd /opt/kselftests/default-in-kernel/x86
> > ./single_step_syscall_32
> >
> > crash dump,
> > [ 1324.774385] kselftest: Running tests in x86
> > [ 1324.830187] ------------[ cut here ]------------
> > [ 1324.834820] IRQs not disabled as expected
> > [ 1324.838838] WARNING: CPU: 2 PID: 5365 at
> > /usr/src/kernel/arch/x86/entry/common.c:645
> > idtentry_exit_cond_rcu+0x92/0xc0
>
> How's this?
>
> DEFINE_IDTENTRY_DEBUG() is DEFINE_IDTENTRY_RAW on x86_64
>                            DEFINE_IDTENTRY on i386
>
> calling exc_debug_*() from DEFINE_IDTENTRY() does a double layer of
> idtentry_{enter,exit}*() functions.
>
> Also, handle_debug() is still a trainwreck, we should never get to
> cond_local_irq_enable() when !user.
>
> Completely untested...
>
> ---
>  arch/x86/kernel/traps.c | 49 +++++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index b0195771c932..47d6b46e1564 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -806,8 +806,17 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
>          * If DR6 is zero, no point in trying to handle it. The kernel is
>          * not using INT1.
>          */
> -       if (!user && !dr6)
> -               return;
> +       if (!user) {
> +               /*
> +                * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
> +                * watchpoint at the same time then that will still be handled.
> +                */
> +               if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
> +                       dr6 &= ~DR_STEP;
> +
> +               if (!dr6)
> +                       return;
> +       }
>
>         /*
>          * If dr6 has no reason to give us about the origin of this trap,
> @@ -859,25 +868,29 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
>         cond_local_irq_disable(regs);
>  }
>
> +#ifdef CONFIG_X86_64
>  static __always_inline void exc_debug_kernel(struct pt_regs *regs,
>                                              unsigned long dr6)
>  {
>         bool irq_state = idtentry_enter_nmi(regs);
>         instrumentation_begin();
>
> -       /*
> -        * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
> -        * watchpoint at the same time then that will still be handled.
> -        */
> -       if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
> -               dr6 &= ~DR_STEP;
> -
>         handle_debug(regs, dr6, false);
>
>         instrumentation_end();
>         idtentry_exit_nmi(regs, irq_state);
>  }
>
> +/* IST stack entry */
> +DEFINE_IDTENTRY_DEBUG(exc_debug)
> +{
> +       unsigned long dr6, dr7;
> +
> +       debug_enter(&dr6, &dr7);
> +       exc_debug_kernel(regs, dr6);
> +       debug_exit(dr7);
> +}
> +
>  static __always_inline void exc_debug_user(struct pt_regs *regs,
>                                            unsigned long dr6)
>  {
> @@ -890,17 +903,6 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
>         idtentry_exit_user(regs);
>  }
>
> -#ifdef CONFIG_X86_64
> -/* IST stack entry */
> -DEFINE_IDTENTRY_DEBUG(exc_debug)
> -{
> -       unsigned long dr6, dr7;
> -
> -       debug_enter(&dr6, &dr7);
> -       exc_debug_kernel(regs, dr6);
> -       debug_exit(dr7);
> -}
> -
>  /* User entry, runs on regular task stack */
>  DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
>  {
> @@ -917,12 +919,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
>         unsigned long dr6, dr7;
>
>         debug_enter(&dr6, &dr7);
> -
> -       if (user_mode(regs))
> -               exc_debug_user(regs, dr6);
> -       else
> -               exc_debug_kernel(regs, dr6);
> -
> +       handle_debug(regs, dr6, user_mode(regs));
>         debug_exit(dr7);
>  }
>  #endif

I'll fold something like this into my pile of pending fixes.
