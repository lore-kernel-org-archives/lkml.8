Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4270DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B81D2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594650034;
	bh=IId5QOPSndJUPoyL6HRFHM12/PWNCAUkWspegEMSuao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j6Q/KFSaXUQf37kpYTdE8+EpAuShL1p+3c8Mu6Obq4ntjHbwKgnPtkjofjZqOr5K3
	 XUJoXqzGJc9xZVZ66sbetellfmVhqm12n8OezDdoGe+mfcHDjp0t5le8Jlwx1E4sJo
	 w/CVVDzMr48Kt3nDcWyiiQSzZtLdQ5UsP6afaC7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgGMOUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgGMOUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:20:32 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F432075D;
        Mon, 13 Jul 2020 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594650031;
        bh=IId5QOPSndJUPoyL6HRFHM12/PWNCAUkWspegEMSuao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UgzykC6i9N+z0nSmXMWOymDt2Cx6HKGWcjiOYgYy+M6NzekoA6tlmHJoOIPHBTgxH
         N6HG8hPskZ87or/KSnwcQrymvJy7t5Ixdl6dlb4vqMgzjGfMyppy7nxppV8ZeI3EqN
         bkJVkOCCCnms/roc45ldTplkcLEat6yE8SxOBSUo=
Received: by mail-ej1-f43.google.com with SMTP id dp18so17387894ejc.8;
        Mon, 13 Jul 2020 07:20:31 -0700 (PDT)
X-Gm-Message-State: AOAM5307L0EHkFN7/e9NlfBO+yB7WA8rpLmKFGJYhbImGj+ncfq/7ql3
        41+r/HPgulTbLIyJqIkrpYmqTA2E2maYqxMnDQ==
X-Google-Smtp-Source: ABdhPJwLnqjJ0wxwFlHWN/oUCrOqvGtPrVpDTTnYynyk+47sF5GTmGIZzs40cnkDwqbJAuOxHTRSVMgpuvN6MpVAGVc=
X-Received: by 2002:a17:906:9354:: with SMTP id p20mr25576593ejw.187.1594650029915;
 Mon, 13 Jul 2020 07:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
 <1594285927-1840-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_-7PwoPG_0ce2p4BCNQ3rundg40Bsni14XSmVETExkKkw@mail.gmail.com>
 <1594351423.4670.18.camel@mtkswgap22> <CAAOTY_9MPYi=FAisE50UzT=eceSykN+Z8HnfFLLg_uRDhPAkpg@mail.gmail.com>
 <1594628844.22730.48.camel@mtkswgap22>
In-Reply-To: <1594628844.22730.48.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Jul 2020 22:20:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY_931nJb2Ove5NzfAWX=xy0D3oj6y5d0ThRsvhANFf1_BQ@mail.gmail.com>
Message-ID: <CAAOTY_931nJb2Ove5NzfAWX=xy0D3oj6y5d0ThRsvhANFf1_BQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: add mtk-devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> Thanks for your review.
>
> On Fri, 2020-07-10 at 22:21 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8811:23=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > > Thanks for your review.
> > >
> > > On Thu, 2020-07-09 at 21:01 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=889=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:13=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > MediaTek bus fabric provides TrustZone security support and data
> > > > > protection to prevent slaves from being accessed by unexpected
> > > > > masters.
> > > > > The security violation is logged and sent to the processor for
> > > > > further analysis or countermeasures.
> > > > >
> > > > > Any occurrence of security violation would raise an interrupt, an=
d
> > > > > it will be handled by mtk-devapc driver. The violation
> > > > > information is printed in order to find the murderer.
> > > > >
> > > > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > >
> > > > [snip]
> > > >
> > > > > +
> > > > > +static u32 get_shift_group(struct mtk_devapc_context *devapc_ctx=
,
> > > > > +                          int slave_type, int vio_idx)
> > > >
> > > > vio_idx  is useless, so remove it.
> > > >
> > >
> > > yes, my mistake. I'll remove it on next patch.
> > >
> > > > > +{
> > > > > +       u32 vio_shift_sta;
> > > > > +       void __iomem *reg;
> > > > > +       int bit;
> > > > > +
> > > > > +       reg =3D mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_SHI=
FT_STA, 0);
> > > > > +       vio_shift_sta =3D readl(reg);
> > > > > +
> > > > > +       for (bit =3D 0; bit < 32; bit++) {
> > > > > +               if ((vio_shift_sta >> bit) & 0x1)
> > > > > +                       break;
> > > > > +       }
> > > > > +
> > > > > +       return bit;
> > > > > +}
> > > > > +
> > > >
> > > > [snip]
> > > >
> > > > > +
> > > > > +/*
> > > > > + * devapc_violation_irq - the devapc Interrupt Service Routine (=
ISR) will dump
> > > > > + *                       violation information including which m=
aster violates
> > > > > + *                       access slave.
> > > > > + */
> > > > > +static irqreturn_t devapc_violation_irq(int irq_number,
> > > > > +                                       struct mtk_devapc_context=
 *devapc_ctx)
> > > > > +{
> > > > > +       const struct mtk_device_info **device_info;
> > > > > +       int slave_type_num;
> > > > > +       int vio_idx =3D -1;
> > > > > +       int slave_type;
> > > > > +
> > > > > +       slave_type_num =3D devapc_ctx->slave_type_num;
> > > > > +       device_info =3D devapc_ctx->device_info;
> > > > > +
> > > > > +       for (slave_type =3D 0; slave_type < slave_type_num; slave=
_type++) {
> > > >
> > > > If slave_type_num is 1, I think the code should be simpler.
> > >
> > > slave_type_num is depends on DT data, it's not always 1.
> >
> > Please change commit title to "add mt6779 mtk-devapc driver". This
> > patch is just for mt6779. If slave_type_num =3D 1 in mt6779, there is
> > only one slave and we don't need a slave_type variable. Add
> > slave_type_num in the patch of adding one SoC which has multiple
> > slaves.
>
> If slave_type_num value is passed from DT data, could we still assume
> its value? Does it make sense to have this strong assumption?

Maintainer has asked you to move this data from device tree to driver
[1], I doubt you could get this data from device tree. Even though
device tree has this property, this driver support only mt6779 now, so
it's not necessary to have slave_type_num because slave type is only
1. I think we should not consider support multiple SoC in this patch.

[1] https://patchwork.kernel.org/patch/11653911/

>
> I'm going to remove mtk_device_info struct array, and pass all SoC
> specific data from DT.
> Is it okay to keep slave_type_num as a variance?
>
> >
> > >
> > > >
> > > > > +               if (!mtk_devapc_dump_vio_dbg(devapc_ctx, slave_ty=
pe, &vio_idx))
> > > > > +                       continue;
> > > > > +
> > > > > +               /* Ensure that violation info are written before
> > > > > +                * further operations
> > > > > +                */
> > > > > +               smp_mb();
> > > > > +
> > > > > +               mask_module_irq(devapc_ctx, slave_type, vio_idx, =
true);
> > > >
> > > > Why do you mask irq?
> > >
> > > It has to mask slave's irq before clear violation status.
> > > It's one of hardware design.
> >
> > If don't do this before clear_vio_status, what would happen? The clear
> > would fail?
>
> If we don't mask slave's irq before clear vio status, It might trigger
> another interrupt before current ISR finished. The nested interrupt will
> have unexpected behavior and hardware state machine goes wrong.

This hardware is so special. For general hardware, only clear status
would let hardware stop interrupt. Please add a comment about this
special hardware behavior.

>
> >
> > >
> > > >
> > > > > +
> > > > > +               clear_vio_status(devapc_ctx, slave_type, vio_idx)=
;
> > > > > +
> > > > > +               mask_module_irq(devapc_ctx, slave_type, vio_idx, =
false);
> > > > > +       }
> > > > > +
> > > > > +       return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * start_devapc - initialize devapc status and start receiving i=
nterrupt
> > > > > + *               while devapc violation is triggered.
> > > > > + */
> > > >
> > > > [snip]
> > > >
> > > > > +
> > > > > +struct mtk_device_info {
> > > > > +       int sys_index;
> > > >
> > > > Useless, so remove it.
> > >
> > > We need to print it as our debug information.
> > > But I did not apply it on this patch, I'll add it on next patch.
> >
> > I think vio address is enough to find out the murder, so remove it in
> > this patch. If it provide another information, add it in another patch
> > and describe clear about what is this and how to use this information.
> >
>
> Okay, it make sense. I'll remove it in next patches.
>
> > >
> > > >
> > > > > +       int ctrl_index;
> > > >
> > > > Ditto.
> > > >
> > > > Regards,
> > > > Chun-Kuang.
> > > >
> > > > > +       int vio_index;
> > > > > +};
> > > > > +
> > >
>
