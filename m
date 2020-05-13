Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096E52065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h05ZFNyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbgEMUQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:16:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43790 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbgEMUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:16:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DKFQht122613;
        Wed, 13 May 2020 15:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589400926;
        bh=H30QMIFzoF2nkWUEQ+aNsHNe38YJ4A6p2K+vwiRIvOs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h05ZFNyJrByhxULBd8H1XQzC7WSLa9PNGvvJ4TBrhFwqeqsF+t2Kcu7s7KgedIh1Q
         eOktVWAdmBXGq7hlGyJBdzfe1KDYtEOUEibBSuyeOvmxbE8r2w/zlBr47XJFdAd72g
         RcYihNk/n6fRbax+mPduA2L4xurtEqlXQlu9RXBs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DKFQVp090834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 15:15:26 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 15:15:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 15:15:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DKFQsl017974;
        Wed, 13 May 2020 15:15:26 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] ASoC: tlv320adcx140: Add device tree property for PDM edges
Date:   Wed, 13 May 2020 15:05:48 -0500
Message-ID: <20200513200549.12213-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513200549.12213-1-dmurphy@ti.com>
References: <20200513200549.12213-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree property to configure the PDM sampling edge for each
digital microphone.

CC: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tlv320adcx140.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index ab2268c0ee67..55668c7d261d 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -63,6 +63,19 @@ properties:
       - $ref: /schemas/types.yaml#/definitions/uint32
       - enum: [0, 1, 2]
 
+  ti,pdm-edge-select:
+    description: |
+       Defines the sampling edge configuration for the PDM inputs.  This is an
+       array defined as <PDMIN1 PDMIN2 PDMIN3 PDMIN4>. 0 (default) is negative
+       sampling edge and 1 is positive sampling edge.
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
@@ -77,6 +90,7 @@ examples:
         compatible = "ti,tlv320adc5140";
         reg = <0x4c>;
         ti,mic-bias-source = <6>;
+        ti,pdm-edge-select = < 0 1 0 1>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
       };
     };
-- 
2.26.2

