Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D39C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD2E20780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="j9Imn/E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgDHNsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:48:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:39961 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgDHNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:48:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586353679; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=SgU4rKSGD2dwYYxSBKEWf1uzpYlsHOnUpLC8NfOEvNM=; b=j9Imn/E4rBGwDbBXACwSzngVypCu7FyDIGdJZPymzW4MHB/EOJ0rqI0AN8gxgzs/G0gUOBp5
 DVM+A/XWNX4dT2JNnBc8xGa+ZeHXWOQTQTUbUdSO0BZE2Stz9DLBvAURb8/CMHXmvEVxlhO9
 RKL+wQdI+5wm1PFhthi1h6fJ36A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8dd60f.7f1044917e68-smtp-out-n04;
 Wed, 08 Apr 2020 13:47:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA952C433F2; Wed,  8 Apr 2020 13:47:57 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16FF9C433F2;
        Wed,  8 Apr 2020 13:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16FF9C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 12/21] arm64: dts: sc7180: Add DSI and MDP OPP tables and power-domains
Date:   Wed,  8 Apr 2020 19:16:38 +0530
Message-Id: <1586353607-32222-13-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP tables for DSI and MDP based on the perf state/clk
requirements, and add the power-domains property to specify the
scalable power domain.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index efba600..db5b3b3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1581,6 +1581,49 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		mdp_opp_table: mdp-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+
+			opp-345000000 {
+				opp-hz = /bits/ 64 <345000000>;
+				required-opps = <&rpmhpd_opp_svs_l1>;
+			};
+
+			opp-460000000 {
+				opp-hz = /bits/ 64 <460000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
+
+		dsi_opp_table: dsi-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-187500000 {
+				opp-hz = /bits/ 64 <187500000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+
+			opp-358000000 {
+				opp-hz = /bits/ 64 <358000000>;
+				required-opps = <&rpmhpd_opp_svs_l1>;
+			};
+		};
+
 		mdss: mdss@ae00000 {
 			compatible = "qcom,sc7180-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
@@ -1626,6 +1669,8 @@
 						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <300000000>,
 						       <19200000>;
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd SC7180_CX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
@@ -1666,6 +1711,9 @@
 					      "iface",
 					      "bus";
 
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SC7180_CX>;
+
 				phys = <&dsi_phy>;
 				phy-names = "dsi";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
