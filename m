Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3799FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C7720657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgHOW1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:27:20 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53992 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgHOW1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:27:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id F0763FB03;
        Sat, 15 Aug 2020 12:40:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OX_34ocNZaCv; Sat, 15 Aug 2020 12:40:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 60AF4457CC; Sat, 15 Aug 2020 12:40:22 +0200 (CEST)
Date:   Sat, 15 Aug 2020 12:40:22 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel: Add panel driver for the Mantix
 MLAF057WE51-X DSI panel
Message-ID: <20200815104022.GA5641@bogon.m.sigxcpu.org>
References: <cover.1597412076.git.agx@sigxcpu.org>
 <0a7539135cc46eec5636ca89f52695f4a1197841.1597412076.git.agx@sigxcpu.org>
 <20200815100230.GA1002374@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815100230.GA1002374@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Sat, Aug 15, 2020 at 12:02:30PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> > +static int mantix_probe(struct mipi_dsi_device *dsi)
> > +{
> > +	struct device *dev = &dsi->dev;
> > +	struct mantix *ctx;
> > +	int ret;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(ctx->reset_gpio)) {
> > +		DRM_DEV_ERROR(dev, "cannot get reset gpio\n");
> > +		return PTR_ERR(ctx->reset_gpio);
> > +	}
> > +
> > +	mipi_dsi_set_drvdata(dsi, ctx);
> > +	ctx->dev = dev;
> > +
> > +	dsi->lanes = 4;
> > +	dsi->format = MIPI_DSI_FMT_RGB888;
> > +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> > +		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> > +
> > +	ctx->avdd = devm_regulator_get(dev, "avdd");
> > +	if (IS_ERR(ctx->avdd)) {
> > +		ret = PTR_ERR(ctx->avdd);
> > +		if (ret != -EPROBE_DEFER)
> > +			DRM_DEV_ERROR(dev,
> > +				      "Failed to request avdd regulator: %d\n",
> > +				      ret);
> > +		return ret;
> > +	}
> 
> Consider to use the recently added dev_err_probe() here and below.
> Note: Not part of drm-misc-next yet - but hopefully after -rc1
> when a backmerge is done.

In fact I did decided against it since i was told that missing dev_* and
DRM_* logging shouldn't be done. So is that o.k. nowadays?
Cheers,
 -- Guido

> 
> 	Sam
> 
> > +	ctx->avee = devm_regulator_get(dev, "avee");
> > +	if (IS_ERR(ctx->avee)) {
> > +		ret = PTR_ERR(ctx->avee);
> > +		if (ret != -EPROBE_DEFER)
> > +			DRM_DEV_ERROR(dev,
> > +				      "Failed to request avee regulator: %d\n",
> > +				      ret);
> > +		return ret;
> > +	}
> > +	ctx->vddi = devm_regulator_get(dev, "vddi");
> > +	if (IS_ERR(ctx->vddi)) {
> > +		ret = PTR_ERR(ctx->vddi);
> > +		if (ret != -EPROBE_DEFER)
> > +			DRM_DEV_ERROR(dev,
> > +				      "Failed to request vddi regulator: %d\n",
> > +				      ret);
> > +		return ret;
> > +	}
> > +
> > +	drm_panel_init(&ctx->panel, dev, &mantix_drm_funcs,
> > +		       DRM_MODE_CONNECTOR_DSI);
> > +
> > +	ret = drm_panel_of_backlight(&ctx->panel);
> > +	if (ret)
> > +		return ret;
> > +	drm_panel_add(&ctx->panel);
> > +
> > +	ret = mipi_dsi_attach(dsi);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev,
> > +			      "mipi_dsi_attach failed (%d). Is host ready?\n",
> > +			      ret);
> > +		drm_panel_remove(&ctx->panel);
> > +		return ret;
> > +	}
> > +
> > +	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
> > +		     default_mode.hdisplay, default_mode.vdisplay,
> > +		     drm_mode_vrefresh(&default_mode),
> > +		     mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
> > +
> > +	return 0;
> > +}
> > +
> > +static void mantix_shutdown(struct mipi_dsi_device *dsi)
> > +{
> > +	struct mantix *ctx = mipi_dsi_get_drvdata(dsi);
> > +	int ret;
> > +
> > +	ret = drm_panel_unprepare(&ctx->panel);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(&dsi->dev, "Failed to unprepare panel: %d\n",
> > +			      ret);
> > +
> > +	ret = drm_panel_disable(&ctx->panel);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(&dsi->dev, "Failed to disable panel: %d\n",
> > +			      ret);
> > +}
> > +
> > +static int mantix_remove(struct mipi_dsi_device *dsi)
> > +{
> > +	struct mantix *ctx = mipi_dsi_get_drvdata(dsi);
> > +	int ret;
> > +
> > +	mantix_shutdown(dsi);
> > +
> > +	ret = mipi_dsi_detach(dsi);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(&dsi->dev, "Failed to detach from DSI host: %d\n",
> > +			      ret);
> > +
> > +	drm_panel_remove(&ctx->panel);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mantix_of_match[] = {
> > +	{ .compatible = "mantix,mlaf057we51-x" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mantix_of_match);
> > +
> > +static struct mipi_dsi_driver mantix_driver = {
> > +	.probe	= mantix_probe,
> > +	.remove = mantix_remove,
> > +	.shutdown = mantix_shutdown,
> > +	.driver = {
> > +		.name = DRV_NAME,
> > +		.of_match_table = mantix_of_match,
> > +	},
> > +};
> > +module_mipi_dsi_driver(mantix_driver);
> > +
> > +MODULE_AUTHOR("Guido Günther <agx@sigxcpu.org>");
> > +MODULE_DESCRIPTION("DRM driver for Mantix MLAF057WE51-X MIPI DSI panel");
> > +MODULE_LICENSE("GPL v2");
> > -- 
> > 2.26.2
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
