Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44FC20747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="D9KYtJns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9FoXXIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgFKJXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:23:31 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60531 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726868AbgFKJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:23:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3651558018F;
        Thu, 11 Jun 2020 05:23:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 05:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=2w0cp3nEr88sP
        +MV7TWqwyUO3pJl2Co6QHKEM/4+4iE=; b=D9KYtJnso0yLpN7LL06zlKNHpB3WR
        jObt6Zw/A6GW6r6tVON5GXSx4imn66XIWNtSx93DoKkt+hjCio97Cixn4t0DngV9
        sRF9pfMX1LAEsNlMRf7D2kRqAI7TY9X+FVZvlg9b5Lx/KjEColzYX10XEZXabjRL
        RsNNDpuDb8KmBM1k5wm5N3ePCqF4VRPw+Vk0OcNcLrDWt07QYoQqFCqv7yKEBHkm
        /+ESJBtp3ItTM7V17faw/mcXLvA2RT2lPYOMG5LtKt/czc8tYBmWDq8mB805G5Ir
        SGUVCUDA7m04L6hhXS+ja7IvPYS9Q0ctchWOmjFN+SvjaTmj93z+l3iew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2w0cp3nEr88sP+MV7TWqwyUO3pJl2Co6QHKEM/4+4iE=; b=u9FoXXIY
        PUqL/VJbaHBLnYn124cS0+7UrZg/saefEqDDe4AIYCG/3/U97yRfR47VYk2i4/k2
        S+WwE4l07yjNZuvL/58W0r7NkAH9rQpKU7HibRjJ3uVklbiuq4E+pkxiYhZLHFDI
        WnCsQoDVxttRrqEIa/Ftk6GtB7IGcNu2xwJQLXkzk80CTjUidLaCepEgOpWmD99G
        WvVd4qGvvFiATQMaK/lrlnTKQ1gjrzRXSttd993PWuFWY0wDJslNFqNog8mbyjKL
        GfGrBFUI7FAhijxh/N8aIC4mK0B1Eu67B6F/4DIt+0Ab50tN1QJTJ992bxzQmj/Z
        RFslTXRhxqh0pw==
X-ME-Sender: <xms:DvjhXtRg8_O_-RUGFzjFKAzrvS6ZPZHJWoDrNS5_ooXyptTipi9fWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:DvjhXmzOBOsC4-63dg5pyuGuzBh09ZAmR76RtoBcL-UaBGdSJoD3Ag>
    <xmx:DvjhXi1EcU2hn3f0tuVa7xlXShP_AhPoa6f38sPYghzt1g8Dpj5CqA>
    <xmx:DvjhXlDh2eC0d7GSgh3d-PLlx0JM30qJtNOB8voukjJOe853XCKjOg>
    <xmx:DvjhXhP2aQDt09Qt-FK04VqpzIaRQJLHuWdUShyqyPrJgWrCPhtgxw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C72E73060FE7;
        Thu, 11 Jun 2020 05:23:25 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 3/3] ARM: dts: bcm2711: Add HDMI DVP
Date:   Thu, 11 Jun 2020 11:23:17 +0200
Message-Id: <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a driver for the DVP, let's add its DT node.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2711.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index a91cf68e3c4c..00bcaed1be32 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -12,6 +12,13 @@
 
 	interrupt-parent = <&gicv2>;
 
+	clk_108MHz: clk-108M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <108000000>;
+		clock-output-names = "108MHz-clock";
+	};
+
 	soc {
 		/*
 		 * Defined ranges:
@@ -244,6 +251,14 @@
 		hvs@7e400000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		dvp: clock@7ef00000 {
+			compatible = "brcm,brcm2711-dvp";
+			reg = <0x7ef00000 0x10>;
+			clocks = <&clk_108MHz>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 
 	/*
-- 
git-series 0.9.1
