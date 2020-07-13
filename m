Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3DCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8972145D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="WN/6PrrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGMWze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgGMWzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:55:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F28C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:18 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g13so11393940qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EA0KSfJQZURE1Ys7r5juFF1n2voOYvfmlWuF3uQoZcA=;
        b=WN/6PrrOkWgHD/XkJ5d3RKiuXPkFohDHVNhXaqywQCjxFgAxXzqAz3YHBa4WVenQxz
         7CEsgit0imPuLaZz/emY//2xNpq9Ww/x7OsjtgB9QtbNWADhkK4PnRjR+nRs2bO4V7S5
         CeRfShIwxdOdjQI67lIInRRdshpVVggaji6wq/9YmctPDpxILvPXmD0dorUu/Z/1l5cC
         uk1ggkMYjrk+2KAaRREg1h83WpQS8w34M0TUMN3grVBrOfWP93s8/TxQjM2/CRNEeDW4
         LEYvsWSaYVKIJxGplhvGYZVSGwp19IMAqY16wplr87kTwzzpZkdWIQeWYysqtvaQi0IW
         dgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EA0KSfJQZURE1Ys7r5juFF1n2voOYvfmlWuF3uQoZcA=;
        b=BkIJqPjXvR36yV6KU6p+ZXIYx1aAzBH7ZrRy6MmtlXKC74TlQJQar5wv9bp2bFTGKK
         gxAOl9a3tb9PyU9BAA2bUsO5LKoagFo0w7l8O1WROg33gT3jUnbMGEHg+5tp/bml4xPn
         1Z+GBK/98B7W6o+/T2x40QoiEFqCIqVi0j5kDIWkEgPi13QxYvzEu7j+gdVdHFufgcaR
         e1fNZA0mguKp8VrxGZQoPlGiyuL8LlDECrMLrqfN77fvbkj8d8lGzliijdCCON+38ng8
         y6xqe2fX1wcHmyNY0OWkaIbUIOxEsWASTTzc1dwzwuFKk7g6pXCqFXCUqIw/WHx+Oq4H
         aJcg==
X-Gm-Message-State: AOAM532wrg6/7YVkggepk6l4F+aNf3wc4ketyqFMSV8mBrk14faEf8vi
        PEcZ9CTNebNuWrZ5KlXHcg2i4g==
X-Google-Smtp-Source: ABdhPJw9KFSKbMVJuPkDYHaYXsj7EXYMpGbgA1qHNqzp47A1TUguSaTAwGSsZIFfX4bPWqtG6t71NQ==
X-Received: by 2002:ac8:4e8d:: with SMTP id 13mr1711583qtp.339.1594680917905;
        Mon, 13 Jul 2020 15:55:17 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id f54sm22405752qte.76.2020.07.13.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:55:17 -0700 (PDT)
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
Subject: [PATCH v4 3/3] drm/msm: handle for EPROBE_DEFER for of_icc_get
Date:   Mon, 13 Jul 2020 18:53:42 -0400
Message-Id: <20200713225345.20556-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713225345.20556-1-jonathan@marek.ca>
References: <20200713225345.20556-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for errors instead of silently not using icc if the msm driver
probes before the interconnect driver.

Allow ENODATA for ocmem path, as it is optional and this error
is returned when "gfx-mem" path is provided but not "ocmem".

Because msm_gpu_cleanup assumes msm_gpu_init has been called, the icc path
init needs to be after msm_gpu_init for the error path to work.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 65 +++++++++++++++----------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index ad64d4b7e8d7..3f1ecc1de965 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -895,7 +895,7 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
 	return 0;
 }
 
-static int adreno_get_pwrlevels(struct device *dev,
+static void adreno_get_pwrlevels(struct device *dev,
 		struct msm_gpu *gpu)
 {
 	unsigned long freq = ULONG_MAX;
@@ -930,24 +930,6 @@ static int adreno_get_pwrlevels(struct device *dev,
 	}
 
 	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
-
-	/* Check for an interconnect path for the bus */
-	gpu->icc_path = of_icc_get(dev, "gfx-mem");
-	if (!gpu->icc_path) {
-		/*
-		 * Keep compatbility with device trees that don't have an
-		 * interconnect-names property.
-		 */
-		gpu->icc_path = of_icc_get(dev, NULL);
-	}
-	if (IS_ERR(gpu->icc_path))
-		gpu->icc_path = NULL;
-
-	gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
-	if (IS_ERR(gpu->ocmem_icc_path))
-		gpu->ocmem_icc_path = NULL;
-
-	return 0;
 }
 
 int adreno_gpu_ocmem_init(struct device *dev, struct adreno_gpu *adreno_gpu,
@@ -993,9 +975,11 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct adreno_gpu *adreno_gpu,
 		const struct adreno_gpu_funcs *funcs, int nr_rings)
 {
-	struct adreno_platform_config *config = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct adreno_platform_config *config = dev->platform_data;
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	int ret;
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
@@ -1007,15 +991,42 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu_config.nr_rings = nr_rings;
 
-	adreno_get_pwrlevels(&pdev->dev, gpu);
+	adreno_get_pwrlevels(dev, gpu);
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev,
+	pm_runtime_set_autosuspend_delay(dev,
 		adreno_gpu->info->inactive_period);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
 
-	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
+	ret = msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			adreno_gpu->info->name, &adreno_gpu_config);
+	if (ret)
+		return ret;
+
+	/* Check for an interconnect path for the bus */
+	gpu->icc_path = of_icc_get(dev, "gfx-mem");
+	if (!gpu->icc_path) {
+		/*
+		 * Keep compatbility with device trees that don't have an
+		 * interconnect-names property.
+		 */
+		gpu->icc_path = of_icc_get(dev, NULL);
+	}
+	if (IS_ERR(gpu->icc_path)) {
+		ret = PTR_ERR(gpu->icc_path);
+		gpu->icc_path = NULL;
+		return ret;
+	}
+
+	gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
+	if (IS_ERR(gpu->ocmem_icc_path)) {
+		ret = PTR_ERR(gpu->ocmem_icc_path);
+		gpu->ocmem_icc_path = NULL;
+		/* allow -ENODATA, ocmem icc is optional */
+		if (ret != -ENODATA)
+			return ret;
+	}
+	return 0;
 }
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
@@ -1029,8 +1040,8 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 
 	pm_runtime_disable(&priv->gpu_pdev->dev);
 
+	msm_gpu_cleanup(&adreno_gpu->base);
+
 	icc_put(gpu->icc_path);
 	icc_put(gpu->ocmem_icc_path);
-
-	msm_gpu_cleanup(&adreno_gpu->base);
 }
-- 
2.26.1

