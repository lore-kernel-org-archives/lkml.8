Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CDCC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B2720855
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599763716;
	bh=T/J19eEn3KKQMictkQaqPg+3MA1LjIWj4lP36KCntIQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A+oSdAcMm16ZuvuNqeVxDcE3jhJ4ey0Hlz/kU3KMF8GKkuRfTYIvESAf/zs90W/82
	 12tPtc80kIbAHXJJyFxhU7sHw02oQ510Wds8aLS7IimAUfdJ14IUXhAVQTEeZsH3wL
	 NJTpyYvXKCU8faKpOsKiO6Pui7VMS+VpswUvfm6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgIJSse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgIJSrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:47:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9192920855;
        Thu, 10 Sep 2020 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599763655;
        bh=T/J19eEn3KKQMictkQaqPg+3MA1LjIWj4lP36KCntIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JxiIkoZNk4KHaoukG4G01fCUjHEL9lzT/onLIlR092y2FmXpQHMjDVYTINe++Erap
         z7wZuUY5qrW95EnkH+SaqvKJbMni1mfaR1/CDt9607ERVJQMCcEugrrP1YhakEryDJ
         I/7xkQ5Pq2MshTi7c4tbU3NxMoVrITSJzucgwVEU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: example: Extend based on practice
Date:   Thu, 10 Sep 2020 20:47:06 +0200
Message-Id: <20200910184706.9677-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the example schema with common rules which seems to be not that
obvious:
1. Expecting arrays of phandles to be always ordered, regardless if
   "xxx-names" is provided (e.g. clocks),
2. Add example of altering a property based on presence of other
   property,
3. Document usage of unevaluatedProperties.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/example-schema.yaml   | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index 822975dbeafa..b381db1ae00a 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -81,6 +81,8 @@ properties:
     maxItems: 1
     description: bus clock. A description is only needed for a single item if
       there's something unique to add.
+      The items should be have a fixed order, so pattern matching names are
+      discouraged.
 
   clock-names:
     items:
@@ -97,6 +99,8 @@ properties:
       A variable number of interrupts warrants a description of what conditions
       affect the number of interrupts. Otherwise, descriptions on standard
       properties are not necessary.
+      The items should be have a fixed order, so pattern matching names are
+      discouraged.
 
   interrupt-names:
     # minItems must be specified here because the default would be 2
@@ -196,14 +200,24 @@ required:
 #
 # If the conditionals become too unweldy, then it may be better to just split
 # the binding into separate schema documents.
-if:
-  properties:
-    compatible:
-      contains:
-        const: vendor,soc2-ip
-then:
-  required:
-    - foo-supply
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: vendor,soc2-ip
+    then:
+      required:
+        - foo-supply
+  # Altering schema depending on presence of properties is usually done by
+  # dependencies (see above), however some adjustments might require if:
+  - if:
+      required:
+        - vendor,bool-property
+    then:
+      properties:
+        vendor,int-property:
+          enum: [2, 4, 6]
 
 # Ideally, the schema should have this line otherwise any other properties
 # present are allowed. There's a few common properties such as 'status' and
@@ -211,6 +225,9 @@ then:
 #
 # This can't be used in cases where another schema is referenced
 # (i.e. allOf: [{$ref: ...}]).
+# If and only if another schema is referenced and arbitrary children nodes can
+# appear, "unevaluatedProperties: false" could be used.  Typical example is I2C
+# controller where no name pattern matching for childre can be added.
 additionalProperties: false
 
 examples:
-- 
2.17.1

