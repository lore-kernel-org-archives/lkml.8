Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54055C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278352073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="g9/LzbYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCELsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:48:09 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:28475 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbgCELsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:48:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583408886; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4jKVb0RH11oa+FT4XfeYYMCV12ybOqDO5l6dlM8M5qA=; b=g9/LzbYLTtgpjWav0PcHVAXxa5u7xff4XqHDW1bqpdXvQpNWs4yIqc7XeVxqVifxxbJXqZqh
 w20jwyxUr55AP/Rzh6/NgmQR7yZYmAbzPZGHlM1r8XwxSFhmI7PpWBniy0A3oQH7zFZ/63PP
 o8ujfM9Aapqfl6licVnsCEXGLII=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e60e6f5.7f18d241d458-smtp-out-n04;
 Thu, 05 Mar 2020 11:48:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEDD5C447A0; Thu,  5 Mar 2020 11:48:04 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E244C433A2;
        Thu,  5 Mar 2020 11:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E244C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v11 2/4] soc: qcom: rpmh: Update dirty flag only when data changes
Date:   Thu,  5 Mar 2020 17:17:34 +0530
Message-Id: <1583408856-1120-3-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583408856-1120-1-git-send-email-mkshah@codeaurora.org>
References: <1583408856-1120-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rpmh ctrlr dirty flag is set for all cases regardless of data
is really changed or not. Add changes to update dirty flag when data is
changed to newer values. Update dirty flag everytime when data in batch
cache is updated since rpmh_flush() may get invoked from any CPU instead
of only last CPU going to low power mode.

Also move dirty flag updates to happen from within cache_lock and remove
unnecessary INIT_LIST_HEAD() call and a default case from switch.

Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/soc/qcom/rpmh.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index eb0ded0..03630ae 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -119,6 +119,7 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 {
 	struct cache_req *req;
 	unsigned long flags;
+	u32 old_sleep_val, old_wake_val;
 
 	spin_lock_irqsave(&ctrlr->cache_lock, flags);
 	req = __find_req(ctrlr, cmd->addr);
@@ -133,26 +134,27 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 
 	req->addr = cmd->addr;
 	req->sleep_val = req->wake_val = UINT_MAX;
-	INIT_LIST_HEAD(&req->list);
 	list_add_tail(&req->list, &ctrlr->cache);
 
 existing:
+	old_sleep_val = req->sleep_val;
+	old_wake_val = req->wake_val;
+
 	switch (state) {
 	case RPMH_ACTIVE_ONLY_STATE:
-		if (req->sleep_val != UINT_MAX)
-			req->wake_val = cmd->data;
-		break;
 	case RPMH_WAKE_ONLY_STATE:
 		req->wake_val = cmd->data;
 		break;
 	case RPMH_SLEEP_STATE:
 		req->sleep_val = cmd->data;
 		break;
-	default:
-		break;
 	}
 
-	ctrlr->dirty = true;
+	ctrlr->dirty = (req->sleep_val != old_sleep_val ||
+			req->wake_val != old_wake_val) &&
+			req->sleep_val != UINT_MAX &&
+			req->wake_val != UINT_MAX;
+
 unlock:
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
@@ -287,6 +289,7 @@ static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
 
 	spin_lock_irqsave(&ctrlr->cache_lock, flags);
 	list_add_tail(&req->list, &ctrlr->batch_cache);
+	ctrlr->dirty = true;
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 }
 
@@ -323,6 +326,7 @@ static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
 	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
 		kfree(req);
 	INIT_LIST_HEAD(&ctrlr->batch_cache);
+	ctrlr->dirty = true;
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
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
