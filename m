Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06ADE205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgENBSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:18:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39022 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENBSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:18:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E9931A15F1;
        Thu, 14 May 2020 03:18:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 81F5F1A012E;
        Thu, 14 May 2020 03:18:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 70523402B4;
        Thu, 14 May 2020 09:18:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] ARM: dts: imx6qdl: Use nvmem interface to get fuse data
Date:   Thu, 14 May 2020 09:08:47 +0800
Message-Id: <1589418528-26410-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although ocotp clock is always ON for i.MX6QDL, OCOTP can be
accessed directly, but since i.MX6QDL nvmem interface is supported,
and fsl,tempmon-data is deprecated, use it instead of getting fuse
data by reading ocotp directly, this makes all i.MX6 SoCs aligned.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 98da446..1763c2b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -74,7 +74,8 @@
 		interrupt-parent = <&gpc>;
 		interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
 		fsl,tempmon = <&anatop>;
-		fsl,tempmon-data = <&ocotp>;
+		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+		nvmem-cell-names = "calib", "temp_grade";
 		clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 		#thermal-sensor-cells = <0>;
 	};
@@ -1171,6 +1172,14 @@
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
+
+				tempmon_calib: calib@38 {
+					reg = <0x38 4>;
+				};
+
+				tempmon_temp_grade: temp-grade@20 {
+					reg = <0x20 4>;
+				};
 			};
 
 			tzasc@21d0000 { /* TZASC1 */
-- 
2.7.4

