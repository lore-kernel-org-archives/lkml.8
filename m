Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF63204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="v8dViW5+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVQ/Olqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgEYENE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:13:04 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38611 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgEYEMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B9EF0580096;
        Mon, 25 May 2020 00:12:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=0k0on15QdqSzY
        KsCWM4aNUcDIKxCa3l6xi36LL5uc+w=; b=v8dViW5+RC8U9PIHUYx0XmI0auV6U
        U6FOohxHwEpL4KNQMbIjBSdsaol65i9vvjd+hZtiM4zE6nPmEyZb1I1c4+/sLy85
        ogdAX/hqeSpV27r8H1P13MajSST1gpewzEK11QweKoRU9KiCBEZDiwKAGpnqtjQ+
        hPVEQlIuZNn6U5w+z1dqdKAdb7kB5f56gSsxFOwWvsoYYC1Ks2YqyEORwC6zWt3g
        ZYWbYFg7+P5tyIknEKnkOLsqBtVRl9EVT57VTPAt3WQLbEdTFkoEy6PkFycxxC2X
        9mIR4jyKjNAMqDKXjnfNJo5XlEzYbU3DH1OjxylHvrKG/bteFWr4juX0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0k0on15QdqSzYKsCWM4aNUcDIKxCa3l6xi36LL5uc+w=; b=KVQ/Olqe
        FriN+FqHHaPjzY6nzvHHuuP7qa68VKo4JH4dotCFGzR/WCOuyubV0TBvANjCDMPp
        hlhs86fp35IN3uXwJrSoev9tjALdvRxBX/LFkVgIY4EHfVj/VbJ8KIZoHSU0Xi21
        GJasvlwbVMBI+/JxgJd1kodHwDgmzh9/Rs/TInnc+CkOMjm/4tCqLrriLJjC/GY0
        /c721AsyRe7EqGYXUkZetJLUsbKbLVHCDpF3VkyDxp7KLfOVMDYuVHqSkf2xURqD
        fmPReouNOlnzWldHOxgdDfAuuMIU6oe6s2VFfnfZM0XMZ9HYgpEflrxfJH0iFRYs
        7ScVBUid75912Q==
X-ME-Sender: <xms:uEXLXtqx1i2EFDkEYdxHqorKK6FuFQdHSAcMeIwwMgpSNmbVUzA03Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:uEXLXvqxIbGgETr-b0aXH5UbGn-wq2PInBJoJ2zLzIrhRLhyfKzSWg>
    <xmx:uEXLXqO7F4e7HfARZ-rathsjvl66ZnKCcHFjq8YeDktbdcbcP-EtKQ>
    <xmx:uEXLXo7C1nCYWKsX4HwCQ7Mp1nIo8HnI_TPD_Zw0glHTitLgIHcJ-g>
    <xmx:uEXLXpwQkOk4R4iPvEC2r3xygq4H6B7scrDgdQ6Ffce8ZqEd2q0_Kg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1084B3066544;
        Mon, 25 May 2020 00:12:40 -0400 (EDT)
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
Subject: [PATCH v2 5/9] ARM: dts: sunxi: h3/h5: Move wakeup-capable IRQs to r_intc
Date:   Sun, 24 May 2020 23:12:58 -0500
Message-Id: <20200525041302.51213-6-samuel@sholland.org>
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

For the H3/H5, r_intc IRQ numbers are offset by 32 from the GIC IRQ
numbers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 94f648ad1c9e..93e7ce60a64b 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -829,8 +829,9 @@ hdmi_phy: hdmi-phy@1ef0000 {
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
@@ -865,7 +866,8 @@ ir: ir@1f02000 {
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01f02000 0x400>;
 			status = "disabled";
 		};
@@ -886,7 +888,8 @@ r_i2c: i2c@1f02400 {
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
2.24.1

