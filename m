Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16FEC55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5C6206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="MXYvLLEw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I6/lLaf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDVELU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:11:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58539 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgDVELT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:11:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CB7D5C011D;
        Wed, 22 Apr 2020 00:11:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Apr 2020 00:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=F1dj2Jw3YDEgFV7WpVHDIIKM8X
        ojVODpM5ZQVusEuJM=; b=MXYvLLEwShFV7Dm5T/etH8ddYFj7Rzkh6OZFhNMgCq
        LVC7aVazTJhWfaIWGrgE4yyMA+cZEH9GO5xiBQmVYcBGbJNONh37rwp7edlihMnV
        AGnZaycj22wMsimVKiNBN2GJQp/cVOy0FR/p2XFg9IIzMytq3wPvTW9HMu/6yLVd
        0yI7b6DDnSjyoe/NyegEOpLaCE4PvFAHfqyD2yGtY4odM6dYmcl2bX2xXwc7v7IC
        9p03Ypw+dKZ3Wiwg274J+je4nZ16f5Mh69iJE0aDjT3wSJ0YCBlk2KZO/XVT8ND3
        /NySffPG2VvjNa925/VSnokPHri0gkofc3pdAWb/IhzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=F1dj2Jw3YDEgFV7Wp
        VHDIIKM8XojVODpM5ZQVusEuJM=; b=I6/lLaf6mN8ViDw9W6zmLNRPTP2Q7dBzW
        O6vE0TjGDKeXifaidQVvkcn/gNr7l72X7Cp2Q2UDGScoLbfeqAMdaJz0ys+5VIMM
        NA2jL0SKpSJZM4UDH9IMdsshomiOt3+MzsdNDOZnBxjmvaENaMZrE8+Sl7enDaJi
        Js+gYZ3N7x0A7jtfRL45077iLACz+ZKOpE4s8oH6SXwcIKntcR8xpNB0KSVbwgBy
        pdVW228l5Hn7hxjy8hW3yBqBYu84bYws9Rpjm6/+1IY7LJeo3+NcXQIK8lmcLtiQ
        yiP8sw8qdmprHy8I4mCM5T7vcNR0MTdSdWl5i/s4ZSOgBYtCDxgqw==
X-ME-Sender: <xms:5cOfXjAJUL0XNAkUOsRMfHSSZYhZmCVEDnDBIMCoZJtvm6MzklxdDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeeigdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5cOfXl32P132cVkl3p8G-YSPyd-dNlCGnZEITP4g0bN8QSoRbpxCFg>
    <xmx:5cOfXhV9Tv7UVJ6_TU_WEwAEdP5It6mnWG5rTjxSu_cAKR6gjVenmg>
    <xmx:5cOfXnm_uym1zKcNPPvObexA2m2AMC2QiS3txZa94y2myED_qTCbgA>
    <xmx:5sOfXiYwIMKOhNpq-bw3eff8wf1T5dUZUrDfKhLjgow9PquBK5NoJw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4FE5A3065CBF;
        Wed, 22 Apr 2020 00:11:17 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] arm64: dts: allwinner: a64: Disable SPDIF by default
Date:   Tue, 21 Apr 2020 23:15:02 -0500
Message-Id: <20200422041502.7497-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of v5.7-rc2, Linux now prints the following message at boot:

  [   33.848525] platform sound_spdif: deferred probe pending

This is because &sound_spdif is waiting on its DAI link component
&spdif to probe, but &spdif is disabled in the DTS. Disable the
audio card as well to match.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6f8c30d89b9b..6c233ff031c6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -169,6 +169,7 @@ link0_codec: codec {
 	sound_spdif {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "On-board SPDIF";
+		status = "disabled";
 
 		simple-audio-card,cpu {
 			sound-dai = <&spdif>;
-- 
2.24.1

