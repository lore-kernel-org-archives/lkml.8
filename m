Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ACFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFF420781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHLIeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:34:21 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:54602 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgHLIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:34:19 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1D2F4C0C54;
        Wed, 12 Aug 2020 16:34:15 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P31771T140662796187392S1597221250509047_;
        Wed, 12 Aug 2020 16:34:15 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <69b1af1b415bf5000b6580fc378eeefa>
X-RL-SENDER: algea.cao@rock-chips.com
X-SENDER: algea.cao@rock-chips.com
X-LOGIN-NAME: algea.cao@rock-chips.com
X-FST-TO: a.hajda@samsung.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Algea Cao <algea.cao@rock-chips.com>
To:     a.hajda@samsung.com, kuankuan.y@gmail.com, hjc@rock-chips.com,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, airlied@linux.ie, heiko@sntech.de,
        jernej.skrabec@siol.net, algea.cao@rock-chips.com,
        Laurent.pinchart@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com, jonas@kwiboo.se,
        mripard@kernel.org, darekm@google.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, cychiang@chromium.org,
        linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, maarten.lankhorst@linux.intel.com,
        daniel@ffwll.ch
Subject: [PATCH 1/6] drm: Add connector atomic_begin/atomic_flush
Date:   Wed, 12 Aug 2020 16:34:07 +0800
Message-Id: <20200812083407.856-1-algea.cao@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812083120.743-1-algea.cao@rock-chips.com>
References: <20200812083120.743-1-algea.cao@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some situations, connector should get some work done
when plane is updating. Such as when change output color
format, hdmi should send AVMUTE to make screen black before
crtc updating color format, or screen may flash. After color
updating, hdmi should clear AVMUTE bring screen back to normal.

The process is as follows:
AVMUTE -> Update CRTC -> Update HDMI -> Clear AVMUTE

So we introduce connector atomic_begin/atomic_flush.

Signed-off-by: Algea Cao <algea.cao@rock-chips.com>

---

 drivers/gpu/drm/drm_atomic_helper.c      | 46 ++++++++++++++++++++++++
 include/drm/drm_modeset_helper_vtables.h | 19 ++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index f68c69a45752..f4abd700d2c4 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2471,6 +2471,8 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 				     struct drm_atomic_state *old_state,
 				     uint32_t flags)
 {
+	struct drm_connector *connector;
+	struct drm_connector_state *old_connector_state, *new_connector_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct drm_plane *plane;
@@ -2479,6 +2481,28 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 	bool active_only = flags & DRM_PLANE_COMMIT_ACTIVE_ONLY;
 	bool no_disable = flags & DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET;
 
+	for_each_oldnew_connector_in_state(old_state, connector,
+					   old_connector_state,
+					   new_connector_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+
+		if (!connector->state->crtc)
+			continue;
+
+		if (!connector->state->crtc->state->active)
+			continue;
+
+		funcs = connector->helper_private;
+
+		if (!funcs || !funcs->atomic_begin)
+			continue;
+
+		DRM_DEBUG_ATOMIC("flush beginning [CONNECTOR:%d:%s]\n",
+				 connector->base.id, connector->name);
+
+		funcs->atomic_begin(connector, old_connector_state);
+	}
+
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
 		const struct drm_crtc_helper_funcs *funcs;
 
@@ -2550,6 +2574,28 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 
 		funcs->atomic_flush(crtc, old_crtc_state);
 	}
+
+	for_each_oldnew_connector_in_state(old_state, connector,
+					   old_connector_state,
+					   new_connector_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+
+		if (!connector->state->crtc)
+			continue;
+
+		if (!connector->state->crtc->state->active)
+			continue;
+
+		funcs = connector->helper_private;
+
+		if (!funcs || !funcs->atomic_flush)
+			continue;
+
+		DRM_DEBUG_ATOMIC("flushing [CONNECTOR:%d:%s]\n",
+				 connector->base.id, connector->name);
+
+		funcs->atomic_flush(connector, old_connector_state);
+	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_planes);
 
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 421a30f08463..10f3f2e2fe28 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1075,6 +1075,25 @@ struct drm_connector_helper_funcs {
 	void (*atomic_commit)(struct drm_connector *connector,
 			      struct drm_connector_state *state);
 
+	/**
+	 * @atomic_begin:
+	 *
+	 * flush atomic update
+	 *
+	 * This callback is used by the atomic modeset helpers but it is optional.
+	 */
+	void (*atomic_begin)(struct drm_connector *connector,
+			     struct drm_connector_state *state);
+
+	/**
+	 * @atomic_begin:
+	 *
+	 * begin atomic update
+	 *
+	 * This callback is used by the atomic modeset helpers but it is optional.
+	 */
+	void (*atomic_flush)(struct drm_connector *connector,
+			     struct drm_connector_state *state);
 	/**
 	 * @prepare_writeback_job:
 	 *
-- 
2.25.1



