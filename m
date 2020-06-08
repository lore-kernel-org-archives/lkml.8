Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D82C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E26206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663151;
	bh=zjxfOe4pKKBJrhJOeTzaHRdyYwbM0wUQuUKpouCfJ5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggMQidDTAhlh62x41xm5su5NWHzS+7FX4jdJ8H0hHz+erKQWSPHwS0oFNYLbMG3k1
	 hY5dDDbr/r0td5ZOW9d5q6q7U5Ht5K/UMmfqAtkTpprQBCIr/iBufaDMwQ5lHE9p5/
	 OQREaWw/FHurwiU4FP01/XLaY8QA4VXws1vMWem8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbgFIAjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgFHXN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234452151B;
        Mon,  8 Jun 2020 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658007;
        bh=zjxfOe4pKKBJrhJOeTzaHRdyYwbM0wUQuUKpouCfJ5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feUt2CLgWmvaKKqh/7EDgogRqem6wVp2I3Hj/GB0xBn0RYIeJAw1DCgMZkaK4/1LQ
         e3SkXJxHTGS4EqFfzAUWZntEUXRS9cjbcReamWvmjCoWzsfflPXc1w/kVZCOwXJb/F
         cOL1oUkGItowkAPvl27Xw/haxgtDnlnn3CMeFS0k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 063/606] ARM: dts: r8a73a4: Add missing CMT1 interrupts
Date:   Mon,  8 Jun 2020 19:03:08 -0400
Message-Id: <20200608231211.3363633-63-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0f739fdfe9e5ce668bd6d3210f310df282321837 upstream.

The R-Mobile APE6 Compare Match Timer 1 generates 8 interrupts, one for
each channel, but currently only 1 is described.
Fix this by adding the missing interrupts.

Fixes: f7b65230019b9dac ("ARM: shmobile: r8a73a4: Add CMT1 node")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200408090926.25201-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index a5cd31229fbd..a3ba722a9d7f 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -131,7 +131,14 @@ i2c5: i2c@e60b0000 {
 	cmt1: timer@e6130000 {
 		compatible = "renesas,r8a73a4-cmt1", "renesas,rcar-gen2-cmt1";
 		reg = <0 0xe6130000 0 0x1004>;
-		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-- 
2.25.1

