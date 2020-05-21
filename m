Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3ED220829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yE2F3eqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgEURDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgEURDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6488C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n15so3620221pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HJdUtFskJTJX9hH5IqG0JWO7Sknuz1pUAhyTdOQmOSs=;
        b=yE2F3eqU2dXuCxAO8X3zL1DuhcawU48juSAfsfYH1wgB9zqgXwzU0anzBUe2gwqCvN
         MSy8eCEy39vC1RhBLUgVHsoVNtOOdcIheysyZoYLHoSBMRw84pLm3dIAOd1WA7RJ0ZCS
         wCcM3Tdy1+4FfxQ+oBt1KFcFOKP0A2zYlB8mQbHv+nuesOHE2KOQCDYYb9WC7wTfxpwd
         TN9mP024MK5zP/ceU2ks8YKgpb5QRMULKfN4gJ9cixRX3SxonNz6kkebytlQwfgYVluz
         EjY8EAU64IpJRmuUxeQzeDU3yX9zrNISHCkaCv+4frMMnxzkv9P0m1kaxFFu6gnyDnMN
         GPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HJdUtFskJTJX9hH5IqG0JWO7Sknuz1pUAhyTdOQmOSs=;
        b=IypknT1WAuN3Q0tsfbRWaXumK+7n0+gpuNt/VCAtE28aP86n8zanqaEWwDyM8kVeVN
         CvUUkpb0GON7zBd+9Qebxsw8ARMXdpDVTJV/0SEJCp2qc9b1YnVgGv6IjMS3cZc3fqV0
         mOpQePdKq/1Jn6h8GMTOr3k8TYxjuI/hRNRhX2l38iHtTcUHpgZw25gGGq6l51TKxE1p
         Zr18RqKKKTCPy11m9HyAcRefwsEWYSGm0mwCpCk0akZaa4B3mXix9AaykwFg8qdWgBVn
         aXiNSl9XZgGIi/tv1ogVWkqE0KtUSvT5SVvByNlk1vOO3fKrOox+q4R3gfdHy+aFs0cF
         2rgA==
X-Gm-Message-State: AOAM531fKT9bOVA62QppeDPJmOlm9BHxDqG6iVQ4H1x3CrCRHZksivF5
        rekkPwB2lgy9w0h6eFuQRkLU
X-Google-Smtp-Source: ABdhPJxsrfOklYSPQDiDPdFTwuCEkiUARZXOFTMu1gxUQM0Oee13qxGfDle3g0oTQPnCyenyjvQ9vQ==
X-Received: by 2002:a62:b503:: with SMTP id y3mr6816452pfe.3.1590080625223;
        Thu, 21 May 2020 10:03:45 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 10/14] bus: mhi: core: Handle disable transitions in state worker
Date:   Thu, 21 May 2020 22:32:45 +0530
Message-Id: <20200521170249.21795-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Mission mode transition is handled by state worker thread but
power off is not. There is a possibility while mission mode
transition is in progress which calls MHI client driver probe,
power off is issued by MHI controller. This results into client
driver probe and remove running in parallel and causes use after
free situation. By queuing disable transition work when mission
mode is in progress prevents the race condition.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c     |  1 +
 drivers/bus/mhi/core/internal.h |  1 +
 drivers/bus/mhi/core/pm.c       | 11 ++++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 3a853c5d2103..12207cc438aa 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -35,6 +35,7 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
 	[DEV_ST_TRANSITION_SBL] = "SBL",
 	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
 	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
+	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
 };
 
 const char * const mhi_state_str[MHI_STATE_MAX] = {
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index f01283b8a451..b1f640b75a94 100644
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
index 743b3207c390..a5d9973059c8 100644
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
@@ -868,7 +872,12 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
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
2.17.1

