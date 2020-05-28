Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABDFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6923A214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="miEDh9vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404441AbgE1P3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404418AbgE1P3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:29:00 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C66DC08C5C6;
        Thu, 28 May 2020 08:29:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 4EDA620F12;
        Thu, 28 May 2020 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590679740; bh=NqxmdRPeUycZfCLPTG84V3ZxjnAvqs76RNa18cYK7Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miEDh9vz5GzaD7YanDRa25KaSfXVV7UJ3y6bbu/V9/4DNKg5doxiwJXBubIrzhzNX
         PopyaYMpL9sXo9mMvaQBsFBxq8dYK2biQoFpBmDj1oWWQpBZN1pANuvFegeHXx+/JG
         KZTpfVeR5gtHmf/7WP55TsSYd5xNtoIRyMdhOIOCqK3Mor13io2whLFC9sF0JO3iD1
         FklA5AmZlB1mgRVuWTrQHRGuE00jVoxRpIGwF9m6Y2NdFYd9+4BNo7fM2k691PJBYm
         5cufk9wtTxQvdEaoHJFwMxQcrdNZmVPDGF8htmNsuH+tO3fN/6HZnlhSPZ2viYMoNF
         TvkuN10b96+jA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v5 4/6] dt-bindings: interrupt-controller: Add Loongson PCH PIC
Date:   Thu, 28 May 2020 23:27:52 +0800
Message-Id: <20200528152757.1028711-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200528152757.1028711-1-jiaxun.yang@flygoat.com>
References: <20200528152757.1028711-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Loongson PCH PIC Controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
--
v2:
	- Fix naming
	- Mark loongson,pic-base-vec as required
v5:
	- Add range check for loongson,pic-base-vec
---
 .../loongson,pch-pic.yaml                     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
new file mode 100644
index 000000000000..274adea13f33
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,pch-pic.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson PCH PIC Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description:
+  This interrupt controller is found in the Loongson LS7A family of PCH for
+  transforming interrupts from on-chip devices into HyperTransport vectorized
+  interrupts.
+
+properties:
+  compatible:
+    const: loongson,pch-pic-1.0
+
+  reg:
+    maxItems: 1
+
+  loongson,pic-base-vec:
+    description:
+      u32 value of the base of parent HyperTransport vector allocated
+      to PCH PIC.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+        maximum: 192
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - loongson,pic-base-vec
+  - interrupt-controller
+  - '#interrupt-cells'
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pic: interrupt-controller@10000000 {
+      compatible = "loongson,pch-pic-1.0";
+      reg = <0x10000000 0x400>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      loongson,pic-base-vec = <64>;
+      interrupt-parent = <&htvec>;
+    };
+...
-- 
2.27.0.rc0

