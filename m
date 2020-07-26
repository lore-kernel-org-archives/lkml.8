Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F6C433F2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080E8206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="uQ9MP1me";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNQnG+g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgGZB0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:26:20 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49817 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727854AbgGZB0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:26:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4387E580164;
        Sat, 25 Jul 2020 21:26:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=YLBWcIY6TfCMV
        PdscSUAAQmXF/LED3PLTtA8SMRgg/M=; b=uQ9MP1me7FmaTR2K42yzAka+XYdBm
        4qmxaTZTBv1xbMQRw2xBO4GHjMG156QP6M+h/W/unsk8MpYwaVpD759Bsb3ci00L
        ewk82NMvcn/s0rrlvo+MO9OGhyV8H+u9BH3P8DmtLrzZnxnzi8uztw96xvlgBFi7
        jE8BUDxodKrNtrpHQVQe5dTn740QWcLudXcseUgL1jBACwgfcNZJEGg/k+Y1sIHg
        3rxZkUPrfHQDjrDPBEVi4pF0/KDxicJCXa/ikFZGod9WKpcTeBbTy0fhCxerNs31
        SL51ASx9nq0xc6x+wHURcYZ5sanFVrEqoEsNQogyKIbJB3UmXlLCNMpQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=YLBWcIY6TfCMVPdscSUAAQmXF/LED3PLTtA8SMRgg/M=; b=aNQnG+g5
        zUTEg3Z+y46J089EY5sCOtfKVSGgpe9U0OCv+JnYvZoHmobstcZXo498LhxOwjoF
        M0rRwNwOEhmfitLOj6eqgWJ1IAbZ0kg9ps/JGSzOVh2Zd80JM8CqXDJb+7uvNkP4
        9YWDsTf/fdBAJlYO1OzXWV8Z6mc6MP3Kesiw2uFkK1LFZ+dRmSpjeEHgmvX03H6p
        R4cRfW6A9E3JPkAnaMHMqaTQXXRYus1hrzLjRuaBff1EKZsaCe24ntaptXAdxPt4
        xRxoknMh+YoLr8ocuvJ4ZgA95vlw0QuA36OrwAKqQMogytZ89owCYBBzwe3b9vlh
        av26fhdcEe4tGQ==
X-ME-Sender: <xms:qtscXxNb4QvAW1EcoT14EPyVgVigjkk6kcJw7qeXX_VH-SXF5Q1o8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:qtscXz_1QD7dZvgbinfZUNrrsCIxiL57oYJkxtfYNiKWO1687WElTQ>
    <xmx:qtscXwRec41C5XqeblvrE3T4we_k0bba0qWxLLOsnwVsoDPnfsNP2A>
    <xmx:qtscX9sLKkkwNexaJTlo8rCGeI-LpkrYFo5nK9wd7Y25V068_rHBtQ>
    <xmx:qtscX50kpVrmWviECX8au6aNb8QpHnm341ui2yzJCMTTW4DN65ZFYg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5FFCD30600A3;
        Sat, 25 Jul 2020 21:26:01 -0400 (EDT)
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
Subject: [PATCH 5/7] ARM: dts: sun8i: a33: Update codec widget names
Date:   Sat, 25 Jul 2020 20:25:55 -0500
Message-Id: <20200726012557.38282-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun8i-codec driver introduced a new set of DAPM widgets that more
accurately describe the hardware topology. Update the various device
trees to use the new widget names.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 4 ++--
 arch/arm/boot/dts/sun8i-a33.dtsi          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 3d78169cdeed..a1953b2872d0 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -194,8 +194,8 @@ &sound {
 				    "Headphone", "Headphone Jack";
 	/* Board level routing. First 2 routes copied from SoC level */
 	simple-audio-card,routing =
-		"Left DAC", "AIF1 Slot 0 Left",
-		"Right DAC", "AIF1 Slot 0 Right",
+		"Left DAC", "DACL",
+		"Right DAC", "DACR",
 		"HP", "HPCOM",
 		"Headphone Jack", "HP",
 		"MIC1", "Microphone Jack",
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index cfd3858afb3e..c458f5fb124f 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -189,8 +189,8 @@ sound: sound {
 		simple-audio-card,mclk-fs = <128>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right";
+			"Left DAC", "DACL",
+			"Right DAC", "DACR";
 		status = "disabled";
 
 		simple-audio-card,cpu {
-- 
2.26.2

