Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40557C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B92072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392003AbgAXTLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:11:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404134AbgAXTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MW-0007iC-Op; Fri, 24 Jan 2020 20:11:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 41F711C1A6E;
        Fri, 24 Jan 2020 20:11:13 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:13 -0000
From:   "tip-bot2 for Yash Shah" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] gpio/sifive: Add DT documentation for SiFive GPIO
Cc:     "Wesley W. Terpstra" <wesley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1575976274-13487-5-git-send-email-yash.shah@sifive.com>
References: <1575976274-13487-5-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Message-ID: <157989307309.396.12029128798763007003.tip-bot2@tip-bot2>
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

Commit-ID:     7875f8242494f8e4c8a75f2aeab4a6fb742599bd
Gitweb:        https://git.kernel.org/tip/7875f8242494f8e4c8a75f2aeab4a6fb742599bd
Author:        Yash Shah <yash.shah@sifive.com>
AuthorDate:    Tue, 10 Dec 2019 16:41:12 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 09:26:05 

gpio/sifive: Add DT documentation for SiFive GPIO

DT json-schema for GPIO controller added.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1575976274-13487-5-git-send-email-yash.shah@sifive.com
---
 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml | 68 ++++++++-
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
new file mode 100644
index 0000000..418e838
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sifive,gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive GPIO controller
+
+maintainers:
+  - Yash Shah <yash.shah@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-gpio
+      - const: sifive,gpio0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt mapping one per GPIO. Maximum 16 GPIOs.
+    minItems: 1
+    maxItems: 16
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - clocks
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/sifive-fu540-prci.h>
+      gpio@10060000 {
+        compatible = "sifive,fu540-c000-gpio", "sifive,gpio0";
+        interrupt-parent = <&plic>;
+        interrupts = <7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22>;
+        reg = <0x0 0x10060000 0x0 0x1000>;
+        clocks = <&tlclk PRCI_CLK_TLCLK>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+      };
+
+...
