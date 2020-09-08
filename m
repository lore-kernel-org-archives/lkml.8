Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BC8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A8E2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgIHDor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 23:44:47 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:59425 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgIHDop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:44:45 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 07 Sep 2020 20:44:44 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Sep 2020 20:44:43 -0700
Received: from c-mansur-linux.qualcomm.com ([10.204.90.208])
  by ironmsg01-blr.qualcomm.com with ESMTP; 08 Sep 2020 09:14:41 +0530
Received: by c-mansur-linux.qualcomm.com (Postfix, from userid 461723)
        id D348521D04; Tue,  8 Sep 2020 09:14:39 +0530 (IST)
From:   Mansur Alisha Shaik <mansur@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Subject: [PATCH 2/2] venus: core: vote for video-mem icc path and change avg, peak bw
Date:   Tue,  8 Sep 2020 09:14:38 +0530
Message-Id: <1599536678-4666-1-git-send-email-mansur@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are voting for venus0-ebi path during buffer processing
with an average bandwidth of all the instances and unvoting during
session release.

While video streaming when we try to do XO-SD using the command
"echo mem > /sys/power/state command" , device is not entering
to suspend state and from interconnect summary seeing votes for venus0-ebi

Corrected this by voting for venus0-ebi path in venus_runtime_resume
and unvote during venus_runtime_suspend.

Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
---
 drivers/media/platform/qcom/venus/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 4857bbd..79d8600 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -373,6 +373,10 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = icc_set_bw(core->video_path, 0, 0);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -382,7 +386,11 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
 	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	int ret;
 
-	ret = icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
+	ret = icc_set_bw(core->video_path, kbps_to_icc(20000), 0);
+	if (ret)
+		return ret;
+
+	ret = icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
 	if (ret)
 		return ret;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

