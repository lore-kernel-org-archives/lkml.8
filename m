Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5DDC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B82078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cTFmA6MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTGVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:21:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57354 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgDTGVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:21:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587363671; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FVcurZhnqdUAS+ng2DGudV2uvfN0AkaVvFL9XeQqcZs=; b=cTFmA6MZi0i5ifIg4RwDoR3cS6MXFU8oidEoTUR086/iftlQhZJ4XZSWg8x/nd8nQCFncwEL
 il7oyoxNEm4NS/ey0RWhF1wQr0N96gTGb5RHzT4h0CyMZnA1xSOTOtOzYOXVaZaGQojGTmc4
 2On3f/fgOKlWOhnpFnVFXSeJpgU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9d3f53.7ffb17b5d4c8-smtp-out-n05;
 Mon, 20 Apr 2020 06:21:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D607C43637; Mon, 20 Apr 2020 06:21:06 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75C48C43636;
        Mon, 20 Apr 2020 06:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75C48C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        <stable@vger.kernel.org>, Andy Gross <agross@kernel.org>
Subject: [PATCH V2 1/3] mmc: sdhci-msm: Enable host capabilities pertains to R1b response
Date:   Mon, 20 Apr 2020 11:50:23 +0530
Message-Id: <1587363626-20413-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587363626-20413-1-git-send-email-vbadigan@codeaurora.org>
References: <1587363626-20413-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM sd host controller is capable of HW busy detection of device busy
signaling over DAT0 line. And it requires the R1B response for
commands that have this response associated with them.

So set the below two host capabilities for qcom SDHC.
	- MMC_CAP_WAIT_WHILE_BUSY
	- MMC_CAP_NEED_RSP_BUSY

Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 09ff731..d826e9b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2087,6 +2087,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+	msm_host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
