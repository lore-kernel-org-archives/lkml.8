Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4076DC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16889206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="QfZeBXNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBVWcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:32:03 -0500
Received: from vps.xff.cz ([195.181.215.36]:33638 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgBVWb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 17:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582410717; bh=TCCzp1xrm/SgtBEqTC1+PUvJ6AXuX1dC7GgiBOhdayE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QfZeBXNTsdU36p1AqOKCSv6wS4fFa0WfFSwlwkexX9QFPaToUWYTTUXkM18CIORgf
         +IxUQD36zqs+WjQ/KEAUmzk08fDN1wSJlASjdPN5A7AtX5eKyK1nXAe+9+qsT8iAig
         KTNUDtvmexHEMxOyQVvc+Ap4vR5zuM5r6D/2gICg=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Tomas Novotny <tomas@novotny.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] ARM: dts: sun8i-a83t-tbs-a711: Fix USB OTG mode detection
Date:   Sat, 22 Feb 2020 23:31:53 +0100
Message-Id: <20200222223154.221632-4-megous@megous.com>
In-Reply-To: <20200222223154.221632-1-megous@megous.com>
References: <20200222223154.221632-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB-ID signal has a pullup on the schematic, but in reality it's not
pulled up, so add a GPIO pullup. And we also need a usb0_vbus_power-supply
for VBUS detection.

This fixes OTG mode detection and charging issues on TBS A711 tablet.
The issues came from ID pin reading 0, causing host mode to be enabled,
when it should not be, leading to DRVVBUS being enabled, which disabled
the charger.

Fixes: f2f221c7810b824e ("ARM: dts: sun8i: a711: Enable USB OTG")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index ae1fd2ee3bcce..32fa64a44d8b4 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -495,7 +495,8 @@ &usb_otg {
 };
 
 &usbphy {
-	usb0_id_det-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	usb0_id_det-gpios = <&pio 7 11 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH11 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_vmain>;
 	usb2_vbus-supply = <&reg_vmain>;
-- 
2.25.1

