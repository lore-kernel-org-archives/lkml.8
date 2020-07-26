Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D33C2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOqK9Udg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgGZSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgGZSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:33:32 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68676C0619D2;
        Sun, 26 Jul 2020 11:33:32 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so6057455ilo.12;
        Sun, 26 Jul 2020 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjG7ZoYlTIlU86cx3B03lhQ3nQqrfFEpaGS9K3Q6ArU=;
        b=XOqK9Udgi1RcHDYkb5Lc5J6ccoEOeVxHwmqMaf45E7oWVRi5K8qH6Va0CW+Lyu/jqt
         NdhHW8EazqYMHTAmMGLmhepPswk6BYHr9KddZxu04t8KUGL21QIjxpfIvDMwllsh2E1w
         p3gSTe1ziK+8TrbxaSOI6Tpbpv0seHofvm5fQp2a5HOb3JBEFMaIVPiaVkOp8zuwFnKv
         Ax0+SMKLOgoqu7BTO4FSIqf5RrXZQmQknb/MgvznUBiP0TT03vA1Vax80/ZoXJQDqBkn
         cko3oER9r0pEb7MIQLvs1enJGOadJrcGuSff8ozVx2KcYFc+1cHEqs9fipLtf1AOcKyk
         WnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjG7ZoYlTIlU86cx3B03lhQ3nQqrfFEpaGS9K3Q6ArU=;
        b=oBgGBF2N7wwoJMyX4o0BKOLyMpqhJO7mOdAJJOHwkQZjKlcsrNRYERhI9loex+58A/
         /3d59SkHSc8LQcLXArHXoaECYMVCHaPDhGEMpVUdfr61saKY7M/fMO2bSRp7nZgItxL0
         573tEhJxT+/LCtpqvypDB8TVoIDCGo9t9BVYcgqxXUZz9AyZqEo7zvUTWxrG3b1QtcDa
         ei/7gs/FNaKKHFH409MFb5QHPCDmZki/deundsGBJe9aMdwtqwum+ifSYzekawfNUKNk
         otyEV18PmjHoUBAdcfuqFYHZRXbyebhsnifLlJCoismhQEaxdnAKCtrb5KoG4CoOhtIj
         TcNA==
X-Gm-Message-State: AOAM530WOAh5BFuupX3/nX4Dw/8oNPHiDqvr8nZY6XVMneyH7kT1F8O2
        8HO+GBi8VmvF8PavkqPV56SB4gYmqdgqz3wxNzyfwbU=
X-Google-Smtp-Source: ABdhPJwZ78Ret661pOnPu9acx4lFJWN7fHXGU3s9HQMQj393fTZdEDKU8RoNSZ9LLsSXDFF1IYwqF1nS72wDxWMYEqg=
X-Received: by 2002:a92:b112:: with SMTP id t18mr11662345ilh.172.1595788411185;
 Sun, 26 Jul 2020 11:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200722220520.051234096@linutronix.de> <159562150262.4006.11750463088671474026.tip-bot2@tip-bot2>
In-Reply-To: <159562150262.4006.11750463088671474026.tip-bot2@tip-bot2>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 26 Jul 2020 14:33:20 -0400
Message-ID: <CAMzpN2ipn3tK7hg4njCG-svtbYSP_nmzr0mWHZCrkaJFYMuXWw@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Consolidate 32/64 bit syscall entry
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 4:14 PM tip-bot2 for Thomas Gleixner
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/entry branch of tip:
>
> Commit-ID:     0b085e68f4072024ecaa3889aeeaab5f6c8eba5c
> Gitweb:        https://git.kernel.org/tip/0b085e68f4072024ecaa3889aeeaab5f6c8eba5c
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Thu, 23 Jul 2020 00:00:01 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Fri, 24 Jul 2020 15:04:58 +02:00
>
> x86/entry: Consolidate 32/64 bit syscall entry
>
> 64bit and 32bit entry code have the same open coded syscall entry handling
> after the bitwidth specific bits.
>
> Move it to a helper function and share the code.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20200722220520.051234096@linutronix.de
>
>
> ---
>  arch/x86/entry/common.c | 93 +++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 52 deletions(-)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index ab6cb86..68d5c86 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -366,8 +366,7 @@ __visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
>         exit_to_user_mode();
>  }
>
> -#ifdef CONFIG_X86_64
> -__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
> +static noinstr long syscall_enter(struct pt_regs *regs, unsigned long nr)
>  {
>         struct thread_info *ti;
>
> @@ -379,6 +378,16 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>         if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
>                 nr = syscall_trace_enter(regs);
>
> +       instrumentation_end();
> +       return nr;
> +}
> +
> +#ifdef CONFIG_X86_64
> +__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
> +{
> +       nr = syscall_enter(regs, nr);
> +
> +       instrumentation_begin();
>         if (likely(nr < NR_syscalls)) {
>                 nr = array_index_nospec(nr, NR_syscalls);
>                 regs->ax = sys_call_table[nr](regs);
> @@ -390,64 +399,53 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>                 regs->ax = x32_sys_call_table[nr](regs);
>  #endif
>         }
> -       __syscall_return_slowpath(regs);
> -
>         instrumentation_end();
> -       exit_to_user_mode();
> +       syscall_return_slowpath(regs);
>  }
>  #endif
>
>  #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
> +static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
> +{
> +       if (IS_ENABLED(CONFIG_IA32_EMULATION))
> +               current_thread_info()->status |= TS_COMPAT;
> +       /*
> +        * Subtlety here: if ptrace pokes something larger than 2^32-1 into
> +        * orig_ax, the unsigned int return value truncates it.  This may
> +        * or may not be necessary, but it matches the old asm behavior.
> +        */
> +       return syscall_enter(regs, (unsigned int)regs->orig_ax);
> +}
> +
>  /*
> - * Does a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.  Does
> - * all entry and exit work and returns with IRQs off.  This function is
> - * extremely hot in workloads that use it, and it's usually called from
> - * do_fast_syscall_32, so forcibly inline it to improve performance.
> + * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
>   */
> -static void do_syscall_32_irqs_on(struct pt_regs *regs)
> +static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
> +                                                 unsigned int nr)
>  {
> -       struct thread_info *ti = current_thread_info();
> -       unsigned int nr = (unsigned int)regs->orig_ax;
> -
> -#ifdef CONFIG_IA32_EMULATION
> -       ti->status |= TS_COMPAT;
> -#endif
> -
> -       if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
> -               /*
> -                * Subtlety here: if ptrace pokes something larger than
> -                * 2^32-1 into orig_ax, this truncates it.  This may or
> -                * may not be necessary, but it matches the old asm
> -                * behavior.
> -                */
> -               nr = syscall_trace_enter(regs);
> -       }
> -
>         if (likely(nr < IA32_NR_syscalls)) {
> +               instrumentation_begin();
>                 nr = array_index_nospec(nr, IA32_NR_syscalls);
>                 regs->ax = ia32_sys_call_table[nr](regs);
> +               instrumentation_end();
>         }
> -
> -       __syscall_return_slowpath(regs);
>  }
>
>  /* Handles int $0x80 */
>  __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
>  {
> -       enter_from_user_mode(regs);
> -       instrumentation_begin();
> +       unsigned int nr = syscall_32_enter(regs);
>
> -       local_irq_enable();
> -       do_syscall_32_irqs_on(regs);
> -
> -       instrumentation_end();
> -       exit_to_user_mode();
> +       do_syscall_32_irqs_on(regs, nr);
> +       syscall_return_slowpath(regs);
>  }
>
> -static bool __do_fast_syscall_32(struct pt_regs *regs)
> +static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)

Can __do_fast_syscall_32() be merged back into do_fast_syscall_32()
now that both are marked noinstr?

--
Brian Gerst
