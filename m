Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA5CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187AF2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="v0lGJtOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgB2QSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:18:32 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43970 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgB2QSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582993109; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=lZfOPkwgE6nYYSnIfv4pFhy7q8haHYJZ5qG0aVOe4oU=;
        b=v0lGJtOJYKbBiHlWAzMord2ep9YNFVEXMg/a+IOzhRXD9a0Ye1ha/D3c8qeThq2Gz8dAWa
        EF/fW95Uyr6C0dbsM+UQ4ejmSx1a0JpqrEZvEO7KamBo9XqRhA6OMbAn0lgsnDaMYSGiTB
        /t+DJgzP5FRUtLo8HMvfLpxpQpcx6Hs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] dt-bindings: Document JZ4770 PHY bindings
Date:   Sat, 29 Feb 2020 13:18:19 -0300
Message-Id: <20200229161820.17824-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the devicetree bindings of the
Ingenic JZ4770 USB transceiver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 .../bindings/usb/ingenic,jz4770-phy.yaml      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml

diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml b/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
new file mode 100644
index 000000000000..a81b0b1a2226
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ingenic,jz4770-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic JZ4770 USB PHY devicetree bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  $nodename:
+    pattern: '^usb-phy@.*'
+
+  compatible:
+    enum:
+      - ingenic,jz4770-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  vcc-supply:
+    description: VCC power supply
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - vcc-supply
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4770-cgu.h>
+    otg_phy: usb-phy@3c {
+      compatible = "ingenic,jz4770-phy";
+      reg = <0x3c 0x10>;
+
+      vcc-supply = <&vcc>;
+      clocks = <&cgu JZ4770_CLK_OTG_PHY>;
+
+      #phy-cells = <0>;
+    };
-- 
2.25.1

