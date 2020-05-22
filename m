Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F7C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB452070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgEVLfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:35:15 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:49393 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729090AbgEVLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:35:15 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 04MBXMSl015024;
        Fri, 22 May 2020 14:33:22 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 676E4639C1; Fri, 22 May 2020 14:33:22 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     ofery@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, kfting@nuvoton.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, wsa@the-dreams.de,
        andriy.shevchenko@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v13 1/3] dt-bindings: i2c: npcm7xx: add NPCM I2C controller
Date:   Fri, 22 May 2020 14:33:10 +0300
Message-Id: <20200522113312.181413-2-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200522113312.181413-1-tali.perry1@gmail.com>
References: <20200522113312.181413-1-tali.perry1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM I2C controller.

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
---
 .../bindings/i2c/nuvoton,npcm7xx-i2c.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
new file mode 100644
index 000000000000..1c9d9a2d4bcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/nuvoton,npcm7xx-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: nuvoton NPCM7XX I2C Controller Device Tree Bindings
+
+description: |
+  The NPCM750x includes sixteen I2C bus controllers. All Controllers support
+  both master and slave mode. Each controller can switch between master and slave
+  at run time (i.e. IPMB mode). Each controller has two 16 byte HW FIFO for TX and
+  RX.
+
+maintainers:
+  - Tali Perry <tali.perry1@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm7xx-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: Reference clock for the I2C bus
+
+  bus-frequency:
+    description: Desired I2C bus clock frequency in Hz. If not specified,
+                 the default 100 kHz frequency will be used.
+                 possible values are 100000, 400000 and 1000000.
+    default: 100000
+    enum: [100000, 400000, 1000000]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c0: i2c@80000 {
+        compatible = "nuvoton,npcm750-i2c";
+        reg = <0x80000 0x1000>;
+        clocks = <&clk NPCM7XX_CLK_APB2>;
+        bus-frequency = <100000>;
+        interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
-- 
2.22.0

