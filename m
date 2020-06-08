Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7600FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B55020823
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658170;
	bh=BhGOM1jW327fu3Be7hLYIarcEr4CmakEcQukh31BnIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvHce0MHed4wYrSzSaGhKPe2BM0X/XkdpugiS8R9grSO0XoCC6jNBKVNbNMa2gIKG
	 CHOFcXi6PuoeXd4b7RQnLaeSdBISPrEIGqiAtm6tP+J/OSJzvyaINmUqkWzcXf12z8
	 zoKiONRwKo0/af6NucMAEM7e5jF/uKAkx5auOxis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgFHXQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgFHXNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A081208C3;
        Mon,  8 Jun 2020 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658005;
        bh=BhGOM1jW327fu3Be7hLYIarcEr4CmakEcQukh31BnIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WD8+x1z1um0Me4sbVFCI0qWQ8vzHHjZ8ls737WCW+picLCZHRpPTD67HX5rI5+CDC
         krA7c39vP6m9cxDuKW3jycG6dlYA0l2g73swytJrhn6ouQ14WnbslsKyvJ/fZ4KXhj
         DObTQi/J9PTovkPwuwrcHmJXM45z5boyV3Rfy0Vs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 061/606] arm64: dts: rockchip: Rename dwc3 device nodes on rk3399 to make dtc happy
Date:   Mon,  8 Jun 2020 19:03:06 -0400
Message-Id: <20200608231211.3363633-61-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

commit 190c7f6fd43a776d4a6da1dac44408104649e9b7 upstream.

The device tree compiler complains that the dwc3 nodes have regs
properties but no matching unit addresses.

Add the unit addresses to the device node name. While at it, also rename
the nodes from "dwc3" to "usb", as guidelines require device nodes have
generic names.

Fixes: 7144224f2c2b ("arm64: dts: rockchip: support dwc3 USB for rk3399")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20200327030414.5903-7-wens@kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 33cc21fcf4c1..5c4238a80144 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -410,7 +410,7 @@ usbdrd3_0: usb@fe800000 {
 		reset-names = "usb3-otg";
 		status = "disabled";
 
-		usbdrd_dwc3_0: dwc3 {
+		usbdrd_dwc3_0: usb@fe800000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0xfe800000 0x0 0x100000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -446,7 +446,7 @@ usbdrd3_1: usb@fe900000 {
 		reset-names = "usb3-otg";
 		status = "disabled";
 
-		usbdrd_dwc3_1: dwc3 {
+		usbdrd_dwc3_1: usb@fe900000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0xfe900000 0x0 0x100000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.25.1

