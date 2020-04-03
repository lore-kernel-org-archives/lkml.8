Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE78C2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC022077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Euy1XSbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403917AbgDCOZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:25:10 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33180 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403898AbgDCOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:25:08 -0400
Received: by mail-pj1-f65.google.com with SMTP id cp9so838530pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+a7470YaM4juMtdG/mmWqx5LDt9fs/5Ezk3ziKgHNt8=;
        b=Euy1XSbhBXZlxWg2kLJ3j8Dqqy89JPhBQZa3i7O2hmc/jOwqnMj8WF9RBq4OGnPPJo
         1uXe5MYwzOmLH2b3Q4f4fbtf/JCbpTNo1J8F+8rZL6Tj3WDF7XqAhhmMpkhMW+uJe/ZM
         ex9Nom/whawa0Q/6pAGK9odIawb/yn1/UJ+qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+a7470YaM4juMtdG/mmWqx5LDt9fs/5Ezk3ziKgHNt8=;
        b=eiAyzRWPtTPkITBm9HE6Zr0ze5MDmkVGeq60noR9kn9CTomPpoN5fX+hKW162unjaI
         XpoiHsghsjKw4nDgSf0UQd2fesdBzpn7GHgt3wYd/7gfgrsMLYeTb+9NGWgd9uF/DN8R
         6WQejbX+UUq7+UWxkRtpuwvvyZdycQh7Ug9FKBKu66I4IPNnrYkrrOSvOjE3CH8aYjad
         hs9UE/lph07sLDtH0ssGrmbMclVrwV+vqV5y3Z17pRGDzttEz2SSDqs8mVU77DHOETRI
         BsbY6jIg4eFrAeOgY7qtFPUnLQedSGRKE8IqYPKjWw+VNb3D9kpoOiZGeX+8muD7zEdD
         WpRw==
X-Gm-Message-State: AGi0PuZW6+zjgNMUdTrB1K7/J72Rn/+FHDJNLQpbrtPbriwtlQiVttVT
        dUuWidnqO7BtT5DcDEQnryRcOA==
X-Google-Smtp-Source: APiQypL8dcscZX5F9IW3XgDzsX1HyC2yPIEdigzQscKxJjzcocO/u9l5Afq31tHjvAMOUlDVHK/ACQ==
X-Received: by 2002:a17:902:8f87:: with SMTP id z7mr7339466plo.342.1585923906818;
        Fri, 03 Apr 2020 07:25:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9cd7:b821:2c84:e325])
        by smtp.gmail.com with ESMTPSA id g75sm5857060pje.37.2020.04.03.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:25:06 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/3] dt-bindings: display: panel: Convert sitronix,st7701 to DT schema
Date:   Fri,  3 Apr 2020 19:54:52 +0530
Message-Id: <20200403142453.25307-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403142453.25307-1-jagan@amarulasolutions.com>
References: <20200403142453.25307-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sitronix,st7701 panel bindings to DT schema.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- update the licence, used (GPL-2.0-only OR BSD-2-Clause) since
  I'm the author for old binding
- use panel-common.yaml
- mark true for common properties 
- use maxItems: 1 for reg
- update example
Changes for v2:
- fix dt_binding_check 

 .../display/panel/sitronix,st7701.txt         | 30 --------
 .../display/panel/sitronix,st7701.yaml        | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
deleted file mode 100644
index ccd17597f1f6..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Sitronix ST7701 based LCD panels
-
-ST7701 designed for small and medium sizes of TFT LCD display, is
-capable of supporting up to 480RGBX864 in resolution. It provides
-several system interfaces like MIPI/RGB/SPI.
-
-Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
-inbuilt ST7701 chip.
-
-Required properties:
-- compatible: must be "sitronix,st7701" and one of
-  * "techstar,ts8550b"
-- reset-gpios: a GPIO phandle for the reset pin
-
-Required properties for techstar,ts8550b:
-- reg: DSI virtual channel used by that screen
-- VCC-supply: analog regulator for MIPI circuit
-- IOVCC-supply: I/O system regulator
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-panel@0 {
-	compatible = "techstar,ts8550b", "sitronix,st7701";
-	reg = <0>;
-	VCC-supply = <&reg_dldo2>;
-	IOVCC-supply = <&reg_dldo2>;
-	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
-	backlight = <&backlight>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
new file mode 100644
index 000000000000..6dff59fe4be1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sitronix,st7701.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7701 based LCD panels
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+description: |
+  ST7701 designed for small and medium sizes of TFT LCD display, is
+  capable of supporting up to 480RGBX864 in resolution. It provides
+  several system interfaces like MIPI/RGB/SPI.
+
+  Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
+  inbuilt ST7701 chip.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - techstar,ts8550b
+      - const: sitronix,st7701
+
+  reg:
+    description: DSI virtual channel used by that screen
+    maxItems: 1
+
+  VCC-supply:
+    description: analog regulator for MIPI circuit
+
+  IOVCC-supply:
+    description: I/O system regulator
+
+  reset-gpios: true
+
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - VCC-supply
+  - IOVCC-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "techstar,ts8550b", "sitronix,st7701";
+            reg = <0>;
+            VCC-supply = <&reg_dldo2>;
+            IOVCC-supply = <&reg_dldo2>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            backlight = <&backlight>;
+        };
+    };
-- 
2.17.1

