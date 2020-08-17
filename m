Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E316C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B5D207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NjM2tnQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHQIMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:12:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19636 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgHQIMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:12:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597651936; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=eI34u/iSchtGSOGXnguCsZq4UgsFfKNHCgVA8utOJCo=; b=NjM2tnQdD/tKlBFpNT6fFAW9cz0TEnGtXAhz5oe5TMiLfev2uneuRKA1wlIIi0YMQpqReH8T
 TlAn91TEgyHk88iBg4VlcxKDDhKd25hbulsPFGKRWc0l/eclrUbDLZSHgsWcPJaGO+as8zOD
 7fYm2CE4nM6wfSvt2eu8RNE3HH0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3a3bd791f8def8b28f2847 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 08:12:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31CAAC4344D; Mon, 17 Aug 2020 08:12:05 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0B33C43449;
        Mon, 17 Aug 2020 08:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0B33C43449
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] soc: qcom: llcc: Support chipsets that can write to llcc registers
Date:   Mon, 17 Aug 2020 13:41:38 +0530
Message-Id: <20200817081138.6755-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

Older chipsets may not be allowed to configure certain LLCC registers
as that is handled by the secure side software. However, this is not
the case for newer chipsets and they must configure these registers
according to the contents of the SCT table, while keeping in mind that
older targets may not have these capabilities. So add support to allow
such configuration of registers to enable capacity based allocation
and power collapse retention for capable chipsets.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
(sai: use table instead of dt property and minor commit msg change)
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/soc/qcom/llcc-qcom.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 429b5a60a1ba..20619d15ecba 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -45,6 +45,9 @@
 #define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
 #define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
 
+#define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21F00
+#define LLCC_TRP_PCB_ACT              0x21F04
+
 #define BANK_OFFSET_STRIDE	      0x80000
 
 /**
@@ -318,6 +321,11 @@ size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
 }
 EXPORT_SYMBOL_GPL(llcc_get_slice_size);
 
+static const struct of_device_id qcom_llcc_configure_of_match[] = {
+	{ .compatible = "qcom,sc7180-llcc" },
+	{ }
+};
+
 static int qcom_llcc_cfg_program(struct platform_device *pdev)
 {
 	int i;
@@ -327,13 +335,18 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
 	u32 attr0_val;
 	u32 max_cap_cacheline;
 	u32 sz;
+	u32 disable_cap_alloc = 0, retain_pc = 0;
 	int ret = 0;
 	const struct llcc_slice_config *llcc_table;
 	struct llcc_slice_desc desc;
+	const struct of_device_id *llcc_configure;
+	const struct device_node *np = dev_of_node(&pdev->dev);
 
 	sz = drv_data->cfg_size;
 	llcc_table = drv_data->cfg;
 
+	llcc_configure = of_match_node(qcom_llcc_configure_of_match, np);
+
 	for (i = 0; i < sz; i++) {
 		attr1_cfg = LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
 		attr0_cfg = LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
@@ -369,6 +382,21 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
 					attr0_val);
 		if (ret)
 			return ret;
+
+		if (llcc_configure) {
+			disable_cap_alloc |= llcc_table[i].dis_cap_alloc << llcc_table[i].slice_id;
+			ret = regmap_write(drv_data->bcast_regmap,
+						LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
+			if (ret)
+				return ret;
+
+			retain_pc |= llcc_table[i].retain_on_pc << llcc_table[i].slice_id;
+			ret = regmap_write(drv_data->bcast_regmap,
+						LLCC_TRP_PCB_ACT, retain_pc);
+			if (ret)
+				return ret;
+		}
+
 		if (llcc_table[i].activate_on_init) {
 			desc.slice_id = llcc_table[i].slice_id;
 			ret = llcc_slice_activate(&desc);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

