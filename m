Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62B4C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9CE206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsqyKWY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgC1VXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:23:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35171 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgC1VXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:23:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id f74so5816012wmf.0;
        Sat, 28 Mar 2020 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XfZCAw3mx1VH8Q89oa0rqaHcmTmN+wwlGYRiFHc66EM=;
        b=EsqyKWY+b1ErnScvE50klIUNK5IQjko+hO6dMBi20fAqFZg+kY8VQZTPqYkfSFNjCD
         Hc4L2D63KLrGVyKhn26mMgwknO523QFvLRS6mhFKkHIZsuQ7gyiNlz02vtTsaFrrRGK1
         hPyFMmVypyBxL/hc/b1mNl/xXcCispKsFjX2bLWZmkprhc4URV/u7SYibEojoaOtWFfT
         Hot3xCxFShK8Klhoc7jPuoaPteXKy2QTAHqLhcaJWFO+ISvK7fFwop0h/Tl3IlshLIhs
         eFYsAC733J/+P94YeTUgDg/8O+8KOIxGfhOqrEf2rcMzUJawpyJ+D2AcSJXgPmFsmX9b
         /JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XfZCAw3mx1VH8Q89oa0rqaHcmTmN+wwlGYRiFHc66EM=;
        b=ddqq9bOvws04teBBGBRjDcodw4l0/USE4Z4G6rq+1GmVcZmv13Lfu3rywLR5LkiPey
         Ak48VH7tOBb70S4Q9yVJ0LBdJn+Cnt/TPSN3x6mjsZEQmGDwNKq/p77hIWiJa/UcxWdh
         FKrMB+0ntOmGtfsF1DFDAX+dYZzbcRL+rkeLrmyb3FF/bs81gEitWxXxF2rzpWY6cPC0
         9QseuIEmaB292XoD+9NScDuHT0MBFiAnClJiOGHw+a6ewL9bCgG8+FeEfXJSSLXzs/Z+
         CQ7ZHakNd9+O1COyJVIPj74xn4PkXSPyEySY4CmpEBGqscWcmw1j5EBoiyDftsUUwPzu
         J9ag==
X-Gm-Message-State: ANhLgQ03CKFwD3XxIhhVmd9RvZ20+HnK6OGN0N3YEoYp9Ic0U2GmeUH+
        aWRSdi6mKwV/ajMOymNkQsg=
X-Google-Smtp-Source: ADFU+vvAiYZf/IYzA5fxaGnYNv0X86Z6T7fDkR1sS4MKCo6tPVfB1D/leyGrwYl0zLlD2RY7i0pYYQ==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr5640004wma.168.1585430596134;
        Sat, 28 Mar 2020 14:23:16 -0700 (PDT)
Received: from eichest-laptop.local (77-57-203-148.dclient.hispeed.ch. [77.57.203.148])
        by smtp.gmail.com with ESMTPSA id a10sm6227436wrm.87.2020.03.28.14.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:23:15 -0700 (PDT)
From:   eichest@gmail.com
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stefan Eichenberger <eichest@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: clearfog-gt-8k: fix ge phy reset pin
Date:   Sat, 28 Mar 2020 22:21:16 +0100
Message-Id: <20200328212115.12477-1-eichest@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <eichest@gmail.com>

According to the ClearFog-GT-8K-rev-1_1-Simplified-Schematic the reset
pin for the gigabit phy is MPP62 and not MPP43.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index b90d78a5724b..d371d938b41e 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -144,7 +144,6 @@
 	 * [35-38] CP0 I2C1 and I2C0
 	 * [39] GPIO reset button
 	 * [40,41] LED0 and LED1
-	 * [43] 1512 phy reset
 	 * [47] USB VBUS EN (active low)
 	 * [48] FAN PWM
 	 * [49] SFP+ present signal
@@ -155,6 +154,7 @@
 	 * [54] NFC reset
 	 * [55] Micro SD card detect
 	 * [56-61] Micro SD
+	 * [62] 1512 phy reset
 	 */
 
 	cp0_pci0_reset_pins: pci0-reset-pins {
@@ -197,11 +197,6 @@
 		marvell,function = "gpio";
 	};
 
-	cp0_copper_eth_phy_reset: copper-eth-phy-reset {
-		marvell,pins = "mpp43";
-		marvell,function = "gpio";
-	};
-
 	cp0_xhci_vbus_pins: xhci0-vbus-pins {
 		marvell,pins = "mpp47";
 		marvell,function = "gpio";
@@ -232,6 +227,11 @@
 			       "mpp60", "mpp61";
 		marvell,function = "sdio";
 	};
+
+	cp0_copper_eth_phy_reset: copper-eth-phy-reset {
+		marvell,pins = "mpp62";
+		marvell,function = "gpio";
+	};
 };
 
 &cp0_pcie0 {
@@ -365,7 +365,7 @@
 		reg = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cp0_copper_eth_phy_reset>;
-		reset-gpios = <&cp0_gpio2 11 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&cp0_gpio2 30 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <10000>;
 		reset-deassert-us = <10000>;
 	};
-- 
2.20.1

