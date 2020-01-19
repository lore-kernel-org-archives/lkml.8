Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8141C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF7F2053B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="W4fvp2pV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6NpJEfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgASQbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50673 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgASQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D364A21B1B;
        Sun, 19 Jan 2020 11:31:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UsvFPJigdCzO6
        2lHJNiea2iRe/frpYuHMue0slMeRJE=; b=W4fvp2pVhHK38AWtgGRFoGVjdsB0T
        0sYAVCDGYmZNXC9K2BAfjqFnvSUp7ZVG+J8kDQc23m7WKXeeRUTzu/2XVBX7UH6t
        Hfd8panBR+9smIJbikTUCT9CkYUlv5ATjTO39GyJRM31yvW4yilu7DnYtea1rOXV
        d3f1IB/wr7uWxUY7Ke4IH09HlrrrC3iv2QxSdTbGK3rnU6Y1ZoKrhI1dDxUJWOQ1
        oqI9tMUq+h7qGniUyErZ69dmWn63HSEs1fDzfN89wn9weCYL0Y47KFbmNVFu1a75
        fGDelOYNnlxzL7DjKZq6dlM5md16cAZq+5dzowJy0MCsURcjbiHksuPyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UsvFPJigdCzO62lHJNiea2iRe/frpYuHMue0slMeRJE=; b=k6NpJEfe
        GatKJHvkgAufZB6cgbBgeqpXMzVqPzVPyfMwj7PdzBCLHbVC3/LZTcx4LHoxtVpb
        x99vnCrxOB0AF5gAEQ+0gTbaGd6fyy3pKNW/aN47gUyEjliJpJbdpf05Lw5Y0HjG
        HoshvpJnuxvfZvComm/IFAN2Ksmj7SSDNJfsx2j7FZsjUdhVHwLy+U32h2540qSt
        nO79altPwyLSBZKp7YbqXt4uUyNC6EpC5C6sgSwp7OTYoe2GG8mUt6jdcROSC8Kc
        7IlywreXFo0TSIVb8Ud3lzWmffOtrXgpjPtyJDeNNAWtRa5XNmjkbR+8l1g8FOGA
        ZoEorkZUZK4FVQ==
X-ME-Sender: <xms:SYQkXulR7VnYWUj7ovL5aZqgowfoLNSyJ7vaHteoh_oghZke52KEoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:SYQkXteuJgpxKJ6t9F3AY8hVzNvW4F8-KqB1uxxxLekzxGmM_lVE4Q>
    <xmx:SYQkXs2iiskIvKpxlYDy3aCAj_z2LS0AGcbr-vzvu2xepKgjaxvmUA>
    <xmx:SYQkXqlkCaAZZrt-A9vzWYSP_-nGM8vXO6INHuyjn9yNqHCdWJBswA>
    <xmx:SYQkXmtIEYS_vRRMVuwfqVzBqDA3XDfHBGNmB9F0kKgqc29m-ppzHQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4339480062;
        Sun, 19 Jan 2020 11:31:05 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/9] arm64: dts: allwinner: pinebook: Remove unused vcc3v3 regulator
Date:   Sun, 19 Jan 2020 10:30:57 -0600
Message-Id: <20200119163104.13274-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixed regulator has no consumers, GPIOs, or other connections.
Remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 3d894b208901..ff32ca1a495e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -63,13 +63,6 @@
 		};
 	};
 
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
-- 
2.23.0

