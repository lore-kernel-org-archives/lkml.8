Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43194C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDB12192A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Fx68tUzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBWNOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:14:51 -0500
Received: from vps.xff.cz ([195.181.215.36]:42654 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgBWNOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582463688; bh=54xRUvTGkyMdNnk2rkB4/jjx5Pxs9Bu2zPWHTbo071c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Fx68tUzrMaT6Zx3ogeXuS/EuwQ/VR0ubxBgXvpNRbq2SWOrAY0bPpSM9f1lhlSbYu
         kAuBvr+0OHOjhyVClPIvqc247aXGz9ytldoXD4bs6Drr632oAP4KbvS9dfjDYXU5bd
         ih4c6a4n5lWwEzMwvrMJMsmKmEgPythG0hxvhEDM=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: leds: Add a binding for AXP813 charger led
Date:   Sun, 23 Feb 2020 14:14:32 +0100
Message-Id: <20200223131435.681620-2-megous@megous.com>
In-Reply-To: <20200223131435.681620-1-megous@megous.com>
References: <20200223131435.681620-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP813 PMIC can control one LED. Add binding to represent the LED.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../devicetree/bindings/leds/leds-axp20x.yaml | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.yaml b/Documentation/devicetree/bindings/leds/leds-axp20x.yaml
new file mode 100644
index 0000000000000..79282d55764bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-axp20x.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-axp20x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for AXP813 PMIC from X-Powers.
+
+maintainers:
+  - Ondrej Jirman <megous@megous.com>
+
+description: |
+  This module is part of the AXP20x MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/axp20x.txt.
+
+  The LED controller is represented as a sub-node of the PMIC node on
+  the device tree.
+
+properties:
+  compatible:
+    const: x-powers,axp813-charger-led
+
+required:
+  - compatible
-- 
2.25.1

