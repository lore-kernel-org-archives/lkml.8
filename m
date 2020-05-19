Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93025C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4920756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589847821;
	bh=yXFIXoaaIhCB0WBUDuO8+foBCMcSuBqnKo4TZIde9+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OJcssxM0aiKFRA/LBwwIpiqWvAkFd4guCaUINhgCdGYhCxYAry0bMh1aC46vCGbQn
	 23lvTml+bGGItVG+cvt6rmWCszKAxdIUXIODWg7u5JzU/uK0kIHf6Ug4t3HoLwtZ4Q
	 0AOfmdhhUgWLbGLtLA2NzmU58dCbwvZw0QH2kIiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgESAXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgESAXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:23:40 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC52207E8;
        Tue, 19 May 2020 00:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589847819;
        bh=yXFIXoaaIhCB0WBUDuO8+foBCMcSuBqnKo4TZIde9+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VYkk+hfQEWe2QCIlDVTrL0JzYcHPFEh2pQdt0SJC4kVCkK3WALYEsbyaJdgWQcF6F
         ZQ1Ir+MKj5YNMBlpRtBD5GfHYyxoMlFJREA29gDzJMhBnSfjLFBttiypFO4VGrQPht
         bot2fl/Y2FZV3XsyOX+jXE6j5v20TbVwRNA45tOM=
Received: by mail-ed1-f46.google.com with SMTP id l25so5458677edj.4;
        Mon, 18 May 2020 17:23:39 -0700 (PDT)
X-Gm-Message-State: AOAM531LAZZpOK1nXxecnbMHeoZt2CbO2nn48XqLWa43kHQNyBCmd8kX
        ZhGSlYYW1UFb+6juxFbmh4v9DhxA9QwaYHox+A==
X-Google-Smtp-Source: ABdhPJyrGc6vsnr+WmOKuIm4SqDP52pR/PCq2FPaelMHb8IdDO8nVnID9dGFbWG/aRvWQ0W2/TOp4xkr7PE1zmaiNLM=
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr13610097eds.288.1589847817907;
 Mon, 18 May 2020 17:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200518113156.25009-1-matthias.bgg@kernel.org> <20200518113156.25009-2-matthias.bgg@kernel.org>
In-Reply-To: <20200518113156.25009-2-matthias.bgg@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 19 May 2020 08:23:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-jo3sjsYPD7MPtuyOxN6XZuGJ1Vd_xUrUoBK94maU5ew@mail.gmail.com>
Message-ID: <CAAOTY_-jo3sjsYPD7MPtuyOxN6XZuGJ1Vd_xUrUoBK94maU5ew@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk/soc: mediatek: mt6797: Bind clock driver from
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
        Richard Fontana <rfontana@redhat.com>,
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
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> The mmsys driver is now the top level entry point for the multimedia
> system (mmsys), we bind the clock driver by creating a platform device.
> We also bind the MediaTek DRM driver which is not yet implement and
> therefor will errror out for now.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>
>  drivers/clk/mediatek/clk-mt6797-mm.c | 9 ++-------
>  drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/=
clk-mt6797-mm.c
> index 8f05653b387d..01fdce287247 100644
> --- a/drivers/clk/mediatek/clk-mt6797-mm.c
> +++ b/drivers/clk/mediatek/clk-mt6797-mm.c
> @@ -92,16 +92,12 @@ static const struct mtk_gate mm_clks[] =3D {
>                  "clk26m", 3),
>  };
>
> -static const struct of_device_id of_match_clk_mt6797_mm[] =3D {
> -       { .compatible =3D "mediatek,mt6797-mmsys", },
> -       {}
> -};
> -
>  static int clk_mt6797_mm_probe(struct platform_device *pdev)
>  {
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *node =3D dev->parent->of_node;
>         struct clk_onecell_data *clk_data;
>         int r;
> -       struct device_node *node =3D pdev->dev.of_node;
>
>         clk_data =3D mtk_alloc_clk_data(CLK_MM_NR);
>
> @@ -121,7 +117,6 @@ static struct platform_driver clk_mt6797_mm_drv =3D {
>         .probe =3D clk_mt6797_mm_probe,
>         .driver =3D {
>                 .name =3D "clk-mt6797-mm",
> -               .of_match_table =3D of_match_clk_mt6797_mm,
>         },
>  };
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 783c3dd008b2..fee64c8d3020 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -88,6 +88,10 @@ static const struct mtk_mmsys_driver_data mt2712_mmsys=
_driver_data =3D {
>         .clk_driver =3D "clk-mt2712-mm",
>  };
>
> +static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data =3D {
> +       .clk_driver =3D "clk-mt6797-mm",
> +};
> +
>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data =3D {
>         .clk_driver =3D "clk-mt8173-mm",
>  };
> @@ -339,6 +343,10 @@ static const struct of_device_id of_match_mtk_mmsys[=
] =3D {
>                 .compatible =3D "mediatek,mt2712-mmsys",
>                 .data =3D &mt2712_mmsys_driver_data,
>         },
> +       {
> +               .compatible =3D "mediatek,mt6797-mmsys",
> +               .data =3D &mt6797_mmsys_driver_data,
> +       },
>         {
>                 .compatible =3D "mediatek,mt8173-mmsys",
>                 .data =3D &mt8173_mmsys_driver_data,
> --
> 2.26.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
