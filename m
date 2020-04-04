Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BD3C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4D1206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586010412;
	bh=egczPPyNSD8HotLbj+TT/i75T2plBn3TUuu2sN6zS3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WSqPI+tv6xjtSHhuKOIUl/iX6kUtvFkLyXb6i7DIad+VBIhPMv19zQMu8dJASAx2O
	 tri6dyfMQ8ch2/Se9xiozdpzSdKRB6iI31rHJ5l/a80i2JEQ+2cGAQW1p+GMtRQuOM
	 FeGtoG4w6SOb6bHY/p9TB4o7O9eiAuCBqCAIaPis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgDDO0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDDO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:26:51 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6418D206F5;
        Sat,  4 Apr 2020 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586010410;
        bh=egczPPyNSD8HotLbj+TT/i75T2plBn3TUuu2sN6zS3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0gPEeJ+XZvMo8ohcfXsCnVrjc4mLfTuhLWVb9JY8KT6HBybsFj3GDEzTgReIqyPlg
         bGjgamuimp50/9wk1xP/X0Io6aaRIP9n6iFGdicL5C1fKPc+uLS9eq/YLs2Cv9w3XD
         xqlObbAW63zaaqihKH2BAx8FtT8qBv3lF0xWqQpA=
Received: by mail-ed1-f44.google.com with SMTP id cf14so12862200edb.13;
        Sat, 04 Apr 2020 07:26:50 -0700 (PDT)
X-Gm-Message-State: AGi0PuaL4/Xscua32N/ZRx++HfyVnA9dBaAMcyrPxZLZHQx36hE4oEDM
        PLXsyUc70sxfVdX1e4w3WNDtRZPmHTqHLqYZrw==
X-Google-Smtp-Source: APiQypLrvRpYNmxtUseQvy0si5lavrNAXp1+yfoZDCiBxoEPrLj81XDyy9SSoVjVq3f/kN0bZ2YxSrzoA/tO5bkDhYc=
X-Received: by 2002:a50:9f07:: with SMTP id b7mr12066158edf.148.1586010408816;
 Sat, 04 Apr 2020 07:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200331082725.81048-1-jitao.shi@mediatek.com> <20200331082725.81048-5-jitao.shi@mediatek.com>
In-Reply-To: <20200331082725.81048-5-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 4 Apr 2020 22:26:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8vpzfKeyxVxXOVC7mDpw+QGGOX+8fJaQg5WduvndEmoA@mail.gmail.com>
Message-ID: <CAAOTY_8vpzfKeyxVxXOVC7mDpw+QGGOX+8fJaQg5WduvndEmoA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drm/mediatek: config mipitx impedance with
 calibration data
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
> Read calibration data from nvmem, and config mipitx impedance with
> calibration data to make sure their impedance are 100ohm.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/gpu/=
drm/mediatek/mtk_mt8183_mipi_tx.c
> index e4cc967750cb..0f87cd3d1d7d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> @@ -5,6 +5,8 @@
>   */
>
>  #include "mtk_mipi_tx.h"
> +#include <linux/nvmem-consumer.h>
> +#include <linux/slab.h>
>
>  #define MIPITX_LANE_CON                0x000c
>  #define RG_DSI_CPHY_T1DRV_EN           BIT(0)
> @@ -28,6 +30,7 @@
>  #define MIPITX_PLL_CON4                0x003c
>  #define RG_DSI_PLL_IBIAS               (3 << 10)
>
> +#define MIPITX_D2P_RTCODE      0x0100
>  #define MIPITX_D2_SW_CTL_EN    0x0144
>  #define MIPITX_D0_SW_CTL_EN    0x0244
>  #define MIPITX_CK_CKMODE_EN    0x0328
> @@ -108,6 +111,58 @@ static const struct clk_ops mtk_mipi_tx_pll_ops =3D =
{
>         .recalc_rate =3D mtk_mipi_tx_pll_recalc_rate,
>  };
>
> +static void mtk_mipi_tx_config_calibration_data(struct mtk_mipi_tx *mipi=
_tx)
> +{
> +       u32 *buf;
> +       u32 rt_code[5];
> +       int i, j;
> +       struct nvmem_cell *cell;
> +       struct device *dev =3D mipi_tx->dev;
> +       size_t len;
> +
> +       cell =3D nvmem_cell_get(dev, "calibration-data");
> +       if (IS_ERR(cell)) {
> +               dev_info(dev, "nvmem_cell_get fail\n");
> +               return;
> +       }
> +
> +       buf =3D (u32 *)nvmem_cell_read(cell, &len);
> +
> +       nvmem_cell_put(cell);
> +
> +       if (IS_ERR(buf)) {
> +               dev_info(dev, "can't get data\n");
> +               return;
> +       }
> +
> +       if (len < 3 * sizeof(u32)) {
> +               dev_info(dev, "invalid calibration data\n");
> +               kfree(buf);
> +               return;
> +       }
> +
> +       rt_code[0] =3D ((buf[0] >> 6 & 0x1f) << 5) | (buf[0] >> 11 & 0x1f=
);
> +       rt_code[1] =3D ((buf[1] >> 27 & 0x1f) << 5) | (buf[0] >> 1 & 0x1f=
);
> +       rt_code[2] =3D ((buf[1] >> 17 & 0x1f) << 5) | (buf[1] >> 22 & 0x1=
f);
> +       rt_code[3] =3D ((buf[1] >> 7 & 0x1f) << 5) | (buf[1] >> 12 & 0x1f=
);
> +       rt_code[4] =3D ((buf[2] >> 27 & 0x1f) << 5) | (buf[1] >> 2 & 0x1f=
);

Why not just save rt_code in nvmem and you don't need to translate here?
If you need to do so, please add description for this.

Regards,
Chun-Kuang.


> +
> +       for (i =3D 0; i < 5; i++) {
> +               if ((rt_code[i] & 0x1f) =3D=3D 0)
> +                       rt_code[i] |=3D 0x10;
> +
> +               if ((rt_code[i] >> 5 & 0x1f) =3D=3D 0)
> +                       rt_code[i] |=3D 0x10 << 5;
> +
> +               for (j =3D 0; j < 10; j++)
> +                       mtk_mipi_tx_update_bits(mipi_tx,
> +                               MIPITX_D2P_RTCODE * (i + 1) + j * 4,
> +                               1, rt_code[i] >> j & 1);
> +       }
> +
> +       kfree(buf);
> +}
> +
>  static void mtk_mipi_tx_power_on_signal(struct phy *phy)
>  {
>         struct mtk_mipi_tx *mipi_tx =3D phy_get_drvdata(phy);
> @@ -130,6 +185,8 @@ static void mtk_mipi_tx_power_on_signal(struct phy *p=
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
