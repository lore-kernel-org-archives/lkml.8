Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B562BC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B48420757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598795948;
	bh=eowi/YlQ5IavL0Z7soL21uIX8ObCFOoc0EBmwO7PxzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kguVw5D3elmdjTKOCd2carzVCaKVDy4z/Zk/r2Bq5k8iOD4JlT5uyPrRtKeDYiXY7
	 lXk15waLjEhK/G/GVj8zD2OgYTGe4lJ9umpGNiSp0fymq1FxWk5xMgFb2qqeKdHft8
	 ZhQoGywz2Tol9zg3JUePvUUdhujrsqL/k1zz7h98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgH3N7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgH3Nye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:34 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48075208DB;
        Sun, 30 Aug 2020 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795674;
        bh=eowi/YlQ5IavL0Z7soL21uIX8ObCFOoc0EBmwO7PxzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0HdybJCmF8OqLsHYYfXt72CLt5BSw8evMzN0CHkWlT1yveInsLqOsJIRu15pZ4UP
         azPrMzYRpxyrtAv8xZEhUjugA062s2bicvVNhqUMuWhPRiwGjfzSutl+ykWVZ3H+Gk
         OL9wKg+ehKAyHqXKuXY+1b5rGZrM+5h1Yh5gq0mU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Denis GNUtoo Carikli" <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 13/33] ARM: dts: exynos: Align SPI GPIO node name with dtschema in Universal C210
Date:   Sun, 30 Aug 2020 15:51:40 +0200
Message-Id: <20200830135200.24304-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree schema expects SPI controller to be named "spi",
otherwise dtbs_check complain with a warning like:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: spi-lcd:
    $nodename:0: 'spi-lcd' does not match '^spi(@.*|-[0-9a-f])*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 7c83ce019b44..3509fdf8f245 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -119,7 +119,7 @@
 		enable-active-high;
 	};
 
-	spi-lcd {
+	spi-3 {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

