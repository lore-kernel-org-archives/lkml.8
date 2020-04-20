Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B75B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="XJitB7jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgDTNql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:46:41 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:59102 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgDTNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:46:40 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id CD7A320CD8;
        Mon, 20 Apr 2020 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587390399; bh=JIRXmtrKVz8AnOE2yfwa7R44IgnCUpDcFZBuh7UShw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJitB7jwewz6iLIdGqKTjrmd1OP/J1nSkMsHIBSgiPPxhb37aDtuH7DjA10krVtG8
         Dy8/L2a1OL5MpLWLKUEGKcKrDb/J+LJFrKY/Rf0PR8ZdhSGn7rB77kAiV9fbewOSez
         k/KoPYp++D3ozoar0714NdGHX1FPj8rhs9iVids11sB8i5Pqr0xbhTEZrhNuNR9Qd6
         N++ZnFNKrar1u3zp0mfI9d1djtI5OmA03XsXCJ9pEiGOxpfjsrEOfGiju/8KsL5OIR
         XX4rwWrykeGG61XxQ0OVDk6F6DSwDOgeYMyy5Ic0tEHpkGbQpLLF+eU37Wacg6LMVB
         wtlgLfXVD0NQg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: Document Loongson RS780E PCH ACPI Controller
Date:   Mon, 20 Apr 2020 21:45:27 +0800
Message-Id: <20200420134536.210475-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200420134536.210475-1-jiaxun.yang@flygoat.com>
References: <20200420073347.157230-1-jiaxun.yang@flygoat.com>
 <20200420134536.210475-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This controller is attached under ISA Bus and can be found
in Loongson-3 systems with RS780E PCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mips/loongson/rs780e-acpi.yaml   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/loongson/rs780e-acpi.yaml

diff --git a/Documentation/devicetree/bindings/mips/loongson/rs780e-acpi.yaml b/Documentation/devicetree/bindings/mips/loongson/rs780e-acpi.yaml
new file mode 100644
index 000000000000..d317897e1115
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/loongson/rs780e-acpi.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mips/loongson/rs780e-acpi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson RS780E PCH ACPI Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description: |
+  This controller can be found in Loongson-3 systems with RS780E PCH.
+
+properties:
+  compatible:
+    const: loongson,rs780e-acpi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    isa@0 {
+      compatible = "isa";
+      #address-cells = <2>;
+      #size-cells = <1>;
+      ranges = <1 0 0 0x1000>;
+
+      acpi@800 {
+        compatible = "loongson,rs780e-acpi";
+        reg = <1 0x800 0x100>;
+      };
+    };
+
+...
-- 
2.26.0.rc2

