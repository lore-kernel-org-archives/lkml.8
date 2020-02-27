Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCA5C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A922469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgB0SWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:25 -0500
Received: from foss.arm.com ([217.140.110.172]:56626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgB0SWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D57E34B2;
        Thu, 27 Feb 2020 10:22:23 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3702D3F73B;
        Thu, 27 Feb 2020 10:22:22 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 02/13] arm: dts: calxeda: Provide UART clock
Date:   Thu, 27 Feb 2020 18:21:59 +0000
Message-Id: <20200227182210.89512-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227182210.89512-1-andre.przywara@arm.com>
References: <20200227182210.89512-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PL011 UART binding requires two clocks to be named in a node.
Add the second clock, which is the bus gate, that just gets enabled.
Since this is a fixed clock anyway, it doesn't make any difference.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/ecx-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index 66ee1d34f72b..f819e3328a9e 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -114,8 +114,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xfff36000 0x1000>;
 			interrupts = <0 20 4>;
-			clocks = <&pclk>;
-			clock-names = "apb_pclk";
+			clocks = <&pclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		smic@fff3a000 {
-- 
2.17.1

