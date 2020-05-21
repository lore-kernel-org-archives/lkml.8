Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56310C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202CE20829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naAlOidb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgEURDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgEURDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32303C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so3595325pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQd+91hs3VK0NhIDC/EczKcty1yvmzMKgEFXlT+7fIE=;
        b=naAlOidbaCwmxFdthTqvyfMi5HlxjBZ95DvnRvEs6qBlOcF/4ezjJr9cJcsek9D3My
         xW7W2Zsy37t4Lv234yBtaLw24EzVgb0T1c76GioDowyp9iasulxTYIEV7l8OH/2EZHgh
         pNj1u6RjGbCEXlLP7UrA8ocGZLC42G6yVoVrvoAH44Z07i1aACydXDJQxSDgsBqVqKqm
         ZkU57RwzJS/r5Kp7H6uYr9Q9acul+0879MR2YewxVhjoh+vUo0ds81N4hrNzJBTv6sTA
         WjaTB+zYKW1G21TovIFtNkug8W/FDBv8xTCBlwcJzSoY91yMR8MDnJCGJGmw2t4XeC2a
         BlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQd+91hs3VK0NhIDC/EczKcty1yvmzMKgEFXlT+7fIE=;
        b=my3TIQu+5s5ey/nUOxBkUGE6kwwiRHXzI8HDn/Yl3ZYC7ImaB29i7oIWTr3/51fgeh
         uh/GXWA0UJ58SY6XpWWBKUoQoszBfAsVjttZy1nJe+xfmQPf5OOrfdRSKicFp4a2P+Cl
         L1Fh4XmEijrOg+Lrr7RoJ9Ikl0jwyVN3vV6KVeH65csghGYyfwuqWnwcTNAMAz7k/7tw
         cPzTW0pEWx4lKn7vdjp296DNLehqMvZE0vZLBQn2sT0roBCmYwMAkc0SDmiJlWwF8FKe
         BXlvhhuSZMCdGhBQsPbshgqUtZvcMhU3X4vM5O/FZhvPFSNWEU84oRgfIMqOuOYrydHL
         OTIQ==
X-Gm-Message-State: AOAM5314UEFoe6GZhl2bNDqSVBpLfFl23ogEXIB5rcJ2ra6Tkbt0C7xC
        gOXUADWDgyjMby6RtTPcZnMTLjX2mw==
X-Google-Smtp-Source: ABdhPJzCXM0qh7/jzyaiK/i9Iv8XR5l/U644HmPJW+3Ktiakck/FWeSSu3vY1vIl3NS3ErGx9u2vPA==
X-Received: by 2002:a63:6c8:: with SMTP id 191mr9582306pgg.22.1590080602609;
        Thu, 21 May 2020 10:03:22 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 05/14] bus: mhi: core: Handle firmware load using state worker
Date:   Thu, 21 May 2020 22:32:40 +0530
Message-Id: <20200521170249.21795-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Upon power up, driver queues firmware worker thread if the execution
environment is PBL. Firmware worker is blocked with a timeout until
state worker gets a chance to run and unblock firmware worker. An
endpoint power up failure can be seen if state worker gets a chance to
run after firmware worker has timed out. Remove this dependency and
handle firmware load directly using state worker thread.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c     | 18 +++---------------
 drivers/bus/mhi/core/init.c     |  1 -
 drivers/bus/mhi/core/internal.h |  1 +
 drivers/bus/mhi/core/pm.c       |  6 +-----
 include/linux/mhi.h             |  2 --
 5 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index ebad5eb48e5a..17c636b4bc6e 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -377,30 +377,18 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 	}
 }
 
-void mhi_fw_load_worker(struct work_struct *work)
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 {
-	struct mhi_controller *mhi_cntrl;
 	const struct firmware *firmware = NULL;
 	struct image_info *image_info;
-	struct device *dev;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
 	size_t size;
 	int ret;
 
-	mhi_cntrl = container_of(work, struct mhi_controller, fw_worker);
-	dev = &mhi_cntrl->mhi_dev->dev;
-
-	dev_dbg(dev, "Waiting for device to enter PBL from: %s\n",
-		TO_MHI_EXEC_STR(mhi_cntrl->ee));
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 MHI_IN_PBL(mhi_cntrl->ee) ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev, "Device MHI is not in valid state\n");
 		return;
 	}
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 1a93d24efffc..6882206ad80e 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -835,7 +835,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	spin_lock_init(&mhi_cntrl->wlock);
 	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
 	INIT_WORK(&mhi_cntrl->syserr_worker, mhi_pm_sys_err_worker);
-	INIT_WORK(&mhi_cntrl->fw_worker, mhi_fw_load_worker);
 	init_waitqueue_head(&mhi_cntrl->state_event);
 
 	mhi_cmd = mhi_cntrl->mhi_cmd;
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 40c47f918ca3..0965ca3c9632 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -627,6 +627,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
 void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
 void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 		      struct image_info *img_info);
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
 int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
 			struct mhi_chan *mhi_chan);
 int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index dc83d65f7784..6d56441013af 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -528,7 +528,6 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 	dev_dbg(dev, "Waiting for all pending threads to complete\n");
 	wake_up_all(&mhi_cntrl->state_event);
 	flush_work(&mhi_cntrl->st_worker);
-	flush_work(&mhi_cntrl->fw_worker);
 
 	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
 	device_for_each_child(mhi_cntrl->cntrl_dev, NULL, mhi_destroy_device);
@@ -643,7 +642,7 @@ void mhi_pm_st_worker(struct work_struct *work)
 				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
 			write_unlock_irq(&mhi_cntrl->pm_lock);
 			if (MHI_IN_PBL(mhi_cntrl->ee))
-				wake_up_all(&mhi_cntrl->state_event);
+				mhi_fw_load_handler(mhi_cntrl);
 			break;
 		case DEV_ST_TRANSITION_SBL:
 			write_lock_irq(&mhi_cntrl->pm_lock);
@@ -833,9 +832,6 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 	next_state = MHI_IN_PBL(current_ee) ?
 		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
 
-	if (next_state == DEV_ST_TRANSITION_PBL)
-		schedule_work(&mhi_cntrl->fw_worker);
-
 	mhi_queue_state_transition(mhi_cntrl, next_state);
 
 	mutex_unlock(&mhi_cntrl->pm_mutex);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 3d7c3c26eeb9..a60312927b4d 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -331,7 +331,6 @@ struct mhi_controller_config {
  * @wlock: Lock for protecting device wakeup
  * @mhi_link_info: Device bandwidth info
  * @st_worker: State transition worker
- * @fw_worker: Firmware download worker
  * @syserr_worker: System error worker
  * @state_event: State change event
  * @status_cb: CB function to notify power states of the device (required)
@@ -412,7 +411,6 @@ struct mhi_controller {
 	spinlock_t wlock;
 	struct mhi_link_info mhi_link_info;
 	struct work_struct st_worker;
-	struct work_struct fw_worker;
 	struct work_struct syserr_worker;
 	wait_queue_head_t state_event;
 
-- 
2.17.1

