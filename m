Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AB4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D2F207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589901026;
	bh=cDO81NBWR5JNkUDn06ROcvMZX+vtmK43mTmgDiFGwlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XB+FFJGeTcuwfqM17bCrRObm6yzjWMcFoOLl5cCby6kw+K6ixevlXSho92Qhdto86
	 zQ3ad8QT4E8UAeiQ4VHlwkmxIWkgcM5AkCRfK5wtlX4heb02KkiqDeRZyX0e9UECdf
	 WQjyklIA1BoUN3ILCA2B+OE4HjrcneUnvDpy8rGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgESPKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgESPKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:10:24 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87492207FB;
        Tue, 19 May 2020 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589901023;
        bh=cDO81NBWR5JNkUDn06ROcvMZX+vtmK43mTmgDiFGwlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KYO1BVfG+R7kOpXoOmTAywsE0eiQsXss/NsSSgXJJjE3FHVJ9XnLrnHRjI2nXsvYf
         j1ys4f0Hr2/RAFw/0wbpP0QBwvnC76RP0kBoHkHzXNeyznPxdLUN6+eRLduEyLs0fv
         zK+V8OYpIDgB3wCdnBU8d7d9VH9tjhJAzhK1Dtfc=
Received: by mail-ej1-f52.google.com with SMTP id s21so12234207ejd.2;
        Tue, 19 May 2020 08:10:23 -0700 (PDT)
X-Gm-Message-State: AOAM530AAiJFq9KvC4ggUKrJbxwe6v9ZeNWMb9XwFuqV3EfelOWAiHt4
        F7o8EmxFr5GqEYY5dS6Nj5LQcyM5jhxdHTWOJA==
X-Google-Smtp-Source: ABdhPJyhbV15yj67Zc07chzoIXRKEsVO7rqxl9HErvPnhH7lppKJMsefvURisxOzEimO9K8QU/uJGq8sP+RlLOQJFNs=
X-Received: by 2002:a17:907:2649:: with SMTP id ar9mr18714534ejc.375.1589901021958;
 Tue, 19 May 2020 08:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200518113156.25009-1-matthias.bgg@kernel.org> <20200518113156.25009-3-matthias.bgg@kernel.org>
In-Reply-To: <20200518113156.25009-3-matthias.bgg@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 19 May 2020 23:10:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY_80D6ZMM5_nEyf_XDjOLaWCOyi3mn9ibWhNX8_ozPK1BQ@mail.gmail.com>
Message-ID: <CAAOTY_80D6ZMM5_nEyf_XDjOLaWCOyi3mn9ibWhNX8_ozPK1BQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk/soc: mediatek: mt6779: Bind clock driver from
 platform device
To:     matthias.bgg@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

<matthias.bgg@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8818=E6=97=A5 =E9=
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> The mmsys driver is now the top level entry point for the multimedia
> system (mmsys), we bind the clock driver by creating a platform device.
> We also bind the MediaTek DRM driver which is not yet implement and
> therefor will errror out for now.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>
>  drivers/clk/mediatek/clk-mt6779-mm.c | 9 ++-------
>  drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/=
clk-mt6779-mm.c
> index fb5fbb8e3e41..059c1a41ac7a 100644
> --- a/drivers/clk/mediatek/clk-mt6779-mm.c
> +++ b/drivers/clk/mediatek/clk-mt6779-mm.c
> @@ -84,15 +84,11 @@ static const struct mtk_gate mm_clks[] =3D {
>         GATE_MM1(CLK_MM_DISP_OVL_FBDC, "mm_disp_ovl_fbdc", "mm_sel", 16),
>  };
>
> -static const struct of_device_id of_match_clk_mt6779_mm[] =3D {
> -       { .compatible =3D "mediatek,mt6779-mmsys", },
> -       {}
> -};
> -
>  static int clk_mt6779_mm_probe(struct platform_device *pdev)
>  {
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *node =3D dev->parent->of_node;
>         struct clk_onecell_data *clk_data;
> -       struct device_node *node =3D pdev->dev.of_node;
>
>         clk_data =3D mtk_alloc_clk_data(CLK_MM_NR_CLK);
>
> @@ -106,7 +102,6 @@ static struct platform_driver clk_mt6779_mm_drv =3D {
>         .probe =3D clk_mt6779_mm_probe,
>         .driver =3D {
>                 .name =3D "clk-mt6779-mm",
> -               .of_match_table =3D of_match_clk_mt6779_mm,
>         },
>  };
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index fee64c8d3020..dc15808cf3a3 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -88,6 +88,10 @@ static const struct mtk_mmsys_driver_data mt2712_mmsys=
_driver_data =3D {
>         .clk_driver =3D "clk-mt2712-mm",
>  };
>
> +static const struct mtk_mmsys_driver_data mt6779_mmsys_driver_data =3D {
> +       .clk_driver =3D "clk-mt6779-mm",

This patch looks good to me, but I've one question: why drm driver
just use single "mediatek-drm" for sub driver name, but clock driver
has different name for each SoC?
Could we just use single name for clock driver such as "mediatek-clk-mm"?

Regards,
Chun-Kuang.

> +};
> +
>  static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data =3D {
>         .clk_driver =3D "clk-mt6797-mm",
>  };
> @@ -343,6 +347,10 @@ static const struct of_device_id of_match_mtk_mmsys[=
] =3D {
>                 .compatible =3D "mediatek,mt2712-mmsys",
>                 .data =3D &mt2712_mmsys_driver_data,
>         },
> +       {
> +               .compatible =3D "mediatek,mt6779-mmsys",
> +               .data =3D &mt6779_mmsys_driver_data,
> +       },
>         {
>                 .compatible =3D "mediatek,mt6797-mmsys",
>                 .data =3D &mt6797_mmsys_driver_data,
> --
> 2.26.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
