Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6484C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3A9206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="gEX0s357";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUhBAIkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBWEJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:09:14 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50741 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbgBWEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:08:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0622C6BF0;
        Sat, 22 Feb 2020 23:08:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 23:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=1aX1QXFPhrSqm
        3Yw9wbaw0rJCUrA9D9ZrNmngaeZs2w=; b=gEX0s357WGak5Rd6Re1wmzqVq4tP6
        ev2/tuTQK+/I7fUEHru9TqZ6oZmHYSNNUVemgdbB61wYhGpFsY1gpda9o44PGEr/
        7K0qSRiT1FQiNcayDFUy7q4MUunwcdSiErg2ylL3hgrBK/+VkvHDzBDfMO9A7ZEl
        qnfOWofZO3xXJnT5rnkwXWyRl9SN4O9vk34JQ4LUdCRzYWxMNoER1w04Kh0gi911
        /5WRZq/zpAn/6VVNjAr6iMqje0HuR5cWC1/5glDtKSuzlJvm/mQA9SrZxHudcuXW
        nAF4Zxxxnqjx7axf6lZd9RQ0AyR6PRrDXZnJB1/1sQlvZToMDKlY3n3bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=1aX1QXFPhrSqm3Yw9wbaw0rJCUrA9D9ZrNmngaeZs2w=; b=iUhBAIkv
        +mVYBWgHHEQgRcthmQ67w42jzN95Hl/vZLZ7Yzbj0R1sL3w8oXHtoo4aTU7mmZ2U
        fqIU0/nYFIaLclAlBkta7bDYVK8DbPSzDpCUb8NSh3ib7H7C58XjYaxYgE9ribAb
        32g/V79Oi6P3orz0Snqea/43ql4r10mlXQhARsm1H0QD7rWS4kaYkSRvltde9nWP
        QdJ5s9TY/6pDsSlvMVBnR+6878YB3fyh6yycJr/eE0mSn8ogd7sxR5jnuLvXenv3
        ci3qVKG0mvsqG4PPGQYMcB9taKFqYQYXbWRzAYREt+I9Sozdnh+n5dJ2hB1Q16wq
        EbborSOagQ1KXA==
X-ME-Sender: <xms:2PpRXgc2Fxmm_3G3NrSQUVSbkIOYZIXB8hGf0kobNDvu-fw0It38-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2PpRXmdABQuihZs0q02VHvdYrgGMjThKUXqtfETJlKg0JZ-fZDXkTA>
    <xmx:2PpRXsjit9ttxX1PxKvp0O6QHziguZIlBPj6FZTG-D2vzrqhrIA6ZA>
    <xmx:2PpRXqRIalIG6MCR62RCrcraPd1PxDZOXUiWZHd3JKHNA4KbVBj1sQ>
    <xmx:2fpRXuYlc2rR8XVY0sLmqu9pdTgbxJTYcZ0s7wwURIH6_YEuSXz3Ng>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52DCC328005E;
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
Subject: [PATCH v7 4/6] ARM: dts: sunxi: h3/h5: Add msgbox node
Date:   Sat, 22 Feb 2020 22:08:51 -0600
Message-Id: <20200223040853.2658-5-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223040853.2658-1-samuel@sholland.org>
References: <20200223040853.2658-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 and H5 SoCs contain a message box that can be used to send
messages and interrupts back and forth between the ARM application CPUs
and the ARISC coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 5e9c3060aa08..effae97593b7 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -239,6 +239,16 @@ ths_calibration: thermal-sensor-calibration@34 {
 			};
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-h3-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
-- 
2.24.1

