Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F392C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A18220672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRs/nNGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgDEOha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:30 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43442 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgDEOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:28 -0400
Received: by mail-yb1-f196.google.com with SMTP id o70so7260879ybg.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPl+IHdcVn1TB1GXPgMKawn91+x0o4Xt5I0OdRzvmhQ=;
        b=TRs/nNGZ4E648PLF071Ign9oS2ESjRL2kbLERqr/1aIFa/agtabbekyVm878CFWYZo
         wfhT7r/pzzYneSvkwLf7LFc9QYVBbBnYRIwfHAvttjlXL3cytpTYsMOTfVHTr+rJSpNX
         tzX4/5Qcl3mXlxUMtWdxmg7LZAGzemlTYPRHq5JGsss8POuzaeWq5Rc19sSFmcA1JBYz
         0fYkMxwkGKyOv/MJx0dgt6kj3ZB09Ne7CDv2+sZb8iSCGJ5ji2OzwmImh5xsOMWUmR0u
         oaQGNN6kszVY8UMn1VfBWthOBBFNKma2wqS6aywfp82dsOmuRGQ/45jCDhR07//DFX7w
         gbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPl+IHdcVn1TB1GXPgMKawn91+x0o4Xt5I0OdRzvmhQ=;
        b=XX0JP49+rLXQ2bmt7cgkkQ5D+i1j3hs7sCFURTYFoxvXWk2vI0BLvrShze5RNpB5dC
         0cyY4/8jxTinGpGqOEOZfT6aMGTPxo5WXKVOp50Pz6rxLJ/MdSW/86Wfxvw16gZnZKXD
         ZZoY4yK6nfnD9uoBjN5xGMdXMvnqtX6HTHfnu7oA/0c6UqUIUaUe7bWvChEe9ipra21a
         HB3ONpA6ozpL+5p1a4J3InsJnODsflk6bi6njCFLF3WzGL5j0kVeXsa6m3Zc+g7tuVxb
         gJUgn+D48RA54NM0vxm17CMChQgA8iAngqw4p6j+OTFG0aonodARZPAVtA+pO90KVcoD
         M6vg==
X-Gm-Message-State: AGi0PuZkdEa45vbxMr0Dh85fQcg4/sdsSalKrmItffHJ3bwrzYbh8k0u
        Y1u6XPlNL4+D2MDSJ8Vq+HuKgE3aPx6nXtbAYGY=
X-Google-Smtp-Source: APiQypKVuU6DUdGgqSzQWBoo/pI/e/1si2J5wKnlYwhTfZYinumdTxF8xc9Pm3nd7k6KBBmrKP3kGauLQpnTRtj1DmM=
X-Received: by 2002:a25:8006:: with SMTP id m6mr25749193ybk.154.1586097447184;
 Sun, 05 Apr 2020 07:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-11-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-11-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:37:16 +0800
Message-ID: <CAEUhbmUiBQ-EkaSTmb9azM-SOvUhpfCvhWvJy02Xix+opf3E8g@mail.gmail.com>
Subject: Re: [PATCH v11 10/11] RISC-V: Add supported for ordered booting
 method using HSM
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:12 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, all harts have to jump Linux in RISC-V. This complicates the
> multi-stage boot process as every transient stage also has to ensure all
> harts enter to that stage and jump to Linux afterwards. It also obstructs
> a clean Kexec implementation.
>
> SBI HSM extension provides alternate solutions where only a single hart
> need to boot and enter Linux. The booting hart can bring up secondary
> harts one by one afterwards.
>
> Add SBI HSM based cpu_ops that implements an ordered booting method in
> RISC-V. This change is also backward compatible with older firmware not
> implementing HSM extension. If a latest kernel is used with older
> firmware, it will continue to use the default spinning booting method.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/kernel/Makefile      |  3 ++
>  arch/riscv/kernel/cpu_ops.c     | 10 +++-
>  arch/riscv/kernel/cpu_ops_sbi.c | 81 +++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S        | 26 +++++++++++
>  arch/riscv/kernel/smpboot.c     |  2 +-
>  arch/riscv/kernel/traps.c       |  2 +-
>  6 files changed, 121 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f81a6ff88005..a0be34b96846 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -44,5 +44,8 @@ obj-$(CONFIG_PERF_EVENTS)     += perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                += sbi.o
> +ifeq ($(CONFIG_RISCV_SBI), y)
> +obj-$(CONFIG_SMP) += cpu_ops_sbi.o
> +endif
>
>  clean:
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index 62705908eee5..c4c33bf02369 100644
> --- a/arch/riscv/kernel/cpu_ops.c
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -18,6 +18,7 @@ const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
>  void *__cpu_up_stack_pointer[NR_CPUS];
>  void *__cpu_up_task_pointer[NR_CPUS];
>
> +extern const struct cpu_operations cpu_ops_sbi;
>  extern const struct cpu_operations cpu_ops_spinwait;
>
>  void cpu_update_secondary_bootdata(unsigned int cpuid,
> @@ -34,5 +35,12 @@ void cpu_update_secondary_bootdata(unsigned int cpuid,
>
>  void __init cpu_set_ops(int cpuid)
>  {
> -       cpu_ops[cpuid] = &cpu_ops_spinwait;
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +       if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
> +               if (!cpuid)
> +                       pr_info("SBI v0.2 HSM extension detected\n");
> +               cpu_ops[cpuid] = &cpu_ops_sbi;
> +       } else
> +#endif
> +               cpu_ops[cpuid] = &cpu_ops_spinwait;
>  }
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> new file mode 100644
> index 000000000000..66f3cded91f5
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HSM extension and cpu_ops implementation.
> + *
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/sbi.h>
> +#include <asm/smp.h>
> +
> +extern char secondary_start_sbi[];
> +const struct cpu_operations cpu_ops_sbi;
> +
> +static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
> +                             unsigned long priv)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_START,
> +                       hartid, saddr, priv, 0, 0, 0);
> +       if (ret.error)
> +               return sbi_err_map_linux_errno(ret.error);
> +       else
> +               return 0;
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static int sbi_hsm_hart_stop(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STOP, 0, 0, 0, 0, 0, 0);
> +
> +       if (ret.error)
> +               return sbi_err_map_linux_errno(ret.error);
> +       else
> +               return 0;
> +}
> +
> +static int sbi_hsm_hart_get_status(unsigned long hartid)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STATUS,
> +                       hartid, 0, 0, 0, 0, 0);
> +       if (ret.error)
> +               return sbi_err_map_linux_errno(ret.error);
> +       else
> +               return ret.value;
> +}
> +#endif
> +
> +static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
> +{
> +       int rc;
> +       unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
> +       int hartid = cpuid_to_hartid_map(cpuid);
> +
> +       cpu_update_secondary_bootdata(cpuid, tidle);
> +       rc = sbi_hsm_hart_start(hartid, boot_addr, 0);
> +
> +       return rc;
> +}
> +
> +static int sbi_cpu_prepare(unsigned int cpuid)
> +{
> +       if (!cpu_ops_sbi.cpu_start) {
> +               pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
> +               return -ENODEV;
> +       }
> +       return 0;
> +}
> +
> +const struct cpu_operations cpu_ops_sbi = {
> +       .name           = "sbi",
> +       .cpu_prepare    = sbi_cpu_prepare,
> +       .cpu_start      = sbi_cpu_start,
> +};
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 173507395a6b..e5115d5e0b3a 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -99,11 +99,37 @@ relocate:
>         ret
>  #endif /* CONFIG_MMU */
>  #ifdef CONFIG_SMP
> +       .global secondary_start_sbi
> +secondary_start_sbi:
> +       /* Mask all interrupts */
> +       csrw CSR_IE, zero
> +       csrw CSR_IP, zero
> +
> +       /* Load the global pointer */
> +       .option push
> +       .option norelax
> +               la gp, __global_pointer$

Is this line's indentation level intended?

> +       .option pop
> +
> +       /*
> +        * Disable FPU to detect illegal usage of
> +        * floating point in kernel space
> +        */
> +       li t0, SR_FS
> +       csrc CSR_STATUS, t0
> +
>         /* Set trap vector to spin forever to help debug */
>         la a3, .Lsecondary_park
>         csrw CSR_TVEC, a3
>
>         slli a3, a0, LGREG
> +       la a4, __cpu_up_stack_pointer
> +       la a5, __cpu_up_task_pointer
> +       add a4, a3, a4
> +       add a5, a3, a5
> +       REG_L sp, (a4)
> +       REG_L tp, (a5)
> +
>         .global secondary_start_common
>  secondary_start_common:
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index e89396a2a1af..4e9922790f6e 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -143,7 +143,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  /*
>   * C entry point for a secondary processor.
>   */
> -asmlinkage __visible void __init smp_callin(void)
> +asmlinkage __visible void smp_callin(void)
>  {
>         struct mm_struct *mm = &init_mm;
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index ffb3d94bf0cc..8e13ad45ccaa 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -147,7 +147,7 @@ int is_valid_bugaddr(unsigned long pc)
>  }
>  #endif /* CONFIG_GENERIC_BUG */
>
> -void __init trap_init(void)
> +void trap_init(void)
>  {
>         /*
>          * Set sup0 scratch register to 0, indicating to exception vector

Should the above 2 be moved to patch [06/11] RISC-V: Move relocate and
few other functions out of __init ?

Other than that,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
