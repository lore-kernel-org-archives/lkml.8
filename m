Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23370C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD14221E2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598181323;
	bh=nBRSChcP1vaZwzxZFMFZYHjipXWONtsRrLat8s6I/KQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CqTkXeULHu9HoK6Xbn+dt8QwiUVwE+dBYEpwflUyLO+thiIq4Z8bLymQ28TQzw0cF
	 gdMTPDHfRtMhPoSj3Xe6Yy2yIxpZH+vnBBYlrCnY6YhrqEyWEZH3509mdrSD1M/hqY
	 rmU8JtTeBBvKI+C4vWhLWwJB3GfjRmiJYspjlpWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHWLPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgHWLPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 07:15:18 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55C92074D;
        Sun, 23 Aug 2020 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598181318;
        bh=nBRSChcP1vaZwzxZFMFZYHjipXWONtsRrLat8s6I/KQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Vqy5UnHutEHs1Ynb6pNsCNmtC0NJGN10nPEi1DYS8xd4a0RPpXaehw5UyVI1DDLRi
         bE89pcA2y7ehFaYonhZ7wBjPrmwasDm6X7DncLDsGy0R+gCQKTZ8O6zk85JdtPOGEo
         gWMLjJlBvbcqhhLHNHHymS/3vadg7QEIrNDGX2K8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] arm64: dts: imx8mm-evk: Replace deprecated phy reset properties
Date:   Sun, 23 Aug 2020 13:15:04 +0200
Message-Id: <20200823111508.1165-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 19a22d0d0730..c1f7d44651df 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -119,8 +119,6 @@
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
-	phy-reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <10>;
 	fsl,magic-packet;
 	status = "okay";
 
@@ -131,6 +129,8 @@
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
+			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
 		};
 	};
 };
-- 
2.17.1

