Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4CC20747
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IoSraQx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgGBLKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:10:13 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20080 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728605AbgGBLKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:10:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593688208; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AS7RKTrJyz8Bs8XYK2abIazfD8EKpRKD3viZRHhzjlQ=; b=IoSraQx8yXMgcfprY+3cVMYn4BHVtvSyYiOP43HeV7Jc2xVKZXxr+VbIKL0zfJwAM/KYKYrn
 2hWX+chM/Yg13S3DQwxb9xk/zdqww0dwI+ukW4iKbdMzm4ZbK3hD1UJ7lLU4WAwnPk1pSdm8
 RIUsS/dvU26aJlix0bnEu/179nI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-east-1.postgun.com with SMTP id
 5efdc086a6e154319f818e20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 11:09:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDA94C43395; Thu,  2 Jul 2020 11:09:57 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38460C43391;
        Thu,  2 Jul 2020 11:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38460C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 3/4] arm64: dts: sdm845: Add DSI and MDP OPP tables and power-domains
Date:   Thu,  2 Jul 2020 16:39:10 +0530
Message-Id: <1593688151-22616-4-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593688151-22616-1-git-send-email-rnayak@codeaurora.org>
References: <1593688151-22616-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP tables for DSI and MDP based on the perf state/clk
requirements, and add the power-domains property to specify the
scalable power domain.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8eb5a31..b6afeb2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3296,6 +3296,35 @@
 			#power-domain-cells = <1>;
 		};
 
+		dsi_opp_table: dsi-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-19200000 {
+				opp-hz = /bits/ 64 <19200000>;
+				required-opps = <&rpmhpd_opp_min_svs>;
+			};
+
+			opp-180000000 {
+				opp-hz = /bits/ 64 <180000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-275000000 {
+				opp-hz = /bits/ 64 <275000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+
+			opp-328580000 {
+				opp-hz = /bits/ 64 <328580000>;
+				required-opps = <&rpmhpd_opp_svs_l1>;
+			};
+
+			opp-358000000 {
+				opp-hz = /bits/ 64 <358000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
+
 		mdss: mdss@ae00000 {
 			compatible = "qcom,sdm845-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
@@ -3340,6 +3369,8 @@
 						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <300000000>,
 						       <19200000>;
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
@@ -3364,6 +3395,30 @@
 						};
 					};
 				};
+
+				mdp_opp_table: mdp-opp-table {
+					compatible = "operating-points-v2";
+
+					opp-19200000 {
+						opp-hz = /bits/ 64 <19200000>;
+						required-opps = <&rpmhpd_opp_min_svs>;
+					};
+
+					opp-171428571 {
+						opp-hz = /bits/ 64 <171428571>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-344000000 {
+						opp-hz = /bits/ 64 <344000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-430000000 {
+						opp-hz = /bits/ 64 <430000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
 			};
 
 			dsi0: dsi@ae94000 {
@@ -3386,6 +3441,8 @@
 					      "core",
 					      "iface",
 					      "bus";
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
 
 				phys = <&dsi0_phy>;
 				phy-names = "dsi";
@@ -3450,6 +3507,8 @@
 					      "core",
 					      "iface",
 					      "bus";
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
 
 				phys = <&dsi1_phy>;
 				phy-names = "dsi";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

