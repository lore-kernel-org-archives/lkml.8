Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9339B20707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="w07y+HIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgH3Qsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:48:31 -0400
Received: from crapouillou.net ([89.234.176.41]:40920 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgH3Qs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598806105; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpiKqvqWt50oYWkDZ/C8i5w2dOneeK046AHbWiBzqtY=;
        b=w07y+HIVSnOUB9g6Qd+qpuEjTYThdHnCaIpCek14hSmCiv/fOGBVLpZsMGg8v58/0MKLfu
        CWCqlL8pRNSQDOD/z0qgvCrxfCCyxIY2CnVQ60EN1b6l5RF2JSfMNB/I9DhbQgm2EeZOdq
        anVvItIYUIgBaV2nq/mEokPvYCtpGOc=
Date:   Sun, 30 Aug 2020 18:48:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH v2 6/6] drm/panel: Add Ilitek
 ILI9341 DBI panel driver
To:     =?UTF-8?b?5L2V5bCP6b6Z?= <Leon.He@unisoc.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-Id: <COYVFQ.2IA7KFB6BF4C3@crapouillou.net>
In-Reply-To: <edf38d68214247f486db3cc1f81ec404@shmbx04.spreadtrum.com>
References: <20200822163250.63664-1-paul@crapouillou.net>
        <20200822163250.63664-7-paul@crapouillou.net>
        <edf38d68214247f486db3cc1f81ec404@shmbx04.spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leon,

Le dim. 30 ao=C3=BBt 2020 =C3=A0 16:36, =E4=BD=95=E5=B0=8F=E9=BE=99 (Leon H=
e)=20
<Leon.He@unisoc.com> a =C3=A9crit :
>>  +struct ili9341 {
>>  +       struct drm_panel panel;
>>  +       struct mipi_dsi_device *dsi;
>>  +       const struct ili9341_pdata *pdata;
>>  +
>>  +       struct gpio_desc        *reset_gpiod;
>>  +       u32 rotation;
>>  +};
>>  +
>=20
> Hi Paul, you put the mipi_dsi_device inside the struct. I think it=20
> maybe not
> a good idea. That means the panel has a MIPI-DSI interface but it=20
> doesn't
> have actually.
>=20
>>  +static int ili9341_probe(struct mipi_dsi_device *dsi)
>>  +{
>>  +       struct device *dev =3D &dsi->dev;
>>  +       struct ili9341 *priv;
>>  +       int ret;
>>  +
>>  +       /* See comment for mipi_dbi_spi_init() */
>>  +       if (!dev->coherent_dma_mask) {
>>  +               ret =3D dma_coerce_mask_and_coherent(dev,=20
>> DMA_BIT_MASK(32));
>>  +               if (ret) {
>>  +                       dev_warn(dev, "Failed to set dma mask=20
>> %d\n", ret);
>>  +                       return ret;
>>  +               }
>>  +       }
>>  +
>>  +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>  +       if (!priv)
>>  +               return -ENOMEM;
>>  +
>>  +       mipi_dsi_set_drvdata(dsi, priv);
>>  +       priv->dsi =3D dsi;
>>  +
>>  +       device_property_read_u32(dev, "rotation", &priv->rotation);
>>  +
>>  +       priv->pdata =3D device_get_match_data(dev);
>>  +       if (!priv->pdata)
>>  +               return -EINVAL;
>>  +
>>  +       drm_panel_init(&priv->panel, dev, &ili9341_funcs,
>>  +                      DRM_MODE_CONNECTOR_DPI);
>>  +
>>  +       priv->reset_gpiod =3D devm_gpiod_get(dev, "reset",=20
>> GPIOD_OUT_HIGH);
>>  +       if (IS_ERR(priv->reset_gpiod)) {
>>  +               dev_err(dev, "Couldn't get our reset GPIO\n");
>>  +               return PTR_ERR(priv->reset_gpiod);
>>  +       }
>>  +
>>  +       ret =3D drm_panel_of_backlight(&priv->panel);
>>  +       if (ret < 0) {
>>  +               if (ret !=3D -EPROBE_DEFER)
>>  +                       dev_err(dev, "Failed to get backlight=20
>> handle\n");
>>  +               return ret;
>>  +       }
>>  +
>>  +       drm_panel_add(&priv->panel);
>>  +
>>  +       dsi->bus_type =3D priv->pdata->bus_type;
>>  +       dsi->lanes =3D priv->pdata->lanes;
>>  +       dsi->format =3D MIPI_DSI_FMT_RGB565;
>>  +
>>  +       ret =3D mipi_dsi_attach(dsi);
>>  +       if (ret) {
>>  +               dev_err(dev, "Failed to attach DSI panel\n");
>>  +               goto err_panel_remove;
>>  +       }
>>  +
>>  +       ret =3D mipi_dsi_maybe_register_tiny_driver(dsi);
>>  +       if (ret) {
>>  +               dev_err(dev, "Failed to init TinyDRM driver\n");
>>  +               goto err_mipi_dsi_detach;
>>  +       }
>>  +
>>  +       return 0;
>>  +
>>  +err_mipi_dsi_detach:
>>  +       mipi_dsi_detach(dsi);
>>  +err_panel_remove:
>>  +       drm_panel_remove(&priv->panel);
>>  +       return ret;
>>  +}
>>  +
>>  +static int ili9341_remove(struct mipi_dsi_device *dsi)
>>  +{
>>  +       struct ili9341 *priv =3D mipi_dsi_get_drvdata(dsi);
>>  +
>>  +       mipi_dsi_detach(dsi);
>>  +       drm_panel_remove(&priv->panel);
>>  +
>>  +       drm_panel_disable(&priv->panel);
>>  +       drm_panel_unprepare(&priv->panel);
>>  +
>>  +       return 0;
>>  +}
>>  +
>>  +static const struct ili9341_pdata yx240qv29_pdata =3D {
>>  +       .mode =3D { DRM_SIMPLE_MODE(240, 320, 37, 49) },
>>  +       .width_mm =3D 0, // TODO
>>  +       .height_mm =3D 0, // TODO
>>  +       .bus_type =3D MIPI_DCS_BUS_TYPE_DBI_SPI_C3,
>>  +       .lanes =3D 1,
>>  +};
>>  +
>>  +static const struct of_device_id ili9341_of_match[] =3D {
>>  +       { .compatible =3D "adafruit,yx240qv29", .data =3D=20
>> &yx240qv29_pdata },
>>  +       { }
>>  +};
>>  +MODULE_DEVICE_TABLE(of, ili9341_of_match);
>>  +
>>  +static struct mipi_dsi_driver ili9341_dsi_driver =3D {
>>  +       .probe          =3D ili9341_probe,
>>  +       .remove         =3D ili9341_remove,
>>  +       .driver =3D {
>>  +               .name           =3D "ili9341-dsi",
>>  +               .of_match_table =3D ili9341_of_match,
>>  +       },
>>  +};
>>  +module_mipi_dsi_driver(ili9341_dsi_driver);
>=20
> Again, you treat this driver as a mipi dsi driver but for a MIPI-DBI=20
> (I8080/SPI)
> panel device. That will make developers confused.
>=20
> Is it possible to just add a mipi_dbi_driver for I8080/SPI interface=20
> panel?
> Thanks!

Please read the cover letter, it explains why it's done this way. The=20
whole point of this patchset is to merge DSI and DBI frameworks in a=20
way that can be maintained.

Cheers,
-Paul


