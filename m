Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C4C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B2A20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3FXu4Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgBKNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:48:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40036 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgBKNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:48:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so7933018qto.7;
        Tue, 11 Feb 2020 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JIZHRdZLqtLorXZfrYCSPItmC1Dc+HGHwOIzP/XDImY=;
        b=d3FXu4DcpsHeeo7NBsq1Ec3f7OKhc4SsvQnIJenSnOtjREel9IF+kdR8ma1SWkO5OR
         Ou4s2dnBv7WOxC4OPWNV6d8KIVpBRVtM/ukAKzN6d3zx7MvBtQz1N27NoDx/a7ujHsmS
         jvZYtEEc8DToM7semtrIS3CUfnR8Jxni2Z/6WUP8wvMdDT8C1m2PB78zzz+BFas4vec2
         VRg0vXB9eGeEdlGGMFCs2IJ9nbGhw7o3VA3WFY8plHWMmjNInC6fLgpMiA40FBmv4BzV
         G9slDIDonCBacDdi6tPT8KEVnytqC8eiltqCoEj+hq8mYECNDQpWUjWhJQ4KRRh1aoXi
         oAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JIZHRdZLqtLorXZfrYCSPItmC1Dc+HGHwOIzP/XDImY=;
        b=NL05IKKlW0LRFfZSq9ut6eSJDrNbVU6q4I4cLgMv6I8VSNguF2YLNynIHoLWfHthje
         ELxXSX7j/7L1/gT0WLrrJboYLPswI2nh/vsMtvXYaf4A6MSsBXV+q2VMxyfQHoDS9TJ/
         Bldxb1Rp7V2VgsW2RpkSqVXBfk3sXJXwTnJAD4UEcz27E731ykiqzoghTKOvnOzhXCB2
         dkeVLp9Eg44fU80qhdSTaM1nki0yrh/DIV3f1QKvl7sY35URfj3KjgK017vS3Kh9BzW5
         BVlh3BPeGlBxJJwDF/FgC+/rYmU15Q/czs16lyqC3k06rd0hNq1W2SeI+mZxg44iFQjE
         JJYA==
X-Gm-Message-State: APjAAAV+zLtDn+UgHtw3f2XRNVyNruGv8v4oGnfEKaIrULyGNfWsQmjQ
        bz7So9gjuT9jrNWdnxfMyO0=
X-Google-Smtp-Source: APXvYqybhzOEAAvHZbhKNes/s71zGxqa2omF1pXH9nVpHWlE7KVvcXMkRtBbOlD4T9UG/KxmmcCT+w==
X-Received: by 2002:ac8:7caf:: with SMTP id z15mr14892626qtv.68.1581428933199;
        Tue, 11 Feb 2020 05:48:53 -0800 (PST)
Received: from NXL86673.nxp.com ([177.221.114.206])
        by smtp.googlemail.com with ESMTPSA id h6sm2158936qtr.33.2020.02.11.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:48:52 -0800 (PST)
From:   Alifer Moraes <alifer.wsdm@gmail.com>
To:     robh+dt@kernel.org
Cc:     festevam@gmail.com, marco.franchi@nxp.com, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Alifer Moraes <alifer.wsdm@gmail.com>
Subject: [PATCH] arm64: dts: imx8mq-phanbell: Add support for ethernet
Date:   Tue, 11 Feb 2020 10:48:28 -0300
Message-Id: <20200211134828.138-1-alifer.wsdm@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ethernet on Google's i.MX 8MQ Phanbell

Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>
---
 .../boot/dts/freescale/imx8mq-phanbell.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
index 3f2a489a4ad8..16ed13c44a47 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -201,6 +201,27 @@
 	};
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <10>;
+	phy-reset-post-delay = <30>;
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -254,6 +275,26 @@
 };
 
 &iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
+			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
-- 
2.17.1

