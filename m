Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6BEC35675
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FFC21741
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="jKVtAAij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kfeFJ6aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBWEI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:08:59 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34511 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbgBWEI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:08:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9AADE6BEB;
        Sat, 22 Feb 2020 23:08:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 23:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=AcgxSqlCWkKGE
        qvHRPWCaLXEYKTOg925jFKVUJEaaK8=; b=jKVtAAijC/zGl7aUchD/g2I7aAqEP
        LUYwpZQiaxsQnjq35Q5kHTDYyoHq12vri72YPQ80Ra0vbV5ps2MOotVmHyeCOmJ0
        MxpAmpKNVaOx11LgI9cnWHSJZishl5f2Dx5Vi6CN2jNhgtJa6mH7fGL0ogcJ+Kew
        YcQ+hg6F3hegre/Xt4yHQcgIquQG/Xhs8VFIxwthGGgbKug4KtqSgN/h16w2/U2Q
        H4Q5MrxQU/UAnPPnsDmTz55lvQcY3LHPJ425BTdUqIxRrEzD2rwT44ZQ5ImlJsjL
        NgYmCBoGgiO5H8puGHYV7slTeEoy2+Ymk9/DfCuwcu2eGYsDre6/gfRHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=AcgxSqlCWkKGEqvHRPWCaLXEYKTOg925jFKVUJEaaK8=; b=kfeFJ6aJ
        OCFb5DtqV/1sk+FGqQI+7eGVa9mqDh/m4Ne8VwlUAXCHuHinl7XgMauf+Jtc1+A9
        odtyxQF8va1BjElMGCusF0g+VbhDfTD+ni/1Aj6TEhAOqzohv6Ws7983H6HRWGGE
        VL/FagQGfgn5jHUhSHuipJLUT5TkzPlvqbqYVTiaJPjHAedtHfePx80L2d2rW0lW
        UIb/isjqZykGi61T0n7YWkwtK3i8EJuAjcD9w6U4k3kFk6GiVjgJ9GlgRucvCK6H
        49xHkw+2SyGBGpHA5+fDqn+EjuFEx5BI3DUt8JDMBYfsY9ohcTDOYrbUTLJi8j3b
        J9bhWg74MQ358A==
X-ME-Sender: <xms:2fpRXgBjFNqA04hPz--IF90thUAIYScwrUFed4bdSmyyFReLUtOTJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2fpRXojGM0gzEeHPeoBOIf2sUERrstrv0W7MJC4onaL9u6EiAqlMUw>
    <xmx:2fpRXhOuEmw5c1muLsjRRqVyrfeB8-_-xa722J2yqEjYLDmI7IO-jA>
    <xmx:2fpRXh55t-etPO6oVKzb3l71kVDgb786v1AWsSZ2PIMDJoiFP5WMDw>
    <xmx:2fpRXl3fD09LOLQ-VH8Ibn-ANW-EQgYHT7oWWDeYYjcwSm_Pmq1jJQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA0A23280060;
        Sat, 22 Feb 2020 23:08:56 -0500 (EST)
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
Subject: [PATCH v7 5/6] arm64: dts: allwinner: a64: Add msgbox node
Date:   Sat, 22 Feb 2020 22:08:52 -0600
Message-Id: <20200223040853.2658-6-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223040853.2658-1-samuel@sholland.org>
References: <20200223040853.2658-1-samuel@sholland.org>
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
index 862b47dc9dc9..18492b542260 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -545,6 +545,16 @@ crypto: crypto@1c15000 {
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
2.24.1

