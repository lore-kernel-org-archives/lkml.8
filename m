Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905EC2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261898;
	bh=FrBso4fIdHgK+2J7oFtYR56l7zEdAlo1N90r7YDQ9WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGA2+6DToXL1sAT3IE5b+SnXIpoSc0JP/Aoh6gT2FykVvj4wboWmtpgJ5NikCCYbg
	 uEUA+tM6Ivqwfn+y7U7b7F2io17I4ZxYz4wFf8c2WXTjrh8Cpp/qEgplGeyKfh6oYl
	 MH7GnohcRXwppzvhvI168zU9oYmDw1dGrMwg6gHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgHXJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgHXIr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:47:26 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5324204FD;
        Mon, 24 Aug 2020 08:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258845;
        bh=FrBso4fIdHgK+2J7oFtYR56l7zEdAlo1N90r7YDQ9WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxkNnl6RQL4MJs0VwWJz9u5g+UxyDb3kb1U7CqQb2TQi+dAvW29VIywXJmzdgrcmi
         f55874SPMco08TgiGledUdy4nNV8OW4/7PJPxlUzY9MNibPJxG76JuPOpaKJ8DZB1P
         ZVgHM67WAaNPD8jYCtLL9bHjCO5hW1ji8XYqfryg=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
Date:   Mon, 24 Aug 2020 14:17:10 +0530
Message-Id: <20200824084712.2526079-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824084712.2526079-1-vkoul@kernel.org>
References: <20200824084712.2526079-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for GPI DMA controller
implemented on Qualcomm SoCs

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/dma/qcom-gpi.yaml     | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom-gpi.yaml

diff --git a/Documentation/devicetree/bindings/dma/qcom-gpi.yaml b/Documentation/devicetree/bindings/dma/qcom-gpi.yaml
new file mode 100644
index 000000000000..c56d601ad2d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom-gpi.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/gpi-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc GPI DMA controller
+
+description: |
+  QCOM GPI DMA controller provides DMA capabilities for
+  peripheral buses such as I2C, UART, and SPI.
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,gpi-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt lines for each GPII instance
+    maxItems: 14
+
+  qcom,max-num-gpii:
+    description:
+      Maximum number of GPII instances available
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  qcom,gpii-mask:
+    description:
+      Bitmap of supported GPII instances for OS
+    maxItems: 1
+
+  qcom,ev-factor:
+    description:
+      Event ring transfer size compare to channel transfer ring. Event
+        ring length = ev-factor * transfer ring size
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - qcom,max-num-gpii
+  - qcom,gpii-mask
+  - qcom,ev-factor
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    gpi_dma0: dma@800000 {
+        #dma-cells = <5>;
+        compatible = "qcom,gpi-dma";
+        reg = <0 0x00800000 0 0x60000>;
+        qcom,max-num-gpii = <13>;
+        qcom,gpii-mask = <0xfa>;
+        qcom,ev-factor = <2>;
+        interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
-- 
2.26.2

