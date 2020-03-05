Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF468C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A069C206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Po0Vsebz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEW2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:28:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40582 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:28:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv19so190746pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ejcr5e0H1ZOIb/0woEIiOH3BL657SstawHp3iY3mX8o=;
        b=Po0VsebzNEvBV3q9RdifUWFGOSxfAD/QGcNuTF6JbgjtpLBSvpJrM0xin6pfF3x4vC
         B6rpGfVKcZWvxuXQLYjKTMZChf9KA8qOwnriD+ATgP07LMH0GNxal+Y7PcbgjU3kddh0
         /O7Mpz6fIx6jO3EpO4uqT6ATfAAfypDetOLNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ejcr5e0H1ZOIb/0woEIiOH3BL657SstawHp3iY3mX8o=;
        b=GTW79IB9u/my+GPSyTlakQ2bmg21vGMwYeFOLDPMTjQ4/liq0fbRd+Kk0c2oiA7VSG
         nG1Q/jDUk/ar6sgEeNodokjH4Nplvo0GOO2iatY9lafYH7htoVAIXkortx3oioV8Tyhl
         VyMbUVHEQFKAfTgcUTPBdy+011QYn12dsRvleY/TLlFhA6KbP/id9bp4w+ozdprg7z5S
         vV1wJ3FaJLyCroJptRxeKkJOMH2nSjEiJZ9kLkajkgwOkr9S3gK90vxYSawub1VAPnMh
         +gT1dLt0DzaknMPB1So0xJbjS3emN+V2kmd9MCf9ZaQeIeckvg0x8fkrQoOM64Hz+L2e
         DtiA==
X-Gm-Message-State: ANhLgQ3MP8AiFOgYZidGEVVGdF4NqBvFZ6fnjw2uVF1JQwWQTwrEEsRI
        O/lFeQMbry+UAM6+wAPJUqB27w==
X-Google-Smtp-Source: ADFU+vv2/oxhNNU3V212qUQdPMqJY5Y/K8T0vj9D5Uo4yAXduFD9Z7pU9/TjdxPx3hRHRTfLEecRQA==
X-Received: by 2002:a17:902:ec02:: with SMTP id l2mr120pld.184.1583447299519;
        Thu, 05 Mar 2020 14:28:19 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id c20sm17680952pfc.140.2020.03.05.14.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:28:18 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v3] dt-bindings: Convert usb-connector to YAML format.
Date:   Thu,  5 Mar 2020 14:27:28 -0800
Message-Id: <20200305222732.133047-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the usb-connector.txt bindings file to YAML format. This allows
it to be used in dt_bindings_check verification. This patch was
born out of a patch series for the addition of a Type C connector
class port driver[1].

An attempt has been made to maintain the same documentation text and
example structure as was in the .txt file, but wherever needed
modifications have been made to satisfy dt_bindings_check.

Also, update all references to usb-connector.txt to now use
usb-connector.yaml.

[1]: https://lkml.org/lkml/2020/2/19/1232

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v3:
- Updated maintainer list.
- Fixed grammatical errors in descriptions.
- Reworded "type" description based on review comments.
- Added more info to OF graph binding for port@2.
- Removed address from DT nodes in examples.

Changes in v2:
- Added type references for some properties.
- Removed pinctrl properties.
- Updated power-role, try-power-role and data-role properties to be in
  valid schema format.
- Added OF graph data bus binding property according to reviewer
  suggestions.

 .../connector/samsung,usb-connector-11pin.txt |   2 +-
 .../bindings/connector/usb-connector.txt      | 135 ------------
 .../bindings/connector/usb-connector.yaml     | 206 ++++++++++++++++++
 .../devicetree/bindings/usb/fcs,fusb302.txt   |   2 +-
 .../devicetree/bindings/usb/generic.txt       |   2 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt |   2 +-
 .../devicetree/bindings/usb/mediatek,musb.txt |   2 +-
 .../bindings/usb/richtek,rt1711h.txt          |   2 +-
 .../devicetree/bindings/usb/ti,hd3ss3220.txt  |   2 +-
 .../devicetree/bindings/usb/typec-tcpci.txt   |   2 +-
 .../devicetree/bindings/usb/usb-conn-gpio.txt |   4 +-
 11 files changed, 216 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.yaml

diff --git a/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
index 22256e295a7a1..3dd8961154abf 100644
--- a/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
+++ b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
@@ -19,7 +19,7 @@ Required nodes:
     0: High Speed (HS),
     3: Mobile High-Definition Link (MHL), specific to 11-pin Samsung micro-USB.
 
-[1]: bindings/connector/usb-connector.txt
+[1]: bindings/connector/usb-connector.yaml
 
 Example
 -------
diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
deleted file mode 100644
index 88578ac1a8a76..0000000000000
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-USB Connector
-=============
-
-A USB connector node represents a physical USB connector. It should be
-a child of a USB interface controller.
-
-Required properties:
-- compatible: describes type of the connector, must be one of:
-    "usb-a-connector",
-    "usb-b-connector",
-    "usb-c-connector".
-
-Optional properties:
-- label: symbolic name for the connector,
-- type: size of the connector, should be specified in case of USB-A, USB-B
-  non-fullsize connectors: "mini", "micro".
-- self-powered: Set this property if the usb device that has its own power
-  source.
-
-Optional properties for usb-b-connector:
-- id-gpios: an input gpio for USB ID pin.
-- vbus-gpios: an input gpio for USB VBUS pin, used to detect presence of
-  VBUS 5V.
-  see gpio/gpio.txt.
-- vbus-supply: a phandle to the regulator for USB VBUS if needed when host
-  mode or dual role mode is supported.
-  Particularly, if use an output GPIO to control a VBUS regulator, should
-  model it as a regulator.
-  see regulator/fixed-regulator.yaml
-- pinctrl-names : a pinctrl state named "default" is optional
-- pinctrl-0 : pin control group
-  see pinctrl/pinctrl-bindings.txt
-
-Optional properties for usb-c-connector:
-- power-role: should be one of "source", "sink" or "dual"(DRP) if typec
-  connector has power support.
-- try-power-role: preferred power role if "dual"(DRP) can support Try.SNK
-  or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
-- data-role: should be one of "host", "device", "dual"(DRD) if typec
-  connector supports USB data.
-
-Required properties for usb-c-connector with power delivery support:
-- source-pdos: An array of u32 with each entry providing supported power
-  source data object(PDO), the detailed bit definitions of PDO can be found
-  in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
-  Source_Capabilities Message, the order of each entry(PDO) should follow
-  the PD spec chapter 6.4.1. Required for power source and power dual role.
-  User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
-  defined in dt-bindings/usb/pd.h.
-- sink-pdos: An array of u32 with each entry providing supported power
-  sink data object(PDO), the detailed bit definitions of PDO can be found
-  in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
-  Sink Capabilities Message, the order of each entry(PDO) should follow
-  the PD spec chapter 6.4.1. Required for power sink and power dual role.
-  User can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
-  in dt-bindings/usb/pd.h.
-- op-sink-microwatt: Sink required operating power in microwatt, if source
-  can't offer the power, Capability Mismatch is set. Required for power
-  sink and power dual role.
-
-Required nodes:
-- any data bus to the connector should be modeled using the OF graph bindings
-  specified in bindings/graph.txt, unless the bus is between parent node and
-  the connector. Since single connector can have multiple data buses every bus
-  has assigned OF graph port number as follows:
-    0: High Speed (HS), present in all connectors,
-    1: Super Speed (SS), present in SS capable connectors,
-    2: Sideband use (SBU), present in USB-C.
-
-Examples
---------
-
-1. Micro-USB connector with HS lines routed via controller (MUIC):
-
-muic-max77843@66 {
-	...
-	usb_con: connector {
-		compatible = "usb-b-connector";
-		label = "micro-USB";
-		type = "micro";
-	};
-};
-
-2. USB-C connector attached to CC controller (s2mm005), HS lines routed
-to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
-DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
-
-ccic: s2mm005@33 {
-	...
-	usb_con: connector {
-		compatible = "usb-c-connector";
-		label = "USB-C";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				usb_con_hs: endpoint {
-					remote-endpoint = <&max77865_usbc_hs>;
-				};
-			};
-			port@1 {
-				reg = <1>;
-				usb_con_ss: endpoint {
-					remote-endpoint = <&usbdrd_phy_ss>;
-				};
-			};
-			port@2 {
-				reg = <2>;
-				usb_con_sbu: endpoint {
-					remote-endpoint = <&dp_aux>;
-				};
-			};
-		};
-	};
-};
-
-3. USB-C connector attached to a typec port controller(ptn5110), which has
-power delivery support and enables drp.
-
-typec: ptn5110@50 {
-	...
-	usb_con: connector {
-		compatible = "usb-c-connector";
-		label = "USB-C";
-		power-role = "dual";
-		try-power-role = "sink";
-		source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
-		sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
-			     PDO_VAR(5000, 12000, 2000)>;
-		op-sink-microwatt = <10000000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
new file mode 100644
index 0000000000000..4638d7adb806a
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -0,0 +1,206 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/usb-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB Connector
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description:
+  A USB connector node represents a physical USB connector. It should be a child
+  of a USB interface controller.
+
+properties:
+  compatible:
+    enum:
+      - usb-a-connector
+      - usb-b-connector
+      - usb-c-connector
+
+  label:
+    description: Symbolic name for the connector.
+
+  type:
+    description: Size of the connector, should be specified in case of
+      non-fullsize 'usb-a-connector' or 'usb-b-connector' compatible
+      connectors.
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/string
+    enum:
+      - mini
+      - micro
+
+  self-powered:
+    description: Set this property if the USB device has its own power source.
+    type: boolean
+
+  # The following are optional properties for "usb-b-connector".
+  id-gpios:
+    description: An input gpio for USB ID pin.
+    maxItems: 1
+
+  vbus-gpios:
+    description: An input gpio for USB VBus pin, used to detect presence of
+      VBUS 5V.
+    maxItems: 1
+
+  vbus-supply:
+    description: A phandle to the regulator for USB VBUS if needed when host
+      mode or dual role mode is supported.
+      Particularly, if use an output GPIO to control a VBUS regulator, should
+      model it as a regulator. See bindings/regulator/fixed-regulator.yaml
+
+  # The following are optional properties for "usb-c-connector".
+  power-role:
+    description: Determines the power role that the Type C connector will
+      support. "dual" refers to Dual Role Port (DRP).
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/string
+    enum:
+      - source
+      - sink
+      - dual
+
+  try-power-role:
+    description: Preferred power role.
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/string
+    enum:
+     - source
+     - sink
+     - dual
+
+  data-role:
+    description: Data role if Type C connector supports USB data. "dual" refers
+      Dual Role Device (DRD).
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/string
+    enum:
+      - host
+      - device
+      - dual
+
+  # The following are optional properties for "usb-c-connector" with power
+  # delivery support.
+  source-pdos:
+    description: An array of u32 with each entry providing supported power
+      source data object(PDO), the detailed bit definitions of PDO can be found
+      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
+      Source_Capabilities Message, the order of each entry(PDO) should follow
+      the PD spec chapter 6.4.1. Required for power source and power dual role.
+      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
+      defined in dt-bindings/usb/pd.h.
+    minItems: 1
+    maxItems: 7
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  sink-pdos:
+    description: An array of u32 with each entry providing supported power sink
+      data object(PDO), the detailed bit definitions of PDO can be found in
+      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
+      Sink Capabilities Message, the order of each entry(PDO) should follow the
+      PD spec chapter 6.4.1. Required for power sink and power dual role. User
+      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+      in dt-bindings/usb/pd.h.
+    minItems: 1
+    maxItems: 7
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  op-sink-microwatt:
+    description: Sink required operating power in microwatt, if source can't
+      offer the power, Capability Mismatch is set. Required for power sink and
+      power dual role.
+
+  ports:
+    description: OF graph bindings (specified in bindings/graph.txt) that model
+      any data bus to the connector unless the bus is between parent node and
+      the connector. Since a single connector can have multiple data buses every
+      bus has an assigned OF graph port number as described below.
+    type: object
+    properties:
+      port@0:
+        type: object
+        description: High Speed (HS), present in all connectors.
+
+      port@1:
+        type: object
+        description: Super Speed (SS), present in SS capable connectors.
+
+      port@2:
+        type: object
+        description: Sideband Use (SBU), present in USB-C. This describes the
+          alternate mode connection of which SBU is a part.
+
+    required:
+      - port@0
+
+required:
+  - compatible
+
+examples:
+  # Micro-USB connector with HS lines routed via controller (MUIC).
+  - |+
+    muic-max77843 {
+      usb_con1: connector {
+        compatible = "usb-b-connector";
+        label = "micro-USB";
+        type = "micro";
+      };
+    };
+
+  # USB-C connector attached to CC controller (s2mm005), HS lines routed
+  # to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
+  # DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
+  - |+
+    ccic: s2mm005 {
+      usb_con2: connector {
+        compatible = "usb-c-connector";
+        label = "USB-C";
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            usb_con_hs: endpoint {
+              remote-endpoint = <&max77865_usbc_hs>;
+            };
+          };
+          port@1 {
+            reg = <1>;
+            usb_con_ss: endpoint {
+              remote-endpoint = <&usbdrd_phy_ss>;
+            };
+          };
+          port@2 {
+            reg = <2>;
+            usb_con_sbu: endpoint {
+              remote-endpoint = <&dp_aux>;
+            };
+          };
+        };
+      };
+    };
+
+  # USB-C connector attached to a typec port controller(ptn5110), which has
+  # power delivery support and enables drp.
+  - |+
+    #include <dt-bindings/usb/pd.h>
+    typec: ptn5110 {
+      usb_con3: connector {
+        compatible = "usb-c-connector";
+        label = "USB-C";
+        power-role = "dual";
+        try-power-role = "sink";
+        source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+        sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
+                     PDO_VAR(5000, 12000, 2000)>;
+        op-sink-microwatt = <10000000>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
index ba2e32d500c02..60e4654297af7 100644
--- a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
+++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
@@ -9,7 +9,7 @@ Required sub-node:
 - connector : The "usb-c-connector" attached to the FUSB302 IC. The bindings
   of the connector node are specified in:
 
-	Documentation/devicetree/bindings/connector/usb-connector.txt
+	Documentation/devicetree/bindings/connector/usb-connector.yaml
 
 
 Example:
diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index e6790d2a4da9b..474e74c06522d 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -34,7 +34,7 @@ Optional properties:
  - usb-role-switch: boolean, indicates that the device is capable of assigning
 			the USB data role (USB host or USB device) for a given
 			USB connector, such as Type-C, Type-B(micro).
-			see connector/usb-connector.txt.
+			see connector/usb-connector.yaml.
 
 This is an attribute to a USB controller such as:
 
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index e0ae6096f7ac8..a82ca438aec1f 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -34,7 +34,7 @@ Optional properties:
 	dual-role mode.
 	it's considered valid for compatibility reasons, not allowed for
 	new bindings, and put into a usb-connector node.
-	see connector/usb-connector.txt.
+	see connector/usb-connector.yaml.
  - pinctrl-names : a pinctrl state named "default" is optional, and need be
 	defined if auto drd switch is enabled, that means the property dr_mode
 	is set as "otg", and meanwhile the property "mediatek,enable-manual-drd"
diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
index 2b8a87c90d9ea..5eedb02965622 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,musb.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
@@ -23,7 +23,7 @@ Optional properties:
                      MTCMOS
 
 Required child nodes:
- usb connector node as defined in bindings/connector/usb-connector.txt
+ usb connector node as defined in bindings/connector/usb-connector.yaml
 Optional properties:
  - id-gpios        : input GPIO for USB ID pin.
  - vbus-gpios      : input GPIO for USB VBUS pin.
diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
index e3fc57e605ed6..6f8115db2ea9b 100644
--- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
@@ -9,7 +9,7 @@ Required properties:
 Required sub-node:
 - connector: The "usb-c-connector" attached to the tcpci chip, the bindings
   of connector node are specified in
-  Documentation/devicetree/bindings/connector/usb-connector.txt
+  Documentation/devicetree/bindings/connector/usb-connector.yaml
 
 Example :
 rt1711h@4e {
diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
index 25780e945b154..2bd21b22ce95b 100644
--- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
+++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
@@ -9,7 +9,7 @@ Required sub-node:
  - connector: The "usb-c-connector" attached to the hd3ss3220 chip. The
    bindings of the connector node are specified in:
 
-	Documentation/devicetree/bindings/connector/usb-connector.txt
+	Documentation/devicetree/bindings/connector/usb-connector.yaml
 
 Example:
 hd3ss3220@47 {
diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
index 0dd1469e73180..2082522b1c326 100644
--- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
+++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
@@ -13,7 +13,7 @@ Required properties:
 Required sub-node:
 - connector: The "usb-c-connector" attached to the tcpci chip, the bindings
   of connector node are specified in
-  Documentation/devicetree/bindings/connector/usb-connector.txt
+  Documentation/devicetree/bindings/connector/usb-connector.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
index 3d05ae56cb0dc..ec80641208a53 100644
--- a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
+++ b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
@@ -8,11 +8,11 @@ Required properties:
 - compatible : should include "gpio-usb-b-connector" and "usb-b-connector".
 - id-gpios, vbus-gpios : input gpios, either one of them must be present,
 	and both can be present as well.
-	see connector/usb-connector.txt
+	see connector/usb-connector.yaml
 
 Optional properties:
 - vbus-supply : can be present if needed when supports dual role mode.
-	see connector/usb-connector.txt
+	see connector/usb-connector.yaml
 
 - Sub-nodes:
 	- port : can be present.
-- 
2.25.0.265.gbab2e86ba0-goog

