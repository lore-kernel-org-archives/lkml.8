Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2DC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1558A214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgAaItr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:49:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37524 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgAaItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:49:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so7738145wmf.2;
        Fri, 31 Jan 2020 00:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRnNY4JLf7ZTy3fdUTm9bEVVoWS6JMbuHY/wh8kGwgE=;
        b=czxENc/T5NRWyxAs9HPgbBXIIJkPFgzLcgWLPj0aU4IvG8oIeCVMW8/RwQXamI/h1Q
         ZGsLtEP9q+k/lbK5GPcvLCbcotURGKC+iSlpm03W1AllaK2kkQzKbSHE1N5HWlmddHco
         c96yqUMBPnrzS02cEUmxSD6RBz1vSZkXQEzhjBoJEavJwTTUlzg6wfdf0TvfJuK0XCVc
         Z3D4/ySW8mrdXTHNZ+meC8YjfOTtR0rkESTsGJLrQOzG3E96KwPfEzgFFyQ5Qi6aXm/7
         fo9wNkVbL0SeUW5NvHeauePJ5ZeCnFT0+UHfz1/al/t6nG7AxCHOpjcInjxHhbIM6lYC
         ZyHg==
X-Gm-Message-State: APjAAAVW2oakKSP43oyZuXVzfU83uBOA66JIRd8jt1xLWCOVFnGjrpeR
        ntESLK2gJLaHCH5ho+uXscXKAKsQ4qw=
X-Google-Smtp-Source: APXvYqySY42pc1aYVVB+FtN/uubVEJzMCyrRHDIBuzHAc9fotMDyplrvmbtRD7ITLJFsIeB5sdNZXA==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr3070206wma.134.1580460112337;
        Fri, 31 Jan 2020 00:41:52 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:51 -0800 (PST)
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
Subject: [PATCH v3 03/12] ARM: dts: imx7d: cl-som-imx7: fix i2c2
Date:   Fri, 31 Jan 2020 08:36:29 +0000
Message-Id: <20200131083638.6118-3-git@andred.net>
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

I2C2 is configured incorrectly at the moment:
* update i2c2 to actually work (fix incorrect pinctrl assignments)
* add the i2c2 bus recovery information [1]

[1] Note that scl is being marked as GPIO_OPEN_DRAIN even
though the i.MX pinctrl driver does not support enabling
open drain directly - it is enabled by the fixed pinmux
entry.
So while this flag has no effect in practice, it needs
to be there purely so as to fix the following warning
from gpiolib:
    gpio-6 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
as that is the mode requested by i2c-imx.c

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 26 +++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index e0432a3aa36f..ec82f4738c4f 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -72,8 +72,11 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_recovery>;
+	sda-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	pmic: pmic@8 {
@@ -236,13 +239,6 @@
 		>;
 	};
 
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
-			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
-		>;
-	};
-
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
@@ -273,4 +269,18 @@
 			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x34
 		>;
 	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO07__I2C2_SDA	0x4000000f
+			MX7D_PAD_LPSR_GPIO1_IO06__I2C2_SCL	0x4000000f
+		>;
+	};
+
+	pinctrl_i2c2_recovery: i2c2recoverygrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x4000007f
+		>;
+	};
 };
-- 
2.23.0.rc1

