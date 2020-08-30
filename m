Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FB4C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C0C206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nNDmHo8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgH3TL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:11:57 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54128 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgH3TL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:11:57 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A0CE258;
        Sun, 30 Aug 2020 21:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598814713;
        bh=fel0reShl8gyxHac+/RDk7fZq+macGvIPWGmYF2KvpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNDmHo8Njma2Cg5b6MZJDWkkayMD+7XR2NTBLh8vbW6FREhHNg44gWKvRWkwOCDx8
         vwCNZg7U9sTxsRIbAbb/q21RWvS+0oJFMADArVTp2dd8EGL4b29Y8W6pXN7oXrvR5V
         BHPfAl6SAy/bnHwTZkkDjW1sDO4mfG5IlaWufAyY=
Date:   Sun, 30 Aug 2020 22:11:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     =?utf-8?B?5L2V5bCP6b6Z?= <Leon.He@unisoc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v2 6/6]
 drm/panel: Add Ilitek ILI9341 DBI panel driver
Message-ID: <20200830191133.GB6043@pendragon.ideasonboard.com>
References: <20200822163250.63664-1-paul@crapouillou.net>
 <20200822163250.63664-7-paul@crapouillou.net>
 <edf38d68214247f486db3cc1f81ec404@shmbx04.spreadtrum.com>
 <COYVFQ.2IA7KFB6BF4C3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <COYVFQ.2IA7KFB6BF4C3@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, Aug 30, 2020 at 06:48:12PM +0200, Paul Cercueil wrote:
> Le dim. 30 août 2020 à 16:36, 何小龙 (Leon He) a écrit :
> >>  +struct ili9341 {
> >>  +       struct drm_panel panel;
> >>  +       struct mipi_dsi_device *dsi;
> >>  +       const struct ili9341_pdata *pdata;
> >>  +
> >>  +       struct gpio_desc        *reset_gpiod;
> >>  +       u32 rotation;
> >>  +};
> >>  +
> > 
> > Hi Paul, you put the mipi_dsi_device inside the struct. I think it 
> > maybe not
> > a good idea. That means the panel has a MIPI-DSI interface but it 
> > doesn't
> > have actually.
> > 
> >>  +static int ili9341_probe(struct mipi_dsi_device *dsi)
> >>  +{
> >>  +       struct device *dev = &dsi->dev;
> >>  +       struct ili9341 *priv;
> >>  +       int ret;
> >>  +
> >>  +       /* See comment for mipi_dbi_spi_init() */
> >>  +       if (!dev->coherent_dma_mask) {
> >>  +               ret = dma_coerce_mask_and_coherent(dev, 
> >> DMA_BIT_MASK(32));
> >>  +               if (ret) {
> >>  +                       dev_warn(dev, "Failed to set dma mask 
> >> %d\n", ret);
> >>  +                       return ret;
> >>  +               }
> >>  +       }
> >>  +
> >>  +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>  +       if (!priv)
> >>  +               return -ENOMEM;
> >>  +
> >>  +       mipi_dsi_set_drvdata(dsi, priv);
> >>  +       priv->dsi = dsi;
> >>  +
> >>  +       device_property_read_u32(dev, "rotation", &priv->rotation);
> >>  +
> >>  +       priv->pdata = device_get_match_data(dev);
> >>  +       if (!priv->pdata)
> >>  +               return -EINVAL;
> >>  +
> >>  +       drm_panel_init(&priv->panel, dev, &ili9341_funcs,
> >>  +                      DRM_MODE_CONNECTOR_DPI);
> >>  +
> >>  +       priv->reset_gpiod = devm_gpiod_get(dev, "reset", 
> >> GPIOD_OUT_HIGH);
> >>  +       if (IS_ERR(priv->reset_gpiod)) {
> >>  +               dev_err(dev, "Couldn't get our reset GPIO\n");
> >>  +               return PTR_ERR(priv->reset_gpiod);
> >>  +       }
> >>  +
> >>  +       ret = drm_panel_of_backlight(&priv->panel);
> >>  +       if (ret < 0) {
> >>  +               if (ret != -EPROBE_DEFER)
> >>  +                       dev_err(dev, "Failed to get backlight 
> >> handle\n");
> >>  +               return ret;
> >>  +       }
> >>  +
> >>  +       drm_panel_add(&priv->panel);
> >>  +
> >>  +       dsi->bus_type = priv->pdata->bus_type;
> >>  +       dsi->lanes = priv->pdata->lanes;
> >>  +       dsi->format = MIPI_DSI_FMT_RGB565;
> >>  +
> >>  +       ret = mipi_dsi_attach(dsi);
> >>  +       if (ret) {
> >>  +               dev_err(dev, "Failed to attach DSI panel\n");
> >>  +               goto err_panel_remove;
> >>  +       }
> >>  +
> >>  +       ret = mipi_dsi_maybe_register_tiny_driver(dsi);
> >>  +       if (ret) {
> >>  +               dev_err(dev, "Failed to init TinyDRM driver\n");
> >>  +               goto err_mipi_dsi_detach;
> >>  +       }
> >>  +
> >>  +       return 0;
> >>  +
> >>  +err_mipi_dsi_detach:
> >>  +       mipi_dsi_detach(dsi);
> >>  +err_panel_remove:
> >>  +       drm_panel_remove(&priv->panel);
> >>  +       return ret;
> >>  +}
> >>  +
> >>  +static int ili9341_remove(struct mipi_dsi_device *dsi)
> >>  +{
> >>  +       struct ili9341 *priv = mipi_dsi_get_drvdata(dsi);
> >>  +
> >>  +       mipi_dsi_detach(dsi);
> >>  +       drm_panel_remove(&priv->panel);
> >>  +
> >>  +       drm_panel_disable(&priv->panel);
> >>  +       drm_panel_unprepare(&priv->panel);
> >>  +
> >>  +       return 0;
> >>  +}
> >>  +
> >>  +static const struct ili9341_pdata yx240qv29_pdata = {
> >>  +       .mode = { DRM_SIMPLE_MODE(240, 320, 37, 49) },
> >>  +       .width_mm = 0, // TODO
> >>  +       .height_mm = 0, // TODO
> >>  +       .bus_type = MIPI_DCS_BUS_TYPE_DBI_SPI_C3,
> >>  +       .lanes = 1,
> >>  +};
> >>  +
> >>  +static const struct of_device_id ili9341_of_match[] = {
> >>  +       { .compatible = "adafruit,yx240qv29", .data = 
> >> &yx240qv29_pdata },
> >>  +       { }
> >>  +};
> >>  +MODULE_DEVICE_TABLE(of, ili9341_of_match);
> >>  +
> >>  +static struct mipi_dsi_driver ili9341_dsi_driver = {
> >>  +       .probe          = ili9341_probe,
> >>  +       .remove         = ili9341_remove,
> >>  +       .driver = {
> >>  +               .name           = "ili9341-dsi",
> >>  +               .of_match_table = ili9341_of_match,
> >>  +       },
> >>  +};
> >>  +module_mipi_dsi_driver(ili9341_dsi_driver);
> > 
> > Again, you treat this driver as a mipi dsi driver but for a MIPI-DBI 
> > (I8080/SPI)
> > panel device. That will make developers confused.
> > 
> > Is it possible to just add a mipi_dbi_driver for I8080/SPI interface 
> > panel?
> > Thanks!
> 
> Please read the cover letter, it explains why it's done this way. The 
> whole point of this patchset is to merge DSI and DBI frameworks in a 
> way that can be maintained.

I think this proves the point that the proposed naming is confusing. At
least a rename would be required.

-- 
Regards,

Laurent Pinchart
