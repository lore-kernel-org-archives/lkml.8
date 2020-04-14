Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06235C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39CC2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404464AbgDNDOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:14:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54860 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404224AbgDNDO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:14:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C1F54200286;
        Tue, 14 Apr 2020 05:14:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6255C200275;
        Tue, 14 Apr 2020 05:14:24 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 078564028B;
        Tue, 14 Apr 2020 11:14:20 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [RESEND 1/2] ls1043ardb: add qe node to ls1043ardb
Date:   Tue, 14 Apr 2020 11:10:28 +0800
Message-Id: <20200414031029.37879-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 16 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    | 66 +++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 4223a23..96e87ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -96,6 +96,22 @@
 	};
 };
 
+&uqe {
+	ucc_hdlc: ucc@2000 {
+		compatible = "fsl,ucc-hdlc";
+		rx-clock-name = "clk8";
+		tx-clock-name = "clk9";
+		fsl,rx-sync-clock = "rsync_pin";
+		fsl,tx-sync-clock = "tsync_pin";
+		fsl,tx-timeslot-mask = <0xfffffffe>;
+		fsl,rx-timeslot-mask = <0xfffffffe>;
+		fsl,tdm-framer-type = "e1";
+		fsl,tdm-id = <0>;
+		fsl,siram-entry-id = <0>;
+		fsl,tdm-interface;
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index c084c7a4..a6f2b15 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -525,6 +525,72 @@
 			#interrupt-cells = <2>;
 		};
 
+		uqe: uqe@2400000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "qe";
+			compatible = "fsl,qe", "simple-bus";
+			ranges = <0x0 0x0 0x2400000 0x40000>;
+			reg = <0x0 0x2400000 0x0 0x480>;
+			brg-frequency = <100000000>;
+			bus-frequency = <200000000>;
+
+			fsl,qe-num-riscs = <1>;
+			fsl,qe-num-snums = <28>;
+
+			qeic: qeic@80 {
+				compatible = "fsl,qe-ic";
+				reg = <0x80 0x80>;
+				#address-cells = <0>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <0 77 0x04 0 77 0x04>;
+			};
+
+			si1: si@700 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,ls1043-qe-si",
+						"fsl,t1040-qe-si";
+				reg = <0x700 0x80>;
+			};
+
+			siram1: siram@1000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,ls1043-qe-siram",
+						"fsl,t1040-qe-siram";
+				reg = <0x1000 0x800>;
+			};
+
+			ucc@2000 {
+				cell-index = <1>;
+				reg = <0x2000 0x200>;
+				interrupts = <32>;
+				interrupt-parent = <&qeic>;
+			};
+
+			ucc@2200 {
+				cell-index = <3>;
+				reg = <0x2200 0x200>;
+				interrupts = <34>;
+				interrupt-parent = <&qeic>;
+			};
+
+			muram@10000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-muram", "fsl,cpm-muram";
+				ranges = <0x0 0x10000 0x6000>;
+
+				data-only@0 {
+					compatible = "fsl,qe-muram-data",
+					"fsl,cpm-muram-data";
+					reg = <0x0 0x6000>;
+				};
+			};
+		};
+
 		lpuart0: serial@2950000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;
-- 
2.9.5

