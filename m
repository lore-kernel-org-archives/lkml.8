Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A302BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9E720829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgESILI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgESILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:11:07 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08DEC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:11:06 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:918e:b928:22c1:d715])
        by baptiste.telenet-ops.be with bizsmtp
        id gYB32200S4CPMDc01YB3Rl; Tue, 19 May 2020 10:11:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jaxL5-0000jp-Lf; Tue, 19 May 2020 10:11:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jaxL5-0007Y4-IN; Tue, 19 May 2020 10:11:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: timer: Add renesas,em-sti bindings
Date:   Tue, 19 May 2020 10:11:01 +0200
Message-Id: <20200519081101.28973-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Device Tree bindings for the Renesas EMMA Mobile System Timer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/timer/renesas,em-sti.yaml        | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,em-sti.yaml

diff --git a/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml b/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
new file mode 100644
index 0000000000000000..233d74d5402cf734
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/renesas,em-sti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas EMMA Mobile System Timer
+
+maintainers:
+  - Magnus Damm <magnus.damm@gmail.com>
+
+properties:
+  compatible:
+    const: renesas,em-sti
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    timer@e0180000 {
+            compatible = "renesas,em-sti";
+            reg = <0xe0180000 0x54>;
+            interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&sti_sclk>;
+            clock-names = "sclk";
+    };
-- 
2.17.1

