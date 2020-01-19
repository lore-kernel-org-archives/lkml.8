Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A2C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E083E2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="JMO0rMkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZl1js/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgASQbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:07 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54795 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbgASQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:06 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 43B2521A7B;
        Sun, 19 Jan 2020 11:31:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=XU3BXx7kzPpiK
        PBvVKiBW6xDC3euYJdkTNurYmc69dU=; b=JMO0rMkTHJ9fBe2zm0/aQ2Y3tzda6
        9/IX67VI1CEN7/TsSgONTdcqgXjO9EXUKYB8ZAsRopACt6JJ0TOZKmEIag2vBJ9Z
        JP85meOTc4J4/bLEREIzoWNF3e2xgiriT9jv4IRcEqq8wQGWKbDFUlnZt5cIUPno
        P6fFBN+H5XVtmHnhlfakWquMruDsZkHbO1i75cD4DSSDKPcvz+QtKXw/DyuE8RWU
        FWGKjFMapd4hGhBA+sikTESJWumsya9TyY0w8Wl1sClH+jyu6c7FLbOLPY8hTtTu
        pcTcC5NwaHFeUZH9e2kLkG+HcG2rvFmV0wd8LcUCDlLpdtS3a+o3RvqhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XU3BXx7kzPpiKPBvVKiBW6xDC3euYJdkTNurYmc69dU=; b=cZl1js/U
        oNghvC5cxFsm0vs48w2A2+O3u9E+wr+spCZv9DS3Fi29mrRfYChz8nVJGKIeTtdL
        tPjB/C0pP9UOC5d5X93Jt+sH18g0mUUv9785F0DB+gMvlxXoPLG+2HOzE5cAj3Jo
        WPjVwxAZRcP7Ltxev8qjzTCIuSif7nPatLoqXcGKAfS56dJJBI2b9KsEBR+OalKv
        HUojyB6h6f5oloPWRP+HDfjDhAqYHX7Wi4uLwXZAQmddkPdJvoRCltbus7pWtQG2
        FRoN+b6MfPV8Jk3odp1LPdoOQg1H6cnJgMRBJJ/+QZypfeJPhFnJC5Ie9wBf4Qfj
        HtBrRywAmuK3jQ==
X-ME-Sender: <xms:SoQkXqDAF8l2mYGXFHy3Ni98nmBVCxbRkj0GEHT0U04CfUBAfJ8opg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:SoQkXiUhGU7ufDb9EErmLWJRM_gD306q7YX_rcJSPFRB74OdnnY0hg>
    <xmx:SoQkXufZeJnYyzUjmzU5xbVW34HHtRZ8ZTSzqBXulSM-PVIkRgWt0w>
    <xmx:SoQkXjtYBna0KySNl9UF_zg3Nv3Qp3y9JJxwrzMlyRNkvjgIzfwR-A>
    <xmx:SoQkXqRfj68MVCc1H1gPDWzjVBdWWWxxeIS6NC0jlNWNcLKlfbnzEw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7B1480060;
        Sun, 19 Jan 2020 11:31:05 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/9] arm64: dts: allwinner: pinebook: Remove unused AXP803 regulators
Date:   Sun, 19 Jan 2020 10:30:58 -0600
Message-Id: <20200119163104.13274-3-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pinebook does not use the CSI bus on the A64. In fact it does not
use GPIO port E for anything at all. Thus the following regulators are
not used and do not need voltages set:

 - ALDO1: Connected to VCC-PE only
 - DLDO3: Not connected
 - ELDO3: Not connected

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts   | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index ff32ca1a495e..8e7ce6ad28dd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -202,9 +202,7 @@
 };
 
 &reg_aldo1 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
-	regulator-name = "vcc-csi";
+	regulator-name = "vcc-pe";
 };
 
 &reg_aldo2 {
@@ -267,12 +265,6 @@
 	regulator-name = "vcc-edp";
 };
 
-&reg_dldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "avdd-csi";
-};
-
 &reg_dldo4 {
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
@@ -286,12 +278,6 @@
 	regulator-name = "cpvdd";
 };
 
-&reg_eldo3 {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-	regulator-name = "vdd-1v8-csi";
-};
-
 &reg_fldo1 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-- 
2.23.0

