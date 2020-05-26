Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3CBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF8820776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaODvcmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgEZSXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:23:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729867AbgEZSX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590517407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkybwaL5hV3//CnMmHVpyyCIBF14CepvpJObWY76xLg=;
        b=gaODvcmMmiW12tGgXNwvuCgVjxHnP3hWMmoSIiiYkvQN7zB+se1av9zhztfHgx9YKDVRdD
        aeJTWPtv5JNfWWPGMjRCdnTACpG/P9WBKm042kr/NtZWaDs0TZo2l/WnfBb8D++GpIX71r
        Mn583dm91F7dR9FOaraBWV1fVAi9QFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-yT4UDOvfM4Kj0e1axdhmBw-1; Tue, 26 May 2020 14:23:25 -0400
X-MC-Unique: yT4UDOvfM4Kj0e1axdhmBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C56E1005510;
        Tue, 26 May 2020 18:23:23 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-19.rdu2.redhat.com [10.10.120.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA34778B2D;
        Tue, 26 May 2020 18:23:21 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Lee Shawn C <shawn.c.lee@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Cooper Chiou <cooper.chiou@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/i915/mst: filter out the display mode exceed sink's capability
Date:   Tue, 26 May 2020 14:23:10 -0400
Message-Id: <20200526182313.4005-3-lyude@redhat.com>
In-Reply-To: <20200526182313.4005-1-lyude@redhat.com>
References: <20200526182313.4005-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Shawn C <shawn.c.lee@intel.com>

So far, max dot clock rate for MST mode rely on physcial
bandwidth limitation. It would caused compatibility issue
if source display resolution exceed MST hub output ability.

For example, source DUT had DP 1.2 output capability.
And MST docking just support HDMI 1.4 spec. When a HDMI 2.0
monitor connected. Source would retrieve EDID from external
and get max resolution 4k@60fps. DP 1.2 can support 4K@60fps
because it did not surpass DP physical bandwidth limitation.
Do modeset to 4k@60fps, source output display data but MST
docking can't output HDMI properly due to this resolution
already over HDMI 1.4 spec.

Refer to commit <fcf463807596> ("drm/dp_mst: Use full_pbn
instead of available_pbn for bandwidth checks").
Source driver should refer to full_pbn to evaluate sink
output capability. And filter out the resolution surpass
sink output limitation.

v2: Using mgr->base.lock to protect full_pbn.
v3: Add ctx lock.
v4:
* s/intel_dp_mst_mode_clock_exceed_pbn_bandwidth/
  intel_dp_mst_mode_clock_exceeds_pbn_bw/
* Use the new drm_connector_helper_funcs.mode_valid_ctx to properly pipe
  down the drm_modeset_acquire_ctx that the probe helpers are using, so
  we can safely grab &mgr->base.lock without deadlocking

Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Cooper Chiou <cooper.chiou@intel.com>
Co-developed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lee Shawn C <shawn.c.lee@intel.com>
Tested-by: Lee Shawn C <shawn.c.lee@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 39 ++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index d18b406f2a7d2..cf052095ad785 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -610,15 +610,42 @@ static int intel_dp_mst_get_modes(struct drm_connector *connector)
 	return intel_dp_mst_get_ddc_modes(connector);
 }
 
+static int
+intel_dp_mst_mode_clock_exceeds_pbn_bw(struct drm_connector *connector,
+				       struct drm_modeset_acquire_ctx *ctx,
+				       int clock, int bpp)
+{
+	struct intel_connector *intel_connector = to_intel_connector(connector);
+	struct intel_dp *intel_dp = intel_connector->mst_port;
+	struct drm_dp_mst_topology_mgr *mgr = &intel_dp->mst_mgr;
+	struct drm_dp_mst_port *port = (to_intel_connector(connector))->port;
+	int ret = MODE_OK;
+
+	if (!mgr)
+		return ret;
+
+	ret = drm_modeset_lock(&mgr->base.lock, ctx);
+	if (ret == -EDEADLK)
+		return ret;
+
+	if (port->full_pbn &&
+	    drm_dp_calc_pbn_mode(clock, bpp, false) > port->full_pbn)
+		ret = MODE_CLOCK_HIGH;
+
+	return ret;
+}
+
 static enum drm_mode_status
-intel_dp_mst_mode_valid(struct drm_connector *connector,
-			struct drm_display_mode *mode)
+intel_dp_mst_mode_valid_ctx(struct drm_connector *connector,
+			    struct drm_display_mode *mode,
+			    struct drm_modeset_acquire_ctx *ctx)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 	int max_dotclk = to_i915(connector->dev)->max_dotclk_freq;
 	int max_rate, mode_rate, max_lanes, max_link_clock;
+	int ret;
 
 	if (drm_connector_is_unregistered(connector))
 		return MODE_ERROR;
@@ -632,7 +659,11 @@ intel_dp_mst_mode_valid(struct drm_connector *connector,
 	max_rate = intel_dp_max_data_rate(max_link_clock, max_lanes);
 	mode_rate = intel_dp_link_required(mode->clock, 18);
 
-	/* TODO - validate mode against available PBN for link */
+	ret = intel_dp_mst_mode_clock_exceeds_pbn_bw(connector, ctx,
+						     mode->clock, 24);
+	if (ret != MODE_OK)
+		return ret;
+
 	if (mode->clock < 10000)
 		return MODE_CLOCK_LOW;
 
@@ -671,7 +702,7 @@ intel_dp_mst_detect(struct drm_connector *connector,
 
 static const struct drm_connector_helper_funcs intel_dp_mst_connector_helper_funcs = {
 	.get_modes = intel_dp_mst_get_modes,
-	.mode_valid = intel_dp_mst_mode_valid,
+	.mode_valid_ctx = intel_dp_mst_mode_valid_ctx,
 	.atomic_best_encoder = intel_mst_atomic_best_encoder,
 	.atomic_check = intel_dp_mst_atomic_check,
 	.detect_ctx = intel_dp_mst_detect,
-- 
2.26.2

