Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017CDC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC41E21744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="HxsCuqVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIb4SqWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgAMEtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:49:51 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60843 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387622AbgAMEtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:43 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 360C1634D;
        Sun, 12 Jan 2020 23:49:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=dURdrtn452X6F
        w0Ia0mRb8PvrJx/GMnv+qVHdfETAAU=; b=HxsCuqVIaoBM5XwmjaMSxKwK/lEiJ
        1m+31P/cV1B+KhwQwSAPSkv30oh8Cmyc5qLjUmSadEY4LsiFhyXkhcX6DziEus8B
        uGbyrt6/zoyAlyr6FdVCGuqjx8sCqcvQac2xZNj6PYHEnEQMZHLYv/SFxXShsaxZ
        YdX1jSQ0K6d/aJniLWKwX62FjiWRQPS1qnj/pPHzvdsNtLdITc56UHNAqPbZ6qVu
        t5XcZEGJhhH2PNbgolNoIGloGKr/0G87yptdttqzmPH/3FYoZsIFCxoRO7U1zN4b
        ZvxWwCWRjVvdb+Y5Aef3vVIkWQCP/FWiS4ipf7UST6GmSBayPzYYIo1SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dURdrtn452X6Fw0Ia0mRb8PvrJx/GMnv+qVHdfETAAU=; b=GIb4SqWz
        86IvFzw0ouaCtPMknPovJhMWHSwJ5RGojxrmKtZ6ZZloIuUNZcS2ik8tOIFn/3lE
        UA9Yuc0JS9v2TcXodjtBQt2cBsrEpASeRpo8Le/1q9gOruwKomr0sezIjA20XzcT
        3CujphF15JknX8DsQpghNOQ2j6K2zSv3nhLL3QJ41e/nJ5kiuF0lTDtHM5sY/l8H
        wvEQ2Lnkv2tUkuYCstLsfFZZHwpp9jcC9I0GqRhAJSN6L6M37xzw6Pd4mK7OvV8V
        dOhYMeW+DVPUWjkXfYEN9t5i8A2ygSLtzSj37BTDPG/5iD3NqLWoK3sD3Zi8aUUt
        Ju07Lk3dOXlGgA==
X-ME-Sender: <xms:5_YbXtJvoXkW1YbvmDqkp4RYYfmvn_2QArteWRXux01CwsUQKgHaaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepje
X-ME-Proxy: <xmx:5_YbXg7Mle6q50yMXuA7SQfvLGpgv-adJo_EuWuoUtiBeq9XEmODDA>
    <xmx:5_YbXozxZdbMPGzwp1u3dHscQw-gjlGm0D3Ysku6TNEmWe6jfmFP5Q>
    <xmx:5_YbXsYhDQCFKgPMxc33HTWq0dHWrKlh4-DloudvkbBVs2HZVCHT7w>
    <xmx:5_YbXsYzxB5ZId-EAqOAgJh-Ylqesaae7FILT3EBL921F2A6rbUP-Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7582630607B0;
        Sun, 12 Jan 2020 23:49:42 -0500 (EST)
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
Subject: [PATCH 9/9] arm64: dts: allwinner: Move wakeup-capable IRQs to r_intc
Date:   Sun, 12 Jan 2020 22:49:36 -0600
Message-Id: <20200113044936.26038-10-samuel@sholland.org>
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

r_intc IRQ numbers are offset by 96 from the GIC IRQ numbers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index f597f3fe06c1..6285354e83a6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -708,8 +708,9 @@
 		rtc: rtc@7000000 {
 			compatible = "allwinner,sun50i-h6-rtc";
 			reg = <0x07000000 0x400>;
-			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
+				     <6 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
 			clocks = <&ext_osc32k>;
 			#clock-cells = <1>;
@@ -745,8 +746,9 @@
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
@@ -769,7 +771,8 @@
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
2.23.0

