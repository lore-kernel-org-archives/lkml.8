Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D076420A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596471219;
	bh=HiU07JR1A+F1+Z53kyhPMkQd/qW5e56jQ2jPVulC8+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BcKeCiu9w3TsBdFzV4Gm/9aPgjZYtEH181TfX6rFGL8Q0dPd4Uy4XubNCyTl90pd1
	 B5HkjdXydFAUGRBpu5ZT6ee+BWsslg/fkAk4gic/yws1XhFDd/fwUqG5VxFDSEmTcT
	 yCEifHiajkGKi08mxBE+nXdkYWx1ZsMNgoIgvXfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHCQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHCQNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:13:39 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9792177B;
        Mon,  3 Aug 2020 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596471217;
        bh=HiU07JR1A+F1+Z53kyhPMkQd/qW5e56jQ2jPVulC8+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5IxzLoGXGhZ8Bs4qDZQdy04EZQYbwGYyq5pZ6j4Y154+ryCc3QMwHdQGC5v1tq34
         4A2h7BH/2Cmd0xibFPwmhNDUoaeGWgtGGAg/l/XlMLE6LQt0g8m2WA7gn23Ll+ewgf
         tIcyXRtGkEbtd56lShh1UKfNr4Icfv8vx+v7EjRM=
Received: by mail-ed1-f47.google.com with SMTP id c15so17971886edj.3;
        Mon, 03 Aug 2020 09:13:38 -0700 (PDT)
X-Gm-Message-State: AOAM531C3bNxd0t4jnJ3tjFqY2g8Cuo5ojtyqNC/ONzD6BxnnEgAQdhp
        QcxVuh52zaOUAT3Xg18+xmrX/2M5UMQg2D+U6w==
X-Google-Smtp-Source: ABdhPJxVBbThlPNq2pTchCAyLxwz7hgBlwFmi8zFSCXl7qnrzYmZzBYIfzjIAbCSg/UXEzg38x48cLfkIWq4AkAuZYg=
X-Received: by 2002:a50:d2c7:: with SMTP id q7mr11624009edg.61.1596471216633;
 Mon, 03 Aug 2020 09:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
 <1596010690-13178-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8bE8Qo5-0MA9J1gcEbN4DP=Wf2O6vOUVos=VkoODeayA@mail.gmail.com>
 <1596163478.3932.17.camel@mtkswgap22> <CAAOTY_9kS+jrCOpZtOs+L8gBzvkewi+cSN7XWGNxuiMQocedFA@mail.gmail.com>
 <1596425521.22971.13.camel@mtkswgap22>
In-Reply-To: <1596425521.22971.13.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 00:13:23 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9UcnSDTaVPDPyPLsWEYcrcq5MY=z520MWtFdeLw_FqGQ@mail.gmail.com>
Message-ID: <CAAOTY_9UcnSDTaVPDPyPLsWEYcrcq5MY=z520MWtFdeLw_FqGQ@mail.gmail.com>
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Fri, 2020-07-31 at 23:03 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8831=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:44=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > >
> > > On Thu, 2020-07-30 at 00:38 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=
=BC=9A
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
> > > > > ---
> > > >
> > > > [snip]
> > > >
> > > > > +
> > > > > +/*
> > > > > + * devapc_extract_vio_dbg - extract full violation information a=
fter doing
> > > > > + *                          shift mechanism.
> > > > > + */
> > > > > +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ct=
x)
> > > > > +{
> > > > > +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> > > > > +       struct mtk_devapc_vio_info *vio_info;
> > > > > +       void __iomem *vio_dbg0_reg;
> > > > > +       void __iomem *vio_dbg1_reg;
> > > > > +       u32 dbg0;
> > > > > +
> > > > > +       vio_dbg0_reg =3D ctx->devapc_pd_base + ctx->offset->vio_d=
bg0;
> > > > > +       vio_dbg1_reg =3D ctx->devapc_pd_base + ctx->offset->vio_d=
bg1;
> > > > > +
> > > > > +       vio_dbgs =3D ctx->vio_dbgs;
> > > > > +       vio_info =3D ctx->vio_info;
> > > > > +
> > > > > +       /* Starts to extract violation information */
> > > > > +       dbg0 =3D readl(vio_dbg0_reg);
> > > > > +       vio_info->vio_addr =3D readl(vio_dbg1_reg);
> > > > > +
> > > > > +       vio_info->master_id =3D (dbg0 & vio_dbgs->mstid.mask) >>
> > > > > +                             vio_dbgs->mstid.start;
> > > >
> > > > What is master_id? How could we use it to debug? For example, if we
> > > > get a master_id =3D 1, what should we do for this?
> > > >
> > > > > +       vio_info->domain_id =3D (dbg0 & vio_dbgs->dmnid.mask) >>
> > > > > +                             vio_dbgs->dmnid.start;
> > > >
> > > > What is domain_id? How could we use it to debug? For example, if we
> > > > get a domain_id =3D 2, what should we do for this?
> > > >
> > >
> > > master_id and domain_id belongs our bus side-band signal info. It can
> > > help us to find the violation master.
> >
> > Does 'violation master' means the hardware could access the protected
> > register? (ex. CPU, GCE, ...) If so, I think it's better to add
> > comment to explain how to map (master_id, domain_id) to a hardware
> > (maybe the device in device tree) because every body does not know
> > what the number means. Don't try to translate the number to a string
> > because this would cost much time to do this. Just print a number and
> > we could find out the master by the comment.
>
> 'violation master' means the master which violates the permission
> control. For example, if we set permission 'Secure R/W only' as CPU to
> spi register. When violation is triggered, it means CPU access spi
> register through normal world instead of secure world, which is not
> allowed.
>
> 'master_id' cannot use the simple comments to describe which master it
> is. It depends on violation slaves. For example, if there are two
> violations:
> 1. CPU access spi reg
> 2. CPU access timer reg
> It might be different 'master_id' for CPU on these two cases.
> I would prefer to remain the id number if translate to a string is a bad
> idea.
> Thanks !

It seams that master_id and domain_id does not help for debug. When we
get master_id =3D 1 and domain_id =3D 2, we don't know what it mean. I
think we just need violation address because we could find the driver
that write this address and the bug would be inside this driver. So
need not to process master_id and domain_id.

Regards,
Chun-Kuang.

>
> >
> > >
> > > > > +       vio_info->write =3D ((dbg0 & vio_dbgs->vio_w.mask) >>
> > > > > +                           vio_dbgs->vio_w.start) =3D=3D 1;
> > > > > +       vio_info->read =3D ((dbg0 & vio_dbgs->vio_r.mask) >>
> > > > > +                         vio_dbgs->vio_r.start) =3D=3D 1;
> > > > > +       vio_info->vio_addr_high =3D (dbg0 & vio_dbgs->addr_h.mask=
) >>
> > > > > +                                 vio_dbgs->addr_h.start;
> > > >
> > > > What is vio_addr_high? As I know all register address are 32 bits, =
is
> > > > vio_addr_high the address above 32 bits?
> > >
> > > Yes, you are right. In MT6779, all register base are 32 bits. We can
> > > ignore this info for current driver. I'll update on next patch.
> > > Thanks !
> >
> > Such a strange hardware, all register is 32 bits but it has a
> > vio_addr_high in its register. OK, just drop this.
> >
> > >
> > > >
> > > > > +
> > > > > +       devapc_vio_info_print(ctx);
> > > > > +}
> > > > > +
> > > >
