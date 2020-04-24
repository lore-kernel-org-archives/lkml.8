Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA7C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7297520767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDXGgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:36:21 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:16337 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgDXGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:36:21 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id C0A69482514;
        Fri, 24 Apr 2020 14:36:12 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v2] drm/arm: fixes pixel clock enabled with wrong format
Date:   Thu, 23 Apr 2020 23:35:51 -0700
Message-Id: <20200424063551.14336-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVOS01CQkJCTUJPQ0lPSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxQ6Ijo*PTg*HlYTM0IQNSIQ
        HBQaCSJVSlVKTkNMTEpLSkxNS09IVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSElPTTcG
X-HM-Tid: 0a71aae69f0d93bakuwsc0a69482514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pixel clock is still enabled when the format is wrong.
no error branch handle, and also some register is not set
in this case, e.g: HDLCD_REG_<color>_SELECT. Maybe we
should disable this clock and throw an warn message when
this happened.
With this change, the code maybe a bit more readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*add format error handle, if format is not correct, throw
an warning message and disable this clock.

Link for V1:
*https://lore.kernel.org/patchwork/patch/1228501/
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index af67fefed38d..f3945dee2b7d 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -96,7 +96,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
 	}
 
 	if (WARN_ON(!format))
-		return 0;
+		return -EINVAL;
 
 	/* HDLCD uses 'bytes per pixel', zero means 1 byte */
 	btpp = (format->bits_per_pixel + 7) / 8;
@@ -125,7 +125,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
 	return 0;
 }
 
-static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
+static int hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
 	struct drm_display_mode *m = &crtc->state->adjusted_mode;
@@ -162,9 +162,10 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	err = hdlcd_set_pxl_fmt(crtc);
 	if (err)
-		return;
+		return err;
 
 	clk_set_rate(hdlcd->clk, m->crtc_clock * 1000);
+	return 0;
 }
 
 static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -173,7 +174,11 @@ static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
 
 	clk_prepare_enable(hdlcd->clk);
-	hdlcd_crtc_mode_set_nofb(crtc);
+	if (hdlcd_crtc_mode_set_nofb(crtc)) {
+		DRM_DEBUG_KMS("Invalid format, pixel clock enable failed!\n");
+		clk_disable_unprepare(hdlcd->clk);
+		return;
+	}
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
 	drm_crtc_vblank_on(crtc);
 }
-- 
2.26.2

