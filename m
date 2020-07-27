Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D007C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5BC20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="yhPiQhes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgG0Qqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:46:45 -0400
Received: from crapouillou.net ([89.234.176.41]:37174 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgG0Qqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595868391; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqfSgQzDELNwOPH2++W23zbJDoB5JUf3lopWLT9PtM0=;
        b=yhPiQhes6EAEZgb3hpxsN/oO6TuzCuK7uWU/NDYUgzIMrn26cIxb9DkrDt8+hbEq6fKAPj
        q9aHeO/a9v48FIkjPep7gKIVHRpqgO1TJj4/D4lugT6wDZIDjMXHx0KBWQeME0KFav/TP7
        JvjHYstxPk8f3QKD4TfXNbDkKa9jSa8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/6] drm: dsi: Let host and device specify supported bus
Date:   Mon, 27 Jul 2020 18:46:09 +0200
Message-Id: <20200727164613.19744-3-paul@crapouillou.net>
In-Reply-To: <20200727164613.19744-1-paul@crapouillou.net>
References: <20200727164613.19744-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current MIPI DSI framework can very well be used to support MIPI DBI
panels. In order to add support for the various bus types supported by
DBI, the DRM panel drivers should specify the bus type they will use,
and the DSI host drivers should specify the bus types they are
compatible with.

The DSI host driver can then use the information provided by the DBI/DSI
device driver, such as the bus type and the number of lanes, to
configure its hardware properly.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/drm_mipi_dsi.c |  9 +++++++++
 include/drm/drm_mipi_dsi.h     | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5dd475e82995..11ef885de765 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -281,6 +281,9 @@ int mipi_dsi_host_register(struct mipi_dsi_host *host)
 {
 	struct device_node *node;
 
+	if (WARN_ON_ONCE(!host->bus_types))
+		host->bus_types = MIPI_DEVICE_TYPE_DSI;
+
 	for_each_available_child_of_node(host->dev->of_node, node) {
 		/* skip nodes without reg property */
 		if (!of_find_property(node, "reg", NULL))
@@ -323,6 +326,12 @@ int mipi_dsi_attach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
 
+	if (WARN_ON_ONCE(!dsi->bus_type))
+		dsi->bus_type = MIPI_DEVICE_TYPE_DSI;
+
+	if (!(dsi->bus_type & dsi->host->bus_types))
+		return -EINVAL;
+
 	if (!ops || !ops->attach)
 		return -ENOSYS;
 
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 360e6377e84b..65d2961fc054 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -63,6 +63,14 @@ struct mipi_dsi_packet {
 int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
 			   const struct mipi_dsi_msg *msg);
 
+/* MIPI bus types */
+#define MIPI_DEVICE_TYPE_DSI		BIT(0)
+#define MIPI_DEVICE_TYPE_DBI_SPI_MODE1	BIT(1)
+#define MIPI_DEVICE_TYPE_DBI_SPI_MODE2	BIT(2)
+#define MIPI_DEVICE_TYPE_DBI_SPI_MODE3	BIT(3)
+#define MIPI_DEVICE_TYPE_DBI_M6800	BIT(4)
+#define MIPI_DEVICE_TYPE_DBI_I8080	BIT(5)
+
 /**
  * struct mipi_dsi_host_ops - DSI bus operations
  * @attach: attach DSI device to DSI host
@@ -94,11 +102,13 @@ struct mipi_dsi_host_ops {
  * struct mipi_dsi_host - DSI host device
  * @dev: driver model device node for this DSI host
  * @ops: DSI host operations
+ * @bus_types: Bitmask of supported MIPI bus types
  * @list: list management
  */
 struct mipi_dsi_host {
 	struct device *dev;
 	const struct mipi_dsi_host_ops *ops;
+	unsigned int bus_types;
 	struct list_head list;
 };
 
@@ -162,6 +172,7 @@ struct mipi_dsi_device_info {
  * @host: DSI host for this peripheral
  * @dev: driver model device node for this peripheral
  * @name: DSI peripheral chip type
+ * @bus_type: MIPI bus type (MIPI_DEVICE_TYPE_DSI/...)
  * @channel: virtual channel assigned to the peripheral
  * @format: pixel format for video mode
  * @lanes: number of active data lanes
@@ -178,6 +189,7 @@ struct mipi_dsi_device {
 	struct device dev;
 
 	char name[DSI_DEV_NAME_SIZE];
+	unsigned int bus_type;
 	unsigned int channel;
 	unsigned int lanes;
 	enum mipi_dsi_pixel_format format;
-- 
2.27.0

