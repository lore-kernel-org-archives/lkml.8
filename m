Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE340C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A075220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FfZY3MR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgENMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:43:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33114 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgENMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:43:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EChGG5097203;
        Thu, 14 May 2020 07:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589460196;
        bh=HlDA7roPZoOfauhzxUkVsNVj1Ph1YT27Vtoau0p6J5I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FfZY3MR8phk6TIfCDXaZbxGQra58C6/erV4EN29DgQN2xq0H95dWxb9aD5o+aHONl
         hQAfCM0uq2OLqkefPDUNlOFDNpibFqC3wWtvtE4vRQZpEDEsakMIWlrkOiRmpOlj/A
         bNV+EnM2xjvkhFJ4ETuuErVipoqrIjKL8XCJ15aA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EChGlk121909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 07:43:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 07:43:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 07:43:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EChFmK030774;
        Thu, 14 May 2020 07:43:15 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] ASoC: tlv320adcx140: Add device tree property for PDM edges
Date:   Thu, 14 May 2020 07:33:37 -0500
Message-ID: <20200514123338.20392-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514123338.20392-1-dmurphy@ti.com>
References: <20200514123338.20392-1-dmurphy@ti.com>
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

v3 - Updated description to be more descriptive and fixed example.

 .../bindings/sound/tlv320adcx140.yaml         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index ab2268c0ee67..daa6cc0e031b 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -63,6 +63,29 @@ properties:
       - $ref: /schemas/types.yaml#/definitions/uint32
       - enum: [0, 1, 2]
 
+  ti,pdm-edge-select:
+    description: |
+       Defines the PDMCLK sampling edge configuration for the PDM inputs.  This
+       array is defined as <PDMIN1 PDMIN2 PDMIN3 PDMIN4>.
+
+       0 - (default) Odd channel is latched on the negative edge and even
+       channel is latched on the the positive edge.
+       1 - Odd channel is latched on the positive edge and even channel is
+       latched on the the negative edge.
+
+       PDMIN1 - PDMCLK latching edge used for channel 1 and 2 data
+       PDMIN2 - PDMCLK latching edge used for channel 3 and 4 data
+       PDMIN3 - PDMCLK latching edge used for channel 5 and 6 data
+       PDMIN4 - PDMCLK latching edge used for channel 7 and 8 data
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
@@ -77,6 +100,7 @@ examples:
         compatible = "ti,tlv320adc5140";
         reg = <0x4c>;
         ti,mic-bias-source = <6>;
+        ti,pdm-edge-select = <0 1 0 1>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
       };
     };
-- 
2.26.2

