Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8642C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B303120EDD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796671;
	bh=4viBEan7JfS5u7rHMOLLKJU0AwOPR9C3uj5SCmPphdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b22OVJlpxOo7eALf5VGKX08QnHytjOvSuu4ZnXLEfFeyt1d6TXOkWG7BWCrAScJbh
	 oObmXzenE1ekybVqZ3S7JQ76Yay4BX5hn9H7mdzIQNVSVrbhr2OxYKlBJKk10cCtaw
	 Kv2yRQLomFdiws1E736ZmDVuf0+LCerkJG0UtYXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgH3OLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgH3Nyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:40 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A1F20757;
        Sun, 30 Aug 2020 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795680;
        bh=4viBEan7JfS5u7rHMOLLKJU0AwOPR9C3uj5SCmPphdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2TgCA7fJluiAieUrO9+xzlyA/MuIJujY0zb/gPtTYPaLVDZPHUluh2ZiARs1hm1d
         4GhT3zR41IW3YFzjJ1HjA79mW/aWCL6PE9cJsFLBVieIn2QuIi62cNgZnUAbEPeWb6
         aazh4WpLAapx1Oio6l3vQzQ06kX0Qa7ri7or3TdQ=
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
Subject: [PATCH 15/33] ARM: dts: exynos: Align SPI GPIO node name with dtschema in Galaxy I9100
Date:   Sun, 30 Aug 2020 15:51:42 +0200
Message-Id: <20200830135200.24304-15-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree schema expects SPI controller to be named "spi",
otherwise dtbs_check complain with a warning like:

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: spi-lcd:
    $nodename:0: 'spi-lcd' does not match '^spi(@.*|-[0-9a-f])*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 1d200a5e1b72..5623e17889a5 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -147,7 +147,7 @@
 		};
 	};
 
-	spi-lcd {
+	spi-3 {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

