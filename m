Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D08C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E312053B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="k2b3NgAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGADK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgGADK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:10:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18EBC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:10:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v19so17358770qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsG0/vZrFsbUfKMaszn0w2LlEErj8aBW/8Ir/pz3OGU=;
        b=k2b3NgAcITe6TyGQHN9BCCJhiQXvuAoeVzfKtvyoSmJgWi8jJF0AMFjlTCh3kwIv+X
         haarJdYqFvdWs3JzwZBovese0hmZb5eKO8olFoXh8krhzwPKD+22sHoW+zu2hHq6A9NA
         MqqElaJZeyXyqlV+mPCmIJrZIUwkj3WYL9YngExLzxBkl7s2k5aUT5/U2ONFWf+6Fgxz
         H6BSC0sjIx6bDb5Pj6Ud57QK3GH9iksxg0GSk9JyMOHZDAT69Yr6Y3XCYmpFM51CVwfA
         d3QmrhfH/PnJqSnM8PXxc+Q74T1PbSs8u2BiJlTg8wMRO+sUc6NcSkkymgP20aZ7b1JB
         v4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsG0/vZrFsbUfKMaszn0w2LlEErj8aBW/8Ir/pz3OGU=;
        b=SKiiLo4W9Xddgo31amhIXJEVnPFu3ftyRRdZwPPhaam2efBpprFy4KPZD8y+9cEBlx
         SXhyQtJitIAo0/PL1AQuV87BNc3nehnyhO2ik++1Cda1+6vxas2IJkPcSarafEI5xZMe
         I6mJmmIimll78zI96fh9LgFWSHPkCgE9W4TZvs7gEkOqGl/ExcdAmy1YzcW7naCDyDCC
         OqtpLi8Y/sAEW1mNgCT1vZusvvlDsrxEOs1HQhLceAemCd3LwBpaUAwEtrXAqEzjjghB
         MjKAhSGvbNzfZK8FfFxFB/wSoek6wlb3MpKvysnWI2+H5jqPfN6mEZs6btnxHrh0MFLP
         xuMw==
X-Gm-Message-State: AOAM532tTXFj+QnEMuxJR0cvacF4pgqh8PvH5DQX0cKST77du9c2Di9/
        a90uetD6DPdonK/qJue2NeTe2w==
X-Google-Smtp-Source: ABdhPJxC8b4XsFFiHjxlqHTC3hjSOcLyAEEBDq59JntLmlgh6Yq4M83KNcLLHHfgnTn8UXfVaA2mvw==
X-Received: by 2002:ac8:5048:: with SMTP id h8mr23325058qtm.81.1593573026817;
        Tue, 30 Jun 2020 20:10:26 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id r188sm4436866qkf.128.2020.06.30.20.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 20:10:26 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: handle for EPROBE_DEFER for of_icc_get
Date:   Tue, 30 Jun 2020 23:08:41 -0400
Message-Id: <20200701030842.24395-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for EPROBE_DEFER instead of silently not using icc if the msm driver
probes before the interconnect driver.

Only check for EPROBE_DEFER because of_icc_get can return other errors that
we want to ignore (ENODATA).

Remove the WARN_ON in msm_gpu_cleanup because INIT_LIST_HEAD won't have
been called on the list yet when going through the defer error path.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 17 ++++++++++++++---
 drivers/gpu/drm/msm/msm_gpu.c           |  2 --
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 89673c7ed473..393c00425d68 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -940,12 +940,20 @@ static int adreno_get_pwrlevels(struct device *dev,
 		 */
 		gpu->icc_path = of_icc_get(dev, NULL);
 	}
-	if (IS_ERR(gpu->icc_path))
+	if (IS_ERR(gpu->icc_path)) {
+		ret = PTR_ERR(gpu->icc_path);
 		gpu->icc_path = NULL;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+	}
 
 	gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
-	if (IS_ERR(gpu->ocmem_icc_path))
+	if (IS_ERR(gpu->ocmem_icc_path)) {
+		ret = PTR_ERR(gpu->ocmem_icc_path);
 		gpu->ocmem_icc_path = NULL;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+	}
 
 	return 0;
 }
@@ -996,6 +1004,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	struct adreno_platform_config *config = pdev->dev.platform_data;
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	int ret;
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
@@ -1007,7 +1016,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu_config.nr_rings = nr_rings;
 
-	adreno_get_pwrlevels(&pdev->dev, gpu);
+	ret = adreno_get_pwrlevels(&pdev->dev, gpu);
+	if (ret)
+		return ret;
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 		adreno_gpu->info->inactive_period);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index a22d30622306..ccf9a0dd9706 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -959,8 +959,6 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 
 	DBG("%s", gpu->name);
 
-	WARN_ON(!list_empty(&gpu->active_list));
-
 	for (i = 0; i < ARRAY_SIZE(gpu->rb); i++) {
 		msm_ringbuffer_destroy(gpu->rb[i]);
 		gpu->rb[i] = NULL;
-- 
2.26.1

