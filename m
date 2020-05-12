Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E6C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA8D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SbK6HaO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgELCD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:03:28 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:29790 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728536AbgELCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:03:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589249001; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ubUHGIqluRbZVp5rB1az2CaAVRj7QgCCGuQL32nMMbU=; b=SbK6HaO+SluSjpmnw+vIysFCxQUlvUBOvxBJdLk+QfgfXfrbSHUyeIFiSHusu0GSKoeJEhfb
 UBxwbrycINHlxIVFjfewk6LB+k1qFVjM6KBamdmuyAa7kvnmCOzRzag5XJjwasa1mV3ZkOtv
 VU7GeMFp7tJudqDET6ilAJooTNs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba03e5.7f97719ced50-smtp-out-n01;
 Tue, 12 May 2020 02:03:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB08DC4478F; Tue, 12 May 2020 02:03:17 +0000 (UTC)
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07648C433BA;
        Tue, 12 May 2020 02:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07648C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 2/5] bus: mhi: core: Handle disable transitions in state worker
Date:   Mon, 11 May 2020 19:03:06 -0700
Message-Id: <1589248989-23824-3-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mission mode transition is handled by state worker thread but
power off is not. There is a possibility while mission mode
transition is in progress which calls MHI client driver probe,
power off is issued by MHI controller. This results into client
driver probe and remove running in parallel and causes use after
free situation. By queuing disable transition work when mission
mode is in progress prevents the race condition.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/init.c     |  1 +
 drivers/bus/mhi/core/internal.h |  1 +
 drivers/bus/mhi/core/pm.c       | 11 ++++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 3a853c5..12207cc 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -35,6 +35,7 @@
 	[DEV_ST_TRANSITION_SBL] = "SBL",
 	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
 	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
+	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
 };
 
 const char * const mhi_state_str[MHI_STATE_MAX] = {
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index f01283b..b1f640b 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -387,6 +387,7 @@ enum dev_st_transition {
 	DEV_ST_TRANSITION_SBL,
 	DEV_ST_TRANSITION_MISSION_MODE,
 	DEV_ST_TRANSITION_SYS_ERR,
+	DEV_ST_TRANSITION_DISABLE,
 	DEV_ST_TRANSITION_MAX,
 };
 
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index d9964d4..345f197 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -657,6 +657,10 @@ void mhi_pm_st_worker(struct work_struct *work)
 			mhi_pm_disable_transition
 				(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
 			break;
+		case DEV_ST_TRANSITION_DISABLE:
+			mhi_pm_disable_transition
+				(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
+			break;
 		default:
 			break;
 		}
@@ -1011,7 +1015,12 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 				to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
 				to_mhi_pm_state_str(mhi_cntrl->pm_state));
 	}
-	mhi_pm_disable_transition(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
+
+	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
+
+	/* Wait for shutdown to complete */
+	flush_work(&mhi_cntrl->st_worker);
+
 	mhi_deinit_free_irq(mhi_cntrl);
 
 	if (!mhi_cntrl->pre_init) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
