Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC6C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D055B2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgzHV/iN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgHZIy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgHZIy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:54:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC98C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:54:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 10so579288plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qadicGXgYcKSNNg1g3go9gjZkk5hffA2czmSYcbwqeQ=;
        b=VgzHV/iNY+RV3kQGcpWagm0E5cDIzUJBfRj8kWs+4M3XFc2gek9bNT+b4PXw+/b4ob
         bOI9+m63UM96I12pdmdG6t4os3qcXBLBnZd5Bazs2C2Oz6z1JRKv65geOMJxWCy4DZXR
         v9vdoApNkhj3Dy1LT3yHgDW/CAErOzLnt8VkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qadicGXgYcKSNNg1g3go9gjZkk5hffA2czmSYcbwqeQ=;
        b=QuoQPgepU4z0fyMTm7dpFJCOmp1f2ZEO5S3CM7BJQfwbRdOfgrA0vqTOk0Lzb+UKXp
         10tmvXGdXIZJrxDM9gM3mIBKvjhvx5Y2zheXJBuPgK8ki5VyyrfwWhOD9bJSLYf0FrW/
         /IyHAAxB/jreEne/QU32MjNdCzE6R5hgvqop0OqmhNE24vgrv5SuGCmEwVDzWtlHh/tB
         baMXgwbUsLyUs/SYZvl+Eb26R8xxN2y60MqtLRlUhJkLPCaI0Z5AOlw/nT8NHMuo5FmY
         rBULIj6UNTWT9d48rK/SehnbKRu5frkNV+zn+JlwmcwJdwp6yu64HKYpt5W9qBYUYVul
         IrbA==
X-Gm-Message-State: AOAM530yixTxWAuDW1fByOG55zfb0PXn0u3Bj5hdcU4ParlfWkJxbnP+
        j9BHE2Uqz6c692oH4BRjKnXCsQ==
X-Google-Smtp-Source: ABdhPJzWRfgimLFOdQX8RCV3Sw17ksdclDCbGcimvVj7p/+/yoe05SEkkQ42vUBTyKihWIgxgA7eoQ==
X-Received: by 2002:a17:90a:8a97:: with SMTP id x23mr5154324pjn.195.1598432095759;
        Wed, 26 Aug 2020 01:54:55 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id v91sm1702990pjv.12.2020.08.26.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 01:54:54 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2] dt-bindings: spi: Convert spi-mtk-nor to json-schema
Date:   Wed, 26 Aug 2020 16:54:50 +0800
Message-Id: <20200826085450.508556-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200820052827.2642164-1-ikjn@chromium.org>
References: <20200820052827.2642164-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Mediatek ARM SOC's serial NOR flash controller binding
to json-schema format.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
v2: remove unnecessary quotes, set interrupts as required,
    add unevaluatedProperties:false
---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 85 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-mtk-nor.txt   | 47 ----------
 2 files changed, 85 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mtk-nor.txt

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
new file mode 100644
index 000000000000..42c9205ac991
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mediatek,spi-mtk-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Serial NOR flash controller for MediaTek ARM SoCs
+
+maintainers:
+  - Bayi Cheng <bayi.cheng@mediatek.com>
+  - Chuanhong Guo <gch981213@gmail.com>
+
+description: |
+  This spi controller support single, dual, or quad mode transfer for
+  SPI NOR flash. There should be only one spi slave device following
+  generic spi bindings. It's not recommended to use this controller
+  for devices other than SPI NOR flash due to limited transfer
+  capability of this controller.
+
+allOf:
+  - $ref: /spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-nor
+              - mediatek,mt2712-nor
+              - mediatek,mt7622-nor
+              - mediatek,mt7623-nor
+              - mediatek,mt7629-nor
+          - enum:
+              - mediatek,mt8173-nor
+      - items:
+          - const: mediatek,mt8173-nor
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock used for spi bus
+      - description: clock used for controller
+
+  clock-names:
+    items:
+      - const: spi
+      - const: sf
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      nor_flash: spi@1100d000 {
+        compatible = "mediatek,mt8173-nor";
+        reg = <0 0x1100d000 0 0xe0>;
+        interrupts = <&spi_flash_irq>;
+        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
+        clock-names = "spi", "sf";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "jedec,spi-nor";
+          reg = <0>;
+        };
+      };
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
deleted file mode 100644
index 984ae7fd4f94..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Serial NOR flash controller for MediaTek ARM SoCs
-
-Required properties:
-- compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
-		  and it's the fallback compatible for other Soc.
-		  For every other SoC, should contain both the SoC-specific compatible
-		  string and "mediatek,mt8173-nor".
-		  The possible values are:
-		  "mediatek,mt2701-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt2712-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt7622-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt8173-nor"
-- reg: 		  physical base address and length of the controller's register
-- interrupts:	  Interrupt number used by the controller.
-- clocks: 	  the phandle of the clocks needed by the nor controller
-- clock-names: 	  the names of the clocks
-		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
-		  and "sf" is used for controller, these are the clocks witch
-		  hardware needs to enabling nor flash and nor flash controller.
-		  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- #address-cells: should be <1>
-- #size-cells:	  should be <0>
-
-There should be only one spi slave device following generic spi bindings.
-It's not recommended to use this controller for devices other than SPI NOR
-flash due to limited transfer capability of this controller.
-
-Example:
-
-nor_flash: spi@1100d000 {
-	compatible = "mediatek,mt8173-nor";
-	reg = <0 0x1100d000 0 0xe0>;
-	interrupts = <&spi_flash_irq>;
-	clocks = <&pericfg CLK_PERI_SPI>,
-		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
-	clock-names = "spi", "sf";
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-	};
-};
-
-- 
2.28.0.297.g1956fa8f8d-goog

