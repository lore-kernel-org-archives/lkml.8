Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA1AC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C741221655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W40z0Rg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgCKJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:50:53 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38157 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgCKJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:50:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so47034pje.3;
        Wed, 11 Mar 2020 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gMxAacWfBtp0/RJtSrae2q7ULd3xlhV0qXYwkL9Z+8o=;
        b=W40z0Rg+x5Ajncf+ctlE6UF2o6FvQmCQtnhwJec++Syw6ttaYsDEeI0tcsYThpz0KS
         CJXTStgfNBTY8EQGZx/MkcciN84KKo8Mio7eFViFSdO4GB+YlMa6nMbnWcdftRfhg/qY
         INBdeh3H3COJqX+D52gQY0I7Gjf7ZQYc2Sa74yPtvUPGJAdSlhrOysjZ/QODSC5Sg/Ou
         nKz/Hi3nGO8TV6r5SZrOQK7Da7rU4s46W5P7D/mNZaycGghcoJqiMC0HklhzL+DXhfff
         uq6hT2E3+BQczL9FIK1t7esuB8n3bhPJTjZH0V+DAmv3oogB7jrWV8AjZ/JyMwagi8hk
         2nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gMxAacWfBtp0/RJtSrae2q7ULd3xlhV0qXYwkL9Z+8o=;
        b=G54LupYuq9wAmDCAR6gTWNYpSahnuxfoukBPBDqudpxJcpZW+NQH7LavBdHmWziNuE
         OZ7Mu/dG5pkowG1Xls64CQojMkgX2/i+8Q5Tn4jBgNKWyj0MIj3QtdIpNHJRSTur2wvq
         wacDhDs1XkbqO+QitdfHnC8LWcJXG9x0Z7YC2bmWRCL3OsFGXuwjmvLWycp8eHT5mncZ
         v11N0UF14VPwm7mWi8VvpSyzAG4CJS9Q6OAxnR6eWn1xoyqzTvou0aG18eh6uHU8clI8
         H6gD6i/isN/vkm115QWxs7rr4DNM3CYmW+h5BzaIWmBtcgNiPamv3i6lEeo4TfdIHeLv
         ThZw==
X-Gm-Message-State: ANhLgQ0sgVELVfB7rQYy4GAwJao+uNw+jQKkgd5tsXBY9DkiPA03CR8F
        rgx4IFHcaTsCh0s0YJDL2Ek=
X-Google-Smtp-Source: ADFU+vv0I7q2bLlo96SUvH8JddfaQ9+6pxLvBrC5NwQyuTElyRJsdv+ONcR8L/mGhopapI04ZQy+7g==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr2373121pll.88.1583920252132;
        Wed, 11 Mar 2020 02:50:52 -0700 (PDT)
Received: from inforce-server-Z9PE-D8-WS.routereb3c90.com ([106.51.138.45])
        by smtp.gmail.com with ESMTPSA id w25sm49919222pfi.106.2020.03.11.02.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Mar 2020 02:50:51 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-binding: Add DSI/LVDS tc358775 bridge bindings
Date:   Wed, 11 Mar 2020 15:18:24 +0530
Message-Id: <1583920112-2680-1-git-send-email-simhavcs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yaml documentation for DSI/LVDS tc358775 bridge

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

---
v1:
 Initial version
---
 .../bindings/display/bridge/toshiba-tc358775.yaml  | 174 +++++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
new file mode 100644
index 0000000..e9a9544
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/toshiba-tc358775.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+
+title: Toshiba TC358775 DSI to LVDS bridge bindings
+
+maintainers:
+	- Vinay Simha BN <simhavcs@gmail.com>
+
+description: |
+	This binding supports DSI to LVDS bridge TC358775
+
+properties:
+ compatible:
+	const: toshiba,tc358775
+
+ reg:
+   maxItems: 1
+   description: i2c address of the bridge, 0x0f
+
+ tc, dsi-lanes: 1
+   maxItems: 1
+   description: Number of DSI data lanes connected to the DSI host. It should
+  be one of 1, 2, 3 or 4.
+
+ tc, dual-link: 1
+   maxItems: 1
+   description: To configure the LVDS transmitter either as single-link or dual-link.
+
+ vdd-supply:
+   maxItems: 1
+   description:  1.2V LVDS Power Supply
+
+ vddio-supply:
+   maxItems: 1
+   description: 1.8V IO Power Supply
+
+ stby-gpios:
+   maxItems: 1
+   description: Standby pin, Low active
+
+ reset-gpios:
+   maxItems: 1
+   description: Hardware reset, Low active
+
+ ports:
+   type: object
+
+    properties:
+      port@0:
+        type: object
+        description: |
+          DSI Input. The remote endpoint phandle should be a
+	  reference to a valid mipi_dsi_host device node.
+      port@1:
+        type: object
+        description: |
+          Video port for LVDS output (panel or connector).
+
+      required:
+      - port@0
+      - port@1
+
+required:
+ - compatible
+ - reg
+ - dsi-lanes
+ - vdd-supply
+ - vddio-supply
+ - stby-gpios
+ - reset-gpios
+ - ports
+
+examples:
+ - |
+   i2c@78b8000 {
+	/* On High speed expansion */
+	label = "HS-I2C2";
+	status = "okay";
+
+	tc_bridge: bridge@f {
+		status = "okay";
+
+		compatible = "toshiba,tc358775";
+		reg = <0x0f>;
+
+		tc,dsi-lanes = <4>;
+		tc,dual-link = <0>;
+
+		vdd-supply = <&pm8916_l2>;
+		vddio-supply = <&pm8916_l6>;
+
+		stby-gpio = <&msmgpio 99 GPIO_ACTIVE_LOW>;
+		reset-gpio = <&msmgpio 72 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				d2l_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				d2l_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
+  };
+
+  panel: auo,b101xtn01 {
+		status = "okay";
+		compatible = "auo,b101xtn01", "panel-lvds";
+		power-supply = <&pm8916_l14>;
+
+		width-mm = <223>;
+		height-mm = <125>;
+
+		data-mapping = "jeida-24";
+
+		panel-timing {
+			/* 1366x768 @60Hz */
+			clock-frequency = <72000000>;
+			hactive = <1366>;
+			vactive = <768>;
+			hsync-len = <70>;
+			hfront-porch = <20>;
+			hback-porch = <0>;
+			vsync-len = <42>;
+			vfront-porch = <14>;
+			vback-porch = <0>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&d2l_out>;
+			};
+		};
+ };
+
+  mdss@1a00000 {
+	status = "okay";
+
+	mdp@1a01000 {
+		status = "okay";
+	};
+
+	dsi@1a98000 {
+		status = "okay";
+		..
+		ports {
+			port@1 {
+				dsi0_out: endpoint {
+					remote-endpoint = <&d2l_in>;
+					data-lanes = <0 1 2 3>;
+				};
+			};
+		};
+	};
+
+	dsi-phy@1a98300 {
+		status = "okay";
+		..
+	};
+ };
-- 
2.7.4

