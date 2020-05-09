Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B0FC54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC91620A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=48.io header.i=@48.io header.b="x6raWZpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEIL1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:27:18 -0400
Received: from 48.io ([37.205.10.103]:60494 "EHLO pruto.48.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgEIL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:27:01 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2020 07:27:00 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pruto.48.io (Postfix) with ESMTPSA id 8B55A94C8D;
        Sat,  9 May 2020 13:18:10 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 8B55A94C8D
Authentication-Results: pruto.48.io; dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
        t=1589023090; bh=D3x6JnWefErO/TazipsOhJ7MREKFaWlPTxw8f1HkRrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=x6raWZpoEGEB1rMVVeudi3uDHkbdRcFBR3qdMfM94S2C+ipI5PRt8XPBWFQs7A65Z
         vX/YBgWpdK1EA+XdZV+W5yBx07ICHMsKIse+QhdqRwgplK+qCb3zqTHGklCV2Uh6/B
         JQYCGPudiqzcw+cABjV8xybSohSW5Nj30x3VZ68o=
From:   srk@48.io
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Richard Marko <srk@48.io>, Sean Cross <xobs@kosagi.com>
Subject: [PATCH 1/2] dt-bindings: it6251: add bindings for IT6251 LVDS-to-eDP bridge
Date:   Sat,  9 May 2020 13:17:31 +0200
Message-Id: <20200509111732.26102-2-srk@48.io>
In-Reply-To: <20200509111732.26102-1-srk@48.io>
References: <20200509111732.26102-1-srk@48.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

Add DT bindings for ITE IT6251 LVDS-to-eDP bridge.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Richard Marko <srk@48.io>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sean Cross <xobs@kosagi.com>
Cc: devicetree@vger.kernel.org
To: dri-devel@lists.freedesktop.org
---
 .../bindings/display/bridge/ite,it6251.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml
new file mode 100644
index 000000000000..8daa44a30fa1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ite,it6251.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ITE IT6251 LVDS-to-eDP bridge bindings
+
+maintainers:
+  - Marek Vasut <marex@denx.de>
+  - Richard Marko <srk@48.io>
+
+description: |
+  The IT6251 is a high-performance single-chip
+  De-SSC LVDS to DisplayPort converter.
+  Combined with LVDS receiver and DisplayPort Transmitter,
+  the IT6251 supports LVDS input and DisplayPort 1.1a
+  output by conversion function.
+
+properties:
+  compatible:
+    const: ite,it6251
+
+  reg:
+    items:
+      - description: I2C address of the bridge
+      - description: I2C address of the LVDS part
+
+  reg-names:
+    items:
+      - const: bridge
+      - const: lvds
+
+  ports:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description: |
+         Video port for eDP output (typically panel).
+
+      port@1:
+        type: object
+        description: |
+          Video port for LVDS input.
+
+    required:
+      - port@0
+      - port@1
+
+    additionalProperties: false
+
+  power-supply: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - power-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    it6251@5c {
+      compatible = "ite,it6251";
+      reg = <0x5c>, <0x5e>;
+      reg-names = "bridge", "lvds";
+      power-supply = <&reg_display>;
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          bridge_out_edp0: endpoint {
+            remote-endpoint = <&panel_in_edp0>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+          bridge_in_lvds0: endpoint {
+            remote-endpoint = <&lvds0_out>;
+          };
+        };
+      };
+    };
-- 
2.25.1

