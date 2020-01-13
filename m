Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C31C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF172082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hru3Yt7a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGyPVWuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbgAMEtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:49:52 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45527 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387613AbgAMEtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:43 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id F2FE96591;
        Sun, 12 Jan 2020 23:49:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=SrzKOkLSwyAw5
        L9dj6C7jHF7WcI4gH8AwCRGv5SLZvU=; b=hru3Yt7atFl9GBt+GCtCPdBmDUR9R
        JFsrya4klAomB+LvN5NPEpMSccZh8GRZk8f3xh20zGGhbzVPqqHZKVBfayYNk4y3
        SW8EUBPQps+TQJnwtmAJJJA36EM1n/9tJItjX96FlaQVdPDujRWhiPp4gY58e4vN
        W/QXV6/NCu0NWthbHDzRS5eezxwYtOMrtDTOZMUhkE9LqyaYg83o06o3wUilMqK2
        3U3lAlqO3Mtvjg0deA3y/0mOX6XbNtagd4HaYaAoi3lPcLvFrIl+D8yhjvTHqETH
        JgZVXM+UOONjbtxSoYMVv/v4mu/SHG5y2Y0af1OUwHPPtlA0/FE7o12Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=SrzKOkLSwyAw5L9dj6C7jHF7WcI4gH8AwCRGv5SLZvU=; b=mGyPVWuH
        DroLBHr2/I3FUZxIhEsoxeLkyfSZOj5sNrZTA2IzaJjWWyN1JuOAkAx0lkLxAOh0
        RNykru32xUuhC5DT9504IHKi38fZGJx9w4C2Atlgh+bn30A2ywhqgwADcmQv4Mvl
        iC0noBfdQdq34LY5skGnmqH40K+YGfKYaPQCQqpb/ridLzj/CaVQuuGkJ2PvQovf
        Zatll07XFvDdfwwy2QBhZzWh9hKhl56fNKOCYwaGjQ9oEyudF/dxu6uJVCzGFe8+
        vw6mTSa3hH4lBl0I+6pJ5ZYIg4WizFfI3j9h299I7jULWCjj+f6YCjZphN/BT2Sk
        Qo28wD5gnkJAAg==
X-ME-Sender: <xms:5fYbXgQZ54lwgcfP0Mx3-fpGdpmdMxcN4ITSf6zfletW79dRO_DzoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:5fYbXp6JbeoyAnyP_VcuG55H5Vy0CLYw7dfhC9eanTV04jnCLX7_3Q>
    <xmx:5fYbXnGoRNmMJJ5gb0b9JlYRRRMu99skSrVS4L3JzeyhAr3Gc5TC_Q>
    <xmx:5fYbXjGjoMuvqs6u2w2fm7hZ1PM9fZCvY_KpaMG1oOrBuKVgkLwqCQ>
    <xmx:5fYbXp3DnwSLWT5Wok4N1iZc8VswLvYOaJPsy6e1AEXEZlM_CNfXmw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3EDDE30607B4;
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
Subject: [PATCH 7/9] arm64: dts: allwinner: a64: Move wakeup-capable IRQs to r_intc
Date:   Sun, 12 Jan 2020 22:49:34 -0600
Message-Id: <20200113044936.26038-8-samuel@sholland.org>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 70f4cce6be43..7b2cacc0aecc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1044,8 +1044,9 @@
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
@@ -1094,7 +1095,8 @@
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_ir_rx_pin>;
 			status = "disabled";
@@ -1114,7 +1116,8 @@
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
2.23.0

