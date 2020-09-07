Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CF9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5004A2176B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgIGMVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:21:50 -0400
Received: from foss.arm.com ([217.140.110.172]:34408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbgIGMSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:18:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F84F143B;
        Mon,  7 Sep 2020 05:18:46 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669803F66E;
        Mon,  7 Sep 2020 05:18:45 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] ARM: dts: hisilicon: Fix SP805 clocks
Date:   Mon,  7 Sep 2020 13:18:31 +0100
Message-Id: <20200907121831.242281-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907121831.242281-1-andre.przywara@arm.com>
References: <20200907121831.242281-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SP805 DT binding requires two clocks to be specified, but
Hisilicon platform DTs currently only specify one clock.

In practice, Linux would pick a clock named "apb_pclk" for the bus
clock, and the Linux and U-Boot SP805 driver would use the first clock
to derive the actual watchdog counter frequency.

Since currently both are the very same clock, we can just double the
clock reference, and add the correct clock-names, to match the binding.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 3ee7967c202d..e2dbf1d8a67b 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -370,8 +370,9 @@
 				arm,primecell-periphid = <0x00141805>;
 				reg = <0xa2c000 0x1000>;
 				interrupts = <0 29 4>;
-				clocks = <&clock HIX5HD2_WDG0_RST>;
-				clock-names = "apb_pclk";
+				clocks = <&clock HIX5HD2_WDG0_RST>,
+					 <&clock HIX5HD2_WDG0_RST>;
+				clock-names = "wdog_clk", "apb_pclk";
 			};
 		};
 
-- 
2.17.1

