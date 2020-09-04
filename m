Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7271FC2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441822087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231263;
	bh=81A3QuqoXZzEZuA4VrJNKDP41nu2TRmL2PK+zN4pelw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gc6EAj/StA0R/1AYoQl2cxrmviWEpxWiB5uIBQHrzrRActOHChT8VmqAJPVBSn3/a
	 q31JqjK1YlBQboAMfPmyZrcUXmbFeHkfNEL7qbr0zQiRiAbNcrAR7H8PhUsHzvQV7F
	 Th4RM2uyAWc2FA5ZP9CHY246NxL25guQ5k17Qf0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgIDOyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbgIDOyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:54:08 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C192074D;
        Fri,  4 Sep 2020 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231248;
        bh=81A3QuqoXZzEZuA4VrJNKDP41nu2TRmL2PK+zN4pelw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVytugngnFVEpJQ4Xz1FSvczr6EDgnVybAzmRAslPiKphk1767QOnPxSLCcY6lTZz
         sjq92gOccYrDXw0o3D8EvzaaDmCCaLFaPOqB70j4wuowOkA/YkdhX5fzs3YYg4mExm
         SwJN2kWQBlDwcaDRNVbOnjkTb5I3+9r7uQlK+YXg=
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
Subject: [PATCH 08/13] arm64: dts: imx8mm-var-som-symphony: Use newer interrupts property
Date:   Fri,  4 Sep 2020 16:53:07 +0200
Message-Id: <20200904145312.10960-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The int-gpios was deprecated in favor of generic interrupts property.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
index 0bca737964d5..fe3abd9d002f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -113,7 +113,7 @@
 	extcon_usbotg1: typec@3d {
 		compatible = "nxp,ptn5150";
 		reg = <0x3d>;
-		int-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		interrupts = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ptn5150>;
 		status = "okay";
-- 
2.17.1

