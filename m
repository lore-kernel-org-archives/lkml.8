Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C1DC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1CF2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TfGI2ExB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xsx7hi2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgASQbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45419 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgASQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DCE0821340;
        Sun, 19 Jan 2020 11:31:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=eogqFitYBM+yu
        0GWe5rWoHs4iLU9w3W4k8bbjQ3IwDE=; b=TfGI2ExBS3+aOPp2AJqFojNUmiEe4
        5/g0WKFp/IxGhatVnxC165fmUlk0iHpnR8VxzDAqSU/ddY2hxTaGudAOpuIOMxVT
        irZ9N0y5mWc/iEv0KHSdCB84Ll9XpSlrW6qW36bPE9oFPHC8Tsnm1ZIdXmtf+NIo
        CIwlo6nNFM1H+Dbj6MAyIE2WMzIS2pB/qx1AAex+Ftg118WduYgi+1pLNA+J4HTq
        cNdIsTga0LWeOYHa97i0b72sjGDGbJDq5kBHZaog4g9EP3N43kJv4w8Xb4bHgR5c
        /8H5CW6zAnF+iha5I+uXvJ5u6ua666qWkcaFETQnzdJD541k/gnJY3yPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eogqFitYBM+yu0GWe5rWoHs4iLU9w3W4k8bbjQ3IwDE=; b=xsx7hi2s
        XsPk8Qf83SdnCARcIjre0PbFqVyCsE57z05he9RmkIqmsFtUFSvr+woIM/dEd6d8
        /+zkZXq6OG1zqHWkooRgz+0EQnU0fa41AY0gQRpD7ezQzvKfjEqj6OoQjOlhe1UK
        OuuvNddVI5pMKzVH8uD1hCEbZf3Vu0f70K9ASZqFzNWbop/wSrMOV6xlj5v2lKWf
        ORQwLM4ApyWZ5/qb3iSI0RBgDAukIOr07znZNyDEIHnC87TVNevehZUAzQcOiNwT
        yDtALcAT+0SPVu0HogkEipl0uelzu/jJAPex0tiM2ssBV5AlvOyK1MJkGmr6PpAh
        HGij/+RQUlAWsw==
X-ME-Sender: <xms:S4QkXq6ymCxJo8EyVJl8ah0I2ssDqDzxOoHgCrPxOdjR_0tSw2_BJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:S4QkXhlPCNOA7DqdniZZ7zYwwM0Uz2WoFrqBerygje6miVFf-SX9fQ>
    <xmx:S4QkXrMNGT6JmYrHjzBl9ZV9yVaWMzhkxY3VP1zvVucbYmiBmvhWxw>
    <xmx:S4QkXjpgaUn0QQn2vMM2LfrF6cDgiaZ9_nCZzMT6ZMGcclNgVMLApw>
    <xmx:S4QkXgfpSKDTB3ShK4kr6J36mV9xxBMLDXWMygCypDOmlBppkLfjhw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C3438005B;
        Sun, 19 Jan 2020 11:31:07 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 7/9] arm64: dts: allwinner: pinebook: Add GPIO port regulators
Date:   Sun, 19 Jan 2020 10:31:02 -0600
Message-Id: <20200119163104.13274-7-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 SoC has separate supplies for PC, PD, PE, PG and PL.

VCC-PC and VCC-PG are supplied by ELDO1 at 1.8v.
VCC-PD is supplied by DCDC1 (VCC-IO) at 3.3v.
VCC-PE is supplied by ALDO1, and is unused.

VCC-PL creates a circular dependency, so it is omitted for now.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 7c6a3d204dba..3e762f93671a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -162,6 +162,13 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_eldo1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_aldo1>;
+	vcc-pg-supply = <&reg_eldo1>;
+};
+
 &pwm {
 	status = "okay";
 };
@@ -174,6 +181,16 @@
 	status = "okay";
 };
 
+&r_pio {
+	/*
+	 * FIXME: We can't add that supply for now since it would
+	 * create a circular dependency between pinctrl, the regulator
+	 * and the RSB Bus.
+	 *
+	 * vcc-pl-supply = <&reg_aldo2>;
+	 */
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.23.0

