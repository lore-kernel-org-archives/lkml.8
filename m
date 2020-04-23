Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF59C55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083BD20776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="D6sJpwFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDWVKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:10:23 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59911C09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:23 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b1so2532895qtt.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXxHc8zF6zr0b8trV04SdIxBHpU7GIEyXW6bHvBYNVc=;
        b=D6sJpwFAYpHqd8PX/6y6/o7HkP8BiVYz9g/6ZRNHeScbDO2X+ywWzs/Hh4MV4pMma1
         bByQHuY4co2thVRAfx4jXyszN+NFiB0ctbaoubyqDE57eev06LFSVnyb+f9UgFO+Oraj
         D/3dMZqDflqckiBbUjNH02GnYywhLb1aHGUWyF+al+WJBoOfHTXKkvk15pDBUEGILTHq
         llXteQNpBZ1FR5jq+W+Hu0rqXYGLjapgqyfzaV3cdCji4Z0MJysMmMLicooCRa6DM8Xc
         Y1uIftDzgv6jOQyBvbEwIJg5WuEyq3nhJ1bJpHbi8o/UhM/J/4uch3H0pdiB1OQc4xUy
         UytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXxHc8zF6zr0b8trV04SdIxBHpU7GIEyXW6bHvBYNVc=;
        b=CKQl5RoDFYbLSMCJrk5LoxXugiPG1SzUiaxVaI5q8uHDgOOcwWeCxwCxgwkkrNuzVD
         zPPxUkUUgkx4tpnZGcds5ZwDm/NNc41F1NEi9SYRZq1B/CY8mwK/6v8nV744+2/ttd+B
         +dMTxNW7Tmyqug+Bxv1/DziJ5iyX5iW5uz+K28JXUDwdq28eomu1SwE0wVgCLCXr878G
         lsVKlFJ6IrnqiUREXx39MxYbpR8rFkiS3IUq5nIcl+Glwrkq1UsB2AIQfrZQEAoOtMSF
         5QdYWpjuk7nWtKZL+tJBbv2tcviJ5TbKHhmmd/GhbekKL5jdhKdbZMvzT7qp+1Okpc0l
         Zc1Q==
X-Gm-Message-State: AGi0PuYlF/VobUJbGPrKyvsgtbj3cFnd72d5lUKYcoHLztU9e7wzopXz
        vxo4N8e9ZvYy1hW5NlgbbCIV5Q==
X-Google-Smtp-Source: APiQypJUMIE6mZ6Ebfbx5vwe0xfAMnDqVAb1YAzOvzRoxWOeD2wdwRP7QlMArdBeduHde/lqgHw75w==
X-Received: by 2002:ac8:7552:: with SMTP id b18mr5826642qtr.312.1587676222586;
        Thu, 23 Apr 2020 14:10:22 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id n4sm2341495qkh.38.2020.04.23.14.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:10:22 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/9] drm/msm: add msm_gem_get_and_pin_iova_range
Date:   Thu, 23 Apr 2020 17:09:13 -0400
Message-Id: <20200423210946.28867-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423210946.28867-1-jonathan@marek.ca>
References: <20200423210946.28867-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function allows pinning iova to a specific page range (for a6xx GMU).

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_drv.h     |  6 +++++-
 drivers/gpu/drm/msm/msm_gem.c     | 28 +++++++++++++++++++++-------
 drivers/gpu/drm/msm/msm_gem_vma.c |  6 ++++--
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 194d900a460e..966fd9068c94 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -236,7 +236,8 @@ int msm_crtc_enable_vblank(struct drm_crtc *crtc);
 void msm_crtc_disable_vblank(struct drm_crtc *crtc);
 
 int msm_gem_init_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int npages);
+		struct msm_gem_vma *vma, int npages,
+		u64 range_start, u64 range_end);
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma);
 void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
@@ -276,6 +277,9 @@ vm_fault_t msm_gem_fault(struct vm_fault *vmf);
 uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj);
 int msm_gem_get_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
+int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
+		struct msm_gem_address_space *aspace, uint64_t *iova,
+		u64 range_start, u64 range_end);
 int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
 uint64_t msm_gem_iova(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 5a6a79fbc9d6..d8f56a34c117 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -389,7 +389,8 @@ put_iova(struct drm_gem_object *obj)
 }
 
 static int msm_gem_get_iova_locked(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace, uint64_t *iova)
+		struct msm_gem_address_space *aspace, uint64_t *iova,
+		u64 range_start, u64 range_end)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma;
@@ -404,7 +405,8 @@ static int msm_gem_get_iova_locked(struct drm_gem_object *obj,
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);
 
-		ret = msm_gem_init_vma(aspace, vma, obj->size >> PAGE_SHIFT);
+		ret = msm_gem_init_vma(aspace, vma, obj->size >> PAGE_SHIFT,
+			range_start, range_end);
 		if (ret) {
 			del_vma(vma);
 			return ret;
@@ -443,9 +445,13 @@ static int msm_gem_pin_iova(struct drm_gem_object *obj,
 			msm_obj->sgt, obj->size >> PAGE_SHIFT);
 }
 
-/* get iova and pin it. Should have a matching put */
-int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace, uint64_t *iova)
+/*
+ * get iova and pin it. Should have a matching put
+ * limits iova to specified range (in pages)
+ */
+int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
+		struct msm_gem_address_space *aspace, uint64_t *iova,
+		u64 range_start, u64 range_end)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	u64 local;
@@ -453,7 +459,8 @@ int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 
 	mutex_lock(&msm_obj->lock);
 
-	ret = msm_gem_get_iova_locked(obj, aspace, &local);
+	ret = msm_gem_get_iova_locked(obj, aspace, &local,
+		range_start, range_end);
 
 	if (!ret)
 		ret = msm_gem_pin_iova(obj, aspace);
@@ -465,6 +472,13 @@ int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 	return ret;
 }
 
+/* get iova and pin it. Should have a matching put */
+int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
+		struct msm_gem_address_space *aspace, uint64_t *iova)
+{
+	return msm_gem_get_and_pin_iova_range(obj, aspace, iova, 0, U64_MAX);
+}
+
 /*
  * Get an iova but don't pin it. Doesn't need a put because iovas are currently
  * valid for the life of the object
@@ -476,7 +490,7 @@ int msm_gem_get_iova(struct drm_gem_object *obj,
 	int ret;
 
 	mutex_lock(&msm_obj->lock);
-	ret = msm_gem_get_iova_locked(obj, aspace, iova);
+	ret = msm_gem_get_iova_locked(obj, aspace, iova, 0, U64_MAX);
 	mutex_unlock(&msm_obj->lock);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1af5354bcd46..407b7ab82818 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -103,7 +103,8 @@ void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 
 /* Initialize a new vma and allocate an iova for it */
 int msm_gem_init_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int npages)
+		struct msm_gem_vma *vma, int npages,
+		u64 range_start, u64 range_end)
 {
 	int ret;
 
@@ -111,7 +112,8 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 		return -EBUSY;
 
 	spin_lock(&aspace->lock);
-	ret = drm_mm_insert_node(&aspace->mm, &vma->node, npages);
+	ret = drm_mm_insert_node_in_range(&aspace->mm, &vma->node, npages, 0,
+		0, range_start, range_end, 0);
 	spin_unlock(&aspace->lock);
 
 	if (ret)
-- 
2.26.1

