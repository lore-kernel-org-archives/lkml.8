Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882DCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6285720728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="wqc+eH54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgEPI3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgEPI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:29:49 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC8C061A0C;
        Sat, 16 May 2020 01:29:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 9ED9821015;
        Sat, 16 May 2020 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1589617788; bh=A4oRxq0dMuOpx/3aB5frBbz3pdt/tjtxdcwCB5u6kPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqc+eH543srFNFdzr5zzVl7gxufd3RZKeSiFcyLT9dPzHtsDLwNntqFTADHaVt0RU
         L8TUCd8VEF1egSUwci0V4MFyJCz6MCr8aMdjOe9DYSpIy50Ir4Aq9/hRbW+ADBxJqa
         5p5r15rmKJSyppzlgQSVFeXybo0wPp/5ZreK+cJIMLJ2ZEef4fNJJLiMZkpmg2dukh
         hFkG1b+2yq57N8cH1zLTdwRX/J006OyVR0NQv0Y2WccGKECuihOASyQBnPyK0R6v2q
         moFdau1Xb5ukvJtkDbXCLY9k9U/AP3N1sNy9hm9tvIfA7lPd8LH06AZv6ndPNV6GFf
         gROlbaxboPLTg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 2/6] dt-bindings: interrupt-controller: Add Loongson HTVEC
Date:   Sat, 16 May 2020 16:29:02 +0800
Message-Id: <20200516082912.3673033-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516082912.3673033-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200516082912.3673033-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Loongson-3 HyperTransport Interrupt Vector Controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
--
v4: Drop ref, '|', add additionalProperties, fix example
---
 .../interrupt-controller/loongson,htvec.yaml  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
new file mode 100644
index 000000000000..19f0109c2afd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,htvec.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson-3 HyperTransport Interrupt Vector Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description:
+  This interrupt controller is found in the Loongson-3 family of chips for
+  receiving vectorized interrupts from PCH's interrupt controller.
+
+properties:
+  compatible:
+    const: loongson,htvec-1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+    description: |
+      Four parent interrupts that receive chained interrupts.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    htvec: interrupt-controller@fb000080 {
+      compatible = "loongson,htvec-1.0";
+      reg = <0xfb000080 0x40>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interrupt-parent = <&liointc>;
+      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+                    <25 IRQ_TYPE_LEVEL_HIGH>,
+                    <26 IRQ_TYPE_LEVEL_HIGH>,
+                    <27 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.26.2

