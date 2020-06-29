Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB39C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0839F208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466170;
	bh=iIs58fRuYkpMgTsFBKYFLGnGWc18yjUOw+YiUjF08do=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ux726WXXASiqQg4wL50VF+gm3AluueJcDSpDt94rm+IzLpsKk23dwxEN9MxKPcONl
	 damIBe9mDQzOurhNXCXRhXwW/Xcx3JcQDRUdHOo5IBNc7cxX0FKKX8saWlEhKyEECq
	 JseHk+L74pK2IgH5o7unU8BoVk/9cuLQ1OKUekW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390984AbgF2V31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbgF2SlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70E023355;
        Mon, 29 Jun 2020 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418594;
        bh=iIs58fRuYkpMgTsFBKYFLGnGWc18yjUOw+YiUjF08do=;
        h=From:To:Cc:Subject:Date:From;
        b=gZn1jSr0/iGSqKsIu83/ocM3a9UieUOU60YFQnCWXsZdzlDGLVoXBWelYDUPUW1OL
         PMhBxLGwQxYeMGjFnycfsSx6vnwc8lqaIVTRL6QrNDYoWKbZBpa4WIbdCy4kVEwEbA
         5aHgzdzCM9cnnXrdVsBL8QqrVua/9JxunrZGHMS8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] arm64: dts: spcfpga: Align GIC, NAND and UART nodenames with dtschema
Date:   Mon, 29 Jun 2020 10:16:29 +0200
Message-Id: <20200629081629.13653-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    intc@fffc1000: $nodename:0:
        'intc@fffc1000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index d1fc9c2055f4..9498d1de730c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -77,7 +77,7 @@
 		method = "smc";
 	};
 
-	intc: intc@fffc1000 {
+	intc: interrupt-controller@fffc1000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
@@ -302,7 +302,7 @@
 			status = "disabled";
 		};
 
-		nand: nand@ffb90000 {
+		nand: nand-controller@ffb90000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "altr,socfpga-denali-nand";
@@ -445,7 +445,7 @@
 			clock-names = "timer";
 		};
 
-		uart0: serial0@ffc02000 {
+		uart0: serial@ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x100>;
 			interrupts = <0 108 4>;
@@ -456,7 +456,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial1@ffc02100 {
+		uart1: serial@ffc02100 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02100 0x100>;
 			interrupts = <0 109 4>;
-- 
2.17.1

