Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6208FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256DF20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qz+ogVx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDHGFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:05:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37970 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgDHGFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:05:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id 13so2870475qtt.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 23:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=la175c9DEDIHk3uGIF+L0/B/W9ixXMBxxvxYraHXojQ=;
        b=qz+ogVx5bzbsbrrMH2avUgVhCc0+CZz48kXXeN4Ftk6sjRa2KdGvP9q73zpEDXcuCT
         Nw97Q2VkqpOlbBqI6KZLzopH2Uhp4D9/jyyxibHBQRvzGJIKijJJBzZADNBRGar9BRVx
         +RAfz9T+ZF1T5mp5B2S/wsNEBrVk1QaR+HE4OhLbvypeEjBVkxjAHLAZLM2AvAs+GShQ
         tVzb1aJBcTc8yLUVZbY3/X19PGk16mAy5bx4+vkUAuBJgtW7LYWTfPWINt7f2MDDLl6/
         HBGAaTtnXzUFmY4d+gzBArtKYumQ5hYJIoMIIJ5QyLEH5J+wW6bwzhDTJTf77cIRdcN3
         eiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=la175c9DEDIHk3uGIF+L0/B/W9ixXMBxxvxYraHXojQ=;
        b=gK3jKPJi99G6NHnMlg2l1AgPOu3qr2lzUgi5sEJvpOks3gHCLQDv8UqTQtFYVqqpp3
         vCrKH3DFwdJLMTThPMDG+VMOFpHy0w8yJz9r0/5finsOmZ1gH7RF9YksjbMOJf/MH/OL
         OPrEFN+hCo4sTEAEwHX+qTvHMAScbLnaqN17ybynmi2lJCkOr4/FCG1bT5Ij7b2y5lgV
         elIKDU2XHSoRP80yXyZi/iAgcHy4BSk7yA60cONQD1aJchu09eSuLEwAXHS0sxNtsOVr
         qRMLXkrC1B1qKK9af1PHt5EnbBgrZw1boI+p2TT/soQ3dg57jHSl/BCMFEimomI/Y3XI
         qFog==
X-Gm-Message-State: AGi0PuaBg3mUhwdpGn3FrPnUQx1UvIbVGddEyrgWuTT/l4CFOn1B291K
        xynyp9vVfFiK0wFxKGdCX7A=
X-Google-Smtp-Source: APiQypIxjg/UarBlnhzp5LojE1qS1IvhJl5fzF/2MxPsw/z48xlte+1dkmItkK+xfp/3YqiH65Fv1w==
X-Received: by 2002:ac8:2dae:: with SMTP id p43mr5933924qta.341.1586325947491;
        Tue, 07 Apr 2020 23:05:47 -0700 (PDT)
Received: from arch.localdomain (189-69-221-86.dial-up.telesp.net.br. [189.69.221.86])
        by smtp.gmail.com with ESMTPSA id w30sm19664170qtw.21.2020.04.07.23.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 23:05:46 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, manasi.d.navare@intel.com
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 2/2] drm/vkms: Add 'virtual_hw' module option
Date:   Wed,  8 Apr 2020 03:05:03 -0300
Message-Id: <20200408060503.47709-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408060503.47709-1-gabrielabittencourt00@gmail.com>
References: <20200408060503.47709-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Virtual Vblank, virtual hardware module option ('virtual_hw')
allows to skip the timing of vblank routine.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 28 ++++++++++++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.c  | 13 +++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h  |  2 ++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index a72769b81efe..d4aa1ed93bf2 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -58,6 +58,18 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 	return HRTIMER_RESTART;
 }
 
+static void vkms_virtual_vblank_simulate(struct vkms_output *output,
+					 struct drm_crtc *crtc)
+{
+	struct vkms_crtc_state *state;
+	bool ret;
+
+	state = output->composer_state;
+	ret = vkms_queue_compose_worker(output, state);
+	if (!ret)
+		DRM_DEBUG_DRIVER("Composer worker already queued\n");
+}
+
 static int vkms_enable_vblank(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
@@ -214,16 +226,25 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 	return 0;
 }
 
+static bool vkms_crtc_atomic_check_vblank_enable(struct drm_crtc *crtc)
+{
+	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
+
+	return (!vkms_out->disable_vblank);
+}
+
 static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
-	drm_crtc_vblank_on(crtc);
+	if (vkms_crtc_atomic_check_vblank_enable(crtc))
+		drm_crtc_vblank_on(crtc);
 }
 
 static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_crtc_state *old_state)
 {
-	drm_crtc_vblank_off(crtc);
+	if (vkms_crtc_atomic_check_vblank_enable(crtc))
+		drm_crtc_vblank_off(crtc);
 }
 
 static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -258,6 +279,9 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 	vkms_output->composer_state = to_vkms_crtc_state(crtc->state);
 
 	spin_unlock_irq(&vkms_output->lock);
+
+	if (vkms_output->disable_vblank)
+		vkms_virtual_vblank_simulate(vkms_output, crtc);
 }
 
 static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index eef85f1a0ce5..f7c25961b083 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -39,6 +39,11 @@ bool enable_cursor;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
 
+bool virtual_hw;
+module_param_named(virtual_hw, virtual_hw, bool, 0444);
+MODULE_PARM_DESC(virtual_hw,
+		 "Enable virtual hardware mode / Disable vblank");
+
 static const struct file_operations vkms_driver_fops = {
 	.owner		= THIS_MODULE,
 	.open		= drm_open,
@@ -168,9 +173,13 @@ static int __init vkms_init(void)
 		goto out_put;
 	}
 
-	vkms_device->drm.irq_enabled = true;
+	vkms_device->output.disable_vblank = virtual_hw;
+	vkms_device->drm.irq_enabled = !virtual_hw;
+
+	if (virtual_hw)
+		DRM_INFO("Virtual hardware mode enabled");
 
-	ret = drm_vblank_init(&vkms_device->drm, 1);
+	ret = (virtual_hw) ? 0 : drm_vblank_init(&vkms_device->drm, 1);
 	if (ret) {
 		DRM_ERROR("Failed to vblank\n");
 		goto out_put;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index eda04ffba7b1..52ad8e06adc5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -19,6 +19,7 @@
 #define YRES_MAX  8192
 
 extern bool enable_cursor;
+extern bool virtual_hw;
 
 struct vkms_composer {
 	struct drm_framebuffer fb;
@@ -64,6 +65,7 @@ struct vkms_output {
 	struct drm_encoder encoder;
 	struct drm_connector connector;
 	struct hrtimer vblank_hrtimer;
+	bool disable_vblank;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
 	/* ordered wq for composer_work */
-- 
2.25.1

