Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285F6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB4120639
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063339;
	bh=zsve7BKRBfrbaFtHd8Ht4PQolSsDUb11ZRwxVwZvmu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rFpO4HwV3WC2C25Q2ApsevF9vQXOwEArmpCgwEaXq7R5sBR8RrHww2FK7KG6kVUeZ
	 9axzcUml1jewXetLBk8YOhU5d6gxxiWDgEWtTe0Wit4KMp2rN8ReVNbLb5zAUdNf0B
	 jBZyAmzsQB6pwsaOvXMndqJ6hb8uolkXn3t5LZTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgIBQPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgIBQPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:15:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 480A520FC3;
        Wed,  2 Sep 2020 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063304;
        bh=zsve7BKRBfrbaFtHd8Ht4PQolSsDUb11ZRwxVwZvmu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGGOiZlzZ6rcuueuRXTVencr84EBYAXLREsqsLjhkwZlsJBprvIxBbvpTy5owIiQp
         uZEiw/bZMs+IVG/O6QocyklXvR6bEj4kwPup9x1gPvugmJhkS96YtyFaOvu2x1IkXH
         6IGT/BtVnmi/J7n5WGINExaA+HsXsh00dQ1Bl3Ng=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 2/2] dt-bindings: mfd: syscon: Document Exynos3 and Exynos5433 compatibles
Date:   Wed,  2 Sep 2020 18:14:52 +0200
Message-Id: <20200902161452.28832-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902161452.28832-1-krzk@kernel.org>
References: <20200902161452.28832-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Samsung Exynos3 and Exynos5433 compatibles for system
registers.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Rebase on first patch
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index a34c9e2ab1ca..0f21943dea28 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -40,8 +40,10 @@ properties:
               - allwinner,sun50i-a64-system-controller
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
+              - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
+              - samsung,exynos5433-sysreg
 
           - const: syscon
 
-- 
2.17.1

