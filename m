Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B52C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F773214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="q1EKs86T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgBVWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:31:59 -0500
Received: from vps.xff.cz ([195.181.215.36]:33610 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgBVWb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 17:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582410716; bh=Fm/QajNW4NPZ7cUaKixvAZfoL/6sl0LR+iU2+Z/Jpwg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=q1EKs86TN+17bnVuvYDClp8arpK0rLQWrQDIK0K9f/1dJPqCc28H0O9mlkw/HBQDV
         ZHshwVhFzpKwklIQjqnocMrt6udcot/U6nQIkPfhEF80+IiQNr3ONMSLA8JcmPWD9I
         9mxgquN5jmFfI8IJ37drhIEEJLy/5h3wZDKbNnO4=
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
Subject: [PATCH 1/4] ARM: dts: sun8i-a83t-tbs-a711: OOB WiFi interrupt doesn't work
Date:   Sat, 22 Feb 2020 23:31:51 +0100
Message-Id: <20200222223154.221632-2-megous@megous.com>
In-Reply-To: <20200222223154.221632-1-megous@megous.com>
References: <20200222223154.221632-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It just causes a constant rate of 5000 interrupts per second for both
GPIO and MMC, even if nothing is happening. Rely on in-band interrupts
instead.

Fixes: 0e23372080def7bb ("arm: dts: sun8i: Add the TBS A711 tablet devicetree")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 2fd31a0a0b344..ee5ce3556b2ad 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -214,9 +214,6 @@ &mmc1 {
 	brcmf: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
-		interrupt-parent = <&r_pio>;
-		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 WL_WAKE_UP */
-		interrupt-names = "host-wake";
 	};
 };
 
-- 
2.25.1

