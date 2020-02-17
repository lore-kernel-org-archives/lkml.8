Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE8EC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39D0206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="o5RHFFEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lv+tb6Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBQGnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:43:24 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:32939 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbgBQGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E7C0157AF;
        Mon, 17 Feb 2020 01:43:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=PQjuU/7i+IoL5
        dNdicbT4GMUQyfOGIb+JuDpBZY3tgY=; b=o5RHFFEcGx1gcJVKBXvtEKwBAEgXx
        yjWM+T7B2xxJ8B7KlLbh9WvXHiCj4Vrgh+Agw37Ta9ffLl+jll2d52c3FNh4HKCQ
        1X6y/VX9JNCJcq90HOgED4pzNs+0liSxZVdoVIuCb4xXiTG4rtkwpCdFBLfRyCjT
        PUWNdrq0jYeiwBqrQzRUnGm0ioACzQSBpiq8tYVXmT9jzM86zhUYaTeuZbokiVqN
        F7T00fGur5Ovc0bLF1CEHNd06jUKNj1UNHS/YqyUsjmCZsAJuqeJHV3Bnwuehefj
        9ItOyIvV+FG1TUEVLE4oSLfBu/IKxgkjxFySPkYBslZwpx+3crzG847dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=PQjuU/7i+IoL5dNdicbT4GMUQyfOGIb+JuDpBZY3tgY=; b=lv+tb6Pw
        0t0VCpmbz4qCBjEuCOmDhPLS3T+7gsXV9eaTreClhGWoXHtiiJRlGdQbIlg6eRth
        fitqIL3oJzbUZ11WS8zZd+TFKY/Fdob1fm/I03d7DtgiLXPy6heZ/NqpNZKd85ef
        u0ITT0pOL/94WLP+/sNvG6cKXBPptd96ch6c60Vf7jbaHCi2KCmAN3WVK2M+4MkF
        6wMh8J2nqLY4ViV7WOteGg2HlvJ9hglRDmEGqVMDpb2tObVoGHZihmFIaPFCDaEU
        WBeHcCC3y5kSLhGgPO3YqAq5/VWCT6M1vv24CZik7XRsqBQfgJmRyvMWPFPR9nal
        pPNT4nIhTCBqxQ==
X-ME-Sender: <xms:_jVKXs9UyIrfMVHxcl5IO8K-CUZQ7p4px4zloF21P9ajCkIXWmtCqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_jVKXnE8xKc2_Yb_Zh4NIrHdYQmg5sXyjz_RhsPan5g5EyM3NnkKdw>
    <xmx:_jVKXrRDmmz4gUnhLrwzMdp3GZ7RYcf3P9lsYFHRImVHZNEGkYB2lA>
    <xmx:_jVKXvk2M-QZT4c50aNMGDRRZBoH1OQG0yRQcuzDZeoHd4-PgJZlSg>
    <xmx:_jVKXsvBeuXTX8l3BFNPnGiML5GG4lXmzUX6hFTyEVC16XjhXVrdCw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 337253280062;
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
Subject: [RFC PATCH 32/34] arm64: dts: allwinner: a64: Allow using multiple codec DAIs
Date:   Mon, 17 Feb 2020 00:42:48 -0600
Message-Id: <20200217064250.15516-33-samuel@sholland.org>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 5b688687a2b2..a7470f2ab975 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -176,7 +176,7 @@ cpudai: simple-audio-card,cpu {
 		};
 
 		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec>;
+			sound-dai = <&codec 0>;
 		};
 	};
 
@@ -801,7 +801,7 @@ dai: dai@1c22c00 {
 		};
 
 		codec: codec@1c22e00 {
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			compatible = "allwinner,sun50i-a64-codec";
 			reg = <0x01c22e00 0x600>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.1

