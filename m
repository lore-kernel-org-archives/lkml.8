Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEFBC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E182070A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgEXKFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 06:05:16 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46282 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387732AbgEXKFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 06:05:00 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 May 2020 03:04:59 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg05-sd.qualcomm.com with ESMTP; 24 May 2020 03:04:55 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id DB055217FF; Sun, 24 May 2020 15:34:49 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V5 7/8] mailbox: qcom: Add ipq6018 apcs compatible
Date:   Sun, 24 May 2020 15:34:45 +0530
Message-Id: <1590314686-11749-8-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590314686-11749-1-git-send-email-sivaprak@codeaurora.org>
References: <1590314686-11749-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm ipq6018 has apcs block, add compatible for the same.
Also, the apcs provides a clock controller functionality similar
to msm8916 but the clock driver is different.

Create a child platform device based on the apcs compatible for the
clock controller functionality.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
[V5]
 * Addressed Bjorn's review comments
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index eeebafd..db3f9518 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -45,6 +45,13 @@ static const struct mbox_chan_ops qcom_apcs_ipc_ops = {
 	.send_data = qcom_apcs_ipc_send_data,
 };
 
+static const struct of_device_id apcs_clk_match_table[] = {
+	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = "qcom,apss-ipq6018-clk", },
+	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = "qcom-apcs-msm8916-clk", },
+	{ .compatible = "qcom,qcs404-apcs-apps-global",  .data = "qcom-apcs-msm8916-clk", },
+	{}
+};
+
 static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 {
 	struct qcom_apcs_ipc *apcs;
@@ -54,11 +61,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	void __iomem *base;
 	unsigned long i;
 	int ret;
-	const struct of_device_id apcs_clk_match_table[] = {
-		{ .compatible = "qcom,msm8916-apcs-kpss-global", },
-		{ .compatible = "qcom,qcs404-apcs-apps-global", },
-		{}
-	};
+	const struct of_device_id *clk_device;
 
 	apcs = devm_kzalloc(&pdev->dev, sizeof(*apcs), GFP_KERNEL);
 	if (!apcs)
@@ -93,11 +96,12 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (of_match_device(apcs_clk_match_table, &pdev->dev)) {
+	clk_device = of_match_device(apcs_clk_match_table, &pdev->dev);
+	if (clk_device) {
 		apcs->clk = platform_device_register_data(&pdev->dev,
-							  "qcom-apcs-msm8916-clk",
-							  PLATFORM_DEVID_NONE,
-							  NULL, 0);
+							clk_device->data,
+							PLATFORM_DEVID_NONE,
+							NULL, 0);
 		if (IS_ERR(apcs->clk))
 			dev_err(&pdev->dev, "failed to register APCS clk\n");
 	}
@@ -126,6 +130,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,sc7180-apss-shared", .data = (void *)12 },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
 	{ .compatible = "qcom,sm8150-apss-shared", .data = (void *)12 },
+	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = (void *)8 },
 	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = (void *)8 },
 	{}
 };
-- 
2.7.4

