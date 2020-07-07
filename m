Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E52AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6569B206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EEyqfv3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgGGHBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGHBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:01:37 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C8C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:01:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id v1so21956814vsb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbsHVyeK2Vstzqb6QmhJv9+M3wOOHcWN7GhZMwhEauo=;
        b=EEyqfv3lnLwactKiE8HZ/CTLLA9oHPzdCHG+biD5AwMuhpZB+6M4SlswZoR/xFBP/T
         7BVPdd4f+5VxTBjYxixYeitZbYSKWgJJKhSWFL5MxXSr7PKGu3zp/5IMUVhFpv3V/Wdt
         CjZU+UXTjLwhhLIQOa+VmBjJNqT/DdPK3ndHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbsHVyeK2Vstzqb6QmhJv9+M3wOOHcWN7GhZMwhEauo=;
        b=lldDc6NVZJgYAcpmpVJSpF8QsNrFQ7WwBTWjm3bVKl0CxJdIM3EBxVWW6b5SuoPFGa
         8/PRgmEG9cjWwcDzANpsWuK2dA+hYJb+A34vgHnr+Mn//G1R/34wIKk6nTkO5mIs0GHx
         X2zjobjIlX1nBDiPy4fYPxTJ5eO84BC6C/YDreeni1xnkDaik525t4HlW17iEomUS+6Y
         UlExLSYijXBxjskerJx5G/YQE6mJxTT8Clui/5+MIYvN6CJLd3Qtk3CHYFycw9qMQvxn
         JVX6iRLpUAw3WOulkSGOl1vmPFmqBztV2grP3zTAAPUwyJ72iSbV8npsL1oxCwRZL+zc
         TBJQ==
X-Gm-Message-State: AOAM532Pbmz3ROxj3Rgfdbc1Lnlhvp67EQDyfQDc1GraOxCgWdcSSQU4
        xKKWoIfmaNVAppeKIawsuGUg6ppW1bVoI/Nv6k62oQ==
X-Google-Smtp-Source: ABdhPJwA2s7xYWSfCkrCts/eUUgdQUXG/H9gqkpnvbcbSGwQe1S7omc1CbDKZxVIZgleI9cmUmc7kJ36DVKAqlSmoE0=
X-Received: by 2002:a67:8e49:: with SMTP id q70mr3322116vsd.14.1594105296201;
 Tue, 07 Jul 2020 00:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591345160.git.xji@analogixsemi.com> <a18316c118c7b8ac201911b0b96d41c84653a00f.1591345160.git.xji@analogixsemi.com>
In-Reply-To: <a18316c118c7b8ac201911b0b96d41c84653a00f.1591345160.git.xji@analogixsemi.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 7 Jul 2020 15:01:25 +0800
Message-ID: <CANMq1KDnoLSUxxYr82o=1eGBR7E3PxoYUr8h1sEVTyqYyHCC-Q@mail.gmail.com>
Subject: Re: [PATCH v13 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Shawn Ku <shawnku@google.com>,
        Sheng Pan <span@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 3:20 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI DSI/DPI to DisplayPort 1.3 4K.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/Kconfig   |    9 +
>  drivers/gpu/drm/bridge/analogix/Makefile  |    1 +
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1999 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  397 ++++++
>  4 files changed, 2406 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
>
> [snip]
> +static int anx7625_parse_dt(struct device *dev,
> +                           struct anx7625_platform_data *pdata)
> +{
> +       struct device_node *np = dev->of_node;
> +       struct device_node *panel_node, *out_ep;
> +
> +       pdata->node.mipi_dsi_host_node = of_graph_get_remote_node(np, 0, 0);
> +       if (!pdata->node.mipi_dsi_host_node) {
> +               DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> +               return -EPROBE_DEFER;

This does not look correct. I don't think of_graph_get_remote_node
will ever return NULL if the device tree is configured properly, and
it's useless to retry later (EPROBE_DEFER). You should just fail (e.g.
return EINVAL).

> +       }
> +
> +       of_node_put(pdata->node.mipi_dsi_host_node);

You are using pdata->node.mipi_dsi_host_node in other places in the
code, so I don't think it's ok to call of_node_put?

> +       DRM_DEV_DEBUG_DRIVER(dev, "found dsi host node.\n");
> +
> +       pdata->node.panel_node = of_graph_get_port_by_id(np, 1);
> +       if (!pdata->node.panel_node) {
> +               DRM_DEV_ERROR(dev, "fail to get panel node.\n");
> +               return -EPROBE_DEFER;

-EINVAL.

> +       }
> +
> +       of_node_put(pdata->node.panel_node);
> +       out_ep = of_get_child_by_name(pdata->node.panel_node,
> +                                     "endpoint");
> +       if (!out_ep) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "cannot get endpoint.\n");

DRM_DEV_ERROR seems more appropriate

> +               return -EPROBE_DEFER;

-EINVAL

> +       }
> +
> +       panel_node = of_graph_get_remote_port_parent(out_ep);
> +       of_node_put(out_ep);
> +       pdata->panel = of_drm_find_panel(panel_node);
> +       DRM_DEV_DEBUG_DRIVER(dev, "get panel node.\n");
> +
> +       of_node_put(panel_node);
> +       if (IS_ERR_OR_NULL(pdata->panel))
> +               return -EPROBE_DEFER;

of_drm_find_panel cannot return NULL, so, do this instead:

if (IS_ERR(pdata->panel))
   return PTR_ERR(pdata->panel);

(which actually _may_ return EPROBE_DEFER)

> +
> +       return 0;
> +}
> [snip]
> +static int anx7625_i2c_probe(struct i2c_client *client,
> +                            const struct i2c_device_id *id)
> +{
> +       struct anx7625_data *platform;
> +       struct anx7625_platform_data *pdata;
> +       int ret = 0;
> +       struct device *dev = &client->dev;
> +
> +       if (!i2c_check_functionality(client->adapter,
> +                                    I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +               DRM_DEV_ERROR(dev, "anx7625's i2c bus doesn't support\n");
> +               return -ENODEV;
> +       }
> +
> +       platform = kzalloc(sizeof(*platform), GFP_KERNEL);
> +       if (!platform) {
> +               DRM_DEV_ERROR(dev, "fail to allocate driver data\n");
> +               return -ENOMEM;
> +       }
> +
> +       pdata = &platform->pdata;
> +
> +       ret = anx7625_parse_dt(dev, pdata);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "fail to parse devicetree.\n");

Please do not print this error (or at least not if err == -EPROBE_DEFER).

> +               goto free_platform;
> +       }
