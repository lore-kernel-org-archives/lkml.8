Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A92C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA5A20759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgEUJOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:14:17 -0400
Received: from v6.sk ([167.172.42.174]:34908 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgEUJOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:14:15 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1787561306;
        Thu, 21 May 2020 09:14:14 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 8/9] dt-bindings: timer: Convert mrvl,mmp-timer to json-schema
Date:   Thu, 21 May 2020 11:13:55 +0200
Message-Id: <20200521091356.2211020-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091356.2211020-1-lkundrak@v3.sk>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A straightforward conversion of the mrvl,mmp-timer binding to DT schema
format using json-schema.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Add default GPL-2.0-only license tag
- Fill in maintainers from MAINTAINERS file

 .../bindings/timer/mrvl,mmp-timer.txt         | 17 -------
 .../bindings/timer/mrvl,mmp-timer.yaml        | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
deleted file mode 100644
index b8f02c663521..000000000000
--- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Marvell MMP Timer controller
-
-Required properties:
-- compatible : Should be "mrvl,mmp-timer".
-- reg : Address and length of the register set of timer controller.
-- interrupts : Should be the interrupt number.
-
-Optional properties:
-- clocks : Should contain a single entry describing the clock input.
-
-Example:
-	timer0: timer@d4014000 {
-		compatible = "mrvl,mmp-timer";
-		reg = <0xd4014000 0x100>;
-		interrupts = <13>;
-		clocks = <&coreclk 2>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.yaml b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.yaml
new file mode 100644
index 000000000000..1fbc260a0cbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mrvl,mmp-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP Timer bindings
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+  - Thomas Gleixner <tglx@linutronix.de>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  $nodename:
+    pattern: '^timer@[a-f0-9]+$'
+
+  compatible:
+    const: mrvl,mmp-timer
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
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@d4014000 {
+        compatible = "mrvl,mmp-timer";
+        reg = <0xd4014000 0x100>;
+        interrupts = <13>;
+        clocks = <&coreclk 2>;
+    };
+
+...
-- 
2.26.2

