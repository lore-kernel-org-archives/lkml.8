Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E938C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83AB2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgGFIru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:47:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40682 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgGFIru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:47:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E6931A1687;
        Mon,  6 Jul 2020 10:47:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 79EFE1A05F7;
        Mon,  6 Jul 2020 10:47:45 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1D2D740296;
        Mon,  6 Jul 2020 16:47:42 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] ARM: dts: imx6qdl: only enable pcie in the pcie dts file
Date:   Mon,  6 Jul 2020 16:44:41 +0800
Message-Id: <1594025081-2353-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since iMX6Q/DL PCIe has the PM limitation (ERR005723 "PCIe PCIe does
not support L2 Power Down").
System suspend/resume would be broken by PCIe, if PCIe is enabled.
Only enable PCIe in the xxx-pcie.dts files to avoid the brokens when
other xxx.dtb files are used on sabresd and sabreauto boards.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/Makefile                  |  4 ++++
 arch/arm/boot/dts/imx6dl-sabreauto-pcie.dts | 12 ++++++++++++
 arch/arm/boot/dts/imx6dl-sabresd-pcie.dts   | 12 ++++++++++++
 arch/arm/boot/dts/imx6q-sabreauto-pcie.dts  | 12 ++++++++++++
 arch/arm/boot/dts/imx6q-sabresd-pcie.dts    | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi    |  4 ----
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi      |  1 -
 7 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-pcie.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-sabresd-pcie.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-pcie.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabresd-pcie.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6a1cac0bfc7..25fcd091f986 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -458,8 +458,10 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
 	imx6dl-sabreauto.dtb \
+	imx6dl-sabreauto-pcie.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
+	imx6dl-sabresd-pcie.dtb \
 	imx6dl-savageboard.dtb \
 	imx6dl-ts4900.dtb \
 	imx6dl-ts7970.dtb \
@@ -545,8 +547,10 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-pistachio.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
+	imx6q-sabreauto-pcie.dtb \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
+	imx6q-sabresd-pcie.dtb \
 	imx6q-savageboard.dtb \
 	imx6q-sbc6x.dtb \
 	imx6q-tbs2910.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-pcie.dts b/arch/arm/boot/dts/imx6dl-sabreauto-pcie.dts
new file mode 100644
index 000000000000..88fc15b1a9de
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreauto-pcie.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ */
+
+/dts-v1/;
+
+#include "imx6dl-sabreauto.dts"
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6dl-sabresd-pcie.dts b/arch/arm/boot/dts/imx6dl-sabresd-pcie.dts
new file mode 100644
index 000000000000..c57558c815d9
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabresd-pcie.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ */
+
+/dts-v1/;
+
+#include "imx6dl-sabresd.dts"
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabreauto-pcie.dts b/arch/arm/boot/dts/imx6q-sabreauto-pcie.dts
new file mode 100644
index 000000000000..769a2cf4a6ac
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabreauto-pcie.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ */
+
+/dts-v1/;
+
+#include "imx6q-sabreauto.dts"
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabresd-pcie.dts b/arch/arm/boot/dts/imx6q-sabresd-pcie.dts
new file mode 100644
index 000000000000..2ff88f6a1d52
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabresd-pcie.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ */
+
+/dts-v1/;
+
+#include "imx6q-sabresd.dts"
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index cf628465cd0a..30737e3b698a 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -805,10 +805,6 @@
 	status = "okay";
 };
 
-&pcie {
-	status = "okay";
-};
-
 &spdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spdif>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 28b35ccb3757..78ead45c748d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -725,7 +725,6 @@
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
-	status = "okay";
 };
 
 &pwm1 {
-- 
2.17.1

