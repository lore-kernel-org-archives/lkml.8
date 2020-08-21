Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201BDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0320D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NK/EUI8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHUSzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:55:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33131 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgHUSye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598036074; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ZBEo8ZeEHfGtM2pRpX9PkSiYXraZn21iFGcK2Njnv+c=; b=NK/EUI8KAIKqC2P1MXm61AKwSJz4LLAvNKBejoXBZZNfaof2WjmOnCly49BYT6ZghE1UOkhC
 MNxGmcniGckJtdsXSBjBCKfv/97ySS7YZaoYEJDo/tFEfgUHTuX6Z2+eNhalx4wq3Uxj5Rag
 9BP4veqHteASiQP9bd+BFAi/Ba8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f401836c1ce10a051f4e151 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 18:53:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D035BC433A1; Fri, 21 Aug 2020 18:53:42 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F09FC433C6;
        Fri, 21 Aug 2020 18:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F09FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/msm: Split the a5xx preemption record
Date:   Fri, 21 Aug 2020 12:53:35 -0600
Message-Id: <20200821185336.2196780-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main a5xx preemption record can be marked as privileged to
protect it from user access but the counters storage needs to be
remain unprivileged. Split the buffers mark the critical memory
privileged.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 25 ++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index 54868d4e3958..1e5b1a15a70f 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -31,6 +31,7 @@ struct a5xx_gpu {
 	struct msm_ringbuffer *next_ring;
 
 	struct drm_gem_object *preempt_bo[MSM_GPU_MAX_RINGS];
+	struct drm_gem_object *preempt_counters_bo[MSM_GPU_MAX_RINGS];
 	struct a5xx_preempt_record *preempt[MSM_GPU_MAX_RINGS];
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
 
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 9cf9353a7ff1..9f3fe177b00e 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -226,19 +226,31 @@ static int preempt_init_ring(struct a5xx_gpu *a5xx_gpu,
 	struct adreno_gpu *adreno_gpu = &a5xx_gpu->base;
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a5xx_preempt_record *ptr;
-	struct drm_gem_object *bo = NULL;
-	u64 iova = 0;
+	void *counters;
+	struct drm_gem_object *bo = NULL, *counters_bo = NULL;
+	u64 iova = 0, counters_iova = 0;
 
 	ptr = msm_gem_kernel_new(gpu->dev,
 		A5XX_PREEMPT_RECORD_SIZE + A5XX_PREEMPT_COUNTER_SIZE,
-		MSM_BO_UNCACHED, gpu->aspace, &bo, &iova);
+		MSM_BO_UNCACHED | MSM_BO_MAP_PRIV, gpu->aspace, &bo, &iova);
 
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
 
+	/* The buffer to store counters needs to be unprivileged */
+	counters = msm_gem_kernel_new(gpu->dev,
+		A5XX_PREEMPT_COUNTER_SIZE,
+		MSM_BO_UNCACHED, gpu->aspace, &counters_bo, &counters_iova);
+	if (IS_ERR(counters)) {
+		msm_gem_kernel_put(bo, gpu->aspace, true);
+		return PTR_ERR(counters);
+	}
+
 	msm_gem_object_set_name(bo, "preempt");
+	msm_gem_object_set_name(counters_bo, "preempt_counters");
 
 	a5xx_gpu->preempt_bo[ring->id] = bo;
+	a5xx_gpu->preempt_counters_bo[ring->id] = counters_bo;
 	a5xx_gpu->preempt_iova[ring->id] = iova;
 	a5xx_gpu->preempt[ring->id] = ptr;
 
@@ -249,7 +261,7 @@ static int preempt_init_ring(struct a5xx_gpu *a5xx_gpu,
 	ptr->data = 0;
 	ptr->cntl = MSM_GPU_RB_CNTL_DEFAULT;
 	ptr->rptr_addr = rbmemptr(ring, rptr);
-	ptr->counter = iova + A5XX_PREEMPT_RECORD_SIZE;
+	ptr->counter = counters_iova;
 
 	return 0;
 }
@@ -260,8 +272,11 @@ void a5xx_preempt_fini(struct msm_gpu *gpu)
 	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
 	int i;
 
-	for (i = 0; i < gpu->nr_rings; i++)
+	for (i = 0; i < gpu->nr_rings; i++) {
 		msm_gem_kernel_put(a5xx_gpu->preempt_bo[i], gpu->aspace, true);
+		msm_gem_kernel_put(a5xx_gpu->preempt_counters_bo[i],
+			gpu->aspace, true);
+	}
 }
 
 void a5xx_preempt_init(struct msm_gpu *gpu)
-- 
2.25.1

