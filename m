Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A2C2BC84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61612206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599214847;
	bh=WU6pHG37aEbrAA9YISaAqXlwY/YxEdpsg9fKJ5lq05g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=TmNwatE6A7S5xhH8jKhE7A0dYWybqcw5SmE+scNGZBsDGCg0Rl/EoZK2Iaf1WpJ7r
	 OF1zOuF2P3KQBiUIzuI9KIVJux7TXATN7pS7JNSrl2i6axp1fr+qGBDPEgjUwrG0dG
	 joAicYbAy5eLXI9c8x2RML52346BnWTs4Pq5UrFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgIDKUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgIDKUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:20:40 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 714C0206D4;
        Fri,  4 Sep 2020 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599214840;
        bh=WU6pHG37aEbrAA9YISaAqXlwY/YxEdpsg9fKJ5lq05g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nQZGvJ0Y3wgQCmrbtJ2iBgHcvUWE3N9lyuRw/T//+TxtVJ5bLrU2v8G5EOZ75nvJj
         WR3AMuSGEkbbtvxEqdibMtOFklbJWVh+d8mz3raKQPMBtabZfCqJ5clO/HmwvwLKOq
         WggzMLAtY0txmVxFE1hbGQd8HMTg3tJg+i0WHd2o=
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos: Add assigned clock parent to CMU
 in Exynos5422 Odroid XU3
To:     Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200903181425.5015-1-krzk@kernel.org>
 <20200903181425.5015-3-krzk@kernel.org>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <d83912b7-d829-4912-9659-de4a9a5e0d1d@kernel.org>
Date:   Fri, 4 Sep 2020 12:20:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903181425.5015-3-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 20:14, Krzysztof Kozlowski wrote:
> Commit 78a68acf3d33 ("ARM: dts: exynos: Switch to dedicated Odroid XU3
> sound card binding") added assigned clocks under sound device node.
> 
> However the dtschema expects "clocks" property if "assigned-clocks" are
> used.  Add reference to input clock, the parent used in
> "assigned-clock-parents" to silence the dtschema warnings:

I'm afraid it doesn't improve anything, we just add another violation of
the DT binding rules as the 'sound' node doesn't represent a real HW and
shouldn't have 'clocks' property. Instead we could move the assigned-clock*
properties to the I2S node, as in below patch. I have tested that already 
on xu3.

----------------------------------8<---------------------------
From f98d2f5ac86d1ae13a77ef481fcbf073a1740f26 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 4 Sep 2020 12:02:11 +0200
Subject: [PATCH] ARM: dts: samsung: odroid-xu3: Move assigned-clock*
 properties to i2s0 node

The purpose of those assigned-clock-* properties is to configure clock for
for the I2S device so move them to respective node.

This suppresses the dtbs_check warning:
arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml: sound: 'clocks' is a dependency 
of 'assigned-clocks'

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 60 ++++++++++-------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index c3c2d85..b5ec4f4 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -29,30 +29,6 @@
 			"HiFi Playback", "Mixer DAI TX",
 			"Mixer DAI RX", "HiFi Capture";
 
-		assigned-clocks = <&clock CLK_MOUT_EPLL>,
-				<&clock CLK_MOUT_MAU_EPLL>,
-				<&clock CLK_MOUT_USER_MAU_EPLL>,
-				<&clock_audss EXYNOS_MOUT_AUDSS>,
-				<&clock_audss EXYNOS_MOUT_I2S>,
-				<&clock_audss EXYNOS_DOUT_SRP>,
-				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
-				<&clock_audss EXYNOS_DOUT_I2S>;
-
-		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
-				<&clock CLK_MOUT_EPLL>,
-				<&clock CLK_MOUT_MAU_EPLL>,
-				<&clock CLK_MAU_EPLL>,
-				<&clock_audss EXYNOS_MOUT_AUDSS>;
-
-		assigned-clock-rates = <0>,
-				<0>,
-				<0>,
-				<0>,
-				<0>,
-				<196608001>,
-				<(196608002 / 2)>,
-				<196608000>;
-
 		cpu {
 			sound-dai = <&i2s0 0>, <&i2s0 1>;
 		};
@@ -62,13 +38,6 @@
 	};
 };
 
-&clock_audss {
-	assigned-clocks = <&clock_audss EXYNOS_DOUT_SRP>,
-			  <&clock CLK_FOUT_EPLL>;
-	assigned-clock-rates = <(196608000 / 256)>,
-			       <196608000>;
-};
-
 &hsi2c_5 {
 	status = "okay";
 	max98090: max98090@10 {
@@ -84,6 +53,31 @@
 
 &i2s0 {
 	status = "okay";
-	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
-	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
+	assigned-clocks = <&clock CLK_MOUT_EPLL>,
+			<&clock CLK_MOUT_MAU_EPLL>,
+			<&clock CLK_MOUT_USER_MAU_EPLL>,
+			<&clock_audss EXYNOS_MOUT_AUDSS>,
+			<&clock_audss EXYNOS_MOUT_I2S>,
+			<&i2s0 CLK_I2S_RCLK_SRC>,
+			<&clock_audss EXYNOS_DOUT_SRP>,
+			<&clock_audss EXYNOS_DOUT_AUD_BUS>,
+			<&clock_audss EXYNOS_DOUT_I2S>;
+
+	assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
+			<&clock CLK_MOUT_EPLL>,
+			<&clock CLK_MOUT_MAU_EPLL>,
+			<&clock CLK_MAU_EPLL>,
+			<&clock_audss EXYNOS_MOUT_AUDSS>,
+			<&clock_audss EXYNOS_SCLK_I2S>;
+
+	assigned-clock-rates = <0>,
+			<0>,
+			<0>,
+			<0>,
+			<0>,
+			<0>,
+			<196608001>,
+			<(196608002 / 2)>,
+			<196608000>;
+
 };
-- 
2.7.4

----------------------------------8<---------------------------
 
