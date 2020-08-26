Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C77BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE91020786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTM9eSha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHZLVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbgHZLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:16:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B4C061574;
        Wed, 26 Aug 2020 04:16:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so884204pgb.2;
        Wed, 26 Aug 2020 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9BLb5SG/442AGlteVEU+VMTqxtoAM2EGD3L4sUWx4Zo=;
        b=RTM9eShaWBULpfiCRgbWc2dfnQ8mzP3UIe6PD9REcR2jFelRuQgY09d5O441gFQ6VO
         D9oO87xWRZNIVvhOanS8SIn4qAUSIE5hSC0QV9OZr/R1PGgA70tXR1XXT2yxGoDCCVh8
         k9DcqEJCygohr8Tp+SAGy4k6aq/7yODQ+f3HKMYSPE9HNJNCUURn96Zzn/ZEuuJ+HdwN
         lFKP+ic/cFUz/eJIsM3GX3eDZ6Lb2LRk/2cydMrII6CYeh5fuBkansErTfOtBjKTm7lo
         eHN8vdd7HPcLirjZpABpPEhp8zbHXq9ZFgG/ZyN+IW9LrDyM1EGCJXO685nidCgwtov2
         zTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9BLb5SG/442AGlteVEU+VMTqxtoAM2EGD3L4sUWx4Zo=;
        b=m7jtrtcFNJ+vlZcWgIBV8DDc5KY1iKAIWOtfazRQhrf47mCwnMZEmGLpbin1Yl6pwu
         Pf26IQbjssEQs+UMA40pGXDb5dsJR3jQh1UVpNRS0IdwIQlHEx8tZIk5cXuSjUh49A+6
         UJ+O3iyD1Jdw5bd0JKGYWSJcVwLRxJ4aIChuC64dzjo9++Hy0tYLlc7FIQ9H02OD0TAo
         SmFkPtWNSAM9ybxcyALOsXHGpY1+DBlqoXmBN5g9bzZKNLdOy9jLhdOaiCiecc8X732X
         WpvlK+qIec+g99ofUcdH2VYsDBPwLUDU+g00pT4H6pG7oOKU8PP6EWzHKVKTId0inPMZ
         95iA==
X-Gm-Message-State: AOAM531yh22QgnLngV0NjJAy7PlTIcCqkreqLkcbgRWwsakzOF8I7Ap5
        dsSvVdbcaC8HRLDSDpvSLzDYnA7lVXzYEw==
X-Google-Smtp-Source: ABdhPJwxUqjX5J9QraoEj7Vzj2jbbfcOOIZC6fx+JhfutgFaUIROtDcRQOSSk3ooISjmDYHh8woMpA==
X-Received: by 2002:a63:6f02:: with SMTP id k2mr10069642pgc.191.1598440617709;
        Wed, 26 Aug 2020 04:16:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:464:1646:7076:aae7:15f:eca9])
        by smtp.gmail.com with ESMTPSA id g129sm2628872pfb.33.2020.08.26.04.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:16:57 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
Date:   Wed, 26 Aug 2020 19:16:42 +0800
Message-Id: <1598440602-8648-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598440602-8648-1-git-send-email-u0084500@gmail.com>
References: <1598440602-8648-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add a devicetree binding documentation for the MT6360 Type-C driver.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
new file mode 100644
index 00000000..9e8ab0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek MT6360 Type-C Port Switch and Power Delivery controller DT bindings
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Mediatek MT6360 is a multi-functional device. It integrates charger, ADC, flash, RGB indicators,
+  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6360 Type-C Port Switch and Power Delivery controller.
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

