Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EDDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F1320873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="bTaDTZfO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wRjzrm+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390111AbgE0Ptd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:49:33 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60109 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390069AbgE0Pt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 13057581FF5;
        Wed, 27 May 2020 11:49:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2w0cp3nEr88sP
        +MV7TWqwyUO3pJl2Co6QHKEM/4+4iE=; b=bTaDTZfO2yJJtiqXcRHGrmv4ObHUi
        nxQ/Ber7Wo/rx3ZyRxdn6bd2cFcZBURuwgnCT0gBE3myvLMmNZn4Hu5zvMARvrxk
        xQdoQzMS73gwcNAQ/j6yKifliopCVh6/dttCj+1TCZKw6QS5crdrAubDj8NX3aa/
        /J56xy1Q6QcWwEcTNT6o1jOW9FmPGDXUWd8sBJBUyOP8eZiXpSTrTqro7nyiqpG6
        PxLhdEtUIBVB0hCSXOcl/xMbLMIekwZi+xT1TEHVWxJ3imdWhKdVIlWomX6qfN9T
        b/gpb6EhY+wGJChaWJxAl+C8XHrSlX79/SFdOj9+39IK7MSSPQtk6GB3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2w0cp3nEr88sP+MV7TWqwyUO3pJl2Co6QHKEM/4+4iE=; b=wRjzrm+W
        9IIV6Wx5rB5Gq2jACDT5UADtSUFRXICNSeEV3cWJ1hOP5y/7L1JsQwbGNixVsZ2A
        YaIbOajko8zM6AShQxUrBv1784CgBzcnk7jjfbT6B/ZEScCDmJGfEgATGJ/NuD58
        5bscC37zWt6lIdrtZKEBoT9lrAcVSoYa8qp5sOF3U2LllDNLA9RluxyJoEe1Sxz9
        SI7PKBwKat7G9mtJi45nJhU4eac353NYtcfyfDDfOVNMowi4ejbeUCpeyIY96QLx
        jg1heZ+7occlg8FIDzA8bRtC3hDHrUxpXDEzUXgLmaaZRZ91BWyoOjlWTFFCpIug
        jIXeeVFGwCkziA==
X-ME-Sender: <xms:BIzOXmwVDlmXtXYfgpu_MIhIsKFOjvlBbAkJrmLYzG3i-Sk0kI2Wtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:BIzOXiRDxEF-IbM53d_WQRQ4A51_CtJgLQCcBBV0aWIsRQGlZ1GkEA>
    <xmx:BIzOXoVGc2l3Mbtox6dNyKEYqTOEp1A1OVS9XnRwKZxSbau9ZroNjA>
    <xmx:BIzOXsjw7xQZRDSyaNIOM9nQ0JgZtkC4UqZFer2dG04-adKcXjFDxQ>
    <xmx:BYzOXmDeFBqmDtZgZfBwVqpnD5svAscM1HnHZls-eZetrR3MRSPrvA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A60AA30618B7;
        Wed, 27 May 2020 11:49:24 -0400 (EDT)
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
Subject: [PATCH v3 005/105] ARM: dts: bcm2711: Add HDMI DVP
Date:   Wed, 27 May 2020 17:47:35 +0200
Message-Id: <0c9279fb2e12645fe9f1d10a8ce8a8bcae51dc2d.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
