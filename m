Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD3C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BB320728
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="LWezrIIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZ6D79+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDZQMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:12:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46465 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgDZQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:12:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E5B8C5C00D3;
        Sun, 26 Apr 2020 12:12:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 26 Apr 2020 12:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=DstDy5l5rdsJcISzdP+t1d2X6d
        9z/JjBvqVJ7i0o2xw=; b=LWezrIImXKV5NwJ6YSYinDnl9kcK1aYg0DBdgxB3mN
        PP9CMayJ6NF1TOgIdc0MW0n75595w3H91aK1sQygeodISKszD8lTD//r5UoyiozP
        aVz84eTEMR+9aEMFPNoiJZdHaWatsJXS6GzEc9AJ6ASi/0bCiGM244fcV2RpqpSQ
        0xSQWY264Oywd1iR1vQ/BoWUu/2L9ZM4ML67Wfrs+JpNnQV0UCUohczExLPQieoj
        PPxYMKD+JRb8VkOZbxIhtbF9pU0MDK/adjBq9VA34dIhJFQzrUxcADWMnCi5i0Y/
        K1P9f2k4Ve2YumQtWw7quQA4OrkPz8Zg4NX+zWqk1n5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DstDy5l5rdsJcISzd
        P+t1d2X6d9z/JjBvqVJ7i0o2xw=; b=KZ6D79+YC8NS6f5MTQmDTWis+kzyY42Q9
        /271i3tc3M+/XcvYGzVxSZ75kTKiDnRshnLRr3Tr4uNmreq8B4DMZgZJjNSXh4q9
        tRHvm5/xNK7ipiFPKMxBxe8lr5d8Zi5v5Kl3ZZd5RSCJ9nSQIEswBao8ZlOQwQ4L
        o9z1uCrxu89WmhwpxSWXij8fXMeGo7/GKhv6XoNKP3umXylybv85kDOj0TBrUrXb
        0kWmKn0bGQPzKYzAQXiezJz3htZ1X0JE3G7lNqO79/TRBEcE0DIriC5Sv7kOXdYB
        vBuIpcyH5Ry+NBxtYOY+Uqrhf3v9MhSqr7o+6IAMoSZDPIdzVfJCw==
X-ME-Sender: <xms:zLKlXvGduu1BG4f0Y_p6zO24-N9Xaugjvwkmb0DkiUVMBXXGZIj-mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:zLKlXjnPZpJwS3sGVc6St_4U7QIo6lkTTlzyi5gRTyljjlaEaSDvuw>
    <xmx:zLKlXl3whgDWeGBB9fIQWcpipHr8cuTPU47aDjOb6Uq89A_UJ9ZBqA>
    <xmx:zLKlXpzFf1pQe2ouGRLgLarcesc0MLdNdL3bkRuEZYw0-usa-Ja56Q>
    <xmx:0LKlXp362ElMk5nDw4AFv8e_1VLp3xq5rR1obrK3b-MedR9XLT7XyA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 780AD3280060;
        Sun, 26 Apr 2020 12:11:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2] arm64: dts: allwinner: a64: Remove unused SPDIF sound card
Date:   Sun, 26 Apr 2020 11:16:05 -0500
Message-Id: <20200426161605.52121-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of v5.7-rc2, Linux now prints the following message at boot:

  [   33.848525] platform sound_spdif: deferred probe pending

This is because sound_spdif is waiting on its CPU DAI &spdif to probe,
but &spdif is disabled in the device tree.

Exposure of the SPDIF pin is board-specific functionality, so the sound
card and codec DAI belong in the individual board DTS, not the SoC DTSI.
In fact, no in-tree A64 board DTS enables &spdif, so let's remove the
card and DAI entirely.

This reverts commit 78e071370a86473f25923e03b51cbbadacf8be0f.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes since v1:
 - Remove the node instead of disabling it
 - Also remove the codec DAI

---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 31143fe64d91..c26cc1fcaffd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -154,24 +154,6 @@ link_codec: simple-audio-card,codec {
 		};
 	};
 
-	sound_spdif {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "On-board SPDIF";
-
-		simple-audio-card,cpu {
-			sound-dai = <&spdif>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&spdif_out>;
-		};
-	};
-
-	spdif_out: spdif-out {
-		#sound-dai-cells = <0>;
-		compatible = "linux,spdif-dit";
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		allwinner,erratum-unknown1;
-- 
2.24.1

