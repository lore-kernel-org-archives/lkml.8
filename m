Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57946C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280F12082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="O0epKHNt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9DbTNT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgAMEuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:50:03 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42137 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387588AbgAMEtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id BC6056575;
        Sun, 12 Jan 2020 23:49:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=cT5DH4Y/cI2uR
        DZ94AwJbRfWX/CG0Z1zt/cRrDOeXBk=; b=O0epKHNtsn0YQegQk+EYvrANG/06l
        ra8eHMZ69Ccoz0CS7iK+AMMpxTGIrPV0aEGTn9IxskOMeCIyW18AbToS8qe7pLIy
        nfxjn/ZvKY0jj7tRoMM+mKy1ZyYYxm7hpvCqT0dSkncigfdT0tKVoRpYjSP5glDO
        QK26v5rvq+q+HktPtWWKGtuQ2NM8f5rZoLSADknniwsTgjTDZc7nJDIOgcQLdkgl
        mQCMh37+rFqVUPQkm3f1mn8Fx6o+Y8t8o3Rs7D8YxS6v0MljfsUQmG3DcOwkRf4K
        mU24tQLosUqv8Yyb8cE2iaek9H4dFfYhFZF6oa74quIaAq7KJZ82WxIEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cT5DH4Y/cI2uRDZ94AwJbRfWX/CG0Z1zt/cRrDOeXBk=; b=X9DbTNT/
        SHW+fGP0JraZLdNsmrzERpYVoVPr8Fxtd2KwQeBUCs/WaZu7ir1yFcmDniNHQQ6+
        tluFJBA9+odYhEggCwiPh3dlqKYZ2C3dzqYeZCA/tgDfKASMGkm9sJSC25vaka/w
        4tHh2ZVR8onWuSUR2fpCK4R+o3B8kPYFz+1JqNJZQLORL6RdD5sl/SCs6yTYTza7
        0Cg2yNPn8W6YrA2eeGNJwnyx9xIsaa6bq74F3Zp74sxIbeU1i1BibUYzWKcgeCNq
        bAAp7lUK1wB3hK78Y2JuodkqE9P1McmiuUNqq+n4erxR2JMgyXekSZP3+ZgIAyJI
        255vsFULPti1Qg==
X-ME-Sender: <xms:5PYbXu7cW7x2DIE-U7OsMTAgEaebLy8Yquxp6dXhJ_zPBEKXeM40LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:5PYbXtT47VJRAokV9Uvt9QUTY3iTOmlIHYCx514X4OwxOz15Xw16gg>
    <xmx:5PYbXtpQfnNAdkSyBk355cDuLq3F0znE4SMom7wbymT1j2LXHTYPbA>
    <xmx:5PYbXrLbduElfCAochQvLYXqwGNQLb06SBdgIH0DjEumIdNHz2TVpg>
    <xmx:5PYbXi6f6oElab_1ZZRQYRyPZJy5_EHnl38Xw1Jpf4lODnOGNaYmUw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0734630607B4;
        Sun, 12 Jan 2020 23:49:39 -0500 (EST)
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
Subject: [PATCH 5/9] ARM: dts: sunxi: h3/h5: Move wakeup-capable IRQs to r_intc
Date:   Sun, 12 Jan 2020 22:49:32 -0600
Message-Id: <20200113044936.26038-6-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113044936.26038-1-samuel@sholland.org>
References: <20200113044936.26038-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All IRQs that can be used to wake up the system must be routed through
r_intc, so they are visible to firmware while the system is suspended.

r_intc IRQ numbers are offset by 32 from the GIC IRQ numbers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 62660108550a..7aca128cfe09 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -807,8 +807,9 @@
 		rtc: rtc@1f00000 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01f00000 0x400>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>,
+				     <9 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
 			clocks = <&osc32k>;
 			#clock-cells = <1>;
@@ -842,7 +843,8 @@
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01f02000 0x400>;
 			status = "disabled";
 		};
@@ -863,7 +865,8 @@
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
-- 
2.23.0

