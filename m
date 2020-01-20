Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2468C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80892217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgATRG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:06:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgATRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:06:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DDCE929132E
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 3/5] drm/rockchip: vop: Fix CRTC unbind
Date:   Mon, 20 Jan 2020 14:06:00 -0300
Message-Id: <20200120170602.3832-4-ezequiel@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120170602.3832-1-ezequiel@collabora.com>
References: <20200120170602.3832-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fix device unbinding, the CRTC release path needs to
be fixed. Get rid of the use-after-free issue that arise
for calling drm_crtc_cleanup() prematurely, by moving
all the CRTC resource release to the crtc.destroy() hook.

The vop_unbind() function is only responsible for the release
of driver-specific (i.e. vop-specific) resources.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 56 ++++++++-------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index d04b3492bdac..87c43097da7e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1387,6 +1387,11 @@ static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
 
 static void vop_crtc_destroy(struct drm_crtc *crtc)
 {
+	struct vop *vop = to_vop(crtc);
+
+	drm_flip_work_cleanup(&vop->fb_unref_work);
+	drm_self_refresh_helper_cleanup(crtc);
+	of_node_put(crtc->port);
 	drm_crtc_cleanup(crtc);
 }
 
@@ -1606,12 +1611,22 @@ static void vop_plane_add_properties(struct drm_plane *plane,
 						   DRM_MODE_ROTATE_0 | flags);
 }
 
+static void vop_plane_cleanup(struct vop *vop)
+{
+	struct drm_device *drm_dev = vop->drm_dev;
+	struct drm_plane *plane, *tmp;
+
+	list_for_each_entry_safe(plane, tmp, &drm_dev->mode_config.plane_list,
+				 head)
+		drm_plane_cleanup(plane);
+}
+
 static int vop_create_crtc(struct vop *vop)
 {
 	const struct vop_data *vop_data = vop->data;
 	struct device *dev = vop->dev;
 	struct drm_device *drm_dev = vop->drm_dev;
-	struct drm_plane *primary = NULL, *cursor = NULL, *plane, *tmp;
+	struct drm_plane *primary = NULL, *cursor = NULL;
 	struct drm_crtc *crtc = &vop->crtc;
 	struct device_node *port;
 	int ret;
@@ -1625,6 +1640,7 @@ static int vop_create_crtc(struct vop *vop)
 	for (i = 0; i < vop_data->win_size; i++) {
 		struct vop_win *vop_win = &vop->win[i];
 		const struct vop_win_data *win_data = vop_win->data;
+		struct drm_plane *plane;
 
 		if (win_data->type != DRM_PLANE_TYPE_PRIMARY &&
 		    win_data->type != DRM_PLANE_TYPE_CURSOR)
@@ -1714,42 +1730,10 @@ static int vop_create_crtc(struct vop *vop)
 err_cleanup_crtc:
 	drm_crtc_cleanup(crtc);
 err_cleanup_planes:
-	list_for_each_entry_safe(plane, tmp, &drm_dev->mode_config.plane_list,
-				 head)
-		drm_plane_cleanup(plane);
+	vop_plane_cleanup(vop);
 	return ret;
 }
 
-static void vop_destroy_crtc(struct vop *vop)
-{
-	struct drm_crtc *crtc = &vop->crtc;
-	struct drm_device *drm_dev = vop->drm_dev;
-	struct drm_plane *plane, *tmp;
-
-	drm_self_refresh_helper_cleanup(crtc);
-
-	of_node_put(crtc->port);
-
-	/*
-	 * We need to cleanup the planes now.  Why?
-	 *
-	 * The planes are "&vop->win[i].base".  That means the memory is
-	 * all part of the big "struct vop" chunk of memory.  That memory
-	 * was devm allocated and associated with this component.  We need to
-	 * free it ourselves before vop_unbind() finishes.
-	 */
-	list_for_each_entry_safe(plane, tmp, &drm_dev->mode_config.plane_list,
-				 head)
-		vop_plane_destroy(plane);
-
-	/*
-	 * Destroy CRTC after vop_plane_destroy() since vop_disable_plane()
-	 * references the CRTC.
-	 */
-	drm_crtc_cleanup(crtc);
-	drm_flip_work_cleanup(&vop->fb_unref_work);
-}
-
 static int vop_initial(struct vop *vop)
 {
 	struct reset_control *ahb_rst;
@@ -2020,7 +2004,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
-	vop_destroy_crtc(vop);
+	vop_plane_cleanup(vop);
+	vop_crtc_destroy(&vop->crtc);
 	return ret;
 }
 
@@ -2032,7 +2017,6 @@ static void vop_unbind(struct device *dev, struct device *master, void *data)
 		rockchip_rgb_fini(vop->rgb);
 
 	pm_runtime_disable(dev);
-	vop_destroy_crtc(vop);
 
 	clk_unprepare(vop->aclk);
 	clk_unprepare(vop->hclk);
-- 
2.25.0

