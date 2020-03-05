Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49F2207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vJegXxrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCERHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:07:48 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:10965 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgCERHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:07:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583428067; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pRNvHxX80n8wBj2lKTDP98u1doAk5pcKRHB2R9qvWTg=; b=vJegXxrfNp/xxk49Ls2o+wn8yUm9mFj1rro3nyxjaw7v2HtA3LndbPLlO3jePLKyYNnCywzf
 LjA1zdFYLfyxOWRflyyujw2BOO+Ra6K9vuSeSJcHfYZrmKnCbCOSsnlEKoF5dPZSio1rd8QL
 JigXnGDlc+wSMldwo60Grjb0aQo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6131d2.7f63685e0810-smtp-out-n03;
 Thu, 05 Mar 2020 17:07:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F016C433A2; Thu,  5 Mar 2020 17:07:30 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B4B9C447A0;
        Thu,  5 Mar 2020 17:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B4B9C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v12 4/4] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes before flushing new data
Date:   Thu,  5 Mar 2020 22:37:03 +0530
Message-Id: <1583428023-19559-5-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583428023-19559-1-git-send-email-mkshah@codeaurora.org>
References: <1583428023-19559-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCSes have previously programmed data when rpmh_flush is called.
This can cause old data to trigger along with newly flushed.

Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.

Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 1951f6a..63364ce 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -472,6 +472,11 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
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
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
