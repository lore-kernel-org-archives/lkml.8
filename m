Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E913C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D2C204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="DfIDgntu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgFDUkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgFDUkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:40:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A6C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:40:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so1735469pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sSwds6Mehfdl4NuqZWFemzPG2moYmBqluiH61i1DVVs=;
        b=DfIDgntuJl5g51HnSaY62dK/6YhbXj8X8+YJ6rmu3TSDzKHAN/2lW3imL53i8yFWk6
         iDQbDGHhZBmL2FzkSCdMYjXwtTn6HKYiVOrUqIlfXMzgf7d2uEfcRZSjhuO0KeVwyGxL
         HroFlPslvCldax5Aq3QMb9v8/j3s9Sj6KmCwBWx00oniLLIlMV9UL99BOcHZWntJoPHt
         PdcTPI0FTj3t9qC83vCnFTNvaU5pgOxIz2Gqrf+tT86bdkfeTzdsVIeAlHWpZhCvxYza
         U/ucwBwbpy9Wc32v7ejOGHWwKWMdQ4JzCkcuKvczhFwXtQjnWy45PtkYsDXX3UdcxAh7
         Iwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sSwds6Mehfdl4NuqZWFemzPG2moYmBqluiH61i1DVVs=;
        b=sHH72011SrfGpwprZqHIVSwfTpPPnL5MjNQnDpmkbCyGREUvO3Dk27NKqVoAdahUlU
         Ehjhys+bj/jUbvpOCghn57WVEfJi/4pI0cMe32vmrYrncirXCoU/zwI5M/KzLZ0qTUq7
         4gRREVolDgjRD2khUjHVKowMsvcmD8jdx3/EozulsG7FJOak7t8jsEnqyCI2/v/4UVsg
         S3ZcwcHDsKxwHLl18g558nEAxjZSX7ozImKCbwaD0I/6ediylJaXnMTn1xtRYWnfaHf3
         UolgJXY9AswOqtGs/sNefkgSGDZJoxtH6p8zcxuOp/f/6l5vZBSbe+ON3GlOquabOtOA
         3xDw==
X-Gm-Message-State: AOAM530p4DsTsVjZ2mlOm+tB0ca+B2WqmnPmUac1AKc5E6HxZSYEMnQN
        jO6znHqkYWaRzbyGG3jszhY3/Q==
X-Google-Smtp-Source: ABdhPJyEO+B4REHxl9bA1UQTuNCX9YLrasiTTCNpbKpwy1NuHpMqc4or97YOkoZxgWeBU20CRjL5Lg==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr6448631plt.66.1591303217628;
        Thu, 04 Jun 2020 13:40:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 3sm5192023pfe.85.2020.06.04.13.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:40:17 -0700 (PDT)
Date:   Thu, 04 Jun 2020 13:40:17 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jun 2020 13:26:30 PDT (-0700)
Subject:     Re: [PATCH 1/5] RISC-V: Add mechanism to provide custom IPI operations
In-Reply-To: <20200521134544.816918-2-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-b031fd3d-c966-4973-a94d-3307d11b44d5@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 06:45:40 PDT (-0700), Anup Patel wrote:
> We add mechanism to set custom IPI operations so that CLINT driver
> from drivers directory can provide custom IPI operations.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/smp.h | 11 ++++++++
>  arch/riscv/kernel/smp.c      | 52 ++++++++++++++++++++++++------------
>  arch/riscv/kernel/smpboot.c  |  3 +--
>  3 files changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 40bb1c15a731..ad0601260cb1 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -40,6 +40,17 @@ void arch_send_call_function_single_ipi(int cpu);
>  int riscv_hartid_to_cpuid(int hartid);
>  void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>
> +struct riscv_ipi_ops {
> +	void (*ipi_inject)(const unsigned long *hart_mask);
> +	void (*ipi_clear)(void);
> +};
> +
> +/* Set custom IPI operations */
> +void riscv_set_ipi_ops(struct riscv_ipi_ops *ops);
> +
> +/* Clear IPI for current CPU */
> +void riscv_clear_ipi(void);
> +
>  /*
>   * Obtains the hart ID of the currently executing task.  This relies on
>   * THREAD_INFO_IN_TASK, but we define that unconditionally.
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index b1d4f452f843..8375cc5970f6 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -84,6 +84,35 @@ static void ipi_stop(void)
>  		wait_for_interrupt();
>  }
>
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +static void clear_ipi(void)
> +{
> +	csr_clear(CSR_IP, IE_SIE);
> +}
> +
> +static struct riscv_ipi_ops sbi_ipi_ops = {
> +	.ipi_inject = sbi_send_ipi,
> +	.ipi_clear = clear_ipi,
> +};
> +
> +static struct riscv_ipi_ops *ipi_ops = &sbi_ipi_ops;
> +#else
> +static struct riscv_ipi_ops *ipi_ops;
> +#endif
> +
> +void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
> +{
> +	ipi_ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
> +
> +void riscv_clear_ipi(void)
> +{
> +	if (ipi_ops)
> +		ipi_ops->ipi_clear();
> +}
> +EXPORT_SYMBOL_GPL(riscv_clear_ipi);

There should at least be a warning on SMP systems when an ipi_ops hasn't been
set, as otherwise the system will just hang.

> +
>  static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
>  {
>  	struct cpumask hartid_mask;
> @@ -95,10 +124,9 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
>  	smp_mb__after_atomic();
>
>  	riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
> -	if (IS_ENABLED(CONFIG_RISCV_SBI))
> -		sbi_send_ipi(cpumask_bits(&hartid_mask));
> -	else
> -		clint_send_ipi_mask(mask);
> +
> +	if (ipi_ops)
> +		ipi_ops->ipi_inject(cpumask_bits(&hartid_mask));
>  }
>
>  static void send_ipi_single(int cpu, enum ipi_message_type op)
> @@ -109,18 +137,8 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
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
> -	else
> -		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
> +	if (ipi_ops)
> +		ipi_ops->ipi_inject(cpumask_bits(cpumask_of(hartid)));
>  }
>
>  void handle_IPI(struct pt_regs *regs)
> @@ -131,7 +149,7 @@ void handle_IPI(struct pt_regs *regs)
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
