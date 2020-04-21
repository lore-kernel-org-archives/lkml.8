Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270CC55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7E720575
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="vy41DKo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDUXmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDUXmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:42:19 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5AC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 16:42:19 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so65899qvw.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rn5GB7Sv7pnmyprLYLd6lgRwcMO9YoyEu1xC0k/IR6I=;
        b=vy41DKo2NKG3DfIeTodwjZBvmUMWAn5OttqBaBPBCqer1hPEUMCJhuG+vZluctM6ZM
         gyEB50lR4G55ttfXv9hiGuYkGXuGr87Zz/JlDqOQVn4Cd6YcYv3OY0vqpsdZiE7/MWHA
         2Q1fAb4K4lgQLemnanq+w8560DTqPKQKYbp14vkbbRkc0/oezMvnvOnsKYwdb3RDd/h2
         XSMqZyvtJ8NMcAqs0NypkJikOEZP77vOQqFeKOB4cjIZQXGtzItyF2165ck6f4Kmfs9e
         hAGB0BCEiPHPlnHf2+hYc5dcqsMH4qUzdpKq8Jufc25fshk3kRj1Fx0CI13IDTzuZb0z
         RmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rn5GB7Sv7pnmyprLYLd6lgRwcMO9YoyEu1xC0k/IR6I=;
        b=SibHg1wY5Cx1VdgVZc/J3YDVaVgA5SzNEBZpsCD03Hky7Qf5L3bmVXtPB3bkdfxpgr
         lzs1ijPEvpLNslUxzoDrxO3bgOx1XiPTaWyrdcYDTrdmhqDS3rfE0YmTSszyJztp7r6p
         VN7OYl2YAtWlSrfsccwouTOe8wubYH7w5JTgil3QRSl6m36uAMCSCIaL08K/Xw3TrtMP
         gTc5LLJQlew2Q0VKYc5trYUUAlvtK7tCsyuITm7NC0rwpMWEwGmR0KCgbwSsUz4un9yB
         1b0NZlJV+eJiaxYF6+4v52xr+Sj+OQthKlazAw8mUS/rUq4U3x7sfwC5/pPIgSp8II2z
         0DIQ==
X-Gm-Message-State: AGi0PuYtoJcsPIOEo03uPLB4+D+74dW5ByzLYrRUmdr30lTGttU1SBfp
        TT8Nq4qxFAm1+acxEslrZKC9Yg==
X-Google-Smtp-Source: APiQypL88cq+jV5buT6b1XRyf84WWEC3KNwKm+2jGvEafA5gtLFP86YA+XjtVEPt7v6P6APpiboppw==
X-Received: by 2002:a05:6214:108a:: with SMTP id o10mr12103730qvr.213.1587512538751;
        Tue, 21 Apr 2020 16:42:18 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y17sm2664010qky.33.2020.04.21.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 16:42:18 -0700 (PDT)
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
Subject: [PATCH v2 8/9] drm/msm/a6xx: enable GMU log
Date:   Tue, 21 Apr 2020 19:41:26 -0400
Message-Id: <20200421234127.27965-9-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421234127.27965-1-jonathan@marek.ca>
References: <20200421234127.27965-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for a650 to work.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 15 +++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 60ed5360fd8a..f24e436daafe 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -201,6 +201,12 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
 	u32 val;
 
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
+
+	/* Set the log wptr index
+	 * note: downstream saves the value in poweroff and restores it here
+	 */
+	gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_PWR_COL_CP_RESP, 0);
+
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 0);
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_CM3_FW_INIT_RESULT, val,
@@ -740,6 +746,9 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 
 	gmu_write(gmu, REG_A6XX_GMU_HFI_SFR_ADDR, chipid);
 
+	gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_PWR_COL_CP_MSG,
+		  gmu->log.iova | (gmu->log.size / SZ_4K - 1));
+
 	/* Set up the lowest idle level on the GMU */
 	a6xx_gmu_power_config(gmu);
 
@@ -1046,6 +1055,7 @@ static void a6xx_gmu_memory_free(struct a6xx_gmu *gmu)
 	msm_gem_kernel_put(gmu->icache.obj, gmu->aspace, false);
 	msm_gem_kernel_put(gmu->dcache.obj, gmu->aspace, false);
 	msm_gem_kernel_put(gmu->dummy.obj, gmu->aspace, false);
+	msm_gem_kernel_put(gmu->log.obj, gmu->aspace, false);
 
 	gmu->aspace->mmu->funcs->detach(gmu->aspace->mmu);
 	msm_gem_address_space_put(gmu->aspace);
@@ -1450,6 +1460,11 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	if (ret)
 		goto err_memory;
 
+	/* Allocate memory for the GMU log region */
+	ret = a6xx_gmu_memory_alloc(gmu, &gmu->log, SZ_4K, 0);
+	if (ret)
+		goto err_memory;
+
 	/* Map the GMU registers */
 	gmu->mmio = a6xx_gmu_get_mmio(pdev, "gmu");
 	if (IS_ERR(gmu->mmio)) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index aed02b2b7659..be65720f32cf 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -61,6 +61,7 @@ struct a6xx_gmu {
 	struct a6xx_gmu_bo icache;
 	struct a6xx_gmu_bo dcache;
 	struct a6xx_gmu_bo dummy;
+	struct a6xx_gmu_bo log;
 
 	int nr_clocks;
 	struct clk_bulk_data *clocks;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
index b4357ea550ec..176ae94d9fe6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
@@ -205,6 +205,10 @@ static inline uint32_t A6XX_GMU_GPU_NAP_CTRL_SID(uint32_t val)
 
 #define REG_A6XX_GPU_GMU_CX_GMU_CX_FAL_INTF			0x000050f0
 
+#define REG_A6XX_GPU_GMU_CX_GMU_PWR_COL_CP_MSG			0x00005100
+
+#define REG_A6XX_GPU_GMU_CX_GMU_PWR_COL_CP_RESP			0x00005101
+
 #define REG_A6XX_GMU_BOOT_KMD_LM_HANDSHAKE			0x000051f0
 
 #define REG_A6XX_GMU_LLM_GLM_SLEEP_CTRL				0x00005157
-- 
2.26.1

