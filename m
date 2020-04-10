Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF53C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC5212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586535151;
	bh=160JUGp3x1fpb1yme+uQZZt6RXsBzoX4rWwBvTmptUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PHU75ZNRvCz6VUzFcD9TKhgUFVX8WP8cMxR52KtWJvvsS7ghToYjoCzMsmdQahCrJ
	 E523CF/dagz1SNRs9kspQytR/oEtjG1seVgjtLnnw5MsehAo5ARMkxejAJyvIX8h48
	 3GQJ25DwnDRPEUKquiuCzd3LEKpkObSLL5Nug2SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJQMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgDJQM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:12:29 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3384212CC;
        Fri, 10 Apr 2020 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586535149;
        bh=160JUGp3x1fpb1yme+uQZZt6RXsBzoX4rWwBvTmptUk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W5wYd2EuxFFOf5RELEUzJliKZesmTsdbiM43S8uvK0l++0HiMbTrQt6XsIAGL4Wns
         y5YgMtu5OtZuC8hYq66rdGRTGWADpy/5wnBH0STWqvG+EhEbo54Rmbhq57vNgA9HDU
         l8ZFGOzumzy1DTerTfgkolsxj0YgGOA/Su1sveIQ=
Received: by mail-ed1-f43.google.com with SMTP id de14so3003852edb.4;
        Fri, 10 Apr 2020 09:12:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuarZuxW884ZAWJt+uvSrSFP3DRcHEmhaK7mY32AFp7VoA3Iy1Kq
        gRG6mKzdhP4Ti01kDR+ocIi5p/yZji2YxccyyA==
X-Google-Smtp-Source: APiQypKcvCktS/0AVOVss/azeh/f4lcTILgqeqaAL4onaaElSMhRA6mYYv8/89RCCzeYggvhT45miRzpgBtQ4McZm4g=
X-Received: by 2002:a05:6402:335:: with SMTP id q21mr5420732edw.47.1586535147130;
 Fri, 10 Apr 2020 09:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200410043248.114384-1-jitao.shi@mediatek.com> <20200410043248.114384-5-jitao.shi@mediatek.com>
In-Reply-To: <20200410043248.114384-5-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 11 Apr 2020 00:12:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-ZiMKn5wVuhECnL4E6BM_=QoF9goorHB-GK-hRL40gyA@mail.gmail.com>
Message-ID: <CAAOTY_-ZiMKn5wVuhECnL4E6BM_=QoF9goorHB-GK-hRL40gyA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] drm/mediatek: config mipitx impedance with
 calibration data
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Read calibration data from nvmem, and config mipitx impedance with
> calibration data to make sure their impedance are 100ohm.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 40 +++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  3 ++
>  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 21 ++++++++++
>  3 files changed, 64 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/med=
iatek/mtk_mipi_tx.c
> index e301af64809e..5e91fc2c1318 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> @@ -88,6 +88,44 @@ static const struct phy_ops mtk_mipi_tx_ops =3D {
>         .owner =3D THIS_MODULE,
>  };
>
> +static void mtk_mipi_tx_get_calibration_datal(struct mtk_mipi_tx *mipi_t=
x)
> +{
> +       struct nvmem_cell *cell;
> +       size_t len;
> +       u32 *buf;
> +
> +       memset(mipi_tx->rt_code, 0, sizeof(mipi_tx->rt_code));

You use kzalloc() to allocate mipi_tx, so this is already zero-initialized.

> +       cell =3D nvmem_cell_get(mipi_tx->dev, "calibration-data");
> +       if (IS_ERR(cell)) {
> +               dev_info(mipi_tx->dev, "can't get nvmem_cell_get, ignore =
it\n");
> +       } else {

If you return when error, you could get rid of the 'else', so you
could reduce many 'tab' and reduce the probability of one line over 80
character.

> +               buf =3D (u32 *)nvmem_cell_read(cell, &len);
> +               nvmem_cell_put(cell);
> +
> +               if (IS_ERR(buf)) {
> +                       dev_info(mipi_tx->dev, "can't get data, ignore it=
\n");
> +               } else {

Ditto.

Regards,
Chun-Kuang.

> +                       if (len < 3 * sizeof(u32)) {
> +                               dev_info(mipi_tx->dev, "invalid calibrati=
on data\n");
> +                               kfree(buf);
> +                               return;
> +                       }
> +
> +                       mipi_tx->rt_code[0] =3D ((buf[0] >> 6 & 0x1f) << =
5) |
> +                                              (buf[0] >> 11 & 0x1f);
> +                       mipi_tx->rt_code[1] =3D ((buf[1] >> 27 & 0x1f) <<=
 5) |
> +                                              (buf[0] >> 1 & 0x1f);
> +                       mipi_tx->rt_code[2] =3D ((buf[1] >> 17 & 0x1f) <<=
 5) |
> +                                              (buf[1] >> 22 & 0x1f);
> +                       mipi_tx->rt_code[3] =3D ((buf[1] >> 7 & 0x1f) << =
5) |
> +                                              (buf[1] >> 12 & 0x1f);
> +                       mipi_tx->rt_code[4] =3D ((buf[2] >> 27 & 0x1f) <<=
 5) |
> +                                              (buf[1] >> 2 & 0x1f);
> +                       kfree(buf);
> +               }
> +       }
> +}
> +
>  static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -174,6 +212,8 @@ static int mtk_mipi_tx_probe(struct platform_device *=
pdev)
>
>         mipi_tx->dev =3D dev;
>
> +       mtk_mipi_tx_get_calibration_datal(mipi_tx);
> +
>         return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>                                    mipi_tx->pll);
>  }
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/gpu/drm/med=
iatek/mtk_mipi_tx.h
> index eea44327fe9f..c76f07c3fdeb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> @@ -12,9 +12,11 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/slab.h>
>
>  struct mtk_mipitx_data {
>         const u32 mppll_preserve;
> @@ -28,6 +30,7 @@ struct mtk_mipi_tx {
>         void __iomem *regs;
>         u32 data_rate;
>         u32 mipitx_drive;
> +       u32 rt_code[5];
>         const struct mtk_mipitx_data *driver_data;
>         struct clk_hw pll_hw;
>         struct clk *pll;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/gpu/=
drm/mediatek/mtk_mt8183_mipi_tx.c
> index e4cc967750cb..9f3e55aeebb2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> @@ -28,6 +28,7 @@
>  #define MIPITX_PLL_CON4                0x003c
>  #define RG_DSI_PLL_IBIAS               (3 << 10)
>
> +#define MIPITX_D2P_RTCODE      0x0100
>  #define MIPITX_D2_SW_CTL_EN    0x0144
>  #define MIPITX_D0_SW_CTL_EN    0x0244
>  #define MIPITX_CK_CKMODE_EN    0x0328
> @@ -108,6 +109,24 @@ static const struct clk_ops mtk_mipi_tx_pll_ops =3D =
{
>         .recalc_rate =3D mtk_mipi_tx_pll_recalc_rate,
>  };
>
> +static void mtk_mipi_tx_config_calibration_data(struct mtk_mipi_tx *mipi=
_tx)
> +{
> +       int i, j;
> +
> +       for (i =3D 0; i < 5; i++) {
> +               if ((mipi_tx->rt_code[i] & 0x1f) =3D=3D 0)
> +                       mipi_tx->rt_code[i] |=3D 0x10;
> +
> +               if ((mipi_tx->rt_code[i] >> 5 & 0x1f) =3D=3D 0)
> +                       mipi_tx->rt_code[i] |=3D 0x10 << 5;
> +
> +               for (j =3D 0; j < 10; j++)
> +                       mtk_mipi_tx_update_bits(mipi_tx,
> +                               MIPITX_D2P_RTCODE * (i + 1) + j * 4,
> +                               1, mipi_tx->rt_code[i] >> j & 1);
> +       }
> +}
> +
>  static void mtk_mipi_tx_power_on_signal(struct phy *phy)
>  {
>         struct mtk_mipi_tx *mipi_tx =3D phy_get_drvdata(phy);
> @@ -130,6 +149,8 @@ static void mtk_mipi_tx_power_on_signal(struct phy *p=
hy)
>                                 RG_DSI_HSTX_LDO_REF_SEL,
>                                 (mipi_tx->mipitx_drive - 3000) / 200 << 6=
);
>
> +       mtk_mipi_tx_config_calibration_data(mipi_tx);
> +
>         mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_=
EN);
>  }
>
> --
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
