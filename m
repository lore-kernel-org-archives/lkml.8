Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEEFC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6955E2078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjjYCWWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgH0D0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgH0D0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:26:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632F1C0612A3;
        Wed, 26 Aug 2020 20:26:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so2340809pgb.4;
        Wed, 26 Aug 2020 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9BLb5SG/442AGlteVEU+VMTqxtoAM2EGD3L4sUWx4Zo=;
        b=CjjYCWWooFK0EHgHSecto1ocZEzgllCZ6bs5diPkpf5KyxPD/2P8ma/JoTJrC/I9kg
         IrZ8+T8EjNNw5L4HIuw8fdnnF7fHtKv7eleB9/ryEWChUMheH7av2zhsM4pVpbOvUzB9
         bndcr9i7J6qk72NPvxT5Pj0VuVCc6JwM47s8q06EI5Xl+EMY7qG4QjzCQbDl6CJYyAFN
         hCueWm2YbBNWGs19NIorW/WjzSeDn44oax4oZ1gBtppkmpCNYSnseFKrirnw7Nu5EnOO
         WRvdQZP5BAg9jjMrW+LZh8am0Qh/PFgLe+Ba3L50V+L2q5iIkRCJyatZPqi3T5mi5w1D
         axpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9BLb5SG/442AGlteVEU+VMTqxtoAM2EGD3L4sUWx4Zo=;
        b=dnNDT9PamUMoLz2fi3svoAK+vnN+EYpHMygZQ0Vc7feOJx0K1VqFlGQAKo5ApDKdaV
         9pM7lkU6bvRxYWgZH+RyvaSLNGfRpYV/Gg0irkUEia58OHHRMnIyeDXzuIkwDNtC1bQJ
         R9n9DdpaRTXQxqAsKxw6t48b/oNXMB9tIwNOuDtS5VcKy6tLS7XQS6coUUr9s6Lf93Z2
         xPGCv9XQZW751niZcKGcfr4pXRti4A+BbdyRGJopPiCo9XskRnSbE0PS7qXf2wTKCb7r
         KDL7yRVnT7XBGpcx8gcU781i9SDr4gwMt14cuxYj+eXchDqow9s8VwhI9u5wD7heaTDU
         KvEg==
X-Gm-Message-State: AOAM532fu1tEYBAjBkaoIpNlQgukdC/yTkMU9Xcu0n5zGTYiVjxi+7b2
        4wXPEinDDPVUbYqLf/BTAG0=
X-Google-Smtp-Source: ABdhPJxlJIglwtNYpMjmJH4S3OB5DwjsuyaIuykvQ+ZOQ/mqrYP2KbU2xeXAzeBV0qrWumABBG0xHw==
X-Received: by 2002:a63:4955:: with SMTP id y21mr12686551pgk.180.1598498764661;
        Wed, 26 Aug 2020 20:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:57b:156e:1129:dc1b:b8d8:6430])
        by smtp.gmail.com with ESMTPSA id 70sm676982pfu.107.2020.08.26.20.25.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 20:26:03 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
Date:   Thu, 27 Aug 2020 11:25:31 +0800
Message-Id: <1598498732-25194-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598498732-25194-1-git-send-email-u0084500@gmail.com>
References: <1598498732-25194-1-git-send-email-u0084500@gmail.com>
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

