Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17507C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA2520715
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzHuzbBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgDQWNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgDQWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:13:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E37C061A0C;
        Fri, 17 Apr 2020 15:13:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so4214580qkg.1;
        Fri, 17 Apr 2020 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iZwNKOyj4NwNMXhZfqTeRorCY/0+cxmYDzA7LdOH228=;
        b=CzHuzbBrOPSwENlS63xf247SLJsqy+HezhesqQH2aCg8/sGnDMinR5qoBT8TPTqEY7
         tlvgZPKQobRdwVWfgdgL+sTX0oiwb+4ISuYs6BrraipRJ0CsXL9RgFstY5ojbXd451w9
         ywLkV4aJE1Y+5O5J1218vcROKvmij/ZmCdRi6HaTubypeNhWrZDPLPfWsj0hAJo6GNBc
         BRDn4J7n736qVzg6dVZCQyC2ohRayKXEsj/FJq/juafyC62wgZnnQT47aggkWu/y7X2t
         crZVIjiGAlKClP3Ce2+IwKGSPLIUHYKrgWadyt7llL2HaFLR56hgKrtIzeX/AYptvEj4
         S4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iZwNKOyj4NwNMXhZfqTeRorCY/0+cxmYDzA7LdOH228=;
        b=IqzJ4adHHfaAiFxXEnFggBxGYdf5kowMVnc4EHZ+m/fv1cFEOtcCcT8dVRIQTkIkJN
         GxxVypCiOxw0gdEvrd15vJA+4oOMwM6mXvuWOQrJ/pvbp1CbHHiYQ4pWqsECC1X4DczZ
         qY9XuHDZVBF2ULkk+YlwSjk7svGuNkRgrd0/d6dhZJ7MaCksSnfM8rY06HpeuD1IyI9q
         FBoSdhCtuv2InOEnp37jiKI2JpDSxyh5Wx7u6Oprcnib3tdxICIDcbW//00qEgTd6w5R
         VbJG0s4V/JkVvSl36++WC7ibKjPoNfaiiZuKrNZqatDDODW4viTvmT5TMznvMCr86Kgx
         Nnqg==
X-Gm-Message-State: AGi0PuYKGJwP+EX4Iw4fCdo/2JWNBqzEvgdbV60kU9yMDZ6Lsn1iBsPE
        oa8ifyfMV2o9XinnQtCXd+w=
X-Google-Smtp-Source: APiQypKUWeVW/aqVwxqOtgWr0FHKUWN77nS8urp+P97zU8zc5k1GGUly5gXQ9YyRvDYFQjGofKgr9A==
X-Received: by 2002:a05:620a:6b0:: with SMTP id i16mr5206640qkh.385.1587161625578;
        Fri, 17 Apr 2020 15:13:45 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id u65sm17780126qkh.100.2020.04.17.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 15:13:45 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
Date:   Fri, 17 Apr 2020 18:13:40 -0400
Message-Id: <20200417221341.31428-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for the Microsemi ZL38060 Connected
Home Audio Processor.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: v5.7-rc1

v1->v2:

- removed all properties related to amp-en-gpios
- removed 'mscc,load-firmware' property

For further details, see v1->v2 notes in 2nd patch.

 .../devicetree/bindings/sound/zl38060.yaml    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zl38060.yaml

diff --git a/Documentation/devicetree/bindings/sound/zl38060.yaml b/Documentation/devicetree/bindings/sound/zl38060.yaml
new file mode 100644
index 000000000000..338e2a13c775
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zl38060.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/zl38060.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZL38060 Connected Home Audio Processor from Microsemi.
+
+description: |
+  The ZL38060 is a "Connected Home Audio Processor" from Microsemi,
+  which consists of a Digital Signal Processor (DSP), several Digital
+  Audio Interfaces (DAIs), analog outputs, and a block of 14 GPIOs.
+
+maintainers:
+  - Jaroslav Kysela <perex@perex.cz>
+  - Takashi Iwai <tiwai@suse.com>
+
+properties:
+  compatible:
+    const: mscc,zl38060
+
+  reg:
+    description:
+      SPI device address.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 24000000
+
+  reset-gpios:
+    description:
+      A GPIO line handling reset of the chip. As the line is active low,
+      it should be marked GPIO_ACTIVE_LOW (see ../gpio/gpio.txt)
+    maxItems: 1
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#gpio-cells'
+  - gpio-controller
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec: zl38060@0 {
+            gpio-controller;
+            #gpio-cells = <2>;
+            #sound-dai-cells = <0>;
+            compatible = "mscc,zl38060";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+            reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.17.1

