Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16448C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC051208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599160413;
	bh=5xuDaQDGdISJYSnuE7kyV2UyZlRMPZhBkIJjyjicBzI=;
	h=From:To:Subject:Date:List-ID:From;
	b=fEUsxyeffnslTgs4zQV4Kw2Rbiq8azJZOghnYUoBgBUEdovShwilu536U2G3Tb0TN
	 MxXvUr+WnIQJagL6mkyHF7Ogqge/8wVLgChtauSmAPCgPcaGf5XhIOqxAE+VixthmN
	 nTGjqD3yXBaAOA12ylJ5HfKNy65ddhzoCUyjrXzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgICTNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgICTN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:13:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE00E208C7;
        Thu,  3 Sep 2020 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160405;
        bh=5xuDaQDGdISJYSnuE7kyV2UyZlRMPZhBkIJjyjicBzI=;
        h=From:To:Subject:Date:From;
        b=NiubHCl/WH/T3jWrAm/ZOhg/zt2LYD4OngdfoSpvkvPZ9+gxaA6VxhknW5OjpBgN7
         f57ef94ZmoeHSxxEgtphK6QOb2QW8uzi6vR1erWZrEdua22R2eHrh+Y705cj6QNGbS
         J2upMN96tRnC3+RIgFonXeftPVo9/vXe1+rFp/Dw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: samsung: pmu: Add missing properties
Date:   Thu,  3 Sep 2020 21:13:10 +0200
Message-Id: <20200903191311.12293-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (assigned-clock-parents,
assigned-clocks) to fix dtbs_check warnings like:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: system-controller@105c0000:
    'assigned-clock-parents', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add properties instead of using unevaluated
---
 Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
index 686c13c14e32..edbe8c69387b 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
@@ -45,6 +45,9 @@ properties:
   reg:
     maxItems: 1
 
+  assigned-clock-parents: true
+  assigned-clocks: true
+
   '#clock-cells':
     const: 1
 
-- 
2.17.1

