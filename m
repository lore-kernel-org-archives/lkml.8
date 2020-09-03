Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9CBC32773
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26ACC20658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599165260;
	bh=6z3I61UrsqdEOlJteYcY9hQ+jdgGM1aWxnw3gt+fAgU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gwRMixKmDrDS9gCvuz/kag0D9yTQtOCyUVb+dmvOEilnp3tuoAM6N379HURiXlPan
	 kw6WpCRbQ+Y1HsNZPqwrn1JGGDD42myw9nt5/yx51N3lw88a+UfPxKpVQt+zY2Ou93
	 PUXrphxCtZChzmNmlLKV9zUcbLoi2k30FBEzj8Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgICUeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbgICUdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD7420678;
        Thu,  3 Sep 2020 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599165193;
        bh=6z3I61UrsqdEOlJteYcY9hQ+jdgGM1aWxnw3gt+fAgU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hL9jVygnF3BMdbkCrhqqbkhnCtKbgKYLMxqnpnapF/MU1/gThkESEQcXzOu1V05dq
         sFTDQW7vwIUvfi610Ad/C+0SpRzBbkHs/GvT6SOj8T+TWnIvjYnzEhuRon666IxCp1
         9uH7c96wyX9z+KX/KoBZNVTfSiWe66DJPEaUQnLM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: exynos: Remove undocumented i2s properties in Exynos5433
Date:   Thu,  3 Sep 2020 22:32:49 +0200
Message-Id: <20200903203250.19830-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903203250.19830-1-krzk@kernel.org>
References: <20200903203250.19830-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few I2S device node properties were not documented and not used by any
of the drivers.  Remove them to fix dtbs_check warning:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: i2s@14d60000:
    Additional properties are not allowed ('samsung,supports-rstclr', 'samsung,supports-tdm',
    'samsung,supports-6ch', 'samsung,supports-low-rfs' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 9651bb9fdadc..8eb4576da8f3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1460,10 +1460,6 @@
 				 <&cmu_peric CLK_SCLK_I2S1>;
 			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
 			#clock-cells = <1>;
-			samsung,supports-6ch;
-			samsung,supports-rstclr;
-			samsung,supports-tdm;
-			samsung,supports-low-rfs;
 			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
-- 
2.17.1

