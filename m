Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE92C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3442075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2vs88Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgESSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESSWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:22:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D187C08C5C0;
        Tue, 19 May 2020 11:22:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu7so54433pjb.0;
        Tue, 19 May 2020 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62O+Kjf9ez3Kf4xkqOzU5F7vZ1myoqJtyp6hoNlnKyM=;
        b=G2vs88OzB+u+wmKqkgbsYbaeZPCEA5cjoEMGbppNuohGbpQ88FZ726G351bjaeKP07
         EvavyAetdJoh9rQwUkwzHS8rJfye46ACvYiSWMV19FnnYcXM3CcL7dqL7KfiKEqqwLhc
         hkDLPPW/SfqsAFP+SvP8evF1nJoPz2g+NsIt5Orkt8gYkeoB1s21rrkj2Z1kw+l1gqk5
         xJunjfQUdsw741jy8PyW/RA6yV3K/aVlN7WNnFVB80mtKBMQhONIXc3N7bfGjirggG+e
         qAXj/nzEKK9mU8two5iK9NGrMaYUz7RaCHruKHk4Hf2R/yPAkDJ/UdBOuwAawBzsadVh
         DTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62O+Kjf9ez3Kf4xkqOzU5F7vZ1myoqJtyp6hoNlnKyM=;
        b=MXsfMfAnmVKLanu4m1tPfbmb0g83v2Y5Ae/hj2xr4WRwMZjojZN8F42/t/z+14WLji
         2INYLswaWCq/GlxQ0vteYoe+8zifpiZhHiSz7nsMhXM4OAYOhQYKrwQtYr3xUiuLqY0C
         dftz8IVu7JUnGFR03iWLaWWKmXnIGNd86NvviUlXV2ediNu7kZQE5vSbB/OxNu0S/BAq
         V0h/YPRn1lPWwjy9ZFv2Wxj5uQSXrjCdf63DnZYh5epqfrCTle1tfyMQvtkorsORgOOQ
         SWwMneI3Vism0sCh0eT2PS0uoxjpST7dtWdpj9QxUoakPBX/I+6ztWjxcE9ouiil/6Th
         BkaQ==
X-Gm-Message-State: AOAM530HAyFq3QJHQEI6D1WWa3bATE64LmTjj4fHy1PHNWaG7fYenbno
        lnt4iocNyoMNSDxvVum43BI=
X-Google-Smtp-Source: ABdhPJwNdsnKxASPNjb0mzWOZGYLLkfljDAYqhMp2/dFIDkWpYBoCddwISwRGA55Pdp9tak8O6JFxA==
X-Received: by 2002:a17:90a:2e17:: with SMTP id q23mr817001pjd.43.1589912552545;
        Tue, 19 May 2020 11:22:32 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.22.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:22:31 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 05/10] dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
Date:   Tue, 19 May 2020 23:49:23 +0530
Message-Id: <1589912368-480-6-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the device tree bindings for the Actions Semi Owl SoCs DMA
Controller over to YAML schemas.

It also adds new compatible string "actions,s700-dma".

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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
 Documentation/devicetree/bindings/dma/owl-dma.yaml | 76 ++++++++++++++++++++++
 2 files changed, 76 insertions(+), 47 deletions(-)
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
index 000000000000..82e7d261e967
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
@@ -0,0 +1,76 @@
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
+    description:
+      DMA registers location and length.
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
+    description:
+      Physical channels supported.
+
+  dma-requests:
+    description:
+      Number of DMA request signals supported by the controller.
+
+  clocks:
+    description:
+      Phandle and Specifier of the clock feeding the DMA controller.
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

