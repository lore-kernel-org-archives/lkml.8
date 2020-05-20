Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9414120708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mZFB9Xkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgETAbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:31:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45534 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728468AbgETAbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:31:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589934673; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4dZM/JYeoA487Rk8Sj4yrYwS43HKgRGST+5m/uOSDi0=; b=mZFB9XkzZhqiBZbGCoICfEiwRf/OfM+jOGZ8hKECNHGU1W7dWrMp6G+FJuHKFFVRBU4GxeN/
 yGvSxgxpHPSvJDTg//HO9JqTIUqHG5PS4t7KcSjEJ8xZpqnCjb3njQeB8//xm4Awyr4dMEcx
 X8ye6TIjmjt+YRFaRWuFGtH7PN8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec47a2f.7f1e2800a110-smtp-out-n04;
 Wed, 20 May 2020 00:30:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8DACC433CB; Wed, 20 May 2020 00:30:39 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1966C433CA;
        Wed, 20 May 2020 00:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1966C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 1/6] bus: mhi: core: Improve shutdown handling after link down detection
Date:   Tue, 19 May 2020 17:30:26 -0700
Message-Id: <1589934631-22752-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589934631-22752-1-git-send-email-bbhatt@codeaurora.org>
References: <1589934631-22752-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MHI were to attempt a device shutdown following an assumption
that the device is inaccessible, the host currently moves to a state
where device register accesses are allowed when they should not be.
This would end up allowing accesses to device register space when the
link is inaccessible which can result in NOC errors to be observed on
the host. Improve shutdown handling so as to prevent these outcomes
and do not move the MHI PM state to a register accessible state after
device is assumed to be inaccessible.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/init.c     |  1 +
 drivers/bus/mhi/core/internal.h |  1 +
 drivers/bus/mhi/core/pm.c       | 20 ++++++++++++++------
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 9b6a5173..0ae4c34 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -37,6 +37,7 @@
 	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
 	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
 	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
+	[DEV_ST_TRANSITION_FATAL] = "FATAL SHUTDOWN",
 };
 
 const char * const mhi_state_str[MHI_STATE_MAX] = {
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 798aa483..a7203c2 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -388,6 +388,7 @@ enum dev_st_transition {
 	DEV_ST_TRANSITION_MISSION_MODE,
 	DEV_ST_TRANSITION_SYS_ERR,
 	DEV_ST_TRANSITION_DISABLE,
+	DEV_ST_TRANSITION_FATAL,
 	DEV_ST_TRANSITION_MAX,
 };
 
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 783e3d5..b2b3de7 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -37,9 +37,10 @@
  *     M0 -> FW_DL_ERR
  *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
  * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
- * L2: SHUTDOWN_PROCESS -> DISABLE
+ * L2: SHUTDOWN_PROCESS -> LD_ERR_FATAL_DETECT
+ *     SHUTDOWN_PROCESS -> DISABLE
  * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
- *     LD_ERR_FATAL_DETECT -> SHUTDOWN_PROCESS
+ *     LD_ERR_FATAL_DETECT -> DISABLE
  */
 static struct mhi_pm_transitions const dev_state_transitions[] = {
 	/* L0 States */
@@ -72,7 +73,7 @@
 	{
 		MHI_PM_M3,
 		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+		MHI_PM_LD_ERR_FATAL_DETECT
 	},
 	{
 		MHI_PM_M3_EXIT,
@@ -103,7 +104,7 @@
 	/* L3 States */
 	{
 		MHI_PM_LD_ERR_FATAL_DETECT,
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_SHUTDOWN_PROCESS
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_DISABLE
 	},
 };
 
@@ -667,7 +668,11 @@ void mhi_pm_st_worker(struct work_struct *work)
 			break;
 		case DEV_ST_TRANSITION_DISABLE:
 			mhi_pm_disable_transition
-				(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
+					(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
+			break;
+		case DEV_ST_TRANSITION_FATAL:
+			mhi_pm_disable_transition
+					(mhi_cntrl, MHI_PM_LD_ERR_FATAL_DETECT);
 			break;
 		default:
 			break;
@@ -1040,6 +1045,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 {
 	enum mhi_pm_state cur_state;
+	enum dev_st_transition next_state = DEV_ST_TRANSITION_DISABLE;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 
 	/* If it's not a graceful shutdown, force MHI to linkdown state */
@@ -1054,9 +1060,11 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 			dev_dbg(dev, "Failed to move to state: %s from: %s\n",
 				to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
 				to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		else
+			next_state = DEV_ST_TRANSITION_FATAL;
 	}
 
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
+	mhi_queue_state_transition(mhi_cntrl, next_state);
 
 	/* Wait for shutdown to complete */
 	flush_work(&mhi_cntrl->st_worker);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
