Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C147CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E43520835
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clmum6eI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFBRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgFBRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:37:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3EC05BD1E;
        Tue,  2 Jun 2020 10:37:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g12so1619301pll.10;
        Tue, 02 Jun 2020 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+2KNhccpvYloQu0PsdQGEpNQg5/dPaiop5EurBVv1E=;
        b=Clmum6eIR6XcmO2XMZ0pyzIVvBytBGDCsz1BRX7EFnilH0qLu34+Wxp236+r/oOMpn
         r7eJHXb+0zBBklmFhNuN8SCRb0k/3UdC0Ke6ofK4UtwxPxRa6U15rjVwbbLv0285Z/nx
         /6cXqpEkaPTFVMcECnQBDv6BqcYExE4z4ujkJC0lwehm2luaEKfjNbEGSI39Zo3GUFk1
         IH9HN2nEjgY7uW+QSBVOQASWP/rDqQO2ZZ0j2b+8ZeNcKrZtfAzRLrzK576sfRnnJ98/
         MRqF9Sh8Kfj1YirYq8LoU4Amgdeh8PPRqE4Ikoq5WBNWM3+pmWbak4apeSHPB3fACVqG
         Da9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+2KNhccpvYloQu0PsdQGEpNQg5/dPaiop5EurBVv1E=;
        b=msRwLRA86OEnVJYrStGcGtVCXDoQCiTPEs6eQ43cicEsN6cMV0pDPysN2y9ElK8Knb
         fvjsDduXROahgUr7/RHKMtCFCFURdlM+cQpmKODXr0cDmJAUrdWYsEiTi7NVRhCK4QkC
         YNIUAyoeYr1orgpnaOgiVWkc5sgSV/DGBMXjDgKHrMeTKyCzKM29fpZZAgvqG3l6xwGM
         NWHiCn4kljEPIIEV4s8z/oGsnTs0eXzmeQ6JmyK7dR6b2UbCe9XTe8nykT0to1ZAGxIy
         CS7G1pI0V4ceRW21yR9W7nX0AlKCN5ZouPBVnku0h0zWlSjRFWbiI7LmtGOCJ+d99Op1
         ZChQ==
X-Gm-Message-State: AOAM531mmfgsPsfoxT9pXec8kT7jZWo/DSa78UQrhIJmb4lhUdOg3XMf
        8k+i1lvXNvk1Tr5tcmEVqoI=
X-Google-Smtp-Source: ABdhPJzZolzcCOfoXwrX67EAdfHxoHcGcuiRuqWt+GtbjqmjiIiL53Ag7XirWPXStW/CtkAuv0PTeA==
X-Received: by 2002:a17:90b:28d:: with SMTP id az13mr304999pjb.67.1591119464856;
        Tue, 02 Jun 2020 10:37:44 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.37.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:37:44 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 05/10] dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
Date:   Tue,  2 Jun 2020 23:03:07 +0530
Message-Id: <1591119192-18538-6-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the device tree bindings for the Actions Semi Owl SoCs DMA
Controller over to YAML schemas.

It also adds new compatible string "actions,s700-dma".

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v2:
	* Addressed Rob's comments:
           - removed unnecessary description. 
	   - added unevaluatedProperties
	   - added relevant information about
             dma-channels and dma-request
	* Added power-domain property.   	
Change since v1:
        * Updated the description field to reflect
          only the necessary information.
        * replaced the maxItems field with description for each
          controller attribute(except interrupts).
        * Replaced the clock macro with number to keep the example
          as independent as possible.

 New patch, was not there in RFC.
---
 Documentation/devicetree/bindings/dma/owl-dma.txt  | 47 -------------
 Documentation/devicetree/bindings/dma/owl-dma.yaml | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/owl-dma.txt b/Documentation/devicetree/bindings/dma/owl-dma.txt
deleted file mode 100644
index 03e9bb12b75f..000000000000
--- a/Documentation/devicetree/bindings/dma/owl-dma.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Actions Semi Owl SoCs DMA controller
-
-This binding follows the generic DMA bindings defined in dma.txt.
-
-Required properties:
-- compatible: Should be "actions,s900-dma".
-- reg: Should contain DMA registers location and length.
-- interrupts: Should contain 4 interrupts shared by all channel.
-- #dma-cells: Must be <1>. Used to represent the number of integer
-              cells in the dmas property of client device.
-- dma-channels: Physical channels supported.
-- dma-requests: Number of DMA request signals supported by the controller.
-                Refer to Documentation/devicetree/bindings/dma/dma.txt
-- clocks: Phandle and Specifier of the clock feeding the DMA controller.
-
-Example:
-
-Controller:
-                dma: dma-controller@e0260000 {
-                        compatible = "actions,s900-dma";
-                        reg = <0x0 0xe0260000 0x0 0x1000>;
-                        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-                                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
-                                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
-                                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-                        #dma-cells = <1>;
-                        dma-channels = <12>;
-                        dma-requests = <46>;
-                        clocks = <&clock CLK_DMAC>;
-                };
-
-Client:
-
-DMA clients connected to the Actions Semi Owl SoCs DMA controller must
-use the format described in the dma.txt file, using a two-cell specifier
-for each channel.
-
-The two cells in order are:
-1. A phandle pointing to the DMA controller.
-2. The channel id.
-
-uart5: serial@e012a000 {
-        ...
-        dma-names = "tx", "rx";
-        dmas = <&dma 26>, <&dma 27>;
-        ...
-};
diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml b/Documentation/devicetree/bindings/dma/owl-dma.yaml
new file mode 100644
index 000000000000..5577cd910781
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/owl-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoCs DMA controller
+
+description: |
+  The OWL DMA is a general-purpose direct memory access controller capable of
+  supporting 10 and 12 independent DMA channels for S700 and S900 SoCs
+  respectively.
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - actions,s900-dma
+      - actions,s700-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      controller supports 4 interrupts, which are freely assignable to the
+      DMA channels.
+    maxItems: 4
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    maximum: 12
+
+  dma-requests:
+    maximum: 46
+
+  clocks:
+    maxItems: 1
+    description:
+      Phandle and Specifier of the clock feeding the DMA controller.
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - dma-channels
+  - dma-requests
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    dma: dma-controller@e0260000 {
+        compatible = "actions,s900-dma";
+        reg = <0x0 0xe0260000 0x0 0x1000>;
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+        dma-channels = <12>;
+        dma-requests = <46>;
+        clocks = <&clock 22>;
+    };
+
+...
-- 
2.7.4

