Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F73C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67A62087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBDNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:21:30 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:7394 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBDNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:21:29 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Feb 2020 18:48:35 +0530
Received: from pillair-linux.qualcomm.com ([10.204.116.193])
  by ironmsg02-blr.qualcomm.com with ESMTP; 04 Feb 2020 18:48:26 +0530
Received: by pillair-linux.qualcomm.com (Postfix, from userid 452944)
        id C315A3963; Tue,  4 Feb 2020 18:48:24 +0530 (IST)
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v6] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module device node
Date:   Tue,  4 Feb 2020 18:48:20 +0530
Message-Id: <1580822300-4491-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for the ath10k SNOC platform driver probe
and add resources required for WCN3990 on sc7180 soc.

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 388f50a..167f68ac 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -287,6 +287,11 @@
 	vdda-pll-supply = <&vreg_l4a_0p8>;
 };
 
+&wifi {
+	status = "okay";
+	qcom,msa-fixed-perm;
+};
+
 /* PINCTRL - additions to nodes defined in sc7180.dtsi */
 
 &qspi_clk {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 8011c5f..e3e8610 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -75,6 +75,11 @@
 			reg = <0x0 0x80900000 0x0 0x200000>;
 			no-map;
 		};
+
+		wlan_fw_mem: memory@93900000 {
+			reg = <0 0x93900000 0 0x200000>;
+			no-map;
+		};
 	};
 
 	cpus {
@@ -1490,6 +1495,28 @@
 
 			#freq-domain-cells = <1>;
 		};
+
+		wifi: wifi@18800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0 0x18800000 0 0x800000>;
+			reg-names = "membase";
+			iommus = <&apps_smmu 0xc0 0x1>;
+			interrupts =
+				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH /* CE0 */ >,
+				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH /* CE1 */ >,
+				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH /* CE2 */ >,
+				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH /* CE3 */ >,
+				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH /* CE4 */ >,
+				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH /* CE5 */ >,
+				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH /* CE6 */ >,
+				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH /* CE7 */ >,
+				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH /* CE8 */ >,
+				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH /* CE9 */ >,
+				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10 */>,
+				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11 */>;
+			memory-region = <&wlan_fw_mem>;
+			status = "disabled";
+		};
 	};
 
 	thermal-zones {
-- 
2.7.4

