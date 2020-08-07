Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED10BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CE22075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596815584;
	bh=t2fo8nswvDUj9OgHJSB/JaXbuihZdBj0/aI3FhdbsfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IT+3aIxs4JGz8CczXnGzBHe/jFT5uqv0n7GqStGHiACTgPxwTKGEj+16qEZvU4pjX
	 njubk/3xf0KEBR/a4jz39d1t3sHZNCdfDwNnzX/uBPfEcarxe++d8e54XGq9LeFhw7
	 yWo2EpYnd450Uij6aD9Z9zgjFgNM/MtjBShseWVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHGPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgHGPxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:53:02 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232EA2224D;
        Fri,  7 Aug 2020 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596815581;
        bh=t2fo8nswvDUj9OgHJSB/JaXbuihZdBj0/aI3FhdbsfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=svUTAYvAhVTToupAthkykPQs2Gi9PP0ArhrzQEgO0qcVFsE5SYa6HSeNKFkQUvBSy
         9d4318C7dNrTi8p/eufc9bCJfiCP6fMwRHWTlTQdg66Fle0mjv0+1xMXI4t4EisJB9
         vATS/ZsaAUttTPWLho8uDpRYRqZvHRKhciV9Ra3w=
Received: by mail-ej1-f45.google.com with SMTP id kq25so2585095ejb.3;
        Fri, 07 Aug 2020 08:53:01 -0700 (PDT)
X-Gm-Message-State: AOAM533Xb/epPrYNIJSEKovlyQlXCNdy4s4NSrWhYoP7C+5M0mKHp7lt
        hwru9qcT0GP94cLIWhE5Iiei3gmEoF2mT74XtQ==
X-Google-Smtp-Source: ABdhPJywPDp7r/UHFFfAdrs9VZgY/N3hDuj3KDipoSAqFEn6JLt3Q7T8qsxFQsxjTQ/zqN2p9P9ZoUU9kLncn+GtEZw=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr9564523ejb.187.1596815579698;
 Fri, 07 Aug 2020 08:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <1596766948-29767-1-git-send-email-neal.liu@mediatek.com> <1596766948-29767-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1596766948-29767-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 7 Aug 2020 23:52:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8dhV8Ns4w9SqSpA7BvRO1gLn=hgRWU-hCJjNM6ZJf+rw@mail.gmail.com>
Message-ID: <CAAOTY_8dhV8Ns4w9SqSpA7BvRO1gLn=hgRWU-hCJjNM6ZJf+rw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MediaTek bus fabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violation is logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by mtk-devapc driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---

[snip]

> +
> +#define PHY_DEVAPC_TIMEOUT     0x10000
> +
> +/*
> + * devapc_sync_vio_dbg - do "shift" mechansim" to get full violation inf=
ormation.
> + *                       shift mechanism is depends on devapc hardware d=
esign.
> + *                       Mediatek devapc set multiple slaves as a group.
> + *                       When violation is triggered, violation info is =
kept
> + *                       inside devapc hardware.
> + *                       Driver should do shift mechansim to sync full v=
iolation
> + *                       info to VIO_DBGs registers.
> + *
> + */
> +static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
> +{
> +       void __iomem *pd_vio_shift_sta_reg;
> +       void __iomem *pd_vio_shift_sel_reg;
> +       void __iomem *pd_vio_shift_con_reg;
> +       int min_shift_group;
> +       int ret;
> +       u32 val;
> +
> +       pd_vio_shift_sta_reg =3D ctx->infra_base +
> +                              ctx->data->vio_shift_sta_offset;
> +       pd_vio_shift_sel_reg =3D ctx->infra_base +
> +                              ctx->data->vio_shift_sel_offset;
> +       pd_vio_shift_con_reg =3D ctx->infra_base +
> +                              ctx->data->vio_shift_con_offset;
> +
> +       /* Find the minimum shift group which has violation */
> +       val =3D readl(pd_vio_shift_sta_reg);
> +       if (!val)
> +               return false;
> +
> +       min_shift_group =3D __ffs(val);
> +
> +       /* Assign the group to sync */
> +       writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);
> +
> +       /* Start syncing */
> +       writel(0x1, pd_vio_shift_con_reg);
> +
> +       ret =3D readl_poll_timeout(pd_vio_shift_con_reg, val, val =3D=3D =
0x3, 0,
> +                                PHY_DEVAPC_TIMEOUT);
> +       if (ret) {
> +               dev_err(ctx->dev, "%s: Shift violation info failed\n", __=
func__);
> +               return false;
> +       }
> +
> +       /* Stop syncing */
> +       writel(0x0, pd_vio_shift_con_reg);
> +       writel(0x0, pd_vio_shift_sel_reg);

This is redundant because you set this register before start syncing.

> +       writel(0x1 << min_shift_group, pd_vio_shift_sta_reg);

You read this register to find minimum shift group, but you write it
back into this register, so this function would get the same minimum
shift group in next time, isn't it?

> +
> +       return true;
> +}
> +
> +/*
> + * devapc_extract_vio_dbg - extract full violation information after doi=
ng
> + *                          shift mechanism.
> + */
> +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
> +{
> +       struct mtk_devapc_vio_dbgs *vio_dbgs;

struct mtk_devapc_vio_dbgs vio_dbgs;

Use stack instead of allocating from heap.

> +       void __iomem *vio_dbg0_reg;
> +       void __iomem *vio_dbg1_reg;
> +
> +       vio_dbgs =3D devm_kzalloc(ctx->dev, sizeof(struct mtk_devapc_vio_=
dbgs),
> +                               GFP_KERNEL);
> +       if (!vio_dbgs)
> +               return;
> +
> +       vio_dbg0_reg =3D ctx->infra_base + ctx->data->vio_dbg0_offset;
> +       vio_dbg1_reg =3D ctx->infra_base + ctx->data->vio_dbg1_offset;
> +
> +       vio_dbgs->vio_dbg0 =3D readl(vio_dbg0_reg);
> +       vio_dbgs->vio_dbg1 =3D readl(vio_dbg1_reg);
> +
> +       /* Print violation information */
> +       if (vio_dbgs->dbg0_bits.vio_w)
> +               dev_info(ctx->dev, "Write Violation\n");
> +       else if (vio_dbgs->dbg0_bits.vio_r)
> +               dev_info(ctx->dev, "Read Violation\n");
> +
> +       dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n",
> +                vio_dbgs->dbg0_bits.mstid, vio_dbgs->dbg0_bits.dmnid,
> +                vio_dbgs->vio_dbg1);
> +}
> +

[snip]

> +
> +/*
> + * start_devapc - unmask slave's irq to start receiving devapc violation=
.
> + */
> +static void start_devapc(struct mtk_devapc_context *ctx)
> +{
> +       void __iomem *pd_apc_con_reg;
> +
> +       pd_apc_con_reg =3D ctx->infra_base + ctx->data->apc_con_offset;
> +       writel(BIT(31), pd_apc_con_reg);

pd_apc_con_reg is used once, so

writel(BIT(31), ctx->infra_base + ctx->data->apc_con_offset);

> +
> +       mask_module_irq(ctx, false);
> +}
> +

[snip]

> +
> +static int mtk_devapc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       struct mtk_devapc_context *ctx;
> +       u32 devapc_irq;
> +       int ret;
> +
> +       if (IS_ERR(node))
> +               return -ENODEV;
> +
> +       ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->data =3D of_device_get_match_data(&pdev->dev);
> +       ctx->dev =3D &pdev->dev;
> +
> +       ctx->infra_base =3D of_iomap(node, 0);
> +       if (!ctx->infra_base)
> +               return -EINVAL;
> +
> +       devapc_irq =3D irq_of_parse_and_map(node, 0);
> +       if (!devapc_irq)
> +               return -EINVAL;
> +
> +       ctx->infra_clk =3D devm_clk_get(&pdev->dev, "devapc-infra-clock")=
;
> +       if (IS_ERR(ctx->infra_clk))
> +               return -EINVAL;
> +
> +       if (clk_prepare_enable(ctx->infra_clk))
> +               return -EINVAL;
> +
> +       ret =3D devm_request_irq(&pdev->dev, devapc_irq,
> +                              (irq_handler_t)devapc_violation_irq,
> +                              IRQF_TRIGGER_NONE, "devapc", ctx);
> +       if (ret) {
> +               clk_disable_unprepare(ctx->infra_clk);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, ctx);
> +
> +       start_devapc(ctx);
> +
> +       return 0;
> +}
> +
> +static int mtk_devapc_remove(struct platform_device *pdev)
> +{
> +       struct mtk_devapc_context *ctx =3D platform_get_drvdata(pdev);
> +

stop_devapc(ctx);

Regards,
Chun-Kuang.

> +       if (ctx->infra_clk)
> +               clk_disable_unprepare(ctx->infra_clk);
> +
> +       return 0;
> +}
> +
