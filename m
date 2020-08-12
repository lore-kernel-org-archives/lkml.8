Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA13206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="MtrgH4e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHLB5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLB5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:57:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 18:57:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so436511wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCc2Gl+2ZTzj2s1NxZep6jFJoKEN1M3r6ckrO/cMZEo=;
        b=MtrgH4e68InVhMQvBNFrmb+HAGSNG13qFb8CyTSJCmb0k9WC6LJcTKtaurJ0h3bvtg
         we1YeNt+fVkQP1vC+8nGUh4yG83PbqsRs0TSMDuLPfAzjWJE6WJxx8fVU2c0aGZ6hdoL
         yJLVsnpfeCe+xo3I/82ccIopkEGlV2XWig7rcszlLgSCN/gZusb8Tqne1dh7h9eibUWx
         7VGxjHoBxqU+FYo7AhSEzTJJ0XawChqTtaMgsXcUyGHCZOEm21qxM+WyRfVKarc6w8Q1
         A7qiCllGLKTyFma03Pe0vd1Al9TuWVFnd2BXJAE6MlXXCo3+UL+EQsAkcnQqiGyWm4GL
         Npxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCc2Gl+2ZTzj2s1NxZep6jFJoKEN1M3r6ckrO/cMZEo=;
        b=jwNspxi+UABr9AlhaTaHwC2uSjynRK8fJuw3m0D83w/tJIQGBhIXup/teXOMCQEaFf
         VsSf0JusPGhRMD2LWV4uGCPWfn0Jv+dZLR2Mxwh69x5EkrBgHCkzT/4OXZq9eSKiGJTP
         6l+fQtCfBbL80aed2iiKpyYaTcvULBYMEkAuVzzT+sqN4+VijCx76sBWXCX3LN9iWnhV
         /ewGH86nUU7Jg7LkvryqM6o9ni/2ObB59peWz2Zz0vpKMuL4FzyjWBb/p1k0v04lpTPa
         OTCNz6G8MI9s1vIprDRyVU7ChNNF4d7OwKWPduXNR8SyzevTC3m0f0zWoc00QLKhuZ7K
         7Zgw==
X-Gm-Message-State: AOAM533xEC4fJcDD35piGkaohV/4Q55wuI1btmRPjXzqtmeqj0dNFAvZ
        bbamk/rUFddp27lZtlPASX12rb3SrU7rJKjebBnGCA==
X-Google-Smtp-Source: ABdhPJz95b1SCywW9YKLXjnSml+205qMM5HwcHslPl1JunI9ijY6bMGsFm70gRZfhcgms4KMTm0evXHaUy55A+Kolas=
X-Received: by 2002:a1c:9c91:: with SMTP id f139mr6595552wme.134.1597197458091;
 Tue, 11 Aug 2020 18:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
 <CAAhSdy1c=R6aUZ6EOggmJ_Bqm2O0VLKEku=zyFfabExSzOKErA@mail.gmail.com> <CAOnJCUJiLVyzMFkn157Zmdrtm66Z=gWmQbXCJiMRY8LCJ3xkaw@mail.gmail.com>
In-Reply-To: <CAOnJCUJiLVyzMFkn157Zmdrtm66Z=gWmQbXCJiMRY8LCJ3xkaw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Aug 2020 07:27:26 +0530
Message-ID: <CAAhSdy0yV154R9EBbmQqR6mN-U7j02hGto76k+PY0W6xpJMW_A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Setup exception vector for K210 properly
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:16 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Tue, Aug 11, 2020 at 1:41 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Tue, Aug 11, 2020 at 12:07 PM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
> > >
> > > Exception vector is missing on nommu platform and it is a big issue.
> > > This patch is tested in Sipeed MAIX Bit Dev Board.
> > >
> > > Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
> > > Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
>
> Thanks for testing it on the kendryte board.
>
> > > ---
> > >  arch/riscv/kernel/smpboot.c |  1 +
> > >  arch/riscv/kernel/traps.c   | 11 ++++++++++-
> > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > > index 356825a57551..23cde0ceb39d 100644
> > > --- a/arch/riscv/kernel/smpboot.c
> > > +++ b/arch/riscv/kernel/smpboot.c
> > > @@ -154,6 +154,7 @@ asmlinkage __visible void smp_callin(void)
> > >         mmgrab(mm);
> > >         current->active_mm = mm;
> > >
> > > +       trap_init();
> > >         notify_cpu_starting(curr_cpuid);
> > >         update_siblings_masks(curr_cpuid);
> > >         set_cpu_online(curr_cpuid, 1);
> > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > index ad14f4466d92..a390239818ae 100644
> > > --- a/arch/riscv/kernel/traps.c
> > > +++ b/arch/riscv/kernel/traps.c
> > > @@ -174,7 +174,16 @@ int is_valid_bugaddr(unsigned long pc)
> > >  }
> > >  #endif /* CONFIG_GENERIC_BUG */
> > >
> > > -/* stvec & scratch is already set from head.S */
> > > +/* stvec & scratch is already set from head.S when mmu is enabled */
> > >  void trap_init(void)
> > >  {
> > > +#ifndef CONFIG_MMU
> > > +       /*
> > > +        * Set sup0 scratch register to 0, indicating to exception vector
> > > +        * that we are presently executing in the kernel
> > > +        */
> > > +       csr_write(CSR_SCRATCH, 0);
> > > +       /* Set the exception vector address */
> > > +       csr_write(CSR_TVEC, &handle_exception);
> > > +#endif
> > >  }
> > > --
> > > 2.28.0
> > >
> >
> > This issue seems to be only on the latest master branch of
> > Linux stable tree so this fix need not be a stable fix.
> >
> > For MMU kernel, the CSR_TVEC is setup in relocate() function
> > called from secondary_start_common() function of head.S
> >
> > For NoMMU kernel, we should set CSR_TVEC directly in
> > secondary_start_common() function as "#else" case of the
> > "#ifdef CONFIG_MMU".
> >
>
> That would enable the trap only for secondary harts. But the exception
> vector on boot hart
> is still uninitialized. How about this change ?
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index d0c5c316e9bb..7822054dbd88 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -77,16 +77,6 @@ relocate:
>         csrw CSR_SATP, a0
>  .align 2
>  1:
> -       /* Set trap vector to exception handler */
> -       la a0, handle_exception
> -       csrw CSR_TVEC, a0
> -
> -       /*
> -        * Set sup0 scratch register to 0, indicating to exception vector that
> -        * we are presently executing in kernel.
> -        */
> -       csrw CSR_SCRATCH, zero
> -

Instead of having no trap vector setup here, we should
at least have dummy trap vector (just like original code).

/* Set trap vector to spin forever to help debug */
la a0, .Lsecondary_park
csrw CSR_TVEC, a0

>         /* Reload the global pointer */
>  .option push
>  .option norelax
> @@ -144,9 +134,23 @@ secondary_start_common:
>         la a0, swapper_pg_dir
>         call relocate
>  #endif
> +       call setup_trap_vector
>         tail smp_callin
>  #endif /* CONFIG_SMP */
>
> +.align 2
> +setup_trap_vector:
> +       /* Set trap vector to exception handler */
> +       la a0, handle_exception
> +       csrw CSR_TVEC, a0
> +
> +       /*
> +        * Set sup0 scratch register to 0, indicating to exception vector that
> +        * we are presently executing in kernel.
> +        */
> +       csrw CSR_SCRATCH, zero
> +       ret
> +
>  .Lsecondary_park:
>         /* We lack SMP support or have too many harts, so park this hart */
>         wfi
> @@ -240,6 +244,7 @@ clear_bss_done:
>         call relocate
>  #endif /* CONFIG_MMU */
>
> +       call setup_trap_vector
>         /* Restore C environment */
>         la tp, init_task
>         sw zero, TASK_TI_CPU(tp)

Apart from above, this looks good.

Regards,
Anup
