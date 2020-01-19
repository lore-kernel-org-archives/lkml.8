Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5722C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3FF206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="gK+YYer/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdU/dUZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgASQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:09 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42323 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728775AbgASQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:09 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E0D121B2F;
        Sun, 19 Jan 2020 11:31:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Kcy6+Z3qK/WAO
        8fFddaISL6a5kd1WYJvw6svqY+H9nw=; b=gK+YYer/2UZbHhYMZ7b4AZ9txi0af
        Pkcn1ViuiE1c2UmudDJUsbda40TDvxLXlhppe8f2i0AJNuCD65dvYv/W5omsuHts
        5V0qmB+UM3QBRTAGvzDIwMeYaBVg1MxDHCkdQOq7zXbA4muWLQw+KCIXJZLIFFfB
        3ZhmdvXMfLcQqS9EGmqi9RZGiQuMHiyVs8/WhEgEZUoCsQGUGchRKvGug3SoKDNI
        oOK3SwRrmzPUdPH3RSto3aO4WuCFnsceN6ej3I9YUrRHGbmWBbLRDxt9Jkhz5n9y
        PpWSTuOMEE5z+yQd73CVeQRWNjm/7V6MPN9PzQ4ee5WuqMXfzXU5zS3uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Kcy6+Z3qK/WAO8fFddaISL6a5kd1WYJvw6svqY+H9nw=; b=jdU/dUZq
        nXsi5GOOvRuwnqzFFv77e4X67KoFYyHtj1SWsQV+ZB00ntwZw36t3SfLG7XqGb4m
        kZCYDdTCwUtjgx9tOf+fInDEeUc55NtcnHmm4BYUiYfU53jgVbZs1D55iMZOM8qU
        96ioxvxayTf6qRd+vdTYGXBDDzXEyy7lIgoCdPJ24xuXXXJODGh0ELePCtcv8Of7
        0vih3hLa4TRHB8Rv77w23WNSsXSoQ5Bp/Sm2qHW0rsQkDPtCA8HjXY6tnKRKtdth
        XDYfK7aTEzoy/Oz4vl+G+6WnhV3Didspnf9qZph8kLT1OiuiDyswDkACTiEb6cQ4
        iy92G2XYyZ2DfQ==
X-ME-Sender: <xms:TIQkXrlrAf9s9WYIX0NDWwBi6eAJBzmacJf_Mxl4cP2QxVJZoved2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:TIQkXjEJFDjSvKJi4qszDkzWj6-N94UZyM5AW94kDQnNoMBGwY390A>
    <xmx:TIQkXsrcoJkYbYGgjNG77YWRzsRs35EoYNv3zv2Y5gXoRHlrWidL0g>
    <xmx:TIQkXn6HErUFi_oU6-ObQKeTrrVN4kQdOaPeSZEI-iJFg5a3hhofAQ>
    <xmx:TIQkXm24VFfRAbDb3nKyPNYpHYELRWUvHP2rFCOkC4ub4l4IvIh4zA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2DCD80061;
        Sun, 19 Jan 2020 11:31:07 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 8/9] arm64: dts: allwinner: pinebook: Fix backlight regulator
Date:   Sun, 19 Jan 2020 10:31:03 -0600
Message-Id: <20200119163104.13274-8-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output from the backlight regulator is labeled as "VBKLT" in the
schematic. Using the equation and resistor values from the schematic,
the output is approximately 18V, not 3.3V. Since the regulator in use
(SS6640STR) is a boost regulator powered by PS (battery or AC input),
which are both >3.3V, the output could not be 3.3V anyway.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 3e762f93671a..96434fdeb5c0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -21,22 +21,13 @@
 		ethernet0 = &rtl8723cs;
 	};
 
-	vdd_bl: regulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "bl-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
-		enable-active-high;
-	};
-
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 50000 0>;
 		brightness-levels = <0 5 10 15 20 30 40 55 70 85 100>;
 		default-brightness-level = <2>;
 		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
-		power-supply = <&vdd_bl>;
+		power-supply = <&reg_vbklt>;
 	};
 
 	chosen {
@@ -57,6 +48,15 @@
 		};
 	};
 
+	reg_vbklt: vbklt {
+		compatible = "regulator-fixed";
+		regulator-name = "vbklt";
+		regulator-min-microvolt = <18000000>;
+		regulator-max-microvolt = <18000000>;
+		gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
-- 
2.23.0

