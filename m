Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9EAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA32B20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596125678;
	bh=0aMZNuZZ87P262TCTl7JTgVhH1Sd45zJlDg8CK8T17s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L4dFRo8lcz+HV0N2Of9bAHlOeBWVj8SPe70ZACl+lflItA54t0pRHt8mGoiD6uP+G
	 M6Q9xGWagIHJC58ou9NGH3QOy6DVajKPgBqDky0Yfk0WLgN0NTfdKI0SliZ9zs8JJy
	 Ylq27MQ2wDo94beIbmJ610V6a5FRKTYrTCNmh+Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgG3QOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:14:35 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA43D21744;
        Thu, 30 Jul 2020 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596125675;
        bh=0aMZNuZZ87P262TCTl7JTgVhH1Sd45zJlDg8CK8T17s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yiVMnIgskP2MdSlOX5zT5x+tdbya179aoYyaCEUrpUeGda7zpzQRm9WryG6OIZHzA
         m/MrEV0bMeZUKvzKnFR1Wo1BPiQE8tzfxC+sAOpcPVu29Gx58+xwFLr/PQ3DXj4l2w
         du6EYkGprZwG2z3Gz7OpHBMHrOXCAV3rV9UcyfHY=
Received: by mail-ed1-f46.google.com with SMTP id q4so17149966edv.13;
        Thu, 30 Jul 2020 09:14:34 -0700 (PDT)
X-Gm-Message-State: AOAM532t83zsQOxGeKaKLY2sGB1cFsaCdRjDOFOzzjOll0REJ1m+vPZY
        m0npOMeJkDkv5bp/lGuqcI3Va+fqDhRvyVTF9Q==
X-Google-Smtp-Source: ABdhPJwikWp3DYvBmgsqn1L0ZzeeaYzTNHPPSdjPh1WXVqu2um+iA+5qm3sBHbdE8aAs96kerq91GTmOIdCNqsF3R2I=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr3509657edv.271.1596125673214;
 Thu, 30 Jul 2020 09:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com> <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 31 Jul 2020 00:14:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9HXv+OsSRF7P9=cRy9AYZ0vwffgo3Kc8V=qQ6ce90uJw@mail.gmail.com>
Message-ID: <CAAOTY_9HXv+OsSRF7P9=cRy9AYZ0vwffgo3Kc8V=qQ6ce90uJw@mail.gmail.com>
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


I would like to define the type of ctx->vio_info to be

struct mtk_devapc_vio_dbgs {
    u32 mstid:16;
    u32 dmnid:6;
    u32 vio_w:1;
    u32 vio_r:1;
    u32 addr_h:4;
    u32 resv:4;
};

so the code would like the simple way

ctx->vio_info =3D (struct mtk_devapc_vio_dbgs)readl(vio_dbg1_reg);

Regards,
Chun-Kuang.

> +
> +       devapc_vio_info_print(ctx);
> +}
> +
