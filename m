Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D5AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D0822B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="PVmE6lXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbgGaMAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:00:35 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:47910 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732512AbgGaMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:00:35 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 911A3A371F;
        Fri, 31 Jul 2020 14:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1596196832;
        bh=JT9Xuochy69py6PoMl9VMEW5YN2VhH6Fy4LmrO6dsWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVmE6lXKVGZRIuxqTEHS2uOhpFqCCydAiElvsSjM5ZuZZeNyX0NQJTYYiJL0NEf9c
         GhVshAeKhxA6HV+/XDpcPa/oshM31J1azDoNnc/XqgJ6UXRhB5X5fQTJxO8yTDcdF3
         wCVcEIUMDw/4AnAz89GXVII9HI9jVwPqYvGDe+qo=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/3] =?UTF-8?q?ARM:=20dts:=20imx6dl-yapp4:=20Add=20Y=20Sof?= =?UTF-8?q?t=20IOTA=C2=A0Orion=20board?=
Date:   Fri, 31 Jul 2020 14:00:07 +0200
Message-Id: <1596196808-5067-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
References: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree for new variant of the Y Soft IOT appliance.
The board is based on Hydra with the following changes:

 - faster SoC (1GHz), 4GB RAM and 64GB eMMC
 - removed miniPCIe
 - removed Audio jack
 - removed uSD slot
 - removed RJ10 serial
 - HDMI replaced by USB host

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/imx6dl-yapp4-orion.dts | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-orion.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..eec0d61874a4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -482,6 +482,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-wandboard-revd1.dtb \
 	imx6dl-yapp4-draco.dtb \
 	imx6dl-yapp4-hydra.dtb \
+	imx6dl-yapp4-orion.dtb \
 	imx6dl-yapp4-ursa.dtb \
 	imx6q-apalis-eval.dtb \
 	imx6q-apalis-ixora.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-orion.dts b/arch/arm/boot/dts/imx6dl-yapp4-orion.dts
new file mode 100644
index 000000000000..0428720417ef
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-yapp4-orion.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2020 Y Soft Corporation, a.s.
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6dl-yapp4-common.dtsi"
+
+/ {
+	model = "Y Soft IOTA Orion i.MX6DualLite board";
+	compatible = "ysoft,imx6dl-yapp4-orion", "fsl,imx6dl";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0xf0000000>;
+	};
+};
+
+&gpio_oled {
+	status = "okay";
+};
+
+&leds {
+	status = "okay";
+};
+
+&oled {
+	status = "okay";
+};
+
+&reg_usb_h1_vbus {
+	status = "okay";
+};
+
+&touchkeys {
+	status = "okay";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
-- 
2.1.4

