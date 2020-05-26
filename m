Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE82C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBE2208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AlZikyLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbgEZUJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:09:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42874 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390815AbgEZUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:09:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04QK9I4E110594;
        Tue, 26 May 2020 15:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590523758;
        bh=a3Bn7e1phIBeu9GwEZi9rAuG8EpD69JqfaOzcTdsyh0=;
        h=From:To:CC:Subject:Date;
        b=AlZikyLtf+4jLs+qkoxYVYwpjE8XyEx0boIFPzAPeUiyUJiaxthsYumkRFRi1kky8
         ptn6MIqERIUjs2P1z41byNUKjVw1Q3ayqAsG8mWqybMzKdbzfyL9d/XZ9G6zq7l1Ju
         rAK3+4OhMIVw4t/Ltqkbw7DJ4FUc80D1ysMGejGE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04QK9IRm086475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 15:09:18 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 15:09:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 15:09:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QK9IAC092862;
        Tue, 26 May 2020 15:09:18 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: sound: tlv320adcx140: Add GPI config property
Date:   Tue, 26 May 2020 15:09:16 -0500
Message-ID: <20200526200917.10385-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an array property that configures the General Purpose Input (GPI)
register.  The device has 4 GPI pins and each pin can be configured in 1
of 7 different ways.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/sound/tlv320adcx140.yaml         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index daa6cc0e031b..e8a69b1c7ca9 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -86,6 +86,32 @@ properties:
           maximum: 1
         default: [0, 0, 0, 0]
 
+  ti,gpi-config:
+    description: |
+       Defines the configuration for the general purpose input pins (GPI).
+       The array is defined as <GPI1 GPI2 GPI3 GPI4>.
+
+       0 - (default) disabled
+       1 - GPIX is configured as a general-purpose input (GPI)
+       2 - GPIX is configured as a master clock input (MCLK)
+       3 - GPIX is configured as an ASI input for daisy-chain (SDIN)
+       4 - GPIX is configured as a PDM data input for channel 1 and channel
+            (PDMDIN1)
+       5 - GPIX is configured as a PDM data input for channel 3 and channel
+            (PDMDIN2)
+       6 - GPIX is configured as a PDM data input for channel 5 and channel
+            (PDMDIN3)
+       7 - GPIX is configured as a PDM data input for channel 7 and channel
+            (PDMDIN4)
+
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 1
+        maxItems: 4
+        items:
+          maximum: 1
+        default: [0, 0, 0, 0]
+
 required:
   - compatible
   - reg
@@ -101,6 +127,7 @@ examples:
         reg = <0x4c>;
         ti,mic-bias-source = <6>;
         ti,pdm-edge-select = <0 1 0 1>;
+        ti,gpi-config = <4 5 6 7>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
       };
     };
-- 
2.26.2

