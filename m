Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D338C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5384A20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbMz8O5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgGBOxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbgGBOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F8C08C5C1;
        Thu,  2 Jul 2020 07:53:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so11402509plo.7;
        Thu, 02 Jul 2020 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NC3+g+Wp7nEZNJbZ9KZMkErAQDFKPvd+kjb0PM4Pigk=;
        b=LbMz8O5HRWKayvR/6n88vDQGNIfEp4nivLSQOv7MoMUq9upBFoj5AeSOyk4vbN/E7d
         x4bH9KVaI5HfIDDLTBX1wfwsc+AKrtuAnWq1sECNFst+en1gC7itqrUs0syfkhr4NatQ
         IFtDHD/PnMeXkpgPWBEImhslojAuaZEAOzQzp02umhCYpl3qsrUyIBusEj9Gk65xZXBZ
         9zszspQMIsBYu2tCkCbaqxdL09iwCPENsN9n+mqE0Gnwv4Kho9CknaH1B6ZX+54ZQlO0
         ZfzfbSYImL3HPhk5w8URC4gVC9E6wcQFMpSaFAXoJ0doK+ryCX62efz+PqTzJ9mi+SFS
         /QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NC3+g+Wp7nEZNJbZ9KZMkErAQDFKPvd+kjb0PM4Pigk=;
        b=iT3I3DXlfTklCI7I21LSF/t/HwkLumb8udoXWaUwyeK8oUrjQfuMfBZe86n+Pb2mj9
         icfaRcB/y3F1Hni9JI5Tx+QVQxjr0MnKV6aWFcZIPUozqcKctEUoNHUBygS7zt0+7uFw
         c6y34VpPiTag/xfU4bpthejQkVv62EsBXqwTx31+rbVfLH0AnkYhAQvlY/DOSXW20K+/
         VH9rH2ACZngxf+og+elqqGocooxu5t2g6kUGhofYOTVS325eho8lnDI5IL+QBlT9Yu+z
         E+7fs0GKKd7qmh8rKDOjuP91Af0krLrL6RrRSUQ2adAMiObARNIyd1yGQ5cIi5b3ZxG8
         5U7g==
X-Gm-Message-State: AOAM531l0RqYgR5Ircr7CuNtuA8i5NuxSfBobmoktu8X7hlvpAH0oG9x
        QmDkJ+lVmQOgS+f8+t9fV1Q=
X-Google-Smtp-Source: ABdhPJw7vYKccSm3RBg56O/4LcCsCPh5/mP5yuIfAvArgjmj/BZrhjsAOWXVstMhp4jYpr5IVu6/hQ==
X-Received: by 2002:a17:902:6ac1:: with SMTP id i1mr27920165plt.147.1593701603800;
        Thu, 02 Jul 2020 07:53:23 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:23 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 01/10] dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
Date:   Thu,  2 Jul 2020 20:22:47 +0530
Message-Id: <1593701576-28580-2-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the device tree bindings for the Actions Semi Owl SoCs DMA
Controller over to YAML schemas.

It also adds new compatible string "actions,s700-dma".

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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

