Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CFCC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 17:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1B320738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 17:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHBR4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 13:56:03 -0400
Received: from mailout09.rmx.de ([94.199.88.74]:38385 "EHLO mailout09.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHBR4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 13:56:03 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout09.rmx.de (Postfix) with ESMTPS id 4BKTG439Nszbjjp;
        Sun,  2 Aug 2020 19:55:56 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BKTFg5DStz2TRjk;
        Sun,  2 Aug 2020 19:55:35 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.16) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sun, 2 Aug
 2020 19:55:35 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Christian Eggers <ceggers@arri.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: at25: convert the binding document to yaml
Date:   Sun, 2 Aug 2020 19:46:26 +0200
Message-ID: <20200802174625.91809-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAL_JsqK+Oj5AMDv5uvtQZZ6YMBzVKBPqvTfAsXEbjWvxqubQnQ@mail.gmail.com>
References: <CAL_JsqK+Oj5AMDv5uvtQZZ6YMBzVKBPqvTfAsXEbjWvxqubQnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.16]
X-RMX-ID: 20200802-195535-4BKTFg5DStz2TRjk-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding document for at25 EEPROMs from txt to yaml. The
compatible property doesn't use a regex pattern (as in at24), because
the 'vendor' and the 'model' are an "infinite" list (even if only 5
combinations are found in the current dts files). The settings required
by a driver are given as separate properties.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
On Friday, Jul 31 2020, Rob Herring wrote:
>> On Tue, Jul 28, 2020 at 1:34 AM Christian Eggers <ceggers@arri.de> wrote:
>> When I specify
>>
>>   compatible:
>>     enum:
>>       - atmel,at25
>>
>> I get an error in dt_binding_check:
>> ...
>
> You can do:
>
> items:
>   - {}
>   - const: atmel,at25
>
> But really, the possible compatible strings need to be listed out. See
> at24.yaml as it had similar issues IIRC.

I think that at24 is very diffrent from at25 here (at least the linux
driver). Whilst the at24 driver extracts parameters of the chip from the
'model' part, at25 gets this information from separate properties.

As there is virtually an infinite list of possible vendors and products
for such type of hardware, is there any value to use expressions like in
the at24 binding?

Other question: What is the meaning of the maintainers field in the
binding? Is it related to the binding itself or the linux driver? I am
not the maintainer of the driver...


 .../devicetree/bindings/eeprom/at25.txt       |  46 +------
 .../devicetree/bindings/eeprom/at25.yaml      | 122 ++++++++++++++++++
 2 files changed, 123 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at25.yaml

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index fe91ecf1f61b..9b1096fb3826 100644
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
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
new file mode 100644
index 000000000000..437a28dab6fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -0,0 +1,122 @@
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
+  # item is fixed to "atmel,at25".
+  compatible:
+    items:
+      - {}
+      - const: atmel,at25
+    description:
+      'Should be "<vendor>,<chip>", and generic value "atmel,at25".
+      Example "<vendor>,<chip>" values:
+        "anvo,anv32e61w"
+        "microchip,25lc040"
+        "st,m95m02"
+        "st,m95256"'
+
+  reg:
+    description:
+      Chip select number.
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+      Maximum SPI frequency to use.
+
+  pagesize:
+    $ref: /schemas/types.yaml#definitions/uint32
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

