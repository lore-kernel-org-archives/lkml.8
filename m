Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B0C11D25
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA24120578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUS+25+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgBXHZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:25:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39659 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgBXHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:25:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so3680829plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 23:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYyHTVUj+djldG9B+Pq0Lr60baNa5Q3EKWfIUDYwvYI=;
        b=bUS+25+867b++YN2nd8IBK/JhTNAEBklHGTNWPbyVyvNJQFtDBeBl9SuLqlQRBUqtZ
         KO4AgOX2vqG1ZV6GxAhNvLgCu/yGMeqlKGIGT/Ityt7Gp1IBonk5HgK73dU3vhZFtg+V
         s9qhgJSIOqVxd9J4M2TFCpQ1mMtZcOKLmh99rI8GwezuH93CfAcKNTuqgDfeRMdfRkbo
         0ZHj9lhAmuDJ9wxclGgcVg/QLC/K2ZLeeqr1RVItZX1hI9Oo6yWY1mj8qjCvW5Fp5fSE
         YYkRLwBbjLGUcw22BNASU3qR3rsNC91Sodgo7rsXS7pROp4MDqRuI2JcneHqGa9EO2cs
         ++kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYyHTVUj+djldG9B+Pq0Lr60baNa5Q3EKWfIUDYwvYI=;
        b=IMIHKgoqKCwiVgjaUC8daehWIw9+6MWkeMPZBaF/+j4HIjuMwQpESuc9mYc/5I8eT9
         tkutpRXap8Rrrh58LhW0UX46NDlngwqmBXdd6wOzQ5W74Tz1wtr8n7wJB/EO34uQdXGM
         Y5z3HfUN4R6rrUFX/iCCReLIpbdWpzrWSKbOTbqmH7aas18m5GKqr2uOQU62lkvcrZv/
         KIExJE6wa7igS42gwFhWqvi3DUsZ4HfKzf/QBi8drNMARE7IdHvZ7EMGXbt5Mf/lihYn
         hNwEcg+dhusyaa2kBbA9PP5BIWqQrfvMW1P+KCiOdT0Arol6dLdBKEzxYc/EMV+F4A38
         Ie4Q==
X-Gm-Message-State: APjAAAU1WhyH9hvwzZM8JGhJDLJdvOXfz09cWqnitF1OLNA2CYVrE5w3
        5tSx3WlZlUf9rj5oLYYyNh1kb+Ez+8s=
X-Google-Smtp-Source: APXvYqzg0kKF8BTBovQmtFgqeEY99Z43OtEGVmVRlMjzR8mFQBD7xUq/zK7JydZGK348jpC4EQTGpw==
X-Received: by 2002:a17:90a:cc16:: with SMTP id b22mr18402691pju.65.1582529146395;
        Sun, 23 Feb 2020 23:25:46 -0800 (PST)
Received: from localhost ([45.127.44.57])
        by smtp.gmail.com with ESMTPSA id e6sm11360524pfh.32.2020.02.23.23.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 23:25:45 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v1 1/3] dt-bindings: thermal: Add yaml bindings for thermal sensors
Date:   Mon, 24 Feb 2020 12:55:35 +0530
Message-Id: <11f9128efef92b427d93a563d5b53b62c4c01888.1582528977.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582528977.git.amit.kucheria@linaro.org>
References: <cover.1582528977.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of moving the thermal bindings to YAML, split it up into 3
bindings: thermal sensors, cooling devices and thermal zones.

The property #thermal-sensor-cells is required in each device that acts
as a thermal sensor. It is used to uniquely identify the instance of the
thermal sensor inside the system.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../bindings/thermal/thermal-sensor.yaml      | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
new file mode 100644
index 000000000000..ac32f54f2f98
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+# Copyright 2020 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal sensor binding
+
+maintainers:
+  - Amit Kucheria <amitk@kernel.org>
+
+description: |
+  Thermal management is achieved in devicetree by describing the sensor hardware
+  and the software abstraction of thermal zones required to take appropriate
+  action to mitigate thermal overloads.
+
+  The following node types are used to completely describe a thermal management
+  system in devicetree:
+   - thermal-sensor: device that measures temperature, has SoC-specific bindings
+   - cooling-device: device used to dissipate heat either passively or artively
+   - thermal-zones: a container of the following node types used to describe all
+     thermal data for the platform
+
+  This binding describes the thermal-sensor.
+
+  Thermal sensor devices provide temperature sensing capabilities on thermal
+  zones. Typical devices are I2C ADC converters and bandgaps. Thermal sensor
+  devices may control one or more internal sensors.
+
+properties:
+  "#thermal-sensor-cells":
+    description:
+      Used to uniquely identify a thermal sensor instance within an IC. Will be
+      0 on sensor nodes with only a single sensor and at least 1 on nodes
+      containing several internal sensors.
+    enum: [0, 1]
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    // Example 1: SDM845 TSENS
+    soc: soc@0 {
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            /* ... */
+
+            tsens0: thermal-sensor@c263000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
+                          <0 0x0c222000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <13>;
+                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow";
+                    #thermal-sensor-cells = <1>;
+            };
+
+            tsens1: thermal-sensor@c265000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
+                          <0 0x0c223000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <8>;
+                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow";
+                    #thermal-sensor-cells = <1>;
+            };
+    };
+...
-- 
2.20.1

