Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD5C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272F02078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NK7YhBPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgG0RDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0RDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:03:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C552C061794;
        Mon, 27 Jul 2020 10:03:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C731556;
        Mon, 27 Jul 2020 19:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595869372;
        bh=BmUuid7qCzoWbedOU9sLebblb85wP/lsToqZ1PEAt7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NK7YhBPigSjuPp+8tFWoURgc5JobClMElhBjG4x8/0HB1ty/e2Xrao9L3SD+DC6sv
         m8+PkL77ie+LOjD+mEWtHHyPmrAwZniDzQlw0vPssSlSdwCgdIv3vxmAEhGzJOj/0b
         sauWg5WMzGjPy7pRV1Xrucl5Y6ybdjam0Z2sNvuY=
Date:   Mon, 27 Jul 2020 20:02:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] drm: dsi: Let host and device specify supported bus
Message-ID: <20200727170245.GF17521@pendragon.ideasonboard.com>
References: <20200727164613.19744-1-paul@crapouillou.net>
 <20200727164613.19744-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727164613.19744-3-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

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

Use the mipi_dsi_* API for DBI panels will be very confusing to say the
least. Can we consider a global name refactoring to clarify all this ?

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
>  	for_each_available_child_of_node(host->dev->of_node, node) {
>  		/* skip nodes without reg property */
>  		if (!of_find_property(node, "reg", NULL))
> @@ -323,6 +326,12 @@ int mipi_dsi_attach(struct mipi_dsi_device *dsi)
>  {
>  	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
>  
> +	if (WARN_ON_ONCE(!dsi->bus_type))
> +		dsi->bus_type = MIPI_DEVICE_TYPE_DSI;
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
>   * @list: list management
>   */
>  struct mipi_dsi_host {
>  	struct device *dev;
>  	const struct mipi_dsi_host_ops *ops;
> +	unsigned int bus_types;
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
>  	unsigned int channel;
>  	unsigned int lanes;
>  	enum mipi_dsi_pixel_format format;

-- 
Regards,

Laurent Pinchart
