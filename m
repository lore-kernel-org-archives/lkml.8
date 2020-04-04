Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03472C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDACB206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586009272;
	bh=/fGwNQGSGd8258j4HpL7qVgnU4jtouS/+Lk1L8UMLa0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qsMWknPGev0q4H++NxQsmxutJLtngK5gb4Kacl1Znn9ZqBM7ICFShDNrEgO50kCi0
	 foqIvGf8m/Qc+H45Nm/VP97HL1Ou6s+/l9x/OFOEoGDQZS7BhNOcJOYYgLLeDMZwoR
	 SUO339rC+Zw0bPOfBpyWpsnOzh4WfTgPEEIrxMKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDDOHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgDDOHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:07:51 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B1E2071C;
        Sat,  4 Apr 2020 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586009271;
        bh=/fGwNQGSGd8258j4HpL7qVgnU4jtouS/+Lk1L8UMLa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y6kx7ZctsdH13Tn2DH/MWaklMItFSw/j1F5h0zFx9Sa4p4YGfwaQNyFCi55i9jn9n
         IXLbICIi/o6HN642XKH/oL+0gGZ6MUMnAi/f/fKnfd45Seui669+Hj7LUS3fzuq2Ng
         B2Ec4WS5K3mgCnmu+njSanerAiao94B2vW673P5Y=
Received: by mail-ed1-f48.google.com with SMTP id cw6so12832626edb.9;
        Sat, 04 Apr 2020 07:07:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuauDL87zVwO7OA4MANJzBdryN3DFY+HZ3H8EFapyk+BUrAX7ZpR
        CpCdYNhrXgAzb5WzhrjeRP3HVy10sT+XE/N2uA==
X-Google-Smtp-Source: APiQypK0S3Kzy+Z7UNvOp7SLCqBUhpNPhPvCjDCuGG8pOnT9BD/0gjPBqrnjz9yHn+AyXpA4LOucO3kSR8nPurmuA+4=
X-Received: by 2002:a17:906:fca4:: with SMTP id qw4mr422751ejb.324.1586009269517;
 Sat, 04 Apr 2020 07:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200403080350.95826-1-jitao.shi@mediatek.com> <20200403080350.95826-4-jitao.shi@mediatek.com>
In-Reply-To: <20200403080350.95826-4-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 4 Apr 2020 22:07:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-FJ9LY6KwnzA+6bb0X=i1VRk8EOvtcM73rfidPhnGdnw@mail.gmail.com>
Message-ID: <CAAOTY_-FJ9LY6KwnzA+6bb0X=i1VRk8EOvtcM73rfidPhnGdnw@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] drm/mediatek: set dpi pin mode to gpio low to
 avoid leakage current
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, huijuan.xie@mediatek.com,
        stonea168@163.com, cawa.cheng@mediatek.com,
        linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Config dpi pins mode to output and pull low when dpi is disabled.
> Aovid leakage current from some dpi pins (Hsync Vsync DE ... ).

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 087f5ce732e1..1e01254788d9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -10,7 +10,9 @@
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>
> @@ -74,6 +76,9 @@ struct mtk_dpi {
>         enum mtk_dpi_out_yc_map yc_map;
>         enum mtk_dpi_out_bit_num bit_num;
>         enum mtk_dpi_out_channel_swap channel_swap;
> +       struct pinctrl *pinctrl;
> +       struct pinctrl_state *pins_gpio;
> +       struct pinctrl_state *pins_dpi;
>         int refcount;
>  };
>
> @@ -379,6 +384,9 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>         if (--dpi->refcount !=3D 0)
>                 return;
>
> +       if (dpi->pinctrl && dpi->pins_gpio)
> +               pinctrl_select_state(dpi->pinctrl, dpi->pins_gpio);
> +
>         mtk_dpi_disable(dpi);
>         clk_disable_unprepare(dpi->pixel_clk);
>         clk_disable_unprepare(dpi->engine_clk);
> @@ -403,6 +411,9 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>                 goto err_pixel;
>         }
>
> +       if (dpi->pinctrl && dpi->pins_dpi)
> +               pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
> +
>         mtk_dpi_enable(dpi);
>         return 0;
>
> @@ -705,6 +716,26 @@ static int mtk_dpi_probe(struct platform_device *pde=
v)
>         dpi->dev =3D dev;
>         dpi->conf =3D (struct mtk_dpi_conf *)of_device_get_match_data(dev=
);
>
> +       dpi->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> +       if (IS_ERR(dpi->pinctrl)) {
> +               dpi->pinctrl =3D NULL;
> +               dev_dbg(&pdev->dev, "Cannot find pinctrl!\n");
> +       }
> +       if (dpi->pinctrl) {
> +               dpi->pins_gpio =3D pinctrl_lookup_state(dpi->pinctrl, "sl=
eep");
> +               if (IS_ERR(dpi->pins_gpio)) {
> +                       dpi->pins_gpio =3D NULL;
> +                       dev_dbg(&pdev->dev, "Cannot find pinctrl idle!\n"=
);
> +               }
> +               if (dpi->pins_gpio)
> +                       pinctrl_select_state(dpi->pinctrl, dpi->pins_gpio=
);
> +
> +               dpi->pins_dpi =3D pinctrl_lookup_state(dpi->pinctrl, "def=
ault");
> +               if (IS_ERR(dpi->pins_dpi)) {
> +                       dpi->pins_dpi =3D NULL;
> +                       dev_dbg(&pdev->dev, "Cannot find pinctrl active!\=
n");
> +               }
> +       }
>         mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         dpi->regs =3D devm_ioremap_resource(dev, mem);
>         if (IS_ERR(dpi->regs)) {
> --
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
