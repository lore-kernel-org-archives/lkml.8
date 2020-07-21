Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305ADC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061982073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595373712;
	bh=wTtpSu1n6XAQfccXsXj/yy7BEmnVf2cxowLIgXfPQa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yiTM98G/LdtvbOl89QxT4l4T0Bb4TdkAcUPUDqVNXBAHIv1T2Oq9eovacWIUXmYIP
	 pg9qfVX4+DYoc7PVjokvXVWCktUJpkHdPW+WjjBsLok7Ndd+41HueFpgzSnB2s2Cs3
	 m4m6bPbwYm+TJxXZePba3Gbbaiz9CiriiMcAF7Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgGUXVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGUXVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:21:50 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BC22080D;
        Tue, 21 Jul 2020 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595373709;
        bh=wTtpSu1n6XAQfccXsXj/yy7BEmnVf2cxowLIgXfPQa4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=djoyGjsek9zMyt+FdnK+r8Y+Y8cE0QjaJAoFygr9S3udNk1aNJSn3lr74jFf5KJyu
         tg8mPdg5E5OYS3dphKNMC5RAnzA2UeSmPG64dn12GcDwmnxFONm6KNtlXosq/uf84A
         BBAVo1jrC1P8LjZHeGqFxI5/no69+m2Sstbl8PbM=
Received: by mail-ed1-f47.google.com with SMTP id d18so269800edv.6;
        Tue, 21 Jul 2020 16:21:49 -0700 (PDT)
X-Gm-Message-State: AOAM533bYGPV78gVJ/7FiGDwU3ik+K88+GZ45DtHoL+Fr0hz9vTo6OOm
        Y3n/LwlcePqe1h3chQSGsP4MxwQ3aeuExx4B/w==
X-Google-Smtp-Source: ABdhPJyyEjrBpd1nx1mUcLsn4M9oTcaAX99uq6R42dxNbGcxMzW6I48C2eM3ctFpN3ScOSRXnd6gohvyg/yKTe1Y26k=
X-Received: by 2002:a05:6402:16c7:: with SMTP id r7mr28579038edx.288.1595373707856;
 Tue, 21 Jul 2020 16:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com> <1595303971-8793-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1595303971-8793-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 22 Jul 2020 07:21:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
Message-ID: <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: mediatek: add mtk-devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8821=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=BC=9A
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
> +static u32 get_shift_group(struct mtk_devapc_context *ctx, u32 vio_idx)

vio_idx is useless, so remove it.

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
> +       return 31;
> +}
> +

[snip]

> +
> +/*
> + * mtk_devapc_dump_vio_dbg - get the violation index and dump the full v=
iolation
> + *                           debug information.
> + */
> +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_context *ctx, u32 =
vio_idx)
> +{
> +       u32 shift_bit;
> +
> +       if (check_vio_mask(ctx, vio_idx))
> +               return false;
> +
> +       if (!check_vio_status(ctx, vio_idx))
> +               return false;
> +
> +       shift_bit =3D get_shift_group(ctx, vio_idx);
> +
> +       if (sync_vio_dbg(ctx, shift_bit))
> +               return false;
> +
> +       devapc_extract_vio_dbg(ctx);

I think get_shift_group(), sync_vio_dbg(), and
devapc_extract_vio_dbg() should be moved out of vio_idx for-loop (the
loop in devapc_violation_irq()) because these three function is not
related to vio_idx.
Another question: when multiple vio_idx violation occur, vio_addr is
related to which one vio_idx? The latest happened one?

> +
> +       return true;
> +}
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
> +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++) {
> +               if (!mtk_devapc_dump_vio_dbg(ctx, vio_idx))
> +                       continue;
> +
> +               /* Ensure that violation info are written before
> +                * further operations
> +                */
> +               smp_mb();
> +
> +               /*
> +                * Mask slave's irq before clearing vio status.
> +                * Must do it to avoid nested interrupt and prevent
> +                * unexpected behavior.
> +                */
> +               mask_module_irq(ctx, vio_idx, true);
> +
> +               clear_vio_status(ctx, vio_idx);
> +
> +               mask_module_irq(ctx, vio_idx, false);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/*
> + * start_devapc - initialize devapc status and start receiving interrupt
> + *                while devapc violation is triggered.
> + */
> +static int start_devapc(struct mtk_devapc_context *ctx)
> +{
> +       void __iomem *pd_vio_shift_sta_reg;
> +       void __iomem *pd_apc_con_reg;
> +       u32 vio_shift_sta;
> +       u32 vio_idx;
> +
> +       pd_apc_con_reg =3D ctx->devapc_pd_base + ctx->offset->apc_con;
> +       pd_vio_shift_sta_reg =3D ctx->devapc_pd_base + ctx->offset->vio_s=
hift_sta;
> +       if (!pd_apc_con_reg || !pd_vio_shift_sta_reg)
> +               return -EINVAL;
> +
> +       /* Clear devapc violation status */
> +       writel(BIT(31), pd_apc_con_reg);
> +
> +       /* Clear violation shift status */
> +       vio_shift_sta =3D readl(pd_vio_shift_sta_reg);
> +       if (vio_shift_sta)
> +               writel(vio_shift_sta, pd_vio_shift_sta_reg);
> +
> +       /* Clear slave violation status */
> +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++) {
> +               clear_vio_status(ctx, vio_idx);
> +               mask_module_irq(ctx, vio_idx, false);
> +       }
> +

Why do you clear these? After power on hardware, I think these
register status are correct. If the default value of these register
are not correct, add a comment for this.

Regards,
Chun-Kuang.

> +       return 0;
> +}
> +
