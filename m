Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E144523EB0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UPbBsYsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgFTQYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:24:06 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A47C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:24:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cy7so3670082edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBB5+d9DExrRxU/V6V7qCMTYL5+l1zibZSgTJX3TLv4=;
        b=UPbBsYsKM2Y0CgcJM/oLWhxOlV7NPTH2Up5Sx9q8Aee3aY1fgQV2IK7bueXo4i/aFO
         anHS/QRTijSw6Nx+agm4d5Nw7S7wAyUES5PwxKphM6U33a2ULHcQJaJaa7hRavjQUo9U
         y4/CYeDa8WJZx7x//OhJZdoT8BKF+TmzzRa/wy7ACojHKQZOj2YU72oWyOV5K6HO50i9
         rLuc8D2lk0bifWwSOAGeo+aa7ERyOwxepJ2bHRfJ4hwaqOgbAewYd6LrglnyfMYEuKST
         XI+k/HyqB44kYl0HsKsxgp1apDRJgLNUp83DAfRF1B+RB2puHoRn3uaWoQmQjFcwrrpI
         1NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBB5+d9DExrRxU/V6V7qCMTYL5+l1zibZSgTJX3TLv4=;
        b=CPxbtZcc7tyliw85Bl0infkjGixpQ3NvVWAlvHfg4+gG2nZY2a7RCdQOMLwK5Sk/Nw
         8Rxqxva7wqAD3hgAc+tN3YihXWY9fphuN5JVYZ1re4GebvWEObt/7EuzF6Weu2e04ser
         29JI3gb5cQp/piao8bAx2lUCIM8Gz3CXK6l9wNiH6EQGFCBLEeUwsilB8zZFqakvh2pe
         yo7eQ8Hn8o2CCi6NCzn5oY4vO5uq1TaiDao+DYeW27/bjAqiuUZZ+fEH2Xc2WB+FtOFl
         fC2000Q8w511Zki5aT5x5LFvKF913UtfNxqrr9+if8pSu/gWPlsgS88GBVBohVLVRT/T
         5MDg==
X-Gm-Message-State: AOAM531lhz1cBFt+ISnySgE9i2m/qij1/eHUDfjYhB0VABlBdTfBfk9t
        XkPuae2ZneXogcUmIobweBGgPOu6
X-Google-Smtp-Source: ABdhPJwLrOeWiRJI8vetnweyhKH5HKvsM+j56XPeJtK7Kup+7ho72bkQIjiCLZGezx2eQjwhQ+xKzQ==
X-Received: by 2002:aa7:c148:: with SMTP id r8mr8929513edp.108.1592670243932;
        Sat, 20 Jun 2020 09:24:03 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id l24sm7515582ejb.5.2020.06.20.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:24:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] arm64: dts: amlogic: Add the Ethernet "timing-adjustment" clock
Date:   Sat, 20 Jun 2020 18:23:47 +0200
Message-Id: <20200620162347.26159-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "timing-adjustment" clock now that we know how it is connected
to the PRG_ETHERNET registers. It is used internally to generate the
RGMII RX delay on the MAC side (if needed).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1 at [0]:
- fixed all typos in the commit message (hopefully...). Thanks to Andrew
  for spotting the first ("no" -> "on") one and shame on me for having
  to find two more ("adjusment" -> "adjustment", "now" -> "know")


[0] https://patchwork.kernel.org/patch/11616101/


 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 6 ++++--
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi       | 5 +++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 5 +++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 8e6281c685fa..b9efc8469265 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -181,8 +181,10 @@ ethmac: ethernet@ff3f0000 {
 			interrupt-names = "macirq";
 			clocks = <&clkc CLKID_ETH>,
 				 <&clkc CLKID_FCLK_DIV2>,
-				 <&clkc CLKID_MPLL2>;
-			clock-names = "stmmaceth", "clkin0", "clkin1";
+				 <&clkc CLKID_MPLL2>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1",
+				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 593a006f4b7b..41805f2ed8fc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -185,8 +185,10 @@ ethmac: ethernet@ff3f0000 {
 			interrupt-names = "macirq";
 			clocks = <&clkc CLKID_ETH>,
 				 <&clkc CLKID_FCLK_DIV2>,
-				 <&clkc CLKID_MPLL2>;
-			clock-names = "stmmaceth", "clkin0", "clkin1";
+				 <&clkc CLKID_MPLL2>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1",
+				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 234490d3ee68..03c25b9facff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -333,8 +333,9 @@ &efuse {
 &ethmac {
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_FCLK_DIV2>,
-		 <&clkc CLKID_MPLL2>;
-	clock-names = "stmmaceth", "clkin0", "clkin1";
+		 <&clkc CLKID_MPLL2>,
+		 <&clkc CLKID_FCLK_DIV2>;
+	clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
 };
 
 &gpio_intc {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index fc59c8534c0f..60484bbc7272 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -131,8 +131,9 @@ &efuse {
 &ethmac {
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_FCLK_DIV2>,
-		 <&clkc CLKID_MPLL2>;
-	clock-names = "stmmaceth", "clkin0", "clkin1";
+		 <&clkc CLKID_MPLL2>,
+		 <&clkc CLKID_FCLK_DIV2>;
+	clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
 
 	mdio0: mdio {
 		#address-cells = <1>;
-- 
2.27.0

