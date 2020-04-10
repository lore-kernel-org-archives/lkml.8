Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B180C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE0C20692
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDJHRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:17:34 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:2025 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbgDJHRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:17:33 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Apr 2020 12:47:31 +0530
Received: from c-mansur-linux.qualcomm.com ([10.204.90.208])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 Apr 2020 12:47:29 +0530
Received: by c-mansur-linux.qualcomm.com (Postfix, from userid 461723)
        id D5F69218D0; Fri, 10 Apr 2020 12:47:27 +0530 (IST)
From:   Mansur Alisha Shaik <mansur@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, mansur@codeaurora.org
Subject: [PATCH V2] venus: core: remove CNOC voting while device suspend
Date:   Fri, 10 Apr 2020 12:47:25 +0530
Message-Id: <1586503045-18630-1-git-send-email-mansur@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Venus driver is voting Configuration NoC during .probe but not clear
voting in .suspend. Because of this NoC is up during shutdown also. As a
consequence the whole device could leak energy while in .suspend.

So correct this by moving voting in .resume and unvoting
in .suspend

signed-off-by: mansur alisha shaik <mansur@codeaurora.org>
---
Changes in V2:
- As per stanimir comment changed the commit message.

 drivers/media/platform/qcom/venus/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 194b10b9..13fa507 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -242,10 +242,6 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
-	if (ret)
-		return ret;
-
 	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		return ret;
@@ -350,6 +346,10 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = icc_set_bw(core->cpucfg_path, 0, 0);
+	if (ret)
+		return ret;
+
 	if (pm_ops->core_power)
 		ret = pm_ops->core_power(dev, POWER_OFF);
 
@@ -368,6 +368,10 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
 			return ret;
 	}
 
+	ret = icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
+	if (ret)
+		return ret;
+
 	return hfi_core_resume(core, false);
 }
 
-- 
2.7.4

