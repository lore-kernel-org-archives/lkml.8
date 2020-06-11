Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C9CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF122078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgFKJss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:48:48 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:57411 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbgFKJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:48:38 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Jun 2020 15:18:26 +0530
Received: from c-rbokka-linux.qualcomm.com ([10.206.232.238])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Jun 2020 15:18:05 +0530
Received: by c-rbokka-linux.qualcomm.com (Postfix, from userid 203305)
        id 0C31F2CBB; Thu, 11 Jun 2020 15:18:04 +0530 (IST)
From:   Ravi Kumar Bokka <rbokka@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>
Subject: [RFC v2 3/3] arm64: dts: qcom: sc7180: Add qfprom-efuse
Date:   Thu, 11 Jun 2020 15:18:02 +0530
Message-Id: <1591868882-16553-4-git-send-email-rbokka@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree node for qfprom-efuse controller.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 4e9149d..2a9224e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -287,6 +287,10 @@
 	};
 };
 
+&qfprom {
+	vcc-supply = <&vreg_l11a_1p8>;
+};
+
 &qspi {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 31b9217..20f3480 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -498,9 +498,15 @@
 			#power-domain-cells = <1>;
 		};
 
-		qfprom@784000 {
+		qfprom: qfprom@780000 {
 			compatible = "qcom,qfprom";
-			reg = <0 0x00784000 0 0x8ff>;
+			reg = <0 0x00780000 0 0x7a0>,
+			      <0 0x00782000 0 0x100>,
+			      <0 0x00784000 0 0x8ff>;
+			reg-names = "raw", "conf", "corrected";
+			
+			clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
+			clock-names = "secclk";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

