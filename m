Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118CC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A1C20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgAaIrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:47:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42496 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgAaIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:47:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so7595672wrd.9;
        Fri, 31 Jan 2020 00:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8BhmUjvRpuRsDLc+hCNgR+cjfG8z1wM6d0LK3Ong3c=;
        b=Lj4E18atvb05TubG/cEzpGPx58RpO71czlMVc3RGskC8qpHse61P4h+UC90S1IdFBP
         37y4S2AT8lziGQks5BzawsSOanlsFuFy49pUbc9U7U2fpkuQAed+iDQVoJypYlVB8bvh
         AV2HZYGWJ3e3+0XoaqByyMStoTnQv5Np4zOK0PedA8MwuQw+XdWiqv2eDzeYVWgVZAB+
         kZlXkuw49eV67vnOlZyGr8F0DWGZNzi2nqURIkgzVmoHg2PN06JemoE3plPy4uM11SOp
         B+9xxeh8VtCgYVlj2YCt3TuT1ovmNUjae4bsRF4B6l8rZzqMiNB9IR5yTgsA1a/HgWtJ
         6l0w==
X-Gm-Message-State: APjAAAXTED9QiZqrmzgd0VpN1wODwv4xw2earBDJq5WinXfp/vMqbaru
        9fWW/7YTFVNdvHoPCEcH59Zp9HP3YHM=
X-Google-Smtp-Source: APXvYqxxlDx6OL+N6mRBKI3g5CIhqUA5YoHHDTW8clNvHsx+P0JH34TY2Onr5/+6Mfr6D6bRmeSs/g==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr10605714wrs.159.1580460121281;
        Fri, 31 Jan 2020 00:42:01 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:42:00 -0800 (PST)
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
Subject: [PATCH v3 11/12] ARM: dts: imx7d: cl-som-imx7: add WiLink Bluetooth support
Date:   Fri, 31 Jan 2020 08:36:37 +0000
Message-Id: <20200131083638.6118-11-git@andred.net>
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

add / enable TI's WiLink8 Bluetooth module on UART3.

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 4cb36decef3d..08fb43f7ae1d 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -250,6 +250,21 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&pca9555 1 GPIO_ACTIVE_HIGH>;
+		max-speed = <3000000>;
+	};
+};
+
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
@@ -351,6 +366,15 @@
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__UART3_DCE_TX	0x79
+			MX7D_PAD_UART3_RX_DATA__UART3_DCE_RX	0x79
+			MX7D_PAD_UART3_CTS_B__UART3_DCE_CTS	0x79
+			MX7D_PAD_UART3_RTS_B__UART3_DCE_RTS	0x79
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
-- 
2.23.0.rc1

