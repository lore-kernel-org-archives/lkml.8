Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A380BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DC8206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586015216;
	bh=WJRemwJCqzpDcI6pJ9JuFYK2/3qEZkXB/hThgp1+WDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EerOKW+hy2l4hE/1WS8SzwJYBddgiOXBnM14H6rWSizPhkiHFnSMiAC9xq879sggn
	 gVDziKkJZBShlrTBdgde5AJfb/X4poiDiwx6rdc5benFqDU1MzZerEaPAVI1NksaqS
	 Bk1dsnliCvcUqBUpXvTk2wWYtGkeAccFj8nPn0DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDDPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDDPqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:46:55 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97845206C3;
        Sat,  4 Apr 2020 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586015213;
        bh=WJRemwJCqzpDcI6pJ9JuFYK2/3qEZkXB/hThgp1+WDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TIYkobiaZmaasIZmR6h4Q1DdVRaXr1785QzuvlU9dd/AoXtDZ6Y0gBE1O/ewnwcjE
         rWVoc0dI+EKeV6zAte9vbrxi9Lo23C/DePzk6Z0mJtfRIDD5DV55QNHbG+ZiesJxbY
         gdN7yfQg8uqBJ5y2O1MJxFjDwHv5KGoNL/G9WFyc=
Received: by mail-ed1-f45.google.com with SMTP id c7so5386842edl.2;
        Sat, 04 Apr 2020 08:46:53 -0700 (PDT)
X-Gm-Message-State: AGi0PuaDS8rHkM5X1LG7d4E4ZLeL/kfvp56LG+IooSDIKBqs0V042c3+
        9O+d0SRlh4h3FXHhCM9f4074eTnUKojoVX106g==
X-Google-Smtp-Source: APiQypK7z+HsfAmBbW8fRL2j4biTCkMbLc7PDBmY54QJwJhjpBtAQh3RlWcMHGlQ9VeMeZHePyRCYJTqhyjeIPOpuk0=
X-Received: by 2002:a05:6402:335:: with SMTP id q21mr3140080edw.47.1586015212120;
 Sat, 04 Apr 2020 08:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331082725.81048-1-jitao.shi@mediatek.com> <20200331082725.81048-4-jitao.shi@mediatek.com>
In-Reply-To: <20200331082725.81048-4-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 4 Apr 2020 23:46:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=uyfSYms_F=T8guvB9Bx9V=Pjo1TtmmfihMgSj1dt9Q@mail.gmail.com>
Message-ID: <CAAOTY_9=uyfSYms_F=T8guvB9Bx9V=Pjo1TtmmfihMgSj1dt9Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/mediatek: add the mipitx driving control
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=8831=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add a property in device tree to control the driving by different
> board.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 14 ++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  1 +
>  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c |  7 +++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/med=
iatek/mtk_mipi_tx.c
> index e4d34484ecc8..e301af64809e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> @@ -125,6 +125,20 @@ static int mtk_mipi_tx_probe(struct platform_device =
*pdev)
>                 return ret;
>         }
>
> +       ret =3D of_property_read_u32(dev->of_node, "drive-strength-microa=
mp",
> +                                  &mipi_tx->mipitx_drive);
> +       /* If can't get the "mipi_tx->mipitx_drive", set it default 0x8 *=
/
> +       if (ret < 0)
> +               mipi_tx->mipitx_drive =3D 4600;
> +
> +       /* check the mipitx_drive valid */
> +       if (mipi_tx->mipitx_drive > 6000 || mipi_tx->mipitx_drive < 3000)=
 {
> +               dev_warn(dev, "drive-strength-microamp is invalid %d, not=
 in 3000 ~ 6000\n",
> +                        mipi_tx->mipitx_drive);
> +               mipi_tx->mipitx_drive =3D clamp_val(mipi_tx->mipitx_drive=
, 3000,
> +                                                 6000);
> +       }
> +
>         ref_clk_name =3D __clk_get_name(ref_clk);
>
>         ret =3D of_property_read_string(dev->of_node, "clock-output-names=
",
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/gpu/drm/med=
iatek/mtk_mipi_tx.h
> index 413f35d86219..eea44327fe9f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> @@ -27,6 +27,7 @@ struct mtk_mipi_tx {
>         struct device *dev;
>         void __iomem *regs;
>         u32 data_rate;
> +       u32 mipitx_drive;
>         const struct mtk_mipitx_data *driver_data;
>         struct clk_hw pll_hw;
>         struct clk *pll;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/gpu/=
drm/mediatek/mtk_mt8183_mipi_tx.c
> index 91f08a351fd0..e4cc967750cb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> @@ -17,6 +17,9 @@
>  #define RG_DSI_BG_CORE_EN              BIT(7)
>  #define RG_DSI_PAD_TIEL_SEL            BIT(8)
>
> +#define MIPITX_VOLTAGE_SEL     0x0010
> +#define RG_DSI_HSTX_LDO_REF_SEL                (0xf << 6)
> +
>  #define MIPITX_PLL_PWR         0x0028
>  #define MIPITX_PLL_CON0                0x002c
>  #define MIPITX_PLL_CON1                0x0030
> @@ -123,6 +126,10 @@ static void mtk_mipi_tx_power_on_signal(struct phy *=
phy)
>         mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_E=
N);
>         mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_E=
N);
>
> +       mtk_mipi_tx_update_bits(mipi_tx, MIPITX_VOLTAGE_SEL,
> +                               RG_DSI_HSTX_LDO_REF_SEL,
> +                               (mipi_tx->mipitx_drive - 3000) / 200 << 6=
);
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
