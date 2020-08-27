Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CEBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8502080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGJQu3Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgH0PVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgH0LcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:32:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992FCC0611E2;
        Thu, 27 Aug 2020 04:19:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g1so3111645pgm.9;
        Thu, 27 Aug 2020 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0zpPcYJ1vUHmpV3rQXkBSiNDDj5ItcpLqLQV/ENULo=;
        b=AGJQu3TbjrCnuhhqkqS7j1YaiFtASNUFy2jKDkkrMPsbG74tH+k2AvHvE3Wq3SFUFK
         il9cHaz+IFKfK0oQnZqC7GVn9uztwPz7XrF09MilOdo1c4uyLjnkPy7qHUZ328ce7Qim
         4+rSz1G2nwDriX1NppIqikjH7CHPGsbDohBmB1EO+6vyFcyKtRI5zxP26bovtvOdIqPX
         vIbFygjdpZzEU/AUet9U27Ekk3eAOZKLaGdUCGl5qGiHktb/Tv1pflAza1wFPATgaMxC
         +HSEfAU4sPHHQqf4uqxRE8zCDQYE7VMtWATO6g7O3Mi2I6D18seH689L3mOrHGyERk9l
         t47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0zpPcYJ1vUHmpV3rQXkBSiNDDj5ItcpLqLQV/ENULo=;
        b=bodw/jAX5fOFl1qBgICUUckdB0Kp4OBNaXNMipWNvfOSYvK8jAmVLdKQ+0sz8UlSku
         noX4R+giCJXIVVRwoCjnmnXumA03WWB1TR+MkcmfoKqsCp12OCrOOgN0T2ko/oBdcfbA
         0OPv4AKSmt1W+msmEnM1LpQQkdgnnxvryoUGKTpFi4vzfbYullzfu3maPXSfWreZTs/z
         QFOXFN9a36NJxllRIXzkBvy5O5gmsVtgFloEp34R71XccGr0aBojRW7dJST2G+6SDm4k
         BPBDIPDH56+M1fa/rX7HsKAv4u6DI1sZ0nLqCuoguR6o1bhcGTRiVOJbxt37nixLwI9Q
         QuMA==
X-Gm-Message-State: AOAM531OXBxcte8ph1zr1Vewy/fKTVmnKdGiK1tQX2DKBjy/FtFiU/r/
        EffgSOqfJTyl8BI7yKtbAPa2rOG3gjmcHFid
X-Google-Smtp-Source: ABdhPJx9BG4IH8NlwPLL49IRWs8UoqHlTHOcA3OYqMJkPAu5ZaZsoK54zswbbH4CKT3oBYuVYRl8QQ==
X-Received: by 2002:a63:2d83:: with SMTP id t125mr13734429pgt.441.1598527165079;
        Thu, 27 Aug 2020 04:19:25 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:c678:1129:dc1b:b8d8:6430])
        by smtp.gmail.com with ESMTPSA id h64sm2411609pfe.201.2020.08.27.04.19.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 04:19:24 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
Date:   Thu, 27 Aug 2020 19:18:57 +0800
Message-Id: <1598527137-6915-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add a devicetree binding documentation for the MT6360 Type-C driver.

usb typec: mt6360: Rename DT binding doument from mt6360 to mt636x

Change binding document file name from mt6360 to mt636xfor the
future compatible.
Also change internal description from mt6360 to mt636x.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/usb/mediatek,mt636x-tcpc.yaml         | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt636x-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt636x-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt636x-tcpc.yaml
new file mode 100644
index 00000000..e6d2b3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt636x-tcpc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt636x-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek MT636x Type-C Port Switch and Power Delivery controller DT bindings
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Mediatek MT636x is a multi-functional device. It integrates charger, ADC, flash, RGB indicators,
+  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT636x Type-C Port Switch and Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6360-tcpc
+
+  interrupts-extended:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: PD_IRQB
+
+patternProperties:
+  "connector":
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts-extended
+  - interrupt-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mt6360@34 {
+            compatible = "mediatek,mt6360";
+            reg = <0x34>;
+
+            tcpc {
+                compatible = "mediatek,mt6360-tcpc";
+                interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+                interrupt-names = "PD_IRQB";
+
+                connector {
+                        compatible = "usb-c-connector";
+                        label = "USB-C";
+                        data-role = "dual";
+                        power-role = "dual";
+                        try-power-role = "sink";
+                        source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+                        sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+                        op-sink-microwatt = <10000000>;
+                };
+            };
+        };
+    };
+...
-- 
2.7.4

