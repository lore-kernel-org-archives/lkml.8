Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664ECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44EA420849
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="a5Nc2U/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdQsXW+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbgEYEM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:58 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58375 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgEYEMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D49E958009B;
        Mon, 25 May 2020 00:12:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=AjstWz6QGrWfK
        MVU6mH/kwcSs8zFKnBr/OchzXq0rFM=; b=a5Nc2U/phyINb6gU6jODx/P0EFFlH
        AVUV1u7RYxUobC2D6N5n/UDhzLb0hyFlgJTUXxux88w9ji+B8GPW/HhIMhTWM0wN
        x8CHjZFkElnfxSoZj5BXwnES8jAe/Kc7eVhjo2sF1O1BSsvm37MR0vHMKUOtSn1C
        5iWtgYqyotSS7uT5kl8LYuAhiMemKOY7FR8TxZhoouIN28i9chZGTdc8/fwkmN7Q
        XbitCBh5WC7sFbpJHl2pNLdT7FGktrFxfq1gsqqR57yeGx6eJ6FJYwset9TVTi5x
        lxTN6PCWR0mMfn57J7TNnO+YBS9cJsQXpcJSY5NuukMHU4sIbxWbqXoRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=AjstWz6QGrWfKMVU6mH/kwcSs8zFKnBr/OchzXq0rFM=; b=YdQsXW+W
        42/N2tWUhXeZzhsFkANls8yinIJeLBfg655GH+J9XlrkYhd61A9F8pITSU3uYHHj
        i2yS6fw4BOeS9FbM2w5W5IHOlqZe/BcI5I2JjGiqIgT4GnqYhkMNBcINFwALvpH/
        GIqD6v3Id5qq8ZLagYlUKnpgoS26C/of5tlZKP/rdRq1Ni/kYB7Sn3jFgiZCYWDl
        m3uSc6RJZ76uqk7eBB6vauZZWTi1LyEbqq9m/yK4rXXrgJHAzns8eci+gyeNkMOY
        K5QT+w85cdkbyU1UfsS/gS0tCoxv5nxhPuMv/WSRjJvOpEH9edqVdCkn0CuSSjMk
        sBo7RA2gQwnK7w==
X-ME-Sender: <xms:uUXLXtXPT2kqpDtvJIiuElLzULxtVll_GBC-1dYjpjV5aob8Ur3wAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:uUXLXtn3BiLC5rqxs0kBABHo9zx9NDnf--UcBu9gJa05bKZ2mioQAw>
    <xmx:uUXLXpbVEGFB_MSQ9Q5zdS6Kw0ZYveo8Hv2YPmNkb_uMS3Iz8dNDbQ>
    <xmx:uUXLXgUhO7Otau32OP0wIgRYxc2HuNRWQFTWQBAm2NS6IVi_Stuidw>
    <xmx:uUXLXgc0aWpugkatrYSJSDLp98AsgZvUHSS-gKd9brtmnVerxJgSSw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C9B93066544;
        Mon, 25 May 2020 00:12:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 7/9] arm64: dts: allwinner: a64: Move wakeup-capable IRQs to r_intc
Date:   Sun, 24 May 2020 23:13:00 -0500
Message-Id: <20200525041302.51213-8-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200525041302.51213-1-samuel@sholland.org>
References: <20200525041302.51213-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All IRQs that can be used to wake up the system must be routed through
r_intc, so they are visible to firmware while the system is suspended.

For the A64, r_intc IRQ numbers are offset by 32 from the GIC IRQ
numbers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index c26cc1fcaffd..33f2ce0d93aa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1176,8 +1176,9 @@ rtc: rtc@1f00000 {
 			compatible = "allwinner,sun50i-a64-rtc",
 				     "allwinner,sun8i-h3-rtc";
 			reg = <0x01f00000 0x400>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>,
+				     <9 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
 			clocks = <&osc32k>;
 			#clock-cells = <1>;
@@ -1227,7 +1228,8 @@ r_ir: ir@1f02000 {
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_ir_rx_pin>;
 			status = "disabled";
@@ -1247,7 +1249,8 @@ r_pwm: pwm@1f03800 {
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
-- 
2.24.1

