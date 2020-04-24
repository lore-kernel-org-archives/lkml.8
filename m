Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39005C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1266B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="N/dSk6AJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kTleo0e+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgDXPkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:40:35 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:46787 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbgDXPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6027A10AA;
        Fri, 24 Apr 2020 11:35:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2w0cp3nEr88sP
        +MV7TWqwyUO3pJl2Co6QHKEM/4+4iE=; b=N/dSk6AJQ3C/nUbhapEedJE8eLmX2
        64M3LAKqUh5PbHZzy0kcTTR5gXf7I9Yo/XTHyeK8u9Pi5jcpjFxP8RUoIk43kZM4
        mwkHfJmkIAaavFEIn/eU9qJ1BIKL2gTYMVgUimSjt1YWfGKxzxR6iVru+g+2miWt
        2rHB7KDELarm6JAiMkwvcMkUDrhH44bmutGaWQuVIm6uATGP7I0nrzxNaBAfu+1M
        Ax9Iz3rPQjkrPueoeexDFDf1zAAq+eV9IpFSC6otMQZNnYdx6ZlGDCRFHsgYbV1D
        2uCOHCGMvmd/XFmmZP1QveOHsZS2FfvIllEfxsqZVnJl6WG9gvwgFoZcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2w0cp3nEr88sP+MV7TWqwyUO3pJl2Co6QHKEM/4+4iE=; b=kTleo0e+
        gMAEV47fJbZF3oyXrxhwLUEskfUiu7xadCctIv7i/1qOxZn3QCyFPRMFCaLSYCDG
        1M64R8jq+LpW555I2nSnQyEVd4IHcUdZizhXbSOpJCK9nzNrzy+gTRg+eeiPJn/g
        aBebi8YKjr4q5r6lpHT7o08pnSqUz2FLoAbxN3IOgjpOUiY/MPADfnvr+65LbFN+
        8kCSSpqujJSC3G4Qr6xHBucc/JsBCuqf/p8gzcn8LyIqx3iGt7LDFrNjhjNj6D/J
        FPWUJtbp+Oi3M3zCb5ifGRuYBjy3mp7oFGbhJTHc3jCjbaYnrFRmqfeZ5YCtb+CB
        ZkcUKmVxyzw1Nw==
X-ME-Sender: <xms:XgejXvy-mkltDnTqrR6_gzZVfKIgItlOYvFTWoJGCzelGLq5TKUMYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvvdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XgejXtn8h8u_Xl2aJRvaEUlvSidwnL7bxHKLeu1BH9nnvw8KWepvjg>
    <xmx:XgejXmD1VTLs8GlrLpZp-gfcJsccdqw1wihvhDZsY4J85_N-IBGnuw>
    <xmx:XgejXoIyRRU1OayvfaPNQ0lmr-gWNY-K5ylCQ-EKhxxo3PbHaxtDmA>
    <xmx:XwejXnMTX2fvQKu4pEB0q5Qw_6II5LX7R5BEXx0RHOMw8Zz6q7lMiXJQp-U>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A69B328005A;
        Fri, 24 Apr 2020 11:35:58 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 26/91] ARM: dts: bcm2711: Add HDMI DVP
Date:   Fri, 24 Apr 2020 17:34:07 +0200
Message-Id: <5607ea5d992f98051e51bcf30ab28f4a7b065515.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
