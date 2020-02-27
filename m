Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669BC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD012467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GDnQKqfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgB0I5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:57:10 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:35918 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728686AbgB0I5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:57:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582793829; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=53H+G3JfcVdMHwRGgnhX+dkCAuSvHteolaxpU2GcwPQ=; b=GDnQKqfPIoJXilGzkeh7UTMfjvp5TU/JQkj5biFao+lVVlLyjfZbQDvDMC2SYE47m5ojtxbY
 WCYhqTepyVDCMDOQvIt8HQsrvAZUpH4k/ShLDCaVdIF4ZCeZlnK1Uc1wrpvFwsFabGiUcnFr
 TqB5qmMs6WBx6TIVSw0ij49LRbs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e578450.7fca9e55fae8-smtp-out-n02;
 Thu, 27 Feb 2020 08:56:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 086C6C43383; Thu, 27 Feb 2020 08:56:48 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1574EC433A2;
        Thu, 27 Feb 2020 08:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1574EC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v8 2/3] soc: qcom: rpmh: Update dirty flag only when data changes
Date:   Thu, 27 Feb 2020 14:26:24 +0530
Message-Id: <1582793785-22423-3-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582793785-22423-1-git-send-email-mkshah@codeaurora.org>
References: <1582793785-22423-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rpmh ctrlr dirty flag is set for all cases regardless of data
is really changed or not. Add changes to update dirty flag when data is
changed to newer values.

Also move dirty flag updates to happen from within cache_lock and remove
unnecessary INIT_LIST_HEAD() call and a default case from switch.

Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index eb0ded0..3f5d9eb 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -133,26 +133,30 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 
 	req->addr = cmd->addr;
 	req->sleep_val = req->wake_val = UINT_MAX;
-	INIT_LIST_HEAD(&req->list);
 	list_add_tail(&req->list, &ctrlr->cache);
 
 existing:
 	switch (state) {
 	case RPMH_ACTIVE_ONLY_STATE:
-		if (req->sleep_val != UINT_MAX)
+		if (req->sleep_val != UINT_MAX) {
 			req->wake_val = cmd->data;
+			ctrlr->dirty = true;
+		}
 		break;
 	case RPMH_WAKE_ONLY_STATE:
-		req->wake_val = cmd->data;
+		if (req->wake_val != cmd->data) {
+			req->wake_val = cmd->data;
+			ctrlr->dirty = true;
+		}
 		break;
 	case RPMH_SLEEP_STATE:
-		req->sleep_val = cmd->data;
-		break;
-	default:
+		if (req->sleep_val != cmd->data) {
+			req->sleep_val = cmd->data;
+			ctrlr->dirty = true;
+		}
 		break;
 	}
 
-	ctrlr->dirty = true;
 unlock:
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
@@ -287,6 +291,7 @@ static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
 
 	spin_lock_irqsave(&ctrlr->cache_lock, flags);
 	list_add_tail(&req->list, &ctrlr->batch_cache);
+	ctrlr->dirty = true;
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 }
 
@@ -323,6 +328,7 @@ static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
 	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
 		kfree(req);
 	INIT_LIST_HEAD(&ctrlr->batch_cache);
+	ctrlr->dirty = true;
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 }
 
@@ -456,13 +462,9 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
 int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 {
 	struct cache_req *p;
+	unsigned long flags;
 	int ret;
 
-	if (!ctrlr->dirty) {
-		pr_debug("Skipping flush, TCS has latest data.\n");
-		return 0;
-	}
-
 	/* First flush the cached batch requests */
 	ret = flush_batch(ctrlr);
 	if (ret)
@@ -488,7 +490,9 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 			return ret;
 	}
 
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
 	ctrlr->dirty = false;
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
 	return 0;
 }
@@ -507,7 +511,6 @@ int rpmh_invalidate(const struct device *dev)
 	int ret;
 
 	invalidate_batch(ctrlr);
-	ctrlr->dirty = true;
 
 	do {
 		ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
