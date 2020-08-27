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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F7E2078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcfeBqhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgH0EvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgH0EvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:51:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E293C0612AC;
        Wed, 26 Aug 2020 21:51:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kx11so1963155pjb.5;
        Wed, 26 Aug 2020 21:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9BLb5SG/442AGlteVEU+VMTqxtoAM2EGD3L4sUWx4Zo=;
        b=hcfeBqhwso3PEQMOSKQnGbznx2Zu5Md8CulOK5yqqgZBqyz5heBSFefG0VlinCv+uA
         ECxYER5w3Br63TbuQhIhtbrr1O/tGldrxjyuyKme9IH5QcMLm9nmKh8cta7n/jEztb6z
         5s4vAVjZ6UhRMEWiPJ4S1oeHpFUmXYPk7WFvohAWEj1ni/htfTmgy/TzXc1lkOl5AfC8
         pjPjedokPZ+xuaNjtzTVF2UjdPSW02Y1NmBy5CpT5UoCSnWjbPmsI9s0M+7+WIeI4dCT
         k1px2IB3468SwM8BwvT18PtU2ve7B3UUXn2e6DX6Kzvv6YhBndreInmZ4uh8/11vcBQL
         n6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9BLb5SG/442AGlteVEU+VMTqxtoAM2EGD3L4sUWx4Zo=;
        b=L26FVwhUNB4V/vRb0FAlgVActor64LQw4JFjBfrCOgikfoK5FIKon7kXdhTI+yNtVN
         ew97Aja5zIJtF7m81nW+Yy2NsyYfgf8fBtQXj7bjmX8a2sG6YNgLElxVIaExsMzFTwVk
         enl3NjyWUcYuecoY9HXu4CWxkgO1Z7r0Uo3dl767f45y1ntNE7ZxtGzOiuujqv20uFLM
         Gv+hcewFmWwkSHzur+jrdhGAPzxOOiGwFyZT2o7SUkcW9Qep3UDj+LUIrWHA8+jTnGlZ
         qurFuXatRcZxXHrsLdGISdMTIOPdkNuE//pZrUdhHWNQ70+qkdLlS2w7SSppnRrVNSUC
         ChBA==
X-Gm-Message-State: AOAM532eNa+pVv7XLt/uxlFlxLgpab6K0LYgKrKtdIU6dc2F6EpNPMiu
        uze5beFbmesyG+kNOaduq4c=
X-Google-Smtp-Source: ABdhPJxxCQt084vIio/21jn+Y9bOhFFOxb57q/VPZKkCWAHnH38E/WjRkUhTdvB+VkRJsk/e6ZwDsw==
X-Received: by 2002:a17:90a:eb09:: with SMTP id j9mr9456782pjz.176.1598503873826;
        Wed, 26 Aug 2020 21:51:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:57b:156e:1129:dc1b:b8d8:6430])
        by smtp.gmail.com with ESMTPSA id q11sm927060pfn.170.2020.08.26.21.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 21:51:13 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
Date:   Thu, 27 Aug 2020 12:50:59 +0800
Message-Id: <1598503859-29620-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598503859-29620-1-git-send-email-u0084500@gmail.com>
References: <1598503859-29620-1-git-send-email-u0084500@gmail.com>
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

