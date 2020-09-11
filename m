Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879FCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF6E22204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="TMbNTQfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKIIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:08:11 -0400
Received: from smtp1.axis.com ([195.60.68.17]:44722 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgIKIIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2770; q=dns/txt; s=axis-central1;
  t=1599811684; x=1631347684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cPa4cUMFiotpZ68Fm/qKTiIofFwHyG7dO+acVYumhHg=;
  b=TMbNTQfPV3HcwVwEfOLVVtdj3X4q0Ip7QoKH5fcduBYr4gK+i0irCMEt
   s8vPwTny3dhkCk7iDGdD0yXcgwGkpk+9RSuWDi9OsMySwlPDAaXpcUfKK
   jGcD8XbzeCj0uGfewINj3dTwoSlryDBzwz7lORw3py/bddD/WLiomZf1H
   EZFz3sC2/Z4ou9vr3kDwoToOfHsT0H3RlF3shz8Mm4FRSr26ExbVXB66b
   TzXFO7mzd+LXbs8KfRe8ktVeIAt+MXI7FI5rX2+VCa52juabvfFpt89Km
   EB2Gl8LLEheWL55H9K2lW75HpoW5EZW0TjnxN1ZNVb5+iRIvakM9KUklB
   w==;
IronPort-SDR: 3tkqyX7XKLPM/R6pI8Xcz34ofl09t0Fwhm+XpilNpZqxb+Pa6otPLkk4027QJuX553TRbIioiQ
 z+y5l2YxCN97cn+I1nhuY/7QwdyDkP4UpLAwN/h5hZ5vCefBBq4EYjMDbIVbAAvAF2Klk5Ngra
 /lWUI20C163PB9adsex6cX+505NFBlMuPQTGpoELj5eg7kTw7lhh6jZq4QUXFyR9sLqlQdnQOy
 ctmei6aGyoYN+R6Yf65C4GKTMY7uHk4BxRB+KsPUOX6QjSaApUMesrk9WiG76y8obKquwrvAIX
 n9g=
X-IronPort-AV: E=Sophos;i="5.76,414,1592863200"; 
   d="scan'208";a="12818358"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH v2 1/3] dt-bindings: tlv320adcx140: Add GPIO config and drive config
Date:   Fri, 11 Sep 2020 10:07:51 +0200
Message-ID: <20200911080753.30342-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Add properties for configuring the General Purpose Input Outputs (GPIO).
There are 2 settings for GPIO, configuration and the output drive type.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 .../bindings/sound/tlv320adcx140.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index f578f17f3e04..7b0b4554da59 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -134,6 +134,49 @@ patternProperties:
        4d - Drive weak low and active high
        5d - Drive Hi-Z and active high
 
+  ti,gpio-config:
+    description: |
+       Defines the configuration and output driver for the general purpose
+       input and output pin (GPIO1). Its value is a pair, the first value is for
+       the configuration type and the second value is for the output drive
+       type. The array is defined as <GPIO1_CFG GPIO1_DRV>
+
+       configuration for the GPIO pin can be one of the following:
+       0 - disabled
+       1 - GPIO1 is configured as a general-purpose output (GPO)
+       2 - (default) GPIO1 is configured as a device interrupt output (IRQ)
+       3 - GPIO1 is configured as a secondary ASI output (SDOUT2)
+       4 - GPIO1 is configured as a PDM clock output (PDMCLK)
+       8 - GPIO1 is configured as an input to control when MICBIAS turns on or
+           off (MICBIAS_EN)
+       9 - GPIO1 is configured as a general-purpose input (GPI)
+       10 - GPIO1 is configured as a master clock input (MCLK)
+       11 - GPIO1 is configured as an ASI input for daisy-chain (SDIN)
+       12 - GPIO1 is configured as a PDM data input for channel 1 and channel 2
+            (PDMDIN1)
+       13 - GPIO1 is configured as a PDM data input for channel 3 and channel 4
+            (PDMDIN2)
+       14 - GPIO1 is configured as a PDM data input for channel 5 and channel 6
+            (PDMDIN3)
+       15 - GPIO1 is configured as a PDM data input for channel 7 and channel 8
+            (PDMDIN4)
+
+       output drive type for the GPIO pin can be one of the following:
+       0 - Hi-Z output
+       1 - Drive active low and active high
+       2 - (default) Drive active low and weak high
+       3 - Drive active low and Hi-Z
+       4 - Drive weak low and active high
+       5 - Drive Hi-Z and active high
+
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          maximum: 15
+        default: [2, 2]
+
 required:
   - compatible
   - reg
@@ -150,6 +193,7 @@ examples:
         ti,mic-bias-source = <6>;
         ti,pdm-edge-select = <0 1 0 1>;
         ti,gpi-config = <4 5 6 7>;
+        ti,gpio-config = <10 2>;
         ti,gpo-config-1 = <0 0>;
         ti,gpo-config-2 = <0 0>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-- 
2.20.1

