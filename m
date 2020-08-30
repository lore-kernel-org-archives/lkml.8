Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D56C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE912071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598786824;
	bh=zHR9TJ8jVNiVPvQ4aST5WzObGLoue/3fhOOFDqyVYUw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X4tOEJ15zVSA2uPaezSGNv+ceeLVBQy9igYoe/Yd3qT4dhAgldF903QB82mZ0HQY/
	 Hc9iszCl6Lbaj7o6lcc+M3agiXhIS8otyoqfZcMdn6sGH6INxTL3ecnjodD6nYwuqb
	 HGolAAfxKwbrGfOhp3ZOT8N38Ob1pyGKSXx9sPQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgH3L05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgH3L0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:26:42 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFDC208CA;
        Sun, 30 Aug 2020 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598786802;
        bh=zHR9TJ8jVNiVPvQ4aST5WzObGLoue/3fhOOFDqyVYUw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XAr8sG/dLCMo1XPpaXff3tNidTfKg5jy81og+3ja6RYewE9kTDvR4DrxLzyRBIMBT
         U5RM0YQcJQ4+VZ5v53PSyWKiNoMx+2b7phZ9yUB01Pi2SiHH/ahiZY5pMun3uko2+8
         7q3+T7ezJTCkTXOC7Nne/MWWkPAlbMb9NbtxA3Zw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: sound: odroid: Use unevaluatedProperties
Date:   Sun, 30 Aug 2020 13:26:33 +0200
Message-Id: <20200830112633.6732-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830112633.6732-1-krzk@kernel.org>
References: <20200830112633.6732-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional properties or nodes actually might appear (e.g.
assigned-clocks) so use unevaluatedProperties to fix dtbs_check warnings
like:

  arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml: sound:
    'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/sound/samsung,odroid.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
index 8ff2d39e7d17..de1be3d6d1e9 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
@@ -69,7 +69,7 @@ required:
   - cpu
   - codec
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.17.1

