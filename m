Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BD6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCCF2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597837850;
	bh=NPewrDTOQbIKmWxXXrLEDvEG+pl4mWNIoi6RAjja1/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yKmO4eJm7ylXGmOu6NaiN2K8k7VGZP2vxkpjsuV2zNSrfe2y3ywiHMfIwQ0jrm3vE
	 bwX7btjoifp3dJv5chLqHjKyjlXx+sj3MiGzbmvAEJN1GGzKAGtmIWq3UUKDnJvZI8
	 aRtHjoLxCtnzmghJVkTd21M6t1KsD8MixhiyoIQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHSLus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgHSLqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:46:22 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28ACF2078D;
        Wed, 19 Aug 2020 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837581;
        bh=NPewrDTOQbIKmWxXXrLEDvEG+pl4mWNIoi6RAjja1/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDFKXpid8S8rDjXPJRzuawn0UghvyY07/CGHDrTode5w1EVMLyvEjEpzs6jkIVr9k
         XNUCIfwBP1mN6tMdvxgmRsgNBZmcphF0jTjLp9tky3DAG2EVTPWXOT2GvQ7boI384/
         z6Cj/20fL/GBvI/6vMKYxlaCTCoeoU0Rgc0o9+1I=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXr-00Eua2-6K; Wed, 19 Aug 2020 13:46:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Liwei Cai <cailiwei@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/49] staging: hikey9xx/gpu: solve tearing issue of display
Date:   Wed, 19 Aug 2020 13:45:31 +0200
Message-Id: <5a1a1acbf05e0d9aa44795e668c16f972006e40f.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liwei Cai <cailiwei@hisilicon.com>

The use of synchronization mechanisms to deal with the display of
buffer, to solve the problem of display tearing.

Signed-off-by: Wanchun Zheng <zhengwanchun@hisilicon.com>
Signed-off-by: Liwei Cai <cailiwei@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/dw_drm_dsi.c     |  3 +-
 drivers/staging/hikey9xx/gpu/kirin_drm_dss.c  |  4 +-
 .../hikey9xx/gpu/kirin_drm_overlay_utils.c    | 90 ++++++++-----------
 3 files changed, 41 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c b/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c
index 9871b375416b..db408beb33ec 100644
--- a/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c
+++ b/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c
@@ -35,7 +35,6 @@
 
 #define DTS_COMP_DSI_NAME "hisilicon,hi3660-dsi"
 
-#define MAX_TX_ESC_CLK		10
 #define ROUND(x, y)		((x) / (y) + \
 				((x) % (y) * 10 / (y) >= 5 ? 1 : 0))
 #define ROUND1(x, y)	((x) / (y) + ((x) % (y)  ? 1 : 0))
@@ -1237,7 +1236,7 @@ static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
 	host->dev = dev;
 	host->ops = &dsi_host_ops;
 
-	mipi->max_tx_esc_clk = 10;
+	mipi->max_tx_esc_clk = 10 * 1000000UL;
 	mipi->vc = 0;
 	mipi->color_mode = DSI_24BITS_1;
 	mipi->clk_post_adjust = 120;
diff --git a/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c
index c47d860f4697..62ac1a0648cc 100644
--- a/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c
@@ -167,8 +167,8 @@ static int dss_power_up(struct dss_crtc *acrtc)
 	dss_inner_clk_common_enable(acrtc);
 	dpe_interrupt_mask(acrtc);
 	dpe_interrupt_clear(acrtc);
-	dpe_irq_enable(acrtc);
-	dpe_interrupt_unmask(acrtc);
+	//dpe_irq_enable(acrtc);
+	//dpe_interrupt_unmask(acrtc);
 
 	ctx->power_on = true;
 	return 0;
diff --git a/drivers/staging/hikey9xx/gpu/kirin_drm_overlay_utils.c b/drivers/staging/hikey9xx/gpu/kirin_drm_overlay_utils.c
index 095335eba16d..917e1a7d7bdf 100644
--- a/drivers/staging/hikey9xx/gpu/kirin_drm_overlay_utils.c
+++ b/drivers/staging/hikey9xx/gpu/kirin_drm_overlay_utils.c
@@ -30,6 +30,7 @@
 
 
 #define DSS_CHN_MAX_DEFINE (DSS_COPYBIT_MAX)
+#define TIME_OUT  (16)
 
 static int mid_array[DSS_CHN_MAX_DEFINE] = {0xb, 0xa, 0x9, 0x8, 0x7, 0x6, 0x5, 0x4, 0x2, 0x1, 0x3, 0x0};
 
@@ -1064,6 +1065,38 @@ void hisi_dss_unflow_handler(struct dss_hw_ctx *ctx, bool unmask)
 	outp32(dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INT_MSK, tmp);
 }
 
+void hisi_dss_wait_for_complete(struct dss_hw_ctx *ctx, bool need_clear)
+{
+	void __iomem *dss_base;
+	u32 tmp = 0;
+	u32 isr_s2 = 0;
+
+	if (!ctx) {
+		DRM_ERROR("ctx is NULL!\n");
+		return;
+	}
+
+	dss_base = ctx->base;
+
+	do {
+		isr_s2 = inp32(dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INTS);
+		if (isr_s2 & BIT_VACTIVE0_END) {
+			DRM_DEBUG("hisi_dss_wait_for_complete exit! temp = %d\n", tmp);
+			if (need_clear)
+				outp32(dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INTS, BIT_VACTIVE0_END);
+			break;
+		} else {
+			msleep(1);
+			tmp++;
+		}
+	} while (tmp < TIME_OUT);
+
+	if (tmp == TIME_OUT) {
+		isr_s2 = inp32(dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INTS);
+		DRM_INFO("wait vactive0_end timeout: isr_s2 = 0x%x\n", isr_s2);
+	}
+}
+#if 0
 static int hisi_vactive0_start_config(struct dss_hw_ctx *ctx)
 {
 	int ret = 0;
@@ -1094,6 +1127,7 @@ static int hisi_vactive0_start_config(struct dss_hw_ctx *ctx)
 
 	return ret;
 }
+#endif
 
 void hisi_fb_pan_display(struct drm_plane *plane)
 {
@@ -1109,9 +1143,6 @@ void hisi_fb_pan_display(struct drm_plane *plane)
 	struct kirin_drm_private *priv = plane->dev->dev_private;
 	struct kirin_fbdev *fbdev = to_kirin_fbdev(priv->fbdev);
 
-	ktime_t prepare_timestamp;
-	u64 vsync_timediff;
-
 	bool afbcd = false;
 	bool mmu_enable = true;
 	dss_rect_ltrb_t rect;
@@ -1164,26 +1195,7 @@ void hisi_fb_pan_display(struct drm_plane *plane)
 	vbp = mode->vtotal - mode->vsync_end;
 	vsw = mode->vsync_end - mode->vsync_start;
 
-	vsync_timediff = (uint64_t)(mode->hdisplay + hbp + hfp + hsw) *
-		(mode->vdisplay + vbp + vfp + vsw) *
-		1000000000UL / (adj_mode->clock * 1000);
-
-	prepare_timestamp = ktime_get();
-
-	if ((ktime_to_ns(prepare_timestamp) > ktime_to_ns(ctx->vsync_timestamp)) &&
-		(ktime_to_ns(prepare_timestamp) - ktime_to_ns(ctx->vsync_timestamp) < (vsync_timediff - 2000000)) &&
-		(ktime_to_ns(ctx->vsync_timestamp_prev) != ktime_to_ns(ctx->vsync_timestamp))) {
-		DRM_DEBUG("vsync_timediff=%llu, timestamp_diff=%llu!\n",
-			vsync_timediff, ktime_to_ns(prepare_timestamp) - ktime_to_ns(ctx->vsync_timestamp));
-	} else {
-		DRM_DEBUG("vsync_timediff=%llu.\n", vsync_timediff);
-
-		if (hisi_vactive0_start_config(ctx) != 0) {
-			DRM_ERROR("hisi_vactive0_start_config failed!\n");
-			return;
-		}
-	}
-	ctx->vsync_timestamp_prev = ctx->vsync_timestamp;
+	hisi_dss_wait_for_complete(ctx, true);
 
 	hisi_dss_mctl_mutex_lock(ctx);
 	hisi_dss_aif_ch_config(ctx, chn_idx);
@@ -1198,9 +1210,8 @@ void hisi_fb_pan_display(struct drm_plane *plane)
 	hisi_dss_mctl_sys_config(ctx, chn_idx);
 	hisi_dss_mctl_mutex_unlock(ctx);
 
-	hisi_dss_unflow_handler(ctx, true);
-
 	enable_ldi(acrtc);
+	hisi_dss_wait_for_complete(ctx, false);
 }
 
 void hisi_dss_online_play(struct drm_plane *plane, drm_dss_layer_t *layer)
@@ -1213,9 +1224,6 @@ void hisi_dss_online_play(struct drm_plane *plane, drm_dss_layer_t *layer)
 	struct dss_crtc *acrtc = aplane->acrtc;
 	struct dss_hw_ctx *ctx = acrtc->ctx;
 
-	ktime_t prepare_timestamp;
-	u64 vsync_timediff;
-
 	bool afbcd = false;
 	bool mmu_enable = true;
 	dss_rect_ltrb_t rect;
@@ -1249,28 +1257,7 @@ void hisi_dss_online_play(struct drm_plane *plane, drm_dss_layer_t *layer)
 	vfp = mode->vsync_start - mode->vdisplay;
 	vbp = mode->vtotal - mode->vsync_end;
 	vsw = mode->vsync_end - mode->vsync_start;
-
-	vsync_timediff = (uint64_t)(mode->hdisplay + hbp + hfp + hsw) *
-		(mode->vdisplay + vbp + vfp + vsw) *
-		1000000000UL / (adj_mode->clock * 1000);
-
-	prepare_timestamp = ktime_get();
-
-	if ((ktime_to_ns(prepare_timestamp) > ktime_to_ns(ctx->vsync_timestamp)) &&
-		(ktime_to_ns(prepare_timestamp) - ktime_to_ns(ctx->vsync_timestamp) < (vsync_timediff - 2000000)) &&
-		(ktime_to_ns(ctx->vsync_timestamp_prev) != ktime_to_ns(ctx->vsync_timestamp))) {
-		DRM_DEBUG("vsync_timediff=%llu, timestamp_diff=%llu!\n",
-			vsync_timediff, ktime_to_ns(prepare_timestamp) - ktime_to_ns(ctx->vsync_timestamp));
-	} else {
-		DRM_DEBUG("vsync_timediff=%llu.\n", vsync_timediff);
-
-		if (hisi_vactive0_start_config(ctx) != 0) {
-			DRM_ERROR("hisi_vactive0_start_config failed!\n");
-			return;
-		}
-	}
-
-	ctx->vsync_timestamp_prev = ctx->vsync_timestamp;
+	hisi_dss_wait_for_complete(ctx, true);
 
 	hisi_dss_mctl_mutex_lock(ctx);
 	hisi_dss_aif_ch_config(ctx, chn_idx);
@@ -1285,7 +1272,6 @@ void hisi_dss_online_play(struct drm_plane *plane, drm_dss_layer_t *layer)
 	hisi_dss_mctl_sys_config(ctx, chn_idx);
 	hisi_dss_mctl_mutex_unlock(ctx);
 
-	hisi_dss_unflow_handler(ctx, true);
-
 	enable_ldi(acrtc);
+	hisi_dss_wait_for_complete(ctx, false);
 }
-- 
2.26.2

