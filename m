Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16752078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKLxVFu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHTD41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTD40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:56:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93668C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:56:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z23so272164plo.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LFTcC1aLlcyeO02My6c2qM77nYX84bs/G0eccqWdp8=;
        b=zKLxVFu4Dg3PQ1EfE/gMN6Q/9V3SUjEcpJci/s0ywSt5tlKuJsaiV58p4HFeN3/5TL
         51PwPoSUzkq+piYo6ZuUNZQMaKxlJnkKKDKUdmONgsBdTTES0jHonRkMIqVYFJp+TLh/
         2KL/xWSqUUjrTIn0y2tsgmuVreBtpvGInfY1p8MfClhqL2L+VN9D+H37sDAJx7BynlgT
         WxK6cZrKv3hTbdKSYdfJwrtWGLPNUo4aefePUbFWGl6GiOrOXQGsYtlSLiDSxPZr9Tbh
         8puli8qrbhX58+IJmOagiJgdfHOja1jqoNyL2htDUvoTa5skihArxs4N6gQ1ys3FFCuk
         xqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LFTcC1aLlcyeO02My6c2qM77nYX84bs/G0eccqWdp8=;
        b=F45erZUnWMMssWjCLTmg0lnRjZThQIAwZAjj1O4KLV9JzaDA6+eFo0yYkwNQxAId7c
         kn01el8VHGByrH3wkj2QBTCeZ8EfrUOS7UjHEVNPtCkZK41842lI7FlxtZdsXjxRN9O6
         vltnmU6Taq207HVsZR+Ajh2t+Jj1TN5PpcOiSYBd5mdqYZNfdmb0fZI/77Hu8iFMzYEA
         LXqkOzRmwF7g9cELL7NLK8s8VKI1nEOWp7mIYmVzykFvGofgxUnYxQ++5z1PSTj6NSN8
         lT0fVaS2pH3Y/fPRbZ4nkFvFaBGAok/uAs0UX/CCnRghTMGjztNyjfYQLIeUGhvGgUMG
         ClQQ==
X-Gm-Message-State: AOAM5337PZNCENW2/x6MqfPlFn2uciuwenAifpePg9GnBuQS5/j96v34
        eS+/gbLQo/SU36G93reQ8OorTOrXRIji7g==
X-Google-Smtp-Source: ABdhPJwzXXRtWo8gBWKqXwGsX+9ri1iFa4kPakvat1NHTNiDKd791H+hxLLpHH4BLHMLq5iZqXv0Jg==
X-Received: by 2002:a17:90a:4dca:: with SMTP id r10mr858796pjl.200.1597895784572;
        Wed, 19 Aug 2020 20:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o65sm759429pfg.176.2020.08.19.20.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 20:56:23 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4/3] drm: hikey9xx: remove wait for VACTIVE IRQ
Date:   Thu, 20 Aug 2020 03:56:17 +0000
Message-Id: <20200820035617.5836-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820034100.128062-2-john.stultz@linaro.org>
References: <20200820034100.128062-2-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

A quick add-on to my earlier fixup series as I realized what the
performance problem was.

This is against Mauro's tree here:
    https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master/

For each display cycle, the Kirin960 display IP will generate a VACTIVE
interrupt followed by a VBLANK. During a FBIOPAN ioctl, the driver will then
wait for the first one to then wait for the second one. This is an issue when
the CPU load is too low: the wait_event() function might trigger a transition
to a deep sleep state and then, waking up from that state will take too much
time to catch the VBLANK interrupt on time, the difference between those two
interrupts being only 60 us.

* Ideal case:                   ACT                VBL
				+                  +
				v                  v
		 ---> wait(ACT) +------> wait(VBL) +-->

* Our case:                     ACT VBL        ACT VBL
				+   +          +   +
				v   v          v   v
		 ---> wait(ACT) +------> wait(VBL) +-->

The wait for VACTIVE IRQ can safely be removed: there is no hardware access
performed between the VACTIVE and the VBLANK IRQs.

This behavior has been introduced from 4.11 with the following patch:
a3fbb53f4 drm/atomic: Wait for vblank whenever a plane is added to state.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Liwei Cai <cailiwei@hisilicon.com>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
[jstultz: hand-ported to Mauro's patch set]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../hikey9xx/gpu/kirin9xx_drm_dpe_utils.c     |  2 +-
 .../staging/hikey9xx/gpu/kirin9xx_drm_dss.c   |  5 ---
 .../hikey9xx/gpu/kirin9xx_drm_overlay_utils.c | 36 -------------------
 3 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
index 82a0edb95953..cc80689d90c9 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
@@ -582,7 +582,7 @@ void dpe_interrupt_unmask(struct dss_crtc *acrtc)
 	writel(unmask, dss_base + GLB_CPU_PDP_INT_MSK);
 
 	unmask = ~0;
-	unmask &= ~(BIT_VSYNC | BIT_VACTIVE0_END | BIT_LDI_UNFLOW);
+	unmask &= ~(BIT_VSYNC | BIT_LDI_UNFLOW);
 
 	writel(unmask, dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INT_MSK);
 }
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index 7adbd924bec2..c99ce7c4d479 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -440,11 +440,6 @@ static irqreturn_t dss_irq_handler(int irq, void *data)
 	isr_s1 &= ~(readl(dss_base + GLB_CPU_PDP_INT_MSK));
 	isr_s2 &= ~(readl(dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INT_MSK));
 
-	if (isr_s2 & BIT_VACTIVE0_END) {
-		ctx->vactive0_end_flag++;
-		wake_up_interruptible_all(&ctx->vactive0_end_wq);
-	}
-
 	if (isr_s2 & BIT_VSYNC) {
 		ctx->vsync_timestamp = ktime_get();
 		drm_crtc_handle_vblank(crtc);
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
index 5ac7f4b31d99..932bad2f428e 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
@@ -822,40 +822,6 @@ void hisifb_mctl_sw_clr(struct dss_crtc *acrtc)
 	DRM_INFO("-.\n");
 }
 
-static int hisi_dss_wait_for_complete(struct dss_crtc *acrtc)
-{
-	int ret = 0;
-	u32 times = 0;
-	u32 prev_vactive0_end = 0;
-	struct dss_hw_ctx *ctx = acrtc->ctx;
-
-	prev_vactive0_end = ctx->vactive0_end_flag;
-
-REDO:
-	ret = wait_event_interruptible_timeout(ctx->vactive0_end_wq,
-					       (prev_vactive0_end != ctx->vactive0_end_flag),
-		msecs_to_jiffies(300));
-	if (ret == -ERESTARTSYS) {
-		if (times < 50) {
-			times++;
-			mdelay(10);
-			goto REDO;
-		}
-	}
-
-	if (ret <= 0) {
-		disable_ldi(acrtc);
-		hisifb_mctl_sw_clr(acrtc);
-		DRM_ERROR("wait_for vactive0_end_flag timeout! ret=%d.\n", ret);
-
-		ret = -ETIMEDOUT;
-	} else {
-		ret = 0;
-	}
-
-	return ret;
-}
-
 void hisi_fb_pan_display(struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
@@ -932,7 +898,6 @@ void hisi_fb_pan_display(struct drm_plane *plane)
 	hisi_dss_unflow_handler(ctx, true);
 
 	enable_ldi(acrtc);
-	hisi_dss_wait_for_complete(acrtc);
 }
 
 void hisi_dss_online_play(struct kirin_fbdev *fbdev, struct drm_plane *plane,
@@ -1001,5 +966,4 @@ void hisi_dss_online_play(struct kirin_fbdev *fbdev, struct drm_plane *plane,
 	hisi_dss_unflow_handler(ctx, true);
 
 	enable_ldi(acrtc);
-	hisi_dss_wait_for_complete(acrtc);
 }
-- 
2.17.1

