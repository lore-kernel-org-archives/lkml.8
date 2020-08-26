Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F3DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3691E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Owub4hcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHZS0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgHZSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq12btJPBuHOrj0w3zi2T9XyamHKGC4hSg1URPs6B7A=;
        b=Owub4hcdHJRTt9hTu9VPRCP0W+df2el6N9qeRdDhXo5N9L3HvEXmhYNjOAwcaOQr5eRqAT
        7kAQcwgl/YS2xS7cg2fbkwKEgDGyu+RwNKfb9vLpdP2idgpS61SjbHFiiotGyVMA0eyIEK
        mmFG3W6AYyYSG2FLg+hP4RkIgcjnTKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-zEGhErP5MSyZ6-OuVFbP-w-1; Wed, 26 Aug 2020 14:25:45 -0400
X-MC-Unique: zEGhErP5MSyZ6-OuVFbP-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9910A8015AD;
        Wed, 26 Aug 2020 18:25:42 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-77.rdu2.redhat.com [10.10.119.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 897D3100238E;
        Wed, 26 Aug 2020 18:25:40 +0000 (UTC)
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
Subject: [PATCH v5 09/20] drm/i915/dp: Extract drm_dp_read_mst_cap()
Date:   Wed, 26 Aug 2020 14:24:45 -0400
Message-Id: <20200826182456.322681-10-lyude@redhat.com>
In-Reply-To: <20200826182456.322681-1-lyude@redhat.com>
References: <20200826182456.322681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a tiny drive-by cleanup, we can consolidate i915's code for
checking for MST support into a helper to be shared across drivers.

v5:
* Drop !!()
* Move drm_dp_has_mst() out of header
* Change name from drm_dp_has_mst() to drm_dp_read_mst_cap()

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c   | 22 ++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 18 ++----------------
 include/drm/drm_dp_mst_helper.h         |  3 +--
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 67dd72ea200e0..17dbed0a9800d 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3486,6 +3486,28 @@ static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
 	return dp_link_bw * dp_link_count / 2;
 }
 
+/**
+ * drm_dp_read_mst_cap() - check whether or not a sink supports MST
+ * @aux: The DP AUX channel to use
+ * @dpcd: A cached copy of the DPCD capabilities for this sink
+ *
+ * Returns: %True if the sink supports MST, %false otherwise
+ */
+bool drm_dp_read_mst_cap(struct drm_dp_aux *aux,
+			 const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	u8 mstm_cap;
+
+	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_12)
+		return false;
+
+	if (drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &mstm_cap) != 1)
+		return false;
+
+	return mstm_cap & DP_MST_CAP;
+}
+EXPORT_SYMBOL(drm_dp_read_mst_cap);
+
 /**
  * drm_dp_mst_topology_mgr_set_mst() - Set the MST state for a topology manager
  * @mgr: manager to set state for
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 79c27f91f42c0..4c7314b7a84e4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4699,20 +4699,6 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 	return true;
 }
 
-static bool
-intel_dp_sink_can_mst(struct intel_dp *intel_dp)
-{
-	u8 mstm_cap;
-
-	if (intel_dp->dpcd[DP_DPCD_REV] < 0x12)
-		return false;
-
-	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_MSTM_CAP, &mstm_cap) != 1)
-		return false;
-
-	return mstm_cap & DP_MST_CAP;
-}
-
 static bool
 intel_dp_can_mst(struct intel_dp *intel_dp)
 {
@@ -4720,7 +4706,7 @@ intel_dp_can_mst(struct intel_dp *intel_dp)
 
 	return i915->params.enable_dp_mst &&
 		intel_dp->can_mst &&
-		intel_dp_sink_can_mst(intel_dp);
+		drm_dp_read_mst_cap(&intel_dp->aux, intel_dp->dpcd);
 }
 
 static void
@@ -4729,7 +4715,7 @@ intel_dp_configure_mst(struct intel_dp *intel_dp)
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
 	struct intel_encoder *encoder =
 		&dp_to_dig_port(intel_dp)->base;
-	bool sink_can_mst = intel_dp_sink_can_mst(intel_dp);
+	bool sink_can_mst = drm_dp_read_mst_cap(&intel_dp->aux, intel_dp->dpcd);
 
 	drm_dbg_kms(&i915->drm,
 		    "[ENCODER:%d:%s] MST support: port: %s, sink: %s, modparam: %s\n",
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 8b9eb4db3381c..6ae5860d8644e 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -728,10 +728,9 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 
 void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr);
 
-
+bool drm_dp_read_mst_cap(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state);
 
-
 int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled);
 
 
-- 
2.26.2

