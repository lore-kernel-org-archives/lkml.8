Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1491AC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC9421D56
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="e56Uo1uJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qj4ADG+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBWEI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:08:57 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35629 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbgBWEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:08:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5C9066BAF;
        Sat, 22 Feb 2020 23:08:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 23:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=1fk3i2ClaxdX2
        eU49K7tz0VJPn9jPZZckBW1lekbOSw=; b=e56Uo1uJqzMwdtD1kJVo81LGzVr6C
        YXxXfHfIXjB1Kg14i7eASZisJRM9AFuYZddFiI/Y1IYaf/BUgFsi2Z1gKTTXVE+5
        QPyAkwX+e1Sqw7J5r7gLrpXN98Vd5nqg2Di9U6F7yyY19ZM/19KHRKezFJXKcP9m
        ZLWn8EzH7jdPjTv+VIsH88g3QN681H/JOKGEXuvXkU5UrvUiThuVfsqQDPNvI8eT
        YqvJ6hfPIpLnEwosC6hiJ4/5UGA8epmcvSTOCz2wKcL8XrcxNDnyrFBp2PfEP1yy
        8YB3HIizmGBUoVDI8Ilal0PBkMRDfNstBKgRp6Gk858a22Evm4+tqzJHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=1fk3i2ClaxdX2eU49K7tz0VJPn9jPZZckBW1lekbOSw=; b=Qj4ADG+u
        h57PIkB7VKOUc7akOReEHEi/GgNu5w5vM9Zsb/s9QQHCFS6GmXNYXn29Ax+AWrTo
        mO0N/8h6fC24nS+IfyPzO19/w2Z/k2XIvDRoEOTiAmTdXQetp5Tu1de2PgUloNel
        cCD+ZBiBdT9g/d8jWcj6hucPtxZzUCWQm3KPuYJNqZvm2kHRq25ph8ZNHmYD6oGi
        Hc9H9+IPaLjNAuPrCeDFVrEpr+HbF2Wo5PaVRKu6rvbjDV6YKxv3pOZevbe7Tuds
        rUXppjTHXrH6roJBjIBrIg4gRk/o7Hf+rGn3k0uSa/DDwAw4eS6CPPgZct9VI2EE
        EA5hV58goDTqWw==
X-ME-Sender: <xms:2PpRXhj7rCGz5DFPrgXlQGapsYMHKTkDolpd0ZqoRByCxgYA-XYHZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2PpRXh3kj8fRDQVJXVY01touArKTklrt15fw8irZtWd4kbYuNumMNQ>
    <xmx:2PpRXsdnQ3jbwBDoLJjZ5_BD4rhuwDbhHi1zSeBQbIGLsuWV-hxldw>
    <xmx:2PpRXvw2EjRxT_69KxDLAdxt2-yXTl2318fzHurhjnExONq66gqaYw>
    <xmx:2PpRXugx0Kd3Gzxf87sDn49i_NaUZjlx58VcObKja7rwMuynVE8Sew>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE71E328005A;
        Sat, 22 Feb 2020 23:08:55 -0500 (EST)
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
Subject: [PATCH v7 3/6] ARM: dts: sunxi: a83t: Add msgbox node
Date:   Sat, 22 Feb 2020 22:08:50 -0600
Message-Id: <20200223040853.2658-4-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223040853.2658-1-samuel@sholland.org>
References: <20200223040853.2658-1-samuel@sholland.org>
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
index 74ac7ee9383c..cdec59eebff4 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -599,6 +599,16 @@ crypto: crypto@1c15000 {
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
2.24.1

