Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B59C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD55D20849
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Yl7IF+bM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RoQfArFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgEYEMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:51 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53583 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbgEYEMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EFF315800A0;
        Mon, 25 May 2020 00:12:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=wJMeT4ENSLLpB
        HK49G1o41GE6X/5CEDc5+ipXnujXfI=; b=Yl7IF+bMFu0sswGGRCePp+xZSgLfj
        sMV0WWj51z/LC6/UNjoQtEY+1hjKalQhIen/pOAPP9XZug070dVpMjgCXXeVW1uB
        XeD6bpt27McSAv7pZaQeu4yEnOweMaxD9tZyOOtY1vQTgjHhmbz6QGKp73+eqxFs
        DBmuy7AhonKAAlqPZJ5ErmfW7aGvrLldz4rpafF7nV7te1Oe0Akw3gpesnY4LhiA
        02rzo8xiW0oeobRCpakFqargfcx4u6OBuY3RRRFv9DwtMkrW9s0Dl8kVxd9DLuLu
        yNW7f+0PkLMIajHRjVfu1eF7QY1ehrbWKnmbS2cwrGpU88oumETqVJ1Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wJMeT4ENSLLpBHK49G1o41GE6X/5CEDc5+ipXnujXfI=; b=RoQfArFD
        3faJa/wAUmmEa3OzGhLFBtgPQXJ4ObqjKPtHVS+FHQdMGLhBfIcDmdhxXQSfpqts
        LMrID+0/BIqEfSc0MyIeXSdpFmZ7RGmi3CK4aQmpcS8vNSAvxIhbOs5NKCklEUpS
        KqMIu6Lm479WA4GSwNoa3VgesUyD0ZrFOev8xoYxJeujkpAC0sW6G/HqUjLBaHc4
        B/rXC10jEzr03nfqgB3K6FD0kb5q5W2EnLgUwEsh3VDpan3OqpdKVjOn/2prbJmd
        YnNHY2hEcd919Qcfa8MbI/1kNzMZI66qZAK68Z2X8WTlz9+bUbA09WoCG9IdVoTq
        KQQJDQD0DRR8hw==
X-ME-Sender: <xms:ukXLXpOw9VlbpmJP4oCcbCmqPuyl_I7HhhsKHFsW7bf1-U_Fc6d6ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:ukXLXr9cupOHN4TbEIROb-7gDyrGAdDsjNqv_rg5IOgA-PjJwpvVRg>
    <xmx:ukXLXoRvIW9L8vkkWQ19XQyNYYU8lYC3bN0v9MvDCz9PFwcT5Mil1g>
    <xmx:ukXLXlt_AOaYtFJEeh3S-9RNRo4VsCbTTQZls-UWTcWQQtpSTy5cGQ>
    <xmx:ukXLXiWGjG-FyTIytMikXi3Uwb9JJcj9x-c92HpbaKVyRbymOqD14A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 490783066544;
        Mon, 25 May 2020 00:12:42 -0400 (EDT)
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
Subject: [PATCH v2 9/9] arm64: dts: allwinner: h6: Move wakeup-capable IRQs to r_intc
Date:   Sun, 24 May 2020 23:13:02 -0500
Message-Id: <20200525041302.51213-10-samuel@sholland.org>
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

For the H6, r_intc IRQ numbers are offset by 96 from the GIC IRQ
numbers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d912188dc6ea..188699f47dea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -844,8 +844,9 @@ tcon_tv_out_tcon_top: endpoint@1 {
 		rtc: rtc@7000000 {
 			compatible = "allwinner,sun50i-h6-rtc";
 			reg = <0x07000000 0x400>;
-			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
+				     <6 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
 			#clock-cells = <1>;
 		};
@@ -880,8 +881,9 @@ r_intc: interrupt-controller@7021000 {
 		r_pio: pinctrl@7022000 {
 			compatible = "allwinner,sun50i-h6-r-pinctrl";
 			reg = <0x07022000 0x400>;
-			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = < 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <15 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
@@ -904,7 +906,8 @@ r_ir: ir@7040000 {
 			compatible = "allwinner,sun50i-h6-ir",
 				     "allwinner,sun6i-a31-ir";
 			reg = <0x07040000 0x400>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB1_IR>,
 				 <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
-- 
2.24.1

