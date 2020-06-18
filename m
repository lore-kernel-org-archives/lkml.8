Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15C920707
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="s45rwrEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgFRNGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:06:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22381 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgFRNGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:06:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592485581; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hMRM2QVP/ewY7wLU63zjCcKd42Mc9s6EEHHa9yVORQk=; b=s45rwrEVb9WkokjoOmLDPriBlTFHozs/eUFVklVAKvSRZpGKEneLVNNui2OF6nSGJ4cLue9U
 tjyJ1C3tsnLUBQu22Sv8U36AItfHAXq0t3rPB4Uy4HugSvu6LZh/dqb1nMY+S2+sQ6zgvbBL
 VtR/FYVbwd5cRF9fIumTU7pjJ4w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5eeb66c8ad153efa3425df8d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 13:06:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CC7B2C43391; Thu, 18 Jun 2020 13:06:15 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D58D8C433C8;
        Thu, 18 Jun 2020 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D58D8C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH] soc: qcom: rpmh: Update rpmh_invalidate function to return void
Date:   Thu, 18 Jun 2020 18:35:53 +0530
Message-Id: <1592485553-29163-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rpmh_invalidate() always returns success. Update its
return type to void.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 6 +-----
 drivers/soc/qcom/rpmh.c               | 4 +---
 include/soc/qcom/rpmh.h               | 7 ++++---
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 2a11a63..a3d2ef1 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -266,11 +266,7 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 	if (!commit_idx[0])
 		goto out;
 
-	ret = rpmh_invalidate(voter->dev);
-	if (ret) {
-		pr_err("Error invalidating RPMH client (%d)\n", ret);
-		goto out;
-	}
+	rpmh_invalidate(voter->dev);
 
 	ret = rpmh_write_batch(voter->dev, RPMH_ACTIVE_ONLY_STATE,
 			       cmds, commit_idx);
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index f2b5b46c..b61e183 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -497,7 +497,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
  *
  * Invalidate the sleep and wake values in batch_cache.
  */
-int rpmh_invalidate(const struct device *dev)
+void rpmh_invalidate(const struct device *dev)
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	struct batch_cache_req *req, *tmp;
@@ -509,7 +509,5 @@ int rpmh_invalidate(const struct device *dev)
 	INIT_LIST_HEAD(&ctrlr->batch_cache);
 	ctrlr->dirty = true;
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-
-	return 0;
 }
 EXPORT_SYMBOL(rpmh_invalidate);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index f9ec353..bdbee1a 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -20,7 +20,7 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 *n);
 
-int rpmh_invalidate(const struct device *dev);
+void rpmh_invalidate(const struct device *dev);
 
 #else
 
@@ -38,8 +38,9 @@ static inline int rpmh_write_batch(const struct device *dev,
 				   const struct tcs_cmd *cmd, u32 *n)
 { return -ENODEV; }
 
-static inline int rpmh_invalidate(const struct device *dev)
-{ return -ENODEV; }
+static inline void rpmh_invalidate(const struct device *dev)
+{
+}
 
 #endif /* CONFIG_QCOM_RPMH */
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

