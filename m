Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED0C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6A420726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="QUKM6AOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQ68Ly7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBQGnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:43:43 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38951 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727448AbgBQGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:10 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 51C465765;
        Mon, 17 Feb 2020 01:43:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZF8SAW4rQvPZn
        izR7+Q+SkTY2Egxs+9JoHdYrQXsQ1U=; b=QUKM6AOjP/Twe7eoBHAQKS5dTNskk
        Zln3Evb6nyQxsbumN3xyqRalHaEM4qH60NvMudMQA04tPizlqy6ksUBmxhSvoBT3
        W8OlgZm2ZkheD/xwWGYyXoNFyRNYppDn/VYNM6qw2Wb1mNbV0f1ee1TBVZiVZbku
        uIT4kexaLomLlC8C0YbnyEfcntIubz94LyNuAEPHoNOCYx7dfDOrVjpuy2oeduv1
        RSc8bpHdsjJxZ/zS1/7VUNapzrZiibj7gFjuaQXLJ8QKLqbxUUaz8Qc4WFmV6mUn
        HV4zbU6q4VP8i2QRePZJa6R24VH7/AcFBult/ypSVAt1N4LWuer+SUCBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZF8SAW4rQvPZnizR7+Q+SkTY2Egxs+9JoHdYrQXsQ1U=; b=AQ68Ly7p
        zAl6vsx52jkKL75gSioyGZtz9ePntnRpVp71wzX54WBZCfB4x1sgINRDiYwHslH7
        Nky05f/DUiewyUZ87HIylinlEUp5gXAvhk43LPoLep4S85UlA5f+0xz7BkEcNLc1
        i5xTKPSLa5D/ubLvlFk5lw03Kup7j+4qnN5LQ4XGzJVZUoOCw0C9kibbTOEzAgwd
        8eCDDyXd0px1YNMMrFJ/UFZfh/0/Ftum6fWE1GLHbBRr+Gr14vcTmuAeMudpFmsr
        /qrZ9OrG/wC5F5/FFWJE89qyqQn0hZ7UEALGbOsY81aIFuhwIkfue3himru0Y2FR
        QV6GN2XqFfHhMg==
X-ME-Sender: <xms:_jVKXvuBp_mEd46PUReiDRDWv3BCTJLZ6df6k-hmkrPexB2msLrwMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_jVKXqFdycQ-KgwWZbfRNzMXzBWDeVNx_0H65Si0_6tswTB_IwIt-g>
    <xmx:_jVKXmPrrM5qaogaLnV3QJW2huXuxTawYzj5Rd7-wtBeOW0iCfBDBw>
    <xmx:_jVKXlELZ6JsKbYaeqYVkIDTkfUpMPhdyIpqSo4pPcHiBa-5ocvU9Q>
    <xmx:_jVKXsH5kwqYZ9fXkyUWTY9NZlrV4f8SEdMvjk147YD7l02FnPW32g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9370F3280059;
        Mon, 17 Feb 2020 01:43:09 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 31/34] ARM: dts: sun8i-a33: Allow using multiple codec DAIs
Date:   Mon, 17 Feb 2020 00:42:47 -0600
Message-Id: <20200217064250.15516-32-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic ASoC OF code supports a sound-dai-cells value of 0 or 1 with
no impact to the driver. Bump sound-dai-cells to 1 to allow using the
secondary DAIs in the codec.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 40b903fa73da..a16c2ca11131 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -200,7 +200,7 @@ simple-audio-card,cpu {
 		};
 
 		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec>;
+			sound-dai = <&codec 0>;
 		};
 	};
 
@@ -240,7 +240,7 @@ dai: dai@1c22c00 {
 		};
 
 		codec: codec@1c22e00 {
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			compatible = "allwinner,sun8i-a33-codec";
 			reg = <0x01c22e00 0x400>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.1

