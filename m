Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D33C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D751E206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596040730;
	bh=8oNvq8B3SV3A3JFjqt0Y5/7PhcaYiiGl5V2LNOy8tIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hiz/IK4q7RHl5VqlioHYMRPbDpVIKXv3zptkF183tG87vMzLks/zOCF60vDhyWgsA
	 sjJ9qJ3gOSHbRpdOun1VTThxUJd6kxXB+gwr3BKAPI/unxRk5GqKjPpOIrw9jCUo7R
	 ukB6w6VC2p936cGAKPZLqx64rrgaNz/bRmlaomYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgG2Qit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgG2Qit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:38:49 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ACC62082E;
        Wed, 29 Jul 2020 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596040727;
        bh=8oNvq8B3SV3A3JFjqt0Y5/7PhcaYiiGl5V2LNOy8tIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cu/0rdka2lGfSrU7gukTXUZnpgaLWsSWlqWDp3qIVvFvJeP/IiHJHLhz1a2mCAoig
         JFS6f46dE13il445jB006N/KDm6lEvZrbOlPYwueKLAPcXjR2fp8Jol12LijkR8XOo
         65qiEP5G47eTgEcAdCA/6w43ZADkdxQ3M/tmMbPM=
Received: by mail-ed1-f46.google.com with SMTP id o18so3461408eds.10;
        Wed, 29 Jul 2020 09:38:47 -0700 (PDT)
X-Gm-Message-State: AOAM533DB/gmixizIdPE4SfvmQsdrfp29mgS4ZKnVjhhcfOB4kIufxo5
        NgjszFsob6SjgjyPHjHcYnZjn+14uyhtEZGQ8w==
X-Google-Smtp-Source: ABdhPJxkSFThDgGSV2/ZhZg3JnPMa8grf6H5kaG+74I6FiJViMGqy+UloZpqzSpAUGKT+mzbLJ+N3YjfuJ08V9uTtqI=
X-Received: by 2002:aa7:c31a:: with SMTP id l26mr30665374edq.61.1596040725806;
 Wed, 29 Jul 2020 09:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com> <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 30 Jul 2020 00:38:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8bE8Qo5-0MA9J1gcEbN4DP=Wf2O6vOUVos=VkoODeayA@mail.gmail.com>
Message-ID: <CAAOTY_8bE8Qo5-0MA9J1gcEbN4DP=Wf2O6vOUVos=VkoODeayA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=BC=9A
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
> +static int get_shift_group(struct mtk_devapc_context *ctx)
> +{
> +       u32 vio_shift_sta;
> +       void __iomem *reg;
> +
> +       reg =3D ctx->devapc_pd_base + ctx->offset->vio_shift_sta;
> +       vio_shift_sta =3D readl(reg);
> +
> +       if (vio_shift_sta)
> +               return __ffs(vio_shift_sta);
> +
> +       return -EIO;
> +}

get_shift_group() is a small function, I would like to merge this
function into sync_vio_dbg() to make code more simple.

> +

[snip]

> +
> +#define PHY_DEVAPC_TIMEOUT     0x10000
> +
> +/*
> + * sync_vio_dbg - do "shift" mechansim" to get full violation informatio=
n.
> + *                shift mechanism is depends on devapc hardware design.
> + *                Mediatek devapc set multiple slaves as a group. When v=
iolation
> + *                is triggered, violation info is kept inside devapc har=
dware.
> + *                Driver should do shift mechansim to "shift" full viola=
tion
> + *                info to VIO_DBGs registers.
> + *
> + */
> +static int sync_vio_dbg(struct mtk_devapc_context *ctx, u32 shift_bit)
> +{
> +       void __iomem *pd_vio_shift_sta_reg;
> +       void __iomem *pd_vio_shift_sel_reg;
> +       void __iomem *pd_vio_shift_con_reg;
> +       int ret;
> +       u32 val;
> +
> +       pd_vio_shift_sta_reg =3D ctx->devapc_pd_base + ctx->offset->vio_s=
hift_sta;
> +       pd_vio_shift_sel_reg =3D ctx->devapc_pd_base + ctx->offset->vio_s=
hift_sel;
> +       pd_vio_shift_con_reg =3D ctx->devapc_pd_base + ctx->offset->vio_s=
hift_con;
> +
> +       /* Enable shift mechansim */
> +       writel(0x1 << shift_bit, pd_vio_shift_sel_reg);
> +       writel(0x1, pd_vio_shift_con_reg);
> +
> +       ret =3D readl_poll_timeout(pd_vio_shift_con_reg, val, val =3D=3D =
0x3, 0,
> +                                PHY_DEVAPC_TIMEOUT);
> +       if (ret)
> +               dev_err(ctx->dev, "%s: Shift violation info failed\n", __=
func__);
> +
> +       /* Disable shift mechanism */
> +       writel(0x0, pd_vio_shift_con_reg);
> +       writel(0x0, pd_vio_shift_sel_reg);
> +       writel(0x1 << shift_bit, pd_vio_shift_sta_reg);
> +
> +       return ret;
> +}
> +

[snip]

> +
> +/*
> + * devapc_extract_vio_dbg - extract full violation information after doi=
ng
> + *                          shift mechanism.
> + */
> +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
> +{
> +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> +       struct mtk_devapc_vio_info *vio_info;
> +       void __iomem *vio_dbg0_reg;
> +       void __iomem *vio_dbg1_reg;
> +       u32 dbg0;
> +
> +       vio_dbg0_reg =3D ctx->devapc_pd_base + ctx->offset->vio_dbg0;
> +       vio_dbg1_reg =3D ctx->devapc_pd_base + ctx->offset->vio_dbg1;
> +
> +       vio_dbgs =3D ctx->vio_dbgs;
> +       vio_info =3D ctx->vio_info;
> +
> +       /* Starts to extract violation information */
> +       dbg0 =3D readl(vio_dbg0_reg);
> +       vio_info->vio_addr =3D readl(vio_dbg1_reg);
> +
> +       vio_info->master_id =3D (dbg0 & vio_dbgs->mstid.mask) >>
> +                             vio_dbgs->mstid.start;

What is master_id? How could we use it to debug? For example, if we
get a master_id =3D 1, what should we do for this?

> +       vio_info->domain_id =3D (dbg0 & vio_dbgs->dmnid.mask) >>
> +                             vio_dbgs->dmnid.start;

What is domain_id? How could we use it to debug? For example, if we
get a domain_id =3D 2, what should we do for this?

> +       vio_info->write =3D ((dbg0 & vio_dbgs->vio_w.mask) >>
> +                           vio_dbgs->vio_w.start) =3D=3D 1;
> +       vio_info->read =3D ((dbg0 & vio_dbgs->vio_r.mask) >>
> +                         vio_dbgs->vio_r.start) =3D=3D 1;
> +       vio_info->vio_addr_high =3D (dbg0 & vio_dbgs->addr_h.mask) >>
> +                                 vio_dbgs->addr_h.start;

What is vio_addr_high? As I know all register address are 32 bits, is
vio_addr_high the address above 32 bits?

> +
> +       devapc_vio_info_print(ctx);
> +}
> +

[snip]

> +
> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) wil=
l dump
> + *                        violation information including which master v=
iolates
> + *                        access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number,
> +                                       struct mtk_devapc_context *ctx)
> +{
> +       u32 vio_idx;
> +
> +       /*
> +        * Mask slave's irq before clearing vio status.
> +        * Must do it to avoid nested interrupt and prevent
> +        * unexpected behavior.
> +        */
> +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++)
> +               mask_module_irq(ctx, vio_idx, true);

I would like to rewrite this for-loop as below to prevent too many
function call in irq handler.

for (i =3D 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num); i++)
    writel(0xffffffff, ctx->devapc_pd_base + ctx->offset->vio_mask + 4 * i)=
;

reg  =3D readl(ctx->devapc_pd_base + ctx->offset->vio_mask + 4 * i);
reg |=3D 1 << (ctx->vio_idx_num - 32 * i + 1) - 1;
writel(reg, ctx->devapc_pd_base + ctx->offset->vio_mask + 4 * i);

> +
> +       devapc_dump_vio_dbg(ctx);
> +
> +       /*
> +        * Ensure that violation info are written
> +        * before further operations
> +        */
> +       smp_mb();
> +
> +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++) {
> +               clear_vio_status(ctx, vio_idx);
> +               mask_module_irq(ctx, vio_idx, false);
> +       }

Ditto for this for-loop.

> +
> +       return IRQ_HANDLED;
> +}
> +

[snip]

> +
> +static int mtk_devapc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       struct mtk_devapc_context *ctx;
> +       struct clk *devapc_infra_clk;
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
> +       ctx =3D (struct mtk_devapc_context *)of_device_get_match_data(&pd=
ev->dev);
> +       ctx->dev =3D &pdev->dev;
> +
> +       ctx->vio_info =3D devm_kzalloc(&pdev->dev,
> +                                    sizeof(struct mtk_devapc_vio_info),
> +                                    GFP_KERNEL);
> +       if (!ctx->vio_info)
> +               return -ENOMEM;
> +
> +       ctx->devapc_pd_base =3D of_iomap(node, 0);
> +       if (!ctx->devapc_pd_base)
> +               return -EINVAL;
> +
> +       devapc_irq =3D irq_of_parse_and_map(node, 0);
> +       if (!devapc_irq)
> +               return -EINVAL;
> +
> +       devapc_infra_clk =3D devm_clk_get(&pdev->dev, "devapc-infra-clock=
");
> +       if (IS_ERR(devapc_infra_clk))
> +               return -EINVAL;
> +
> +       if (clk_prepare_enable(devapc_infra_clk))
> +               return -EINVAL;
> +
> +       ret =3D devm_request_irq(&pdev->dev, devapc_irq,
> +                              (irq_handler_t)devapc_violation_irq,
> +                              IRQF_TRIGGER_NONE, "devapc", ctx);
> +       if (ret)

You should clk_disable_unprepare(devapc_infra_clk);

> +               return ret;
> +
> +       start_devapc(ctx);
> +
> +       return 0;
> +}
> +
> +static int mtk_devapc_remove(struct platform_device *dev)
> +{

Ditto.

Regards,
Chun-Kuang.

> +       return 0;
> +}
> +
> +static struct platform_driver mtk_devapc_driver =3D {
> +       .probe =3D mtk_devapc_probe,
> +       .remove =3D mtk_devapc_remove,
> +       .driver =3D {
> +               .name =3D KBUILD_MODNAME,
> +               .of_match_table =3D mtk_devapc_dt_match,
> +       },
> +};
> +
> +module_platform_driver(mtk_devapc_driver);
> +
