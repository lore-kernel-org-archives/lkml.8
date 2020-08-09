Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF834C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B625B206B2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 02:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="t4LVxzQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tMMos/Ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgHICS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:18:26 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42003 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgHICS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 22:18:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3D98F9B0;
        Sat,  8 Aug 2020 22:18:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 08 Aug 2020 22:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=gHv/rpfSLcjiU1EWYFEkVOAG62
        ry5U4QM/lSUqvQPZg=; b=t4LVxzQXi70hcj1qWNqY4NM/GErtsMOi5aiuJ2atIL
        tOB6XxOSz4yZFnHiT5aTP4rlFsLiStigtTUWodyZiPXKpj5d1L1g4/3oyt95qs5R
        xFLySds5QLSBob6+r+0CLxKycckfmaNqB3Mjn1QMAmyxZQDal0g0ODn45UKx6oQd
        cVSJ6fOL083WcFL32tPFQdoUScZzyVJt5v0GpxUJoH3e3zdgyavM/E+hLh/lKxq4
        4Vu0CzeU14Qxkfp/yzfOtglOHbOIYy1vqOr0rCZnUcx9DK3gZUBunc3A4vyks9If
        L00Aeqg8/7vLTEkIboxBOmGAAXyOKpFNhclGb9FK7prQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gHv/rpfSLcjiU1EWY
        FEkVOAG62ry5U4QM/lSUqvQPZg=; b=tMMos/TajiRlbynnTcvRwRIJhirYjp4r1
        BdT8B4CUAfGjjs0UrVd01gZQVLTPjXRVuQFFXXnyFOBColIzahdMYAL1O0824EmI
        /MnK0j56bxrP0QlVi3Jto30KdLHAGNd/QOksgF4pxRp3oEbyqAF8hzmT1g8uwce9
        9mQXAI0I4daQ+GuoZE8edXbh+ffGLqrjkqxuZuSAV3n4mfbUDsUFaUpKz2N7/+RG
        dLZ5dL5BbuHeP/LvnwFaOdQY7HbDpBS/YqhirJA4wzPfecH3pKWLDNKcxXBAWQ0K
        44fF+oDTnDd5sZdrPfxk2xOrGPYQPZwrrdOs5xrbGdYLtX9VfPAZQ==
X-ME-Sender: <xms:71wvXxYTuqDkgkxdv-0O8GQcTu4abrM3bs2hxCxsaWR9rta1nLQ4UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkeehgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
    rhhg
X-ME-Proxy: <xmx:71wvX4YAnpBS3YQnj-kWUK4fQyLk8Keu12_VoQx9uK2ISs2kFuc1_g>
    <xmx:71wvXz_1pi6sDLSfhda_v5e0ob2R0T_bUau3KXkXtUwvufuIWo0zaA>
    <xmx:71wvX_pxZNo4tvUwYKiDJFC1M-GpaUwyul2FF5c04Sy0544UQT7TyA>
    <xmx:8FwvXz1kty-PT2Bn6mjCo2Rxqsw5803bXqcOVt5BI90zlJXc5Wh_pw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 13A8930600A9;
        Sat,  8 Aug 2020 22:18:23 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] arm64: dts: allwinner: Mark timer as stopped in suspend
Date:   Sat,  8 Aug 2020 21:18:22 -0500
Message-Id: <20200809021822.5285-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible, system firmware on 64-bit Allwinner platforms disables
OSC24M during system suspend. Since this oscillator is the clock source
for the ARM architectural timer, this causes the timer to stop counting.
Therefore, the ARM architectural timer must not be marked as NONSTOP on
these platforms, or the time will be wrong after system resume.

Adding the arm,no-tick-in-suspend property forces the kernel to ignore
the ARM architectural timer when calculating sleeptime; it falls back to
reading the RTC. Note that this only affects deep suspend, not s2idle.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8dfbcd144072..5d19cf6f6d4f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -157,6 +157,7 @@ link_codec: simple-audio-card,codec {
 	timer {
 		compatible = "arm,armv8-timer";
 		allwinner,erratum-unknown1;
+		arm,no-tick-in-suspend;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 4462a68c0681..a6c8b43b99a3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -53,6 +53,7 @@ psci {
 
 	timer {
 		compatible = "arm,armv8-timer";
+		arm,no-tick-in-suspend;
 		interrupts = <GIC_PPI 13
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 9ce78a7b117d..28c77d6872f6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -90,6 +90,7 @@ psci {
 
 	timer {
 		compatible = "arm,armv8-timer";
+		arm,no-tick-in-suspend;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14
-- 
2.26.2

