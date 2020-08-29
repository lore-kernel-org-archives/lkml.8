Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5493C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A0120E65
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711154;
	bh=R+YptOt/CSt+P2Wj8C74CaZMIMAj5J5igqnpYW+07eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bI6b7oH8d8X14mD8FbgVDHWDvJhp688Ok3PL08VC2fm6Fg7uhcTQBTfERvTDEQ8+a
	 ldRTZPC5653S6e7Swe6fiW+6u97kQJFpv0hQ2i7sHF13lHBpVN4Ntw94RObY36lIC2
	 yBAjJ4Z+arK95fXjpBJ2y1saAGZt5wlyzyUV3g70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgH2OZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgH2OZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:25:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6019020791;
        Sat, 29 Aug 2020 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711133;
        bh=R+YptOt/CSt+P2Wj8C74CaZMIMAj5J5igqnpYW+07eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtNk4txujpBviSezAH5cbRaeNwlCH0zcAGxuhCwLxzLq/jFv9OdHiLHEFxd5amY0s
         bHtGKCzqBHiT58+c2PQjUpW8NcBfjdFvzJri3BXr7xoSFhb04qZFOxuDK2R2hnDNPd
         UdVK7pqBsoeK25H3FGG4uxQ7GvJTYdCdpr4hg5NM=
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
Subject: [PATCH 04/10] dt-bindings: mfd: syscon: Document Samsung Exynos compatibles
Date:   Sat, 29 Aug 2020 16:24:55 +0200
Message-Id: <20200829142501.31478-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
References: <20200829142501.31478-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Exynos SoCs use syscon for system registers so document its
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 049ec2ffc7f9..0f21943dea28 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -40,6 +40,10 @@ properties:
               - allwinner,sun50i-a64-system-controller
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
+              - samsung,exynos3-sysreg
+              - samsung,exynos4-sysreg
+              - samsung,exynos5-sysreg
+              - samsung,exynos5433-sysreg
 
           - const: syscon
 
-- 
2.17.1

