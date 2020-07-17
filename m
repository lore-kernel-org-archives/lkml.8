Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25893C433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0111207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595001684;
	bh=2ZbkrZccM4GRyeKL6L2cvwgpAuoXXOK43VqdE71mHdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WiR6t2HL7viWp2Hz5DHKA4S4aB9ZFdUk/x6J+VHlIRCotav5uNZDRhhZzfs68a5Am
	 0kEGVWfiRlC/vK+CXLtb73li7J8xnMGk1fop+URLpTdeLvZd4KQTWELVmg+xauLejG
	 pZ/cOZKFuQm+8+XaEnJavrdPwJRPrc1w/zH36A08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGQQBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgGQQA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:00:59 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D068206BE;
        Fri, 17 Jul 2020 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001658;
        bh=2ZbkrZccM4GRyeKL6L2cvwgpAuoXXOK43VqdE71mHdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yY+WDOnJn57BkxkmLI/zXIHgVNyIueEkL1qmzCzjz6EXM9kj/vLVBnOmeI9+WhhwC
         2AQAJOOnqG+Twne9wJOK4duq90eNzhI9yFHicouK22DDAXAD0fgu+hWAIRMGunipXw
         ZQg+t/RfgdUGD5TVuS3hYRC/RMtr9nryBUSbknjg=
Received: by wens.tw (Postfix, from userid 1000)
        id 29FD45FD44; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] ARM: dts: sunxi: bananapi-m2-plus-v1.2: Fix CPU supply voltages
Date:   Sat, 18 Jul 2020 00:00:48 +0800
Message-Id: <20200717160053.31191-4-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717160053.31191-1-wens@kernel.org>
References: <20200717160053.31191-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Bananapi M2+ uses a GPIO line to change the effective resistance of
the CPU supply regulator's feedback resistor network. The voltages
described in the device tree were given directly by the vendor. This
turns out to be slightly off compared to the real values.

The updated voltages are based on calculations of the feedback resistor
network, and verified down to three decimal places with a multi-meter.

Fixes: 6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
index a628b5ee72b6..235994a4a2eb 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
@@ -16,12 +16,12 @@ reg_vdd_cpux: vdd-cpux {
 		regulator-type = "voltage";
 		regulator-boot-on;
 		regulator-always-on;
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1108475>;
+		regulator-max-microvolt = <1308475>;
 		regulator-ramp-delay = <50>; /* 4ms */
 		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
 		gpios-states = <0x1>;
-		states = <1100000 0>, <1300000 1>;
+		states = <1108475 0>, <1308475 1>;
 	};
 };
 
-- 
2.27.0

