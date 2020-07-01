Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F6BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F60E207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="FHBeQ5nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgGAKcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:32:14 -0400
Received: from vps.xff.cz ([195.181.215.36]:42548 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbgGAKbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593599495; bh=mqI4DMxpU5nv3gGp6GplYAwWUJ0ad4+0Fg/Z0K5Wudc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FHBeQ5nFreZDNM/2l/SYGog3iYLNPDSfkXOtAYK1Yz5XNjf2LVKMIpAto++BlDQqw
         N6kczy9TekXltpwUeR34bXP1B8iCG2G0phR9JtIpxL5pAPtyxK2E4CIGLQ46zY9oRF
         Y2UrLFQKlLmaZnQiOx89ytpZIhLjU4VL6R0VbEQA=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v6 13/13] arm64: dts: sun50i-a64-pinephone: Add touchscreen support
Date:   Wed,  1 Jul 2020 12:31:26 +0200
Message-Id: <20200701103126.1512615-14-megous@megous.com>
In-Reply-To: <20200701103126.1512615-1-megous@megous.com>
References: <20200701103126.1512615-1-megous@megous.com>
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
index 85a7aa5efd32..2d5694446d17 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -123,6 +123,25 @@ &ehci1 {
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt917s", "goodix,gt911";
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

