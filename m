Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E32C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCD024691
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273208;
	bh=qIZGB2KAJ/YqTcpc7Sf9Or75sLBsI5DaMLX/4qzK9fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/VhOYg3MnDCb9QGRV06HsQDZWJeYOBKQ9a9lBHIwgUnxAbLV4rRkewQZKIkb9xiX
	 EdTgTPFnwoDtL/OgFOMwccbpIUg+Tbm9V6F5CJk5JjLK3zq0DsqmmNGxsYJXWmwJ50
	 WFYYMNW2LoR2CjdQdBHOA/Jn88ND+PIuXzOcbYvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbgBUIUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbgBUIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:20:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0139024691;
        Fri, 21 Feb 2020 08:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273200;
        bh=qIZGB2KAJ/YqTcpc7Sf9Or75sLBsI5DaMLX/4qzK9fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8+tTHuqLzVM29F/nciLVaFjh9g5J6bftZOfFBrDo3kzrpgoP97hS8YH11tqFSfry
         yIvYdHFTo7mxrwSZpM51cE6nnJGr3BG6jHYZeGGLPNkh8fOBXgCLh3IkRzXWzFG3O3
         3ChYcFwKc4d2TaX7La/pSRq30jk7Km50gutbtgFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/191] scsi: ufs: Complete pending requests in host reset and restore path
Date:   Fri, 21 Feb 2020 08:40:54 +0100
Message-Id: <20200221072300.945692003@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

[ Upstream commit 2df74b6985b51e77756e2e8faa16c45ca3ba53c5 ]

In UFS host reset and restore path, before probe, we stop and start the
host controller once. After host controller is stopped, the pending
requests, if any, are cleared from the doorbell, but no completion IRQ
would be raised due to the hba is stopped.  These pending requests shall be
completed along with the first NOP_OUT command (as it is the first command
which can raise a transfer completion IRQ) sent during probe.  Since the
OCSs of these pending requests are not SUCCESS (because they are not yet
literally finished), their UPIUs shall be dumped. When there are multiple
pending requests, the UPIU dump can be overwhelming and may lead to
stability issues because it is in atomic context.  Therefore, before probe,
complete these pending requests right after host controller is stopped and
silence the UPIU dump from them.

Link: https://lore.kernel.org/r/1574751214-8321-5-git-send-email-cang@qti.qualcomm.com
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Tested-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 24 ++++++++++--------------
 drivers/scsi/ufs/ufshcd.h |  2 ++
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index f4fcaee41dc26..b3dee24917a86 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4809,7 +4809,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		break;
 	} /* end of switch */
 
-	if (host_byte(result) != DID_OK)
+	if ((host_byte(result) != DID_OK) && !hba->silence_err_logs)
 		ufshcd_print_trs(hba, 1 << lrbp->task_tag, true);
 	return result;
 }
@@ -5341,8 +5341,8 @@ static void ufshcd_err_handler(struct work_struct *work)
 
 	/*
 	 * if host reset is required then skip clearing the pending
-	 * transfers forcefully because they will automatically get
-	 * cleared after link startup.
+	 * transfers forcefully because they will get cleared during
+	 * host reset and restore
 	 */
 	if (needs_reset)
 		goto skip_pending_xfer_clear;
@@ -5996,9 +5996,15 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	int err;
 	unsigned long flags;
 
-	/* Reset the host controller */
+	/*
+	 * Stop the host controller and complete the requests
+	 * cleared by h/w
+	 */
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_hba_stop(hba, false);
+	hba->silence_err_logs = true;
+	ufshcd_complete_requests(hba);
+	hba->silence_err_logs = false;
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	/* scale up clocks to max frequency before full reinitialization */
@@ -6032,22 +6038,12 @@ out:
 static int ufshcd_reset_and_restore(struct ufs_hba *hba)
 {
 	int err = 0;
-	unsigned long flags;
 	int retries = MAX_HOST_RESET_RETRIES;
 
 	do {
 		err = ufshcd_host_reset_and_restore(hba);
 	} while (err && --retries);
 
-	/*
-	 * After reset the door-bell might be cleared, complete
-	 * outstanding requests in s/w here.
-	 */
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	ufshcd_transfer_req_compl(hba);
-	ufshcd_tmc_handler(hba);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
 	return err;
 }
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 33fdd3f281ae8..4554a4b725b54 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -489,6 +489,7 @@ struct ufs_stats {
  * @uic_error: UFS interconnect layer error status
  * @saved_err: sticky error mask
  * @saved_uic_err: sticky UIC error mask
+ * @silence_err_logs: flag to silence error logs
  * @dev_cmd: ufs device management command information
  * @last_dme_cmd_tstamp: time stamp of the last completed DME command
  * @auto_bkops_enabled: to track whether bkops is enabled in device
@@ -645,6 +646,7 @@ struct ufs_hba {
 	u32 saved_err;
 	u32 saved_uic_err;
 	struct ufs_stats ufs_stats;
+	bool silence_err_logs;
 
 	/* Device management request data */
 	struct ufs_dev_cmd dev_cmd;
-- 
2.20.1



