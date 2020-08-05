Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA48C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F150220792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="HzK+ca6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHEBry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEBrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:47:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11885C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 18:47:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so6108323pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hbhDd5h5jVe1Ri0zJKjTyJWIMM8zkGidIN7/ag+bjpw=;
        b=HzK+ca6Ha/0cNCnlTwobFMy1ZkHvaDLOgSrzqNXZNqx9T5ust2PaIE1g2MGS6XIqm9
         YCSKh/pqKUD+hWosSgQ6hf4WTnu+h8/ogN2xTkNxfU91WXFWRisqCec7XKOJIwLm59T7
         3Nen6gAEd/aPvCk07o0qPHWLLgryuXVN7zxWKbNmvjZ1dZxL8E56Ffh7FSJnZsxxrb6c
         lELId0btI8O4ANWXcrngyev23Bu04Topj6XUAnVkUfeSiVPh+5TWuc5Rv3WIAsHAT+ca
         LyUeWhCnACIX4U4mJUXEMXXkDMe4kFgLvKeGsZ0Vhozved7o3CIitzOI2SFaFP5peach
         hkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hbhDd5h5jVe1Ri0zJKjTyJWIMM8zkGidIN7/ag+bjpw=;
        b=kyJ359ehAexBGC+Mwz9dpEtiXxSQ8n9xIAuni0Vs6NVzxK6OavvCEDoaOW7izLR62c
         wI87U3t/9jvBUsYvXPnvqHKRqSLDUj6IwDM3cxl8gORogd8fcfdl+ZUSYzYyqHDjnQBr
         zRCuMeAOOkXF8IN9V5rfGxOwmCWLrknHAG6AaQGPopiHFbqREkefdRsMLzyz1f8HhEvV
         euOONrYzfT5oTisgnCwaJTiwbs6TqCCeP+NGYcqgovnS0p6/38je7dunA9whQ0F0VhBc
         rPCMmRa5QBdVjbtIDUmlz69y6TcYEcHw21IH/QdiC6ZzGmNHXNj0tZaKh5EFxmLhODLA
         ivpA==
X-Gm-Message-State: AOAM530Ma+7zro6oYpGhi3hUDKaDpBVN6dCyF5cTKCX8shtjj+g4huBK
        z/Jqmqw9sU53DWvFduHngvdm7Q==
X-Google-Smtp-Source: ABdhPJxrebvWAbvTnoleLLDXQbpIBRACyC1mC8A95kpxL4dJrKqB9vIsBXj8mvSwvWOnhek1x9mJYg==
X-Received: by 2002:a62:144b:: with SMTP id 72mr1106302pfu.111.1596592072080;
        Tue, 04 Aug 2020 18:47:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l8sm502367pjb.14.2020.08.04.18.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 18:47:51 -0700 (PDT)
Date:   Tue, 04 Aug 2020 18:47:51 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Aug 2020 18:30:52 PDT (-0700)
Subject:     Re: [PATCH v6 1/4] RISC-V: Add mechanism to provide custom IPI operations
In-Reply-To: <20200724071822.126758-2-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>, kernel@esmil.dk
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-b663cb30-a0de-4594-a5e1-394c3f29a049@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 00:18:19 PDT (-0700), Anup Patel wrote:
> We add mechanism to set custom IPI operations so that CLINT driver
> from drivers directory can provide custom IPI operations.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/clint.h | 25 --------------------
>  arch/riscv/include/asm/smp.h   | 19 +++++++++++++++
>  arch/riscv/kernel/clint.c      | 23 ++++++++++++++++--
>  arch/riscv/kernel/sbi.c        | 14 +++++++++++
>  arch/riscv/kernel/smp.c        | 43 +++++++++++++++++++---------------
>  arch/riscv/kernel/smpboot.c    |  3 +--
>  6 files changed, 79 insertions(+), 48 deletions(-)
>
> diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
> index a279b17a6aad..adaba98a7d6c 100644
> --- a/arch/riscv/include/asm/clint.h
> +++ b/arch/riscv/include/asm/clint.h
> @@ -6,34 +6,9 @@
>  #include <linux/smp.h>
>
>  #ifdef CONFIG_RISCV_M_MODE
> -extern u32 __iomem *clint_ipi_base;
> -
>  void clint_init_boot_cpu(void);
> -
> -static inline void clint_send_ipi_single(unsigned long hartid)
> -{
> -	writel(1, clint_ipi_base + hartid);
> -}
> -
> -static inline void clint_send_ipi_mask(const struct cpumask *mask)
> -{
> -	int cpu;
> -
> -	for_each_cpu(cpu, mask)
> -		clint_send_ipi_single(cpuid_to_hartid_map(cpu));
> -}
> -
> -static inline void clint_clear_ipi(unsigned long hartid)
> -{
> -	writel(0, clint_ipi_base + hartid);
> -}
>  #else /* CONFIG_RISCV_M_MODE */
>  #define clint_init_boot_cpu()	do { } while (0)
> -
> -/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_M_MODE): */
> -void clint_send_ipi_single(unsigned long hartid);
> -void clint_send_ipi_mask(const struct cpumask *hartid_mask);
> -void clint_clear_ipi(unsigned long hartid);
>  #endif /* CONFIG_RISCV_M_MODE */
>
>  #endif /* _ASM_RISCV_CLINT_H */

So this is entirely unrelated to the actual contents of this patch, I'd just
forgotten about it before: the scheme used by clint_init_boot_cpu() only works
once per system reset (and as far as I can tell, that code only works for
two-CPU systems).  Not really an issue with this patch set, but we should
probably put a sanity check in the code -- the two-CPU thing should be easy,
but the "only use the CLINT init trick once" thing need some sort of platform
interface.

> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 40bb1c15a731..68de78a8eba6 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -15,6 +15,11 @@
>  struct seq_file;
>  extern unsigned long boot_cpu_hartid;
>
> +struct riscv_ipi_ops {
> +	void (*ipi_inject)(const struct cpumask *target);
> +	void (*ipi_clear)(void);
> +};
> +
>  #ifdef CONFIG_SMP
>  /*
>   * Mapping between linux logical cpu index and hartid.
> @@ -40,6 +45,12 @@ void arch_send_call_function_single_ipi(int cpu);
>  int riscv_hartid_to_cpuid(int hartid);
>  void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>
> +/* Set custom IPI operations */
> +void riscv_set_ipi_ops(struct riscv_ipi_ops *ops);
> +
> +/* Clear IPI for current CPU */
> +void riscv_clear_ipi(void);
> +
>  /*
>   * Obtains the hart ID of the currently executing task.  This relies on
>   * THREAD_INFO_IN_TASK, but we define that unconditionally.
> @@ -78,6 +89,14 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
>  	cpumask_set_cpu(boot_cpu_hartid, out);
>  }
>
> +static inline void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
> +{
> +}

It's a bit pedantic, but it seems like this should do something as of this
patch -- even though there's only a single driver, it's odd to have this both
exist and do nothing.

> +
> +static inline void riscv_clear_ipi(void)
> +{
> +}
> +
>  #endif /* CONFIG_SMP */
>
>  #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
> index 3647980d14c3..a9845ee023e2 100644
> --- a/arch/riscv/kernel/clint.c
> +++ b/arch/riscv/kernel/clint.c
> @@ -5,11 +5,11 @@
>
>  #include <linux/io.h>
>  #include <linux/of_address.h>
> +#include <linux/smp.h>
>  #include <linux/types.h>
>  #include <asm/clint.h>
>  #include <asm/csr.h>
>  #include <asm/timex.h>
> -#include <asm/smp.h>
>
>  /*
>   * This is the layout used by the SiFive clint, which is also shared by the qemu
> @@ -21,6 +21,24 @@
>
>  u32 __iomem *clint_ipi_base;
>
> +static void clint_send_ipi(const struct cpumask *target)
> +{
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, target)
> +		writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
> +}
> +
> +static void clint_clear_ipi(void)
> +{
> +	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
> +}
> +
> +static struct riscv_ipi_ops clint_ipi_ops = {
> +	.ipi_inject = clint_send_ipi,
> +	.ipi_clear = clint_clear_ipi,
> +};
> +
>  void clint_init_boot_cpu(void)
>  {
>  	struct device_node *np;
> @@ -40,5 +58,6 @@ void clint_init_boot_cpu(void)
>  	riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
>  	riscv_time_val = base + CLINT_TIME_VAL_OFF;
>
> -	clint_clear_ipi(boot_cpu_hartid);
> +	clint_clear_ipi();
> +	riscv_set_ipi_ops(&clint_ipi_ops);
>  }
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f383ef5672b2..226ccce0f9e0 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -547,6 +547,18 @@ static inline long sbi_get_firmware_version(void)
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_VERSION);
>  }
>
> +static void sbi_send_cpumask_ipi(const struct cpumask *target)
> +{
> +	struct cpumask hartid_mask;
> +
> +	riscv_cpuid_to_hartid_mask(target, &hartid_mask);
> +
> +	sbi_send_ipi(cpumask_bits(&hartid_mask));
> +}
> +
> +static struct riscv_ipi_ops sbi_ipi_ops = {
> +	.ipi_inject = sbi_send_cpumask_ipi
> +};
>
>  int __init sbi_init(void)
>  {
> @@ -587,5 +599,7 @@ int __init sbi_init(void)
>  		__sbi_rfence	= __sbi_rfence_v01;
>  	}
>
> +	riscv_set_ipi_ops(&sbi_ipi_ops);
> +
>  	return 0;
>  }
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index b1d4f452f843..8b85683ce203 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -84,9 +84,25 @@ static void ipi_stop(void)
>  		wait_for_interrupt();
>  }
>
> +static struct riscv_ipi_ops *ipi_ops;
> +
> +void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
> +{
> +	ipi_ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
> +
> +void riscv_clear_ipi(void)
> +{
> +	if (ipi_ops && ipi_ops->ipi_clear)
> +		ipi_ops->ipi_clear();
> +
> +	csr_clear(CSR_IP, IE_SIE);
> +}
> +EXPORT_SYMBOL_GPL(riscv_clear_ipi);
> +
>  static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
>  {
> -	struct cpumask hartid_mask;
>  	int cpu;
>
>  	smp_mb__before_atomic();
> @@ -94,33 +110,22 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
>  		set_bit(op, &ipi_data[cpu].bits);
>  	smp_mb__after_atomic();
>
> -	riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
> -	if (IS_ENABLED(CONFIG_RISCV_SBI))
> -		sbi_send_ipi(cpumask_bits(&hartid_mask));
> +	if (ipi_ops && ipi_ops->ipi_inject)
> +		ipi_ops->ipi_inject(mask);
>  	else
> -		clint_send_ipi_mask(mask);
> +		pr_warn("SMP: IPI inject method not available\n");
>  }
>
>  static void send_ipi_single(int cpu, enum ipi_message_type op)
>  {
> -	int hartid = cpuid_to_hartid_map(cpu);
> -
>  	smp_mb__before_atomic();
>  	set_bit(op, &ipi_data[cpu].bits);
>  	smp_mb__after_atomic();
>
> -	if (IS_ENABLED(CONFIG_RISCV_SBI))
> -		sbi_send_ipi(cpumask_bits(cpumask_of(hartid)));
> -	else
> -		clint_send_ipi_single(hartid);
> -}
> -
> -static inline void clear_ipi(void)
> -{
> -	if (IS_ENABLED(CONFIG_RISCV_SBI))
> -		csr_clear(CSR_IP, IE_SIE);
> +	if (ipi_ops && ipi_ops->ipi_inject)
> +		ipi_ops->ipi_inject(cpumask_of(cpu));
>  	else
> -		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
> +		pr_warn("SMP: IPI inject method not available\n");
>  }
>
>  void handle_IPI(struct pt_regs *regs)
> @@ -131,7 +136,7 @@ void handle_IPI(struct pt_regs *regs)
>
>  	irq_enter();
>
> -	clear_ipi();
> +	riscv_clear_ipi();
>
>  	while (true) {
>  		unsigned long ops;
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 4e9922790f6e..5fe849791bf0 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -147,8 +147,7 @@ asmlinkage __visible void smp_callin(void)
>  {
>  	struct mm_struct *mm = &init_mm;
>
> -	if (!IS_ENABLED(CONFIG_RISCV_SBI))
> -		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
> +	riscv_clear_ipi();
>
>  	/* All kernel threads share the same mm context.  */
>  	mmgrab(mm);

I don't really care that much, though, so:

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
