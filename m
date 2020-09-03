Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB9C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1D520E65
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599160488;
	bh=aY9WSw+KtEcd/Y/kDDSzJvuWuATd0tgV5DIFu+97x2U=;
	h=From:To:Subject:Date:List-ID:From;
	b=bDlTyD5Rkob+OB/djGXQ1DnctLxp80X3NrKrs4VnkeYYMBJLrjUnYzlyJje6vC5uK
	 ao5INJIZWLdOQXwHNIKvCuikMwvkRge3qtrkznD2ZK8tGj3J9cey9SqJaa5Pk+ByOB
	 pzHKiGUFhyYoK83XnHwWsr5vZhZYCnwvxMg9cRno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgICTOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgICTOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:14:45 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D722920C56;
        Thu,  3 Sep 2020 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160484;
        bh=aY9WSw+KtEcd/Y/kDDSzJvuWuATd0tgV5DIFu+97x2U=;
        h=From:To:Subject:Date:From;
        b=Q90It/9c77d5zJj8kdeeL2dBCwBCHOJQQqjPg9gYXxbE5piWOW96E/hIbBiWCy1ev
         bBmmhX4urz65mWPY0MELhjTAIf/LoQX5dDQ7xSox6zFk/t5JGD95c4xYzG6/vIvTz7
         KyLP4+vC8SvmNRTZvZ1zFXI8kUfOXGVd+/j+MT2M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: gpu: arm,mali-midgard: Add missing properties
Date:   Thu,  3 Sep 2020 21:14:33 +0200
Message-Id: <20200903191438.12781-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (opp-table) to fix dtbs_check
warnings like:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: gpu@14ac0000:
    'opp-table' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add properties instead of using unevaluated
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 80d519a76db2..e9c42b59f30f 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -74,6 +74,7 @@ properties:
       - const: bus
 
   mali-supply: true
+  opp-table: true
 
   power-domains:
     maxItems: 1
-- 
2.17.1

