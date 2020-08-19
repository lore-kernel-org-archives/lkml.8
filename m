Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C2AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFE6205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838838;
	bh=x1jF4ONUI3WvdhnDAvjBBDqTSRAPdOHh78APakRS7W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eTsV31AaL0Rmv6etxvuqHxDOFdJe1wSME69ygOG+1n2NlC8JNl9yIulEJ4gH7hV/m
	 GWEMFYOihhE1Dek2lbe+Z4+5e+rmR65dS6eu2O5WbwEDCkorB1STsZQgy3TGet184s
	 N7kwgu4zOLZqoPuXrkn7IUAv2NTvMYj0mcx1BSsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHSMHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgHSLr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:26 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A1A22D08;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=x1jF4ONUI3WvdhnDAvjBBDqTSRAPdOHh78APakRS7W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIsx9hgRPqwUt4i61QKXWJfm8XMR7IbUOrgog+qwyT6heCONf4T4S5VsPuwZlt0AJ
         4Bmhg4+b1ubLcJLo2z8GeR4QDOMKNeY/dN86Kq2TndErlRdNM0w3xzv0ilI6OowPlA
         NI4rlLhsFV4cCIAjSHsXYq3HwiyO9bfWNLeugR+M=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00Eub7-EJ; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/49] staging: hikey9xx/gpu: place vblank enable/disable at the right place
Date:   Wed, 19 Aug 2020 13:45:55 +0200
Message-Id: <64118ff9b67f151e72518d6b32694727a18ce30c.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those methods belong to crtc fops

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/gpu/kirin9xx_drm_dss.c   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index e7907a0b511c..e1f2557a6be1 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -391,24 +391,26 @@ static void dss_power_down(struct dss_crtc *acrtc)
 	ctx->power_on = false;
 }
 
-static int dss_enable_vblank(struct drm_device *dev, unsigned int pipe)
+static int dss_enable_vblank(struct drm_crtc *crtc)
 {
-	struct kirin_drm_private *priv = dev->dev_private;
-	struct dss_crtc *acrtc = to_dss_crtc(priv->crtc[pipe]);
+	struct dss_crtc *acrtc = to_dss_crtc(crtc);
 	struct dss_hw_ctx *ctx = acrtc->ctx;
 
-	if (!ctx->power_on)
+	DRM_INFO("%s\n", __func__);
+	if (!ctx->power_on) {
+		DRM_INFO("Enabling vblank\n");
 		(void)dss_power_up(acrtc);
+	}
 
 	return 0;
 }
 
-static void dss_disable_vblank(struct drm_device *dev, unsigned int pipe)
+static void dss_disable_vblank(struct drm_crtc *crtc)
 {
-	struct kirin_drm_private *priv = dev->dev_private;
-	struct dss_crtc *acrtc = to_dss_crtc(priv->crtc[pipe]);
+	struct dss_crtc *acrtc = to_dss_crtc(crtc);
 	struct dss_hw_ctx *ctx = acrtc->ctx;
 
+	DRM_INFO("%s\n", __func__);
 	if (!ctx->power_on) {
 		DRM_ERROR("power is down! vblank disable fail\n");
 		return;
@@ -545,6 +547,8 @@ static const struct drm_crtc_funcs dss_crtc_funcs = {
 	.reset		= drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank = dss_enable_vblank,
+	.disable_vblank = dss_disable_vblank,
 };
 
 static int dss_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
@@ -928,9 +932,6 @@ static int dss_drm_init(struct drm_device *dev)
 
 	disable_irq(ctx->irq);
 
-	dev->driver->enable_vblank = dss_enable_vblank;
-	dev->driver->disable_vblank = dss_disable_vblank;
-
 	return 0;
 }
 
-- 
2.26.2

