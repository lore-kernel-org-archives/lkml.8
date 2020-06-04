Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79544C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526BC204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ehCLDs/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgFDUk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgFDUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:40:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57FC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:40:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so1735155pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tOm0eZIfTixCIuiiTONw0d8MpMY0xEkqqW2K4o8xHYE=;
        b=ehCLDs/32BzqqIn6f6SwjjPXO9KP3vf55FjWqEqklC4xvw5E7bMZa28s8uQSfCBeNz
         L6dc1ieExL+7vlLqmQ0/lyOp2M4ICnoKOWoQvXEaknRAN8tmhLq/WVMAQeeXBMcjP9D6
         3RuWyPaMG4tHZr8xq62MEA3JBDrJ1g6UIEkUgeLhrAUOSG253UV6VUVCsz31sJI5stXg
         utocO4or8BMGQh9E85ibZom/QdW9WYGw2UJ20S0rR5ua2KHAJG3IFHDoxVmtjCcO4p+k
         c2wX8Uz9hvNyy5I0BNAByB6m5FIsQVJ+Mjb0dZIJn3gtPpuM7UX4nvapcwYn3Ftp45K9
         3+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tOm0eZIfTixCIuiiTONw0d8MpMY0xEkqqW2K4o8xHYE=;
        b=N9hsq77pQZR8LQwXAjKqMSUh3elB3hg4Dsxdei8lqm8M5n+LSHiu9iEtZJlKLhdhvc
         SQPPCw8yVFywzL8/xAc8QGQhEl+t7wNgdVW7EZM7qVRK+pfgQroeBffYbjwGhjRrLdtf
         P1hhvsE42/0HxNXwZ6ZdJgCsCf2JoNnI2FN6/mYMC2N3GSH0080PwL5K1n7HVldUQWgv
         JtIxqB62rm1M9yravyv60HDOgcmxFpHHOxjC4zlK35W6H2nplWHD4+VFP4tYJE9bYkgS
         cabFqCDFbJuEMCAuWTwPlswss79kc6eaELQHuszwdQQwxMLnw+qMKAbEj15l6xgMnouK
         vz2A==
X-Gm-Message-State: AOAM531yfHPfHgrqYtYxz3CYhAPe1ToGntsdyBjzH3w1a9natlbh2eUg
        kuuZJB6TJHx4y9Zdeokq5snUOw==
X-Google-Smtp-Source: ABdhPJxsUSVVLwoV7LD89QZpLzQIKaoFTH88mEntDFRWMQpU65Q7OY9mgUqGNYJzYOPQBFPLR4GHyQ==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr6626139plk.45.1591303219131;
        Thu, 04 Jun 2020 13:40:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e78sm5378955pfh.50.2020.06.04.13.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:40:18 -0700 (PDT)
Date:   Thu, 04 Jun 2020 13:40:18 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jun 2020 13:27:53 PDT (-0700)
Subject:     Re: [PATCH 2/5] RISC-V: Remove CLINT related code
In-Reply-To: <20200521134544.816918-3-anup.patel@wdc.com>
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
Message-ID: <mhng-f2e4aecb-a19b-4d20-9a48-9640bd9d264d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 06:45:41 PDT (-0700), Anup Patel wrote:
> We will be having separate CLINT timer driver which will also
> provide CLINT based IPI operations so let's remove CLINT related
> code from arch/riscv directory.

This will leave the system unbootable, which breaks bisecting.

>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/clint.h | 39 ------------------------------
>  arch/riscv/kernel/Makefile     |  2 +-
>  arch/riscv/kernel/clint.c      | 44 ----------------------------------
>  arch/riscv/kernel/setup.c      |  2 --
>  arch/riscv/kernel/smp.c        |  1 -
>  arch/riscv/kernel/smpboot.c    |  1 -
>  6 files changed, 1 insertion(+), 88 deletions(-)
>  delete mode 100644 arch/riscv/include/asm/clint.h
>  delete mode 100644 arch/riscv/kernel/clint.c
>
> diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
> deleted file mode 100644
> index a279b17a6aad..000000000000
> --- a/arch/riscv/include/asm/clint.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_RISCV_CLINT_H
> -#define _ASM_RISCV_CLINT_H 1
> -
> -#include <linux/io.h>
> -#include <linux/smp.h>
> -
> -#ifdef CONFIG_RISCV_M_MODE
> -extern u32 __iomem *clint_ipi_base;
> -
> -void clint_init_boot_cpu(void);
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
> -#else /* CONFIG_RISCV_M_MODE */
> -#define clint_init_boot_cpu()	do { } while (0)
> -
> -/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_M_MODE): */
> -void clint_send_ipi_single(unsigned long hartid);
> -void clint_send_ipi_mask(const struct cpumask *hartid_mask);
> -void clint_clear_ipi(unsigned long hartid);
> -#endif /* CONFIG_RISCV_M_MODE */
> -
> -#endif /* _ASM_RISCV_CLINT_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index d8bbd3207100..529cda705cfe 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -31,7 +31,7 @@ obj-y	+= cacheinfo.o
>  obj-y	+= patch.o
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>
> -obj-$(CONFIG_RISCV_M_MODE)	+= clint.o traps_misaligned.o
> +obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
>  obj-$(CONFIG_FPU)		+= fpu.o
>  obj-$(CONFIG_SMP)		+= smpboot.o
>  obj-$(CONFIG_SMP)		+= smp.o
> diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
> deleted file mode 100644
> index 3647980d14c3..000000000000
> --- a/arch/riscv/kernel/clint.c
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2019 Christoph Hellwig.
> - */
> -
> -#include <linux/io.h>
> -#include <linux/of_address.h>
> -#include <linux/types.h>
> -#include <asm/clint.h>
> -#include <asm/csr.h>
> -#include <asm/timex.h>
> -#include <asm/smp.h>
> -
> -/*
> - * This is the layout used by the SiFive clint, which is also shared by the qemu
> - * virt platform, and the Kendryte KD210 at least.
> - */
> -#define CLINT_IPI_OFF		0
> -#define CLINT_TIME_CMP_OFF	0x4000
> -#define CLINT_TIME_VAL_OFF	0xbff8
> -
> -u32 __iomem *clint_ipi_base;
> -
> -void clint_init_boot_cpu(void)
> -{
> -	struct device_node *np;
> -	void __iomem *base;
> -
> -	np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
> -	if (!np) {
> -		panic("clint not found");
> -		return;
> -	}
> -
> -	base = of_iomap(np, 0);
> -	if (!base)
> -		panic("could not map CLINT");
> -
> -	clint_ipi_base = base + CLINT_IPI_OFF;
> -	riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
> -	riscv_time_val = base + CLINT_TIME_VAL_OFF;
> -
> -	clint_clear_ipi(boot_cpu_hartid);
> -}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 145128a7e560..b07a583bf53b 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -18,7 +18,6 @@
>  #include <linux/swiotlb.h>
>  #include <linux/smp.h>
>
> -#include <asm/clint.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/setup.h>
>  #include <asm/sections.h>
> @@ -76,7 +75,6 @@ void __init setup_arch(char **cmdline_p)
>  	setup_bootmem();
>  	paging_init();
>  	unflatten_device_tree();
> -	clint_init_boot_cpu();
>
>  #ifdef CONFIG_SWIOTLB
>  	swiotlb_init(1);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 8375cc5970f6..8a23f1eb5400 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -17,7 +17,6 @@
>  #include <linux/seq_file.h>
>  #include <linux/delay.h>
>
> -#include <asm/clint.h>
>  #include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 5fe849791bf0..a6cfa9842d4b 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -24,7 +24,6 @@
>  #include <linux/of.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/mm.h>
> -#include <asm/clint.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
