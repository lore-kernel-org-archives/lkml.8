Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAF020792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHDGdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:33:43 -0400
Received: from mailout06.rmx.de ([94.199.90.92]:34790 "EHLO mailout06.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHDGdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:33:42 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout06.rmx.de (Postfix) with ESMTPS id 4BLQ1r6vcTz9x00;
        Tue,  4 Aug 2020 08:33:36 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BLQ1S1tS5z2TRlZ;
        Tue,  4 Aug 2020 08:33:16 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.79) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Aug
 2020 08:33:16 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Christian Eggers <ceggers@arri.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: at25: convert the binding document to yaml
Date:   Tue, 4 Aug 2020 08:33:07 +0200
Message-ID: <20200804063307.10029-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803221206.GA3211829@bogus>
References: <20200803221206.GA3211829@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.79]
X-RMX-ID: 20200804-083316-4BLQ1S1tS5z2TRlZ-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding document for at25 EEPROMs from txt to yaml.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
On Tuesday, 4 August 2020, 00:12:06 CEST, Rob Herring wrote:
> On Sun, Aug 02, 2020 at 07:46:26PM +0200, Christian Eggers wrote:
> > As there is virtually an infinite list of possible vendors and products
> > for such type of hardware, is there any value to use expressions like in
> > the at24 binding?
> 
> Maybe so, but there are only 4 compatible strings to document in the
> tree. That's not a lot to cover and we already have some of them in
> free-form text. If the infinite number becomes a problem we can always
> address that later. I'm sure that less than infinite buyers/products
> will prevent infinite producers.

Added the following devices to the new yaml binding:
- Examples from description of previous txt binding.
- Result of grepping .dts and .dtsi files for atmel,at25
- Devices I personally use (dts files not mainlined yet).

 .../devicetree/bindings/eeprom/at25.txt       |  46 +------
 .../devicetree/bindings/eeprom/at25.yaml      | 129 ++++++++++++++++++
 2 files changed, 130 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at25.yaml

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index fe91ecf1f61b..d9ef7dc5fb8e 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -1,45 +1 @@
-EEPROMs (SPI) compatible with Atmel at25.
-
-Required properties:
-- compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
-  Example "<vendor>,<type>" values:
-    "anvo,anv32e61w"
-    "microchip,25lc040"
-    "st,m95m02"
-    "st,m95256"
-
-- reg : chip select number
-- spi-max-frequency : max spi frequency to use
-- pagesize : size of the eeprom page
-- size : total eeprom size in bytes
-- address-width : number of address bits (one of 8, 9, 16, or 24).
-  For 9 bits, the MSB of the address is sent as bit 3 of the instruction
-  byte, before the address byte.
-
-Optional properties:
-- spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
-- spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
-- read-only : this parameter-less property disables writes to the eeprom
-- wp-gpios : GPIO to which the write-protect pin of the chip is connected
-
-Obsolete legacy properties can be used in place of "size", "pagesize",
-"address-width", and "read-only":
-- at25,byte-len : total eeprom size in bytes
-- at25,addr-mode : addr-mode flags, as defined in include/linux/spi/eeprom.h
-- at25,page-size : size of the eeprom page
-
-Additional compatible properties are also allowed.
-
-Example:
-	eeprom@0 {
-		compatible = "st,m95256", "atmel,at25";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		spi-cpha;
-		spi-cpol;
-		wp-gpios = <&gpio1 3 0>;
-
-		pagesize = <64>;
-		size = <32768>;
-		address-width = <16>;
-	};
+This file has been moved to at25.yaml.
diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
new file mode 100644
index 000000000000..9810619a2b5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/eeprom/at25.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: SPI EEPROMs compatible with Atmel's AT25
+
+maintainers:
+  - Christian Eggers <ceggers@arri.de>
+
+properties:
+  $nodename:
+    pattern: "^eeprom@[0-9a-f]{1,2}$"
+
+  # There are multiple known vendors who manufacture EEPROM chips compatible
+  # with Atmel's AT25. The compatible string requires two items where the
+  # 'vendor' and 'model' parts of the first are the actual chip and the second
+  # item is fixed to "atmel,at25". Some existing bindings only have the
+  # "atmel,at25" part and should be fixed by somebody who knows vendor and
+  # product.
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - anvo,anv32e61w
+              - atmel,at25256B
+              - fujitsu,mb85rs1mt
+              - fujitsu,mb85rs64
+              - microchip,at25160bn
+              - microchip,25lc040
+              - st,m95m02
+              - st,m95256
+
+          - const: atmel,at25
+
+      # Please don't use this alternative for new bindings.
+      - items:
+          - const: atmel,at25
+
+  reg:
+    description:
+      Chip select number.
+
+  spi-max-frequency: true
+
+  pagesize:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072]
+    description:
+      Size of the eeprom page.
+
+  size:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+      Total eeprom size in bytes.
+
+  address-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 8, 9, 16, 24 ]
+    description:
+      Number of address bits.
+      For 9 bits, the MSB of the address is sent as bit 3 of the instruction
+      byte, before the address byte.
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  read-only:
+    description:
+      Disable writes to the eeprom.
+    type: boolean
+
+  wp-gpios:
+    maxItems: 1
+    description:
+      GPIO to which the write-protect pin of the chip is connected.
+
+  # Deprecated: at25,byte-len, at25,addr-mode, at25,page-size
+  at25,byte-len:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+       Total eeprom size in bytes. Deprecated, use "size" property instead.
+    deprecated: true
+
+  at25,addr-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+       Addr-mode flags, as defined in include/linux/spi/eeprom.h.
+       Deprecated, use "address-width" property instead.
+    deprecated: true
+
+  at25,page-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the eeprom page. Deprecated, use "pagesize" property instead.
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - pagesize
+  - size
+  - address-width
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        eeprom@0 {
+            compatible = "st,m95256", "atmel,at25";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpha;
+            spi-cpol;
+            wp-gpios = <&gpio1 3 0>;
+
+            pagesize = <64>;
+            size = <32768>;
+            address-width = <16>;
+        };
+    };
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

