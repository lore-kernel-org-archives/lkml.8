Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE6FC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95EF2087D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598786802;
	bh=yMnFhXHlxippItZdgfHLbRUuY7UCY/HWezFEFtyBv5w=;
	h=From:To:Subject:Date:List-ID:From;
	b=vzvaegx2NRdbi2wzAIKe5totwIqH+Csl643k89EiBM8bG0k7PSlEQKqDhmkB883Lr
	 72vmXk2tPk/e2uqqMtM0WpkvonadBnkqgCzbbKXMioPoV0y8uc469SwnebA/tMs4uq
	 GXcFTmjxTLrq28/zhLKNRfaXFZrbl9H/oBNGif8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgH3L0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgH3L0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:26:40 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C0D20714;
        Sun, 30 Aug 2020 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598786799;
        bh=yMnFhXHlxippItZdgfHLbRUuY7UCY/HWezFEFtyBv5w=;
        h=From:To:Subject:Date:From;
        b=lniyAStplYVHoTNln5UL2w9VIlSX2osOegi9pZOhk+UV7Kgu3WPGvFsdHJLNY9bqW
         7539o/8ImcjHRET4t+KRWbHWtVL6RS1vzgFMk5aN8M2xCC191Z/GADFg82HFmf4PDq
         8f8Z71I6b7kalIeqaQmXedkusxCzxoy3eifDrgbk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing sound-dai phandles
Date:   Sun, 30 Aug 2020 13:26:32 +0200
Message-Id: <20200830112633.6732-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "sound-dai" property has cells therefore phandle-array should be
used, even if it is just one phandle.  This fixes dtbs_check warnings
like:

  arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0:1: missing phandle tag in 0
  arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0: [158, 0] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/sound/samsung,midas-audio.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
index 1c755de686f7..578928e67e5c 100644
--- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
@@ -21,7 +21,8 @@ properties:
     type: object
     properties:
       sound-dai:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        maxItems: 1
         description: phandle to the I2S controller
     required:
       - sound-dai
@@ -30,7 +31,8 @@ properties:
     type: object
     properties:
       sound-dai:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        maxItems: 1
         description: phandle to the WM1811 CODEC
     required:
       - sound-dai
-- 
2.17.1

