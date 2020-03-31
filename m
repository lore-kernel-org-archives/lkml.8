Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD6C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA3220787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585697314;
	bh=l7zMYSntV7hVq8rfpu63wjGejX5IPF+uFcD9Vs6O3I8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Pb1Ava4ZqeisulIS5FLYEKBdwcIOzMPGLcFW+fc/UCNFIF01f7gBza9p+w/VIxOXy
	 /tTnRxyEfJulird2gzb5feivhOQ4QyaNNl0IhZi62cxwLqoXsX5z22gJw5IVrSs7kI
	 E2Y8CLvy4g6o/NJirl3z74BdsYcjAJhZwZaG5uBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgCaX2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbgCaX2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:28:32 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3645421775;
        Tue, 31 Mar 2020 23:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585697311;
        bh=l7zMYSntV7hVq8rfpu63wjGejX5IPF+uFcD9Vs6O3I8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MUvJi6wRPlDITY6PDh0q/OLcS+7pn4GJTp71mf2egrupLmdVom35B4dl/FNfYMSL9
         jvuFOF66rSY6u/g+qJ+tdnewpVmwV4npcvCkbIEEJWd7iaq1I5cAeVEpwD4jZxO/Cs
         hA9NxsSqQJa8j8pW9q2zjQp8YdQnPB3oIcVKIFO8=
Received: by mail-ed1-f42.google.com with SMTP id v1so27439172edq.8;
        Tue, 31 Mar 2020 16:28:31 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1WbiKQBqDbRGog6Jos6daIlZONkXFc1y5l4XjoDpwT5Q3yFw+e
        tbWJRh9HY3FQ61F4Ropx7/cfdMTxaxi5TA25EA==
X-Google-Smtp-Source: ADFU+vs8xTP/4fNCKc/Lkxq6axyfNY0WeUUpH6PAk0Z4p/Dm89IelQXjsghn8yHY1mTBx4UE/MzCvvq1r5Omz1grjaY=
X-Received: by 2002:a05:6402:b70:: with SMTP id cb16mr6166633edb.48.1585697309577;
 Tue, 31 Mar 2020 16:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214609.1742152-1-enric.balletbo@collabora.com> <20200331214609.1742152-3-enric.balletbo@collabora.com>
In-Reply-To: <20200331214609.1742152-3-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 1 Apr 2020 07:28:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-wt1shM7RGTquTmej3VeCNXUy9ByxN+T56qDYG-MeJeA@mail.gmail.com>
Message-ID: <CAAOTY_-wt1shM7RGTquTmej3VeCNXUy9ByxN+T56qDYG-MeJeA@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk / soc: mediatek: Bind clock and gpu driver for mt2701
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, CK Hu <ck.hu@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        ulrich.hecht+renesas@gmail.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        hsinyi@chromium.org, linux-kernel@vger.kernel.org,
        Richard Fontana <rfontana@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-mediatek@lists.infradead.org,
        Allison Randal <allison@lohutok.net>, matthias.bgg@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B44=E6=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:47=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Now that the mmsys driver is the top-level entry point for the
> multimedia subsystem, we could bind the clock and the gpu driver on
> those devices that is expected to work, so the drm driver is
> intantiated by the mmsys driver and display, hopefully, working again.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> If you have this hardware, please kindly provide your tested tag. Only
> build tested.
>
>  drivers/clk/mediatek/clk-mt2701-mm.c | 8 ++------
>  drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/=
clk-mt2701-mm.c
> index 054b597d4a73..3a4e895a3d0f 100644
> --- a/drivers/clk/mediatek/clk-mt2701-mm.c
> +++ b/drivers/clk/mediatek/clk-mt2701-mm.c
> @@ -79,16 +79,12 @@ static const struct mtk_gate mm_clks[] =3D {
>         GATE_DISP1(CLK_MM_TVE_FMM, "mm_tve_fmm", "mm_sel", 14),
>  };
>
> -static const struct of_device_id of_match_clk_mt2701_mm[] =3D {
> -       { .compatible =3D "mediatek,mt2701-mmsys", },
> -       {}
> -};
> -
>  static int clk_mt2701_mm_probe(struct platform_device *pdev)
>  {
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *node =3D dev->parent->of_node;
>         struct clk_onecell_data *clk_data;
>         int r;
> -       struct device_node *node =3D pdev->dev.of_node;
>
>         clk_data =3D mtk_alloc_clk_data(CLK_MM_NR);
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index c7d3b7bcfa32..cacafe23c823 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -80,6 +80,10 @@ struct mtk_mmsys_driver_data {
>         const char *clk_driver;
>  };
>
> +static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
> +       .clk_driver =3D "clk-mt2701-mm",
> +};
> +
>  static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data =3D {
>         .clk_driver =3D "clk-mt2712-mm",
>  };
> @@ -323,6 +327,10 @@ static int mtk_mmsys_probe(struct platform_device *p=
dev)
>  }
>
>  static const struct of_device_id of_match_mtk_mmsys[] =3D {
> +       {
> +               .compatible =3D "mediatek,mt2701-mmsys",
> +               .data =3D &mt2701_mmsys_driver_data,
> +       },
>         {
>                 .compatible =3D "mediatek,mt2712-mmsys",
>                 .data =3D &mt2712_mmsys_driver_data,
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
