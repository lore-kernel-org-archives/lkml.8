Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A42C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA77207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598787017;
	bh=CBW3xSf21q4dAmNmmQKGXwuMoBGBt5jvhTlTLQsPdy4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QhDYpsNOIRyQ33HC6RoHIFmUy57en2S81MS3uNAdvRfkmqgIptD0aiptjK9dCpgoq
	 15/Nl/bWslZ/tu1BDuFbZUaPdjv+vH6AI6I2+eLVx+tGgiT8wuDgsY5slEpWzXoYOl
	 8Gv4dl9rbUadXDeE5UXiYcCDtZvnJJcB1xzx31ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgH3LaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgH3LaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:30:08 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7686520BED;
        Sun, 30 Aug 2020 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598787008;
        bh=CBW3xSf21q4dAmNmmQKGXwuMoBGBt5jvhTlTLQsPdy4=;
        h=From:To:Cc:Subject:Date:From;
        b=ovQRKGHUKWDlfzVl/w2XG4NetqGBPXL/MPSh10UgshPsm50nn93M4evkEOwm/NspS
         /9YcwghMiDqGYaM+QyqhP2di9veJFR1wp16yVK6DEHvWqlGoPXNbLP8w7SDLNwABvr
         ryXxHchzhC/s0HQQPWb0xATk83368giWc9J4Sgc0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: gpu: samsung-rotator: Use unevaluatedProperties
Date:   Sun, 30 Aug 2020 13:30:02 +0200
Message-Id: <20200830113002.7080-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional properties or nodes actually might appear (e.g. power
domains) so use unevaluatedProperties to fix dtbs_check warnings like:

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: rotator@12810000:
    'iommus', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
index 665c6e3b31d3..c897c687bdab 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -36,7 +36,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.17.1

