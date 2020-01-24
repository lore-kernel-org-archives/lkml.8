Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3635DC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080B020880
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbgAXTLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:11:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403988AbgAXTLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MN-0007dd-9z; Fri, 24 Jan 2020 20:11:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E1DAC1C1A5F;
        Fri, 24 Jan 2020 20:11:10 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:10 -0000
From:   "tip-bot2 for Joakim Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add binding for
 NXP INTMUX interrupt multiplexer
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200117060653.27485-2-qiangqing.zhang@nxp.com>
References: <20200117060653.27485-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Message-ID: <157989307074.396.8522984149728788486.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     618ea6275b9806909ef384c6d57f40641d7985d2
Gitweb:        https://git.kernel.org/tip/618ea6275b9806909ef384c6d57f40641d7985d2
Author:        Joakim Zhang <qiangqing.zhang@nxp.com>
AuthorDate:    Fri, 17 Jan 2020 06:10:05 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 19:10:05 

dt-bindings: interrupt-controller: Add binding for NXP INTMUX interrupt multiplexer

This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
for i.MX8 family SoCs.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200117060653.27485-2-qiangqing.zhang@nxp.com
---
 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
new file mode 100644
index 0000000..43c6eff
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale INTMUX interrupt multiplexer
+
+maintainers:
+  - Joakim Zhang <qiangqing.zhang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx-intmux
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+    description: |
+      Should contain the parent interrupt lines (up to 8) used to multiplex
+      the input interrupts.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      The 1st cell is hw interrupt number, the 2nd cell is channel index.
+
+  clocks:
+    description: ipg clock.
+
+  clock-names:
+    const: ipg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@37400000 {
+        compatible = "fsl,imx-intmux";
+        reg = <0x37400000 0x1000>;
+        interrupts = <0 16 4>,
+                     <0 17 4>,
+                     <0 18 4>,
+                     <0 19 4>,
+                     <0 20 4>,
+                     <0 21 4>,
+                     <0 22 4>,
+                     <0 23 4>;
+        interrupt-controller;
+        interrupt-parent = <&gic>;
+        #interrupt-cells = <2>;
+        clocks = <&clk>;
+        clock-names = "ipg";
+    };
