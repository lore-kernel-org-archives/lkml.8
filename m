Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61902C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267D82074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231274;
	bh=QOJLGecW1qxz6ZNlLifYa3oKhiDzUyvvKI7pYuzuHRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s2AZXy1CjiN7b+7bCMmA1KTcVK5qMxNiopU0awoMQOQjihxJ+kyq75vZ57HYZyuxE
	 dYrsyp/fxgAp9riyZpqtGvEsu7bK1N8Q6nykkb8OtCUdLxCEivkebtJXzCM5kVaN7c
	 qJhCcJyPeqwRUX6M6vbp86/32b0qnSewC4TaVhTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgIDOyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbgIDOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:54:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABC620722;
        Fri,  4 Sep 2020 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231271;
        bh=QOJLGecW1qxz6ZNlLifYa3oKhiDzUyvvKI7pYuzuHRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIaC+jSu5K5Ul1I+hd40MUvRZUlCxrX3f809s3TEnNjprGSdRQROcWey19AD11pmp
         rNnrLLXLjWuznWa5iLoYcNm9Pklcbv5VdJ06qeBB/uqh9wDr7sdvRI3xD6HUPPtJgH
         LJlaXSdlXFcy/CbOvNSeld92RdgUUw+jXBoqcLkk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 12/13] arm64: dts: imx8mq-librem5: Drop interrupt-names in PMIC
Date:   Fri,  4 Sep 2020 16:53:11 +0200
Message-Id: <20200904145312.10960-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'interrupt-names' property is not described in dtschema, not used by
the driver and does not really make sense as its value is simple 'irq'.
Drop it to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dt.yaml:
    pmic@4b: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 1 -
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 10f30ff85fd3..cce1b595e2d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -289,7 +289,6 @@
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 GPIO_ACTIVE_LOW>;
-		interrupt-names = "irq";
 		rohm,reset-snvs-powered;
 
 		regulators {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 4e50cb62654d..a78584086fa9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -640,7 +640,6 @@
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
 		interrupts = <7 GPIO_ACTIVE_LOW>;
-		interrupt-names = "irq";
 		rohm,reset-snvs-powered;
 
 		regulators {
-- 
2.17.1

