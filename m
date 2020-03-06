Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9876C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CF92072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WPUQj8kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCFNk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:40:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53078 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCFNkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:40:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so2462637wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TqwPKVWpDrYVmu/Cm/Bmq2S/VPK7PgKiVqGEdY3cJqk=;
        b=WPUQj8kZJMXrcKqH/Ng/QOr/NbXP/iPjfR0rEVKAN8Ci3+AHvBaOZzWdhaRASufX3p
         k2YKlWwfaTN9YnFshsEKsjAdx6xTe76vSuC1joaK1J9amqtbOtZCo6A4ygS44kMJozyp
         hN/PmyyGLKp9+NdaJj7yOoIGKwFdJXjwz+QUFvFeoZLD34NMimL5So4q96ciNcvf1YYC
         hbe02WKVfoKKOPOHKsXl4AKT0hh/tOsEaHI6xGWMtboZib7fSF+u+nfafTlH+6azZ81+
         HcGybrHlgyaplqnj0MvRdIY6qFlGlbf8gckVLlWmoZt1Xm7i8xcL/jUPCGQmnlcvjwj+
         4ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TqwPKVWpDrYVmu/Cm/Bmq2S/VPK7PgKiVqGEdY3cJqk=;
        b=BrFZG+iEkcP4gBWxFjiZVGQjLWCJS4l7KyVO2CGUmTmlyOargUYNZ1xHj/UjYbuFQA
         5jTss2Cop5oqs4yHinvcDpxkRcpqRmD1yzooa+++gXOwbJpFc/ltm4q1jjoIgUOFGVbN
         0HoxSDqTK5SOVe03VA58D0LEUXl+lEbV6Mtis2A4S2kgoVnWqiRhaorsarEf5bm7FHSn
         QGAuZvnKlljsTlwnstnqsKGh9LdxNf4IHytXYjL3JcKGgg36u9t3ycSvMddanOayy80X
         pLxmpby7oEGNX6dHrk2LwGYufDsixgNRM4PxgqB2YmGjRzmHJBKfJXiczbm7Uah0zItp
         ji4Q==
X-Gm-Message-State: ANhLgQ0DCmktwb8ikQ9n9x35ut+q8/Coy4+nKomqe6cimM4Ywda5kdYW
        MOuyJExKBWSW9dTpdkCCwtm/wY+EPsFOiA==
X-Google-Smtp-Source: ADFU+vvxe2j0UhSXyb8tLoax6/Do2GBZydw/5eIHY4+nyFEx3t1nxI5f72UnPGv/mwksi7MziuPRew==
X-Received: by 2002:a1c:488b:: with SMTP id v133mr3967539wma.159.1583502052708;
        Fri, 06 Mar 2020 05:40:52 -0800 (PST)
Received: from localhost.localdomain (89-82-119-43.abo.bbox.fr. [89.82.119.43])
        by smtp.gmail.com with ESMTPSA id g7sm47178086wrm.72.2020.03.06.05.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2020 05:40:52 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io, Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH v3 2/3] dt-bindings: leds: Shiji Lighting APA102C LED
Date:   Fri,  6 Mar 2020 14:40:09 +0100
Message-Id: <1583502010-16210-3-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583502010-16210-1-git-send-email-nbelin@baylibre.com>
References: <1583502010-16210-1-git-send-email-nbelin@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Shiji Lighting APA102C LED driver device tree bindings.

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 .../devicetree/bindings/leds/leds-apa102c.yaml     | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-apa102c.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-apa102c.yaml b/Documentation/devicetree/bindings/leds/leds-apa102c.yaml
new file mode 100644
index 000000000000..21457fc3762d
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-apa102c.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-apa102c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for Shiji Lighting - APA102C
+
+maintainers:
+  - Nicolas Belin <nbelin@baylibre.com>
+
+description:
+  Each RGB LED is represented as a rgb-led sub-node of the leds-apa102c
+  device.  Each LED is a three color rgb LED with an additional 32 levels
+  brightness adjustment. They can be cascaded so that multiple LEDs can be set
+  with a single command.
+
+properties:
+  compatible:
+    const: shiji,apa102c
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^rgb-led@[0-9]+$":
+    type: object
+    description: |
+      Array of connected RGB LEDs.
+
+    properties:
+      reg:
+        description: |
+          This property corresponds to the led index. It has to be between 0
+          and the number of managed leds minus 1
+        maxItems: 1
+
+      label:
+        description: |
+          This property corresponds to the name of the RGB led.
+        maxItems: 1
+
+      linux,default-trigger: true
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    required:
+      - reg
+      - label
+      - '#address-cells'
+      - '#size-cells'
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        led-controller@0 {
+            compatible = "shiji,apa102c";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            rgb-led@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0>;
+                label = "rgb_led1";
+            };
+            rgb-led@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <1>;
+                label = "rgb_led2";
+            };
+        };
+    };
-- 
2.7.4

