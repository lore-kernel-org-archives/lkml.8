Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF53BC3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97078246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aEquvtIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgCBIre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:47:34 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:21353 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbgCBIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:47:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583138853; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=wmVI700tbQq6+iaWrtHBd6KzHd/LvL94inrgBbMCajQ=; b=aEquvtIabK/tsD20675Xgj2Gqwqz/QgwbgZX7ak7FxeNNGjrF6GTI8Y8Ba2S9wyilwNrZ9fL
 eYrEFrZ33eqvhFoqgsOdwB863ud8HiVuw1aWjJ9BUJ6PYxcRD7UFT8tB8ueh1L8u/f1i1xUf
 YqDJbT7mqd16W//ARZ+s598ttK0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5cc824.7f6d358dbb20-smtp-out-n03;
 Mon, 02 Mar 2020 08:47:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD535C433A2; Mon,  2 Mar 2020 08:47:31 +0000 (UTC)
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1A02C43383;
        Mon,  2 Mar 2020 08:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1A02C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH] drm: msm: a6x: Disable interrupts before recovery
Date:   Mon,  2 Mar 2020 14:17:16 +0530
Message-Id: <1583138836-20807-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disables interrupts in the GPU RBBM hang detect fault handler
before going to recovery.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index dc8ec2c..4dd0f62 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -676,6 +676,9 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
 		gpu_read64(gpu, REG_A6XX_CP_IB2_BASE, REG_A6XX_CP_IB2_BASE_HI),
 		gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE));
 
+	/* Disable interrupts before going for a recovery*/
+	gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, 0);
+
 	/* Turn off the hangcheck timer to keep it from bothering us */
 	del_timer(&gpu->hangcheck_timer);
 
-- 
1.9.1
