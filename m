Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB23020644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pp3345.net header.i=@pp3345.net header.b="CFd8qH59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389254AbgDMVvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:51:50 -0400
Received: from saul.pp3345.net ([163.172.111.124]:56738 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389229AbgDMVvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:51:42 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id 00F7F9A45ED;
        Mon, 13 Apr 2020 23:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1586814184; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=jiSzLqUhJT84Fasmh/xWn11q8s8/UivOsitInucSSJg=;
        b=CFd8qH59JP/5gV8RWHTJ+Q1AnwXANR1VUuKdmiADvZwtdJqvJwUtz16q2oqTh86CizOueZ
        3xg6SId6u6mcd5ZBdhD8taTEVX/ODQr36v6Rscx9lALPIKzmm8qH8KBIHcf+C3V62vwg0x
        oM/5OJgtJNxPFZJ8d/JLz5MeYLeBK0RjkXaY1Pp5oMhLdckQvOg82+7X/MUgTcR7ewc0Xx
        oXbBKHShLFLyv1wz90hOBnhLOaP9mRcFbWGWI+wzSUcJn+rwt2idOGuwBt7jP571XE9jrl
        b6sPl12OlWWQofs/CJEs0MJqO5+31d2i6HplVM6r4714+aRUoMh87Dn/bJv/1g==
From:   Yussuf Khalil <dev@pp3345.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH 2/5] drm: Add "RGB quantization range" connector property
Date:   Mon, 13 Apr 2020 23:40:23 +0200
Message-Id: <20200413214024.46500-3-dev@pp3345.net>
In-Reply-To: <20200413214024.46500-1-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new "RGB quantization range" property with three possible values:
Automatic, Limited, and Full. User-space may use this property to override
the automatic selection of the RGB range as specified by CTA-861. Drivers
should attach this property to all CTA-861 sinks.

Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
 drivers/gpu/drm/drm_atomic_uapi.c |  4 ++++
 drivers/gpu/drm/drm_connector.c   | 35 +++++++++++++++++++++++++++++++
 include/drm/drm_connector.h       | 23 ++++++++++++++++++++
 include/drm/drm_mode_config.h     |  7 +++++++
 4 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index a1e5e262bae2..f12b3a40c6cf 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -766,6 +766,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 						   fence_ptr);
 	} else if (property == connector->max_bpc_property) {
 		state->max_requested_bpc = val;
+	} else if (property == config->rgb_quantization_range_property) {
+		state->rgb_quantization_range = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -842,6 +844,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = 0;
 	} else if (property == connector->max_bpc_property) {
 		*val = state->max_requested_bpc;
+	} else if (property == config->rgb_quantization_range_property) {
+		*val = state->rgb_quantization_range;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 644f0ad10671..e60d3b6e5e56 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -929,6 +929,12 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
 	{ DRM_MODE_COLORIMETRY_BT2020_YCC, "BT2020_YCC" },
 };
 
+static const struct drm_prop_enum_list rgb_quantization_range_options[] = {
+	{ DRM_MODE_RGB_QUANTIZATION_RANGE_AUTOMATIC, "Automatic" },
+	{ DRM_MODE_RGB_QUANTIZATION_RANGE_LIMITED, "Limited" },
+	{ DRM_MODE_RGB_QUANTIZATION_RANGE_FULL, "Full" },
+};
+
 /**
  * DOC: standard connector properties
  *
@@ -1804,6 +1810,35 @@ int drm_mode_create_dp_colorspace_property(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_mode_create_dp_colorspace_property);
 
+/**
+ * drm_mode_create_rgb_quantization_range_property - create RGB quantization
+ * range property
+ * @dev: device to create the RGB quantization range property on.
+ *
+ * Called by a driver the first time it's needed, must be attached to connectors
+ * of CEA-861-compliant sinks.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_mode_create_rgb_quantization_range_property(struct drm_device *dev)
+{
+	if (dev->mode_config.rgb_quantization_range_property)
+		return 0;
+
+	dev->mode_config.rgb_quantization_range_property =
+		drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,
+					 "RGB quantization range",
+					 rgb_quantization_range_options,
+					 ARRAY_SIZE(rgb_quantization_range_options));
+
+	if (!dev->mode_config.rgb_quantization_range_property)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_mode_create_rgb_quantization_range_property);
+
 /**
  * drm_mode_create_content_type_property - create content type property
  * @dev: DRM device
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 19ae6bb5c85b..f605e0fbcc0e 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -303,6 +303,22 @@ struct drm_monitor_range_info {
 #define DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT		14
 #define DRM_MODE_COLORIMETRY_BT601_YCC			15
 
+/**
+ * enum drm_rgb_quantization_range - rgb_quantization_range property value
+ *
+ * This enum lists the possible options for the rgb_quantization_range property.
+ *
+ * @DRM_MODE_RGB_QUANTIZATION_RANGE_AUTOMATIC:	Let the driver select the
+ * 						appropriate quantization range.
+ * @DRM_MODE_RGB_QUANTIZATION_RANGE_LIMITED:	Force limited range RGB.
+ * @DRM_MODE_RGB_QUANTIZATION_RANGE_FULL:	Force full range RGB.
+ */
+enum drm_rgb_quantization_range {
+	DRM_MODE_RGB_QUANTIZATION_RANGE_AUTOMATIC = 0,
+	DRM_MODE_RGB_QUANTIZATION_RANGE_LIMITED = 1,
+	DRM_MODE_RGB_QUANTIZATION_RANGE_FULL = 2,
+};
+
 /**
  * enum drm_bus_flags - bus_flags info for &drm_display_info
  *
@@ -661,6 +677,12 @@ struct drm_connector_state {
 	 */
 	u32 colorspace;
 
+	/**
+	 * @rgb_quantization_range: Connector property to control the selected
+	 * RGB quantization range for CEA-861 outputs.
+	 */
+	u32 rgb_quantization_range;
+
 	/**
 	 * @writeback_job: Writeback job for writeback connectors
 	 *
@@ -1575,6 +1597,7 @@ int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
 int drm_mode_create_hdmi_colorspace_property(struct drm_connector *connector);
 int drm_mode_create_dp_colorspace_property(struct drm_connector *connector);
 int drm_mode_create_content_type_property(struct drm_device *dev);
+int drm_mode_create_rgb_quantization_range_property(struct drm_device *dev);
 void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
 					 const struct drm_connector_state *conn_state);
 
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 3bcbe30339f0..745587f6b83c 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -855,6 +855,13 @@ struct drm_mode_config {
 	 */
 	struct drm_property *hdcp_content_type_property;
 
+	/**
+	 * @rgb_quantization_range_property: Connector property to allow
+	 * user-space to override the RGB quantization range for CEA-861
+	 * outputs.
+	 */
+	struct drm_property *rgb_quantization_range_property;
+
 	/* dumb ioctl parameters */
 	uint32_t preferred_depth, prefer_shadow;
 
-- 
2.26.0

