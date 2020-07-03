Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E052073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Q7FuNIKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGCJpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:45:06 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37982 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgGCJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:45:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593769505; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=dl0rgC/HhlVxkyXbeJ+jwvTvXNECw4L3SLbh6WDhKSM=; b=Q7FuNIKP5qBhj0LgjL9N2FHYXZmPOTuhxPIrAIBgfbmMWPdKoCn6l2YaULD3fwXYRmuf+VxU
 bYneOibvk9mBAxWLllrAxlmpW5J+YXnH8jlNcNMN8SwrKkwWe6uQwU+55O7ONw4gvpaExIOJ
 GAqMMHxcBHfAuifA4ddi7c9R/X0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5efefe0d567385e8e707101c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 09:44:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 950E2C433AF; Fri,  3 Jul 2020 09:44:44 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9747C433AD;
        Fri,  3 Jul 2020 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9747C433AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 3/3] arm64: dts: sc7180: Add qspi opps and power-domains
Date:   Fri,  3 Jul 2020 15:11:33 +0530
Message-Id: <1593769293-6354-4-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
References: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domain supporting performance state and the corresponding
OPP tables for the qspi device on sc7180

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 2be81a2..34a6d83 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2407,6 +2407,25 @@
 			status = "disabled";
 		};
 
+		qspi_opp_table: qspi-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-75000000 {
+				opp-hz = /bits/ 64 <75000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-150000000 {
+				opp-hz = /bits/ 64 <150000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
+
 		qspi: spi@88dc000 {
 			compatible = "qcom,qspi-v1";
 			reg = <0 0x088dc000 0 0x600>;
@@ -2419,6 +2438,8 @@
 			interconnects = <&gem_noc MASTER_APPSS_PROC
 					&config_noc SLAVE_QSPI_0>;
 			interconnect-names = "qspi-config";
+			power-domains = <&rpmhpd SC7180_CX>;
+			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";
 		};
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

