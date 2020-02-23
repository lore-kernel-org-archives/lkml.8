Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B5C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B8E208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="eG/cPJm1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oxelx4G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBWEJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:09:00 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50741 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbgBWEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:08:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1C6846C17;
        Sat, 22 Feb 2020 23:08:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 23:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=94YtxdflGeYMO
        W0HwTF5Rysy837bt9YAGEKY/eUFxaI=; b=eG/cPJm1DW4Tv8TM5TC1JFX66167g
        11AALYogAMi7cAUab3SyYq60Q2h+yV8l6kZYBa9hxmef6kdG80YhJ55KEke5+/27
        hvxAWxRzsZyoJxjH2vqphikzlQrVBk0M8sCxji5fmrXryML+PrE+WtlLlx/J4MTl
        rAK+TYggWHw4sTSHAiC4pK796ZEQTNvVkrmU5UfpT37t5zsmx8cXoAkcAbyN+vJ6
        nCyi4d9KcwMgp1BXyIMHdOCm5ThnJvuUo8X7zNw9S1oiz4XpEg/lAdfkdH02R2rV
        Vkk6QRvTIc7TItG2j1wMaWhSUvStVZnp9uZ8t6YCG48dlC/0lUbEBTVdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=94YtxdflGeYMOW0HwTF5Rysy837bt9YAGEKY/eUFxaI=; b=Oxelx4G4
        wWT5Zlf/v7P0dZ4jG4JB1JIf5SECishSazhD34EkwNqKQGhs0drrfrcZ494Pw7Sq
        I/ofan10RJ4uqJU9AStRH+IqPoA1dt8TiJ/aiOYaY6Wiv845fqZVuIN7fEWWSk0y
        AhJDmJzB8EGo+cek0LF9lqgKgU2uJ3zQZYq7hTwlo+HLG0cNuKTsLYWXGCmdQGUg
        UeFNNpJKZEtQTFWSyOU/WTcpI8o8I1Amn2ygJr2Y3TTLU9B/RhzjvM9cZzdbWlTf
        MAl3VF3nTbp8gY85GqlmjnmIAKOimWzzEDnfDK8GA5LRs+4OcYPzm0ZR/nDioXUE
        loGldYgc10tRmg==
X-ME-Sender: <xms:2fpRXtUP1bH9_MSv7mGz_k2WXEZHY7SrFONl5jQ1tsdskdgSyp9HwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2vpRXlvtS51aihAp8GujzBXy4DmNTMWGcONfkUMlTCt6FWVME_U8Cw>
    <xmx:2vpRXo7fELQH7jzd0FA13kyO74mXIKQ354qNhx2ksLeh1gd2cMh9gA>
    <xmx:2vpRXgRCW2GwGKweIYXisObNmzfmUwy3MOAlImXZh3DUsq67IqZjEw>
    <xmx:2vpRXtXBF7a8T-ST3TS6b1lQXl4mCa6X6yyj1tQo0F0TEdRs90NQEg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6C2B9328005E;
        Sat, 22 Feb 2020 23:08:57 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 6/6] arm64: dts: allwinner: h6: Add msgbox node
Date:   Sat, 22 Feb 2020 22:08:53 -0600
Message-Id: <20200223040853.2658-7-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223040853.2658-1-samuel@sholland.org>
References: <20200223040853.2658-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H6 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3329283e38ab..46e2cb28c86b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -239,6 +239,16 @@ dma: dma-controller@3002000 {
 			#dma-cells = <1>;
 		};
 
+		msgbox: mailbox@3003000 {
+			compatible = "allwinner,sun50i-h6-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x03003000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h6-sid";
 			reg = <0x03006000 0x400>;
-- 
2.24.1

