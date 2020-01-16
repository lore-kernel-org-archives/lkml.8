Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C96C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7532E20661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="isUQiE+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391780AbgAPXkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:40:19 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:19956 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391680AbgAPXkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:40:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579218014; h=References: In-Reply-To: Message-Id: Date:
 Subject: To: From: Sender;
 bh=LDZlibC7V5vrLNV2qPZ0WAjcYgQQq7dFFZfd1WhDPq8=; b=isUQiE+G+ceSWGsGfr06wWw8WKTGhfoaMCZqYRYchrDSxD8tJO9XQpH7OSDR3dHxdy+R5ndo
 WUFGdUYcvQmsv9qR3Z2nZagFtespikxNkRqxrBJn5UlKvFf0Nil6NneHdr1qJQI8fqWbMksj
 +u+3LPgaiR1Z5oaCN0sDWU9N+60=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e20f45c.7faae9450e30-smtp-out-n02;
 Thu, 16 Jan 2020 23:40:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F1DDC433CB; Thu, 16 Jan 2020 23:40:12 +0000 (UTC)
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgutta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC1DAC447A1;
        Thu, 16 Jan 2020 23:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC1DAC447A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, vinod.koul@linaro.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, tdas@codeaurora.org,
        vnkgutta@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: clock: Add RPMHCC bindings for SM8250
Date:   Thu, 16 Jan 2020 15:39:48 -0800
Message-Id: <1579217994-22219-2-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

Add bindings and update documentation for clock rpmh driver on SM8250.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 include/dt-bindings/clock/qcom,rpmh.h                    | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 94e2f14..21398d1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,sc7180-rpmh-clk
       - qcom,sdm845-rpmh-clk
       - qcom,sm8150-rpmh-clk
+      - qcom,sm8250-rpmh-clk
 
   clocks:
     maxItems: 1
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index edcab3f..2e6c54e 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+/* Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved. */
 
 
 #ifndef _DT_BINDINGS_CLK_MSM_RPMH_H
@@ -19,5 +19,7 @@
 #define RPMH_RF_CLK3				10
 #define RPMH_RF_CLK3_A				11
 #define RPMH_IPA_CLK				12
+#define RPMH_LN_BB_CLK1				13
+#define RPMH_LN_BB_CLK1_A			14
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
