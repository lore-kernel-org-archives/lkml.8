Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D41AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9242065C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="ie94EZvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHLHlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHLHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:41:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:41:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p20so1105691wrf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcgI980fiRK7SzxZtdY0+aQKjgScVqiUUhN/ufIMkto=;
        b=ie94EZvBjlMPBYC7v+ZULaM3vEkmlqRbQup1ISoqE7/k++/Nxg7Zo3hGSK6NGo6J2E
         ov5MLZQyA7Ey345t2WDXVw8/jykGfhDUCDePGYVmEm2Z6AitQLrEVkQXtv6LRmrT4rHF
         pSt/LUexc4sHFDschR7ooBgKqAcTMzk4XhZgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcgI980fiRK7SzxZtdY0+aQKjgScVqiUUhN/ufIMkto=;
        b=X9RdbjKy6yoLYcMkQxXOY+P0WJ0p0q9CIFSUxRX+De0fzsjVTnzGEdtxxWiSR1e+jl
         ojgvEpZWDNCxYQFYYMAo1uwmFBvcszEzZZUZGuQPZbXAZ1jFGQhiuhx6Ej2YCEYG9d0/
         Nucu0AG9LU/OwHJrziqnBB+a+M4EMN7wVeFBLOgAtcAZaTRPkgo+peqEE/KWA5rto/SO
         HaPegIPr6VhHCcpZ+s8aNE7PBmqwCCgJhEF3s5n5ONjLJMHG6x0T6xZ9BUGz6zFe8czp
         1f8PMEsIPb/odBAtdEWTZEeCgNFVj4jNnLgh0YGYEs3iDiLIDxx/O2r/0u0HQbDyzlkX
         QP8w==
X-Gm-Message-State: AOAM531USfeZdelPtM5tc6AndEXjbHTSS8wTkK9C0u0B67cl97xoqrj5
        +H6Y2Hi0X9C7v0EOqQoJHrVsvnaMAAIM6jGTc2I5
X-Google-Smtp-Source: ABdhPJxE9iPhEi+Ighffl+MyFz80beV70ynZhB9O2kOx/VILETEiMy0EHhp5f4+WmccEEZUdbbgH6SIO5ou6TM23tvY=
X-Received: by 2002:adf:d84f:: with SMTP id k15mr31107746wrl.176.1597218110811;
 Wed, 12 Aug 2020 00:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
 <CAAhSdy1c=R6aUZ6EOggmJ_Bqm2O0VLKEku=zyFfabExSzOKErA@mail.gmail.com>
 <CAOnJCUJiLVyzMFkn157Zmdrtm66Z=gWmQbXCJiMRY8LCJ3xkaw@mail.gmail.com> <CAAhSdy0yV154R9EBbmQqR6mN-U7j02hGto76k+PY0W6xpJMW_A@mail.gmail.com>
In-Reply-To: <CAAhSdy0yV154R9EBbmQqR6mN-U7j02hGto76k+PY0W6xpJMW_A@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 12 Aug 2020 00:41:39 -0700
Message-ID: <CAOnJCULTwbmHta04VLqF=cTh=M68mTyF1bueSF8CQQV5XxFUCg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Setup exception vector for K210 properly
To:     Anup Patel <anup@brainfault.org>
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

On Tue, Aug 11, 2020 at 6:57 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Aug 12, 2020 at 12:16 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Tue, Aug 11, 2020 at 1:41 AM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 12:07 PM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
> > > >
> > > > Exception vector is missing on nommu platform and it is a big issue.
> > > > This patch is tested in Sipeed MAIX Bit Dev Board.
> > > >
> > > > Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
> > > > Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
> >
> > Thanks for testing it on the kendryte board.
> >
> > > > ---
> > > >  arch/riscv/kernel/smpboot.c |  1 +
> > > >  arch/riscv/kernel/traps.c   | 11 ++++++++++-
> > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > > > index 356825a57551..23cde0ceb39d 100644
> > > > --- a/arch/riscv/kernel/smpboot.c
> > > > +++ b/arch/riscv/kernel/smpboot.c
> > > > @@ -154,6 +154,7 @@ asmlinkage __visible void smp_callin(void)
> > > >         mmgrab(mm);
> > > >         current->active_mm = mm;
> > > >
> > > > +       trap_init();
> > > >         notify_cpu_starting(curr_cpuid);
> > > >         update_siblings_masks(curr_cpuid);
> > > >         set_cpu_online(curr_cpuid, 1);
> > > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > > index ad14f4466d92..a390239818ae 100644
> > > > --- a/arch/riscv/kernel/traps.c
> > > > +++ b/arch/riscv/kernel/traps.c
> > > > @@ -174,7 +174,16 @@ int is_valid_bugaddr(unsigned long pc)
> > > >  }
> > > >  #endif /* CONFIG_GENERIC_BUG */
> > > >
> > > > -/* stvec & scratch is already set from head.S */
> > > > +/* stvec & scratch is already set from head.S when mmu is enabled */
> > > >  void trap_init(void)
> > > >  {
> > > > +#ifndef CONFIG_MMU
> > > > +       /*
> > > > +        * Set sup0 scratch register to 0, indicating to exception vector
> > > > +        * that we are presently executing in the kernel
> > > > +        */
> > > > +       csr_write(CSR_SCRATCH, 0);
> > > > +       /* Set the exception vector address */
> > > > +       csr_write(CSR_TVEC, &handle_exception);
> > > > +#endif
> > > >  }
> > > > --
> > > > 2.28.0
> > > >
> > >
> > > This issue seems to be only on the latest master branch of
> > > Linux stable tree so this fix need not be a stable fix.
> > >
> > > For MMU kernel, the CSR_TVEC is setup in relocate() function
> > > called from secondary_start_common() function of head.S
> > >
> > > For NoMMU kernel, we should set CSR_TVEC directly in
> > > secondary_start_common() function as "#else" case of the
> > > "#ifdef CONFIG_MMU".
> > >
> >
> > That would enable the trap only for secondary harts. But the exception
> > vector on boot hart
> > is still uninitialized. How about this change ?
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index d0c5c316e9bb..7822054dbd88 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -77,16 +77,6 @@ relocate:
> >         csrw CSR_SATP, a0
> >  .align 2
> >  1:
> > -       /* Set trap vector to exception handler */
> > -       la a0, handle_exception
> > -       csrw CSR_TVEC, a0
> > -
> > -       /*
> > -        * Set sup0 scratch register to 0, indicating to exception vector that
> > -        * we are presently executing in kernel.
> > -        */
> > -       csrw CSR_SCRATCH, zero
> > -
>
> Instead of having no trap vector setup here, we should
> at least have dummy trap vector (just like original code).
>

Ahh yes. We should include that.

> /* Set trap vector to spin forever to help debug */
> la a0, .Lsecondary_park
> csrw CSR_TVEC, a0
>
> >         /* Reload the global pointer */
> >  .option push
> >  .option norelax
> > @@ -144,9 +134,23 @@ secondary_start_common:
> >         la a0, swapper_pg_dir
> >         call relocate
> >  #endif
> > +       call setup_trap_vector
> >         tail smp_callin
> >  #endif /* CONFIG_SMP */
> >
> > +.align 2
> > +setup_trap_vector:
> > +       /* Set trap vector to exception handler */
> > +       la a0, handle_exception
> > +       csrw CSR_TVEC, a0
> > +
> > +       /*
> > +        * Set sup0 scratch register to 0, indicating to exception vector that
> > +        * we are presently executing in kernel.
> > +        */
> > +       csrw CSR_SCRATCH, zero
> > +       ret
> > +
> >  .Lsecondary_park:
> >         /* We lack SMP support or have too many harts, so park this hart */
> >         wfi
> > @@ -240,6 +244,7 @@ clear_bss_done:
> >         call relocate
> >  #endif /* CONFIG_MMU */
> >
> > +       call setup_trap_vector
> >         /* Restore C environment */
> >         la tp, init_task
> >         sw zero, TASK_TI_CPU(tp)
>
> Apart from above, this looks good.
>
> Regards,
> Anup



-- 
Regards,
Atish
