Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC812C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80200206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="i99lQeaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwBMFoeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBQGng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:43:36 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60881 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbgBQGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6F00855F6;
        Mon, 17 Feb 2020 01:43:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=0bytkBnACm85u
        8GzFKkbz2lEVaNk97YvyRqeDTlzBYk=; b=i99lQeaTghn8OQoAndt3G+dRheaO7
        fZt3V1MIRK2/IhxlsJqfsHIxJwqRnHrntE8g0GyqriW6z4BzwBIfoSCKdK5/XclU
        RzvdzEeutg3uwMBaJSIIh1PLsbK5kR9cTgU4BzGz5wSDgV7GBYPsgOQ5ZuQ9I3Dv
        Av+qMZbFz1cSBE3RYryHNqQuYy8+olMcFULBR4GnIyiCavqnMckYWucCawTlKEGv
        1+tSH/jWJA2VxmNnD9/zZkJzo4XxbH+LWetOv7SHzizp+QtgN2zQg79cPqba4Wfe
        Pbicci++kBkkn9e5I0RvCEOqdwptQnTFgK3KqEC1NgcSK2Llhg4wcU8rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0bytkBnACm85u8GzFKkbz2lEVaNk97YvyRqeDTlzBYk=; b=WwBMFoeh
        Qa11XMb5Xd3MWF4wtTHrY5LBbyHxIdYx72jEDDGLK43ViU8IVYTr1zB+6oBPvXsz
        wrFhjDMkBUxyAaO89E14qLbo+PYCdams7gzPLeSmDDy03vpls5az41Xr74Aa8UR+
        9LFMMg+d7IsSFXsbQ2q+Rr0ht2gWGx+k0nBseEw5TS77dmoggdj0S7/wFWd3w+gs
        y7JiV4ihgokvYjKN7Wac7sHyagVIp1fu8PVb5TvYMhC2ci8iqcNW8OTfuH/JHTSx
        ie8akTY3UmsGhbygtNyaISERBoDjKjgbAcij2n39HZXtOLScQWcQiul7d6FxGno3
        BgCPe3MZAl6feg==
X-ME-Sender: <xms:_zVKXtR-TCsBFRD2CKHVBUoiEUqoFf7DNrioFovXvSSRt413WpSkvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_zVKXsKL33Rk3bUTnQfqwnv908Y5ovArZCAXo5Jr2JQV8LE0LdDZXA>
    <xmx:_zVKXjC0w8iGmhcJ_lyoV1g_mJsGkM1stjHdvaT1zEreH__2akslUQ>
    <xmx:_zVKXlBria6HDsYR_yKYBcJDcjPi3RZb-VRJSZiNAvQK6Cl2Sg-D5A>
    <xmx:_zVKXnxCKNWDF9qTUjnSAR2gYFbOiIDeHMkxE8hSCOUcUHPABn41gg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C6EB6328005A;
        Mon, 17 Feb 2020 01:43:10 -0500 (EST)
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
Subject: [RFC PATCH 33/34] arm64: dts: allwinner: a64: Allow multiple DAI links
Date:   Mon, 17 Feb 2020 00:42:49 -0600
Message-Id: <20200217064250.15516-34-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple-audio-card supports either a single DAI link at the top level, or
subnodes with one or more DAI links. To use the secondary AIFs on the
codec, we need to add additional DAI links to the same sound card, so we
need to use the other binding.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index a7470f2ab975..78353893c3b9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -157,12 +157,10 @@ psci {
 	};
 
 	sound: sound {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "sun50i-a64-audio";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&cpudai>;
-		simple-audio-card,bitclock-master = <&cpudai>;
-		simple-audio-card,mclk-fs = <128>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
 				"Left DAC", "DAC Left",
@@ -171,12 +169,19 @@ sound: sound {
 				"ADC Right", "Right ADC";
 		status = "disabled";
 
-		cpudai: simple-audio-card,cpu {
-			sound-dai = <&dai>;
-		};
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+			frame-master = <&link0_cpu>;
+			bitclock-master = <&link0_cpu>;
+			mclk-fs = <128>;
 
-		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec 0>;
+			link0_cpu: cpu {
+				sound-dai = <&dai>;
+			};
+
+			link0_codec: codec {
+				sound-dai = <&codec 0>;
+			};
 		};
 	};
 
-- 
2.24.1

