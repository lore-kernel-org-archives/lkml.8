Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E3BC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1461120716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCLJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:56:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54646 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLJ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:56:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 855091A0F32;
        Thu, 12 Mar 2020 10:56:48 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 484341A0A59;
        Thu, 12 Mar 2020 10:56:43 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B71F1402D5;
        Thu, 12 Mar 2020 17:56:36 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: dts: imx7d: Add cpu1 supply
Date:   Thu, 12 Mar 2020 17:50:13 +0800
Message-Id: <1584006613-31623-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584006613-31623-1-git-send-email-Anson.Huang@nxp.com>
References: <1584006613-31623-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each cpu-core is supposed to list its supply separately, add
supply for cpu1.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++++
 arch/arm/boot/dts/imx7d-colibri.dtsi    | 4 ++++
 arch/arm/boot/dts/imx7d-nitrogen7.dts   | 4 ++++
 arch/arm/boot/dts/imx7d-sdb.dts         | 4 ++++
 arch/arm/boot/dts/imx7d-tqma7.dtsi      | 4 ++++
 5 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 89267cd..713483c 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -37,6 +37,10 @@
 	cpu-supply = <&sw1a_reg>;
 };
 
+&cpu1 {
+	cpu-supply = <&sw1a_reg>;
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index e2e327f..cae3299 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -50,6 +50,10 @@
 	};
 };
 
+&cpu1 {
+	cpu-supply = <&reg_DCDC2>;
+};
+
 &gpmi {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 6b4acea..e0751e6 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -121,6 +121,10 @@
 	cpu-supply = <&sw1a_reg>;
 };
 
+&cpu1 {
+	cpu-supply = <&sw1a_reg>;
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 869efbc..17cca8a 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -162,6 +162,10 @@
 	cpu-supply = <&sw1a_reg>;
 };
 
+&cpu1 {
+	cpu-supply = <&sw1a_reg>;
+};
+
 &ecspi3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
diff --git a/arch/arm/boot/dts/imx7d-tqma7.dtsi b/arch/arm/boot/dts/imx7d-tqma7.dtsi
index 8ad3048..598aed1 100644
--- a/arch/arm/boot/dts/imx7d-tqma7.dtsi
+++ b/arch/arm/boot/dts/imx7d-tqma7.dtsi
@@ -9,3 +9,7 @@
 
 #include "imx7d.dtsi"
 #include "imx7-tqma7.dtsi"
+
+&cpu1 {
+	cpu-supply = <&sw1a_reg>;
+};
-- 
2.7.4

