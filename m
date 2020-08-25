Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ACCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E21205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnlNnUrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgHYCcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgHYCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:32:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:32:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so8031557qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOLsO/hnUA/LXpNmtoh/FCzJgvBB5RVzQBuVn0F6EAA=;
        b=GnlNnUrB3sMP4jxWWpQpqDub903wvoeJbSB0z5dfsWOV/fjCLC7LRzWhQq3T/xNEZQ
         0oyjQocFVl2FkNKrWHDuNGrufhqD6JVg1rMCSn0oya2l3dlfs+yBFLNhnW7Vx5vQVzj3
         KcacmqcEc3DvJ84CpHnOYRlOivWzmpOombsqJL6FvutA+60zfsZJydSqSrWzB3HTo50W
         856l/n+RRMHzAy3IG7/fFaK8nKh8KIMs/BMD81gvDVopZ7wsoIJ9w4pyNz9rAfS0SHhD
         XztITviLzkqma1krM95XebPrvjyrVDrt1bH7FQbIGIX+r78u3qw3LaT4j7jhu8CrutwV
         /BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOLsO/hnUA/LXpNmtoh/FCzJgvBB5RVzQBuVn0F6EAA=;
        b=mbIfl1pDNexCF/4HmBX1HBamdwTvYWNKGXEHDMRzZFdonrwHu4qjCy286WPkbalXgs
         qPT9FxPlO73qdYSccPH19seZCPpwIXefp9oCUrpyGiF2Kw4jomjSOJXIipHAE+hwh7VS
         stNK18EIqOTPzUnkhkoWSvFm6voDP/EQWv3hbNBOgGxbaIENh2KfoGt1tcm7SJGRBcNl
         GAEOHSusD2ZLbzm6+KpabRK00MOFEuhkpbsXFpMFGgnvlrJ0g2FEG+/5b5pW1btYS6Zo
         0boQHhqMlaOfbmLNjLw39QioHIngeHx+uLMLxaJ3xYL8eU01nDGgZzWb6dfU13G4k8NU
         37GA==
X-Gm-Message-State: AOAM531Q2aq145NRD1/ZAwOfBuPkHT458eRoc4+RfMoVZAY0d5NQKJbh
        rYOX28677KVPtFZajnuzl5RS0enm0cI=
X-Google-Smtp-Source: ABdhPJyvGty6paSSOX3Q5MrEImvZC95pdW0pTY4moROBRByKUhesYuLqBN0xMlmfMPPic2NnseeStw==
X-Received: by 2002:ac8:33a1:: with SMTP id c30mr3978255qtb.156.1598322720872;
        Mon, 24 Aug 2020 19:32:00 -0700 (PDT)
Received: from atma2.hitronhub.home ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id x137sm11095372qkb.47.2020.08.24.19.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:32:00 -0700 (PDT)
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        melissa.srw@gmail.com, daniels@collabora.com,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH v5 3/3] drm/vkms: Add support for writeback
Date:   Mon, 24 Aug 2020 22:31:42 -0400
Message-Id: <20200825023142.2561220-4-rodrigosiqueiramelo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
References: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the necessary functions to add writeback support
for vkms. This feature is useful for testing compositors if you don't
have hardware with writeback support.

Change in V4 (Emil and Melissa):
- Move signal completion above drm_crtc_add_crc_entry()
- Make writeback always available
- Use appropriate namespace
- Drop fb check in vkms_wb_atomic_commit
- Make vkms_set_composer visible for writeback code
- Enable composer operation on prepare_job and disable it on cleanup_job

Change in V3 (Daniel):
- If writeback is enabled, compose everything into the writeback buffer
instead of CRC private buffer
- Guarantees that the CRC will match exactly what we have in the
writeback buffer.

Change in V2:
- Rework signal completion (Brian)
- Integrates writeback with active_planes (Daniel)
- Compose cursor (Daniel)

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/Makefile         |   9 +-
 drivers/gpu/drm/vkms/vkms_composer.c  |  21 +++-
 drivers/gpu/drm/vkms/vkms_drv.h       |  11 +-
 drivers/gpu/drm/vkms/vkms_output.c    |   4 +
 drivers/gpu/drm/vkms/vkms_writeback.c | 143 ++++++++++++++++++++++++++
 5 files changed, 181 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 0b767d7efa24..333d3cead0e3 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
-vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_composer.o
+vkms-y := \
+	vkms_drv.o \
+	vkms_plane.o \
+	vkms_output.o \
+	vkms_crtc.o \
+	vkms_gem.o \
+	vkms_composer.o \
+	vkms_writeback.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 387b0690a64a..656085c4ebf3 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -163,16 +163,17 @@ void vkms_composer_worker(struct work_struct *work)
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	struct vkms_composer *primary_composer = NULL;
 	struct vkms_composer *cursor_composer = NULL;
+	bool crc_pending, wb_pending;
 	void *vaddr_out = NULL;
 	u32 crc32 = 0;
 	u64 frame_start, frame_end;
-	bool crc_pending;
 	int ret;
 
 	spin_lock_irq(&out->composer_lock);
 	frame_start = crtc_state->frame_start;
 	frame_end = crtc_state->frame_end;
 	crc_pending = crtc_state->crc_pending;
+	wb_pending = crtc_state->wb_pending;
 	crtc_state->frame_start = 0;
 	crtc_state->frame_end = 0;
 	crtc_state->crc_pending = false;
@@ -194,22 +195,32 @@ void vkms_composer_worker(struct work_struct *work)
 	if (!primary_composer)
 		return;
 
+	if (wb_pending)
+		vaddr_out = crtc_state->active_writeback;
+
 	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
 	if (ret) {
-		if (ret == -EINVAL)
+		if (ret == -EINVAL && !wb_pending)
 			kfree(vaddr_out);
 		return;
 	}
 
 	crc32 = compute_crc(vaddr_out, primary_composer);
 
+	if (wb_pending) {
+		drm_writeback_signal_completion(&out->wb_connector, 0);
+		spin_lock_irq(&out->composer_lock);
+		crtc_state->wb_pending = false;
+		spin_unlock_irq(&out->composer_lock);
+	} else {
+		kfree(vaddr_out);
+	}
+
 	/*
 	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
 	 */
 	while (frame_start <= frame_end)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
-
-	kfree(vaddr_out);
 }
 
 static const char * const pipe_crc_sources[] = {"auto"};
@@ -252,7 +263,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	return 0;
 }
 
-static void vkms_set_composer(struct vkms_output *out, bool enabled)
+void vkms_set_composer(struct vkms_output *out, bool enabled)
 {
 	bool old_enabled;
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index f4036bb0b9a8..641d8bc52a3a 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -8,6 +8,7 @@
 #include <drm/drm.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_writeback.h>
 
 #define XRES_MIN    20
 #define YRES_MIN    20
@@ -19,6 +20,7 @@
 #define YRES_MAX  8192
 
 extern bool enable_cursor;
+extern bool enable_writeback;
 
 struct vkms_composer {
 	struct drm_framebuffer fb;
@@ -52,9 +54,11 @@ struct vkms_crtc_state {
 	int num_active_planes;
 	/* stack of active planes for crc computation, should be in z order */
 	struct vkms_plane_state **active_planes;
+	void *active_writeback;
 
-	/* below three are protected by vkms_output.composer_lock */
+	/* below four are protected by vkms_output.composer_lock */
 	bool crc_pending;
+	bool wb_pending;
 	u64 frame_start;
 	u64 frame_end;
 };
@@ -63,6 +67,7 @@ struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
+	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
@@ -143,5 +148,9 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
+void vkms_set_composer(struct vkms_output *out, bool enabled);
+
+/* Writeback */
+int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
 
 #endif /* _VKMS_DRV_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 85afb77e97f0..4a1848b0318f 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -80,6 +80,10 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		goto err_attach;
 	}
 
+	ret = vkms_enable_writeback_connector(vkmsdev);
+	if (ret)
+		DRM_ERROR("Failed to init writeback connector\n");
+
 	drm_mode_config_reset(dev);
 
 	return 0;
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
new file mode 100644
index 000000000000..ddcd5ad0d7aa
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "vkms_drv.h"
+#include <drm/drm_fourcc.h>
+#include <drm/drm_writeback.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+
+static const u32 vkms_wb_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static const struct drm_connector_funcs vkms_wb_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	struct drm_framebuffer *fb;
+	const struct drm_display_mode *mode = &crtc_state->mode;
+
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
+		return 0;
+
+	fb = conn_state->writeback_job->fb;
+	if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
+		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
+			      fb->width, fb->height);
+		return -EINVAL;
+	}
+
+	if (fb->format->format != vkms_wb_formats[0]) {
+		struct drm_format_name_buf format_name;
+
+		DRM_DEBUG_KMS("Invalid pixel format %s\n",
+			      drm_get_format_name(fb->format->format,
+						  &format_name));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct drm_encoder_helper_funcs vkms_wb_encoder_helper_funcs = {
+	.atomic_check = vkms_wb_encoder_atomic_check,
+};
+
+static int vkms_wb_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+
+	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
+				    dev->mode_config.max_height);
+}
+
+static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+			       struct drm_writeback_job *job)
+{
+	struct vkms_gem_object *vkms_obj;
+	struct drm_gem_object *gem_obj;
+	int ret;
+
+	if (!job->fb)
+		return 0;
+
+	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
+	ret = vkms_gem_vmap(gem_obj);
+	if (ret) {
+		DRM_ERROR("vmap failed: %d\n", ret);
+		return ret;
+	}
+
+	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
+	job->priv = vkms_obj->vaddr;
+
+	return 0;
+}
+
+static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
+				struct drm_writeback_job *job)
+{
+	struct drm_gem_object *gem_obj;
+	struct vkms_device *vkmsdev;
+
+	if (!job->fb)
+		return;
+
+	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
+	vkms_gem_vunmap(gem_obj);
+
+	vkmsdev = drm_device_to_vkms_device(gem_obj->dev);
+	vkms_set_composer(&vkmsdev->output, false);
+}
+
+static void vkms_wb_atomic_commit(struct drm_connector *conn,
+				  struct drm_connector_state *state)
+{
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
+	struct vkms_output *output = &vkmsdev->output;
+	struct drm_writeback_connector *wb_conn = &output->wb_connector;
+	struct drm_connector_state *conn_state = wb_conn->base.state;
+	struct vkms_crtc_state *crtc_state = output->composer_state;
+
+	if (!conn_state)
+		return;
+
+	vkms_set_composer(&vkmsdev->output, true);
+
+	spin_lock_irq(&output->composer_lock);
+	crtc_state->active_writeback = conn_state->writeback_job->priv;
+	crtc_state->wb_pending = true;
+	spin_unlock_irq(&output->composer_lock);
+	drm_writeback_queue_job(wb_conn, state);
+}
+
+static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
+	.get_modes = vkms_wb_connector_get_modes,
+	.prepare_writeback_job = vkms_wb_prepare_job,
+	.cleanup_writeback_job = vkms_wb_cleanup_job,
+	.atomic_commit = vkms_wb_atomic_commit,
+};
+
+int vkms_enable_writeback_connector(struct vkms_device *vkmsdev)
+{
+	struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
+
+	vkmsdev->output.wb_connector.encoder.possible_crtcs = 1;
+	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
+
+	return drm_writeback_connector_init(&vkmsdev->drm, wb,
+					    &vkms_wb_connector_funcs,
+					    &vkms_wb_encoder_helper_funcs,
+					    vkms_wb_formats,
+					    ARRAY_SIZE(vkms_wb_formats));
+}
+
-- 
2.28.0

