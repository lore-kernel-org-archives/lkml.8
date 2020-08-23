Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43BCC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706E12074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598181336;
	bh=50izIWaL0UlK8Z2wfbwIT09ELCQ3HOkZUDyiNLo5fbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHEs8DtSjtLmxkxt513Je5eMS5Y/00NqS2+f6ynglMPdcXDuZ05SGA+HuUqINwCxn
	 wJD4lM1O5aIKtW0N2obQdDvVBGncQjI8qxIydMH2YW83fWXzfWksK5G4JumMts9Qhj
	 AXld7SlX0cQykhUUJnf5xSn4dCjRyk5EzVnrUOpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHWLP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgHWLPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 07:15:21 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E33420825;
        Sun, 23 Aug 2020 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598181321;
        bh=50izIWaL0UlK8Z2wfbwIT09ELCQ3HOkZUDyiNLo5fbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCXoCA1fyvCO447HtTbq2mJdy9JAtHJBPyCV2RRX3lwvmubIxIgYdVhuuyjqJNHKZ
         EsLrOwO0SLdkwl1hVaebs3YuYgnko0zpDgVGxh2i3nuIJ6ZUTr88FnCJ3jVBe9sHWJ
         eZOVv3q+appKrmhDgprXLln30fcntbDgRdUT1n4A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/5] arm64: dts: imx8mq-evk: Replace deprecated phy reset properties
Date:   Sun, 23 Aug 2020 13:15:05 +0200
Message-Id: <20200823111508.1165-2-krzk@kernel.org>
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index c9241abf0df3..8aa9cd8e495a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -137,8 +137,6 @@
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
-	phy-reset-gpios = <&gpio1 9  GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <10>;
 	fsl,magic-packet;
 	status = "okay";
 
@@ -149,6 +147,8 @@
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
+			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
 		};
 	};
 };
-- 
2.17.1

