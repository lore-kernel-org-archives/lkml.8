Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ABEC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03CB2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Z10iIopv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWvr3JOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgASQbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:12 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45419 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728827AbgASQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:09 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C6DA121B6B;
        Sun, 19 Jan 2020 11:31:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=J50f2lbdcydT0
        Mb3z0ZQkgpbye5qC5NfAXApFJPVhDI=; b=Z10iIopv0pJzUiGi/OLDXKi1laAvb
        hBxF6Qq+iht34FKmoKN3MbB5TtseHRqyYMRwu1Omp5VUkA68GeLDxEc8Slty9vs7
        Fj2EGSwuhsEyCX0VukpDKBQBiZLunpTrah8frCx1y14nUFDBln2IJn/zxWRSwvvH
        8v5aMRugxKytvTSYCAanbc9uKjqlk6Q9ETSrFNksl2iLul6R7pTZ3PcTcbGuaweZ
        oK8dF4u3Yql4pSvB4Tm/n0gDhsuD/T5r1UJnQfoh1CBHfmVk2MCiphCTFz1K4Tvq
        QX2R6Pok7gouip/orbUOnhvbzq4PjCGw0CiXMUvqNI0oN3PlSzYEcqL2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=J50f2lbdcydT0Mb3z0ZQkgpbye5qC5NfAXApFJPVhDI=; b=pWvr3JOB
        Tv3fRCqIa+28Jf8sLTvpbDtOkRvdMqDp3hheQUdKyppxEwpTar5Um3ZmYWeiDi5J
        IJFU1yGpzKBwFfK9+1POx0PJ1h9nCKPzshwbTtLMpCTsPtfoONb+1YSt3zeoWsdC
        ujQLpB4iS7qcPAVunZ2lSaKa2mNVjkqXzWstBk/2fT91kemo2dOULiAcvLYEsPcj
        ENAyeH3RKZ5kTuXHn9riXnx0gwglbpga4X+ZdLf79WwYO7Nbokv3yJnt1/jNRH/9
        klD22YzH+9UghSGFtso1eHKrx4hWdLVbRn7cSrMCDkuWiCzUFAFyf/WD+RizWNQg
        bYV76vmJZ22+qQ==
X-ME-Sender: <xms:TIQkXqLbymyBPWQ3F2iKkh1FFYTJX-vhQe-t47JdUbJGi61nLsxymw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:TIQkXgAW4AHcWkersNdEul4j34be3FDSqROhzDbIU3IhtldtHgvdDw>
    <xmx:TIQkXjzSAhQ5YkDUwBRnP1it_lW-DPEKavbFaxuRvIu_IxzoeLLKHQ>
    <xmx:TIQkXgrJd4DehqtFoCCvEr4gsu1a4spc2BdKn9DppNLQebvhhP4y5g>
    <xmx:TIQkXgmUr4kIbZHpSLeS324Eqw_Nhs00Ydm1nM5ESLD-EFbPBGtFig>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32EB08005A;
        Sun, 19 Jan 2020 11:31:08 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 9/9] arm64: dts: allwinner: pinebook: Fix 5v0 boost regulator
Date:   Sun, 19 Jan 2020 10:31:04 -0600
Message-Id: <20200119163104.13274-9-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that AXP803 GPIO support is available, we can properly model
the hardware. Replace the use of GPIO0-LDO with a fixed regulator
controlled by GPIO0. This boost regulator is used to power the
(internal and external) USB ports, as well as the speakers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 96434fdeb5c0..12e513ba8f50 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -57,6 +57,15 @@
 		enable-active-high;
 	};
 
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&axp_gpio 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
@@ -64,12 +73,7 @@
 
 	speaker_amp: audio-amplifier {
 		compatible = "simple-audio-amplifier";
-		/*
-		 * TODO This is actually a fixed regulator controlled by
-		 * the GPIO line on the PMIC. This should be corrected
-		 * once GPIO support is added for this PMIC.
-		 */
-		VCC-supply = <&reg_ldo_io0>;
+		VCC-supply = <&reg_vcc5v0>;
 		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
 		sound-name-prefix = "Speaker Amp";
 	};
@@ -302,13 +306,6 @@
 	regulator-name = "vdd-cpus";
 };
 
-&reg_ldo_io0 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-usb";
-	status = "okay";
-};
-
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
@@ -357,7 +354,7 @@
 };
 
 &usbphy {
-	usb0_vbus-supply = <&reg_ldo_io0>;
-	usb1_vbus-supply = <&reg_ldo_io0>;
+	usb0_vbus-supply = <&reg_vcc5v0>;
+	usb1_vbus-supply = <&reg_vcc5v0>;
 	status = "okay";
 };
-- 
2.23.0

