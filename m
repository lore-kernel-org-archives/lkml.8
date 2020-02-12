Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CFC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C4D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="g+YTRJuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBLE5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:57:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45264 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgBLE5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:57:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so514884wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 20:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BmVz8M0DHmO6ndjWhbEydu5XNnhgxAMx801ictogH0=;
        b=g+YTRJuo4tDXTnbiJgTSMYfeGIYy0IZgZjoegtGBMTBYJ4RqZJKGPGRD0Hbshg0GTD
         n7I8FpIAqlet+MD0Eg7vZESGIPtvUKp0OdawI5mZrRLsDoFFSSOYbh43owWApRSv9gpd
         TEeOHmrM0K40AFVUOMSootpcheA7qapdssRmyEKAsv+nad4+fDeGeC+sMYLO9apAhRmI
         RWU0fUYQyYvfI0KwV1FqfXXNNLIM3c92O/iV8Q8JwNB4M0YWrB8pzrPJHS47bNmq89nj
         FrS40WdVYxWQdqPrjIsa8xTUkpNvDp+9yfx3DdeHplCgbbpks87nXggmdNo6uKv0eNhA
         XOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BmVz8M0DHmO6ndjWhbEydu5XNnhgxAMx801ictogH0=;
        b=a3rIj8w3NIazZTpQuRrtwcVbKl4rRj3krxYNmn4YQsyJlsJgjmTDC27VQH+7PtuxYc
         GWMJ8V1Hv4OlgWRMtdIIU5PMLYYATOKzJYWnhXvrBKmY/IpkZFltQXGSHzRY5j+2J/ho
         u6KwsI0D2umMVvqMJDLV2jXzWRwa16mn3fE6v6iJvaJZ8rLbPPEpCmFClUknH64K+N1m
         T7K3XxWGWjzM3B28HKbRDimCvCG6Gou4828C25a4RSsbumKRlbVZp7DfXmWjsJIVDMv5
         iiWirbmhcPBHEs1ZssRDOPhpe9ECa8PgSTqIdizj5aqKIWkaA+ZsLTmhGw36rTRtw30l
         5xvw==
X-Gm-Message-State: APjAAAXckX6smVq54uOyZUHc4MO3cEOQ/wRZmFfL/qHYQBtVkxSRoCQ0
        7G+b6oFUY7KDMdPvKkwC9f9hJZ8DazMZ0Pn8hh9DdrzpyoE=
X-Google-Smtp-Source: APXvYqy/7JQfNq07kkVhnyCwlxFDKokr2LfQNOtJeWVVKaLF1GsIn0y4auWMosXK2ZaUHdNANRoG+bk1SFgRtjSZGik=
X-Received: by 2002:adf:f28f:: with SMTP id k15mr12564779wro.230.1581483439490;
 Tue, 11 Feb 2020 20:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-1-atish.patra@wdc.com> <20200212014822.28684-10-atish.patra@wdc.com>
In-Reply-To: <20200212014822.28684-10-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Feb 2020 10:27:08 +0530
Message-ID: <CAAhSdy0qK+MC4+Yu6OM20XwzrAennzyi68SOmkC5KAzPJOqTng@mail.gmail.com>
Subject: Re: [PATCH v8 09/11] RISC-V: Add supported for ordered booting method
 using HSM
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:21 AM Atish Patra <atish.patra@wdc.com> wrote:
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
> ---
>  arch/riscv/kernel/cpu_ops.c     | 10 +++++++++-
>  arch/riscv/kernel/cpu_ops_sbi.c | 31 +++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S        | 26 ++++++++++++++++++++++++++
>  arch/riscv/kernel/smpboot.c     |  2 +-
>  arch/riscv/kernel/traps.c       |  2 +-
>  5 files changed, 68 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index 1085def3735a..6221bbedaea4 100644
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
> @@ -34,7 +35,14 @@ void cpu_update_secondary_bootdata(unsigned int cpuid,
>
>  int __init cpu_set_ops(int cpuid)
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
>
>         return 0;
>  }
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index 9bdb60e0a4df..31487a80c3b8 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -7,9 +7,13 @@
>
>  #include <linux/init.h>
>  #include <linux/mm.h>
> +#include <asm/cpu_ops.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
>
> +extern char secondary_start_sbi[];
> +const struct cpu_operations cpu_ops_sbi;
> +
>  static int sbi_hsm_hart_stop(void)
>  {
>         struct sbiret ret;
> @@ -46,3 +50,30 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
>         else
>                 return ret.value;
>  }
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
> index c1be597d22a1..8386cfafba98 100644
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
> index 2ee41c779a16..2c56ac70e64d 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -146,7 +146,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  /*
>   * C entry point for a secondary processor.
>   */
> -asmlinkage __visible void __init smp_callin(void)
> +asmlinkage __visible void smp_callin(void)
>  {
>         struct mm_struct *mm = &init_mm;
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f4cad5163bf2..0063dd7318d6 100644
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
> --
> 2.24.0
>

Overall, this patch looks good but SBI HSM helper functions
from PATCH8 should be moved to this patch.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
