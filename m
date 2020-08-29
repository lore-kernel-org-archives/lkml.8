Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD3FC433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F451206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711177;
	bh=ZPC2r53bEziZCpdfmQrkMVPlGOOeeG9AyiFx16cp2qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E39fHBtUroAgdBn8jBLWKYypWc6fAskKwV92wqCgcWPeqD8r4PzNilkHawp2SFZiz
	 gIhqoG1EZuEBIGnOo6YfLQJlHOmrq+3E6AyZ/eiFMC9oUXu9YRkdfEcb9jfXf1ALl9
	 /52ecVh8Y8G/bDrJW0y4hf7SkPLry48YmWGJm+Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgH2O0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgH2OZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:25:48 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3EF206C0;
        Sat, 29 Aug 2020 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711148;
        bh=ZPC2r53bEziZCpdfmQrkMVPlGOOeeG9AyiFx16cp2qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS9oJ9HUao9ja/oGRphCZRqBDytU9+3ps7NueDbRsBYutROOVgOWbwj0bpN/8Q3o0
         62aJOfN9Ub53/A1VEIAKb79LDuNEtclQwKknjbeiEB6rIzJlZcTJbg/kqwHpWZpODs
         7CXh/ZHYfzf6EnSg7iogoj5YlgabyZlJhjYEaV4c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 07/10] arm64: dts: exynos: Replace deprecated "gpios" i2c-gpio property in Exynos5433
Date:   Sat, 29 Aug 2020 16:24:58 +0200
Message-Id: <20200829142501.31478-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
References: <20200829142501.31478-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"gpios" property is deprecated.  Update the Exynos5433 DTS to fix
dtbs_checks warnings like:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: i2c-gpio-0: 'sda-gpios' is a required property
  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: i2c-gpio-0: 'scl-gpios' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 250fc01de78d..6246cce2a15e 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -87,8 +87,8 @@
 
 	i2c_max98504: i2c-gpio-0 {
 		compatible = "i2c-gpio";
-		gpios = <&gpd0 1 GPIO_ACTIVE_HIGH /* SPK_AMP_SDA */
-			 &gpd0 0 GPIO_ACTIVE_HIGH /* SPK_AMP_SCL */ >;
+		sda-gpios = <&gpd0 1 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&gpd0 0 GPIO_ACTIVE_HIGH>;
 		i2c-gpio,delay-us = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

