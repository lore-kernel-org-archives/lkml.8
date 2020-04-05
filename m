Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F0CC2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F0720659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586104061;
	bh=87r5HiwV250TQH/hXNaopHedMN2Y4ebyXBOwB1uf87s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N0MW5iTcY4pIvZ4ixc5ZUru1qQ/tx9wKu/s60sxZeAofTlgVhbB6Wbhyl3UeCKwNj
	 uGLHIutdJctH9XGgVDLQluHEaiB8w7dee6UoMMtGJiDvMINfNKse7uqYErib5meKa/
	 Xvysl+JX/FFWd2r0nfahHm+v1tPWMlbWcsKoYV8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgDEQ1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 12:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgDEQ1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:27:39 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43A40206C3;
        Sun,  5 Apr 2020 16:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586104058;
        bh=87r5HiwV250TQH/hXNaopHedMN2Y4ebyXBOwB1uf87s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0uL/iuu+DPJe3hArpFNmH8g3sP52h2w4dF5t09k1v3CrPdfKPoQKTfgvJcjovoA32
         B+EUftAQ0AjBlefdQfqvusqMf7jZrybIP9c6M1PmkZtel1YqtJI27zpYNEDqqW2+rj
         /hW9yYf2bLOL3IOwhZAtOZREdTI3pvVfcw5Kccxs=
Received: by mail-ed1-f46.google.com with SMTP id cf14so15824219edb.13;
        Sun, 05 Apr 2020 09:27:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuaS//XKd4N+81FI+Hx96KnsjMamaLEhzPSQuw5udiFttLcdtyHN
        Oi8iGbhu2NWqbvvFImf0VkrbaCiiLzFAfGE3UQ==
X-Google-Smtp-Source: APiQypJxhl3q1HZOKp0nuBjPykK5XzlvVbUY1lgbpYwIUm7Q3QtRq37rV5b91lqpWxHI2giZOD89RTYhXF9pKbTigvc=
X-Received: by 2002:aa7:c544:: with SMTP id s4mr16354259edr.271.1586104056683;
 Sun, 05 Apr 2020 09:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200331082725.81048-1-jitao.shi@mediatek.com>
 <20200331082725.81048-5-jitao.shi@mediatek.com> <CAAOTY_8vpzfKeyxVxXOVC7mDpw+QGGOX+8fJaQg5WduvndEmoA@mail.gmail.com>
 <1586093949.10544.4.camel@mszsdaap41>
In-Reply-To: <1586093949.10544.4.camel@mszsdaap41>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 6 Apr 2020 00:27:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY_83pE=+WFJe3Jb8uk-8ToS_j4XN=LDLs+e_7DoYzrjdUA@mail.gmail.com>
Message-ID: <CAAOTY_83pE=+WFJe3Jb8uk-8ToS_j4XN=LDLs+e_7DoYzrjdUA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drm/mediatek: config mipitx impedance with
 calibration data
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=885=E6=97=
=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=889:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> On Sat, 2020-04-04 at 22:26 +0800, Chun-Kuang Hu wrote:
> > Hi, Jitao:
> >
> > Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=8831=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Read calibration data from nvmem, and config mipitx impedance with
> > > calibration data to make sure their impedance are 100ohm.
> > >
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 57 +++++++++++++++++=
++
> > >  1 file changed, 57 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/=
gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> > > index e4cc967750cb..0f87cd3d1d7d 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> > > @@ -5,6 +5,8 @@
> > >   */
> > >
> > >  #include "mtk_mipi_tx.h"
> > > +#include <linux/nvmem-consumer.h>
> > > +#include <linux/slab.h>
> > >
> > >  #define MIPITX_LANE_CON                0x000c
> > >  #define RG_DSI_CPHY_T1DRV_EN           BIT(0)
> > > @@ -28,6 +30,7 @@
> > >  #define MIPITX_PLL_CON4                0x003c
> > >  #define RG_DSI_PLL_IBIAS               (3 << 10)
> > >
> > > +#define MIPITX_D2P_RTCODE      0x0100
> > >  #define MIPITX_D2_SW_CTL_EN    0x0144
> > >  #define MIPITX_D0_SW_CTL_EN    0x0244
> > >  #define MIPITX_CK_CKMODE_EN    0x0328
> > > @@ -108,6 +111,58 @@ static const struct clk_ops mtk_mipi_tx_pll_ops =
=3D {
> > >         .recalc_rate =3D mtk_mipi_tx_pll_recalc_rate,
> > >  };
> > >
> > > +static void mtk_mipi_tx_config_calibration_data(struct mtk_mipi_tx *=
mipi_tx)
> > > +{
> > > +       u32 *buf;
> > > +       u32 rt_code[5];
> > > +       int i, j;
> > > +       struct nvmem_cell *cell;
> > > +       struct device *dev =3D mipi_tx->dev;
> > > +       size_t len;
> > > +
> > > +       cell =3D nvmem_cell_get(dev, "calibration-data");
> > > +       if (IS_ERR(cell)) {
> > > +               dev_info(dev, "nvmem_cell_get fail\n");
> > > +               return;
> > > +       }
> > > +
> > > +       buf =3D (u32 *)nvmem_cell_read(cell, &len);
> > > +
> > > +       nvmem_cell_put(cell);
> > > +
> > > +       if (IS_ERR(buf)) {
> > > +               dev_info(dev, "can't get data\n");
> > > +               return;
> > > +       }
> > > +
> > > +       if (len < 3 * sizeof(u32)) {
> > > +               dev_info(dev, "invalid calibration data\n");
> > > +               kfree(buf);
> > > +               return;
> > > +       }
> > > +
> > > +       rt_code[0] =3D ((buf[0] >> 6 & 0x1f) << 5) | (buf[0] >> 11 & =
0x1f);
> > > +       rt_code[1] =3D ((buf[1] >> 27 & 0x1f) << 5) | (buf[0] >> 1 & =
0x1f);
> > > +       rt_code[2] =3D ((buf[1] >> 17 & 0x1f) << 5) | (buf[1] >> 22 &=
 0x1f);
> > > +       rt_code[3] =3D ((buf[1] >> 7 & 0x1f) << 5) | (buf[1] >> 12 & =
0x1f);
> > > +       rt_code[4] =3D ((buf[2] >> 27 & 0x1f) << 5) | (buf[1] >> 2 & =
0x1f);
> >
> > Why not just save rt_code in nvmem and you don't need to translate here=
?
> > If you need to do so, please add description for this.
> >
> > Regards,
> > Chun-Kuang.
> >
>
> Hi Chun-Kuang,
>
> The calibration data is flashed in rom when the IC FT test
> And the data struct can't be stored again

OK, it looks like this transtation is necessary.
If it's fixed, I would like to get the rt_code when probe or somewhere
initialization.

Regards,
Chun-Kuang.

>
> Best Regards
> JItao
> >
> > > +
> > > +       for (i =3D 0; i < 5; i++) {
> > > +               if ((rt_code[i] & 0x1f) =3D=3D 0)
> > > +                       rt_code[i] |=3D 0x10;
> > > +
> > > +               if ((rt_code[i] >> 5 & 0x1f) =3D=3D 0)
> > > +                       rt_code[i] |=3D 0x10 << 5;
> > > +
> > > +               for (j =3D 0; j < 10; j++)
> > > +                       mtk_mipi_tx_update_bits(mipi_tx,
> > > +                               MIPITX_D2P_RTCODE * (i + 1) + j * 4,
> > > +                               1, rt_code[i] >> j & 1);
> > > +       }
> > > +
> > > +       kfree(buf);
> > > +}
> > > +
> > >  static void mtk_mipi_tx_power_on_signal(struct phy *phy)
> > >  {
> > >         struct mtk_mipi_tx *mipi_tx =3D phy_get_drvdata(phy);
> > > @@ -130,6 +185,8 @@ static void mtk_mipi_tx_power_on_signal(struct ph=
y *phy)
> > >                                 RG_DSI_HSTX_LDO_REF_SEL,
> > >                                 (mipi_tx->mipitx_drive - 3000) / 200 =
<< 6);
> > >
> > > +       mtk_mipi_tx_config_calibration_data(mipi_tx);
> > > +
> > >         mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_CKMODE_EN, DSI_CK_CKM=
ODE_EN);
> > >  }
> > >
> > > --
> > > 2.21.0
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
