Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2CAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0412073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594299719;
	bh=svdZb33Y7t1B2vg6ybn6AQgGBJfX7TqitPVoZxOAkL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GWN4kSupNULeqPSOixlDfpe5RMnnhpsOrOXFZDu244qtIzE6N1iUE5fz9Lj0WvDbA
	 N7Hw2uc4Yc4MDLjZiDuiRGILQQy6AuT3G8ZXH04K/mNjAPkqNohG8StLC22LHrLRvE
	 8g9ETXuxQFZhtL4Bg98wT4dmWpIV5+jNaUzJVJbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGINB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgGINB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:01:58 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A602074B;
        Thu,  9 Jul 2020 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594299717;
        bh=svdZb33Y7t1B2vg6ybn6AQgGBJfX7TqitPVoZxOAkL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tfp0iRBHR5aRvFS09s+qOKpZQFFKbB2kScnHzox4/rJKRdocXBIsmZ28HBb3wD6CE
         fKw6nsoiJUi2ZgfsRnVpWaI7fWnNz2BK3OkaPyeUML/jj6UJmVbe7il6EwRsOjeAHl
         W+g1fWQZWJ2nrfLleVShsmjfFnoDtyXOcL1gBhhc=
Received: by mail-ed1-f54.google.com with SMTP id n2so1730626edr.5;
        Thu, 09 Jul 2020 06:01:57 -0700 (PDT)
X-Gm-Message-State: AOAM531XottZPZ54EVzF+PXn3u8/ydbF+5YVDQ6YqPFAoZzBubK2eANN
        a87iVplwo2Gv7sMR0YpOrIXSUv7qGWwoOLbdBQ==
X-Google-Smtp-Source: ABdhPJwXcokw3x2lqWpS4cVqHBkCVCiRJ+sqhgLCVDH335FOjvxmmxIFTWC0erzNbub7XMGUoCnGTGG4fug7NRxffhU=
X-Received: by 2002:a05:6402:1766:: with SMTP id da6mr69654748edb.48.1594299715658;
 Thu, 09 Jul 2020 06:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com> <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 9 Jul 2020 21:01:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-7PwoPG_0ce2p4BCNQ3rundg40Bsni14XSmVETExkKkw@mail.gmail.com>
Message-ID: <CAAOTY_-7PwoPG_0ce2p4BCNQ3rundg40Bsni14XSmVETExkKkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: add mtk-devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:13=E5=AF=AB=E9=81=93=EF=BC=9A
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
> +static u32 get_shift_group(struct mtk_devapc_context *devapc_ctx,
> +                          int slave_type, int vio_idx)

vio_idx  is useless, so remove it.

> +{
> +       u32 vio_shift_sta;
> +       void __iomem *reg;
> +       int bit;
> +
> +       reg =3D mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_SHIFT_STA, =
0);
> +       vio_shift_sta =3D readl(reg);
> +
> +       for (bit =3D 0; bit < 32; bit++) {
> +               if ((vio_shift_sta >> bit) & 0x1)
> +                       break;
> +       }
> +
> +       return bit;
> +}
> +

[snip]

> +
> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) wil=
l dump
> + *                       violation information including which master vi=
olates
> + *                       access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number,
> +                                       struct mtk_devapc_context *devapc=
_ctx)
> +{
> +       const struct mtk_device_info **device_info;
> +       int slave_type_num;
> +       int vio_idx =3D -1;
> +       int slave_type;
> +
> +       slave_type_num =3D devapc_ctx->slave_type_num;
> +       device_info =3D devapc_ctx->device_info;
> +
> +       for (slave_type =3D 0; slave_type < slave_type_num; slave_type++)=
 {

If slave_type_num is 1, I think the code should be simpler.

> +               if (!mtk_devapc_dump_vio_dbg(devapc_ctx, slave_type, &vio=
_idx))
> +                       continue;
> +
> +               /* Ensure that violation info are written before
> +                * further operations
> +                */
> +               smp_mb();
> +
> +               mask_module_irq(devapc_ctx, slave_type, vio_idx, true);

Why do you mask irq?

> +
> +               clear_vio_status(devapc_ctx, slave_type, vio_idx);
> +
> +               mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/*
> + * start_devapc - initialize devapc status and start receiving interrupt
> + *               while devapc violation is triggered.
> + */

[snip]

> +
> +struct mtk_device_info {
> +       int sys_index;

Useless, so remove it.

> +       int ctrl_index;

Ditto.

Regards,
Chun-Kuang.

> +       int vio_index;
> +};
> +
