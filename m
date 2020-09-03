Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BDEC3526A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D6D20658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599165284;
	bh=92uFz6sFhAh1pp3KzCm8GS1+pP7l6jA8SS2d+ieytR8=;
	h=From:To:Subject:Date:List-ID:From;
	b=XLmXijbKXeDsO77SGiYmmIuxppo3KKXo1ojUuhwGAI2JonefHif178v8UkEydJYDX
	 I4dqgHY0PazUY1hHb5cD0ctOdkVpH1GTXxZSi4TiBEIVKIUCjPbz5WxgIjce6pSD0c
	 6zM2880k9prrAIF1IVinxrXlD/7kYaaJuMX3xU1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgICUen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbgICUdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B7620658;
        Thu,  3 Sep 2020 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599165185;
        bh=92uFz6sFhAh1pp3KzCm8GS1+pP7l6jA8SS2d+ieytR8=;
        h=From:To:Subject:Date:From;
        b=RhMk/jlN1GrSCCHWwfyBk8c6vjdyZL4trcZAoUtR2Pj6c+zkByMAfdIYCwyCTNzct
         tQ8iIiltGL5PChRum0BZyNoiFKGrh5cKwjW7wcfYwm8sMwdEZS36+j83CgtJ5m5TFg
         KJpc9Qof6PAk/hkh1Om+q3zoY7MMzk+rW4BcQpK0=
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
Subject: [PATCH 1/4] ASoC: odroid: Add missing properties
Date:   Thu,  3 Sep 2020 22:32:47 +0200
Message-Id: <20200903203250.19830-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of "unevaluatedProperties: false" is not correct as it suppresses
warnings about all undocumented properties.  Instead, add all missing
properties.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Fixup for:
https://lore.kernel.org/lkml/30b8ea43-c2d0-5ddf-dc16-a8fe80d47c38@samsung.com/
---
 .../devicetree/bindings/sound/samsung,odroid.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
index de1be3d6d1e9..e8122bc87362 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
@@ -28,6 +28,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string
     description: The user-visible name of this sound complex.
 
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+  clocks: true
+
   cpu:
     type: object
     properties:
@@ -69,7 +74,7 @@ required:
   - cpu
   - codec
 
-unevaluatedProperties: false
+additionalProperties: false
 
 examples:
   - |
-- 
2.17.1

