Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69065C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1A820787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585278278;
	bh=+VivrJSNavP7dQm9czqzrLUyFrtNJAC1T71ZuCbvtck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qp19boFY1GBjisJ2V+XrMRte4aDAbglYoXsfrd1EMkcDwqsMDfUGQmSmfBRgRbO6C
	 zJo9o5aFav1o0NA8dNoqwoa9sy4ZwVkD9dGwyMW/UaciXwxoKmFOZlzdhovOZ1K726
	 3mqFJ+IPOnN3K2KA4CrUgGX8BFrUyOH8jmuYYE7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgC0DEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgC0DEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:04:34 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8D5214D8;
        Fri, 27 Mar 2020 03:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585278273;
        bh=+VivrJSNavP7dQm9czqzrLUyFrtNJAC1T71ZuCbvtck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/HRdYG6988iHf1qykXbWpHCWlswl5wLsIIfo7NL5dZRLNEqfamLUo3bC2zP/mueF
         wQce0bC13NDPNDt06K+pbRlxff3uWP/b5xRgNbSv1fm7t+pnMC4UNVCDkC0VYBI+Mq
         fGQbo+LhGKCEMRglJT6mVikWUcRv6SWgLakChrS0=
Received: by wens.tw (Postfix, from userid 1000)
        id 6340860141; Fri, 27 Mar 2020 11:04:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: rockchip: rk3399: Rename dwc3 device nodes to make dtc happy
Date:   Fri, 27 Mar 2020 11:04:14 +0800
Message-Id: <20200327030414.5903-7-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327030414.5903-1-wens@kernel.org>
References: <20200327030414.5903-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The device tree compiler complains that the dwc3 nodes have regs
properties but no matching unit addresses.

Add the unit addresses to the device node name. While at it, also rename
the nodes from "dwc3" to "usb", as guidelines require device nodes have
generic names.

Fixes: 7144224f2c2b ("arm64: dts: rockchip: support dwc3 USB for rk3399")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

dtc also complains about the usbdrd3 nodes not having regs properties
despite having unit addresses. What can we do about those?
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3499d1497127..90c27723cec5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -403,7 +403,7 @@ usbdrd3_0: usb@fe800000 {
 		reset-names = "usb3-otg";
 		status = "disabled";
 
-		usbdrd_dwc3_0: dwc3 {
+		usbdrd_dwc3_0: usb@fe800000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0xfe800000 0x0 0x100000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -439,7 +439,7 @@ usbdrd3_1: usb@fe900000 {
 		reset-names = "usb3-otg";
 		status = "disabled";
 
-		usbdrd_dwc3_1: dwc3 {
+		usbdrd_dwc3_1: usb@fe900000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0xfe900000 0x0 0x100000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.25.1

