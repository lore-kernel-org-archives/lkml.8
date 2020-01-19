Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D76C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B72F2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Ss9nHyKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XP5LRL0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgASQbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:07 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33099 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbgASQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D1FA621B01;
        Sun, 19 Jan 2020 11:31:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=jRXBQP1pUsdOzqmTPi7i0GNzpz
        hk8MjLKuWSz3BrgbE=; b=Ss9nHyKUmmUdUVZnkh9KSqKaovOToU/w0XpUd3ioEI
        lSQSVTwho0JumsjMAJBNXXu6z2exAg6iqFi/LbaKQQScXHgpQD0TP1266j1tGj1l
        9beo5IzZzWJ+QifEb0mq6Fsr0VMPKip65U+AnZXxlFOUKnah2JipW8+2X90bKKAE
        xDGWdbrIhupvwwvKFaE4KN09daKEZbXrZh61oYUkTekgNX1FAlKHHGCOXlt58gD4
        VMtmAFsqMwl3nOcAqngxcD41kPDaU3etB4WbbSK7xFxWhI5Q7xr+fkyHDAHUwWQW
        U28yAArEV0yiJCbjWHDfqJFrSAGulNrDpVzCLN7MF2cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jRXBQP1pUsdOzqmTP
        i7i0GNzpzhk8MjLKuWSz3BrgbE=; b=XP5LRL0rkqT5A7Jca0CA9sb6eLXmxpHj6
        kFWKD75gDttAJg78qybWCkM+kN0LJEubLLBkSaCdxrH2kNoEk+FWzNYpiwkXONxm
        CcVj3fc2IHLkjLbRb+BZQgJbJprza9t9R3QdwIKyC7QrLapqQVmOyLnoem2/iXNr
        6H/3BriaOxsiseJaM/Ik/MCF7AhyB4aEd7IosUGFA2LpLNAHsTSEczhwJ9Ct1pu4
        k05Y7pXTKJWbl+TqmFJ2Mfxr+xAO9GNGiECtS+bKD8eueX0UfukSzipzN8diR2KY
        LR2DakDDvZadiBmVAkYHqFGozvSx7cMTeNC0QNqJy+m7gFFcSzBdw==
X-ME-Sender: <xms:SYQkXu2t0pTzPsonGpgvAuYrrkNDmvx5NylXBsTbWHumwxL_3AKuqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghl
    sehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:SYQkXgYqnKPPGE0gWQUtLWPv_j9pZCpeu0xDSYzFRpoXHJs5j9OfXg>
    <xmx:SYQkXt0CEB2peFOny9G6B6r-BuTha3uMTywm0_kdeRM5UE3mOWDwBw>
    <xmx:SYQkXrKLxCt89pyW-bO6WtV27OUzeVTkaEFrnIjrAnGjTlNlR8c6_Q>
    <xmx:SYQkXusNyWmbW4FH4AHsaEbbbAUtuY1I8swgnQB50VHJHhZxZ4JdUg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE0978005B;
        Sun, 19 Jan 2020 11:31:04 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/9] arm64: dts: allwinner: Enable button wakeup on Orange Pi PC2
Date:   Sun, 19 Jan 2020 10:30:56 -0600
Message-Id: <20200119163104.13274-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Orange Pi PC2 features a GPIO button. As the button is connected to
Port L (pin PL3), it can be used as a wakeup source. Enable this.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 70b5f0998421..c4f89c312f42 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -61,6 +61,7 @@
 			label = "sw4";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
 		};
 	};
 
-- 
2.23.0

