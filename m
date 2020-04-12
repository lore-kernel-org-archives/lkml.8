Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25169C2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF420708
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 16:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XkbZOwPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgDLQAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgDLQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 12:00:06 -0400
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info [104.130.122.26])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 8D194C0A3BF5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:55:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586706901; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5msTDxYT3tpSfnzCJKX6Ft0Yy5norn9AjSAP7jky84s=; b=XkbZOwPTJJj/WhUvEVIiT0JhquIgfO0i69A1IIOvnMUhl0MjPb1+urU2XmSM78GIyJtEXFBI
 AFn1x42LIgVyGD8B5J0jkZ3hyDL3QdhecUuxfdeA6NOztaC2jJr+BrRMWv1RJCvLS6Ze94f3
 GOsiQENx4Yd8tFulpRhcPRPb/Cc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9339c9.7f6a640eac70-smtp-out-n05;
 Sun, 12 Apr 2020 15:54:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0452C433BA; Sun, 12 Apr 2020 15:54:48 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EBAAC433F2;
        Sun, 12 Apr 2020 15:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EBAAC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V1 2/4] mmc: sdhci-msm: Enable MMC_CAP_NEED_RSP_BUSY host capability
Date:   Sun, 12 Apr 2020 21:23:26 +0530
Message-Id: <1586706808-27337-3-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org>
References: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-msm controller requires the R1B response for commands that
has this response associated with them.

So enable MMC_CAP_NEED_RSP_BUSY capability.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 013dcea..d826e9b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2088,6 +2088,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	}
 
 	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+	msm_host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
