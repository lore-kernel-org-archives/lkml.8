Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1620C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA3922522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgAOVOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:14:12 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:44108 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgAOVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:14:12 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1D865804E5;
        Wed, 15 Jan 2020 22:14:05 +0100 (CET)
Date:   Wed, 15 Jan 2020 22:14:04 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH v8 2/8] drm/panel: support for BOE tv101wum-nl6 wuxga dsi
 video mode panel
Message-ID: <20200115211404.GC28904@ravnborg.org>
References: <20200115135958.126303-1-jitao.shi@mediatek.com>
 <20200115135958.126303-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115135958.126303-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8
        a=qFe5Z7MAUKcRMEBcnwwA:9 a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

> +
> +static int boe_panel_add(struct boe_panel *boe)
> +{
> +	struct device *dev = &boe->dsi->dev;
> +	int err;
> +
> +	boe->avdd = devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(boe->avdd))
> +		return PTR_ERR(boe->avdd);
> +
> +	boe->avee = devm_regulator_get(dev, "avee");
> +	if (IS_ERR(boe->avee))
> +		return PTR_ERR(boe->avee);
> +
> +	boe->pp1800 = devm_regulator_get(dev, "pp1800");
> +	if (IS_ERR(boe->pp1800))
> +		return PTR_ERR(boe->pp1800);
> +
> +	boe->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(boe->enable_gpio)) {
> +		dev_err(dev, "cannot get reset-gpios %ld\n",
> +			PTR_ERR(boe->enable_gpio));
> +		return PTR_ERR(boe->enable_gpio);
> +	}
> +
> +	gpiod_set_value(boe->enable_gpio, 0);
> +
> +	err = drm_panel_of_backlight(&boe->base);
> +	if (err)
> +		return err;
From the descrition of drm_panel_of_backlight():

""
drm_panel_of_backlight() must be called after the call to drm_panel_init().
""

Please do as documented.

	Sam

> +
> +	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
> +		       DRM_MODE_CONNECTOR_DSI);
> +
> +	boe->base.funcs = &boe_panel_funcs;
> +	boe->base.dev = &boe->dsi->dev;
> +
> +	return drm_panel_add(&boe->base);
> +}
> +
> +static int boe_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct boe_panel *boe;
> +	int ret;
> +	const struct panel_desc *desc;
> +
> +	boe = devm_kzalloc(&dsi->dev, sizeof(*boe), GFP_KERNEL);
> +	if (!boe)
> +		return -ENOMEM;
> +
> +	desc = of_device_get_match_data(&dsi->dev);
> +	dsi->lanes = desc->lanes;
> +	dsi->format = desc->format;
> +	dsi->mode_flags = desc->mode_flags;
> +	boe->desc = desc;
> +	boe->dsi = dsi;
> +	ret = boe_panel_add(boe);
> +	if (ret < 0)
> +		return ret;
> +
> +	mipi_dsi_set_drvdata(dsi, boe);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret)
> +		drm_panel_remove(&boe->base);
> +
> +	return ret;
> +}
> +
> +static void boe_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> +
> +	drm_panel_disable(&boe->base);
> +	drm_panel_unprepare(&boe->base);
> +}
> +
> +static int boe_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	boe_panel_shutdown(dsi);
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +	if (boe->base.dev)
> +		drm_panel_remove(&boe->base);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id boe_of_match[] = {
> +	{ .compatible = "boe,tv101wum-nl6",
> +	  .data = &boe_tv101wum_nl6_desc
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, boe_of_match);
> +
> +static struct mipi_dsi_driver boe_panel_driver = {
> +	.driver = {
> +		.name = "panel-boe-tv101wum-nl6",
> +		.of_match_table = boe_of_match,
> +	},
> +	.probe = boe_panel_probe,
> +	.remove = boe_panel_remove,
> +	.shutdown = boe_panel_shutdown,
> +};
> +module_mipi_dsi_driver(boe_panel_driver);
> +
> +MODULE_AUTHOR("Jitao Shi <jitao.shi@mediatek.com>");
> +MODULE_DESCRIPTION("BOE tv101wum-nl6 1200x1920 video mode panel driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.21.0
