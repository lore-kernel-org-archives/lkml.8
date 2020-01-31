Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96720C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672A4206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FuaxnXUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgAaCes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:34:48 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49089 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgAaCer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:34:47 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1C9138365B;
        Fri, 31 Jan 2020 15:34:41 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580438081;
        bh=6tDJYJw6qyBxE5gbUdGqb3erz1PiKAMuHxH5IXgdldk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FuaxnXUY5/qpeLbWswkfNIKKSZuUjBu12k6kZSbWGXnRys0RHIODHz/1Vdjh3zq/W
         DKbhc3QuGFoM976BpBHIKn43jqNJKuozpFeFSeTifv796Yb+PTAkHMPfQSo2tnncFy
         HaDKiJtlvXnE005mk1/83nip5StliLq5kjTKAHj5qMO3vq3u5Qj5wwzyjexR8Mtd81
         m/vwC+DRLXBWagapbxBa0v2QxuG7R9mEgVuQOtUB3WyV5XujXvDOzpC1XvMvJ/KKxz
         VqRBNqHTUhqyRPaBjATFSv5qJ8eVM1smShjSdXnhfjFeGUnwY8+AlX3qpvTwiuI0Gt
         eGMwwDHYvJUxw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e3392410001>; Fri, 31 Jan 2020 15:34:41 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id C501413EED4;
        Fri, 31 Jan 2020 15:34:40 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id EACDC280071; Fri, 31 Jan 2020 15:34:40 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date:   Fri, 31 Jan 2020 15:34:32 +1300
Message-Id: <20200131023433.12133-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz>
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the spi-mux driver. This allows a generic
multiplexer to be used to provide access to multiple SPI devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - make dt_binding_check clean (properly this time)
   =20
    Changes in v2:
    - update license
    - make dt_binding_check clean

 .../devicetree/bindings/spi/spi-mux.yaml      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documen=
tation/devicetree/bindings/spi/spi-mux.yaml
new file mode 100644
index 000000000000..0ae692dc28b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic SPI Multiplexer
+
+description: |
+  This binding describes a SPI bus multiplexer to route the SPI chip sel=
ect
+  signals. This can be used when you need more devices than the SPI cont=
roller
+  has chip selects available. An example setup is shown in ASCII art; th=
e actual
+  setting of the multiplexer to a channel needs to be done by a specific=
 SPI mux
+  driver.
+
+        MOSI /--------------------------------+--------+--------+-------=
-\
+        MISO |/------------------------------+|-------+|-------+|-------=
\|
+         SCL ||/----------------------------+||------+||------+||------\=
||
+             |||                            |||      |||      |||      |=
||
+      +------------+                        |||      |||      |||      |=
||
+      | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+=
++-+
+      |      |||   |                      | dev |  | dev |  | dev |  | d=
ev |
+      |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--=
+--+
+      |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        =
|
+      |   +------+ |       +--+---+\\\-------/   CS-1 |        |        =
|
+      |            |          |    \\\----------------/   CS-2 |        =
|
+      |   +------+ |          |     \\-------------------------/   CS-3 =
|
+      |   | ?    +-|----------/      \----------------------------------=
/
+      |   +------+ |
+      +------------+
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  compatible:
+    const: spi-mux
+
+  mux-controls:
+    maxItems: 1
+
+required:
+   - compatible
+   - reg
+   - spi-max-frequency
+   - mux-controls
+
+examples:
+   - |
+     #include <dt-bindings/gpio/gpio.h>
+     mux: mux-controller {
+       compatible =3D "gpio-mux";
+       #mux-control-cells =3D <0>;
+
+       mux-gpios =3D <&gpio0 3 GPIO_ACTIVE_HIGH>;
+     };
+
+     spi {
+       #address-cells =3D <1>;
+       #size-cells =3D <0>;
+       spi@0 {
+         compatible =3D "spi-mux";
+         reg =3D <0>;
+         #address-cells =3D <1>;
+         #size-cells =3D <0>;
+         spi-max-frequency =3D <100000000>;
+
+         mux-controls =3D <&mux>;
+
+         spi-flash@0 {
+           compatible =3D "jedec,spi-nor";
+           reg =3D <0>;
+           #address-cells =3D <1>;
+           #size-cells =3D <0>;
+           spi-max-frequency =3D <40000000>;
+         };
+
+         spi-device@1 {
+           compatible =3D "lineartechnology,ltc2488";
+           reg =3D <1>;
+           #address-cells =3D <1>;
+           #size-cells =3D <0>;
+           spi-max-frequency =3D <10000000>;
+         };
+       };
+     };
--=20
2.25.0

