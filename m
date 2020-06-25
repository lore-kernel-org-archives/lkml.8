Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9CB207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593065960;
	bh=YbHGP11pHUX7giQDfbZQIvNPcOxAKEPuTaMFvWI1/mI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MCrE7mWZnMjkgd3fczuEFD+pmCXqp68s8bKkmU7MH4H5aPaqTuUZGaGVzY+IvyXfr
	 66p04HRLQzzO+nrUxGb3X7PGP5ajsp2ONusltRpg0FzO3ZpDVFS1ev01V9FZrh+npU
	 WkOdJUv41y/dvnTIY910SIw9pqhEtjkLpxF7MUOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbgFYGTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389663AbgFYGTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:19:16 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27763207E8;
        Thu, 25 Jun 2020 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593065955;
        bh=YbHGP11pHUX7giQDfbZQIvNPcOxAKEPuTaMFvWI1/mI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yZZ1VTEyTafiT2YXaenbvvrLdDlo6nFFtivq2bXBWSj94Ii9nNCaabS/k/Xi9yKMm
         bXTyiyj2+7xgLAopMan2JLxV7MFY0KFkYmFCuPHveByBaBPRIp21WH48T3z1TWAOEh
         3tV3DmTnBlzIa94uLY8ifxSrlGuF5vHpiTgjqs9s=
Received: by mail-ej1-f51.google.com with SMTP id y10so4790948eje.1;
        Wed, 24 Jun 2020 23:19:15 -0700 (PDT)
X-Gm-Message-State: AOAM530HmvOkzndY/AmQbmYPrPX80mZvn9l3airlkUBPYFAO8tqOlmqj
        Su36iogqXPK06uqcaujx9OTFjsk6S6ptyGN9sA==
X-Google-Smtp-Source: ABdhPJyi7O/XYnvtXHx6vhbw1CBavl9kSew93qwynQ4pKthExCyrXGBoxEehFW4NkW5yOppX2nLWouhaN+4dRcFwtPU=
X-Received: by 2002:a17:906:856:: with SMTP id f22mr18224560ejd.245.1593065953692;
 Wed, 24 Jun 2020 23:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com> <1592559720-8482-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1592559720-8482-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 25 Jun 2020 14:19:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-hfQFL_CRHTC7RxOLSe0BYzWf_f-QUvjBp4JjaAcX1PA@mail.gmail.com>
Message-ID: <CAAOTY_-hfQFL_CRHTC7RxOLSe0BYzWf_f-QUvjBp4JjaAcX1PA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MT6873 bus frabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violations are logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by devapc-mt6873 driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---

[snip]

> +
> +/*
> + * sramrom_vio_handler - clean sramrom violation & print violation infor=
mation
> + *                      for debugging.
> + */
> +static void sramrom_vio_handler(struct mtk_devapc_context *devapc_ctx)
> +{
> +       const struct mtk_sramrom_sec_vio_desc *sramrom_vios;
> +       struct mtk_devapc_vio_info *vio_info;
> +       struct arm_smccc_res res;
> +       size_t sramrom_vio_sta;
> +       int sramrom_vio;
> +       u32 rw;
> +
> +       sramrom_vios =3D devapc_ctx->soc->sramrom_sec_vios;
> +       vio_info =3D devapc_ctx->soc->vio_info;
> +
> +       arm_smccc_smc(MTK_SIP_KERNEL_CLR_SRAMROM_VIO,
> +                     0, 0, 0, 0, 0, 0, 0, &res);
> +

This irq handler call arm_smccc_smc() to get into TrustZone, why not
let the whole irq handler in TrustZone?

Regards,
Chun-Kuang.

> +       sramrom_vio =3D res.a0;
> +       sramrom_vio_sta =3D res.a1;
> +       vio_info->vio_addr =3D res.a2;
> +
> +       if (sramrom_vio =3D=3D SRAM_VIOLATION)
> +               pr_info(PFX "SRAM violation is triggered\n");
> +       else if (sramrom_vio =3D=3D ROM_VIOLATION)
> +               pr_info(PFX "ROM violation is triggered\n");
> +       else
> +               return;
> +
> +       vio_info->master_id =3D (sramrom_vio_sta & sramrom_vios->vio_id_m=
ask)
> +                       >> sramrom_vios->vio_id_shift;
> +       vio_info->domain_id =3D (sramrom_vio_sta & sramrom_vios->vio_doma=
in_mask)
> +                       >> sramrom_vios->vio_domain_shift;
> +       rw =3D (sramrom_vio_sta & sramrom_vios->vio_rw_mask) >>
> +                       sramrom_vios->vio_rw_shift;
> +
> +       if (rw)
> +               vio_info->write =3D 1;
> +       else
> +               vio_info->read =3D 1;
> +
> +       pr_info(PFX "%s: master_id:0x%x, domain_id:0x%x, rw:%s, vio_addr:=
0x%x\n",
> +               __func__, vio_info->master_id, vio_info->domain_id,
> +               rw ? "Write" : "Read", vio_info->vio_addr);
> +}
> +
