Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E40C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952D7205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="AkUXHOBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMGpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgHMGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:45:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E17C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:45:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so4056143wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15/mwsQoBEuD1UnQg0WuQ5I0KeUnjP+2eB9N9GgL8EQ=;
        b=AkUXHOBKHkEJbIl8DXGc+JE/8Q+P3+MPn2+ghNpogZBAlbVu83PZnqRAjk6ld34dpo
         H398Iy2p5q7orn9oKHCWeBpd07JymChd2v8bDjaQ89t6j+H9MEXoSrG1cqpmTXim7WT8
         8Z7GGanzTaBc1OSLTocvV4QR75gsL+txbYnxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15/mwsQoBEuD1UnQg0WuQ5I0KeUnjP+2eB9N9GgL8EQ=;
        b=WznuHyPB1bj9xEEpIaJG/2PeSQJXI0XGHC8SWTwbrM+qzDoUt8pQL88jW58tpmol4+
         mTTx6T5KbOGcX8a2Wp+2645ILO7PyBXDEYXDtpIGhGAhlZBjD4XDZWkqAIvs+7Qm2+46
         wxi9SdclP9EG4To+JeGepABkKjeFkhu+Eu6Ls48UuQa8NY8xUlpJbrz4FhY/+wHQvqnb
         WAkB3V7PoCaff3jubOoyBzib0zxcf/keu43sEv8OH6RlwNrIH9vY4sMJ36/WpcqYKO4f
         F7qVKLDjhhIlSZMEzyaPKPGTliLZ2rdS+R2W00V5FjiVpJ9IK4/CZTv+7kLcg8TysqAG
         NsSQ==
X-Gm-Message-State: AOAM530bxh//lHGK06m6R4dj73skEAWHWiI+jV7+St6JDl2nPFAP/7ws
        Fe5LYlpFXBus8iEI7Zr7DNGzuMhpmGc7hm8w6dsD
X-Google-Smtp-Source: ABdhPJxtTMvTIOuyXnTDOzi8O0hbnzjAJe/bIvZreckJCf7i0Tl/K4mmhwfObr+Wqzr7pbVb8Ow7xHg/HWrcMsHfljI=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr2880135wmh.55.1597301120774;
 Wed, 12 Aug 2020 23:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200813033807.19556-1-qiuwenbo@phytium.com.cn> <CY4PR04MB3751ECCFBE6B590E9D0850B0E7430@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB3751ECCFBE6B590E9D0850B0E7430@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 12 Aug 2020 23:45:09 -0700
Message-ID: <CAOnJCUJTR_FEmjvs+L1KV6UJNbsZKrrVr7noWHUi8gG6qoWHxA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Setup exception vector for nommu platform
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:44 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/08/13 12:40, Qiu Wenbo wrote:
> > Exception vector is missing on nommu platform and that is an issue.
> > This patch is tested in Sipeed Maix Bit Dev Board.
> >
> > Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
> > Suggested-by: Anup Patel <anup@brainfault.org>
> > Suggested-by: Atish Patra <atishp@atishpatra.org>
> > Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
>
> Please add a cc stable #5.8 tag. Kendryte support is in 5.8 stable.
>

That won't be necessary as the patch that broke nommu (79b1feba5455) was
part of the 1st PR sent towards 5.9-rc1.


> > ---
> >  arch/riscv/kernel/head.S | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index d0c5c316e9bb..0a4e81b8dc79 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -77,16 +77,10 @@ relocate:
> >       csrw CSR_SATP, a0
> >  .align 2
> >  1:
> > -     /* Set trap vector to exception handler */
> > -     la a0, handle_exception
> > +     /* Set trap vector to spin forever to help debug */
> > +     la a0, .Lsecondary_park
> >       csrw CSR_TVEC, a0
> >
> > -     /*
> > -      * Set sup0 scratch register to 0, indicating to exception vector that
> > -      * we are presently executing in kernel.
> > -      */
> > -     csrw CSR_SCRATCH, zero
> > -
> >       /* Reload the global pointer */
> >  .option push
> >  .option norelax
> > @@ -144,9 +138,23 @@ secondary_start_common:
> >       la a0, swapper_pg_dir
> >       call relocate
> >  #endif
> > +     call setup_trap_vector
> >       tail smp_callin
> >  #endif /* CONFIG_SMP */
> >
> > +.align 2
> > +setup_trap_vector:
> > +     /* Set trap vector to exception handler */
> > +     la a0, handle_exception
> > +     csrw CSR_TVEC, a0
> > +
> > +     /*
> > +      * Set sup0 scratch register to 0, indicating to exception vector that
> > +      * we are presently executing in kernel.
> > +      */
> > +     csrw CSR_SCRATCH, zero
> > +     ret
> > +
> >  .Lsecondary_park:
> >       /* We lack SMP support or have too many harts, so park this hart */
> >       wfi
> > @@ -240,6 +248,7 @@ clear_bss_done:
> >       call relocate
> >  #endif /* CONFIG_MMU */
> >
> > +     call setup_trap_vector
> >       /* Restore C environment */
> >       la tp, init_task
> >       sw zero, TASK_TI_CPU(tp)
> >
>
>
> --
> Damien Le Moal
> Western Digital Research



--
Regards,
Atish
