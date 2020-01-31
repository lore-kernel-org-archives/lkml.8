Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E11AC35246
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5D220705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgAaIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:47:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36816 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgAaIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:47:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7733339wma.1;
        Fri, 31 Jan 2020 00:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EkrQbHmytM/4HBLq09Tk0mO3BlMQ43f4QPGQu2sSZ8=;
        b=jdiYd+Pm+gm3OHGwtuxPRtDq5+uCjJlscbOd31mfYKHMvn4SC6ZI8HDlN8IUKpc4K7
         D8Li0YbHvxD7baWQVj1Y3E5PqYOwnM8Fy7BSmdIoEyntHjwXmfJD0yzLeOJy57jDDsrr
         kArFdVyw6vuHfaTY3rAXSTtmgCKSRDXfjwyVi8FgJ3tsVFe+RtBKgr6XuJxTC5doUKMI
         ni5U1didi/5H+VybrtUREuYwaAfJiKquG2N82QOqCEByBb/LljCsas4zOG3m9at1e6el
         YFskvKaajUJrt/EoaSHsyCOejF5oIciCMaDsUsThXANYvNlFVJYqJ8P676Lqjz66bQO3
         T9TQ==
X-Gm-Message-State: APjAAAUii7HxqaFTS8HJYo8klPeMyvmAeNBfbprKeV0NDXLzgI/ks/bA
        xAoIcwwMmKZT4WiVn7Z+L9uT4AuyOuU=
X-Google-Smtp-Source: APXvYqwu9LmExa87URoYI/cO7DwIY7BOw5a3ckxOgqG1pCcQbtNOFFpvqIq7xQjjsS1gxQqpBgRCJg==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr10564641wmf.93.1580460110332;
        Fri, 31 Jan 2020 00:41:50 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:49 -0800 (PST)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 01/12] ARM: dts: imx7d: cl-som-imx7 imx7d-sbc-imx7: move USB
Date:   Fri, 31 Jan 2020 08:36:27 +0000
Message-Id: <20200131083638.6118-1-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether and which USB port is enabled and how they
are powered is a function of the carrier board, not
of the SoM. Different carrier boards can have different
ports enabled / wired up, and power them differently;
so this should really move into the respective DTS.

Do so and update the USB power supply to reflect
the actual situation on the sbc-imx7 carrier board.

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 24 ------------------------
 arch/arm/boot/dts/imx7d-sbc-imx7.dts    | 13 +++++++++++++
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 7646284e13a7..0d962e9fe83a 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -22,15 +22,6 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
 	};
-
-	reg_usb_otg1_vbus: regulator-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
 };
 
 &cpu0 {
@@ -195,13 +186,6 @@
 	status = "okay";
 };
 
-&usbotg1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1>;
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -280,11 +264,3 @@
 		>;
 	};
 };
-
-&iomuxc_lpsr {
-	pinctrl_usbotg1: usbotg1grp {
-		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
index f8a868552707..aab646903de3 100644
--- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
@@ -15,6 +15,14 @@
 / {
 	model = "CompuLab SBC-iMX7";
 	compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
+
+	reg_usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &usdhc1 {
@@ -26,6 +34,11 @@
 	status = "okay";
 };
 
+&&usbotg1 {
+	vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-- 
2.23.0.rc1

