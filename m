Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5534C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D45720836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="rGyp96Sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBWNOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:14:52 -0500
Received: from vps.xff.cz ([195.181.215.36]:42696 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgBWNOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582463689; bh=NMin2NjZeeqocWZC9NSK1oMc+IKPqF2jiBrmazxCDxs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rGyp96Slng/w/Z7/e3YLulL5bZqgnaIYdI5fCn37OVTi25dHUU6qMSWUoRJMMTFH3
         A0a3h0AKjpqQBgmI4pDVojzIgMFnrYegCmMSejetqfS1d4vnCStpAQ943VDbMh+pE9
         G4OGZrj2ZGK52DJLuab6irxsutHCdFVxLnjXm5FA=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: axp813: Add charger LED
Date:   Sun, 23 Feb 2020 14:14:34 +0100
Message-Id: <20200223131435.681620-4-megous@megous.com>
In-Reply-To: <20200223131435.681620-1-megous@megous.com>
References: <20200223131435.681620-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC supports charging status indication via a LED. Add support
for it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 1dfeeceabf4c3..00b092f94433d 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -175,4 +175,9 @@ reg_drivevbus: drivevbus {
 	usb_power_supply: usb-power-supply {
 		compatible = "x-powers,axp813-usb-power-supply";
 	};
+
+	charger_led: charger-led {
+		compatible = "x-powers,axp813-charger-led";
+		status = "disabled";
+	};
 };
-- 
2.25.1

