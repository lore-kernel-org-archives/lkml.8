Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F29C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD620727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AQGR1GYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCIJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:31:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44905 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgCIJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:31:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583746293; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GWrEORlfn6gZkjUF60IMjo4kKFjeyGs6BAkvgFw3ywg=; b=AQGR1GYlMLwBm1B+LHxOPBVi/bAnrPO7RM8miNcv5XGm4L0JTe3WCBXAM51q66CQ1gMx9t9V
 Dg0qGXHhtgzbTjyRaCJzcnpqszkfOKT3UiaxlwA3308qIrf62Dc4BKtA3v2vwO2pNw3sL4AV
 Ij81BMNrpS7VqWQoN8vTMKyg51k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e660cf4.7fabc862e650-smtp-out-n01;
 Mon, 09 Mar 2020 09:31:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1EF1C43636; Mon,  9 Mar 2020 09:31:32 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 675DDC433D2;
        Mon,  9 Mar 2020 09:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 675DDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v13 3/5] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes before flushing new data
Date:   Mon,  9 Mar 2020 15:00:34 +0530
Message-Id: <1583746236-13325-4-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org>
References: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCSes have previously programmed data when rpmh_flush is called.
This can cause old data to trigger along with newly flushed.

Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.

With this there is no need to invoke rpmh_rsc_invalidate() call from
rpmh_invalidate().

Simplify rpmh_invalidate() by moving invalidate_batch() inside.

Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 03630ae..5bed8f4 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -317,19 +317,6 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
 	return ret;
 }
 
-static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
-{
-	struct batch_cache_req *req, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
-	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
-		kfree(req);
-	INIT_LIST_HEAD(&ctrlr->batch_cache);
-	ctrlr->dirty = true;
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-}
-
 /**
  * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
  * batch to finish.
@@ -467,6 +454,11 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 		return 0;
 	}
 
+	/* Invalidate the TCSes first to avoid stale data */
+	do {
+		ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
+	} while (ret == -EAGAIN);
+
 	/* First flush the cached batch requests */
 	ret = flush_batch(ctrlr);
 	if (ret)
@@ -503,19 +495,21 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
  *
  * @dev: The device making the request
  *
- * Invalidate the sleep and active values in the TCS blocks.
+ * Invalidate the sleep and wake values in batch_cache.
  */
 int rpmh_invalidate(const struct device *dev)
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
-	int ret;
-
-	invalidate_batch(ctrlr);
+	struct batch_cache_req *req, *tmp;
+	unsigned long flags;
 
-	do {
-		ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
-	} while (ret == -EAGAIN);
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
+		kfree(req);
+	INIT_LIST_HEAD(&ctrlr->batch_cache);
+	ctrlr->dirty = true;
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(rpmh_invalidate);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
