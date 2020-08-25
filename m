Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F80C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1062074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPcZtLbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHYTvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbgHYTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598385096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmfhbTgiJshdHk/qquvzkEDDNHj6aCysj8P0ZBueTi8=;
        b=bPcZtLbgVLfmItD2Z8s8UpWBYOeDWRGggn3tjY+womO6r9J2oUpFMW3ZRniQEHX0B6Utvb
        pzidZyeMRvVjaOu5N5MjYIYh5qexWBSHykLH1y7en44126Ai0LXcbJnzlTYjrjvD0kK/h9
        MvL1bB3rmO2feoXIJiFGwv4ZACcXG1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-vkVFVHivMUeBAxcpWM8r2g-1; Tue, 25 Aug 2020 15:51:32 -0400
X-MC-Unique: vkVFVHivMUeBAxcpWM8r2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3914E80EFA7;
        Tue, 25 Aug 2020 19:51:29 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-227.rdu2.redhat.com [10.10.120.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85B975D9D3;
        Tue, 25 Aug 2020 19:51:27 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 15/20] drm/i915/dp: Extract drm_dp_has_sink_count()
Date:   Tue, 25 Aug 2020 15:50:22 -0400
Message-Id: <20200825195027.74681-16-lyude@redhat.com>
In-Reply-To: <20200825195027.74681-1-lyude@redhat.com>
References: <20200825195027.74681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since other drivers are also going to need to be aware of the sink count
in order to do proper dongle detection, we might as well steal i915's
DP_SINK_COUNT helpers and move them into DRM helpers so that other
dirvers can use them as well.

Note that this also starts using intel_dp_has_sink_count() in
intel_dp_detect_dpcd(), which is a functional change.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_helper.c         | 22 ++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 21 ++++++++++++---------
 include/drm/drm_dp_helper.h             |  8 +++++++-
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 4f845995f1f66..863e0babc1903 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -714,6 +714,28 @@ void drm_dp_set_subconnector_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_dp_set_subconnector_property);
 
+/**
+ * drm_dp_has_sink_count() - Check whether a given connector has a valid sink
+ * count
+ * @connector: The DRM connector to check
+ * @dpcd: A cached copy of the connector's DPCD RX capabilities
+ * @desc: A cached copy of the connector's DP descriptor
+ *
+ * Returns: %True if the (e)DP connector has a valid sink count that should
+ * be probed, %false otherwise.
+ */
+bool drm_dp_has_sink_count(struct drm_connector *connector,
+			   const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+			   const struct drm_dp_desc *desc)
+{
+	/* Some eDP panels don't set a valid value for the sink count */
+	return connector->connector_type != DRM_MODE_CONNECTOR_eDP &&
+		dpcd[DP_DPCD_REV] >= DP_DPCD_REV_11 &&
+		dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT &&
+		!drm_dp_has_quirk(desc, 0, DP_DPCD_QUIRK_NO_SINK_COUNT);
+}
+EXPORT_SYMBOL(drm_dp_has_sink_count);
+
 /*
  * I2C-over-AUX implementation
  */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 984e49194ca31..35a4779a442e2 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4634,6 +4634,16 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
 	return true;
 }
 
+static bool
+intel_dp_has_sink_count(struct intel_dp *intel_dp)
+{
+	if (!intel_dp->attached_connector)
+		return false;
+
+	return drm_dp_has_sink_count(&intel_dp->attached_connector->base,
+				     intel_dp->dpcd,
+				     &intel_dp->desc);
+}
 
 static bool
 intel_dp_get_dpcd(struct intel_dp *intel_dp)
@@ -4653,13 +4663,7 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 		intel_dp_set_common_rates(intel_dp);
 	}
 
-	/*
-	 * Some eDP panels do not set a valid value for sink count, that is why
-	 * it don't care about read it here and in intel_edp_init_dpcd().
-	 */
-	if (!intel_dp_is_edp(intel_dp) &&
-	    !drm_dp_has_quirk(&intel_dp->desc, 0,
-			      DP_DPCD_QUIRK_NO_SINK_COUNT)) {
+	if (intel_dp_has_sink_count(intel_dp)) {
 		u8 count;
 		ssize_t r;
 
@@ -5939,9 +5943,8 @@ intel_dp_detect_dpcd(struct intel_dp *intel_dp)
 		return connector_status_connected;
 
 	/* If we're HPD-aware, SINK_COUNT changes dynamically */
-	if (intel_dp->dpcd[DP_DPCD_REV] >= 0x11 &&
+	if (intel_dp_has_sink_count(intel_dp) &&
 	    intel_dp->downstream_ports[0] & DP_DS_PORT_HPD) {
-
 		return intel_dp->sink_count ?
 		connector_status_connected : connector_status_disconnected;
 	}
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 1349f16564ace..a1413a531eaf4 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1631,6 +1631,11 @@ void drm_dp_set_subconnector_property(struct drm_connector *connector,
 				      const u8 *dpcd,
 				      const u8 port_cap[4]);
 
+struct drm_dp_desc;
+bool drm_dp_has_sink_count(struct drm_connector *connector,
+			   const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+			   const struct drm_dp_desc *desc);
+
 void drm_dp_remote_aux_init(struct drm_dp_aux *aux);
 void drm_dp_aux_init(struct drm_dp_aux *aux);
 int drm_dp_aux_register(struct drm_dp_aux *aux);
@@ -1689,7 +1694,8 @@ enum drm_dp_quirk {
 	 * @DP_DPCD_QUIRK_NO_SINK_COUNT:
 	 *
 	 * The device does not set SINK_COUNT to a non-zero value.
-	 * The driver should ignore SINK_COUNT during detection.
+	 * The driver should ignore SINK_COUNT during detection. Note that
+	 * drm_dp_has_sink_count() automatically checks for this quirk.
 	 */
 	DP_DPCD_QUIRK_NO_SINK_COUNT,
 	/**
-- 
2.26.2

