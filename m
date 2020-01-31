Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C493CC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CD520705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgAaIrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:47:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52943 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgAaIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:47:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so6961662wmc.2;
        Fri, 31 Jan 2020 00:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdNLZLbUZjioU3Z4lRpuQbaNIysXdv9lDzhe4Q5gJwU=;
        b=ex6PVFYBZmEDc+SC1Z2fH1XDxwSIt3sgXLQCwIJROjjZK9BFuAGjdjfnDuDRec0Qjx
         mtT96RuFtPtN/juBcvbaLfOU7svE0VXJqlvLrREV1T+ppDppHOWVjxQO6sK+58pYobhh
         VA5L1e1ZnkmTvtbb3qOpyRvgRv2U9ZzWg4uVb/w4SCgWxTGGm/sfNxFh/BxdMX2yTPWu
         BBHCHu8Go6iFgi1SC1y9Hc8sALxNF9U3adPTCSIZsnMWb5leNLb4XqoKuHXLQKTQ5d+V
         hZBAYLNPGnWCptrfgdn30FP+OSBx/RHnQVck2mpa73VMti6XfYFD3sYoHF/IcAl+LaiB
         /lAQ==
X-Gm-Message-State: APjAAAXMwZ9NUhAhbTo0bhNnmINVFuAuVtV+kVD582LPi2MOzBMN91yF
        pzZ7VJA9DbQ6wscXkYvX9KO6WwMIvo4=
X-Google-Smtp-Source: APXvYqwcnzQbFdcIMaQGA5ZuO128eq6F3wqKYN22ra3jP99Ay4uMroGsQRwG80xB0777PwhhtX7RWw==
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr10594687wmc.158.1580460116515;
        Fri, 31 Jan 2020 00:41:56 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:55 -0800 (PST)
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
Subject: [PATCH v3 07/12] ARM: dts: imx7d: cl-som-imx7: add/enable SPI flash on spi1
Date:   Fri, 31 Jan 2020 08:36:33 +0000
Message-Id: <20200131083638.6118-7-git@andred.net>
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

add/enable SPI flash on spi1 using the default vendor's
partition layout as per downstream kernel

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ca3c5d95d6c3..d4637a8ca223 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -28,6 +28,36 @@
 	cpu-supply = <&sw1a_reg>;
 };
 
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
+	cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+
+		partition@0 {
+			label = "uboot";
+			reg = <0x0 0xc0000>;
+		};
+
+		partition@c0000 {
+			label = "uboot environment";
+			reg = <0xc0000 0x40000>;
+		};
+
+		partition@100000 {
+			label = "splash";
+			reg = <0x100000 0x100000>;
+		};
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1phy>;
@@ -214,6 +244,21 @@
 };
 
 &iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI1_MOSI__ECSPI1_MOSI		0xf
+			MX7D_PAD_ECSPI1_MISO__ECSPI1_MISO		0xf
+			MX7D_PAD_ECSPI1_SCLK__ECSPI1_SCLK		0xf
+		>;
+	};
+
+	pinctrl_ecspi1_cs: ecspi1_cs_grp {
+		fsl,pins = <
+			/* SPI flash chipselect */
+			MX7D_PAD_ECSPI1_SS0__GPIO4_IO19			0x34
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x30
-- 
2.23.0.rc1

