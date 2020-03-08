Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBDC10F29
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC42020873
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=heimpold.de header.i=@heimpold.de header.b="A3oqdy+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCHWZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 18:25:09 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:20612 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCHWZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 18:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583706306;
        s=strato-dkim-0002; d=heimpold.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=d9uANtqqjVRwOWMSyb++r8818TlXjH+7k+MeOvfjjAo=;
        b=A3oqdy+PX8PD0cNpjQs47ICTEpjOrCOukRPRFlPEOYv6xPq9i09aHbtjEHRADGyeQo
        BJ4ITDeLGy2+YNXfS9ZKry9vEAMjx8PLspeM0FecHZoBm2cl1Cka3WahN3INoV0dQlhK
        lCoq3HIR02fggWNrgymb4QXxYaGGA5BLkj0i7bvvMCGtwqCqlKcCziyAK0eJRXNeEidc
        Or/dSlYXiFfovllXJcuQvYi3vgSo8tCUQaoO67eBrxCEWxr87D0VFcDQvNftTdzaxbD5
        7JfWU9grT6yTD92P0Lc7nQnzfKnMba4t03nBOGMjQvapwRfquS7ANLKLMBkM9mttDXHC
        newA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGQORRBv+ASfYPl1MuUOoWmb+wVC/S4hO3Q59Bxjg5s+JNFtEYYiw=="
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 46.2.0 AUTH)
        with ESMTPSA id Q06422w28MM4gKy
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 8 Mar 2020 23:22:04 +0100 (CET)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 6D0F71512E1;
        Sun,  8 Mar 2020 23:22:03 +0100 (CET)
From:   Michael Heimpold <mhei@heimpold.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH] ARM: dts: imx23: introduce mmc0_sck_cfg
Date:   Sun,  8 Mar 2020 23:21:44 +0100
Message-Id: <20200308222144.24863-1-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Olimex Olinuxino board has a user led connected to SSP1_DETECT.
But since this pin is listed in mmc0_pins_fixup, it is already claimed
by MMC driver and this results in this error during boot:

[    1.390000] imx23-pinctrl 80018000.pinctrl: pin SSP1_DETECT already
  requested by 80010000.spi; cannot claim for leds
[    1.400000] imx23-pinctrl 80018000.pinctrl: pin-65 (leds) status -22
[    1.410000] imx23-pinctrl 80018000.pinctrl: could not request pin 65
   (SSP1_DETECT) from group led_gpio2_1.0  on device 80018000.pinctrl
[    1.420000] leds-gpio leds: Error applying setting, reverse things back
[    1.430000] leds-gpio: probe of leds failed with error -22

This fix it, introduce mmc0_sck_cfg and switch the Olinuxino board to it.

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/imx23-olinuxino.dts | 2 +-
 arch/arm/boot/dts/imx23.dtsi          | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 4c9aafe00b5d..0729e72f2283 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -23,7 +23,7 @@
 			ssp0: spi@80010000 {
 				compatible = "fsl,imx23-mmc";
 				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
+				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_sck_cfg>;
 				bus-width = <4>;
 				broken-cd;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8257630f7a49..e18ad74d5470 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -267,6 +267,14 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				mmc0_sck_cfg: mmc0-sck-cfg@0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX23_PAD_SSP1_SCK__SSP1_SCK
+					>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				mmc1_4bit_pins_a: mmc1-4bit@0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.17.1

