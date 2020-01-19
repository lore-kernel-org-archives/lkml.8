Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7428FC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1B52064C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="PdU80dp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMaLqF1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgASQbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:20 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51537 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728733AbgASQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 890B321B7C;
        Sun, 19 Jan 2020 11:31:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=BdLsbiYqLIzZi
        4myyOEJxDQqqWES1KD/D8a1k+nQK5c=; b=PdU80dp4KEjsSJhxcUV/NNV+wMYy+
        5+5oxbkIrh1JalAnUzqi8i24Kzuoi6kz9Sp3pn7VJkzn7eksLlGL1OQfyH2O02RI
        5esaS5y68LrOmziAsZZOCZhqp1DjI0W0vsTtXJWFzYfCq8UuwqYPRsWQ8hN/rvk0
        2Oab2Nk1PsKm+t/qwaOFHXITFoUo6FCebO/deofRXhYG1swgm6I2clfgeXxxW4e4
        itl3abrGzMOAwZr9cVxqwc4vquxih4XEAJ6Se3/uEGfDrDaB3cxG3CRxU+teIW6q
        VKKmuK8ppptDtYGw4SVu9d0oEdBJkUAdAEq0PE92KcKFhuPxXmR19vT7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=BdLsbiYqLIzZi4myyOEJxDQqqWES1KD/D8a1k+nQK5c=; b=IMaLqF1C
        koSUy1HRzvu3Mlv0fWI576H2tcQdsqwrzIf/Kmi9EQyzPcswy//rAYvIfT5J8Mea
        kB3d8zfclikyHNWO9z6bouT8CF6dWUEO00flJ7xAVz2Zup8tGyYaVM7k4DG4R4Ek
        v6fN2r1ywcM3J8dWZXPTWui3JTUiyC2no5YN/f7aXQ+EeH9d/VbTI02W2hux5NvS
        YsbNvPzHvU6x7B97D18JXUwPM47Q/UUDpptsNyIXXRDWWTBHwGPdK5b2Xrj6elLS
        gXeXEpNj6JcDA0YTe+XN1hKxFBayyrxBuDtszxMPVOIqE31+VqIltqE0nf3nNi0d
        vrXW8yGOobYjmA==
X-ME-Sender: <xms:S4QkXhvcz0sOxxdDEC8ftpsGCur5W8GSEgqZPaijUT8QB4aEj9JmSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:S4QkXqIMcYV_83Q3TiWwDN9XtafXx9cBPRcBjSYkiU3aZthoHdlxmQ>
    <xmx:S4QkXo0tbc533YBGGfnQLjQlvDHGu-1qKwVHWkHaskR5chFkkYSuaQ>
    <xmx:S4QkXtDOozcBr-bZibrkk8o3GYl02b1Tobrc6q-LXAT3lq3P-VpaIg>
    <xmx:S4QkXlbsawf6WJMaAoeEPYHwsgtuaS0ogcEvfIaL1j0YTOWn6SinJw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id ECBCF8005A;
        Sun, 19 Jan 2020 11:31:06 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 6/9] arm64: dts: allwinner: pinebook: Document MMC0 CD pin name
Date:   Sun, 19 Jan 2020 10:31:01 -0600
Message-Id: <20200119163104.13274-6-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally GPIO pin references are followed by a comment giving the pin
name for searchability. Add the comment here where it was missing.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index af902b565b0a..7c6a3d204dba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -119,7 +119,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
-- 
2.23.0

