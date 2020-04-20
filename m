Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2C1C54FD2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3851A20722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="VbG3Okuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgDTODr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729218AbgDTODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:03:45 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7576C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:03:45 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id bu9so4658785qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AL7hXb8H/qoBJbDBZohhbHzSXTKh5iAM3hIyFPRwuxM=;
        b=VbG3OkuzryiADo+SuBJMbjRhDLggqq8Z1nhcUstkpW0HmJY80ivSzoVD2bIoL6+c7I
         Uuz2QniB7Z5CqT94K3NPuYYbVgEk167cNocTu/UlsjOALbqUng7Q1NVdJibuQAanmatL
         DduIC6hLlqo28IdSPd0YwUcYBhPtHmyeb29iL7yLS77UHGjIR2tuLHes5h98hsDaEwQS
         /oKP9LDWnrAJD5oEEpwSKM6ofmER19wQeJE8eZQ42tTaJJFNsy4QFfd4A0MmR+8EvgXc
         1y9+4KleZ3lbmFCkeUINytrZV/azWgy2U9PJ4oZlHOt3Yae9ET3/FjlGOZJty3tL+svC
         NeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AL7hXb8H/qoBJbDBZohhbHzSXTKh5iAM3hIyFPRwuxM=;
        b=Eyo3PhZFEgoLqinc2Twc2rM9TkVuFKroAAakymQptJ90MKBNqAt/ILFVKdpAXAGW0X
         3iPMM0IewXxRrPyx5ar3869wERPdTaAae585naD4IXt10U2doI/5lR+9DGl1jCrkZ24q
         YEEsPer035CBOzX/HKMNKuP3Ungmu4qXvvwBSMZFKSd/z+X/c/oot3VyJuu8ZFJL+qvT
         lHyShblL1LJFD3rJGflBu4JbAVrMuLxG/ppqMA22uHDoCeopBoM6Js3QJk4f/0echkaC
         iyveQPctzz0qp0OLAEd9AfXt1aKedYJEdYKza5cXyzF3g5hxdRcD/eU+Nyoem4NTOayd
         CYGg==
X-Gm-Message-State: AGi0Puah7rZHWXt1U2FlG/5jmnCsJ2/CqULPjXqBj9QGE6lsWmwAhaEK
        jmJkcLTO+ZolOSw2vpDPof/8XA==
X-Google-Smtp-Source: APiQypJbBE+wFH9zAewo04smsE28aAKfYYfnbIhgn83376FC45tY9AalDkIrTnMLrKQ/dym8U3JM0Q==
X-Received: by 2002:a0c:f38d:: with SMTP id i13mr15276070qvk.187.1587391423430;
        Mon, 20 Apr 2020 07:03:43 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id t75sm609424qke.127.2020.04.20.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 07:03:42 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/9] drm/msm/a6xx: allow allocating GMU memory with a fixed address
Date:   Mon, 20 Apr 2020 10:03:07 -0400
Message-Id: <20200420140313.7263-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420140313.7263-1-jonathan@marek.ca>
References: <20200420140313.7263-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 748cd379065f..c6ecb3189ec5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -938,8 +938,8 @@ static void a6xx_gmu_memory_free(struct a6xx_gmu *gmu, struct a6xx_gmu_bo *bo)
 	kfree(bo);
 }
 
-static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
-		size_t size)
+static struct a6xx_gmu_bo *
+a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu, size_t size, uint64_t iova)
 {
 	struct a6xx_gmu_bo *bo;
 	int ret, count, i;
@@ -964,13 +964,13 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
 			goto err;
 	}
 
-	bo->iova = gmu->uncached_iova_base;
+	bo->iova = iova ?: gmu->uncached_iova_base;
 
 	for (i = 0; i < count; i++) {
 		ret = iommu_map(gmu->domain,
 			bo->iova + (PAGE_SIZE * i),
 			page_to_phys(bo->pages[i]), PAGE_SIZE,
-			IOMMU_READ | IOMMU_WRITE);
+			IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV);
 
 		if (ret) {
 			DRM_DEV_ERROR(gmu->dev, "Unable to map GMU buffer object\n");
@@ -990,7 +990,8 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
 		goto err;
 
 	/* Align future IOVA addresses on 1MB boundaries */
-	gmu->uncached_iova_base += ALIGN(size, SZ_1M);
+	if (!iova)
+		gmu->uncached_iova_base += ALIGN(size, SZ_1M);
 
 	return bo;
 
@@ -1331,12 +1332,12 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_put_device;
 
 	/* Allocate memory for for the HFI queues */
-	gmu->hfi = a6xx_gmu_memory_alloc(gmu, SZ_16K);
+	gmu->hfi = a6xx_gmu_memory_alloc(gmu, SZ_16K, 0);
 	if (IS_ERR(gmu->hfi))
 		goto err_memory;
 
 	/* Allocate memory for the GMU debug region */
-	gmu->debug = a6xx_gmu_memory_alloc(gmu, SZ_16K);
+	gmu->debug = a6xx_gmu_memory_alloc(gmu, SZ_16K, 0);
 	if (IS_ERR(gmu->debug))
 		goto err_memory;
 
-- 
2.26.1

