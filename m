Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3138C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CA3206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466644;
	bh=Tt9I5dS3JeAJvU2sRBG7+iIKUeVdnCbPfw8XBTvHkOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mCPReNjPgIB7lgt2ZXeF6CADc7wuVbDzMcahkavJ+sLLQzVHP9hK53Dzd9DffP0kD
	 Hx7zP6hPIFDgu5bEqAwfdXAPug9J3ayNd16yL2BZAcmrESQwK60ysgqHfA2h8Mskmr
	 MHlGWEDlGBFuQ961hDjeSMy0mcMaGgtwFapuDP30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbgF2VhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgF2Ski (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAA723358;
        Mon, 29 Jun 2020 08:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418624;
        bh=Tt9I5dS3JeAJvU2sRBG7+iIKUeVdnCbPfw8XBTvHkOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3w/jW0sfpY78qC1W4n6OjPGfllVKlWaaK7SOpQVQopV6Em32krY/i5WIrgMV3qLk
         vp14DQthtenP6sNr7r3+P61E3WmqI0okr9qg/iwMv2dcxDNmy3nxgzrPaz9GmOZpnA
         NyZeEKzl1pngW5YhOIISNKGHKp+p8Au1+oLpdHvA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] arm64: dts: hisilicon: Align UART nodename with dtschema
Date:   Mon, 29 Jun 2020 10:16:57 +0200
Message-Id: <20200629081657.13821-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629081657.13821-1-krzk@kernel.org>
References: <20200629081657.13821-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    uart@f8015000: $nodename:0: 'uart@f8015000' does not match '^serial(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 2072b637b5af..3d189d9f0d24 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -302,7 +302,7 @@
 			mboxes = <&mailbox 1 0 11>;
 		};
 
-		uart0: uart@f8015000 {	/* console */
+		uart0: serial@f8015000 {	/* console */
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf8015000 0x0 0x1000>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
@@ -311,7 +311,7 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		uart1: uart@f7111000 {
+		uart1: serial@f7111000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf7111000 0x0 0x1000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
@@ -325,7 +325,7 @@
 			status = "disabled";
 		};
 
-		uart2: uart@f7112000 {
+		uart2: serial@f7112000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf7112000 0x0 0x1000>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -337,7 +337,7 @@
 			status = "disabled";
 		};
 
-		uart3: uart@f7113000 {
+		uart3: serial@f7113000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf7113000 0x0 0x1000>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
@@ -349,7 +349,7 @@
 			status = "disabled";
 		};
 
-		uart4: uart@f7114000 {
+		uart4: serial@f7114000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf7114000 0x0 0x1000>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

