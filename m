Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A3EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FF8246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dVSibMhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB1LjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:39:01 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:45487 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgB1LjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:39:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582889939; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ZW3+R3WZn+Fe4z409CjSDFwivm2DxMFy6ZjsdFoYfMY=; b=dVSibMhyA/WFoshEaIDO4kLhgg36JvAZm4PrYo+7VixXfGBf8qGIfTmFGEUscS2hTrfyMwrm
 sacZMMZO9oQFIzXb1XTIDRklMtjEedm+V+hOYmRwRNA1V79WUtna3GxAwAHZbLtaVBux1/md
 m1It60+1u47X35AKmLy7JqX0j04=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e58fbc8.7fde1c1b0688-smtp-out-n02;
 Fri, 28 Feb 2020 11:38:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47484C4479D; Fri, 28 Feb 2020 11:38:47 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18FE8C4479C;
        Fri, 28 Feb 2020 11:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18FE8C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v9 3/3] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
Date:   Fri, 28 Feb 2020 17:08:23 +0530
Message-Id: <1582889903-12890-4-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582889903-12890-1-git-send-email-mkshah@codeaurora.org>
References: <1582889903-12890-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to invoke rpmh flush() from within cache_lock when the data
in cache is dirty.

This is done only if OSI is not supported in PSCI. If OSI is supported
rpmh_flush can get invoked when the last cpu going to power collapse
deepest low power mode.

Also remove "depends on COMPILE_TEST" for Kconfig option QCOM_RPMH so the
driver is only compiled for arm64 which supports psci_has_osi_support()
API.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
---
 drivers/soc/qcom/Kconfig |  2 +-
 drivers/soc/qcom/rpmh.c  | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index d0a73e7..2e581bc 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -105,7 +105,7 @@ config QCOM_RMTFS_MEM
 
 config QCOM_RPMH
 	bool "Qualcomm RPM-Hardened (RPMH) Communication"
-	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
+	depends on ARCH_QCOM && ARM64
 	help
 	  Support for communication with the hardened-RPM blocks in
 	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index f28afe4..6a5a60c 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/psci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -158,6 +159,13 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 	}
 
 unlock:
+	if (ctrlr->dirty && !psci_has_osi_support()) {
+		if (rpmh_flush(ctrlr)) {
+			spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
 	return req;
@@ -285,26 +293,35 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write);
 
-static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
+static int cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+
 	list_add_tail(&req->list, &ctrlr->batch_cache);
 	ctrlr->dirty = true;
+
+	if (!psci_has_osi_support()) {
+		if (rpmh_flush(ctrlr)) {
+			spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+			return -EINVAL;
+		}
+	}
+
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+
+	return 0;
 }
 
 static int flush_batch(struct rpmh_ctrlr *ctrlr)
 {
 	struct batch_cache_req *req;
 	const struct rpmh_request *rpm_msg;
-	unsigned long flags;
 	int ret = 0;
 	int i;
 
 	/* Send Sleep/Wake requests to the controller, expect no response */
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
 	list_for_each_entry(req, &ctrlr->batch_cache, list) {
 		for (i = 0; i < req->count; i++) {
 			rpm_msg = req->rpm_msgs + i;
@@ -314,7 +331,6 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
 				break;
 		}
 	}
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
 	return ret;
 }
@@ -386,10 +402,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 		cmd += n[i];
 	}
 
-	if (state != RPMH_ACTIVE_ONLY_STATE) {
-		cache_batch(ctrlr, req);
-		return 0;
-	}
+	if (state != RPMH_ACTIVE_ONLY_STATE)
+		return cache_batch(ctrlr, req);
 
 	for (i = 0; i < count; i++) {
 		struct completion *compl = &compls[i];
@@ -455,9 +469,6 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
  * Return: -EBUSY if the controller is busy, probably waiting on a response
  * to a RPMH request sent earlier.
  *
- * This function is always called from the sleep code from the last CPU
- * that is powering down the entire system. Since no other RPMH API would be
- * executing at this time, it is safe to run lockless.
  */
 int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
