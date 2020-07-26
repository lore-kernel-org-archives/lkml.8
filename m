Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F68C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D0E206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="PJ+Oa5kH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dad5MuFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGZB0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:26:06 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49817 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbgGZB0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:26:04 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 981225803EA;
        Sat, 25 Jul 2020 21:26:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=zniOgjBVDjzwc
        FzCQ5VisrbxqLW88v+7YjNv2U8VdwA=; b=PJ+Oa5kHxTGVKa819xKyIo9XhUpsy
        MxV1xREn35tIJHEmvXnk4bSUpYej2kQxCs5TGocTZIlVDK+a81PnIWtvbD17kGbv
        4Q/LoQrnwWQ1qF8gB1BnyuD5KUeE71sv1KK/Utnri2sFf3B5BDbMCtXMX8E4/8Pb
        VVKdsAublimntYRqoKx7PpErVgdQ6xVEUI7nRF5eNF0Or0elERDEIzm/NKLpiI4N
        LIma/rXTpDh9Az+NHHDyFr3AyG0QYXtF6Oyz/m81YkNA1kz7W69XQeQxTonrio/I
        cY8tL7HvZvMmA1bDkiZA2+obq9bzSM0p5GHh7D4cOJhDvHcBhfYqIXylw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=zniOgjBVDjzwcFzCQ5VisrbxqLW88v+7YjNv2U8VdwA=; b=Dad5MuFu
        Zt9T4DR+KMBf0RjbT33sRMx+RDHITZrRUbj/jWkv7ClbLMQbvNtqZ/mknWj3kLvU
        dHav/m56nYJGkL91ssmqMJa5cqqC6ZsSJOHRCI0FJIzd9e4RuGtPNUUJUaC6u+Ja
        lRpPpAq59A25qEidDFCdyyQtdUcjymb3u4BwybDefZyQsZ/yXZiCguXSMYgSYA8h
        p3BnHRmnPhMixmH4Y5OeghWhkvS7ENk/aOgy7M6ie56CNnqz11gYSn3corOl7jkC
        ct8PZPRpRwr45MfxB6UB1Fb0tJtlvxfE1qI+V0YCn0opBrZZmtj2NfTq2wdQ32xc
        anFK+Z09L13Akg==
X-ME-Sender: <xms:q9scX3NLQiLSwwwDLMlSMjFjpV7e4wzgKMFBRIS80JXh1ZgTY7aWAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:q9scXx-O_bW0wcoE6PUKU3yhzMZyuhF9ArPOsA77dVp-a3yOJ5jjlg>
    <xmx:q9scX2S1mSjwM3krrgOInygqr9fwrWBeEHvNT4Sg48ibpuojhAIh1g>
    <xmx:q9scX7t_fZdBbgBizTZGFZXTV5Aag0Kl7zy2o7Z9jdiMh0BZtz60DQ>
    <xmx:q9scX33jxQHmADYspKGKdWEVdq0ygykFhRPt3O32RHjuX8xAHnWYNA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C641A30600A9;
        Sat, 25 Jul 2020 21:26:02 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 7/7] arm64: dts: allwinner: a64: Update the audio codec compatible
Date:   Sat, 25 Jul 2020 20:25:57 -0500
Message-Id: <20200726012557.38282-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio codec in the A64 has some differences from the A33 codec, so
it needs its own compatible. Since the two codecs are similar, the A33
codec compatible is kept as a fallback.

Using the correct compatible fixes a channel inversion issue and cleans
up some DAPM widgets that are no longer used.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 73ae7656e0f3..26df6278dfb7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -860,7 +860,8 @@ dai: dai@1c22c00 {
 
 		codec: codec@1c22e00 {
 			#sound-dai-cells = <0>;
-			compatible = "allwinner,sun8i-a33-codec";
+			compatible = "allwinner,sun50i-a64-codec",
+				     "allwinner,sun8i-a33-codec";
 			reg = <0x01c22e00 0x600>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
-- 
2.26.2

