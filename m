Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91B920727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583862441;
	bh=L/g69189loolLa5gwwsa6SGkomtLZ00efuDIf4aB4kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=htWnSAFQRsG+L9l0uIIXePIZ5p2EJhoUgo1VT0lgGrf+RGqlK5yJMIZGQmCH3zMxV
	 8sAJhQnnFGjBYYg2VUFD1vMcC+zyQYnIw53TPBhc3nHPgSLO+o/03hPlCXYGExUPw4
	 PKmYJ9ObGz6nzlOUbieAOpnJNQMl9YgC6zxA3RTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCJRrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgCJRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:13 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C4121D7E;
        Tue, 10 Mar 2020 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583862432;
        bh=L/g69189loolLa5gwwsa6SGkomtLZ00efuDIf4aB4kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9vL0XX/mfnj7A/ngBoRrJFrke2SgqrL6rNIKO8ipP5EycnLce+R+zi6GpfsvDK4K
         rhFg9MEplTMdnx7eZb3bvcQkonOPuqtF0xkijYIafz9k3xyu3NF/E3ByXWmXjifSvH
         sYABcsJGTdMGe3SoSZCXbvfDZQzzi21aOtdmsI1o=
Received: by wens.tw (Postfix, from userid 1000)
        id 2AC5A604E2; Wed, 11 Mar 2020 01:47:09 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: sun8i: r40: Move AHCI device node based on address order
Date:   Wed, 11 Mar 2020 01:47:07 +0800
Message-Id: <20200310174709.24174-2-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310174709.24174-1-wens@kernel.org>
References: <20200310174709.24174-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When the AHCI device node was added, it was added in the wrong location
in the device tree file. The device nodes should be sorted by register
address.

Move the device node to before EHCI1, where it belongs.

Fixes: 41c64d3318aa ("ARM: dts: sun8i: r40: add sata node")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index d5442b5b6fd2..b278686d0c22 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -307,6 +307,17 @@ crypto: crypto@1c15000 {
 			resets = <&ccu RST_BUS_CE>;
 		};
 
+		ahci: sata@1c18000 {
+			compatible = "allwinner,sun8i-r40-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
+			resets = <&ccu RST_BUS_SATA>;
+			reset-names = "ahci";
+			status = "disabled";
+
+		};
+
 		ehci1: usb@1c19000 {
 			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
 			reg = <0x01c19000 0x100>;
@@ -733,17 +744,6 @@ spi3: spi@1c0f000 {
 			#size-cells = <0>;
 		};
 
-		ahci: sata@1c18000 {
-			compatible = "allwinner,sun8i-r40-ahci";
-			reg = <0x01c18000 0x1000>;
-			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
-			resets = <&ccu RST_BUS_SATA>;
-			reset-names = "ahci";
-			status = "disabled";
-
-		};
-
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.25.1

