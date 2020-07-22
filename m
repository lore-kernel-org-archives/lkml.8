Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CFD2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgGVTNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:13:06 -0400
Received: from mailout12.rmx.de ([94.199.88.78]:36241 "EHLO mailout12.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgGVTNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:13:06 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout12.rmx.de (Postfix) with ESMTPS id 4BBkn24scMzRq9f;
        Wed, 22 Jul 2020 20:40:54 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BBkmW6hFtz2TRlg;
        Wed, 22 Jul 2020 20:40:27 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.68) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 22 Jul
 2020 20:40:27 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH 3/4] dt-bindings: usb: Add Microchip USB47xx/USB49xx support
Date:   Wed, 22 Jul 2020 20:38:58 +0200
Message-ID: <20200722183859.24470-4-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722183859.24470-1-ceggers@arri.de>
References: <20200722183859.24470-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.68]
X-RMX-ID: 20200722-204027-4BBkmW6hFtz2TRlg-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Microchip USB47xx/USB49xx driver.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 .../devicetree/bindings/usb/usb49xx.yaml      | 230 ++++++++++++++++++
 1 file changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/usb49xx.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb49xx.yaml b/Documentation/devicetree/bindings/usb/usb49xx.yaml
new file mode 100644
index 000000000000..20c7b64c6b7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb49xx.yaml
@@ -0,0 +1,230 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb49xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip USB47xx/USB49xx USB 2.0 Hi-Speed Hub Controller
+
+maintainers:
+  - Christian Eggers <ceggers@arri.de>
+
+description: |
+  http://ww1.microchip.com/downloads/en/Appnotes/AN2651-Configuration-of-Microchip-USB47xx-USB49xx-Application-Note-00002651B.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,usb4712
+      - microchip,usb4712i
+      - microchip,usb4715
+      - microchip,usb4715i
+      - microchip,usb4912
+      - microchip,usb4912i
+      - microchip,usb4914
+      - microchip,usb4914i
+      - microchip,usb4916
+      - microchip,usb4916i
+      - microchip,usb4925
+      - microchip,usb4925i
+      - microchip,usb4927
+      - microchip,usb4927i
+
+  reg:
+    maxItems: 1
+    description:
+      I2C address on the selected bus (usually <0x2D>).
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Specify the gpio for hub reset.
+
+  vdd-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Specify the regulator supplying vdd.
+
+  skip-config:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Skip Hub configuration, but only send the USB-Attach command.
+
+  vendor-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 65535
+    description:
+      Set USB Vendor ID of the hub.
+
+  product-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 65535
+    description:
+      Set USB Product ID of the hub.
+
+  device-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 65535
+    description:
+      Set USB Device ID of the hub.
+
+  language-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 65535
+    description:
+      Set USB Language ID.
+
+  manufacturer:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Set USB Manufacturer string (max. 62 characters long).
+
+  product:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Set USB Product string (max. 62 characters long).
+
+  bus-powered:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Selects bus powered operation.
+
+  self-powered:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Selects self powered operation (default).
+
+  disable-hi-speed:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Disable USB Hi-Speed support.
+
+  multi-tt:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Selects multi-transaction-translator (default).
+
+  single-tt:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Selects single-transaction-translator.
+
+  disable-eop:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Disable End of Packet generation in full-speed mode.
+
+  ganged-sensing:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Select ganged over-current sense type in self-powered mode.
+
+  individual-sensing:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Select individual over-current sense type in self-powered mode (default).
+
+  ganged-port-switching:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Select ganged port power switching mode.
+
+  individual-port-switching:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Select individual port power switching mode (default).
+
+  dynamic-power-switching:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable auto-switching from self- to bus-powered operation if the local
+      power source is removed or unavailable.
+
+  oc-delay-us:
+    enum:
+      - 50
+      - 100
+      - 200
+      - 400
+    default: 200
+    description:
+      Delay time (in microseconds) for filtering the over-current sense inputs.
+      If an invalid value is given, the default is used instead.
+
+  compound-device:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicate the hub is part of a compound device.
+
+  port-mapping-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable port mapping mode.
+
+  non-removable-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Should specify the ports which have a non-removable device connected.
+
+  sp-disabled-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specifies the ports which will be self-power disabled.
+
+  bp-disabled-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specifies the ports which will be bus-power disabled.
+
+  power-on-time-ms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 100
+    minimum: 0
+    maximum: 510
+    description:
+      Specifies the time (in milliseconds) it takes from the time the host
+      initiates the power-on sequence to a port until the port has adequate
+      power.
+
+  hub-controller-port:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Hub port where the internal hub controller shall be connected. Usually
+      <number of ports>+1.
+
+additionalProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      usb4916i@2d {
+        compatible = "microchip,usb4916i";
+        reg = <0x2d>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_usb_hub>;
+        /* usb49xx.c already assumes low-active, don't negate twice */
+        reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+        //skip-config;
+        //self-powered;         /* power on default */
+        //individual-sensing;   /* power on default */
+        //multi-tt;             /* power on default */
+        //disable-eop;          /* power on default */
+        //individual-port-switching;  /* power on default */
+        //oc-delay-ns = <200>;  /* power on default */
+        power-on-time-ms = <4>; /* T_ON,max = 4 ms for NCP380 */
+        ocs-min-width-ms = <0>; /* MIC2005 only outputs 2us FAULT pulses */
+        manufacturer = "Foo";
+        product = "Foo-Bar";
+        /* port 5 is connected to an internal SD-Card reader */
+        non-removable-ports = <5>;
+      };
+    };
+
+...
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

