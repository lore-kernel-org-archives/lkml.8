Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D19C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4EE24656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hNr8Q1LN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bsQJNFtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbgAMFTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:19:11 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51379 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgAMFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:18:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5854E6126;
        Mon, 13 Jan 2020 00:18:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Jan 2020 00:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=XV5JCk435bYmn
        5TtUbjEpZov0Q3bQjAnZltxpekEahY=; b=hNr8Q1LNpNeh0s3i6pRfY3tsFJ9iV
        raZ9mth82VU9MIcFxldKNAz2QdioG8J1gQeRjTofoZoSHXa3JgAr1xyiMLzLtPaK
        Xhu2/4vhUVbw2hE+1L0+FC1IGessg7iz7BKgdqdqrY3BjQlIJ0ljf2TVU1XuHTb+
        RtCltQw7H/R2G6lI2B/S7hvNic0hN4ggomQFvOurgvSnlV/SNEijoDeaGNrSuptK
        ApDKNcI6pLIufczWuLyCmQSUSmF4ZUwl+ObvsS57Xz/sTiZ5gPLQVUIbmR1Dfypx
        n7LD2AtuwreHVB98IgFuwIpMcDnI4efGWBv29rRqdC43mTFh4dTgt/Aew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XV5JCk435bYmn5TtUbjEpZov0Q3bQjAnZltxpekEahY=; b=bsQJNFtU
        vwE4oln5VhixFgIn+ruOIbrwf0X0U5DNjnducNmdOUflrsqLkYf4rLfX1mFxnrHy
        8v0ETX3jmemY3K27b4KK24cL7TuTJKA5doXvHRFpXeZTLsC8+bYzp8A1XVN6Ta0B
        8/g9/UYfAW4E4gz88Lo4DDKA53iHN0AnJHYTHa+Y2w2XD2l7O4vPTd+0B54EL2o4
        th66VMf8ONUcahh26szr0KtTUwwnz4tK4Gzj1KI5CsZ1en++xKeSrAwT+n9EsOhJ
        ct9kHGeFBUy+9FbndwbHZgWQi/iY7bttmaUhaByicN62fyewVG051bxUgNkJ5WPm
        qWiDc32euh/jsQ==
X-ME-Sender: <xms:v_0bXqZsX9-7kffH0thdks1oFizVvEudQvLpd64i-6dset7oyKoXAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:v_0bXihbpQ4jJYtnumDai_VJJ0yZV2LTrQhIl1dVwcFrvQaOIz76dA>
    <xmx:v_0bXn6X_wFJIMQJm6MLp-KxZQhUUAXPf1EpUlPgEL2UkjLNV2XzEA>
    <xmx:v_0bXir9YpvgYU3rcJZ0bMz8RpGIIxkVqZAuUmGAgs23xvymYnwTzw>
    <xmx:wf0bXl8WLqsCMlEAa-VYi4qkehKy1bwGOB9oxTdlFUlZlTZQsDVzKw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E8A43060840;
        Mon, 13 Jan 2020 00:18:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 5/6] arm64: dts: allwinner: a64: Add msgbox node
Date:   Sun, 12 Jan 2020 23:18:51 -0600
Message-Id: <20200113051852.15996-6-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113051852.15996-1-samuel@sholland.org>
References: <20200113051852.15996-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 0287d8458675..690f0a7d9cfa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -487,6 +487,16 @@
 			resets = <&ccu RST_BUS_CE>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun50i-a64-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-- 
2.23.0

