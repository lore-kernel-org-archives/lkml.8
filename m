Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC2C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581504248;
	bh=a74Ur2aGwpyLmtSJw/xtsawU+rUAv7FqSD4NhB0pg5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WR0znLxPSvD07+6i8c7WEVPn30y6rJRcHPGIXi5Ig2z28wSmXmPPy6B+OFk9flXl6
	 Z0N4pQZyJa+2p5CR1kOl5wRT66OvT4aqty+UckPrh0IJHvqnz967qfaNEa2qF7zRYp
	 3lT1uVbnCUcLvLfnhqtkItI2iBLt/fQzaS5cfhl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBLKoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:44:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35923 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBLKoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:44:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so1257756lfh.3;
        Wed, 12 Feb 2020 02:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfdJBTNvCTI7BpYX85qLAk9HwyLTmyD1T6kKp6aaYPs=;
        b=f12MfN6xCIlrVOd/ZCKQQyjygg4gWpIALxSVF6rWneyHGy7FNiH9RyqkUfsETd7LQD
         XL7HOtpI3AZButlPhUnqHZo8YsZkR1LBeNEXcig5k5DWcWhB3xGjFRIgU6SkWei5mWkS
         iXvzaijeMOygdHRAAu+r2q85Wyixuc+144w5kWCYzHN9GK2coPpT6rGjQWrJNBLrbvnF
         /BjBrF8LLc9JKL4UQrmQnVd9EVYxkiQ7Ig0T50XveUuqSgmgA8LrsQcBV9K73i6jTIHm
         eZiAoG8OYlo1XG5DUPe6+4ipz3cc1dOlUoeSKmFRno+r6LDtN0+QF2drAdyAiaqKRf6s
         lbxA==
X-Gm-Message-State: APjAAAXrFJNWcm6mZrQImtXAK5YqA9OsK1wxvNSJ8nGJOQk7TqpEZiLU
        rOHnJCoq075avrBk1Cv7g3Q=
X-Google-Smtp-Source: APXvYqzIshsThoHFCzhoumPwFpQqdmQWyTtvhlbbJqwYfwu6qPvpCG83PEOZAQCFyBEPM10yO6VJkA==
X-Received: by 2002:ac2:4246:: with SMTP id m6mr6415511lfl.165.1581504239993;
        Wed, 12 Feb 2020 02:43:59 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id k4sm82303lfo.48.2020.02.12.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:43:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1j1pUs-0005CS-4J; Wed, 12 Feb 2020 11:43:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
        Johan Hovold <johan@kernel.org>,
        Zhiwu Song <Zhiwu.Song@csr.com>, Hao Liu <Hao.Liu@csr.com>
Subject: [PATCH 1/3] ARM: dts: atlas7: fix space in flexnoc compatible strings
Date:   Wed, 12 Feb 2020 11:43:46 +0100
Message-Id: <20200212104348.19940-2-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212104348.19940-1-johan@kernel.org>
References: <20200212104348.19940-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the space between manufacturer and model in the Arteris FlexNoC
compatible string in the noc-bus nodes so that it matches the
recommended format.

Note that there are no in-kernel drivers that use this compatible and it
is not present in any binding.

Fixes: 7d76d03b9be8 ("ARM: dts: add init dts file for CSR atlas7 SoC")
Cc: Zhiwu Song <Zhiwu.Song@csr.com>
Cc: Hao Liu <Hao.Liu@csr.com>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/atlas7.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 99c9d9d9267f..92b00e4740f6 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1164,7 +1164,7 @@ vi_vip1_high8bit {
 		};
 
 		pmipc {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x13240000 0x13240000 0x00010000>;
@@ -1175,7 +1175,7 @@ pmipc@0x13240000 {
 		};
 
 		dramfw {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x10830000 0x10830000 0x18000>;
@@ -1186,7 +1186,7 @@ dramfw@10820000 {
 		};
 
 		spramfw {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x10250000 0x10250000 0x3000>;
@@ -1197,7 +1197,7 @@ spramfw@10820000 {
 		};
 
 		cpum {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x10200000 0x10200000 0x3000>;
@@ -1208,7 +1208,7 @@ cpum@10200000 {
 		};
 
 		cgum {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x18641000 0x18641000 0x3000>,
@@ -1238,7 +1238,7 @@ pwm: pwm@18630000 {
 		};
 
 		gnssm {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x18000000 0x18000000 0x0000ffff>,
@@ -1365,7 +1365,7 @@ spi1: spi@18200000 {
 
 
 		gpum {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x13000000 0x13000000 0x3000>,
@@ -1407,7 +1407,7 @@ sdr@0x13010000 {
 		};
 
 		mediam {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x15000000 0x15000000 0x00600000>,
@@ -1549,7 +1549,7 @@ i2c0: i2c@17020000 {
 		};
 
 		vdifm {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x13290000 0x13290000 0x3000>,
@@ -1652,7 +1652,7 @@ sd7: sdhci@14700000 {
 		};
 
 		audiom {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x10d50000 0x10d50000 0x0000ffff>,
@@ -1767,7 +1767,7 @@ usp2: usp@10d40000 {
 		};
 
 		ddrm {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x10820000 0x10820000 0x3000>,
@@ -1786,7 +1786,7 @@ memory-controller@0x10800000 {
 		};
 
 		btm {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x11002000 0x11002000 0x0000ffff>,
@@ -1838,7 +1838,7 @@ btm@11010000 {
 		};
 
 		rtcm {
-			compatible = "arteris, flexnoc", "simple-bus";
+			compatible = "arteris,flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x18810000 0x18810000 0x3000>,
-- 
2.24.1

