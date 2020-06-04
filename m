Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26A3C433ED
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC3C207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Cw6DE8ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgFDINR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgFDIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:12:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6FC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:12:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x6so4997041wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPAnyNEtS0uY+bUuM8GxOFOVsLMIhBxwz7ItIj7lR3A=;
        b=Cw6DE8iprZ3uQg5gII/9i5sihculizd8rViFXjzCXSdVxul9CqWdFgOfY71gVkGiuV
         juGxO+Tm75A9A2e/W5n2HP7py+rVnr9u2LxOwSRBXRkhwJHpkeuFJDFWdS3KfjcSOmQG
         RdZmXaDOTVBzfxFPq9ypg/Dpc5CyQyRF0HX2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPAnyNEtS0uY+bUuM8GxOFOVsLMIhBxwz7ItIj7lR3A=;
        b=EHFCOMJ1cI+rShNhsXGK6c1zs66wPy3y49pdWcj8vEMm/YR2uRF4uFOaarayqKm5Q/
         08zkl/doJQb3cdG60Va2hfjdWlnHWehZWKDqIxfc6PbvzbjkkQDvxd0MoyEjfXHb/Xcm
         wyzmMii6s+f13QCRLSaKKEOyWq8UGwQqrPZgR/ADDUBaCtcps+5OdAOprKCQqBOZb1TJ
         3Uu8RowKRoqHnf4wyIb7DO3f4GCE4uVB30+Erg4HJRjjRHXUv/+YNCBJNMIMKnJ8kIZL
         JdULPD0WNLysw2rqEDdL/mL0U5bavkH4keJ7KZeuycKS9cP4JarvHW/BtpqGEMgDTLQp
         JWXQ==
X-Gm-Message-State: AOAM530btn29YLCbOTsev93fcoajA2/3BvoHDf9glKf9/TFCnN5F9k7I
        AWHIR3lVxlrHzzOUGHHZaQ3UoQ==
X-Google-Smtp-Source: ABdhPJzqUtEw7Ja3sjtBGx+terae6/AGLT+5Iphc3r7rUYdY/P0UYh8UASXP+HWl66kBwvknWv+Dcg==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr3458296wru.118.1591258371351;
        Thu, 04 Jun 2020 01:12:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:50 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 15/18] drm/amdgpu: use dma-fence annotations for gpu reset code
Date:   Thu,  4 Jun 2020 10:12:21 +0200
Message-Id: <20200604081224.863494-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve coverage also annotate the gpu reset code itself, since
that's called from other places than drm/scheduler (which is already
annotated). Annotations nests, so this doesn't break anything, and
allows easier testing.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a027a8f7b281..ac0286a5f2fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4215,6 +4215,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
 		true : false;
 	bool audio_suspended = false;
+	bool fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	/*
 	 * Flush RAM to disk so that after reboot
@@ -4243,6 +4246,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 			  job ? job->base.id : -1, hive->hive_id);
 		mutex_unlock(&hive->hive_lock);
+		dma_fence_end_signalling(fence_cookie);
 		return 0;
 	}
 
@@ -4253,8 +4257,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	INIT_LIST_HEAD(&device_list);
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		if (!hive)
+		if (!hive) {
+			dma_fence_end_signalling(fence_cookie);
 			return -ENODEV;
+		}
 		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
 			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
 		device_list_handle = &hive->device_list;
@@ -4269,6 +4275,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
 			mutex_unlock(&hive->hive_lock);
+			dma_fence_end_signalling(fence_cookie);
 			return 0;
 		}
 
@@ -4409,6 +4416,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	if (r)
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
+	dma_fence_end_signalling(fence_cookie);
 	return r;
 }
 
-- 
2.26.2

