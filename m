Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2399DC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA6A2137B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589101186;
	bh=/RntUQgZ4VxLxMu4+YNoen/YFz9jHRYb9h2qimOY4zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DaJs74DwW+Z/LnV/fxD/bkYzsNdstM1CYXll+5jbzh3ZWHh57ASNBFakyLPHIyS9I
	 9eoc+0HgQjiDsPeiDiaOx+5B9sjtfZcTohtswHcgoe9WalZelvk3BQQdcBM9Sz1fKt
	 +uMnGM5h0uSMoQSZrXWXH/fxqijZFiy7ucKwwS1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgEJI7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 04:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgEJI7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 04:59:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367B9208DB;
        Sun, 10 May 2020 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589101183;
        bh=/RntUQgZ4VxLxMu4+YNoen/YFz9jHRYb9h2qimOY4zI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HNsh0B/2fbkkfKqwDlJ6WNg6+tgtHSwmphr8OrRhTD986IKOz0KikcMko3h0lnP4s
         MDPvuIH6Rf2CCgePtqjqBoSxKU2KWPrB2fjWtrhElXZvIx6KQPnEc2Y20NKk6ej3gt
         tDgGgbrOx84K7Xr18Uif4Sgs9KTqTqOFCuD3uOgM=
Date:   Sun, 10 May 2020 17:59:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     <daniel.thompson@linaro.org>, <jason.wessel@windriver.com>,
        <dianders@chromium.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
Subject: Re: [PATCH 2/4] arm64: Extract kprobes_save_local_irqflag() and
 kprobes_restore_local_irqflag()
Message-Id: <20200510175938.7c888bd01f82d29203995c63@kernel.org>
In-Reply-To: <20200509214159.19680-3-liwei391@huawei.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
        <20200509214159.19680-3-liwei391@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Sun, 10 May 2020 05:41:57 +0800
Wei Li <liwei391@huawei.com> wrote:

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

Agreed, these prepare/cleanup should be generic.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

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
> +						struct pt_regs *regs);
> +void kernel_cleanup_single_step(unsigned long flags,
> +						struct pt_regs *regs);
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
> +						struct pt_regs *regs)
> +{
> +	*flags = regs->pstate & DAIF_MASK;
> +	regs->pstate |= PSR_I_BIT;
> +	/* Unmask PSTATE.D for enabling software step exceptions. */
> +	regs->pstate &= ~PSR_D_BIT;
> +}
> +NOKPROBE_SYMBOL(kernel_prepare_single_step);
> +
> +void kernel_cleanup_single_step(unsigned long flags,
> +						struct pt_regs *regs)
> +{
> +	regs->pstate &= ~DAIF_MASK;
> +	regs->pstate |= flags;
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
>  	__this_cpu_write(current_kprobe, p);
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
> -						struct pt_regs *regs)
> -{
> -	kcb->saved_irqflag = regs->pstate & DAIF_MASK;
> -	regs->pstate |= PSR_I_BIT;
> -	/* Unmask PSTATE.D for enabling software step exceptions. */
> -	regs->pstate &= ~PSR_D_BIT;
> -}
> -
> -static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
> -						struct pt_regs *regs)
> -{
> -	regs->pstate &= ~DAIF_MASK;
> -	regs->pstate |= kcb->saved_irqflag;
> -}
> -
>  static void __kprobes
>  set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
>  {
> @@ -227,7 +203,7 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>  		set_ss_context(kcb, slot);	/* mark pending ss */
>  
>  		/* IRQs and single stepping do not mix well. */
> -		kprobes_save_local_irqflag(kcb, regs);
> +		kernel_prepare_single_step(&kcb->saved_irqflag, regs);
>  		kernel_enable_single_step(regs);
>  		instruction_pointer_set(regs, slot);
>  	} else {
> @@ -414,7 +390,7 @@ kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
>  	retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
>  
>  	if (retval == DBG_HOOK_HANDLED) {
> -		kprobes_restore_local_irqflag(kcb, regs);
> +		kernel_cleanup_single_step(kcb->saved_irqflag, regs);
>  		kernel_disable_single_step();
>  
>  		post_kprobe_handler(kcb, regs);
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
