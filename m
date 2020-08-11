Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0869DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D440320774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj9nmbbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHKUGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:06:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52408 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbgHKUG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597176386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63ODGXkWyW49riNxJEU4/mDwKu93Z8a6CqD+BfsvOP0=;
        b=Mj9nmbbDZObRJ9ayt+OWk5fjtktlRLHl54801ug/aD7S/d8DedFckfQQ/hcuZQkdRRfnM/
        ETe5gvJxvyIV6UdqX5supqA1hYRUgi9qFeWhIyz2iCECCnLct/NxprPEuVzfxdeW469t7y
        h1bJddZLttWC/Ca4AlHFohxF1/xlhXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-C__81l_kO0-MLbvGWdX2qg-1; Tue, 11 Aug 2020 16:06:22 -0400
X-MC-Unique: C__81l_kO0-MLbvGWdX2qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0D7F1005510;
        Tue, 11 Aug 2020 20:06:19 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 697F15D9DD;
        Tue, 11 Aug 2020 20:06:17 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: [RFC 09/20] drm/i915/dp: Extract drm_dp_has_mst()
Date:   Tue, 11 Aug 2020 16:04:46 -0400
Message-Id: <20200811200457.134743-10-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-1-lyude@redhat.com>
References: <20200811200457.134743-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a tiny drive-by cleanup, we can consolidate i915's code for
checking for MST support into a helper to be shared across drivers.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 18 ++----------------
 include/drm/drm_dp_mst_helper.h         | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 79c27f91f42c0..1e29d3a012856 100644
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
+		drm_dp_has_mst(&intel_dp->aux, intel_dp->dpcd);
 }
 
 static void
@@ -4729,7 +4715,7 @@ intel_dp_configure_mst(struct intel_dp *intel_dp)
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
 	struct intel_encoder *encoder =
 		&dp_to_dig_port(intel_dp)->base;
-	bool sink_can_mst = intel_dp_sink_can_mst(intel_dp);
+	bool sink_can_mst = drm_dp_has_mst(&intel_dp->aux, intel_dp->dpcd);
 
 	drm_dbg_kms(&i915->drm,
 		    "[ENCODER:%d:%s] MST support: port: %s, sink: %s, modparam: %s\n",
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 8b9eb4db3381c..2d8983a713e8c 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -911,4 +911,26 @@ __drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
 	for ((__i) = 0; (__i) < (__state)->num_private_objs; (__i)++) \
 		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), NULL, &(new_state), (__i)))
 
+/**
+ * drm_dp_has_mst() - check whether or not a sink supports MST
+ * @aux: The DP AUX channel to use
+ * @dpcd: A cached copy of the DPCD capabilities for this sink
+ *
+ * Returns: %True if the sink supports MST, %false otherwise
+ */
+static inline bool
+drm_dp_has_mst(struct drm_dp_aux *aux,
+	       const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	u8 mstm_cap;
+
+	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_12)
+		return false;
+
+	if (drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &mstm_cap) != 1)
+		return false;
+
+	return !!(mstm_cap & DP_MST_CAP);
+}
+
 #endif
-- 
2.26.2

