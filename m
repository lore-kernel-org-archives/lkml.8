Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6022C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A329C214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="SF+KIf6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djup157o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgAMFTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:19:00 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49391 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgAMFS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:18:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 564855ED5;
        Mon, 13 Jan 2020 00:18:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Jan 2020 00:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=JeR0cnryoywMK
        HwISvSewvjFYfRlDvtFyO5FMfPy1yA=; b=SF+KIf6V6C4fNtr3QHDdrsPgXvUkr
        sHsLCaGsVcYDUNtT6hiIh5D+UV76PgnIbcvqR3McBWrX/9nERxBl+MR12WTLgr95
        k/F86sGWldCj0w8dyx1mh76nIoeQlrlGA5/sHDACGcUpVahI5wG2wztG1aWRE94F
        Ztpb+xbirJciAonzGyRrkcXQ+tE8/KapghllF9IjILVlfazL7WycEsPde9L0SVp5
        CWqYIHHwuslq73ME/1kbokX5XlOt1orbhGCpxJ+H8V6IPVx6BzLNPDnkrRoJsgoD
        p6Usdo34acYPDh5CNumUi01hpJyl0Fi8acX028zgsS4UWUILkSk0Am4eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JeR0cnryoywMKHwISvSewvjFYfRlDvtFyO5FMfPy1yA=; b=djup157o
        lJT9BXBHEOaBtjBeDWg8zdzV3cD0RYyz1pQ8p3oAR+FHxkcxmD1ZPtHGsjpRO6F2
        CbBnGW+/Eof6a1FlA/j/LLOZ3S51Y2rj9Bgcw9zetlxg9WURv/fcz40XL2Yj4TCl
        yDALHQBEgEx1QLJ/vVCabZaBPLin78lRBgm5mb+HzeKSmwuWKNBfwH8+6KpLrD98
        je8T12npTi5+1xrAAtnhAKbyzoTjGl33opaZEwCGC1jW5u62KNWcAEa6pycOA1MS
        L4fXXgvedvoiXG0OC6+rjJ7mcfL8KskwyefbhSTNslpbzHBHmp09UF2xfzuELZmL
        aqBO5WM1VsKs0Q==
X-ME-Sender: <xms:vv0bXlPsYxpNg1JhzoS1u4A0V3TtXGktWqZfAgExh7Z35ga98Ykp_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:vv0bXu_xkDw62bTzOAIwD-N2ZEqORm9uiIBC_nC-BUpu-qTg8kxiQA>
    <xmx:vv0bXpTKUbtj3AI65Dk6GC3NU7ty6qgwTaNWmfNmWoAoIcOOGoZITg>
    <xmx:vv0bXglHZC9XyiBX3wp0sv-Naa7_tEp1hZ9GgfJAbz7dYekeur_o0w>
    <xmx:wf0bXsOUK-5Z6bikE5g9V4Ghfwsbvg6c-iy0itwbaiNwOcWj6wY22g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 08D90306080E;
        Mon, 13 Jan 2020 00:18:54 -0500 (EST)
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
Subject: [PATCH v6 3/6] ARM: dts: sunxi: a83t: Add msgbox node
Date:   Sun, 12 Jan 2020 23:18:49 -0600
Message-Id: <20200113051852.15996-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113051852.15996-1-samuel@sholland.org>
References: <20200113051852.15996-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A83T SoC contains a message box that can be used to send messages
and interrupts back and forth between the ARM application CPUs and the
ARISC coprocessor. Add a device tree node for it.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 53c38deb8a08..464b57d03dc0 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -592,6 +592,16 @@
 			clock-names = "bus", "mod";
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-a83t-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a83t-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.23.0

