Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98B9C2D0A6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A0220678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599165248;
	bh=rGPaazvsw6UUUMLNC7pSLAMKZMR24aj4m3T8eVAFLtU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LNEnhjlxvHCsQvU6bHpn/agrj90O5E+El1lN3Tlbw7QpaO43dfkhIxSvM0QZ6ilPs
	 UjuNg262Skr6VrCZywozpKQJvoN4liVGZVQzCpCB96o6BTRnq5BeKNGwr1DQAZnT7x
	 FAaqXqXi+sq2IHgnqXPz3CDI9+lov8A+iRNzL2ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgICUeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbgICUdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5142071B;
        Thu,  3 Sep 2020 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599165196;
        bh=rGPaazvsw6UUUMLNC7pSLAMKZMR24aj4m3T8eVAFLtU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=twPSX/J8eCw7EPQ43IcfD/idW6US0ZSlCKYsZLrCf6DMYqxT+UmGNZiLO37/ZIJLx
         4HiW95TbPfl+AWwb3sjp21IC0PnPs+DhgWvi4PFuibzUL6uhIFy4B6gpi+jAX3ORbR
         8wlEPqg+kMQifhzYnPq2SpyDMGFD4ekY7H73pvno=
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
Subject: [PATCH 4/4] ARM: dts: exynos: Add clocks sound node in Exynos5422 Odroid XU4
Date:   Thu,  3 Sep 2020 22:32:50 +0200
Message-Id: <20200903203250.19830-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903203250.19830-1-krzk@kernel.org>
References: <20200903203250.19830-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtschema expects "clocks" property if "assigned-clocks" are used.
Add reference to all parent clocks to silence the dtbs_check warnings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroidxu4.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 892d389d6d09..fe4266850659 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -44,6 +44,11 @@
 				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
 				<&clock_audss EXYNOS_DOUT_I2S>;
 
+		clocks = <&clock CLK_FOUT_EPLL>,
+			 <&clock CLK_MOUT_EPLL>,
+			 <&clock CLK_MOUT_MAU_EPLL>,
+			 <&clock CLK_MAU_EPLL>,
+			 <&clock_audss EXYNOS_MOUT_AUDSS>;
 		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
 				<&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
-- 
2.17.1

