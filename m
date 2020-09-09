Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB3C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA85F2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIIH5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:57:00 -0400
Received: from mail.v3.sk ([167.172.186.51]:48628 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgIIH4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:56:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 23933DF930;
        Wed,  9 Sep 2020 07:55:35 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wWl66GxIz-h2; Wed,  9 Sep 2020 07:55:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 41254DF974;
        Wed,  9 Sep 2020 07:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eY-Om9O-9_Lx; Wed,  9 Sep 2020 07:55:34 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id EA5EDDF930;
        Wed,  9 Sep 2020 07:55:33 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: display: himax,hx8837: Add Himax HX8837 bindings
Date:   Wed,  9 Sep 2020 09:56:48 +0200
Message-Id: <20200909075649.1100300-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909075649.1100300-1-lkundrak@v3.sk>
References: <20200909075649.1100300-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Himax HX8837 is a secondary display controller used to drive the panel
on OLPC platforms.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v4:
- Rob's Reviewed-by

Changes since v3:
- Moved to bindings/display/
- Added the ports
- Converted to YAML
- Removed Pavel's Ack, because the changes are substantial

Changes since v2:
- s/betweend/between/

Changes since v1:
- s/load-gpio/load-gpios/
- Use interrupt bindings instead of gpio for the IRQ

 .../bindings/display/bridge/himax,hx8837.yaml | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/hima=
x,hx8837.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/himax,hx883=
7.yaml b/Documentation/devicetree/bindings/display/bridge/himax,hx8837.ya=
ml
new file mode 100644
index 0000000000000..f5b0a00f5089d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/himax,hx8837.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2018,2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/himax,hx8837.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HX8837 Display Controller Device Tree Bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: himax,hx8837
+
+  reg:
+    const: 0xd
+
+  load-gpios:
+    maxItems: 1
+    description: GPIO specifier of DCON_LOAD pin (active high)
+
+  stat-gpios:
+    minItems: 2
+    description: GPIO specifier of DCON_STAT0 and DCON_STAT1 pins (activ=
e high)
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt specifier of DCON_IRQ pin (edge falling)
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description: |
+          Video port for RGB input.
+
+      port@1:
+        type: object
+        description: |
+          Video port connected to the panel.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - load-gpios
+  - stat-gpios
+  - interrupts
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+       =20
+        lcd-controller@d {
+            compatible =3D "himax,hx8837";
+            reg =3D <0x0d>;
+            stat-gpios =3D <&gpio 100 GPIO_ACTIVE_HIGH>,
+                         <&gpio 101 GPIO_ACTIVE_HIGH>;
+            load-gpios =3D <&gpio 142 GPIO_ACTIVE_HIGH>;
+            interrupts =3D <&gpio 124 IRQ_TYPE_EDGE_FALLING>;
+   =20
+            ports {
+                #address-cells =3D <0x01>;
+                #size-cells =3D <0x00>;
+   =20
+                port@0 {
+                    reg =3D <0x00>;
+                    dcon_rgb_in: endpoint {
+                        remote-endpoint =3D <&lcd0_rgb_out>;
+                    };
+                };
+   =20
+                port@1 {
+                    reg =3D <0x01>;
+                    dcon_gettl_out: endpoint {
+                        remote-endpoint =3D <&panel_dettl_in>;
+                    };
+                };
+            };
+        };
+    };
--=20
2.26.2

