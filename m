Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F7C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 00:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED31F21927
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587254743;
	bh=33JbAin6PHGhZptu6f59hi3G6ZY0jAf3vYhmJbelnZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D7tZgzvQ7LvyvsVGF5nqorsPTJmv8cFrtCbt/jQamNHXhQzDow9mSMO++FaI18M1L
	 qZlTX4WfnnU9K1qdLxcD/QJTY+BHz8tRnWvbfeQzsQnfldC38WzsP7QrqLQsIcC6Dq
	 WAFsyRgCqc6yJ8CDjTuI6uCyMZJUt1Na55i7y4RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgDSAFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 20:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgDSAFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 20:05:41 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B6F21927;
        Sun, 19 Apr 2020 00:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587254740;
        bh=33JbAin6PHGhZptu6f59hi3G6ZY0jAf3vYhmJbelnZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c9xI/fMRrcCukMve30jKP7r7lyu297B6dvw7fDLsnxAk0jCkSrNEksbOCz01+CiDu
         R577ZnyWYoRCO6QuICusA9MpUTHxL3PJLH7hCDic/CkbCyLXgSUKwFzRzsPzMiEYtP
         F3K1YJev2Eb60V4Lzt5htapSgfInfmQlorxGoWO0=
Received: by mail-ej1-f43.google.com with SMTP id s9so4751126eju.1;
        Sat, 18 Apr 2020 17:05:40 -0700 (PDT)
X-Gm-Message-State: AGi0PuYDB/39/LLAOVLZZDoOU9rxKh1pZU19x3AEIoOTHJf7lSfih2Wa
        OEbTdATtTQy1mbHT7aSilu2nMqOP52cv66vdPQ==
X-Google-Smtp-Source: APiQypIULvFRzFBMzFkL3EtwUTFi+ypYZd5hhQkN2Wb/68KrYZ5++frnyfAGznqAC6oplPRSjpCJI0G+9kqCx9X0Rjk=
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr9757904ejb.201.1587254738804;
 Sat, 18 Apr 2020 17:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200415011319.25559-1-jitao.shi@mediatek.com> <20200415011319.25559-4-jitao.shi@mediatek.com>
In-Reply-To: <20200415011319.25559-4-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 19 Apr 2020 08:05:26 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Ym8m-PEiwXyJkw=knHRjEMyqRe-jCzm0=o7vB-x1JGw@mail.gmail.com>
Message-ID: <CAAOTY_-Ym8m-PEiwXyJkw=knHRjEMyqRe-jCzm0=o7vB-x1JGw@mail.gmail.com>
Subject: Re: [PATCH v15 3/3] drm/mediatek: set dpi pin mode to gpio low to
 avoid leakage current
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Config dpi pins mode to output and pull low when dpi is disabled.
> Aovid leakage current from some dpi pins (Hsync Vsync DE ... ).

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,Chun-Kuang.

>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 31 +++++++++++++++++++++++++++++++
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
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
