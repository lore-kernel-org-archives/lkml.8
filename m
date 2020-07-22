Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA38C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44ACF20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595427928;
	bh=7qu9AhuxHamYf2H65Wn8U6QS1wG03iK+GcGL7GeTdt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y4AlD8lJpuYjAZ6P3QbeNnCNLdn9GGaqbc498ft7Qc6KsGVpIF4lI2SdTPDI5ggSq
	 njvKwQi0ADHZkhBY+edejuBPD9+eVPQLbmh9UT/fQJ3FVsarNfgcKfhaI3ETmwxj0B
	 dQaAKmscRvHT9R7nX0waquHRqIT2kTfK43YPfrys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbgGVOZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbgGVOZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:25:26 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B852120729;
        Wed, 22 Jul 2020 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595427926;
        bh=7qu9AhuxHamYf2H65Wn8U6QS1wG03iK+GcGL7GeTdt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UdOTKCQNQEAHNuJPmna0YOIC32+p0i5Fs49J2mN+BlpL4q4OnGm7p32BW0oDSaQxm
         kWEl+WHTI0AUOh6qR4A8SWognsRXz+p34Iz+CrrmT2euaU3CJ/nz7y87eGz1tiuz61
         mY85CSbo1PFGp4cRDrm1OHL9zd1c82kTPX9vviWI=
Received: by mail-ej1-f42.google.com with SMTP id y10so2437783eje.1;
        Wed, 22 Jul 2020 07:25:25 -0700 (PDT)
X-Gm-Message-State: AOAM530JzqviUExCJYbH0FWEbFX3TRrA0fWepCTHfkGrq/4FhfNzgVYD
        GRoHF6uErDEfgPqBhXRxXfZJpFZlzdiY+zDyWg==
X-Google-Smtp-Source: ABdhPJzFT8VUNhe352u2h73sOsvThk1Vu0xKwN26k6fBL2y8N2CMnD91ujV5It0L2yB+67/2TV+cl1gHiuVf6ha3PqI=
X-Received: by 2002:a17:906:6959:: with SMTP id c25mr29600316ejs.375.1595427924194;
 Wed, 22 Jul 2020 07:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com>
 <1595303971-8793-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
 <1595389756.20193.12.camel@mtkswgap22>
In-Reply-To: <1595389756.20193.12.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 22 Jul 2020 22:25:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9k7rM=Pf43DwJR_bkQvxVtpWYTjVoNSZLVE2N0Y_DBmA@mail.gmail.com>
Message-ID: <CAAOTY_9k7rM=Pf43DwJR_bkQvxVtpWYTjVoNSZLVE2N0Y_DBmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: mediatek: add mtk-devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8822=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Wed, 2020-07-22 at 07:21 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8821=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> >
> > > +
> > > +/*
> > > + * mtk_devapc_dump_vio_dbg - get the violation index and dump the fu=
ll violation
> > > + *                           debug information.
> > > + */
> > > +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_context *ctx, =
u32 vio_idx)
> > > +{
> > > +       u32 shift_bit;
> > > +
> > > +       if (check_vio_mask(ctx, vio_idx))
> > > +               return false;
> > > +
> > > +       if (!check_vio_status(ctx, vio_idx))
> > > +               return false;
> > > +
> > > +       shift_bit =3D get_shift_group(ctx, vio_idx);
> > > +
> > > +       if (sync_vio_dbg(ctx, shift_bit))
> > > +               return false;
> > > +
> > > +       devapc_extract_vio_dbg(ctx);
> >
> > I think get_shift_group(), sync_vio_dbg(), and
> > devapc_extract_vio_dbg() should be moved out of vio_idx for-loop (the
> > loop in devapc_violation_irq()) because these three function is not
> > related to vio_idx.
> > Another question: when multiple vio_idx violation occur, vio_addr is
> > related to which one vio_idx? The latest happened one?
> >
>
> Actually, it's related to vio_idx. But we don't use it directly on these
> function. I think below snip code might be better way to understand it.
>
> for (...)
> {
>         check_vio_mask()
>         check_vio_status()
>
>         // if get vio_idx, mask it temporarily
>         mask_module_irq(true)
>         clear_vio_status()
>
>         // dump violation info
>         get_shift_group()
>         sync_vio_dbg()
>         devapc_extract_vio_dbg()
>
>         // unmask
>         mask_module_irq(false)
> }

This snip code does not explain any thing. I could rewrite this code as:

for (...)
{
    check_vio_mask()
    check_vio_status()

    // if get vio_idx, mask it temporarily
    mask_module_irq(true)
    clear_vio_status()
    // unmask
    mask_module_irq(false)
}

// dump violation info
get_shift_group()
sync_vio_dbg()
devapc_extract_vio_dbg()

And my version is identical with your version, isn't it?

>
> About your question, vio_addr would be the first one.

So other vio_addr would be dropped? Or hardware would keep all
vio_addr and you have some way to get all vio_addr?

>
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +/*
> > > + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR)=
 will dump
> > > + *                        violation information including which mast=
er violates
> > > + *                        access slave.
> > > + */
> > > +static irqreturn_t devapc_violation_irq(int irq_number,
> > > +                                       struct mtk_devapc_context *ct=
x)
> > > +{
> > > +       u32 vio_idx;
> > > +
> > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++) {
> > > +               if (!mtk_devapc_dump_vio_dbg(ctx, vio_idx))
> > > +                       continue;
> > > +
> > > +               /* Ensure that violation info are written before
> > > +                * further operations
> > > +                */
> > > +               smp_mb();
> > > +
> > > +               /*
> > > +                * Mask slave's irq before clearing vio status.
> > > +                * Must do it to avoid nested interrupt and prevent
> > > +                * unexpected behavior.
> > > +                */
> > > +               mask_module_irq(ctx, vio_idx, true);
> > > +
> > > +               clear_vio_status(ctx, vio_idx);
> > > +
> > > +               mask_module_irq(ctx, vio_idx, false);
> > > +       }
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +/*
> > > + * start_devapc - initialize devapc status and start receiving inter=
rupt
> > > + *                while devapc violation is triggered.
> > > + */
> > > +static int start_devapc(struct mtk_devapc_context *ctx)
> > > +{
> > > +       void __iomem *pd_vio_shift_sta_reg;
> > > +       void __iomem *pd_apc_con_reg;
> > > +       u32 vio_shift_sta;
> > > +       u32 vio_idx;
> > > +
> > > +       pd_apc_con_reg =3D ctx->devapc_pd_base + ctx->offset->apc_con=
;
> > > +       pd_vio_shift_sta_reg =3D ctx->devapc_pd_base + ctx->offset->v=
io_shift_sta;
> > > +       if (!pd_apc_con_reg || !pd_vio_shift_sta_reg)
> > > +               return -EINVAL;
> > > +
> > > +       /* Clear devapc violation status */
> > > +       writel(BIT(31), pd_apc_con_reg);
> > > +
> > > +       /* Clear violation shift status */
> > > +       vio_shift_sta =3D readl(pd_vio_shift_sta_reg);
> > > +       if (vio_shift_sta)
> > > +               writel(vio_shift_sta, pd_vio_shift_sta_reg);
> > > +
> > > +       /* Clear slave violation status */
> > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++) {
> > > +               clear_vio_status(ctx, vio_idx);
> > > +               mask_module_irq(ctx, vio_idx, false);
> > > +       }
> > > +
> >
> > Why do you clear these? After power on hardware, I think these
> > register status are correct. If the default value of these register
> > are not correct, add a comment for this.
> >
>
> The register default value would be correct after power on.
> But there are many things have to do before kernel driver probe.
> During that time, devapc register status might be changed. But we are
> focusing on handling violation after driver probe instead.
> So clearing all reg status to make it as initial state.

After hardware is powered on and some violation happen before this
driver init, why do you not care about it? That is a violation in this
system.
For one application, I could build this driver as a ko (kernel
module). I do not insert this ko in normal, but I insert it after
something is wrong. So I need to get the information happened before
this driver init.

Regards,
Chun-Kuang.

>
> > Regards,
> > Chun-Kuang.
> >
> > > +       return 0;
> > > +}
> > > +
>
