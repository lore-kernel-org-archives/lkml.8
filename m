Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F7E207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="QKlgVXeT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYSHueMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgEYEMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53583 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbgEYEMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4915158009A;
        Mon, 25 May 2020 00:12:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=scAeKOYN6U1Ep
        ihzAYCDSCBuXJQThd3gMwznYbjUp64=; b=QKlgVXeTBTKYzX+99X7fuyyftVqEi
        YHKebWsTTM7VUqBy6k+PQr/7URU56au1gstNXSd/0iwaNUBzoaDyDTPE0GTQAg9n
        RUW+8C/REy55ZWUVuQg/yJirz9qN4uA+Lzz6xb+17VkDd6aTZ0oW2hbnIOABW3q2
        4Ikr4jDpsK2dbOAfR1/I+OkwXFMxba3D6EXAzFP3+YmP1S6uQVyGtaQpwIum84Sb
        8zqC2kHhIDpdNqj9HGTT9XstFceh9rP5XHEYmgPpgT/mK4d+YJMpd5xLUPdkHadX
        t69MqGDg2XhvJI9RYNohY4pNzFn1mfiLmhNtX4tp7BKAG5ZRjkGLpRvfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=scAeKOYN6U1EpihzAYCDSCBuXJQThd3gMwznYbjUp64=; b=GYSHueMv
        eZ8mCWKynobadXi7+EDZFHrNIM5CqzyRfDOgua+D6D3Cp1tTYz/oyICBl+eL2l7M
        g7C8+MKAJQVRc9xcdSk3qlYE+YRq7Lvva+ff/jXcmYaPHvNRa6nF7mZsDEptp/1z
        uzQUKBI6E/qGvGvcrei7yjKagvGiOIGDovsKGLVIdEKKNFaAEHaQvULNhslGw17A
        hbjitOAmjx5dRmwnPie35Om0sO77gYJUJcGgSm8Jzs3BcBOVn6PpZIPq/2kG9CH/
        5HjFmed1VjSvvxDz/ha0ksPCl2+AjmD5AcC98+LD3eqIK5E/nljzWvMwSwTzuGmt
        AkxTnYhEJqXECw==
X-ME-Sender: <xms:uUXLXl0SjhvXl9MV9hT61lL75JIX9RjzDdI4ymSFNN0j9n1rHK6PUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:uUXLXsF7rzslzZgfQtXjej1hQqAq44H6wxQh0wTAysbmXy-3-57CLQ>
    <xmx:uUXLXl5vM368Lxmej_6WpsiR7L6qeUtEd228QJfp7JyIVmtKLPRxGA>
    <xmx:uUXLXi1LgGWNHo3tXDqPC0unslR1mqrgaB28Ds7sRLt9MNT8hb6xPQ>
    <xmx:uUXLXg_pulQUyByQTya18rvkF8dIeMMVspWDXechrI4bpUHkkUlSUQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 995E2306653A;
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
Subject: [PATCH v2 6/9] ARM: dts: sunxi: a83t: Move wakeup-capable IRQs to r_intc
Date:   Sun, 24 May 2020 23:12:59 -0500
Message-Id: <20200525041302.51213-7-samuel@sholland.org>
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

For the A83T, r_intc IRQ numbers are offset by 32 from the GIC IRQ
numbers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 655404d6d3a3..fcfc573eb96d 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1130,7 +1130,8 @@ r_cir: ir@1f02000 {
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01f02000 0x400>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_cir_pin>;
@@ -1140,14 +1141,16 @@ r_cir: ir@1f02000 {
 		r_lradc: lradc@1f03c00 {
 			compatible = "allwinner,sun8i-a83t-r-lradc";
 			reg = <0x01f03c00 0x100>;
-			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>,
 				 <&osc16Md512>;
 			clock-names = "apb", "hosc", "losc";
-- 
2.24.1

