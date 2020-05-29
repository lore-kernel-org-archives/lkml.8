Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9611C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C1E20723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="fsfq+9ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgE2Bh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgE2BhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:37:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661FDC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:37:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fs4so412102pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=I9ySmq/ziTnD5JxWwfYJIk6GUKpSL6REIC8gk6+wZMc=;
        b=fsfq+9tiV8u8HYp38iQg9BOoRCUTFfhL59YYTFKAt/ysAn3GrtGIwAl0STMCWez+jo
         /B6RmKyjAds7rB03or7Y+orv4p6rsJrikLhB7tSomO/hVQNW4ttaJioNGBzcU4qqPgn2
         JpX6+OyA6RBlEYD4kMIwwwk693CrdN+V+21ZyJ/dqMbJYnLGzYuNidneLt5MrKmCrM/6
         9Wc5OsYLP+8GHrE/kO2GqNyDSAa2J3YGogjb/aThuaUX5QjqTutwQPhR+oeNdK5jiG55
         C1qiYUOUgbXrMEj9rEvBFuV3wwYN/6horCIqfnAWOj9XOIi1ikpngxS9knF6H6KNDgjY
         9nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=I9ySmq/ziTnD5JxWwfYJIk6GUKpSL6REIC8gk6+wZMc=;
        b=VuVASk3g3kpzHbL0DZ/2x7sgdB1SpNE5yJBPGDLmnKeR3M6V4L5er38FUIRglrANiv
         Yd+0JfgjvQoADjGMV5mlLERYoOg/XUTNG/lRAgla5ikYliBWJDOMdivBVlQ1Z3Gz4/rv
         XT1XcK/Eva2EXWOk9u7nVhG3r3Bt0f3KrobQvy654vZwALhUit6CrGQpvMPwkVmDC5vl
         AMZTGNZVsvdZk1mOpDSzsZn9NX4zopw/bg1sGcV1RyPPm0mVTj9PqMJk3EEtfSXwPOwF
         qmT7U0xep1L0/pR7CuCa0BgkRI9MLX3tdYhu1sgTQrm1lgFCOptOvOhhHrtw+nzCzPpW
         ZieQ==
X-Gm-Message-State: AOAM5321UJUZyQMeDc1rrVmCmFbG/prrysJBmdwKoUMIfhUMPj78S2r3
        kz/6t62kCXncbVnXbcGJiJ+qQg==
X-Google-Smtp-Source: ABdhPJzMjKkIRn90tyhAd6Gm1cXusgxHVIqzD7pgn5rxO/zcNPjJe4FguS6UJqFgV09OVFl1uVDr8Q==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr7084493pjb.173.1590716238955;
        Thu, 28 May 2020 18:37:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v197sm6073630pfc.4.2020.05.28.18.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 18:37:18 -0700 (PDT)
Date:   Thu, 28 May 2020 18:37:18 -0700 (PDT)
X-Google-Original-Date: Thu, 28 May 2020 18:25:39 PDT (-0700)
Subject:     Re: [PATCH v5 1/6] RISC-V: self-contained IPI handling routine
In-Reply-To: <20200521133301.816665-2-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, Marc Zyngier <maz@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-bd8faf3a-434c-4beb-a44a-3c71475304cd@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 06:32:56 PDT (-0700), Anup Patel wrote:
> Currently, the IPI handling routine riscv_software_interrupt() does
> not take any argument and also does not perform irq_enter()/irq_exit().
>
> This patch makes IPI handling routine more self-contained by:
> 1. Passing "pt_regs *" argument
> 2. Explicitly doing irq_enter()/irq_exit()
> 3. Explicitly save/restore "pt_regs *" using set_irq_regs()
>
> With above changes, IPI handling routine does not depend on caller
> function to perform irq_enter()/irq_exit() and save/restore of
> "pt_regs *" hence its more self-contained. This also enables us
> to call IPI handling routine from IRQCHIP drivers.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/irq.h |  1 -
>  arch/riscv/include/asm/smp.h |  3 +++
>  arch/riscv/kernel/irq.c      | 16 ++++++++++------
>  arch/riscv/kernel/smp.c      | 11 +++++++++--
>  4 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 6e1b0e0325eb..0183e15ace66 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -13,7 +13,6 @@
>  #define NR_IRQS         0
>
>  void riscv_timer_interrupt(void);
> -void riscv_software_interrupt(void);
>
>  #include <asm-generic/irq.h>
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index f4c7cfda6b7f..40bb1c15a731 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -28,6 +28,9 @@ void show_ipi_stats(struct seq_file *p, int prec);
>  /* SMP initialization hook for setup_arch */
>  void __init setup_smp(void);
>
> +/* Called from C code, this handles an IPI. */
> +void handle_IPI(struct pt_regs *regs);
> +
>  /* Hook for the generic smp_call_function_many() routine. */
>  void arch_send_call_function_ipi_mask(struct cpumask *mask);
>
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 345c4f2eba13..bb0bfcd537e7 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -19,12 +19,15 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>
>  asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
>  {
> -	struct pt_regs *old_regs = set_irq_regs(regs);
> +	struct pt_regs *old_regs;
>
> -	irq_enter();
>  	switch (regs->cause & ~CAUSE_IRQ_FLAG) {
>  	case RV_IRQ_TIMER:
> +		old_regs = set_irq_regs(regs);
> +		irq_enter();
>  		riscv_timer_interrupt();
> +		irq_exit();
> +		set_irq_regs(old_regs);
>  		break;
>  #ifdef CONFIG_SMP
>  	case RV_IRQ_SOFT:
> @@ -32,19 +35,20 @@ asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
>  		 * We only use software interrupts to pass IPIs, so if a non-SMP
>  		 * system gets one, then we don't know what to do.
>  		 */
> -		riscv_software_interrupt();
> +		handle_IPI(regs);
>  		break;
>  #endif
>  	case RV_IRQ_EXT:
> +		old_regs = set_irq_regs(regs);
> +		irq_enter();
>  		handle_arch_irq(regs);
> +		irq_exit();
> +		set_irq_regs(old_regs);
>  		break;
>  	default:
>  		pr_alert("unexpected interrupt cause 0x%lx", regs->cause);
>  		BUG();
>  	}
> -	irq_exit();
> -
> -	set_irq_regs(old_regs);
>  }
>
>  void __init init_IRQ(void)
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index a65a8fa0c22d..b1d4f452f843 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -123,11 +123,14 @@ static inline void clear_ipi(void)
>  		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
>  }
>
> -void riscv_software_interrupt(void)
> +void handle_IPI(struct pt_regs *regs)
>  {
> +	struct pt_regs *old_regs = set_irq_regs(regs);
>  	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
>  	unsigned long *stats = ipi_data[smp_processor_id()].stats;
>
> +	irq_enter();
> +
>  	clear_ipi();
>
>  	while (true) {
> @@ -138,7 +141,7 @@ void riscv_software_interrupt(void)
>
>  		ops = xchg(pending_ipis, 0);
>  		if (ops == 0)
> -			return;
> +			goto done;
>
>  		if (ops & (1 << IPI_RESCHEDULE)) {
>  			stats[IPI_RESCHEDULE]++;
> @@ -160,6 +163,10 @@ void riscv_software_interrupt(void)
>  		/* Order data access and bit testing. */
>  		mb();
>  	}
> +
> +done:
> +	irq_exit();
> +	set_irq_regs(old_regs);
>  }
>
>  static const char * const ipi_names[] = {

I guess we still have to figure out which tree these are going in through, but
I'm going to start acking them as I review them just so it all stays together.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
