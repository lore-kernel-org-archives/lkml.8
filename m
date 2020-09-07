Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA238C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB00321481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgIGMYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:24:17 -0400
Received: from foss.arm.com ([217.140.110.172]:34346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgIGMSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423591396;
        Mon,  7 Sep 2020 05:18:41 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291723F66E;
        Mon,  7 Sep 2020 05:18:40 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] ARM: dts: nspire: Fix SP804 users
Date:   Mon,  7 Sep 2020 13:18:27 +0100
Message-Id: <20200907121831.242281-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907121831.242281-1-andre.przywara@arm.com>
References: <20200907121831.242281-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the SP804 binding allows to specify only one clock, the
primecell driver requires a named clock to activate the bus clock.

Specify the one clock three times and provide some clock-names, to
make the DT match the SP804 and primecell binding.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/nspire.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index d9a0fd7524dc..90e033d9141f 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -145,15 +145,19 @@
 
 			timer0: timer@900C0000 {
 				reg = <0x900C0000 0x1000>;
-
-				clocks = <&timer_clk>;
+				clocks = <&timer_clk>, <&timer_clk>,
+					 <&timer_clk>;
+				clock-names = "timer0clk", "timer1clk",
+					      "apb_pclk";
 			};
 
 			timer1: timer@900D0000 {
 				reg = <0x900D0000 0x1000>;
 				interrupts = <19>;
-
-				clocks = <&timer_clk>;
+				clocks = <&timer_clk>, <&timer_clk>,
+					 <&timer_clk>;
+				clock-names = "timer0clk", "timer1clk",
+					      "apb_pclk";
 			};
 
 			watchdog: watchdog@90060000 {
-- 
2.17.1

