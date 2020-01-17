Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C7C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D73A2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="c7prnGGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAQNvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:51:53 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:58236 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728820AbgAQNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:51:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579269111; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jOQ2AiNK0PTdImO2J+Y0U8b21UxBofdNZ88zGFoed5o=; b=c7prnGGMzHTwzEEq92erFZv06uWq0K9JFs77NOcpT0DARRz+27Byq8GIBqnlwpDgWxUuss1E
 QpHqqXnf+6eWPPt0lEBWo7QHYLOtUGq6xsJOzPXJYW6AVVYfIc1zMGzn9Zs9gSjiQzDv6A7m
 /TLxtInRwZQs/0MhEA//5cZVeZs=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e21bbf4.7efc141cc5a8-smtp-out-n01;
 Fri, 17 Jan 2020 13:51:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AAC46C447B8; Fri, 17 Jan 2020 13:51:48 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A311C43383;
        Fri, 17 Jan 2020 13:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A311C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        p.zabel@pengutronix.de
Cc:     ohad@wizery.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/4] remoteproc: qcom: q6v5-mss: Use regmap_read_poll_timeout
Date:   Fri, 17 Jan 2020 19:21:27 +0530
Message-Id: <20200117135130.3605-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200117135130.3605-1-sibis@codeaurora.org>
References: <20200117135130.3605-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the loop for HALT_ACK detection with regmap_read_poll_timeout.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 51f451311f5fc..f20b39c6ff0ed 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -73,6 +73,7 @@
 #define NAV_AXI_IDLE_BIT		BIT(2)
 
 #define HALT_ACK_TIMEOUT_MS		100
+#define NAV_HALT_ACK_TIMEOUT_US		200
 
 /* QDSP6SS_RESET */
 #define Q6SS_STOP_CORE			BIT(0)
@@ -746,7 +747,6 @@ static void q6v5proc_halt_nav_axi_port(struct q6v5 *qproc,
 				       struct regmap *halt_map,
 				       u32 offset)
 {
-	unsigned long timeout;
 	unsigned int val;
 	int ret;
 
@@ -760,15 +760,11 @@ static void q6v5proc_halt_nav_axi_port(struct q6v5 *qproc,
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
+	ret = regmap_read_poll_timeout(halt_map, offset, val,
+				       (val & NAV_AXI_HALTACK_BIT),
+				       5, NAV_HALT_ACK_TIMEOUT_US);
+	if (ret)
+		dev_err(qproc->dev, "nav halt ack timeout\n");
 
 	ret = regmap_read(halt_map, offset, &val);
 	if (ret || !(val & NAV_AXI_IDLE_BIT))
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
