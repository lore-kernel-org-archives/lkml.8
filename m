Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F84C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 10:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C4423B1C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 10:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgFTKc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 06:32:27 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:47140 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgFTKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 06:31:27 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id DC51B20020;
        Sat, 20 Jun 2020 12:31:07 +0200 (CEST)
Date:   Sat, 20 Jun 2020 12:31:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Vinay Simha BN <simhavcs@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 2/2] display/drm/bridge: TC358775 DSI/LVDS driver
Message-ID: <20200620103106.GA15379@ravnborg.org>
References: <20200618121902.16841-1-simhavcs@gmail.com>
 <20200618121902.16841-2-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618121902.16841-2-simhavcs@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=edQTgYMH c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Qg8_i2Z0HerwvbgKwyIA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinay.

> +
> +static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct drm_panel *panel;
> +	struct tc_data *tc;
> +	int ret;
> +
> +	tc = devm_kzalloc(dev, sizeof(*tc), GFP_KERNEL);
> +	if (!tc)
> +		return -ENOMEM;
> +
> +	tc->dev = dev;
> +	tc->i2c = client;
> +
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, TC358775_LVDS_OUT0,
> +					  0, &panel, NULL);
> +	if (ret < 0)
> +		return ret;
> +	if (!panel)
> +		return -ENODEV;
> +
> +	panel->connector_type = DRM_MODE_CONNECTOR_LVDS;

The panel is responsible for specifying the connector_type.
It is wrong to let users of panel set it.

Fix the panel and not the bridge driver.


> +
> +	tc->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> +	if (IS_ERR(tc->panel_bridge))
> +		return PTR_ERR(tc->panel_bridge);
> +
> +	ret = tc358775_parse_dt(dev->of_node, tc);
> +	if (ret)
> +		return ret;
> +
> +	tc->vddio = devm_regulator_get(dev, "vddio-supply");
> +	if (IS_ERR(tc->vddio)) {
> +		ret = PTR_ERR(tc->vddio);
> +		dev_err(dev, "vddio-supply not found\n");
> +		return ret;
> +	}
> +
> +	tc->vdd = devm_regulator_get(dev, "vdd-supply");
> +	if (IS_ERR(tc->vdd)) {
> +		ret = PTR_ERR(tc->vddio);
> +		dev_err(dev, "vdd-supply not found\n");
> +		return ret;
> +	}
> +
> +	tc->stby_gpio = devm_gpiod_get(dev, "stby", GPIOD_OUT_HIGH);
> +	if (IS_ERR(tc->stby_gpio)) {
> +		ret = PTR_ERR(tc->stby_gpio);
> +		dev_err(dev, "cannot get stby-gpio %d\n", ret);
> +		return ret;
> +	}
> +
> +	tc->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(tc->reset_gpio)) {
> +		ret = PTR_ERR(tc->reset_gpio);
> +		dev_err(dev, "cannot get reset-gpios %d\n", ret);
> +		return ret;
> +	}
> +
> +	tc->bridge.funcs = &tc_bridge_funcs;
> +	tc->bridge.of_node = dev->of_node;
> +	drm_bridge_add(&tc->bridge);
> +
> +	i2c_set_clientdata(client, tc);
> +
> +	return 0;
> +}
> +

	Sam
