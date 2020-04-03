Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF24DC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52F520857
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZMtQ3Z/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403893AbgDCOZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:25:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37565 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403868AbgDCOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:25:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id x1so2748565plm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vKBRMX/UzCOn34k/kAwE26KCgVenN+ytvHTmdWU7Okc=;
        b=ZMtQ3Z/uwSYiMhhw2nTl6CsbXXgH9xLLOhxQrgzJsrv3UW4kLSwgmTsE+7IuS36SVf
         nNr3S9XTiC1OASHDsk3Kjfy1pztgLDzzIXtliEDLztXZmr+sVH40xM7/Q9Gd23g7LO7t
         QfJPhwHti/wJtJsJ6E7HVd7ge9OGsfoe7PzWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vKBRMX/UzCOn34k/kAwE26KCgVenN+ytvHTmdWU7Okc=;
        b=fFzCqGfES/LtumpOuJQ+OnTpBrHMhWwVnkn/BWwDW3M1nDigFXFXzVWlgMuVtBevGe
         pWhL+VFToc5yGvF1zX2imxbr5WmqBEMubN9RHLeHereLQbkDgbzyJPVIMEwOzZw3pZFk
         IgJjOqSysNS3hwp8z87Zj9nCEug7Nm3wnYWrIkeni03+tGKx/AZNZso43rEyGiPruwQb
         TqJUYq08/h8ThFx+lftCyjemwWTBCPZK+QO5sS7+mKcOqCEjtEj6A1ABqRsBPFKDDgMa
         MHdI0GrzUztzLozRrfk26p73peY2EC+I6Z/6XOLGHp2EPPUf6ejCKqlDK6mS5cxp+T7h
         uLmw==
X-Gm-Message-State: AGi0Puak7OVvek8k1tWgmKiOcUx9ATATjH/wDOfUy1PnKNxRQOPquW6E
        rl12MfFESRXXtkajU3Cs2PlZrQ==
X-Google-Smtp-Source: APiQypK/FOTXW2tO2HaeGhqMJi79/X/DjEIrHqAV05vSXxlPqEGWtElSKJxS/FsqoFPl8lB1RiTSIg==
X-Received: by 2002:a17:90b:3615:: with SMTP id ml21mr10361300pjb.145.1585923902916;
        Fri, 03 Apr 2020 07:25:02 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9cd7:b821:2c84:e325])
        by smtp.gmail.com with ESMTPSA id g75sm5857060pje.37.2020.04.03.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:25:02 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/3] dt-bindings: display: panel: Convert feiyang,fy07024di26a30d to DT schema
Date:   Fri,  3 Apr 2020 19:54:51 +0530
Message-Id: <20200403142453.25307-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the feiyang,fy07024di26a30d panel bindings to DT schema.

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

 .../display/panel/feiyang,fy07024di26a30d.txt | 20 -------
 .../panel/feiyang,fy07024di26a30d.yaml        | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
deleted file mode 100644
index 82caa7b65ae8..000000000000
--- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
-
-Required properties:
-- compatible: must be "feiyang,fy07024di26a30d"
-- reg: DSI virtual channel used by that screen
-- avdd-supply: analog regulator dc1 switch
-- dvdd-supply: 3v3 digital regulator
-- reset-gpios: a GPIO phandle for the reset pin
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-panel@0 {
-	compatible = "feiyang,fy07024di26a30d";
-	reg = <0>;
-	avdd-supply = <&reg_dc1sw>;
-	dvdd-supply = <&reg_dldo2>;
-	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
-	backlight = <&backlight>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
new file mode 100644
index 000000000000..95acf9e96f1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/feiyang,fy07024di26a30d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: feiyang,fy07024di26a30d
+
+  reg:
+    description: DSI virtual channel used by that screen
+    maxItems: 1
+
+  avdd-supply:
+    description: analog regulator dc1 switch
+
+  dvdd-supply:
+    description: 3v3 digital regulator
+
+  reset-gpios: true
+
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
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
+            compatible = "feiyang,fy07024di26a30d";
+            reg = <0>;
+            avdd-supply = <&reg_dc1sw>;
+            dvdd-supply = <&reg_dldo2>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            backlight = <&backlight>;
+        };
+    };
-- 
2.17.1

