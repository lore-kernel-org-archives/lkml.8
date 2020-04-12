Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E68C2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD0D20732
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgDLJeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:34:03 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59238 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgDLJdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:33:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CEBD820151D;
        Sun, 12 Apr 2020 11:33:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EBF3201097;
        Sun, 12 Apr 2020 11:33:50 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 89ADA402FB;
        Sun, 12 Apr 2020 17:33:45 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, ran.wang_1@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: [RESEND,v1 3/4] arm64: dts: ls1012a/ls1043a/ls1046a/ls1088a/ls208xa: add ftm_alarm0 node
Date:   Sun, 12 Apr 2020 17:29:55 +0800
Message-Id: <20200412092956.27859-3-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412092956.27859-1-biwen.li@oss.nxp.com>
References: <20200412092956.27859-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

The patch adds ftm_alarm0 DT node
	- add new rcpm node
	- add ftm_alarm0 node
	- aliases ftm_alarm0 as rtc1

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 14 ++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 337919366dc8..ab8b19f4d750 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -22,6 +22,7 @@
 		rtic-c = &rtic_c;
 		rtic-d = &rtic_d;
 		sec-mon = &sec_mon;
+		rtc1 = &ftm_alarm0;
 	};
 
 	cpus {
@@ -499,6 +500,20 @@
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		rcpm: rcpm@1ee2140 {
+			compatible = "fsl,ls1012a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1ee2140 0x0 0x4>;
+			#fsl,rcpm-wakeup-cells = <1>;
+		};
+
+		ftm_alarm0: timer@29d0000 {
+			compatible = "fsl,ls1012a-ftm-alarm";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x20000>;
+			interrupts = <0 86 0x4>;
+			big-endian;
+		};
 	};
 
 	firmware {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index c084c7a4b6a6..45456aa9d27b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -27,6 +27,7 @@
 		ethernet4 = &enet4;
 		ethernet5 = &enet5;
 		ethernet6 = &enet6;
+		rtc1 = &ftm_alarm0;
 	};
 
 	cpus {
@@ -764,6 +765,19 @@
 			big-endian;
 		};
 
+		rcpm: rcpm@1ee2140 {
+			compatible = "fsl,ls1043a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1ee2140 0x0 0x4>;
+			#fsl,rcpm-wakeup-cells = <1>;
+		};
+
+		ftm_alarm0: timer@29d0000 {
+			compatible = "fsl,ls1043a-ftm-alarm";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x20000>;
+			interrupts = <0 86 0x4>;
+			big-endian;
+		};
 	};
 
 	firmware {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index d4c1da3d4bde..2a34cf1bd6d6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -28,6 +28,7 @@
 		ethernet5 = &enet5;
 		ethernet6 = &enet6;
 		ethernet7 = &enet7;
+		rtc1 = &ftm_alarm0;
 	};
 
 	cpus {
@@ -765,6 +766,20 @@
 			queue-sizes = <64 64>;
 			big-endian;
 		};
+
+		rcpm: rcpm@1ee2140 {
+			compatible = "fsl,ls1046a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1ee2140 0x0 0x4>;
+			#fsl,rcpm-wakeup-cells = <1>;
+		};
+
+		ftm_alarm0: timer@29d0000 {
+			compatible = "fsl,ls1046a-ftm-alarm";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x20000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
+		};
 	};
 
 	reserved-memory {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 594566265e3d..bd8528f224b3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -18,6 +18,7 @@
 
 	aliases {
 		crypto = &crypto;
+		rtc1 = &ftm_alarm0;
 	};
 
 	cpus {
@@ -777,6 +778,19 @@
 				};
 			};
 		};
+
+		rcpm: rcpm@1e34040 {
+			compatible = "fsl,ls1088a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1e34040 0x0 0x18>;
+			#fsl,rcpm-wakeup-cells = <6>;
+		};
+
+		ftm_alarm0: timer@2800000 {
+			compatible = "fsl,ls1088a-ftm-alarm";
+			reg = <0x0 0x2800000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0>;
+			interrupts = <0 44 4>;
+		};
 	};
 
 	firmware {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f96d06da96be..0e06b0e12cd3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -24,6 +24,7 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		serial3 = &serial3;
+		rtc1 = &ftm_alarm0;
 	};
 
 	cpu: cpus {
@@ -759,6 +760,19 @@
 			reg = <0x0 0x04000000 0x0 0x01000000>;
 			interrupts = <0 12 4>;
 		};
+
+		rcpm: rcpm@1e34040 {
+			compatible = "fsl,ls208xa-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1e34040 0x0 0x18>;
+			#fsl,rcpm-wakeup-cells = <6>;
+		};
+
+		ftm_alarm0: timer@2800000 {
+			compatible = "fsl,ls208xa-ftm-alarm";
+			reg = <0x0 0x2800000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0>;
+			interrupts = <0 44 4>;
+		};
 	};
 
 	ddr1: memory-controller@1080000 {
-- 
2.17.1

