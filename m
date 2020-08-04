Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6BA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596554904;
	bh=GrEWQJQGOl4cRu/UhU8uTIUnxBntWt33e91g5LKhI0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dxzIKnTLXpDX3QiYrA5aRV/fK9MtuQ2azKXeRXq4kUYrjWBTl26RZXMGFunPZPYvn
	 lsrqpBhb2fnadkye+U0jj+Coz8NGjGcVd5kvYunMo69kYYL1DGaNLX3dfgfN883E1y
	 3IXC+/x7AuXjwnDsFluzQmejhxxlJrhc+C06GIUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgHDP2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgHDP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:28:14 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A092086A;
        Tue,  4 Aug 2020 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596554889;
        bh=GrEWQJQGOl4cRu/UhU8uTIUnxBntWt33e91g5LKhI0I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nPRx8iVY++kqpG4JDyL1ugJ8/dPRM/1CePHwuMe6djgeGx/H47CQvGe8BxoDCcvTB
         +xnKxXz0q/mQsWogVoyUU8Nh1lisdIbXVuFzZvsCKxPeZ9zgnQAokq3MDRCJvXynF8
         EV4KlR/0/hX43DjjgGRnOv62JW6Wup4tHovWHpek=
Received: by mail-ed1-f53.google.com with SMTP id df16so13844972edb.9;
        Tue, 04 Aug 2020 08:28:08 -0700 (PDT)
X-Gm-Message-State: AOAM530t0JtibuhZ1WbZ2YAlFvrIgzL8o6yFwNcT6cyhQWD2SxGep5Eg
        Y3kGj5PpNHk75KSePsS+5VE/21DRzdFvCn1JsQ==
X-Google-Smtp-Source: ABdhPJz4owQRFlNIZk3qrbGz+1xbIMmNTB4wOXaF6pJDPcefYmGuIWtd4ZfGJJqDp76Dh2VsG/aOI8Et1XcOKW06Fao=
X-Received: by 2002:a50:e109:: with SMTP id h9mr7679015edl.47.1596554887579;
 Tue, 04 Aug 2020 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
 <1596010690-13178-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8bE8Qo5-0MA9J1gcEbN4DP=Wf2O6vOUVos=VkoODeayA@mail.gmail.com>
 <1596163478.3932.17.camel@mtkswgap22> <CAAOTY_9kS+jrCOpZtOs+L8gBzvkewi+cSN7XWGNxuiMQocedFA@mail.gmail.com>
 <1596425521.22971.13.camel@mtkswgap22> <CAAOTY_9UcnSDTaVPDPyPLsWEYcrcq5MY=z520MWtFdeLw_FqGQ@mail.gmail.com>
 <1596507531.17917.10.camel@mtkswgap22>
In-Reply-To: <1596507531.17917.10.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 23:27:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-fsAXAO0rVMBdL+MLpFUx6w8EUCNoZG=qNvG+UuEDkGA@mail.gmail.com>
Message-ID: <CAAOTY_-fsAXAO0rVMBdL+MLpFUx6w8EUCNoZG=qNvG+UuEDkGA@mail.gmail.com>
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> On Tue, 2020-08-04 at 00:13 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > > On Fri, 2020-07-31 at 23:03 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=883=
1=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:44=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > Hi Chun-Kuang,
> > > > >
> > > > >
> > > > > On Thu, 2020-07-30 at 00:38 +0800, Chun-Kuang Hu wrote:
> > > > > > Hi, Neal:
> > > > > >
> > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8829=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > MediaTek bus fabric provides TrustZone security support and d=
ata
> > > > > > > protection to prevent slaves from being accessed by unexpecte=
d
> > > > > > > masters.
> > > > > > > The security violation is logged and sent to the processor fo=
r
> > > > > > > further analysis or countermeasures.
> > > > > > >
> > > > > > > Any occurrence of security violation would raise an interrupt=
, and
> > > > > > > it will be handled by mtk-devapc driver. The violation
> > > > > > > information is printed in order to find the murderer.
> > > > > > >
> > > > > > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > > > > > ---
> > > > > >
> > > > > > [snip]
> > > > > >
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * devapc_extract_vio_dbg - extract full violation informati=
on after doing
> > > > > > > + *                          shift mechanism.
> > > > > > > + */
> > > > > > > +static void devapc_extract_vio_dbg(struct mtk_devapc_context=
 *ctx)
> > > > > > > +{
> > > > > > > +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> > > > > > > +       struct mtk_devapc_vio_info *vio_info;
> > > > > > > +       void __iomem *vio_dbg0_reg;
> > > > > > > +       void __iomem *vio_dbg1_reg;
> > > > > > > +       u32 dbg0;
> > > > > > > +
> > > > > > > +       vio_dbg0_reg =3D ctx->devapc_pd_base + ctx->offset->v=
io_dbg0;
> > > > > > > +       vio_dbg1_reg =3D ctx->devapc_pd_base + ctx->offset->v=
io_dbg1;
> > > > > > > +
> > > > > > > +       vio_dbgs =3D ctx->vio_dbgs;
> > > > > > > +       vio_info =3D ctx->vio_info;
> > > > > > > +
> > > > > > > +       /* Starts to extract violation information */
> > > > > > > +       dbg0 =3D readl(vio_dbg0_reg);
> > > > > > > +       vio_info->vio_addr =3D readl(vio_dbg1_reg);
> > > > > > > +
> > > > > > > +       vio_info->master_id =3D (dbg0 & vio_dbgs->mstid.mask)=
 >>
> > > > > > > +                             vio_dbgs->mstid.start;
> > > > > >
> > > > > > What is master_id? How could we use it to debug? For example, i=
f we
> > > > > > get a master_id =3D 1, what should we do for this?
> > > > > >
> > > > > > > +       vio_info->domain_id =3D (dbg0 & vio_dbgs->dmnid.mask)=
 >>
> > > > > > > +                             vio_dbgs->dmnid.start;
> > > > > >
> > > > > > What is domain_id? How could we use it to debug? For example, i=
f we
> > > > > > get a domain_id =3D 2, what should we do for this?
> > > > > >
> > > > >
> > > > > master_id and domain_id belongs our bus side-band signal info. It=
 can
> > > > > help us to find the violation master.
> > > >
> > > > Does 'violation master' means the hardware could access the protect=
ed
> > > > register? (ex. CPU, GCE, ...) If so, I think it's better to add
> > > > comment to explain how to map (master_id, domain_id) to a hardware
> > > > (maybe the device in device tree) because every body does not know
> > > > what the number means. Don't try to translate the number to a strin=
g
> > > > because this would cost much time to do this. Just print a number a=
nd
> > > > we could find out the master by the comment.
> > >
> > > 'violation master' means the master which violates the permission
> > > control. For example, if we set permission 'Secure R/W only' as CPU t=
o
> > > spi register. When violation is triggered, it means CPU access spi
> > > register through normal world instead of secure world, which is not
> > > allowed.
> > >
> > > 'master_id' cannot use the simple comments to describe which master i=
t
> > > is. It depends on violation slaves. For example, if there are two
> > > violations:
> > > 1. CPU access spi reg
> > > 2. CPU access timer reg
> > > It might be different 'master_id' for CPU on these two cases.
> > > I would prefer to remain the id number if translate to a string is a =
bad
> > > idea.
> > > Thanks !
> >
> > It seams that master_id and domain_id does not help for debug. When we
> > get master_id =3D 1 and domain_id =3D 2, we don't know what it mean. I
> > think we just need violation address because we could find the driver
> > that write this address and the bug would be inside this driver. So
> > need not to process master_id and domain_id.
> >
>
> Actually, it does help us for debug. violation master is not CPU only.
> It might be any other master in our SoC. So the bug might not be inside
> the kernel driver.
> I'll prefer to remain this information.
> Thanks !

Let maintainer to make decision. Maybe he like to print magic number
and wait for someone to hack it.

>
> > Regards,
> > Chun-Kuang.
> >
> > >
> > > >
> > > > >
> > > > > > > +       vio_info->write =3D ((dbg0 & vio_dbgs->vio_w.mask) >>
> > > > > > > +                           vio_dbgs->vio_w.start) =3D=3D 1;
> > > > > > > +       vio_info->read =3D ((dbg0 & vio_dbgs->vio_r.mask) >>
> > > > > > > +                         vio_dbgs->vio_r.start) =3D=3D 1;
> > > > > > > +       vio_info->vio_addr_high =3D (dbg0 & vio_dbgs->addr_h.=
mask) >>
> > > > > > > +                                 vio_dbgs->addr_h.start;
> > > > > >
> > > > > > What is vio_addr_high? As I know all register address are 32 bi=
ts, is
> > > > > > vio_addr_high the address above 32 bits?
> > > > >
> > > > > Yes, you are right. In MT6779, all register base are 32 bits. We =
can
> > > > > ignore this info for current driver. I'll update on next patch.
> > > > > Thanks !
> > > >
> > > > Such a strange hardware, all register is 32 bits but it has a
> > > > vio_addr_high in its register. OK, just drop this.
> > > >
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +       devapc_vio_info_print(ctx);
> > > > > > > +}
> > > > > > > +
> > > > > >
>
