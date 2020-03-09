Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E4C24676
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="gtTcMZ/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCIUga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:36:30 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:57386 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgCIUg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:36:29 -0400
Received: from localhost.localdomain (80-110-126-226.cgn.dynamic.surfer.at [80.110.126.226])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 81B32C3FFA;
        Mon,  9 Mar 2020 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1583786188; bh=KPd6oQFBBiN/9I0ySx9jqxIcwIp9TkFiNB/U9clGivc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gtTcMZ/x2ojg0iBOdpF0cSX9DyGMNXbgNUZujiGdqwVucl+02AfEvdCu/7ozMCSq9
         0gDj6wQD7uR/DHcgwUdDErAW+wxrfbaKCmjcPFvNFiPot1dCo0y+J7FO7kBZNY2xtT
         wH/epdZENLc63KhZxfN9gBC81N8/mu8KsM5SHJfA=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-leds@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 2/3] dt-bindings: leds: Add binding for sgm3140
Date:   Mon,  9 Mar 2020 21:35:57 +0100
Message-Id: <20200309203558.305725-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309203558.305725-1-luca@z3ntu.xyz>
References: <20200309203558.305725-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for SGMICRO SGM3140 charge pump used for
camera flash LEDs.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes since RFC:
- new patch

I'm not sure about the completeness of this binding as it doesn't
mention the led subnode at all.
The only existing led yaml binding is leds/leds-max77650.yaml which
mentions the subnode but duplicates properties from documented in 
leds/common.txt.

 .../bindings/leds/leds-sgm3140.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
new file mode 100644
index 000000000000..be9384573d02
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-sgm3140.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SGMICRO SGM3140 500mA Buck/Boost Charge Pump LED Driver
+
+maintainers:
+  - Luca Weiss <luca@z3ntu.xyz>
+
+description: |
+  The SGM3140 is a current-regulated charge pump which can regulate two current
+  levels for Flash and Torch modes.
+
+  It is controlled with two GPIO pins.
+
+  The data sheet can be found at:
+    http://www.sg-micro.com/uploads/soft/20190626/1561535688.pdf
+
+properties:
+  compatible:
+    const: sgmicro,sgm3140
+
+  enable-gpios:
+    maxItems: 1
+    description: A connection to the 'EN' pin.
+
+  flash-gpios:
+    maxItems: 1
+    description: A connection to the 'FLASH' pin.
+
+required:
+  - compatible
+  - flash-gpios
+  - enable-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    sgm3140 {
+        compatible = "sgmicro,sgm3140";
+        flash-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+        enable-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
+
+        sgm3140_flash: led {
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            flash-max-timeout-us = <250000>;
+        };
+    };
-- 
2.25.1

