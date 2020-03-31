Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F157C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457C20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585697252;
	bh=x7DzV0s4ROjdZWJe2RxSIJB/ii7d/wsIeF2JinMwFOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hS6LLvL7b93XzvPWncU+6Cqd4JaFjvc7BSu3SRCmj9Q+g2YbgnoTLrrsv7gwYoaSH
	 JeQ77/9J0EHhE/7EcPLChkGO/pCfUdnjSjUMQWUcj6EcsILWl/+QFiigxQPttljLFN
	 no2zmc2xp9gFOmyNfo/ACnd0nKwQGFZx179ceXUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgCaX1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbgCaX1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:27:30 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B758320CC7;
        Tue, 31 Mar 2020 23:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585697249;
        bh=x7DzV0s4ROjdZWJe2RxSIJB/ii7d/wsIeF2JinMwFOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0xWtKYorfntJUn3zsbp0ID4Nl7w4wPpnZO5Ggo8YLC3vMGTIxNDHex5Hd9S2Qltpd
         nZuYpuIZWwZzhl09dXzcPj3wemdniZPT8qIfIyFahD2+ug3yUOrGMLmzgVHPaHUZX0
         WRzXsVyRAKP+T6V8EVv46Y/i8io7KfBvZvibs6jQ=
Received: by mail-ed1-f54.google.com with SMTP id v1so27436829edq.8;
        Tue, 31 Mar 2020 16:27:28 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0pRsqcwLGK0L7ktCg6jTPD/SxbJUCHsO1U6CJOPPnfIM45+7I5
        4Q18BpNZNVnStTZIdM6yEbNEYbIcnm8UfPUP7w==
X-Google-Smtp-Source: ADFU+vtBb1KxI4+vTeZ5U2HQ3nMwxxGyWPlJXzhWQefQTTzE7BevfFVF32dfd5Ohkz+crkUGgNF6LeglDGiRNsaNUxQ=
X-Received: by 2002:a50:9f07:: with SMTP id b7mr18189302edf.148.1585697247066;
 Tue, 31 Mar 2020 16:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214609.1742152-1-enric.balletbo@collabora.com> <20200331214609.1742152-2-enric.balletbo@collabora.com>
In-Reply-To: <20200331214609.1742152-2-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 1 Apr 2020 07:27:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9S_tWeB5VAVYv8mtFOgtAqw=9ts+a5ugEkaYFvKujosQ@mail.gmail.com>
Message-ID: <CAAOTY_9S_tWeB5VAVYv8mtFOgtAqw=9ts+a5ugEkaYFvKujosQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk / soc: mediatek: Bind clock and gpu driver for mt2712
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
> intantiated by the mmsys driver and display, hopefully, working again on
> those devices.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> If you have this hardware, please kindly provide your tested tag. Only
> build tested.
>
>  drivers/clk/mediatek/clk-mt2712-mm.c | 8 ++------
>  drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/=
clk-mt2712-mm.c
> index 1c5948be35f3..660c1f63293f 100644
> --- a/drivers/clk/mediatek/clk-mt2712-mm.c
> +++ b/drivers/clk/mediatek/clk-mt2712-mm.c
> @@ -128,9 +128,10 @@ static const struct mtk_gate mm_clks[] =3D {
>
>  static int clk_mt2712_mm_probe(struct platform_device *pdev)
>  {
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *node =3D dev->parent->of_node;
>         struct clk_onecell_data *clk_data;
>         int r;
> -       struct device_node *node =3D pdev->dev.of_node;
>
>         clk_data =3D mtk_alloc_clk_data(CLK_MM_NR_CLK);
>
> @@ -146,11 +147,6 @@ static int clk_mt2712_mm_probe(struct platform_devic=
e *pdev)
>         return r;
>  }
>
> -static const struct of_device_id of_match_clk_mt2712_mm[] =3D {
> -       { .compatible =3D "mediatek,mt2712-mmsys", },
> -       {}
> -};
> -
>  static struct platform_driver clk_mt2712_mm_drv =3D {
>         .probe =3D clk_mt2712_mm_probe,
>         .driver =3D {
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 05e322c9c301..c7d3b7bcfa32 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -80,6 +80,10 @@ struct mtk_mmsys_driver_data {
>         const char *clk_driver;
>  };
>
> +static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data =3D {
> +       .clk_driver =3D "clk-mt2712-mm",
> +};
> +
>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data =3D {
>         .clk_driver =3D "clk-mt8173-mm",
>  };
> @@ -319,6 +323,10 @@ static int mtk_mmsys_probe(struct platform_device *p=
dev)
>  }
>
>  static const struct of_device_id of_match_mtk_mmsys[] =3D {
> +       {
> +               .compatible =3D "mediatek,mt2712-mmsys",
> +               .data =3D &mt2712_mmsys_driver_data,
> +       },
>         {
>                 .compatible =3D "mediatek,mt8173-mmsys",
>                 .data =3D &mt8173_mmsys_driver_data,
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
