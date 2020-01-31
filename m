Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2CC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63C120705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgAaIsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:48:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgAaIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:48:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so7707917wme.4;
        Fri, 31 Jan 2020 00:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dEBK2/0QEjcEIbTow6H8atvD57XckSzsqrktuuuwiQ=;
        b=iE1y3RWV6QWI2ssruPyBjM36XoczkGFjHbsAK0Y9paiW+gaFQBHH/jxSsIsLAoirYF
         rrkYwl2rFqusVLx0t5h3dtjthYzl69mfNc2AT+hcEHaFoSITKYuHtiuNfHvwybE8ige+
         zx7tBKDEZXncKMHWLI2JUQtigaqSQYDd6QPeXKDyeXnj6qcST8YugW6lELv1KbdLjWBe
         I7Lzjzj+iLRlblzpS2iGRjTSCdLEzTM+qYiPfXp6/DDxTg4JsJ+L86wlIluEj9AQ5h3Q
         NmpuMr8C2TMz2RmDHp3dvkAUvKFSy6eD6MwyIjZFJoWUrv4QOWi3u3bM0sZ6Q9dinoYO
         gkPQ==
X-Gm-Message-State: APjAAAU7CS6MbwWa3bizXyUTFUAcjJFzQrOg6OnzWrzZFWKMVFycCvz6
        ZgTzWnp8QnEtzWrprrmhMPfTG2F/Z/Q=
X-Google-Smtp-Source: APXvYqyHY3SsN8sdxcNTZKwuYJH0cgDW0nY1gVdu6YC/r1hZq5mTO/Ua3IXVS/iQwDDxxCzDvFMN6w==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr11106584wmb.155.1580460119746;
        Fri, 31 Jan 2020 00:41:59 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:59 -0800 (PST)
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
Subject: [PATCH v3 10/12] ARM: dts: imx7d: cl-som-imx7: add WiLink8 WLAN support
Date:   Fri, 31 Jan 2020 08:36:36 +0000
Message-Id: <20200131083638.6118-10-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200131083638.6118-1-git@andred.net>
References: <20200131083638.6118-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add / enable TI's WiLink8 WLAN module on SDIO2.

Notes:
* power is always enabled (because of bluetooth)
* the downstream delay of 70ms after power-on
  doesn't seem to reliably work, hence it was
  bumped to 700ms

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index a16cbb070a12..4cb36decef3d 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -28,6 +28,24 @@
 		compatible = "smsc,usb3503";
 		reset-gpios = <&pca9555 6 GPIO_ACTIVE_LOW>;
 	};
+
+	pwrseq_ti_wifi: ti-wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pca9555 0 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <700>;
+		/* 10μs during shutdown, but 60μs between two enables */
+		power-off-delay-us = "60";
+	};
+
+	reg_ti_wifi: regulator-ti-wifi {
+		compatible = "regulator-fixed";
+		regulator-name = "wilink-regulator";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca9555 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
 };
 
 &cpu0 {
@@ -232,6 +250,31 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	vmmc-supply = <&reg_ti_wifi>;
+	mmc-pwrseq = <&pwrseq_ti_wifi>;
+	non-removable;
+	cap-power-off-card;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_wlcore>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -308,6 +351,23 @@
 		>;
 	};
 
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x19
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
+		>;
+	};
+
+	pinctrl_usdhc2_wlcore: usdhc2wlcoregrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO15__GPIO1_IO15		0x34
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-- 
2.23.0.rc1

