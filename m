Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5003BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BFE24655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PUeVLlc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAWNM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:12:59 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:24453 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgAWNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:12:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579785178; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3ha1rS6O3ZwlH4JO8Y0j7JhpciqYdmBECeTyfGJObso=; b=PUeVLlc7bi6r+R5zEn4dXoSIT0zpzNweoyAd67DSzLlM22FjuJh6VHWeCwzVmuQJp8UsDcpc
 YEE20WB7cHt70a8wuZZ409xO1QrKCnEWHq484sTGlrmcAreqoJ8FDBt1OiRNR231IR/LTE1s
 1Cy2c7xQQp7yqOjjs+uy/XzCEjQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e299bd9.7f02ce420420-smtp-out-n02;
 Thu, 23 Jan 2020 13:12:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59AADC4479F; Thu, 23 Jan 2020 13:12:57 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7C6BC433CB;
        Thu, 23 Jan 2020 13:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7C6BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        p.zabel@pengutronix.de
Cc:     ohad@wizery.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 1/2] remoteproc: qcom: q6v5-mss: Use regmap_read_poll_timeout
Date:   Thu, 23 Jan 2020 18:42:35 +0530
Message-Id: <20200123131236.1078-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200123131236.1078-1-sibis@codeaurora.org>
References: <20200123131236.1078-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the loop for HALT_ACK detection with regmap_read_poll_timeout.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 899ed769a343b..89ab96c21a44a 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -72,7 +72,8 @@
 #define NAV_AXI_HALTACK_BIT		BIT(1)
 #define NAV_AXI_IDLE_BIT		BIT(2)
 
-#define HALT_ACK_TIMEOUT_MS		100
+#define HALT_ACK_TIMEOUT_US		100000
+#define NAV_HALT_ACK_TIMEOUT_US		200
 
 /* QDSP6SS_RESET */
 #define Q6SS_STOP_CORE			BIT(0)
@@ -716,7 +717,6 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
 				   struct regmap *halt_map,
 				   u32 offset)
 {
-	unsigned long timeout;
 	unsigned int val;
 	int ret;
 
@@ -729,14 +729,8 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
 	regmap_write(halt_map, offset + AXI_HALTREQ_REG, 1);
 
 	/* Wait for halt */
-	timeout = jiffies + msecs_to_jiffies(HALT_ACK_TIMEOUT_MS);
-	for (;;) {
-		ret = regmap_read(halt_map, offset + AXI_HALTACK_REG, &val);
-		if (ret || val || time_after(jiffies, timeout))
-			break;
-
-		msleep(1);
-	}
+	regmap_read_poll_timeout(halt_map, offset + AXI_HALTACK_REG, val,
+				 val, 1000, HALT_ACK_TIMEOUT_US);
 
 	ret = regmap_read(halt_map, offset + AXI_IDLE_REG, &val);
 	if (ret || !val)
@@ -750,7 +744,6 @@ static void q6v5proc_halt_nav_axi_port(struct q6v5 *qproc,
 				       struct regmap *halt_map,
 				       u32 offset)
 {
-	unsigned long timeout;
 	unsigned int val;
 	int ret;
 
@@ -764,15 +757,9 @@ static void q6v5proc_halt_nav_axi_port(struct q6v5 *qproc,
 			   NAV_AXI_HALTREQ_BIT);
 
 	/* Wait for halt ack*/
-	timeout = jiffies + msecs_to_jiffies(HALT_ACK_TIMEOUT_MS);
-	for (;;) {
-		ret = regmap_read(halt_map, offset, &val);
-		if (ret || (val & NAV_AXI_HALTACK_BIT) ||
-		    time_after(jiffies, timeout))
-			break;
-
-		udelay(5);
-	}
+	regmap_read_poll_timeout(halt_map, offset, val,
+				 (val & NAV_AXI_HALTACK_BIT),
+				 5, NAV_HALT_ACK_TIMEOUT_US);
 
 	ret = regmap_read(halt_map, offset, &val);
 	if (ret || !(val & NAV_AXI_IDLE_BIT))
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
