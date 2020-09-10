Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E26C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6CC20809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vRYROEqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgIJHzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:55:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55074 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgIJHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:54:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08A7scYT036046;
        Thu, 10 Sep 2020 02:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599724478;
        bh=RBWE7U0tlwFef9YzggYph/v9AwzgqEVQs2QRRG5UVLo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vRYROEquBYJZJnAP1oqqT6tAelB4vnEw/DMqRmsk64/sWF4pVCMVrdkHmjA+0KfA8
         xNAofxLNWYBhGFSJGzY2hF4Y63YgTvACyl+1b8OfTADlN3tRRPYRYzdGcYHwbWwAAC
         HWBqhFnR7rjhCriWBbaw14l01FvscGiBPuKJsDnM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08A7scLr110132;
        Thu, 10 Sep 2020 02:54:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 02:54:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 02:54:37 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08A7sXCT123142;
        Thu, 10 Sep 2020 02:54:36 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: ti,j721e-cpb-audio: Document support for j7200-cpb
Date:   Thu, 10 Sep 2020 10:54:32 +0300
Message-ID: <20200910075433.26718-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910075433.26718-1-peter.ujfalusi@ti.com>
References: <20200910075433.26718-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

j721e or j7200 SOM can be attached to the same Common Processor Board (CPB)

With the j7200 SOM only the 48KHz family parent clock is available and
McASP0 is used for the audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/ti,j721e-cpb-audio.yaml    | 92 ++++++++++++++-----
 1 file changed, 70 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
index d52cfbeb2d07..805da4d6a88e 100644
--- a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
@@ -18,18 +18,25 @@ description: |
   PLL15 (for 44.1KHz). The same PLLs are used for McASP10's AUXCLK clock via
   different HSDIVIDER.
 
-  Clocking setup for 48KHz family:
-  PLL4 ---> PLL4_HSDIV0 ---> MCASP10_AUXCLK ---> McASP10.auxclk
-        |-> PLL4_HSDIV2 ---> AUDIO_REFCLK2  ---> pcm3168a.SCKI
+  Clocking setup for j721e:
+    48KHz family:
+    PLL4 ---> PLL4_HSDIV0 ---> MCASP10_AUXCLK ---> McASP10.auxclk
+          |-> PLL4_HSDIV2 ---> AUDIO_REFCLK2  ---> pcm3168a.SCKI
 
-  Clocking setup for 44.1KHz family:
-  PLL15 ---> PLL15_HSDIV0 ---> MCASP10_AUXCLK ---> McASP10.auxclk
-         |-> PLL15_HSDIV2 ---> AUDIO_REFCLK2  ---> pcm3168a.SCKI
+    44.1KHz family:
+    PLL15 ---> PLL15_HSDIV0 ---> MCASP10_AUXCLK ---> McASP10.auxclk
+           |-> PLL15_HSDIV2 ---> AUDIO_REFCLK2  ---> pcm3168a.SCKI
+
+  Clocking setup for j7200:
+    48KHz family:
+    PLL4 ---> PLL4_HSDIV0 ---> MCASP0_AUXCLK ---> McASP0.auxclk
+          |-> PLL4_HSDIV2 ---> AUDIO_REFCLK2  ---> pcm3168a.SCKI
 
 properties:
   compatible:
-    items:
-      - const: ti,j721e-cpb-audio
+    enum:
+      - ti,j721e-cpb-audio
+      - ti,j7200-cpb-audio
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
@@ -44,22 +51,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
 
   clocks:
-    items:
-      - description: AUXCLK clock for McASP used by CPB audio
-      - description: Parent for CPB_McASP auxclk (for 48KHz)
-      - description: Parent for CPB_McASP auxclk (for 44.1KHz)
-      - description: SCKI clock for the pcm3168a codec on CPB
-      - description: Parent for CPB_SCKI clock (for 48KHz)
-      - description: Parent for CPB_SCKI clock (for 44.1KHz)
+    minItems: 4
+    maxItems: 6
 
   clock-names:
-    items:
-      - const: cpb-mcasp-auxclk
-      - const: cpb-mcasp-auxclk-48000
-      - const: cpb-mcasp-auxclk-44100
-      - const: cpb-codec-scki
-      - const: cpb-codec-scki-48000
-      - const: cpb-codec-scki-44100
+    minItems: 4
+    maxItems: 6
 
 required:
   - compatible
@@ -71,6 +68,57 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,j721e-cpb-audio
+
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          items:
+            - description: AUXCLK clock for McASP used by CPB audio
+            - description: Parent for CPB_McASP auxclk (for 48KHz)
+            - description: Parent for CPB_McASP auxclk (for 44.1KHz)
+            - description: SCKI clock for the pcm3168a codec on CPB
+            - description: Parent for CPB_SCKI clock (for 48KHz)
+            - description: Parent for CPB_SCKI clock (for 44.1KHz)
+
+        clock-names:
+          items:
+            - const: cpb-mcasp-auxclk
+            - const: cpb-mcasp-auxclk-48000
+            - const: cpb-mcasp-auxclk-44100
+            - const: cpb-codec-scki
+            - const: cpb-codec-scki-48000
+            - const: cpb-codec-scki-44100
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,j7200-cpb-audio
+
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+          items:
+            - description: AUXCLK clock for McASP used by CPB audio
+            - description: Parent for CPB_McASP auxclk (for 48KHz)
+            - description: SCKI clock for the pcm3168a codec on CPB
+            - description: Parent for CPB_SCKI clock (for 48KHz)
+
+        clock-names:
+          items:
+            - const: cpb-mcasp-auxclk
+            - const: cpb-mcasp-auxclk-48000
+            - const: cpb-codec-scki
+            - const: cpb-codec-scki-48000
+
 examples:
   - |+
     sound {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

