Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C4EC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899812051A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="AURRjPp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD1Gd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:33:59 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:60618 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgD1Gdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:33:52 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id D379420CDC;
        Tue, 28 Apr 2020 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1588055632; bh=UBb6voEXnZVtEz2ml1YRi2CB/X7gUz26bvIQSCyUKX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AURRjPp1sdyjFwJi8SdcR45DMiMXQvQQdGq/9fl0fLPF/aYyQC9YTUYU30wKbCk/w
         6KyV6OMM7dSHLQFx1BBX+lIYMR1JC8QoONJurC5i9Ov/3tF2yH4Dl+Z/gYLC+Fc1m7
         Q7Px2Bi2xkHCQr495nTo8ZXAADitIdo6cF18SDGvSBLbUghlHm5WoopYvgtsl4UPhc
         n0Zqon5jg7tSnfaS82GD19OBYOwCCjXCtV2YwK77OJt77c16PAL/VqI5nbqQJgk0Li
         rw4rF5D/m2DxvdxbOrKJs+AqFSeuxrLJS7S2R371of6LradCB2O+Zy4P0aR7gcKhyg
         nL5JqhskOzmVA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 6/6] dt-bindings: interrupt-controller: Add Loongson PCH MSI
Date:   Tue, 28 Apr 2020 14:32:45 +0800
Message-Id: <20200428063247.2223499-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200428063247.2223499-1-jiaxun.yang@flygoat.com>
References: <20200422142428.1249684-1-jiaxun.yang@flygoat.com>
 <20200428063247.2223499-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Loongson PCH MSI controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../loongson,pch-msi.yaml                     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
new file mode 100644
index 000000000000..513ed1933035
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
@@ -0,0 +1,56 @@
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
+description: |
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
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      u32 value of the base of parent HyperTransport vector allocated
+      to PCH MSI.
+
+  loongson,msi-num-vecs:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      u32 value of the number of parent HyperTransport vectors allocated
+      to PCH MSI.
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
-- 
2.26.0.rc2

