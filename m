Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4597AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADEA2071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599062443;
	bh=fKssNxEpGlEeBwAJ6aSQrLneqbFsntwOpiEKOEP4OVo=;
	h=From:To:Subject:Date:List-ID:From;
	b=PZdBtIo1Tf5ZaqCWVGqIG3GXKJy9/M0MfJ1ET2hZ2A/t35Et2gcsDbYAqN56i2Rlu
	 y0G1q187H3gGqnsBWID2LXzN2MzJoS5NPTpsvH2r/gZ2SIe7Nj6UBxNX/6/WeFeOne
	 QAO641KKRG2XViDL/tMS8t7sBANsNV3YjqV5iiuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIBQAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:00:33 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2042072A;
        Wed,  2 Sep 2020 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599062433;
        bh=fKssNxEpGlEeBwAJ6aSQrLneqbFsntwOpiEKOEP4OVo=;
        h=From:To:Subject:Date:From;
        b=yU3KFPShOWBRqkV7u6Ory9Vzxd+pQ0OJ9CDFFBBx2tI2VCw6Ki/c30eGtFaTdZStz
         IEKRjzyatUsz87JCnWfZET2ogEppZE+1VnV5b/BIx4+QlZz68SIBUO/9vjEUVrQeN0
         vgpCsNDQwWg7r8Un7KXMlZ5KWvdR9wNpLFTwLRl0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: aries-wm8994: Match compatibles with enum
Date:   Wed,  2 Sep 2020 18:00:25 +0200
Message-Id: <20200902160025.20922-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common pattern for enumerating compatibles is enum, not oneOf.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/sound/samsung,aries-wm8994.yaml          | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
index 902a0b66628e..1c6947294825 100644
--- a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
@@ -11,12 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: samsung,aries-wm8994
-        description: With FM radio and modem master
-
-      - const: samsung,fascinate4g-wm8994
-        description: Without FM radio and modem slave
+    enum:
+      # With FM radio and modem master
+      - samsung,aries-wm8994
+      # Without FM radio and modem slave
+      - samsung,fascinate4g-wm8994
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.17.1

