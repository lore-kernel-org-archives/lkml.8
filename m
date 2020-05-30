Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE36C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E12920776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgE3Hqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgE3Hqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D212C03E969;
        Sat, 30 May 2020 00:46:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCN-0001p0-Ba; Sat, 30 May 2020 09:46:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE6391C0093;
        Sat, 30 May 2020 09:46:30 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:30 -0000
From:   "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add Loongson PCH MSI
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528152757.1028711-7-jiaxun.yang@flygoat.com>
References: <20200528152757.1028711-7-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <159082479072.17951.7141736298495200150.tip-bot2@tip-bot2>
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

Commit-ID:     da10a4b626657387845f32d37141fc7d48ebbdb3
Gitweb:        https://git.kernel.org/tip/da10a4b626657387845f32d37141fc7d48ebbdb3
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Thu, 28 May 2020 23:27:54 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 29 May 2020 09:42:19 +01:00

dt-bindings: interrupt-controller: Add Loongson PCH MSI

Add binding for Loongson PCH MSI controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200528152757.1028711-7-jiaxun.yang@flygoat.com
---
 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
new file mode 100644
index 0000000..1a5ebbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,pch-msi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson PCH MSI Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description:
+  This interrupt controller is found in the Loongson LS7A family of PCH for
+  transforming interrupts from PCIe MSI into HyperTransport vectorized
+  interrupts.
+
+properties:
+  compatible:
+    const: loongson,pch-msi-1.0
+
+  reg:
+    maxItems: 1
+
+  loongson,msi-base-vec:
+    description:
+      u32 value of the base of parent HyperTransport vector allocated
+      to PCH MSI.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+        maximum: 255
+
+  loongson,msi-num-vecs:
+    description:
+      u32 value of the number of parent HyperTransport vectors allocated
+      to PCH MSI.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 1
+        maximum: 256
+
+  msi-controller: true
+
+required:
+  - compatible
+  - reg
+  - msi-controller
+  - loongson,msi-base-vec
+  - loongson,msi-num-vecs
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    msi: msi-controller@2ff00000 {
+      compatible = "loongson,pch-msi-1.0";
+      reg = <0x2ff00000 0x4>;
+      msi-controller;
+      loongson,msi-base-vec = <64>;
+      loongson,msi-num-vecs = <64>;
+      interrupt-parent = <&htvec>;
+    };
+...
