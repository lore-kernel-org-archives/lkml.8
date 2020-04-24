Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED98C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BD520857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gy4e1DrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDXUrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgDXUrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:47:16 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE6C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:47:14 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c24so10876099uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeSr0lei+fRC9/QJxXSmPKueqlEcByGy/C+Sm2/krvg=;
        b=Gy4e1DrYdXOs9V95msoY1FVrKuSQ1ZhCKigCD3DdHYa4vQSZF0/wZGOzsXWdhDRQMJ
         ntjWHIAzoYQW/EbWleAXGSfEnaY3ZJ7a7cSARn7y8iNmYUhWJlNIe/hR5f+f+ETIthcj
         +7H9KyKHdOyYM6Yq87MOT6M0ttEfo85nWdehE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeSr0lei+fRC9/QJxXSmPKueqlEcByGy/C+Sm2/krvg=;
        b=NIjMtvWx1Ggz0GN4+18Wq8QYQVYznLUdxM4n8VkyNlv5fOzYO9FzC9sxIYOd9cbCkt
         FKpZQ9p3Grn0GVdfy9T5HmoFnAeihlLapk+h3YaTE+HsEsn8VQOZQUs0Ym07lig5gU3m
         EVtb/0b3JS8a0CmMYCQNpI1ZlmU2Tpdh0IPzo81VVwNJfK8yNeCrtz+oAm3Ar3Gvvlax
         Tdii5iqom/0yi7riMceqL9cU4ZSSrR8RoEHPZz25CeaU9CnvlJItP1tatgkQIB0mxVtZ
         09D6x0NLPBBBDa683PhJ24VdN/C9UmnduN02h+iVy4NtpKOw3ZSqVQI2aay+IRQOGqxz
         ADew==
X-Gm-Message-State: AGi0PubGTjd1Hn1RbLxOykO8Q9itsmQc4y1mSOsmwVMuP2+5PN2CODgf
        tgmJt+j04KFnQezvY/98iE9fdom4NhI=
X-Google-Smtp-Source: APiQypITkQIdsFy00Hd27mx8HtPMRNoAGkvIdyyKMcRfg3SdeHMg0YoYwTfn+EnHkeu8AEn05n3fJg==
X-Received: by 2002:a67:2247:: with SMTP id i68mr9117338vsi.19.1587761233275;
        Fri, 24 Apr 2020 13:47:13 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id v16sm1678906vsq.18.2020.04.24.13.47.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 13:47:12 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id z16so10884430uae.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:47:11 -0700 (PDT)
X-Received: by 2002:ab0:b13:: with SMTP id b19mr8989653uak.91.1587761231452;
 Fri, 24 Apr 2020 13:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org> <1587726554-32018-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1587726554-32018-5-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 13:46:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VSrVnx_R=Y38tQ=bw_o22zxWmm=+M+AaqmEMAtK66b-Q@mail.gmail.com>
Message-ID: <CAD=FV=VSrVnx_R=Y38tQ=bw_o22zxWmm=+M+AaqmEMAtK66b-Q@mail.gmail.com>
Subject: Re: [RFC Patch v1 4/4] arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, julien.thierry.kdev@gmail.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 4:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> leveraged to round up CPUs which are stuck in hard lockup state with
> interrupts disabled that wouldn't be possible with a normal IPI.
>
> So instead switch to round up CPUs using IPI_CALL_NMI_FUNC. And in
> case a particular arm64 platform doesn't supports pseudo NMIs,
> IPI_CALL_NMI_FUNC will act as a normal IPI which maintains existing
> kgdb functionality.
>
> Also, one thing to note here is that with CPUs running in NMI context,
> kernel has special handling for printk() which involves CPU specific
> buffers and defering printk() until exit from NMI context. But with kgdb
> we don't want to defer printk() especially backtrace on corresponding
> CPUs. So switch to normal printk() context instead prior to entering
> kgdb context.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/kernel/kgdb.c | 15 +++++++++++++++
>  arch/arm64/kernel/smp.c  | 17 ++++++++++++++---
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 4311992..0851ead 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -14,6 +14,7 @@
>  #include <linux/kgdb.h>
>  #include <linux/kprobes.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/smp.h>
>
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
> @@ -353,3 +354,17 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>         return aarch64_insn_write((void *)bpt->bpt_addr,
>                         *(u32 *)bpt->saved_instr);
>  }
> +
> +#ifdef CONFIG_SMP
> +void kgdb_roundup_cpus(void)
> +{
> +       struct cpumask mask;
> +
> +       cpumask_copy(&mask, cpu_online_mask);
> +       cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> +       if (cpumask_empty(&mask))
> +               return;
> +
> +       arch_send_call_nmi_func_ipi_mask(&mask);
> +}
> +#endif
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 27c8ee1..c7158f6e8 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -31,6 +31,7 @@
>  #include <linux/of.h>
>  #include <linux/irq_work.h>
>  #include <linux/kexec.h>
> +#include <linux/kgdb.h>
>  #include <linux/kvm_host.h>
>
>  #include <asm/alternative.h>
> @@ -976,9 +977,19 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>                 /* Handle it as a normal interrupt if not in NMI context */
>                 if (!in_nmi())
>                         irq_enter();
> -
> -               /* nop, IPI handlers for special features can be added here. */
> -
> +#ifdef CONFIG_KGDB

My vote would be to keep "ifdef"s out of the middle of functions.  Can
you put your code in "arch/arm64/kernel/kgdb.c" and then have a dummpy
no-op function if "CONFIG_KGDB" isn't defined?


> +               if (atomic_read(&kgdb_active) != -1) {
> +                       /*
> +                        * For kgdb to work properly, we need printk to operate
> +                        * in normal context.
> +                        */
> +                       if (in_nmi())
> +                               printk_nmi_exit();

It feels like all the printk management belongs in kgdb_nmicallback().
...or is there some reason that this isn't a problem for other
platforms using NMI?  Maybe it's just that nobody has noticed it yet?


> +                       kgdb_nmicallback(raw_smp_processor_id(), regs);

Why do you need to call raw_smp_processor_id()?  Are you expecting a
different value than the local variable "cpu"?


> +                       if (in_nmi())
> +                               printk_nmi_enter();
> +               }
> +#endif
>                 if (!in_nmi())
>                         irq_exit();
>                 break;

Not that I really know what I'm talking about since I really don't
know arm64 at this level very well, but I'll ask anyway and probably
look like a fool...  I had a note that said:

* Will Deacon says:
*
* the whole roundup code is sketchy and it's the only place in the kernel
* which tries to perform I-cache maintenance with irqs disabled, leading
* to this nasty hack in the arch code:
*
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/cacheflush.h#n74

I presume that, if nothing else, the comment needs to be updated.
...but is the situation any better (or worse?) with your new solution?

-Doug
