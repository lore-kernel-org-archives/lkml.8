Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD35C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFFB20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCOBg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:36:28 -0400
Received: from mail.v3.sk ([167.172.186.51]:54310 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbgCOBfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:35:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B6D06E0211;
        Sat, 14 Mar 2020 10:16:55 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QtgEdfX4CAdx; Sat, 14 Mar 2020 10:16:53 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A9C69E020B;
        Sat, 14 Mar 2020 10:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qhBQUlD3JXul; Sat, 14 Mar 2020 10:16:52 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5F1D2DFF03;
        Sat, 14 Mar 2020 10:16:52 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: display: Add Chrontel CH7033 Video Encoder binding
Date:   Sat, 14 Mar 2020 11:16:26 +0100
Message-Id: <20200314101627.336939-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200314101627.336939-1-lkundrak@v3.sk>
References: <20200314101627.336939-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the Chrontel CH7033 VGA/DVI/HDMI Encoder.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v3:
- Fixed the example so that it validates

Changes since v1:
- Dual licensed with BSD-2-Clause
- Collected Rob's reviewed-by tag

 .../display/bridge/chrontel,ch7033.yaml       | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chro=
ntel,ch7033.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/chrontel,ch=
7033.yaml b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7=
033.yaml
new file mode 100644
index 0000000000000..9f38f55fc9904
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.ya=
ml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/chrontel,ch7033.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chrontel CH7033 Video Encoder Device Tree Bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: chrontel,ch7033
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device
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
+          DVI port, should be connected to a node compatible with the
+          dvi-connector binding.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        vga-dvi-encoder@76 {
+            compatible =3D "chrontel,ch7033";
+            reg =3D <0x76>;
+
+            ports {
+                #address-cells =3D <1>;
+                #size-cells =3D <0>;
+
+                port@0 {
+                    reg =3D <0>;
+                    endpoint {
+                        remote-endpoint =3D <&lcd0_rgb_out>;
+                    };
+                };
+
+                port@1 {
+                    reg =3D <1>;
+                    endpoint {
+                        remote-endpoint =3D <&dvi_in>;
+                    };
+                };
+
+            };
+        };
+    };
--=20
2.25.1

