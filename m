Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F9C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B525A2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="BB2raS0t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1jZnzmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgASQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:09 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42323 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbgASQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 232BD213CA;
        Sun, 19 Jan 2020 11:31:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=hRy0Rr9iYfUJ+
        i5sc98uoqEzTLMSGVVLNQOlk6Dfgms=; b=BB2raS0tSvNhDlx9uap5mrxhESEnk
        b5HKO+rF7HgUnhszuwTnFOlVJDiDJ0ByDPzXbm7eL3PA03YXetsg3r8zhBFwkSIB
        3XgZKQ9aR8pPk+5fj1bd9uSWw2juRL+GZh8FxtiXwZju2NM+Cuvt9VvSAkHWkb1R
        qm2WuF+yGb4yjBJPVCsIU3kfIuv3dQ8r0gI0vpD8YSch6T5TUov6JMIkALkkzvVB
        z//ax0HueQB9xMcXIEb7c1O0O61AacQSyBxINFiNZsPfEuBRln2Y0ctXrrB3Tvk+
        MJdkzNuJ7UnWKdGWkboEkh8++XgdjrsF+yNE3JVYTFtiri/kPPG6lpP3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=hRy0Rr9iYfUJ+i5sc98uoqEzTLMSGVVLNQOlk6Dfgms=; b=i1jZnzmF
        cgbUYlLNBbqn2QrpxPYx9jr2O8zQzDS6fViPj0o+xoYVmlmnGBfnYxeuDR3q102o
        JblNdUw7hdRPmP88MFJxuJPxsmmpjk95+JAc/Y6ZIf4BysOgWn+vseWUKCmDn/Ms
        ++8vuP1+U+NBr0YnMYSrC7PSiWcED/2C+UwBvm3BL7BvQ5cMarOWYycH9BTqH/q/
        STqa9hgw6LHNnj1/HnDptfsI8Z1rFCe9oRzcZM7r7BETaHtANawlcaK43qcCt1BQ
        t7a/OhfhRz7QKp6/9LAvMc/XECnCGumGrTavYA7v11cMrN5rb5TZDwB7V0HhUjn/
        m+LSGpV4xNzKRg==
X-ME-Sender: <xms:S4QkXgbQOtXRL8KS3Izt3CGzW64xSRYeUfwjqxpCzMWnu_CbZ36DDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:S4QkXuRYA4ll5vDJt_LzzZRvQmqGJmRbov76jQ3oFz4dAN3AY6uo8w>
    <xmx:S4QkXrxQ7ePJ_xMAe5Wv9IhNtb6vYJOBWYKfyNjThq4Rm_gLvWURng>
    <xmx:S4QkXscdoemS9ta9DDpthFSZaY969Kh_WI3hugv7vj_Y9eywBTpmmQ>
    <xmx:S4QkXrNsqwjeJx4QUzYXygy8RT5u5sLPYROA7YeZLr7ApTOO_0hTbQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 857B78005B;
        Sun, 19 Jan 2020 11:31:06 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 5/9] arm64: dts: allwinner: pinebook: Make simplefb more consistent
Date:   Sun, 19 Jan 2020 10:31:00 -0600
Message-Id: <20200119163104.13274-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards generally reference the simplefb nodes from the SoC dtsi by
label, not by full path. simplefb_hdmi is already like this in the
Pinebook DTS. Update simplefb_lcd to match.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 97e412fc4e4b..af902b565b0a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -41,12 +41,6 @@
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-
-		framebuffer-lcd {
-			panel-supply = <&reg_dc1sw>;
-			dvdd25-supply = <&reg_dldo2>;
-			dvdd12-supply = <&reg_fldo1>;
-		};
 	};
 
 	gpio_keys {
@@ -302,6 +296,12 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_lcd {
+	panel-supply = <&reg_dc1sw>;
+	dvdd25-supply = <&reg_dldo2>;
+	dvdd12-supply = <&reg_fldo1>;
+};
+
 &simplefb_hdmi {
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
-- 
2.23.0

