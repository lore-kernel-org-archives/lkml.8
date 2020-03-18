Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E13C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9D92076A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCRHHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:07:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRHHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:07:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0C0FD292457
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, icenowy@aosc.io,
        anarsoul@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        megous@megous.com, Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: Add binding for the Analogix ANX7688 chip
Date:   Wed, 18 Mar 2020 08:07:27 +0100
Message-Id: <20200318070730.4012371-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ANX7688 chip is a Type-C Port Controller, HDMI to DP converter and
USB-C mux between USB 3.0 lanes and the DP output.

For our use case a big part of the chip, like power supplies, control
gpios and the usb-c part is managed by an Embedded Controller, hence,
this is its simplest form of the binding. We'd prefer introduce these
properties for someone with a different use case so they can test
on their hardware.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4: None
Changes in v3:
- Add binding for ANX7688 multi-function device.

Changes in v2: None

 .../bindings/mfd/analogix,anx7688.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml

diff --git a/Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml b/Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml
new file mode 100644
index 000000000000..bb95a4e87188
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/analogix,anx7688.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analogix ANX7688 HDMI to USB Type-C Bridge (Port Controller with MUX)
+
+maintainers:
+  - Nicolas Boichat <drinkcat@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  ANX7688 converts HDMI 2.0 to DisplayPort 1.3 Ultra-HDi (4096x2160p60)
+  including an intelligent crosspoint switch to support USB Type-C (USB-C).
+  The integrated crosspoint switch supports USB 3.1 data transfer along with
+  the DisplayPort Alternate Mode signaling over USB Type-C. Additionally,
+  an on-chip microcontroller (OCM) is available to manage the signal switching,
+  Channel Configuration (CC) detection, USB Power Delivery (USB-PD), Vendor
+  Defined Message (VDM) protocol support and other functions as defined in the
+  USB TypeC and USB Power Delivery specifications.
+
+  As a result, a multi-function device is exposed as parent of the video
+  bridge, TCPC and MUX blocks.
+
+properties:
+  compatible:
+    const: analogix,anx7688
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        anx7688: anx7688@2c {
+            compatible = "analogix,anx7688";
+            reg = <0x2c>;
+        };
+    };
-- 
2.25.1

