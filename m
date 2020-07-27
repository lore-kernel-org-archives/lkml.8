Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F266AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D601B208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="leOnkFjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgG0SEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:04:06 -0400
Received: from crapouillou.net ([89.234.176.41]:39978 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgG0SEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595873043; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8hnFBflIFs2SlnL6a+fKRKHJ7sn0cbnakResXbbUtA=;
        b=leOnkFjIl0aSA5iqFDCdj5b+p3adVmnkZKXJg0N7/xmPXnt3X1S6LDuqIngP9ozNT/YcJF
        P6k20aw9Hi23nRy1MU0vEYqq5ixwb8QF38FlpFaiwOiZyHF0VVzNXwlGknrghO+D8/MUYv
        G2qb4VceNxHI5vyBnhak5mccVGMdk/s=
Date:   Mon, 27 Jul 2020 19:59:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/6] drm: dsi: Let host and device specify supported bus
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        Noralf =?iso-8859-1?q?Tr=F8nnes?= <noralf@tronnes.org>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <QA35EQ.0IE6UXSOG224@crapouillou.net>
In-Reply-To: <20200727170245.GF17521@pendragon.ideasonboard.com>
References: <20200727164613.19744-1-paul@crapouillou.net>
        <20200727164613.19744-3-paul@crapouillou.net>
        <20200727170245.GF17521@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Le lun. 27 juil. 2020 =E0 20:02, Laurent Pinchart=20
<laurent.pinchart@ideasonboard.com> a =E9crit :
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Mon, Jul 27, 2020 at 06:46:09PM +0200, Paul Cercueil wrote:
>>  The current MIPI DSI framework can very well be used to support=20
>> MIPI DBI
>>  panels. In order to add support for the various bus types supported=20
>> by
>>  DBI, the DRM panel drivers should specify the bus type they will=20
>> use,
>>  and the DSI host drivers should specify the bus types they are
>>  compatible with.
>>=20
>>  The DSI host driver can then use the information provided by the=20
>> DBI/DSI
>>  device driver, such as the bus type and the number of lanes, to
>>  configure its hardware properly.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/gpu/drm/drm_mipi_dsi.c |  9 +++++++++
>>   include/drm/drm_mipi_dsi.h     | 12 ++++++++++++
>=20
> Use the mipi_dsi_* API for DBI panels will be very confusing to say=20
> the
> least. Can we consider a global name refactoring to clarify all this ?

I was thinking that this could be done when the code is cleaned up and=20
drivers/gpu/drm/drm_mipi_dbi.c is removed. I'm scared of tree-wide=20
patchsets.

-Paul

>=20
>>   2 files changed, 21 insertions(+)
>>=20
>>  diff --git a/drivers/gpu/drm/drm_mipi_dsi.c=20
>> b/drivers/gpu/drm/drm_mipi_dsi.c
>>  index 5dd475e82995..11ef885de765 100644
>>  --- a/drivers/gpu/drm/drm_mipi_dsi.c
>>  +++ b/drivers/gpu/drm/drm_mipi_dsi.c
>>  @@ -281,6 +281,9 @@ int mipi_dsi_host_register(struct mipi_dsi_host=20
>> *host)
>>   {
>>   	struct device_node *node;
>>=20
>>  +	if (WARN_ON_ONCE(!host->bus_types))
>>  +		host->bus_types =3D MIPI_DEVICE_TYPE_DSI;
>>  +
>>   	for_each_available_child_of_node(host->dev->of_node, node) {
>>   		/* skip nodes without reg property */
>>   		if (!of_find_property(node, "reg", NULL))
>>  @@ -323,6 +326,12 @@ int mipi_dsi_attach(struct mipi_dsi_device=20
>> *dsi)
>>   {
>>   	const struct mipi_dsi_host_ops *ops =3D dsi->host->ops;
>>=20
>>  +	if (WARN_ON_ONCE(!dsi->bus_type))
>>  +		dsi->bus_type =3D MIPI_DEVICE_TYPE_DSI;
>>  +
>>  +	if (!(dsi->bus_type & dsi->host->bus_types))
>>  +		return -EINVAL;
>>  +
>>   	if (!ops || !ops->attach)
>>   		return -ENOSYS;
>>=20
>>  diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
>>  index 360e6377e84b..65d2961fc054 100644
>>  --- a/include/drm/drm_mipi_dsi.h
>>  +++ b/include/drm/drm_mipi_dsi.h
>>  @@ -63,6 +63,14 @@ struct mipi_dsi_packet {
>>   int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
>>   			   const struct mipi_dsi_msg *msg);
>>=20
>>  +/* MIPI bus types */
>>  +#define MIPI_DEVICE_TYPE_DSI		BIT(0)
>>  +#define MIPI_DEVICE_TYPE_DBI_SPI_MODE1	BIT(1)
>>  +#define MIPI_DEVICE_TYPE_DBI_SPI_MODE2	BIT(2)
>>  +#define MIPI_DEVICE_TYPE_DBI_SPI_MODE3	BIT(3)
>>  +#define MIPI_DEVICE_TYPE_DBI_M6800	BIT(4)
>>  +#define MIPI_DEVICE_TYPE_DBI_I8080	BIT(5)
>>  +
>>   /**
>>    * struct mipi_dsi_host_ops - DSI bus operations
>>    * @attach: attach DSI device to DSI host
>>  @@ -94,11 +102,13 @@ struct mipi_dsi_host_ops {
>>    * struct mipi_dsi_host - DSI host device
>>    * @dev: driver model device node for this DSI host
>>    * @ops: DSI host operations
>>  + * @bus_types: Bitmask of supported MIPI bus types
>>    * @list: list management
>>    */
>>   struct mipi_dsi_host {
>>   	struct device *dev;
>>   	const struct mipi_dsi_host_ops *ops;
>>  +	unsigned int bus_types;
>>   	struct list_head list;
>>   };
>>=20
>>  @@ -162,6 +172,7 @@ struct mipi_dsi_device_info {
>>    * @host: DSI host for this peripheral
>>    * @dev: driver model device node for this peripheral
>>    * @name: DSI peripheral chip type
>>  + * @bus_type: MIPI bus type (MIPI_DEVICE_TYPE_DSI/...)
>>    * @channel: virtual channel assigned to the peripheral
>>    * @format: pixel format for video mode
>>    * @lanes: number of active data lanes
>>  @@ -178,6 +189,7 @@ struct mipi_dsi_device {
>>   	struct device dev;
>>=20
>>   	char name[DSI_DEV_NAME_SIZE];
>>  +	unsigned int bus_type;
>>   	unsigned int channel;
>>   	unsigned int lanes;
>>   	enum mipi_dsi_pixel_format format;
>=20
> --
> Regards,
>=20
> Laurent Pinchart


