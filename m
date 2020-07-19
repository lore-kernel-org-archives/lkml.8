Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE1521744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAJ0vaNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGSRmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:42:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1CC0619D2;
        Sun, 19 Jul 2020 10:42:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n5so9219430pgf.7;
        Sun, 19 Jul 2020 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yzbjFfaJs/MFsRpCaMHXJlGCvB9Qsqv8l66YZ1v9PZk=;
        b=WAJ0vaNfQ79aLVy+JrxT4z+mIq1Rb2ACQ77SdmdK4e4fr86H0sthDMM2Nh6iWGpz6V
         6xXG4V0uMbv6Nnax/BainfcaP0MNodZlwnomuVleoKI+zgq4fs8uQPn5f7JSog5z2g6o
         defscOesLL0Fm9bGv0RDxqVZptj4GPaVQn0R+GigVdgqMD5y9QUILFhsHYty2W9yv8I0
         35XInkHGEG9OSf6YssypNeL67ucfCJ+mom6BaO/iNnTPK+5HlR8fI645+8VKFJxAAvNT
         jQT2lrfi5bKNCgJelWgs4bnH9X8JfQOSo0+E4zYCWQzviRxXWyZbK6ajWZx5rxEotl7T
         C8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yzbjFfaJs/MFsRpCaMHXJlGCvB9Qsqv8l66YZ1v9PZk=;
        b=WIaHBuyii+O8MuhBLVeeNp2mpFm8A30hqLd60Yp6n/uq9JwpwUzQDEfeLJn7UNIqVI
         pCT/rQhnSV8XP8PWkuHLXRTb/F682YdallZ4tdZ6jvpjLibIJAO2p6U3743jIag+mOFG
         uFcnG1RFFIjcW6CKerl/F78/M6kGG9vj6ByJUoOZmYfCFGinmAtDV2pGQdYCOjIRK6a4
         N/JehHTr7WFanYjRlmugzHGQSaVJuLo1SpGxKA9P+UPy/W2jocfS/i9TctyaJtUsbPhG
         txrWAWYKNyoBezQ2DTLtjww/nzBH6zDo3fkcEbyVj/q5Y9EA9TX/RKFaDpXJEFzXvaVy
         +PnQ==
X-Gm-Message-State: AOAM530BzWhfYyfiiTP08iU4mIcC7zsN/dfiy2iRN5x6JXjShUKC3ny/
        MD2IBnvsjzh/KXjUYbvyEIM=
X-Google-Smtp-Source: ABdhPJyjfCxfT0e+XoaE1dIzLI+XgLmOT0sqD2+4M7PZRlLgD987tRyjpT6QzmHkM0Y8cGnxulwzdg==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr15856803pgm.253.1595180557306;
        Sun, 19 Jul 2020 10:42:37 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:42:36 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 01/10] dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
Date:   Sun, 19 Jul 2020 23:11:58 +0530
Message-Id: <1595180527-11320-2-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the device tree bindings for the Actions Semi Owl SoCs DMA
Controller over to YAML schemas.

It also adds new compatible string "actions,s700-dma".

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Removed Rob's Reviewed-by tag as his bot found errors
          running 'make dt_binding_check'.
        * Fixed the errore reported by Rob's bot, adjusting the reg
          property in example.
Changes since v4:
        * Added Rob's Reviewed-by tag.
        * Re-order it from 05/10 to 01/10.
Changes since v3:
        * No change.
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
index 000000000000..256d62af2c64
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
+        reg = <0xe0260000 0x1000>;
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

