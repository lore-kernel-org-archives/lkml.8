Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A15C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9932071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598946906;
	bh=sh6M4pSwNrEOA3urjUEc8eUnsLxhdjB4kO7NJR/6PTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPlgeFYGwlSR6zGYjg42S68mRurxhLqjnCgNirJmv5Q62oOUfFyl6N1d3HwJuXTrx
	 7WDCiKAT3tfntv3eYa1v8Frmtm+ACD7NvbK0nbvr2PdYJYBP8KpL8RtYcyDf4SjxfP
	 j2H9KC+Y4pf+b4VLQUWBwLZGhCr1HQCBmCQyf2dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIAHzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgIAHzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:55:01 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B9C2098B;
        Tue,  1 Sep 2020 07:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946900;
        bh=sh6M4pSwNrEOA3urjUEc8eUnsLxhdjB4kO7NJR/6PTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/806Q3Ef54Brm33Iio3K8uQwO89bZOvND1RKeTqoNlaPNKf9A+nwfNAHPklFg6O7
         msK93tZN+TUX2D8qesVep103XRRBcyBY8k0vYU7k/0R/3J1xMp5B1MA8gyHJTJjADv
         845QH6qjNccjbiMV1xml7qqJR7NTY/GR8mAdTV+4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 08/13] ARM: dts: exynos: Add max77686 clocks for S3C RTC in SMDK5250
Date:   Tue,  1 Sep 2020 09:54:12 +0200
Message-Id: <20200901075417.22481-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock-cells to max77686 PMIC node so its 32 kHz clocks could be used
later in the S3C RTC node. Except making the S3C RTC working, this also
fixes dtbs_check warnings:

  arch/arm/boot/dts/exynos5250-smdk5250.dt.yaml: rtc@101e0000: clocks: [[2, 337]] is too short
  arch/arm/boot/dts/exynos5250-smdk5250.dt.yaml: rtc@101e0000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 5c42df024adf..00af7fb65080 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -7,6 +7,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "exynos5250.dtsi"
@@ -129,13 +130,14 @@
 		reg = <0x50>;
 	};
 
-	max77686@9 {
+	max77686: pmic@9 {
 		compatible = "maxim,max77686";
 		reg = <0x09>;
 		interrupt-parent = <&gpx3>;
 		interrupts = <2 IRQ_TYPE_NONE>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max77686_irq>;
+		#clock-cells = <1>;
 		wakeup-source;
 
 		voltage-regulators {
@@ -368,6 +370,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &sata {
-- 
2.17.1

