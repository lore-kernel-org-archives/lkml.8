Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E14EC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AE52072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WR/ehuHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBEUs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:48:26 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:50793 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbgBEUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:48:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580935705; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Jg+vVF4f4HRYjtHcmJnN46NBA8+b45y2XdVY1zbRPZQ=; b=WR/ehuHYd2HNABpOl4EE+behdyCV+AB9g3kCPM/eGYup5d09DPnar+cfdBncKYdv5se7pqcJ
 uapZHRHraq5hkRQPxQzqornIGTO4NJaldOt0GQu9Tg3zUUz5iCZdG5POliNAujzhnFzqfzZL
 xlHD1leJvNlomP3ksJHzZA5KeHU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3b2a18.7f4ebe1221b8-smtp-out-n02;
 Wed, 05 Feb 2020 20:48:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34F6EC447A0; Wed,  5 Feb 2020 20:48:24 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E66BC433CB;
        Wed,  5 Feb 2020 20:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E66BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2] drm/msm: Fix a6xx GMU shutdown sequence
Date:   Wed,  5 Feb 2020 13:48:17 -0700
Message-Id: <1580935697-28195-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e812744c5f95 ("drm: msm: a6xx: Add support for A618") missed
updating the VBIF flush in a6xx_gmu_shutdown and instead
inserted the new sequence into a6xx_pm_suspend along with a redundant
GMU idle.

Move a6xx_bus_clear_pending_transactions to a6xx_gmu.c and use it in
the appropriate place in the shutdown routine and remove the redundant
idle call.

v2: Remove newly unused variable that was triggering a warning

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 37 +++++++++++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 43 -----------------------------------
 2 files changed, 31 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 983afea..748cd37 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -796,12 +796,41 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
 	return true;
 }
 
+#define GBIF_CLIENT_HALT_MASK             BIT(0)
+#define GBIF_ARB_HALT_MASK                BIT(1)
+
+static void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu)
+{
+	struct msm_gpu *gpu = &adreno_gpu->base;
+
+	if (!a6xx_has_gbif(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
+		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
+								0xf) == 0xf);
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
+
+		return;
+	}
+
+	/* Halt new client requests on GBIF */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
+	spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
+			(GBIF_CLIENT_HALT_MASK)) == GBIF_CLIENT_HALT_MASK);
+
+	/* Halt all AXI requests on GBIF */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
+	spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
+			(GBIF_ARB_HALT_MASK)) == GBIF_ARB_HALT_MASK);
+
+	/* The GBIF halt needs to be explicitly cleared */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
+}
+
 /* Gracefully try to shut down the GMU and by extension the GPU */
 static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
-	struct msm_gpu *gpu = &adreno_gpu->base;
 	u32 val;
 
 	/*
@@ -819,11 +848,7 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 			return;
 		}
 
-		/* Clear the VBIF pipe before shutting down */
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
-		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) & 0xf)
-			== 0xf);
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
+		a6xx_bus_clear_pending_transactions(adreno_gpu);
 
 		/* tell the GMU we want to slumber */
 		a6xx_gmu_notify_slumber(gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index daf0780..b580e47 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -748,39 +748,6 @@ static const u32 a6xx_register_offsets[REG_ADRENO_REGISTER_MAX] = {
 	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_CNTL, REG_A6XX_CP_RB_CNTL),
 };
 
-#define GBIF_CLIENT_HALT_MASK             BIT(0)
-#define GBIF_ARB_HALT_MASK                BIT(1)
-
-static void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu)
-{
-	struct msm_gpu *gpu = &adreno_gpu->base;
-
-	if(!a6xx_has_gbif(adreno_gpu)){
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
-		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
-								0xf) == 0xf);
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
-
-		return;
-	}
-
-	/* Halt new client requests on GBIF */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
-	spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
-			(GBIF_CLIENT_HALT_MASK)) == GBIF_CLIENT_HALT_MASK);
-
-	/* Halt all AXI requests on GBIF */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
-	spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
-			(GBIF_ARB_HALT_MASK)) == GBIF_ARB_HALT_MASK);
-
-	/*
-	 * GMU needs DDR access in slumber path. Deassert GBIF halt now
-	 * to allow for GMU to access system memory.
-	 */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
-}
-
 static int a6xx_pm_resume(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -805,16 +772,6 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 
 	devfreq_suspend_device(gpu->devfreq.devfreq);
 
-	/*
-	 * Make sure the GMU is idle before continuing (because some transitions
-	 * may use VBIF
-	 */
-	a6xx_gmu_wait_for_idle(&a6xx_gpu->gmu);
-
-	/* Clear the VBIF pipe before shutting down */
-	/* FIXME: This accesses the GPU - do we need to make sure it is on? */
-	a6xx_bus_clear_pending_transactions(adreno_gpu);
-
 	return a6xx_gmu_stop(a6xx_gpu);
 }
 
-- 
2.7.4
