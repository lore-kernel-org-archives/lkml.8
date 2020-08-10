Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F0EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E7D20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597101301;
	bh=P9CJfEyiOT7Igx/c3tpoCndruqP8PEyy267r4NIn7o8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZuOmK58Dw2fqHZjJ63D6dzKyPmWOXEWsVEcKGBLuiY9MToL8t7dp9qyRkPcxTqBq7
	 EGXqs6Jt+b3hj+0h+B914xN/nAICcmb+Xr/zIQAljmQDhQq7AuTodeA2VlTGGmkBCd
	 gZVGh2Cz7edceuKA+fA1FErHVh8a6YO0XbfFgwAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHJXPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHJXPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:15:00 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0052075D;
        Mon, 10 Aug 2020 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597101298;
        bh=P9CJfEyiOT7Igx/c3tpoCndruqP8PEyy267r4NIn7o8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dDaXUeULgPRAnVceedtxw6PH3WX2JZmKEILgfY2VgCf4Me1e2y8srWGk+Ms+IaEIH
         X4arEx9tAdempJCXOmQrIj8WkbCDuHdUq0WmhJKoylCcO6HrtSQPVpYfjaegzHGagF
         3VOQJ57mRGv9ZpNZTZFUR8y/JJSzKjma9dZ2JqKs=
Received: by mail-ej1-f54.google.com with SMTP id d6so11101843ejr.5;
        Mon, 10 Aug 2020 16:14:57 -0700 (PDT)
X-Gm-Message-State: AOAM533fVcexwRUHphs58ou9Lb3lBlK4rkrl2ERwCuFrkbGvdR0uD4LF
        ObvJtE439BJxk/aX6d5c8cDcnxvsrlMlwr/p5g==
X-Google-Smtp-Source: ABdhPJzo2B7Z0tm/Ctdynuvck42y/X0/Q6r+ZRzwsVj9txXuzpfbBq1UP4nN4YN/T0sbcVSfh+ejSsqjJnlWJM1N72s=
X-Received: by 2002:a17:906:f14f:: with SMTP id gw15mr23054505ejb.245.1597101296467;
 Mon, 10 Aug 2020 16:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <1596766948-29767-1-git-send-email-neal.liu@mediatek.com>
 <1596766948-29767-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8dhV8Ns4w9SqSpA7BvRO1gLn=hgRWU-hCJjNM6ZJf+rw@mail.gmail.com>
 <1597030994.7823.5.camel@mtkswgap22>
In-Reply-To: <1597030994.7823.5.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 11 Aug 2020 07:14:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY__dYy2yN5MHNJP5=_v48oVWPu2GRZW=EuKT=-U1Pfu7wQ@mail.gmail.com>
Message-ID: <CAAOTY__dYy2yN5MHNJP5=_v48oVWPu2GRZW=EuKT=-U1Pfu7wQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] soc: mediatek: add mt6779 devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Fri, 2020-08-07 at 23:52 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:34=E5=AF=AB=E9=81=93=EF=BC=
=9A
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
> > > +#define PHY_DEVAPC_TIMEOUT     0x10000
> > > +
> > > +/*
> > > + * devapc_sync_vio_dbg - do "shift" mechansim" to get full violation=
 information.
> > > + *                       shift mechanism is depends on devapc hardwa=
re design.
> > > + *                       Mediatek devapc set multiple slaves as a gr=
oup.
> > > + *                       When violation is triggered, violation info=
 is kept
> > > + *                       inside devapc hardware.
> > > + *                       Driver should do shift mechansim to sync fu=
ll violation
> > > + *                       info to VIO_DBGs registers.
> > > + *
> > > + */
> > > +static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
> > > +{
> > > +       void __iomem *pd_vio_shift_sta_reg;
> > > +       void __iomem *pd_vio_shift_sel_reg;
> > > +       void __iomem *pd_vio_shift_con_reg;
> > > +       int min_shift_group;
> > > +       int ret;
> > > +       u32 val;
> > > +
> > > +       pd_vio_shift_sta_reg =3D ctx->infra_base +
> > > +                              ctx->data->vio_shift_sta_offset;
> > > +       pd_vio_shift_sel_reg =3D ctx->infra_base +
> > > +                              ctx->data->vio_shift_sel_offset;
> > > +       pd_vio_shift_con_reg =3D ctx->infra_base +
> > > +                              ctx->data->vio_shift_con_offset;
> > > +
> > > +       /* Find the minimum shift group which has violation */
> > > +       val =3D readl(pd_vio_shift_sta_reg);
> > > +       if (!val)
> > > +               return false;
> > > +
> > > +       min_shift_group =3D __ffs(val);
> > > +
> > > +       /* Assign the group to sync */
> > > +       writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);
> > > +
> > > +       /* Start syncing */
> > > +       writel(0x1, pd_vio_shift_con_reg);
> > > +
> > > +       ret =3D readl_poll_timeout(pd_vio_shift_con_reg, val, val =3D=
=3D 0x3, 0,
> > > +                                PHY_DEVAPC_TIMEOUT);
> > > +       if (ret) {
> > > +               dev_err(ctx->dev, "%s: Shift violation info failed\n"=
, __func__);
> > > +               return false;
> > > +       }
> > > +
> > > +       /* Stop syncing */
> > > +       writel(0x0, pd_vio_shift_con_reg);
> > > +       writel(0x0, pd_vio_shift_sel_reg);
> >
> > This is redundant because you set this register before start syncing.
>
> No, we don't set this reg before start syncing.
>

I'm talking about pd_vio_shift_sel_reg, and I find this before start syncin=
g:

       /* Assign the group to sync */
       writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);

       /* Start syncing */
       writel(0x1, pd_vio_shift_con_reg);

> >
> > > +       writel(0x1 << min_shift_group, pd_vio_shift_sta_reg);
> >
> > You read this register to find minimum shift group, but you write it
> > back into this register, so this function would get the same minimum
> > shift group in next time, isn't it?
>
> No. The operation means write clear. We won't get the same minimum shift
> group after clear this bit.
>

Add comment for this because this is not trivial.

> >
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +/*
> > > + * devapc_extract_vio_dbg - extract full violation information after=
 doing
> > > + *                          shift mechanism.
> > > + */
> > > +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
> > > +{
> > > +       struct mtk_devapc_vio_dbgs *vio_dbgs;
> >
> > struct mtk_devapc_vio_dbgs vio_dbgs;
> >
> > Use stack instead of allocating from heap.
>
> Why it cannot use heap if the memory is handled correctly?
>

You could use heap but allocating memory from heap would cost much
time. In the worst case, it would trigger buddy system to break a page
for slub. Using stack cost almost no time, but it has some limitation.
Stack memory is small and it should be used for local variable, and
vio_dbgs match this limitation, so stack is better than heap.

> >
> > > +       void __iomem *vio_dbg0_reg;
> > > +       void __iomem *vio_dbg1_reg;
> > > +
> > > +       vio_dbgs =3D devm_kzalloc(ctx->dev, sizeof(struct mtk_devapc_=
vio_dbgs),
> > > +                               GFP_KERNEL);
> > > +       if (!vio_dbgs)
> > > +               return;
> > > +
> > > +       vio_dbg0_reg =3D ctx->infra_base + ctx->data->vio_dbg0_offset=
;
> > > +       vio_dbg1_reg =3D ctx->infra_base + ctx->data->vio_dbg1_offset=
;
> > > +
> > > +       vio_dbgs->vio_dbg0 =3D readl(vio_dbg0_reg);
> > > +       vio_dbgs->vio_dbg1 =3D readl(vio_dbg1_reg);
> > > +
> > > +       /* Print violation information */
> > > +       if (vio_dbgs->dbg0_bits.vio_w)
> > > +               dev_info(ctx->dev, "Write Violation\n");
> > > +       else if (vio_dbgs->dbg0_bits.vio_r)
> > > +               dev_info(ctx->dev, "Read Violation\n");
> > > +
> > > +       dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n=
",
> > > +                vio_dbgs->dbg0_bits.mstid, vio_dbgs->dbg0_bits.dmnid=
,
> > > +                vio_dbgs->vio_dbg1);
> > > +}
> > > +
> >
> > [snip]
> >
> > > +
> > > +static int mtk_devapc_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device_node *node =3D pdev->dev.of_node;
> > > +       struct mtk_devapc_context *ctx;
> > > +       u32 devapc_irq;
> > > +       int ret;
> > > +
> > > +       if (IS_ERR(node))
> > > +               return -ENODEV;
> > > +
> > > +       ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> > > +       if (!ctx)
> > > +               return -ENOMEM;
> > > +
> > > +       ctx->data =3D of_device_get_match_data(&pdev->dev);
> > > +       ctx->dev =3D &pdev->dev;
> > > +
> > > +       ctx->infra_base =3D of_iomap(node, 0);
> > > +       if (!ctx->infra_base)
> > > +               return -EINVAL;
> > > +
> > > +       devapc_irq =3D irq_of_parse_and_map(node, 0);
> > > +       if (!devapc_irq)
> > > +               return -EINVAL;
> > > +
> > > +       ctx->infra_clk =3D devm_clk_get(&pdev->dev, "devapc-infra-clo=
ck");
> > > +       if (IS_ERR(ctx->infra_clk))
> > > +               return -EINVAL;
> > > +
> > > +       if (clk_prepare_enable(ctx->infra_clk))
> > > +               return -EINVAL;
> > > +
> > > +       ret =3D devm_request_irq(&pdev->dev, devapc_irq,
> > > +                              (irq_handler_t)devapc_violation_irq,
> > > +                              IRQF_TRIGGER_NONE, "devapc", ctx);
> > > +       if (ret) {
> > > +               clk_disable_unprepare(ctx->infra_clk);
> > > +               return ret;
> > > +       }
> > > +
> > > +       platform_set_drvdata(pdev, ctx);
> > > +
> > > +       start_devapc(ctx);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mtk_devapc_remove(struct platform_device *pdev)
> > > +{
> > > +       struct mtk_devapc_context *ctx =3D platform_get_drvdata(pdev)=
;
> > > +
> >
> > stop_devapc(ctx);
>
> We don't have to do any further operations to stop devapc hw.
>

After this driver is removed, I think we should restore hardware to
the status before probing. Before probe(), devapc hardware is stopped
(pd_apc_con_reg is a default value and all vio irq is masked), so it
should be the same status after remove(). This concept is the same as
what you do for infra_clk.

Regards,
Chun-Kuang.

> >
> > Regards,
> > Chun-Kuang.
> >
> > > +       if (ctx->infra_clk)
> > > +               clk_disable_unprepare(ctx->infra_clk);
> > > +
> > > +       return 0;
> > > +}
> > > +
>
