Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC49BC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F0220725
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+0qSLNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403799AbgDPAOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgDPAOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:14:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBFFC061A0C;
        Wed, 15 Apr 2020 17:14:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 71so15045046qtc.12;
        Wed, 15 Apr 2020 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pIUSEdVkYnzUbRZnkBabNoQ8PA+FbWN+5gp6Ca6tF8g=;
        b=q+0qSLNia0iJHTK4tDzgVoXW/iaWNN/Cj5Dtk9LxON5XaHhjhR0wBvMSEX8kulQxy1
         g9e4WyorxLfF20kNjj0p5VYgU1M6VQbuDotniG/5fxe//maq5lQD7VKfViKTr6Lnqo4c
         bLzJAeSxYtW7gl9JbrGOxijSdXhlBeS8S2ycSOvgRdsgk58zx2AulNWFxBCVfojmSoxb
         c6PMvbfxloUNOoScmGG6RiOXrtHm1u856NsXHkxg9yX+2P8K5og08Dv1T93rESAZaTN5
         safQT4MchBYR+1bSCUivV4x12zWtMWJTQbdK6Vj2oLj7YHrY3rLc93lNr7UieHFo22el
         rRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pIUSEdVkYnzUbRZnkBabNoQ8PA+FbWN+5gp6Ca6tF8g=;
        b=RqSRCBgOm9WKj85VUFIjLS09Wi/2NBI5i4Zovm9WOdohXSlm1K5KtdpROh/3n6JPKa
         cbibaP74L0Sc1WgMofxneaV9zWUuoGpXnzxB3h2nltiroT3Oxgkw5KHA+27IlminqJF/
         bf8OampSxBiuGm4kFNIo3TMbaJl8X47Rus3tZ6sBAgf/ZKqdqG1mCdLeuelNnalJIQAR
         oPc8ycmF4yT4MjCDG8L7qliMdj2NQEOLocP+ZJbb2/v29WMpoLArkP7woP/oCFtjVNXy
         lYixevwR6CiBUYICZRmsQ1BV8uV97P/Rsp/AsB2BrjCL1pWWswy6HrefS/VPzyqHgIte
         dflw==
X-Gm-Message-State: AGi0PuaxcYwJtH6Dxjn9LvmaXt+DMA7Fn0JDeN7TP12k9Tfl6XTvhOAt
        yr05zGFu3xOSwyE3j5giJej5c2ET
X-Google-Smtp-Source: APiQypJXSUQZOgihlU2mIcclWqeseQ99JyYBajbA5ktpmn2uSKAUUFAzTMMX57omUZ7FlaxHo3u+EQ==
X-Received: by 2002:ac8:2783:: with SMTP id w3mr23654972qtw.265.1586996059405;
        Wed, 15 Apr 2020 17:14:19 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id v27sm5199071qtb.35.2020.04.15.17.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:14:18 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
Date:   Wed, 15 Apr 2020 20:14:13 -0400
Message-Id: <20200416001414.25746-1-TheSven73@gmail.com>
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

 .../devicetree/bindings/sound/zl38060.yaml    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zl38060.yaml

diff --git a/Documentation/devicetree/bindings/sound/zl38060.yaml b/Documentation/devicetree/bindings/sound/zl38060.yaml
new file mode 100644
index 000000000000..8e1976bee76b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zl38060.yaml
@@ -0,0 +1,90 @@
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
+  mscc,load-firmware:
+    description:
+      If present, the driver will attempt to load firmware into the chip via
+      the SPI interface.
+    type: boolean
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+  '#sound-dai-cells':
+    const: 0
+
+  amp-en-gpios:
+    description:
+      An optional GPIO line which is active when the codec is playing back
+      audio. Can be used to control an external amplifier.
+    maxItems: 1
+
+  mscc,amp-startup-delay-ms:
+    description:
+      An optional delay between amp-en-gpio becoming active, and the start
+      of audio playback. In milliseconds.
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+            amp-en-gpios = <&codec 3 GPIO_ACTIVE_HIGH>;
+            mscc,amp-startup-delay-ms = <12>;
+            mscc,load-firmware;
+        };
+    };
-- 
2.17.1

