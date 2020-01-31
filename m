Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2096AC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E7E20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgAaIrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:47:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37277 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgAaIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:47:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so7730561wmf.2;
        Fri, 31 Jan 2020 00:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HyaBKxElmmkbij4csv64kln2w3uU/8uK5M/u+w6Ug8=;
        b=hvhge9uXQIzb97c6FEi8nhCGbfAoxBZyz1YpY74PQU/9f59jWigcXruzTKVSxHANNR
         N3L1EaZR71U36KMcmn/NvV1FQE/zblaJSykcCbkjs3F6C1Ras97xDIdthwwwKZoHKI0A
         o3+R4uayEE0s532b11lO6cB9W5UXjGtueO2vDC2mihF0TFsTZvFXe/fBuvB7HYVXbT/f
         sMUYk5mV+GbXyCs/6iIeAQfATga75JtmXs5MmuVjN2qXLmwQ4O+2DgXiqyXsS2VqHg0l
         jmEDjeopguk2BNudKPEnaMKR2Favl7VMrZcmSz6xWR3MU28ZcLQpJR9znXv6s0JgZcHn
         oqIQ==
X-Gm-Message-State: APjAAAW3qWHjn8H4HQx1tTbeEohCUbLr9b25KJ58giPmi6/rWVSl89fd
        meAaqpS/lZRnDyeyd84UyrXHfhIkpW8=
X-Google-Smtp-Source: APXvYqyDG0GpmJ9fE1LRLArRrCTwciMloxNp5gciCVnYB3j3IjoivEqkSuv+/IAYtnLTN0HRvXZ8Jg==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr10797173wmi.20.1580460111352;
        Fri, 31 Jan 2020 00:41:51 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:50 -0800 (PST)
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
Subject: [PATCH v3 02/12] ARM: dts: imx7d: cl-som-imx7: add phy-reset-gpios
Date:   Fri, 31 Jan 2020 08:36:28 +0000
Message-Id: <20200131083638.6118-2-git@andred.net>
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

According to the design team:
* reset input PHY0 is directly connected to the
  corresponding pin GPIO1_4 in the i.MX7
* reset for PHY1 is done using the gpio expander bit 4

While touching this area, also add a 'compatible'
to the phy to make it more clear what this is and
which driver handles this - an Ethernet phy attached
to mdio, handled by of_mdio.c

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 0d962e9fe83a..e0432a3aa36f 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -30,13 +30,14 @@
 
 &fec1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>;
+	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1phy>;
 	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
 			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
+	phy-reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	fsl,magic-packet;
 	status = "okay";
 
@@ -65,6 +66,7 @@
 	assigned-clock-rates = <0>, <100000000>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
+	phy-reset-gpios = <&pca9555 4 GPIO_ACTIVE_LOW>;
 	fsl,magic-packet;
 	status = "okay";
 };
@@ -264,3 +266,11 @@
 		>;
 	};
 };
+
+&iomuxc_lpsr {
+	pinctrl_enet1phy: enet1phygrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x34
+		>;
+	};
+};
-- 
2.23.0.rc1

