Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450C32065C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596062840;
	bh=klKSOlHcs2r4bmzNnXq4Xe7PD5R3XSNJtVynCtjaa0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Wo6iI9ODJEx0MWahG27RBdfgVH8SJ/kRQgau+X1ITlLdQdoTkU4dlg14BfqZA2X4j
	 oMWK1d48WR8gmW580VS/7ZF+yN8WzgexpwxoV5ce1p3VRUvqryKJI8eic7FkoP3ZzX
	 aOXfNWDpWZfnkzyxpeA6snfioBRt8eHBR0DOSTYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgG2WrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgG2WrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:47:18 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD952065C;
        Wed, 29 Jul 2020 22:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596062837;
        bh=klKSOlHcs2r4bmzNnXq4Xe7PD5R3XSNJtVynCtjaa0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bTjVUwRNfsJ/7uTGgyRRg1z3+JU0qI0OB5rY12sGpsidiDlNpQSN27Q19r0zoJBTO
         doyvq0VJDH4q029N6VuBGFZ+u18PFnHyhf3sDffhaLdMIBH4MfLtbCWCIcPuzL7yy3
         RNX19oqaG1v+X+9gVEoTjmgcWAXScP/vlhrfisrQ=
Received: by mail-ej1-f46.google.com with SMTP id qc22so11193323ejb.4;
        Wed, 29 Jul 2020 15:47:16 -0700 (PDT)
X-Gm-Message-State: AOAM530Yn/k3gj2RXvpJVBuPGL7oaGG3B3DYfaq1uhCysHaW2+SIfFPc
        fFyG5ro5NWEQVPcOSlSETze9pv0kdTBtbO0rJg==
X-Google-Smtp-Source: ABdhPJxlUf8wHtgaUmw1RVqJVXI8FHcJjTmdLWj3e6c9lhjXZckNQ/gauu5X7cH8Pd2kVqvteU1A6h6RdHuTocMEk34=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr527342ejb.187.1596062835563;
 Wed, 29 Jul 2020 15:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com> <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 30 Jul 2020 06:47:04 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9dqcQdZd5x9ckE67KKh-4d_5gN9MQYDq7b4vGCWwHoDw@mail.gmail.com>
Message-ID: <CAAOTY_9dqcQdZd5x9ckE67KKh-4d_5gN9MQYDq7b4vGCWwHoDw@mail.gmail.com>
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

[snip]

> +
> +static void devapc_vio_info_print(struct mtk_devapc_context *ctx)
> +{
> +       struct mtk_devapc_vio_info *vio_info =3D ctx->vio_info;
> +
> +       /* Print violation information */
> +       if (vio_info->write)
> +               dev_info(ctx->dev, "Write Violation\n");
> +       else if (vio_info->read)
> +               dev_info(ctx->dev, "Read Violation\n");
> +
> +       dev_info(ctx->dev, "Vio Addr:0x%x, High:0x%x, Bus ID:0x%x, Dom ID=
:%x\n",
> +                vio_info->vio_addr, vio_info->vio_addr_high,
> +                vio_info->master_id, vio_info->domain_id);
> +}

devapc_vio_info_print() is small function and only called by
devapc_extract_vio_dbg(), so I would like to merge this function into
devapc_extract_vio_dbg() and you could drop struct mtk_devapc_vio_info
because its member are all local variable.

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
> +       vio_info->domain_id =3D (dbg0 & vio_dbgs->dmnid.mask) >>
> +                             vio_dbgs->dmnid.start;
> +       vio_info->write =3D ((dbg0 & vio_dbgs->vio_w.mask) >>
> +                           vio_dbgs->vio_w.start) =3D=3D 1;
> +       vio_info->read =3D ((dbg0 & vio_dbgs->vio_r.mask) >>
> +                         vio_dbgs->vio_r.start) =3D=3D 1;
> +       vio_info->vio_addr_high =3D (dbg0 & vio_dbgs->addr_h.mask) >>
> +                                 vio_dbgs->addr_h.start;
> +
> +       devapc_vio_info_print(ctx);
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
> +       u32 vio_idx;
> +
> +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++)
> +               mask_module_irq(ctx, vio_idx, false);

Are these bits default true? If they are default false, you need not
to setup it to false again.

> +}
> +

[snip]

> diff --git a/drivers/soc/mediatek/mtk-devapc.h b/drivers/soc/mediatek/mtk=
-devapc.h
> new file mode 100644
> index 0000000..7bd7e66
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-devapc.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_DEVAPC_H__
> +#define __MTK_DEVAPC_H__
> +
> +#define VIO_MOD_TO_REG_IND(m)  ((m) / 32)
> +#define VIO_MOD_TO_REG_OFF(m)  ((m) % 32)
> +
> +struct mtk_devapc_pd_offset {
> +       u32 vio_mask;
> +       u32 vio_sta;
> +       u32 vio_dbg0;
> +       u32 vio_dbg1;
> +       u32 apc_con;
> +       u32 vio_shift_sta;
> +       u32 vio_shift_sel;
> +       u32 vio_shift_con;
> +};
> +
> +struct mtk_devapc_vio_dbgs_desc {
> +       u32 mask;
> +       u32 start;
> +};
> +
> +struct mtk_devapc_vio_dbgs {
> +       struct mtk_devapc_vio_dbgs_desc mstid;
> +       struct mtk_devapc_vio_dbgs_desc dmnid;
> +       struct mtk_devapc_vio_dbgs_desc vio_w;
> +       struct mtk_devapc_vio_dbgs_desc vio_r;
> +       struct mtk_devapc_vio_dbgs_desc addr_h;
> +};
> +
> +struct mtk_devapc_vio_info {
> +       bool read;
> +       bool write;
> +       u32 vio_addr;
> +       u32 vio_addr_high;
> +       u32 master_id;
> +       u32 domain_id;
> +};
> +
> +struct mtk_devapc_context {
> +       struct device *dev;
> +       u32 vio_idx_num;
> +       void __iomem *devapc_pd_base;
> +       struct mtk_devapc_vio_info *vio_info;
> +       const struct mtk_devapc_pd_offset *offset;
> +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> +};
> +
> +#endif /* __MTK_DEVAPC_H__ */

Data in this header file is only used in mtk-devapc.c and mtk-devapc.c
is a small file, so I think it's better to move data in header file
into .c file to make code simpler.

Regards,
Chun-Kuang.
