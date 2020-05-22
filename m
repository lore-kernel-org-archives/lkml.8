Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA91120738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="MtLePMPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgEVWaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgEVWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:30:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:30:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so6835590qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SSfZ9IdBClHLXK3pfg1yXkNX5wz/8jpNFyfhF/pEsw=;
        b=MtLePMPE37iKUqsdbm0WI0hZpMobQwNowF1YqzxZnkYGg8jCoFbmpzz0//yIRCnLGN
         w46JzPzlw6YLUbAFhFo3jYibwkOrEugtULj1tlH7wBQjj/NoLByH3rRDMOhpf4QCu2OC
         7vZXitKqyXM/mbgU713y0LHxjS4tP93m47sM+O6mfGxVs/2uyN9A2Ag1pVMtPZjy+lXY
         jJ/z2rxdpJI7w0vjRkHx03Qav8Pi1+S2eNs84TeqOaWV90KpnNUapsPnmu7bsV++CVgR
         bWGaiVyay3ePM2ReDShlAmJb6wnY5Og1MZXP0CKM0vAoYvJDIG5AYA7ZS7UfkSu/uhCf
         ppqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SSfZ9IdBClHLXK3pfg1yXkNX5wz/8jpNFyfhF/pEsw=;
        b=lQUt4+FnSu9RQSUxFETX2Bt1gBKQUHErBmcvlJesVxZj2KjIz/2RPef/73xO0zRdpU
         ElP1uFyaO0J/KbFidPBy9jmr+TKQBGP7EbxR+nfPT54ePr0q4cI0Vz18INbw+guQ+Wka
         FXTMJkXrQ9u85nU+PJ+jEkUk/UDsPEZYDhcfrA8lTheCh5WxPf2NtqY1aGbZkgSI2LUb
         8NLHUX+P6Q0OtmUbclQrbmtS9uAXTu+D7OnvQ3lUN8mIJr+HRroXgsDbplFTkRuZWzko
         QKAZ03hHvUN1gFLQWTfE1C6VKwAppMXum2htWgL9rSKk+NdJaBemTpKIswij32TN1imB
         gjRQ==
X-Gm-Message-State: AOAM531dCAtCl6vAABiY91TFon7JFOVhZBdVeHoVqXptQL89HULVwrVv
        /7h61q4PL28SAdsH5JLYbBiaNg==
X-Google-Smtp-Source: ABdhPJzAnLLFpegQtoCoMHFW91a6ZzaBMIso6a0e2wpumt9qbPxo0WGAnu7uCpmn8mWsPKd33gg68Q==
X-Received: by 2002:a37:b3c7:: with SMTP id c190mr16615709qkf.466.1590186644182;
        Fri, 22 May 2020 15:30:44 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id l184sm8416876qkf.84.2020.05.22.15.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 15:30:43 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedreno.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm/a6xx: skip HFI set freq if GMU is powered down
Date:   Fri, 22 May 2020 18:29:08 -0400
Message-Id: <20200522222909.27260-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200522221159.GA20960@jcrouse1-lnx.qualcomm.com>
References: <20200522221159.GA20960@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also skip the newly added HFI set freq path if the GMU is powered down,
which was missing because of patches crossing paths.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 67c58345b26a..9851367a88cd 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -110,13 +110,6 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	int ret;
 
-	/*
-	 * This can get called from devfreq while the hardware is idle. Don't
-	 * bring up the power if it isn't already active
-	 */
-	if (pm_runtime_get_if_in_use(gmu->dev) == 0)
-		return;
-
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
 
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_PERF_SETTING,
@@ -141,7 +134,6 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 	 * for now leave it at max so that the performance is nominal.
 	 */
 	icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
-	pm_runtime_put(gmu->dev);
 }
 
 void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
@@ -159,13 +151,21 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
 			break;
 
 	gmu->current_perf_index = perf_index;
+	gmu->freq = gmu->gpu_freqs[perf_index];
+
+	/*
+	 * This can get called from devfreq while the hardware is idle. Don't
+	 * bring up the power if it isn't already active
+	 */
+	if (pm_runtime_get_if_in_use(gmu->dev) == 0)
+		return;
 
 	if (gmu->legacy)
 		__a6xx_gmu_set_freq(gmu, perf_index);
 	else
 		a6xx_hfi_set_freq(gmu, perf_index);
 
-	gmu->freq = gmu->gpu_freqs[perf_index];
+	pm_runtime_put(gmu->dev);
 }
 
 unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu)
-- 
2.26.1

