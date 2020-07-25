Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F45C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA3F206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="Q1vZe+rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGYF0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGYF0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:26:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50DEC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:26:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so20057wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6p0lVxEnhHsvjplpbb7vWgmumCrMN6gGnNK6UWZILU=;
        b=Q1vZe+rKwyyYjIW6XXvjhhERm0kakS74BuxhRPpXajZcKpBSQrLf4lCSu0NiYL2LFy
         n5RFcUmb062jxXoc9P482sXmu4tvBwwyPReseQpg5qGh/X58CzCvXB/NzsCvuF4EVd8x
         /zgGwj9uZmSfxsS3AdLH+E+vyTeIZLdZ6uLJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6p0lVxEnhHsvjplpbb7vWgmumCrMN6gGnNK6UWZILU=;
        b=YSvCp3/6qMt5raWOAmqnytbSTnFLkrC8zpywFV8QgHvuLiu6WswK4odO+2x5Qi4pzf
         LdbXsBDD1G+KdMNRDZo3c66RxsYQ8jV6iqP2TaLSzMKmBWGDSxwE5x/Lw065RxbtikpG
         QJfDUtq7Hyy99metlmvxroNNQUI5BCIVRNeEruUm5wXOuZix4LbKB+Urqd2AJZKYxdV9
         VETZJEuL6LkckrgmWC1shIpkJHmEzwPWwuAZaKKTNNUyR7e1WEoUV/uCQgagMR3Lj2IW
         KugNyfW5NLQnhULFv/UFDUKn6wjydg8pyf3RSZodXenwwCiidUFav7Xe+FOWLTSp/Tbf
         7pPg==
X-Gm-Message-State: AOAM531VTOpQjH0ejNAvjdX2ojuuIjOcKC+V2Fc3U6xrsauMM9bWzXCp
        PW01c5TKwKwpqnrmwXksZNs9Yipgujj+PF8swO5S
X-Google-Smtp-Source: ABdhPJwrMR+ET7MBSwIPEVUPSgwSWal0eiCukHggZx1kTuBtHy9ADY6OHBBQ+R7mDwHTpoe4ACM51xX1mQ4QXV1TL1k=
X-Received: by 2002:adf:d84f:: with SMTP id k15mr10836892wrl.176.1595654782356;
 Fri, 24 Jul 2020 22:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200715233009.27183-2-atish.patra@wdc.com> <mhng-8ce8d920-4b65-432c-8b51-8d81f55936c0@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-8ce8d920-4b65-432c-8b51-8d81f55936c0@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Jul 2020 22:26:10 -0700
Message-ID: <CAOnJCUL7=i3XXMDJ5vgnNo==3zOANxGEe3ufznAhn7LE7vVAZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: Setup exception vector early
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        sudeep.holla@arm.com, Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:12 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 15 Jul 2020 16:30:06 PDT (-0700), Atish Patra wrote:
> > The trap vector is set only in trap_init which may be too late in some
> > cases. Early ioremap/efi spits many warning messages which may be useful.
> >
> > Setup the trap vector early so that any warning/bug can be handled before
> > generic code invokes trap_init.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/kernel/head.S    | 10 ++++++++--
> >  arch/riscv/kernel/smpboot.c |  1 -
> >  arch/riscv/kernel/traps.c   |  8 +-------
> >  3 files changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 7ed1b22950fd..d0c5c316e9bb 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -77,10 +77,16 @@ relocate:
> >       csrw CSR_SATP, a0
> >  .align 2
> >  1:
> > -     /* Set trap vector to spin forever to help debug */
> > -     la a0, .Lsecondary_park
> > +     /* Set trap vector to exception handler */
> > +     la a0, handle_exception
> >       csrw CSR_TVEC, a0
> >
> > +     /*
> > +      * Set sup0 scratch register to 0, indicating to exception vector that
> > +      * we are presently executing in kernel.
> > +      */
> > +     csrw CSR_SCRATCH, zero
> > +
> >       /* Reload the global pointer */
> >  .option push
> >  .option norelax
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 4e9922790f6e..5a9c127a380e 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -154,7 +154,6 @@ asmlinkage __visible void smp_callin(void)
> >       mmgrab(mm);
> >       current->active_mm = mm;
> >
> > -     trap_init();
> >       notify_cpu_starting(smp_processor_id());
> >       update_siblings_masks(smp_processor_id());
> >       set_cpu_online(smp_processor_id(), 1);
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 7d95cce5e47c..ad14f4466d92 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -174,13 +174,7 @@ int is_valid_bugaddr(unsigned long pc)
> >  }
> >  #endif /* CONFIG_GENERIC_BUG */
> >
> > +/* stvec & scratch is already set from head.S */
> >  void trap_init(void)
> >  {
> > -     /*
> > -      * Set sup0 scratch register to 0, indicating to exception vector
> > -      * that we are presently executing in the kernel
> > -      */
> > -     csr_write(CSR_SCRATCH, 0);
> > -     /* Set the exception vector address */
> > -     csr_write(CSR_TVEC, &handle_exception);
> >  }
>
> While I think these are all actual fixes, it's pretty late in the cycle here so
> I'm going to a bit on the careful side and only take the patches that actually
> manifest as bugs in the current port.  Assuming this doesn't manifest until
> early_ioremap is enabled (and we don't do that yet), I've put it on for-next.
>

Yeah. early_ioremap is part of the UEFI series. So this can go into for-next.
Thanks.

> LMK if I'm wrong about this, or the following ones.
>
> Thanks!
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
