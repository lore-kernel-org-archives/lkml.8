Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E116C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADE220836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="mJC075OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWNOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:14:52 -0500
Received: from vps.xff.cz ([195.181.215.36]:42716 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgBWNOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582463690; bh=O0vRhY+V2Jl0M2obAxrjSnldPLPIOsBZnIOFMxJMK+c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mJC075OALCfwecGtghLUWPgvLx+ENTajLDet/rRYECHBD3H+iU5h22uyPSOneXWA6
         bbpu90eCtl56eNcxBQGRX+/cQmM2Web00EzrUdJJ95Ykq8mD6V8vI/3bynYSeGVXBk
         Gh23GXprCha0Kn49mD4lg63UldnhkNREBDh2Cyww=
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
Subject: [PATCH 4/4] ARM: dts: sun8i-a83t-tbs-a711: Enable charging LED
Date:   Sun, 23 Feb 2020 14:14:35 +0100
Message-Id: <20200223131435.681620-5-megous@megous.com>
In-Reply-To: <20200223131435.681620-1-megous@megous.com>
References: <20200223131435.681620-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tablet has a LED connected to the PMIC. The LED is visible in the
top right corner of the tablet. Enable it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 2fd31a0a0b344..40911b5d3f323 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -300,6 +300,10 @@ &battery_power_supply {
 	status = "okay";
 };
 
+&charger_led {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
2.25.1

