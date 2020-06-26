Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A20DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7B2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DxU162sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgFZUE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:04:56 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:41317 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgFZUEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:04:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593201890; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LdWbyAz364u7P6m0IEZru9FONBE/gZvu9Gt+jgjI10I=; b=DxU162sOZSIH+IdOurTUw+suZBI4Wb5Fk2TrkQfq6xrkvBepAnjxYXNSoh9vB1la3OdWByAp
 dXbNibXeBFeYVGAUKuZNWPKM3oTH84LsYkWaX91ZL5WF19Axjm82TgshxvDyA283o7JKKITO
 mNPAQIclJqbHXzSzRDzfQnwP0P0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5ef654d2bfb34e631c1a7c20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 20:04:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 78ECFC433C8; Fri, 26 Jun 2020 20:04:33 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96B86C433C6;
        Fri, 26 Jun 2020 20:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96B86C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        John Stultz <john.stultz@linaro.org>,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] drm/msm/a6xx: Add support for per-instance pagetables
Date:   Fri, 26 Jun 2020 14:04:14 -0600
Message-Id: <20200626200414.14382-7-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626200414.14382-1-jcrouse@codeaurora.org>
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using per-instance pagetables if all the dependencies are
available.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 43 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_ringbuffer.h  |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index aa53f47b7e8b..95ed2ceac121 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -79,6 +79,34 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 	OUT_RING(ring, upper_32_bits(iova));
 }
 
+static void a6xx_set_pagetable(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
+		struct msm_file_private *ctx)
+{
+	phys_addr_t ttbr;
+	u32 asid;
+
+	if (msm_iommu_pagetable_params(ctx->aspace->mmu, &ttbr, &asid))
+		return;
+
+	/* Execute the table update */
+	OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
+	/* CONTEXTIDR is currently unused */
+	OUT_RING(ring, 0);
+	/* CONTEXTBANK is currently unused */
+	OUT_RING(ring, 0);
+
+	/*
+	 * Write the new TTBR0 to the memstore. This is good for debugging.
+	 */
+	OUT_PKT7(ring, CP_MEM_WRITE, 4);
+	OUT_RING(ring, lower_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, upper_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
+}
+
 static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 	struct msm_file_private *ctx)
 {
@@ -89,6 +117,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i;
 
+	a6xx_set_pagetable(gpu, ring, ctx);
+
 	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
 		rbmemptr_stats(ring, index, cpcycles_start));
 
@@ -872,6 +902,18 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
 	return (unsigned long)busy_time;
 }
 
+struct msm_gem_address_space *a6xx_address_space_instance(struct msm_gpu *gpu)
+{
+	struct msm_mmu *mmu;
+
+	mmu = msm_iommu_pagetable_create(gpu->aspace->mmu);
+	if (IS_ERR(mmu))
+		return msm_gem_address_space_get(gpu->aspace);
+
+	return msm_gem_address_space_create(mmu,
+		"gpu", 0x100000000ULL, 0x1ffffffffULL);
+}
+
 static const struct adreno_gpu_funcs funcs = {
 	.base = {
 		.get_param = adreno_get_param,
@@ -895,6 +937,7 @@ static const struct adreno_gpu_funcs funcs = {
 		.gpu_state_put = a6xx_gpu_state_put,
 #endif
 		.create_address_space = adreno_iommu_create_address_space,
+		.address_space_instance = a6xx_address_space_instance,
 	},
 	.get_timestamp = a6xx_get_timestamp,
 };
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 7764373d0ed2..0987d6bf848c 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -31,6 +31,7 @@ struct msm_rbmemptrs {
 	volatile uint32_t fence;
 
 	volatile struct msm_gpu_submit_stats stats[MSM_GPU_SUBMIT_STATS_COUNT];
+	volatile u64 ttbr0;
 };
 
 struct msm_ringbuffer {
-- 
2.17.1

