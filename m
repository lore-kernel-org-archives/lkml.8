Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9336C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C92421927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="khya/urK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBFN4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:56:14 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:21936 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbgBFN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:56:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580997373; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=mW67z5fJQUs/2JR6p4GaeWdEZ1YlpNpt/lb6jF4izcY=; b=khya/urK19RhiOaCQKkA6MNV6jZgI3ySRIUHKWhix6iaqAz19RBJpP6P1RZ2zcR2nfpkz1MW
 w7SrOI/WlcIszVdf1RZXpv8cpcO9b/HbTSz+Y5ONvsKX2s3mmdmpcPTSln2qxNfeKXsk5p3d
 ZufajrnEI5t7WJ2Vw+K/ARNRPOM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3c1afa.7ff404caeed8-smtp-out-n03;
 Thu, 06 Feb 2020 13:56:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB0E1C43383; Thu,  6 Feb 2020 13:56:10 +0000 (UTC)
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5C15C447A0;
        Thu,  6 Feb 2020 13:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5C15C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     rnayak@codeaurora.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V3 2/2] mfd: qcom-spmi-pmic: Add support for pm6150 and pm6150l
Date:   Thu,  6 Feb 2020 19:25:27 +0530
Message-Id: <1580997328-16365-2-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580997328-16365-1-git-send-email-kgunda@codeaurora.org>
References: <1580997328-16365-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles and PMIC ids for pm6150 and pm6150l PMICs
found on SC7180 based platforms

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 ++
 drivers/mfd/qcom-spmi-pmic.c                              | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index affc169..36f0795 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -46,6 +46,8 @@ properties:
       - qcom,pm8998
       - qcom,pmi8998
       - qcom,pm8005
+      - qcom,pm6150
+      - qcom,pm6150l
       - qcom,spmi-pmic
 
   reg:
diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 1df1a27..5bfeec8 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -36,6 +36,8 @@
 #define PM8998_SUBTYPE		0x14
 #define PMI8998_SUBTYPE		0x15
 #define PM8005_SUBTYPE		0x18
+#define PM6150L_SUBTYPE		0x1F
+#define PM6150_SUBTYPE		0x28
 
 static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,spmi-pmic", .data = (void *)COMMON_SUBTYPE },
@@ -57,6 +59,8 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,pm8998",    .data = (void *)PM8998_SUBTYPE },
 	{ .compatible = "qcom,pmi8998",   .data = (void *)PMI8998_SUBTYPE },
 	{ .compatible = "qcom,pm8005",    .data = (void *)PM8005_SUBTYPE },
+	{ .compatible = "qcom,pm6150l",   .data = (void *)PM6150L_SUBTYPE },
+	{ .compatible = "qcom,pm6150",    .data = (void *)PM6150_SUBTYPE },
 	{ }
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
