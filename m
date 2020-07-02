Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74C7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41902067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="NKoZQqD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGBIOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:14:54 -0400
Received: from vps.xff.cz ([195.181.215.36]:39358 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgGBIOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593677689; bh=ct3WCETUhO2fBq7dbPZ7Ee7p2JVAC0DgiR8id7bupFc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NKoZQqD3CaxGMgUTALdSJmmTNH4Rf1sD3m6RaODw/qTu0ZGA1AvnoP43C/hM/sZlT
         tsPexv9LquJ4QWweUl9F3E8M8qTr57YaVZE+iMrYkbPzH6IcCZzTNFtWBJV7oWazdq
         syt1tuRj3FpZhxgS91ybuPSljWJ+fCFVYcWlqPMA=
From:   Ondrej Jirman <megous@megous.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v8 2/2] arm64: dts: sun50i-a64-pinephone: Add touchscreen support
Date:   Thu,  2 Jul 2020 10:14:32 +0200
Message-Id: <20200702081432.1727696-3-megous@megous.com>
In-Reply-To: <20200702081432.1727696-1-megous@megous.com>
References: <20200702081432.1727696-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinephone has a Goodix GT917S capacitive touchscreen controller on
I2C0 bus. Add support for it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index a89425ad3727..5c7386566053 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -121,6 +121,25 @@ &ehci1 {
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt917s";
+		reg = <0x5d>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+		AVDD28-supply = <&reg_ldo_io0>;
+		VDDIO-supply = <&reg_ldo_io0>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1440>;
+	};
+};
+
 &i2c1 {
 	status = "okay";
 
-- 
2.27.0

