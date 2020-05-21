Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ECAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E0A20829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDxnv31H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgEURDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgEURDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85984C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci21so3382515pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mkORFAFgTLNLDFrtKjsr+0SKkC8nOalD6sT+qgpFPxw=;
        b=NDxnv31HOCtw6zA/c8EYwx7mmGQ//7G5Twm9Rs5p0UPffqBSG1OuqSEgxCbdd3K0NT
         oS03x7QLKloXwZfTEzvXpwGF27YgMNMrtqxcMm4+CDpgX3zNZ7tOht6It+EoNgkc2726
         xKHiffMwkFlV2rY+VFN8HCmO0D3lbkFYHnxamyR2Hg85AlOr2y16PlnlHLe0uSwMh2vl
         MgzlD5Yrx2N8JdlJDbZXn/exkEgEfX0jpqoIDrmFUqHUQql/AjhmiuI8xNNptnVBnr+/
         6t5+6B/1diTFB9y5hAEH8Bh/Q4e3PRxYO2B9xyxFuv9RZw6kLd8529R3Gz/8H10y0ld8
         GVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mkORFAFgTLNLDFrtKjsr+0SKkC8nOalD6sT+qgpFPxw=;
        b=H1R/owphztHD8qyfQtdgmWh1KFLEzX0WTm/FWK7kg57Ul6wTBgtxFkz4juIDB7A/yO
         T7kQsUfp7zh+fbEJ7t7iekyqP0y7J8jLPPqn8dm79g4iixVNcTo3gagzm+u9QmALI+U4
         fZQPEEhxmrYYV1Uky8jBqNHG8LqupqgMJA+2Qq6DGr43FwRLa9t78B05JgyIpDKkcuxx
         yYF5E8cvMfB4jJ3MjmWQ7LCzrlt8ltqKS0x0Aa7u37+SC6LHjBB9RjqAkGMxvJIMDIEf
         Q/fiep07aIW6DdOgD8EX80mqENnovLIcn2o9W1eurDDXfc9cUXU6htdTL5JAiUQUQzju
         PnUg==
X-Gm-Message-State: AOAM530aEyuTKl66RMBLldGrWZEpueD7S2Mur+jZkbXo0O6UltcSwNoL
        /0O9mOxh2YXRi8YIousTbBR2
X-Google-Smtp-Source: ABdhPJylkdZbxY75cKgwJnzxb+EP9ogEskMz6cgk8O2ZLEiACRxBCStdmEDjJ9wPSGG7POHo2IaOFQ==
X-Received: by 2002:a17:90a:c984:: with SMTP id w4mr12475643pjt.9.1590080620966;
        Thu, 21 May 2020 10:03:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 09/14] bus: mhi: core: Remove the system error worker thread
Date:   Thu, 21 May 2020 22:32:44 +0530
Message-Id: <20200521170249.21795-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Remove the system error worker thread and instead have the
execution environment worker handle that transition to serialize
processing and avoid any possible race conditions during
shutdown.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c     |  2 +-
 drivers/bus/mhi/core/internal.h |  3 ++-
 drivers/bus/mhi/core/main.c     |  6 +++---
 drivers/bus/mhi/core/pm.c       | 32 ++++++++++++++------------------
 include/linux/mhi.h             |  2 --
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 6882206ad80e..3a853c5d2103 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -34,6 +34,7 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
 	[DEV_ST_TRANSITION_READY] = "READY",
 	[DEV_ST_TRANSITION_SBL] = "SBL",
 	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
+	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
 };
 
 const char * const mhi_state_str[MHI_STATE_MAX] = {
@@ -834,7 +835,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	spin_lock_init(&mhi_cntrl->transition_lock);
 	spin_lock_init(&mhi_cntrl->wlock);
 	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
-	INIT_WORK(&mhi_cntrl->syserr_worker, mhi_pm_sys_err_worker);
 	init_waitqueue_head(&mhi_cntrl->state_event);
 
 	mhi_cmd = mhi_cntrl->mhi_cmd;
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 80b32c20149c..f01283b8a451 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -386,6 +386,7 @@ enum dev_st_transition {
 	DEV_ST_TRANSITION_READY,
 	DEV_ST_TRANSITION_SBL,
 	DEV_ST_TRANSITION_MISSION_MODE,
+	DEV_ST_TRANSITION_SYS_ERR,
 	DEV_ST_TRANSITION_MAX,
 };
 
@@ -587,7 +588,7 @@ enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
 int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
 			       enum dev_st_transition state);
 void mhi_pm_st_worker(struct work_struct *work);
-void mhi_pm_sys_err_worker(struct work_struct *work);
+void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
 void mhi_fw_load_worker(struct work_struct *work);
 int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
 void mhi_ctrl_ev_task(unsigned long data);
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index a394691d9383..e5f6500e89fd 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -405,7 +405,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev)
 		if (MHI_IN_PBL(ee))
 			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_FATAL_ERROR);
 		else
-			schedule_work(&mhi_cntrl->syserr_worker);
+			mhi_pm_sys_err_handler(mhi_cntrl);
 	}
 
 exit_intvec:
@@ -733,7 +733,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 							MHI_PM_SYS_ERR_DETECT);
 				write_unlock_irq(&mhi_cntrl->pm_lock);
 				if (new_state == MHI_PM_SYS_ERR_DETECT)
-					schedule_work(&mhi_cntrl->syserr_worker);
+					mhi_pm_sys_err_handler(mhi_cntrl);
 				break;
 			}
 			default:
@@ -919,7 +919,7 @@ void mhi_ctrl_ev_task(unsigned long data)
 		}
 		write_unlock_irq(&mhi_cntrl->pm_lock);
 		if (pm_state == MHI_PM_SYS_ERR_DETECT)
-			schedule_work(&mhi_cntrl->syserr_worker);
+			mhi_pm_sys_err_handler(mhi_cntrl);
 	}
 }
 
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 6d56441013af..743b3207c390 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -449,19 +449,8 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		to_mhi_pm_state_str(transition_state));
 
 	/* We must notify MHI control driver so it can clean up first */
-	if (transition_state == MHI_PM_SYS_ERR_PROCESS) {
-		/*
-		 * If controller supports RDDM, we do not process
-		 * SYS error state, instead we will jump directly
-		 * to RDDM state
-		 */
-		if (mhi_cntrl->rddm_image) {
-			dev_dbg(dev,
-				 "Controller supports RDDM, so skip SYS_ERR\n");
-			return;
-		}
+	if (transition_state == MHI_PM_SYS_ERR_PROCESS)
 		mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_SYS_ERROR);
-	}
 
 	mutex_lock(&mhi_cntrl->pm_mutex);
 	write_lock_irq(&mhi_cntrl->pm_lock);
@@ -527,7 +516,6 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 	dev_dbg(dev, "Waiting for all pending threads to complete\n");
 	wake_up_all(&mhi_cntrl->state_event);
-	flush_work(&mhi_cntrl->st_worker);
 
 	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
 	device_for_each_child(mhi_cntrl->cntrl_dev, NULL, mhi_destroy_device);
@@ -607,13 +595,17 @@ int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
 }
 
 /* SYS_ERR worker */
-void mhi_pm_sys_err_worker(struct work_struct *work)
+void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl)
 {
-	struct mhi_controller *mhi_cntrl = container_of(work,
-							struct mhi_controller,
-							syserr_worker);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	/* skip if controller supports RDDM */
+	if (mhi_cntrl->rddm_image) {
+		dev_dbg(dev, "Controller supports RDDM, skip SYS_ERROR\n");
+		return;
+	}
 
-	mhi_pm_disable_transition(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
+	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_SYS_ERR);
 }
 
 /* Device State Transition worker */
@@ -661,6 +653,10 @@ void mhi_pm_st_worker(struct work_struct *work)
 		case DEV_ST_TRANSITION_READY:
 			mhi_ready_state_transition(mhi_cntrl);
 			break;
+		case DEV_ST_TRANSITION_SYS_ERR:
+			mhi_pm_disable_transition
+				(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
+			break;
 		default:
 			break;
 		}
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index a60312927b4d..642ef1f40a2b 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -331,7 +331,6 @@ struct mhi_controller_config {
  * @wlock: Lock for protecting device wakeup
  * @mhi_link_info: Device bandwidth info
  * @st_worker: State transition worker
- * @syserr_worker: System error worker
  * @state_event: State change event
  * @status_cb: CB function to notify power states of the device (required)
  * @wake_get: CB function to assert device wake (optional)
@@ -411,7 +410,6 @@ struct mhi_controller {
 	spinlock_t wlock;
 	struct mhi_link_info mhi_link_info;
 	struct work_struct st_worker;
-	struct work_struct syserr_worker;
 	wait_queue_head_t state_event;
 
 	void (*status_cb)(struct mhi_controller *mhi_cntrl,
-- 
2.17.1

