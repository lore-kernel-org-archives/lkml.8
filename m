Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EBE20768
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598181351;
	bh=v6DcEuq4TZ/6Ck4lnEqFninOLK9CeVIu8u9/wUwmwTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nmr1SkJDWQc3hWiohLv8mGXDDFZkrs1+5TWMzC6ONJJ3ai80KyXTopo1x/u4/e2kP
	 J2rjGWIDMd1dUdPUDiA6EAIO3egi6zc+BXWQ8+YvOL8SfNZh1D9USV9BnDTvGeTArf
	 7U+Tb/y/RAgHi685bGkn5cHfgQlto1k7tvXEIBME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHWLPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgHWLP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 07:15:26 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD6A2074D;
        Sun, 23 Aug 2020 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598181326;
        bh=v6DcEuq4TZ/6Ck4lnEqFninOLK9CeVIu8u9/wUwmwTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVOzWhOoEYW27guIbOh4XJ2k8xz7a/p5A8KY8s96qekfBy47GnMw05U6WzxPFFLT/
         uLfZiE7jTPzZjfJzBl02uLrPcXyhtWP+mu3xqiRaDxZOX7icID2LmGJ4YpXfZgPU/5
         EWuPPMGIUToUy1qTQo2UA14xWzvZHyjs8Pt9LCVg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/5] arm64: dts: imx8mq-sr-som: Replace deprecated phy reset properties
Date:   Sun, 23 Aug 2020 13:15:07 +0200
Message-Id: <20200823111508.1165-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823111508.1165-1-krzk@kernel.org>
References: <20200823111508.1165-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred properties of phy node instead of deprecated
phy-reset-gpios (and others).  This avoids copying deprecated code into
future DTSes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
index 602c870a7ccb..404c46671b96 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
@@ -20,8 +20,6 @@
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
-	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <2>;
 	fsl,magic-packet;
 	status = "okay";
 
@@ -32,6 +30,8 @@
 		ethphy0: ethernet-phy@4 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <4>;
+			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <2000>;
 		};
 	};
 };
-- 
2.17.1

