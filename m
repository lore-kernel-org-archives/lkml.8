Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34106C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36A420731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e1BCbpsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgIJVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbgIJNBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:01:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A274C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so6646776wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRs7Uzub0zJIby8weUidtFyGgxBuDRRReFxv1hE4uO8=;
        b=e1BCbpsXv9QwCCYq522KpmcV/gk6T8ibKbGXusxUOfAfP2F3CYIxea926Q3rOONKiI
         Rzl8B7GGIANojnTkvRGBr2uu72MpTHHDCNtHhD4yyD+b7SSDXbAYdCN+ImfUBrfmPAWg
         EnOxs50Im1TZFZVUxvBrJYQTIGujYBUAw6TypR8XcDTWN8Gvaq503Urh22FAiPblCx1k
         PS3Zc0optxM7KKJMz86JCliv8SH1QyDsfCON0rUiTTChG5yW+3AomEktH6Lxa7h1xT+3
         sbl6e6D5fbYtDpWmLKX7lyqsY2U970qtVw/X5OfLyjWjVVyvSgRQj0O1XdCwuFCNVIhb
         RWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRs7Uzub0zJIby8weUidtFyGgxBuDRRReFxv1hE4uO8=;
        b=n7+tF7gzWkZnbdR2zriMe6GaJKz+HsoV3WA1dA7qj2YV94zhMaMS3Ur1C0SV8qv+oW
         15DR6/1l9uf7Rsrhp1feReyPPaplXgkIswAL4WbU8tIr4tK+rUjaG+A2T60NgEOysJlL
         UdHBbfeTwSH70hA+Zb6dBLIKIDtaLC3GkhNbkbrEnIx3afk+DJWnk/mHSLFLYVTZATM3
         aCEZvZx9tP+uXny4Dm+LrOqaTr6CHY6oEKTTBzrXbcvQjbHPMgieWCEi7j59BEDfD8vw
         UvdkrtS/W3UK5Ys8l3T8l1RiezVGDNj2nEVig8kPfL1LkKBN8f54vQR1bHCmFliRPbVw
         CGaw==
X-Gm-Message-State: AOAM530jr54w1oxh0QC9P4JW2ZLmzFXaitXpWhjwUa+ktUB1UAE9IMx3
        CO2Axk/y6EhOKQdUXt9VYq8xKw==
X-Google-Smtp-Source: ABdhPJx4KLaMhKr7HdhOjKyG9sCQC8O62DGqMbs3kGQb1cIb++035zPL1Wso7SB/gY7s9bimrlrhXA==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr8886654wrm.346.1599742898647;
        Thu, 10 Sep 2020 06:01:38 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y1sm9488269wru.87.2020.09.10.06.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:01:37 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, gpain@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 1/4] dt bindings: remoteproc: Add bindings for MT8183 APU
Date:   Thu, 10 Sep 2020 15:01:45 +0200
Message-Id: <20200910130148.8734-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910130148.8734-1-abailon@baylibre.com>
References: <20200910130148.8734-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds dt bindings for the APU present in the MT8183.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../bindings/remoteproc/mtk,apu.yaml          | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
new file mode 100644
index 000000000000..7a71d2f5c4e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+
+---
+$id: "http://devicetree.org/schemas/remoteproc/mtk,apu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MT8183 AI Processor Unit (APU) a.k.a. Vision Processor Unit (VPU)
+
+description:
+  This document defines the binding for the APU, a co-processor that could
+  offload the CPU for machine learning and neural network.
+
+maintainers:
+  - Alexandre Bailon <abailon@bayLibre.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8183-apu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Three clocks are expected for AXI, IPU and JTAG.
+      The JTAG clock seems to be required to run the DSP,
+      even when JTAG is not in use."
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: axi
+      - const: ipu
+      - const: jtag
+
+  iommus:
+    maxItems: 3
+
+  memory-region:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  pinctrl:
+    description: pinctrl handles, required to configure pins for JTAG.
+
+  pinctrl-names:
+    items:
+      - const: jtag
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - iommus
+  - memory-region
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt8183-larb-port.h>
+    #include <dt-bindings/power/mt8183-power.h>
+
+    reserved-memory {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      apu_ram: apu_ram@0x60000000 {
+        compatible = "shared-dma-pool";
+        reg = <0x60000000 0x040000000>;
+        no-map;
+        linux,cma-default;
+      };
+    };
+
+    apu0: apu@19100000 {
+      compatible = "mediatek,mt8183-apu";
+      reg = <0x19180000 0x14000>;
+      interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_LOW>;
+
+      iommus = <&iommu M4U_PORT_IMG_IPUO>,
+         <&iommu M4U_PORT_IMG_IPU3O>,
+         <&iommu M4U_PORT_IMG_IPUI>;
+
+      clocks = <&ipu_core0 CLK_IPU_CORE0_AXI>,
+         <&ipu_core0 CLK_IPU_CORE0_IPU>,
+         <&ipu_core0 CLK_IPU_CORE0_JTAG>;
+
+      clock-names = "axi", "ipu", "jtag";
+
+      power-domains = <&scpsys MT8183_POWER_DOMAIN_VPU_CORE0>;
+      memory-region = <&apu_ram>;
+    };
+...
-- 
2.26.2

