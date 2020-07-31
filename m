Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56BEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9485622B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596210939;
	bh=J9+siusKNMgqbpz/tIFkjD2Z8De5SqX8GkR1C4h8230=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I9s3j8KCLgf+uLQGHpxmC+/EI+WhMBUx6pgJRtX3ShTi328CJUc7Mq4DA/W/gzZpP
	 s4/ibHn/8tnTDkdf/NyiM+xSwnrq1OuI9TcoQqM59G8Y14QvxpogjdZYy5V5GyqmrF
	 eeF6f4NV1SS8LksiO3CnpKOa1Qf8a6Evc07ahpis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgGaPzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgGaPzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:55:37 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724DD22B40;
        Fri, 31 Jul 2020 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596210936;
        bh=J9+siusKNMgqbpz/tIFkjD2Z8De5SqX8GkR1C4h8230=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dGIUQu1jbUUxwH5rNXVUSew0VW7xzb9z6seOM7jOMSR8GUvwf7QuYFyTKi8qefnzh
         dcfB3/3KbfK0b4Y0V+NZDUf6Kvcrin+hg9mdRhQ/vYzVpaAp3uw0Ww0nO+KcUMKbBo
         TNm9aew2dfnUY0dckAe9MYp/u3on5mWvf7WNbII8=
Received: by mail-ed1-f49.google.com with SMTP id c15so13013092edj.3;
        Fri, 31 Jul 2020 08:55:36 -0700 (PDT)
X-Gm-Message-State: AOAM530+Rr7NBN6+CZlJAY9tIo/IM6gyQwuYBOSAVIbjDCpuq8sETQK6
        /3nfzqo7IE7egRpKkPUldq5fqy0XjSL0/UtkqA==
X-Google-Smtp-Source: ABdhPJyvCgp3yv2IchWxBuw3fUcmJODItQC77/XdI2+/aZn3y49etTW8MtFbnkKPj7yQQ025yPQkWTWNgUEveNWJWTw=
X-Received: by 2002:a50:9e6f:: with SMTP id z102mr4608208ede.300.1596210935010;
 Fri, 31 Jul 2020 08:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
 <1596010690-13178-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_9HXv+OsSRF7P9=cRy9AYZ0vwffgo3Kc8V=qQ6ce90uJw@mail.gmail.com>
 <1596163970.3932.24.camel@mtkswgap22>
In-Reply-To: <1596163970.3932.24.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 31 Jul 2020 23:55:23 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-3vs9VdAs3RHc_-MQJ7HbmqXKgULC_H0grr3q7oNDxMQ@mail.gmail.com>
Message-ID: <CAAOTY_-3vs9VdAs3RHc_-MQJ7HbmqXKgULC_H0grr3q7oNDxMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8831=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Fri, 2020-07-31 at 00:14 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > MediaTek bus fabric provides TrustZone security support and data
> > > protection to prevent slaves from being accessed by unexpected
> > > masters.
> > > The security violation is logged and sent to the processor for
> > > further analysis or countermeasures.
> > >
> > > Any occurrence of security violation would raise an interrupt, and
> > > it will be handled by mtk-devapc driver. The violation
> > > information is printed in order to find the murderer.
> > >
> > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > ---
> >
> > [snip]
> >
> > > +
> > > +/*
> > > + * devapc_extract_vio_dbg - extract full violation information after=
 doing
> > > + *                          shift mechanism.
> > > + */
> > > +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
> > > +{
> > > +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> > > +       struct mtk_devapc_vio_info *vio_info;
> > > +       void __iomem *vio_dbg0_reg;
> > > +       void __iomem *vio_dbg1_reg;
> > > +       u32 dbg0;
> > > +
> > > +       vio_dbg0_reg =3D ctx->devapc_pd_base + ctx->offset->vio_dbg0;
> > > +       vio_dbg1_reg =3D ctx->devapc_pd_base + ctx->offset->vio_dbg1;
> > > +
> > > +       vio_dbgs =3D ctx->vio_dbgs;
> > > +       vio_info =3D ctx->vio_info;
> > > +
> > > +       /* Starts to extract violation information */
> > > +       dbg0 =3D readl(vio_dbg0_reg);
> > > +       vio_info->vio_addr =3D readl(vio_dbg1_reg);
> > > +
> > > +       vio_info->master_id =3D (dbg0 & vio_dbgs->mstid.mask) >>
> > > +                             vio_dbgs->mstid.start;
> > > +       vio_info->domain_id =3D (dbg0 & vio_dbgs->dmnid.mask) >>
> > > +                             vio_dbgs->dmnid.start;
> > > +       vio_info->write =3D ((dbg0 & vio_dbgs->vio_w.mask) >>
> > > +                           vio_dbgs->vio_w.start) =3D=3D 1;
> > > +       vio_info->read =3D ((dbg0 & vio_dbgs->vio_r.mask) >>
> > > +                         vio_dbgs->vio_r.start) =3D=3D 1;
> > > +       vio_info->vio_addr_high =3D (dbg0 & vio_dbgs->addr_h.mask) >>
> > > +                                 vio_dbgs->addr_h.start;
> >
> >
> > I would like to define the type of ctx->vio_info to be
> >
> > struct mtk_devapc_vio_dbgs {
> >     u32 mstid:16;
> >     u32 dmnid:6;
> >     u32 vio_w:1;
> >     u32 vio_r:1;
> >     u32 addr_h:4;
> >     u32 resv:4;
> > };
> >
> > so the code would like the simple way
> >
> > ctx->vio_info =3D (struct mtk_devapc_vio_dbgs)readl(vio_dbg1_reg);
> >
>
> This idea looks great! Is there any possible to pass the bit layout by
> DT data, and still make this operation simple?
> Why am I asking this question is because this bit layout is platform
> dependent.

I doubt these info would be in a single 32-bits register for all
future SoC. If they are not in single 32-bits register, you may create
a vio_dbgs_type in DT data, and the code may be

if (ctx->vio_dbgs_type =3D=3D VIO_DBGS_TYPE_MTxxxx) {
    ctx->vio_info =3D (struct mtk_devapc_vio_dbgs)readl(vio_dbg1_reg);
} else if (ctx->vio_dbgs_type =3D=3D VIO_DBGS_TYPE_MTyyyy) {
    ctx->vio_info->mstid =3D readl(vio_mstid_reg);
    ctx->vio_info->dmnid =3D readl(vio_dmnid_reg);
    ctx->vio_info->vio_w =3D readl(vio_vio_w_reg);
    ctx->vio_info->vio_r =3D readl(vio_vio_r_reg);
}

I think we need not to consider how the future would be. Once the
second SoC driver is upstreaming, we could find out the best solution
for it.

Regards,
Chun-Kuang.

>
> > Regards,
> > Chun-Kuang.
> >
> > > +
> > > +       devapc_vio_info_print(ctx);
> > > +}
> > > +
>
