Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB66206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgFHJhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:37:39 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37165 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729167AbgFHJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:37:36 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2020 02:37:33 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 08 Jun 2020 02:37:31 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id B47E921812; Mon,  8 Jun 2020 15:07:29 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] mailbox: qcom: Add ipq6018 apcs compatible
Date:   Mon,  8 Jun 2020 15:07:27 +0530
Message-Id: <1591609047-29995-5-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591609047-29995-1-git-send-email-sivaprak@codeaurora.org>
References: <1591609047-29995-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm ipq6018 has apcs block, add compatible for the same. Also,
the ipq6018 apcs provides a clock functionality similar to msm8916 but
the clock driver is different.

Create a child device based on the apcs compatible for the clock
controller functionality.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 49eebb5..cec34f0 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -29,6 +29,10 @@ struct qcom_apcs_ipc_data {
 	char *clk_name;
 };
 
+static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
+	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
+};
+
 static const struct qcom_apcs_ipc_data ipq8074_apcs_data = {
 	.offset = 8, .clk_name = NULL
 };
@@ -139,6 +143,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 
 /* .data is the offset of the ipc register within the global block */
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
+	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq8074_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
-- 
2.7.4

