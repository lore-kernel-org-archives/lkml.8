Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95F7C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9563020692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AFafhI3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgDHNsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:48:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:58235 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727883AbgDHNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:48:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586353718; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3LyFRqPl+hE6jhfR1grLHYkI2mGY6U5I71YbCiteW8s=; b=AFafhI3a2FxoUO892yYnzHQBQN876ZLLUdxI/5mYhBDlNMJK880jmxXJCYodxajJMFBSVPWd
 rYVBIC2JeEjO97vms2RVgdP6SN3fi+4//TioJG8lPNSL++m/xlgNJVqJWC2G85f5Gobeb1RJ
 hrA8J7DexlDoIKWkZmrsliLmedU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8dd628.7f77f6789d88-smtp-out-n01;
 Wed, 08 Apr 2020 13:48:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16759C44793; Wed,  8 Apr 2020 13:48:23 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0FB0C3856D;
        Wed,  8 Apr 2020 13:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0FB0C3856D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH 19/21] spi: spi-qcom-qspi: Use OPP API to set clk/perf state
Date:   Wed,  8 Apr 2020 19:16:45 +0530
Message-Id: <1586353607-32222-20-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSPI needs to vote on a performance state of a power domain depending on
the clock rate. Add support for it by specifying the perf state/clock rate
as an OPP table in device tree.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Akash Asthana <akashast@codeaurora.org>
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/spi-qcom-qspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 3c4f83b..42a9511 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_opp.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
@@ -235,7 +236,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		speed_hz = xfer->speed_hz;
 
 	/* In regular operation (SBL_EN=1) core must be 4x transfer clock */
-	ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
+	ret = dev_pm_opp_set_rate(ctrl->dev, speed_hz * 4);
 	if (ret) {
 		dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
 		return ret;
@@ -481,6 +482,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->handle_err = qcom_qspi_handle_err;
 	master->auto_runtime_pm = true;
 
+	dev_pm_opp_set_clkname(&pdev->dev, "core");
+	dev_pm_opp_of_add_table(&pdev->dev);
+
 	pm_runtime_enable(dev);
 
 	ret = spi_register_master(master);
@@ -490,6 +494,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 
 exit_probe_master_put:
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	spi_master_put(master);
 
 	return ret;
@@ -499,6 +504,8 @@ static int qcom_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 
+	dev_pm_opp_of_remove_table(&pdev->dev);
+
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_master(master);
 
@@ -512,6 +519,7 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 
+	dev_pm_opp_set_rate(dev, 0);
 	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
 
 	return 0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
