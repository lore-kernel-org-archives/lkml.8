Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C532C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5502465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qftK8xRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgA1WQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:16:36 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:38823 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgA1WQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:16:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580249787; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=O/8M1MNl/g2Ft85CmdGvaBeu5AxW8ZxPF5UoiWwDXBc=; b=qftK8xRRU1vAM7P9RrgAqWnh63NcEUd2D+JJV7J72MSyjOD0H1RtqL4FBMALKJJWd7EDlRpS
 0qmE/WJyNmx2HstsJSMy/XEO7qOmEgp0twXIUmEQAFqEftZH/gWbmt6lcJ78cK2Khztr3AUL
 ZpcL08MuV5y2ftgHRoewOpmDpok=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30b2b7.7feee8ead1f0-smtp-out-n02;
 Tue, 28 Jan 2020 22:16:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01D08C433A2; Tue, 28 Jan 2020 22:16:22 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A33CC43383;
        Tue, 28 Jan 2020 22:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A33CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 4/6] drm/msm: Add support to create target specific address spaces
Date:   Tue, 28 Jan 2020 15:16:08 -0700
Message-Id: <1580249770-1088-5-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to create a GPU target specific address space for
a context. For those targets that support per-instance
pagetables they will return a new address space set up for
the instance if possible otherwise just use the global
device pagetable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_drv.c | 22 +++++++++++++++++++---
 drivers/gpu/drm/msm/msm_gpu.h |  2 ++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e4b750b..e485dc1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -585,6 +585,18 @@ static void load_gpu(struct drm_device *dev)
 	mutex_unlock(&init_lock);
 }
 
+static struct msm_gem_address_space *context_address_space(struct msm_gpu *gpu)
+{
+	if (!gpu)
+		return NULL;
+
+	if (gpu->funcs->create_instance_space)
+		return gpu->funcs->create_instance_space(gpu);
+
+	/* If all else fails use the default global space */
+	return gpu->aspace;
+}
+
 static int context_init(struct drm_device *dev, struct drm_file *file)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -596,7 +608,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 
 	msm_submitqueue_init(dev, ctx);
 
-	ctx->aspace = priv->gpu ? priv->gpu->aspace : NULL;
+	ctx->aspace = context_address_space(priv->gpu);
 	file->driver_priv = ctx;
 
 	return 0;
@@ -612,8 +624,12 @@ static int msm_open(struct drm_device *dev, struct drm_file *file)
 	return context_init(dev, file);
 }
 
-static void context_close(struct msm_file_private *ctx)
+static void context_close(struct msm_drm_private *priv,
+		struct msm_file_private *ctx)
 {
+	if (priv->gpu && ctx->aspace != priv->gpu->aspace)
+		msm_gem_address_space_put(ctx->aspace);
+
 	msm_submitqueue_close(ctx);
 	kfree(ctx);
 }
@@ -628,7 +644,7 @@ static void msm_postclose(struct drm_device *dev, struct drm_file *file)
 		priv->lastctx = NULL;
 	mutex_unlock(&dev->struct_mutex);
 
-	context_close(ctx);
+	context_close(priv, ctx);
 }
 
 static irqreturn_t msm_irq(int irq, void *arg)
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d496b68..76636da 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -64,6 +64,8 @@ struct msm_gpu_funcs {
 	void (*gpu_set_freq)(struct msm_gpu *gpu, unsigned long freq);
 	struct msm_gem_address_space *(*create_address_space)
 		(struct msm_gpu *gpu, struct platform_device *pdev);
+	struct msm_gem_address_space *(*create_instance_space)
+		(struct msm_gpu *gpu);
 };
 
 struct msm_gpu {
-- 
2.7.4
