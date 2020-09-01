Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B61CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5300820684
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598946950;
	bh=FyC3vz2QUi9Tu/bsrWsjAasFxnvsQF+943Ds8MXgSnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dMAJ/Y2gbmepHs9H4g4wvdVY0u+nhpYN3+wULT4wk7/hj85H6pM5kQ2+lN5hQz8oc
	 uWIwHrYu2JBfX27cmZV/+GvYo0rvs+MqWJFaVpe/0UJ4Ic5PiWvlyBVZaB/laAS7tz
	 YtxGRhJct8zEL3MmG02drz7C9RZOCz44piuFoMKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgIAHzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgIAHyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:54:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFA82071B;
        Tue,  1 Sep 2020 07:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946876;
        bh=FyC3vz2QUi9Tu/bsrWsjAasFxnvsQF+943Ds8MXgSnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/qTLQXe/NKD+uf9Ap3U5F9zjSeTZNF6RjEtKcibZTPm+YrkKlf0W5uX7dR3LkBgD
         V2O71fg/BwedqMe/2M3z3WNtGrqcmksRDXgkYUc9D2y/dNwGHBnUGyMzOCiyJHK5Ap
         M7tn2AwBt29ZP2wjOpc7yVd0tN7OGOZjaimzjA8k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 02/13] ARM: dts: exynos: Correct compatible for Exynos5260 GIC
Date:   Tue,  1 Sep 2020 09:54:06 +0200
Message-Id: <20200901075417.22481-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5260 SoCs have ARM GIC 400.  Correct the compatibles to match
dtschema and fix the dtbs_check warnings like:

  arch/arm/boot/dts/exynos5260-xyref5260.dt.yaml: interrupt-controller@10481000:
    compatible: ['arm,cortex-a15-gic', 'arm,cortex-a9-gic'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5260.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 154df70128f3..9b45e052cca9 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -162,7 +162,7 @@
 		};
 
 		gic: interrupt-controller@10481000 {
-			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+			compatible = "arm,gic-400", "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-- 
2.17.1

