Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B57DC2D0A7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA84A2073B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLHqe7tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgIEUEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 16:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgIEUEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:04:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763AC061244;
        Sat,  5 Sep 2020 13:04:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c142so6478360pfb.7;
        Sat, 05 Sep 2020 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfGuu3TfGSC0dAIWAeWJaFVq9ECT1JPqbW2AFayA+GQ=;
        b=fLHqe7tuHBg643XOnANJa3y5lkVRvNbD+ZY2APv6SzsGfka9WXly+hl1tM7/HJXDHM
         vwKBLD+qIlrUe9NpiHqak2zmWxwm56lOUAhAAdyheomlL04rTaC9VtT+AX+ZOgsMXfXU
         U3FLr6o0UstkeYhWw3mbMjl1BIa+yMYr+n15QV1Jp0X5KMyTb+MGiIIxek8E9CE+xG22
         uGutikItn5mkfK45NlYKVx4ugaGId8YRGL+Y4gI8jbuseRMG1y1GnkkB+QSX8/0Jn7Sj
         3+8TbeAVw1PfKbWAhoeED7c0mZ55O1CIgOptp+lte/nQpAy0fqjOsCYZu4AdSCk/znXi
         q5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfGuu3TfGSC0dAIWAeWJaFVq9ECT1JPqbW2AFayA+GQ=;
        b=ZHlJQWixpEpTGQ6WtPvbEeZIKJo6TE/NWWISrkUS9LzIWk8igAki5ICZvFpa56Ra5l
         CfLDMRlMOiYyCZT9+LNIczY+48sr7bs9pYQtqX7HQwN80+yiWO/WKC72TXjkMTG0lCR/
         dCSJAYZvoyvyHjOVhK7ZmdzLFcqj6IUm7yLw1U1igZ/kb80IZG54sAcCz1gcXGUWViF5
         jzvDLEYgVEMU+//dAe+PvsDi+1lPsIW9OBOYSNAF8mtW0pqcoOPTJBwj2vJWnGt+Qep8
         qPWv4y8zL97P0QjZ2SUnyT5CMxunyK9pcnCwTZv97C6cV0zDUefMphsZZ6i/s+15nc3O
         SBkA==
X-Gm-Message-State: AOAM530OFTgTtxxjTIILNqtddHc32aLuqdyqR+ygfV7LMpga1BXckNs5
        /ylxnu2xnbhQhmFqBjqK8is=
X-Google-Smtp-Source: ABdhPJw//aNsrYgjcLMECQ4CrSS0sTgYqpUFarDgcROXwMPHuT20MbxLWh8MpFOXkngMosoqQORaVw==
X-Received: by 2002:aa7:8645:0:b029:13c:de96:6fde with SMTP id a5-20020aa786450000b029013cde966fdemr11646572pfo.14.1599336269399;
        Sat, 05 Sep 2020 13:04:29 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id x19sm9954174pfm.28.2020.09.05.13.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 13:04:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v17 09/20] drm/msm: Add support for private address space instances
Date:   Sat,  5 Sep 2020 13:04:15 -0700
Message-Id: <20200905200454.240929-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

Add support for allocating private address space instances. Targets that
support per-context pagetables should implement their own function to
allocate private address spaces.

The default will return a pointer to the global address space.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/msm_drv.c     | 13 +++++++------
 drivers/gpu/drm/msm/msm_drv.h     |  5 +++++
 drivers/gpu/drm/msm/msm_gem_vma.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.c     | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h     |  5 +++++
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 75cd7639f560..7e963f707852 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -597,7 +597,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	kref_init(&ctx->ref);
 	msm_submitqueue_init(dev, ctx);
 
-	ctx->aspace = priv->gpu ? priv->gpu->aspace : NULL;
+	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu);
 	file->driver_priv = ctx;
 
 	return 0;
@@ -780,18 +780,19 @@ static int msm_ioctl_gem_cpu_fini(struct drm_device *dev, void *data,
 }
 
 static int msm_ioctl_gem_info_iova(struct drm_device *dev,
-		struct drm_gem_object *obj, uint64_t *iova)
+		struct drm_file *file, struct drm_gem_object *obj,
+		uint64_t *iova)
 {
-	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_file_private *ctx = file->driver_priv;
 
-	if (!priv->gpu)
+	if (!ctx->aspace)
 		return -EINVAL;
 
 	/*
 	 * Don't pin the memory here - just get an address so that userspace can
 	 * be productive
 	 */
-	return msm_gem_get_iova(obj, priv->gpu->aspace, iova);
+	return msm_gem_get_iova(obj, ctx->aspace, iova);
 }
 
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
@@ -830,7 +831,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		args->value = msm_gem_mmap_offset(obj);
 		break;
 	case MSM_INFO_GET_IOVA:
-		ret = msm_ioctl_gem_info_iova(dev, obj, &args->value);
+		ret = msm_ioctl_gem_info_iova(dev, file, obj, &args->value);
 		break;
 	case MSM_INFO_SET_NAME:
 		/* length check should leave room for terminating null: */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 4561bfb5e745..2ca9c3c03845 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -249,6 +249,10 @@ int msm_gem_map_vma(struct msm_gem_address_space *aspace,
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma);
 
+
+struct msm_gem_address_space *
+msm_gem_address_space_get(struct msm_gem_address_space *aspace);
+
 void msm_gem_address_space_put(struct msm_gem_address_space *aspace);
 
 struct msm_gem_address_space *
@@ -434,6 +438,7 @@ static inline void __msm_file_private_destroy(struct kref *kref)
 	struct msm_file_private *ctx = container_of(kref,
 		struct msm_file_private, ref);
 
+	msm_gem_address_space_put(ctx->aspace);
 	kfree(ctx);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 5f6a11211b64..29cc1305cf37 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -27,6 +27,15 @@ void msm_gem_address_space_put(struct msm_gem_address_space *aspace)
 		kref_put(&aspace->kref, msm_gem_address_space_destroy);
 }
 
+struct msm_gem_address_space *
+msm_gem_address_space_get(struct msm_gem_address_space *aspace)
+{
+	if (!IS_ERR_OR_NULL(aspace))
+		kref_get(&aspace->kref);
+
+	return aspace;
+}
+
 /* Actually unmap memory for the vma */
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 57532b6b4702..9f1bd17dfa47 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -823,6 +823,28 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
 	return 0;
 }
 
+/* Return a new address space for a msm_drm_private instance */
+struct msm_gem_address_space *
+msm_gpu_create_private_address_space(struct msm_gpu *gpu)
+{
+	struct msm_gem_address_space *aspace = NULL;
+
+	if (!gpu)
+		return NULL;
+
+	/*
+	 * If the target doesn't support private address spaces then return
+	 * the global one
+	 */
+	if (gpu->funcs->create_private_address_space)
+		aspace = gpu->funcs->create_private_address_space(gpu);
+
+	if (IS_ERR_OR_NULL(aspace))
+		aspace = msm_gem_address_space_get(gpu->aspace);
+
+	return aspace;
+}
+
 int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
 		const char *name, struct msm_gpu_config *config)
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 5cf696169f93..04a2f7539712 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -66,6 +66,8 @@ struct msm_gpu_funcs {
 	void (*gpu_set_freq)(struct msm_gpu *gpu, struct dev_pm_opp *opp);
 	struct msm_gem_address_space *(*create_address_space)
 		(struct msm_gpu *gpu, struct platform_device *pdev);
+	struct msm_gem_address_space *(*create_private_address_space)
+		(struct msm_gpu *gpu);
 };
 
 struct msm_gpu {
@@ -298,6 +300,9 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
 		const char *name, struct msm_gpu_config *config);
 
+struct msm_gem_address_space *
+msm_gpu_create_private_address_space(struct msm_gpu *gpu);
+
 void msm_gpu_cleanup(struct msm_gpu *gpu);
 
 struct msm_gpu *adreno_load_gpu(struct drm_device *dev);
-- 
2.26.2

