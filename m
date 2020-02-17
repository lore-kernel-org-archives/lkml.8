Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F33C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E92A20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBQGjF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:39:05 -0500
Received: from mailoutvs13.siol.net ([185.57.226.204]:51859 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbgBQGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:39:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 51884522CE8;
        Mon, 17 Feb 2020 07:39:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aQUjgWNbNH1b; Mon, 17 Feb 2020 07:39:01 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id F4052522C8E;
        Mon, 17 Feb 2020 07:39:00 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 1C5E9522CE8;
        Mon, 17 Feb 2020 07:38:59 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, boris.brezillon@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 02/11] drm/bridge: dw-hdmi: add max bpc connector property
Date:   Mon, 17 Feb 2020 07:38:58 +0100
Message-ID: <11463907.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20200206191834.6125-3-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com> <20200206191834.6125-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne četrtek, 06. februar 2020 ob 20:18:25 CET je Neil Armstrong napisal(a):
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> Add the max_bpc property to the dw-hdmi connector to prepare support
> for 10, 12 & 16bit output support.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> 9e0927d22db6..051001f77dd4 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2406,6 +2406,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
> *bridge) DRM_MODE_CONNECTOR_HDMIA,
>  				    hdmi->ddc);
> 
> +	drm_atomic_helper_connector_reset(connector);

Why is this reset needed?

Best regards,
Jernej

> +
> +	drm_connector_attach_max_bpc_property(connector, 8, 16);
> +
>  	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
>  		drm_object_attach_property(&connector->base,
>  			connector->dev-
>mode_config.hdr_output_metadata_property, 0);




