Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08DBC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8620721744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="A7ihwOn9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvrKjUhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgAMEt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:49:58 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42137 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387615AbgAMEtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:43 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 94A7C59EA;
        Sun, 12 Jan 2020 23:49:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=8AqTt0s+nWzUs
        USBLaiZYq4YnGomy2QjysCCyqzWOoU=; b=A7ihwOn9nV/1HcNKs5AXZcdfksKfK
        8cNegpmGsc7s1ytMfij5BbDOXHokrAXY7dtMeFgXsgioo2HjL+wIsP9aR/xirvhT
        zxYSvSr4YdDUAyKi3ntTfWMSgtifOnIK4SqtH+ouimDRtSWXYz1s03/izvu4Vdek
        OVseO0BucXuNf0Q+Yf9F1junaZyYdgJbcTvdip5LRzI4u4IR1TzY1ieD+qf6V7DE
        9lAbQpx2iK5WXET8CqkA2zx0rFS10Kl1303jETJHh0QBzm7eRbyqmC+207rnKf3l
        X/DhcwxEAydY5CHNA3BDK4BNw5DpPg6iH9gxPT21kGQP91vG/sRCDuGSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8AqTt0s+nWzUsUSBLaiZYq4YnGomy2QjysCCyqzWOoU=; b=ZvrKjUhF
        jSurR8QJXFZ7emsATjBCQo5bnC9WBtehJZZTeOaZA9CkEeaMz8OeHexANiMfmhdP
        PFxywPQyKPE68MJvhSXTsd3vUed41NMzDpuTRQO2/GKsDJ30ZqP7qBGJ46zoyWYi
        daOmdwZK4iFaCGtHVSS/kx0n0ESLgYZPl700gjTzKOFhmldsLZF8LsF1S4nx1/1J
        l1h0tmYd6/vsbi+s9GjOz2SD9mQHVgibueB53at3v9kFhYfi7zvfxnd708JvBBWt
        rvZN1PkynwzPDm6Y3txcJe8OMFxdVkNzQt4J5Bbjr7MBD/Nu0ZbXhxmtZo8HPaGS
        fN0vaZ28x90kQw==
X-ME-Sender: <xms:5vYbXgEDER3oAtHt8XN25EXAR1LagBRKMVltmkFVJGNdQ6C8d5FQKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepje
X-ME-Proxy: <xmx:5vYbXuXKApK6dqjPYwajXXvt-Jxt8F0l754nXTS3cqoH4XsZJFpwzQ>
    <xmx:5vYbXrDoAmp6hM9uFvdZ0gY1PUc2oxq3_RtBH7uZq6znLXv_HIxAlw>
    <xmx:5vYbXn12Sbd9feTBA5nOoGfG2cwVi6vM_YEeCHzOr3aFYh-qblAbrg>
    <xmx:5vYbXmXf7iWZHIGbx89TR9UvAdnOHKyYAifbueppuIzRYYARFYC8sA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D468830602DB;
        Sun, 12 Jan 2020 23:49:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 8/9] arm64: dts: allwinner: h6: Fix indentation of IR node
Date:   Sun, 12 Jan 2020 22:49:35 -0600
Message-Id: <20200113044936.26038-9-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113044936.26038-1-samuel@sholland.org>
References: <20200113044936.26038-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node was indented by two tabs when added instead of one.
Remove the extra tab.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0d5ea19336a1..f597f3fe06c1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -766,17 +766,17 @@
 		};
 
 		r_ir: ir@7040000 {
-				compatible = "allwinner,sun50i-h6-ir",
-					     "allwinner,sun6i-a31-ir";
-				reg = <0x07040000 0x400>;
-				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&r_ccu CLK_R_APB1_IR>,
-					 <&r_ccu CLK_IR>;
-				clock-names = "apb", "ir";
-				resets = <&r_ccu RST_R_APB1_IR>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&r_ir_rx_pin>;
-				status = "disabled";
+			compatible = "allwinner,sun50i-h6-ir",
+				     "allwinner,sun6i-a31-ir";
+			reg = <0x07040000 0x400>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB1_IR>,
+				 <&r_ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			resets = <&r_ccu RST_R_APB1_IR>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_ir_rx_pin>;
+			status = "disabled";
 		};
 
 		r_i2c: i2c@7081400 {
-- 
2.23.0

