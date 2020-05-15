Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2EBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19942065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VCM6A/La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgEOKnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:43:50 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41384 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589539425; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=LSfDnvsEJIz1J1JIdTi+RPD75P1nIyJJmUoWunmP6sM=;
        b=VCM6A/LaTaE0jZo38Ia7KdlbNDVbLYUQh1fOPfNZuD5aN7E/BiQZx0E93N1S1RcAf+2uJO
        WuazfiA/DKpxQ1UJnTlv1m1+vVrDK08II/59JZYG2lpkTO98M2bmXqHcxw1ncapo/1vtes
        Uolr7r3/BC/45wJYF5L0bnM6+fXjUmo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: Document JZ47xx VPU auxiliary processor
Date:   Fri, 15 May 2020 12:43:36 +0200
Message-Id: <20200515104340.10473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
Ingenic is a second Xburst MIPS CPU very similar to the main core.
This document describes the devicetree bindings for this auxiliary
processor.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2: Update TCSM0 address in example
    v3: Change node name to 'video-decoder'
    v4: Convert to YAML. I didn't add Rob's Ack on v3 because of that (sorry Rob)
    v5: - Fix 'reg' not in <addr, len> pairs
    	- Add missing include to devicetree example
    v6-v7: No change

 .../bindings/remoteproc/ingenic,vpu.yaml      | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
new file mode 100644
index 000000000000..c019f9fbe916
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/remoteproc/ingenic,vpu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Ingenic Video Processing Unit bindings
+
+description:
+  Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
+  Ingenic is a second Xburst MIPS CPU very similar to the main core.
+  This document describes the devicetree bindings for this auxiliary
+  processor.
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  compatible:
+    const: ingenic,jz4770-vpu-rproc
+
+  reg:
+    items:
+      - description: aux registers
+      - description: tcsm0 registers
+      - description: tcsm1 registers
+      - description: sram registers
+
+  reg-names:
+    items:
+      - const: aux
+      - const: tcsm0
+      - const: tcsm1
+      - const: sram
+
+  clocks:
+    items:
+      - description: aux clock
+      - description: vpu clock
+
+  clock-names:
+    items:
+      - const: aux
+      - const: vpu
+
+  interrupts:
+    description: VPU hardware interrupt
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4770-cgu.h>
+
+    vpu: video-decoder@132a0000 {
+      compatible = "ingenic,jz4770-vpu-rproc";
+
+      reg = <0x132a0000 0x20>, /* AUX */
+            <0x132b0000 0x4000>, /* TCSM0 */
+            <0x132c0000 0xc000>, /* TCSM1 */
+            <0x132f0000 0x7000>; /* SRAM */
+      reg-names = "aux", "tcsm0", "tcsm1", "sram";
+
+      clocks = <&cgu JZ4770_CLK_AUX>, <&cgu JZ4770_CLK_VPU>;
+      clock-names = "aux", "vpu";
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <3>;
+    };
-- 
2.26.2

