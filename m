Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF62C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ABB2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgG0UD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:03:28 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:44580 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgG0UD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:03:27 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 79BA32002B;
        Mon, 27 Jul 2020 22:03:21 +0200 (CEST)
Date:   Mon, 27 Jul 2020 22:03:20 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] drm: dsi: Let host and device specify supported bus
Message-ID: <20200727200320.GA1014103@ravnborg.org>
References: <20200727164613.19744-1-paul@crapouillou.net>
 <20200727164613.19744-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727164613.19744-3-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=mj1frrxOal-xCd-NJWkA:9
        a=kvZZqAbxeRUPa8gG:21 a=D4JMFfri3F8EuTwx:21 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Mon, Jul 27, 2020 at 06:46:09PM +0200, Paul Cercueil wrote:
> The current MIPI DSI framework can very well be used to support MIPI DBI
> panels. In order to add support for the various bus types supported by
> DBI, the DRM panel drivers should specify the bus type they will use,
> and the DSI host drivers should specify the bus types they are
> compatible with.
> 
> The DSI host driver can then use the information provided by the DBI/DSI
> device driver, such as the bus type and the number of lanes, to
> configure its hardware properly.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c |  9 +++++++++
>  include/drm/drm_mipi_dsi.h     | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 5dd475e82995..11ef885de765 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -281,6 +281,9 @@ int mipi_dsi_host_register(struct mipi_dsi_host *host)
>  {
>  	struct device_node *node;
>  
> +	if (WARN_ON_ONCE(!host->bus_types))
> +		host->bus_types = MIPI_DEVICE_TYPE_DSI;
> +
So all 14 users need to specify bus_types.
Seems doable.

>  	for_each_available_child_of_node(host->dev->of_node, node) {
>  		/* skip nodes without reg property */
>  		if (!of_find_property(node, "reg", NULL))
> @@ -323,6 +326,12 @@ int mipi_dsi_attach(struct mipi_dsi_device *dsi)
>  {
>  	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
>  
> +	if (WARN_ON_ONCE(!dsi->bus_type))
> +		dsi->bus_type = MIPI_DEVICE_TYPE_DSI;
We have ~50 users of mipi_dsi_attach() - doable. But a bit more work.

> +
> +	if (!(dsi->bus_type & dsi->host->bus_types))
> +		return -EINVAL;
> +
>  	if (!ops || !ops->attach)
>  		return -ENOSYS;
>  
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 360e6377e84b..65d2961fc054 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -63,6 +63,14 @@ struct mipi_dsi_packet {
>  int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
>  			   const struct mipi_dsi_msg *msg);
>  
> +/* MIPI bus types */
If you define this as an enum then kernel-doc syntax will be picked up.
See for example: enum drm_driver_feature

> +#define MIPI_DEVICE_TYPE_DSI		BIT(0)
> +#define MIPI_DEVICE_TYPE_DBI_SPI_MODE1	BIT(1)
> +#define MIPI_DEVICE_TYPE_DBI_SPI_MODE2	BIT(2)
> +#define MIPI_DEVICE_TYPE_DBI_SPI_MODE3	BIT(3)
> +#define MIPI_DEVICE_TYPE_DBI_M6800	BIT(4)
> +#define MIPI_DEVICE_TYPE_DBI_I8080	BIT(5)
> +
>  /**
>   * struct mipi_dsi_host_ops - DSI bus operations
>   * @attach: attach DSI device to DSI host
> @@ -94,11 +102,13 @@ struct mipi_dsi_host_ops {
>   * struct mipi_dsi_host - DSI host device
>   * @dev: driver model device node for this DSI host
>   * @ops: DSI host operations
> + * @bus_types: Bitmask of supported MIPI bus types
Please add some kind of reference to MIPI_DEVICE_TYPE_* - so the reader
knows for sure this is the bits used here.

>   * @list: list management
>   */
>  struct mipi_dsi_host {
>  	struct device *dev;
>  	const struct mipi_dsi_host_ops *ops;
> +	unsigned int bus_types;
Use u32. Shorter and we know this is 32 bits wide.

>  	struct list_head list;
>  };
>  
> @@ -162,6 +172,7 @@ struct mipi_dsi_device_info {
>   * @host: DSI host for this peripheral
>   * @dev: driver model device node for this peripheral
>   * @name: DSI peripheral chip type
> + * @bus_type: MIPI bus type (MIPI_DEVICE_TYPE_DSI/...)
>   * @channel: virtual channel assigned to the peripheral
>   * @format: pixel format for video mode
>   * @lanes: number of active data lanes
> @@ -178,6 +189,7 @@ struct mipi_dsi_device {
>  	struct device dev;
>  
>  	char name[DSI_DEV_NAME_SIZE];
> +	unsigned int bus_type;
Use u32.

>  	unsigned int channel;
>  	unsigned int lanes;
>  	enum mipi_dsi_pixel_format format;
> -- 
> 2.27.0
