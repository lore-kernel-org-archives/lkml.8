Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4617C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877B9206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="P69O72Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbgAXMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:21:47 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:63548 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730673AbgAXMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 07:21:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579868506; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=F1LWU1oX1nibhhy7cGSDGcWE9ft9GXYa7Jl4DQRxQjA=; b=P69O72GqUE9oHn1SKpUJiA8JWqIyeA+Ot+4o5eOswMyKp+G23/HFS7ElkMH4IKsXzIKigezA
 fedVpZPFN99gvUV5wPaKu0hSyCmm0xYhZ+aONfavkEqBtcNPsd3vyQ5qVA3FE5RjTVySFBrh
 43sf19qohEXnFBh4WXhwvc8qcGo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2ae159.7fdff4753df8-smtp-out-n03;
 Fri, 24 Jan 2020 12:21:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18286C4479F; Fri, 24 Jan 2020 12:21:45 +0000 (UTC)
Received: from akhilpo-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DF1CC433CB;
        Fri, 24 Jan 2020 12:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DF1CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        smasetty@codeaurora.org
Subject: [PATCH] drm/msm/a6xx: Correct the highestbank configuration
Date:   Fri, 24 Jan 2020 17:50:11 +0530
Message-Id: <1579868411-20837-1-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Highest bank bit configuration is different for a618 gpu. Update
it with the correct configuration which is the reset value incidentally.

Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index daf0780..536d196 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -470,10 +470,12 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	/* Select CP0 to always count cycles */
 	gpu_write(gpu, REG_A6XX_CP_PERFCTR_CP_SEL_0, PERF_CP_ALWAYS_COUNT);
 
-	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL, 2 << 1);
-	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, 2 << 1);
-	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, 2 << 1);
-	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, 2 << 21);
+	if (adreno_is_a630(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL, 2 << 1);
+		gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, 2 << 1);
+		gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, 2 << 1);
+		gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, 2 << 21);
+	}
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL,
-- 
2.7.4
