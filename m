Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB7C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C8221D79
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgD2PWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:22:42 -0400
Received: from lists.gateworks.com ([108.161.130.12]:55540 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgD2PWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:22:42 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jToa1-0006N5-QF; Wed, 29 Apr 2020 15:24:57 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] ARM: dts: gw552x: add USB OTG support
Date:   Wed, 29 Apr 2020 08:22:35 -0700
Message-Id: <1588173755-18045-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587748215-9587-1-git-send-email-tharvey@gateworks.com>
References: <1587748215-9587-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW552x-B board revision adds USB OTG support.

Enable the device-tree node and configure the OTG_ID pin.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index dc646b7..bb35971 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -258,6 +258,14 @@
 	status = "okay";
 };
 
+&usbotg {
+	vbus-supply = <&reg_5p0v>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
 &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
@@ -359,6 +367,12 @@
 		>;
 	};
 
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x13059
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
-- 
2.7.4

