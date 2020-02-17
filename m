Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B902CC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA5020732
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KkPIDrxN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwV6073b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgBQGnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:43:22 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39695 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgBQGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 26FD9586D;
        Mon, 17 Feb 2020 01:43:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=WMkmsxGWAZAP4
        sWxF/e88HgunxucfP1/cWpmUNmh5DM=; b=KkPIDrxNZh4osC8sxcoD0YDsGt3oq
        /RjE7PpItQWjbLhHMTu3857HawDyzwt5XuMovwHEiO1nTn3Hgd2RvdBkU/3ZNLUw
        znz4TyERmOdQDs74YhXWDFh8B2Lbm8Q7O51flkV+2A5AyL859V/FrmA6E630et3J
        c/2SiHjfTAskw04WkQWlcnpOrgqLYsbjV9ItPlsq2nZeWksKtRBxXCnp7oder1AZ
        xbElMkJ7GJKzBBldygXlyyHcD9W6Bifl7eSYuVErBV+HU9aR9m0ssKXbvU0bzNUe
        LTm00tC596xrRDYlQtET1c5kOsZu76dlLIq2q9iy/C2TWmC0oG8ZrGQ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WMkmsxGWAZAP4sWxF/e88HgunxucfP1/cWpmUNmh5DM=; b=AwV6073b
        vssgZIpuBnh8D8Vau4Kf6hmBmrQvGuk4vlQMRT6DKP4+TscL61EmqX29S1+c3rL9
        ALjTDE/6ke0UJakfYmk47quOtX5QLrpLigt+tt/anFm1dnotyRIj6N+Jz6SmrfLB
        8U3rdPZl3zQk+E+rcs1svZOvSrO/tcu0H9fgTLA/WV7NPdNTMpdyepVqGoqG//nz
        AbWSHaEkpz66Iia0Gz5mIyRPcJqg0ev7zaJDtGxhmzqZmR6PNBzXF00OpBiZN/Oe
        qoqPbT8c/PtLr4fZJrzK4w8cC3UOhqNRWu6PWhufTaFDvFvX46rukNiCLzSGQstS
        hhxejdzcK/sjSA==
X-ME-Sender: <xms:ADZKXo5OmVddj7BEv-6VAgmFPFzSLxOs7GAwM6SVI483Pm2ukR6Ovg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ADZKXuz5Epqh8939N10zNHgP3h0R3QNNnLKnuwG4__k5Jn7OOaq2dQ>
    <xmx:ADZKXlCCWgxpotqBH2iSdRaes-VwQP3HjkCYiC3zPKmesX9yk9_CwA>
    <xmx:ADZKXvMrACIXbY9ZCR1dTSoy5XJImO1Ki0wlkWyHQXLJUPeaLRU7rw>
    <xmx:ADZKXrHrJOSeRSxGMfAZAK40icIVBotqIHPJ_ya6FZqPN0zwPVh2fw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 660FB3280059;
        Mon, 17 Feb 2020 01:43:11 -0500 (EST)
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
Subject: [RFC PATCH 34/34] arm64: dts: allwinner: a64: Add pinmux for AIF2/AIF3
Date:   Mon, 17 Feb 2020 00:42:50 -0600
Message-Id: <20200217064250.15516-35-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the codec driver supports AIF2 and AIF3,
boards can use them in DAI links.

Add the pinmux nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 78353893c3b9..ee09a2dd6f69 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -605,6 +605,18 @@ pio: pinctrl@1c20800 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			aif2_pins: aif2-pins {
+				pins = "PB4", "PB5", "PB6", "PB7";
+				function = "aif2";
+			};
+
+			/omit-if-no-ref/
+			aif3_pins: aif3-pins {
+				pins = "PG10", "PG11", "PG12", "PG13";
+				function = "aif3";
+			};
+
 			csi_pins: csi-pins {
 				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
 				       "PE7", "PE8", "PE9", "PE10", "PE11";
-- 
2.24.1

