Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5C4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D919122203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MI3lnda/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgGNN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:26:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58262 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgGNN0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:26:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594733190; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ZuuVvtXOSn5P69Z0eecIOVwDd77Y6Cz0UPcGzE05C34=; b=MI3lnda/Y9Y12wRUZDd+/vRTr4uho7fDLHMNAYdb6IHy28N/Lfb/pjiIB1ZAzOIfWFhJdemh
 keyLAR6YrSjNuRd2JhkH1YnSw1VUbzkJHLSv0GLVKe3Jv0AAc3cQmI+8J2wtZje+JoFIOB0N
 i4UQ+FVULLfDxjs8L9apZyN0at4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f0db2551e603dbb44145967 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 13:25:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6ABBDC43391; Tue, 14 Jul 2020 13:25:40 +0000 (UTC)
Received: from akhilpo-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDDF8C433CA;
        Tue, 14 Jul 2020 13:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDDF8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org, jonathan@marek.ca,
        robdclark@gmail.com, rnayak@codeaurora.org
Subject: [PATCH] drm: msm: a6xx: fix gpu failure after system resume
Date:   Tue, 14 Jul 2020 18:55:30 +0530
Message-Id: <1594733130-398-1-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On targets where GMU is available, GMU takes over the ownership of GX GDSC
during its initialization. So, take a refcount on the GX PD on behalf of
GMU before we initialize it. This makes sure that nobody can collapse the
GX GDSC once GMU owns the GX GDSC. This patch fixes some weird failures
during GPU wake up during system resume.

Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index a6f43ff..5b2df7d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -873,10 +873,19 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Turn on the resources */
 	pm_runtime_get_sync(gmu->dev);
 
+	/*
+	 * "enable" the GX power domain which won't actually do anything but it
+	 * will make sure that the refcounting is correct in case we need to
+	 * bring down the GX after a GMU failure
+	 */
+	if (!IS_ERR_OR_NULL(gmu->gxpd))
+		pm_runtime_get_sync(gmu->gxpd);
+
 	/* Use a known rate to bring up the GMU */
 	clk_set_rate(gmu->core_clk, 200000000);
 	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
 	if (ret) {
+		pm_runtime_put(gmu->gxpd);
 		pm_runtime_put(gmu->dev);
 		return ret;
 	}
@@ -919,19 +928,12 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Set the GPU to the current freq */
 	a6xx_gmu_set_initial_freq(gpu, gmu);
 
-	/*
-	 * "enable" the GX power domain which won't actually do anything but it
-	 * will make sure that the refcounting is correct in case we need to
-	 * bring down the GX after a GMU failure
-	 */
-	if (!IS_ERR_OR_NULL(gmu->gxpd))
-		pm_runtime_get(gmu->gxpd);
-
 out:
 	/* On failure, shut down the GMU to leave it in a good state */
 	if (ret) {
 		disable_irq(gmu->gmu_irq);
 		a6xx_rpmh_stop(gmu);
+		pm_runtime_put(gmu->gxpd);
 		pm_runtime_put(gmu->dev);
 	}
 
-- 
2.7.4

