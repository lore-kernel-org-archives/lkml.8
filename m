Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B289FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FFF2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Na/d5Qrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbgENAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732847AbgENAVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:21:52 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A06C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:21:52 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id g2so953976vsb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpGKrAWxnYteSKZx7BseBLlhQnaeajEX7687cVAYxvo=;
        b=Na/d5QrkKWMd5tBXEQIOgp0ETgPkUHKtgmGm/sLF6yNvFjZqEKLtpDkpMNCJjQuGh4
         m+pWKEf2Dt08HwhWCRjZSTVVkTRDd1BnZ2KqkRFwiv3vY/wdr/WVJpe3WBgXKXtOozjM
         S124A/tHJN4q3DSHmZKFkknmBOJKhcz0ZjtA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpGKrAWxnYteSKZx7BseBLlhQnaeajEX7687cVAYxvo=;
        b=ncByJ12/rEQDOG8pJuZxstpfq3ZOSpnku67+IOxFqxrDCplVOWU7lvPggzSbGNNpqm
         bq7+ptQsDRnj/7mzfXM1og+QhrGKuRQGL8kmgoqGTgUfaYNL9fZyOLhX/z9fNTrRQoSg
         xEt2CZ51dxFCtTFY1+NjHBiflhhZuJl2nEfS43D3zSeQzhZr55pZc0xDjyxtw/wwpuTX
         9KoPqU1fS5F29SCnqeATcC3hwgBXjJDe1kZAPJQQK0lO/oAXr5l4YLgdgxzepJtcJbxa
         Da3CpVUlwIER0HGBMPZ7/ioSMFqH4ZcDMJmh8O6ZR/Hqb7rHLka7LWx6p+Lh+XfVWZtT
         Vwjg==
X-Gm-Message-State: AOAM530CSkIfC1LYows0H9VDbNw4CztX0faEDMxWCzlcsrq2hBusXQqH
        QJlPxkvVZKKfefOmBxgMzlGqdk8J21w=
X-Google-Smtp-Source: ABdhPJyRgBMuMO5bpUOB0NZTXCCXsDpmlbw4khkv07bXL16F6DRoNaZtKzMdkCCVYDlyNlnkLPZGng==
X-Received: by 2002:a67:ee0d:: with SMTP id f13mr1625128vsp.188.1589415710759;
        Wed, 13 May 2020 17:21:50 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id c94sm328087uac.2.2020.05.13.17.21.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 17:21:50 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id y10so496190uao.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:21:49 -0700 (PDT)
X-Received: by 2002:ab0:6147:: with SMTP id w7mr427477uan.8.1589415709444;
 Wed, 13 May 2020 17:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com> <20200509214159.19680-3-liwei391@huawei.com>
In-Reply-To: <20200509214159.19680-3-liwei391@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 17:21:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVz4QnQ6AWAsCMxw6Zne6es0omvJ--Gnag=PXkMPt42g@mail.gmail.com>
Message-ID: <CAD=FV=VVz4QnQ6AWAsCMxw6Zne6es0omvJ--Gnag=PXkMPt42g@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: Extract kprobes_save_local_irqflag() and kprobes_restore_local_irqflag()
To:     Wei Li <liwei391@huawei.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
>
> PSTATE.I and PSTATE.D are very important for single-step working.
>
> Without disabling interrupt on local CPU, there is a chance of
> interrupt occurrence in the period of exception return and start of
> out-of-line single-step, that result in wrongly single stepping
> into the interrupt handler. And if D bit is set then, it results into
> undefined exception and when it's handler enables dbg then single-step
> exception is generated, not as expected.
>
> As they are maintained well in kprobes_save_local_irqflag() and
> kprobes_restore_local_irqflag() for kprobe module, extract them as
> kernel_prepare_single_step() and kernel_cleanup_single_step() for
> general use.
>
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/include/asm/debug-monitors.h |  4 ++++
>  arch/arm64/kernel/debug-monitors.c      | 26 +++++++++++++++++++++++
>  arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
>  3 files changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 7619f473155f..b62469f3475b 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -113,6 +113,10 @@ void user_fastforward_single_step(struct task_struct *task);
>  void kernel_enable_single_step(struct pt_regs *regs);
>  void kernel_disable_single_step(void);
>  int kernel_active_single_step(void);
> +void kernel_prepare_single_step(unsigned long *flags,
> +                                               struct pt_regs *regs);
> +void kernel_cleanup_single_step(unsigned long flags,
> +                                               struct pt_regs *regs);
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
>  int reinstall_suspended_bps(struct pt_regs *regs);
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 48222a4760c2..25ce6b5a52d2 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -429,6 +429,32 @@ int kernel_active_single_step(void)
>  }
>  NOKPROBE_SYMBOL(kernel_active_single_step);
>
> +/*
> + * Interrupts need to be disabled before single-step mode is set, and not
> + * reenabled until after single-step mode ends.
> + * Without disabling interrupt on local CPU, there is a chance of
> + * interrupt occurrence in the period of exception return and  start of
> + * out-of-line single-step, that result in wrongly single stepping
> + * into the interrupt handler.
> + */
> +void kernel_prepare_single_step(unsigned long *flags,
> +                                               struct pt_regs *regs)
> +{
> +       *flags = regs->pstate & DAIF_MASK;
> +       regs->pstate |= PSR_I_BIT;
> +       /* Unmask PSTATE.D for enabling software step exceptions. */
> +       regs->pstate &= ~PSR_D_BIT;
> +}
> +NOKPROBE_SYMBOL(kernel_prepare_single_step);

nit: why not just return unsigned long rather than passing by reference?


> +
> +void kernel_cleanup_single_step(unsigned long flags,
> +                                               struct pt_regs *regs)
> +{
> +       regs->pstate &= ~DAIF_MASK;
> +       regs->pstate |= flags;
> +}
> +NOKPROBE_SYMBOL(kernel_cleanup_single_step);
> +
>  /* ptrace API */
>  void user_enable_single_step(struct task_struct *task)
>  {
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index d1c95dcf1d78..c655b6b543e3 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -168,30 +168,6 @@ static void __kprobes set_current_kprobe(struct kprobe *p)
>         __this_cpu_write(current_kprobe, p);
>  }
>
> -/*
> - * Interrupts need to be disabled before single-step mode is set, and not
> - * reenabled until after single-step mode ends.
> - * Without disabling interrupt on local CPU, there is a chance of
> - * interrupt occurrence in the period of exception return and  start of
> - * out-of-line single-step, that result in wrongly single stepping
> - * into the interrupt handler.
> - */
> -static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
> -                                               struct pt_regs *regs)
> -{
> -       kcb->saved_irqflag = regs->pstate & DAIF_MASK;
> -       regs->pstate |= PSR_I_BIT;
> -       /* Unmask PSTATE.D for enabling software step exceptions. */
> -       regs->pstate &= ~PSR_D_BIT;
> -}
> -
> -static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
> -                                               struct pt_regs *regs)
> -{
> -       regs->pstate &= ~DAIF_MASK;
> -       regs->pstate |= kcb->saved_irqflag;
> -}
> -
>  static void __kprobes
>  set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
>  {
> @@ -227,7 +203,7 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>                 set_ss_context(kcb, slot);      /* mark pending ss */
>
>                 /* IRQs and single stepping do not mix well. */
> -               kprobes_save_local_irqflag(kcb, regs);
> +               kernel_prepare_single_step(&kcb->saved_irqflag, regs);

Is there some reason to have two functions?  It seems like every time
you call kernel_enable_single_step() you'd want to call
kernel_prepare_single_step().  ...and every time you call
kernel_disable_single_step() you'd want to call
kernel_cleanup_single_step().

Maybe you can just add the flags parameter to
kernel_enable_single_step() / kernel_disable_single_step() and put the
code in there?


-Doug
