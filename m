Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78205C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E5420774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCWFai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:30:38 -0400
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:44123 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgCWFah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:30:37 -0400
IronPort-SDR: YbxTHeOOcFdXOuhoP3V/Htz6bnQHTfERZD1jCGnLtMR2iVr3VW3KaPqlM3GCBk+5houZHjuSHn
 ckjHSzgN7jHA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Mar 2020 13:30:35 +0800
Received: from CSBMAIL1.internal.ite.com.tw (csbmail1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 02N5USbj004041;
        Mon, 23 Mar 2020 13:30:28 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 23 Mar 2020 13:30:20 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/3] dt-bindings: Add binding for IT6505.
Date:   Mon, 23 Mar 2020 13:21:53 +0800
Message-ID: <1584941015-20541-3-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584941015-20541-1-git-send-email-allen.chen@ite.com.tw>
References: <1584941015-20541-1-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: 4DB9E5599C06409A34E643D7D7F07E90C8EC27F661EB41F2CF794FDB20F7BB5F2000:8
X-MAIL: mse.ite.com.tw 02N5USbj004041
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT binding documentation for IT6505.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
cros-ec does not have an associated driver that uses the standard Linux USB-C driver class.
extcon is used to model the Type-C connector.(crbug.com/982932)
---
 .../bindings/display/bridge/ite,it6505.yaml        | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
new file mode 100644
index 00000000..13feeef
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ITE it6505 Device Tree Bindings
+
+maintainers:
+  - Allen Chen <allen.chen@ite.com.tw>
+
+description: |
+  The IT6505 is a high-performance DisplayPort 1.1a transmitter,
+  fully compliant with DisplayPort 1.1a, HDCP 1.3 specifications.
+  The IT6505 supports color depth of up to 36 bits (12 bits/color)
+  and ensures robust transmission of high-quality uncompressed video
+  content, along with uncompressed and compressed digital audio content.
+
+  Aside from the various video output formats supported, the IT6505
+  also encodes and transmits up to 8 channels of I2S digital audio,
+  with sampling rate up to 192kHz and sample size up to 24 bits.
+  In addition, an S/PDIF input port takes in compressed audio of up to
+  192kHz frame rate.
+
+  Each IT6505 chip comes preprogrammed with an unique HDCP key,
+  in compliance with the HDCP 1.3 standard so as to provide secure
+  transmission of high-definition content. Users of the IT6505 need not
+  purchase any HDCP keys or ROMs.
+
+properties:
+  compatible:
+    const: ite,it6505
+
+  ovdd-supply:
+    maxItems: 1
+    description: I/O voltage
+
+  pwr18-supply:
+    maxItems: 1
+    description: core voltage
+
+  interrupts:
+    maxItems: 1
+    description: interrupt specifier of INT pin
+
+  reset-gpios:
+    maxItems: 1
+    description: gpio specifier of RESET pin
+
+  extcon:
+    maxItems: 1
+    description: extcon specifier for the Power Delivery
+
+  port:
+    type: object
+    description: A port node pointing to DPI host port node
+
+required:
+  - compatible
+  - ovdd-supply
+  - pwr18-supply
+  - interrupts
+  - reset-gpios
+  - extcon
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c3 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dp-bridge@5c {
+            compatible = "ite,it6505";
+            interrupts = <152 IRQ_TYPE_EDGE_FALLING 152 0>;
+            reg = <0x5c>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&it6505_pins>;
+            ovdd-supply = <&mt6358_vsim1_reg>;
+            pwr18-supply = <&it6505_pp18_reg>;
+            reset-gpios = <&pio 179 1>;
+            extcon = <&usbc_extcon>;
+
+            port {
+                it6505_in: endpoint {
+                    remote-endpoint = <&dpi_out>;
+                };
+            };
+        };
+    };
-- 
1.9.1

