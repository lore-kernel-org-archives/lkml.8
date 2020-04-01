Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A02C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBBD206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9p4I7ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbgDALPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:15:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37693 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbgDALPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:15:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id i34so1836947pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iutfgAEMr3aVnETDGpH220S0Jcsh/zdk3Pb7ajXb/+Q=;
        b=J9p4I7ha9Kr4aCnjJUEmfgDuGIMxLJY57FMqgMrTxiyzl4NanfRaPU5YcNjC4r/WZL
         nk2/D0Tl7uXpOTYHkSP5WxMpGJk2c+vA+h23xv22k8NUNFpj50vfIIcD4gAJwOLIgx6a
         WS4B9SZwKrKwNUA+Bav04kd86EchZ0bJIdzsCORhN/TzCwYzny04tcFljyo8xk6IHdFP
         ev3xUa+1LKjHyvJrF75V+clg0uTz+3kBSb2zF9NHUwx1y1bB1Z15Xfh/dwudjdpdM0Uy
         Pu084v+RsFqNBd8Bu7PhOUvbd74pHJ026APLoYLdApY+mEFmewbWzx6YF/6Q8Vp7KoYa
         u5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iutfgAEMr3aVnETDGpH220S0Jcsh/zdk3Pb7ajXb/+Q=;
        b=J81Bipohw93ZIjD+3PfyqbyjKbpU9EXS6VgnTMTHYldg9saU2RrAAnWonksfRNhu64
         TU0KRbSXpHc8M8y+PNYeum+PpB9Taj11CEqN47DMHEMwiz9Il+mqMJSrtIm0nhKM17y8
         sO9hc5LQTui/D8qOSA6eHcKad8faTFBwE1m3Zqf0BHUhe5cJmaDW6Ae9vCqepFyXPv4G
         llCH56j9MoygnCRzX8oqSpGzw/ku/Di+Q0WLmYztLRa3wcugG3kke/biTlFT7BUjSIdm
         oylUaAYcpiasFerCGaGssjCX2f8xVqCkJIyJ/BylXTH6q+VKYfEimxTpMQ7zN/vFcLYD
         7niw==
X-Gm-Message-State: ANhLgQ1P4QvuvvokyQsKjx+BY/Y7mPUvr67H3lntg6cuicBpVlASiN6Z
        Z4JDRXQT7fzWamcFfgdr4/ILn9woaW8=
X-Google-Smtp-Source: ADFU+vszJlCQlH8uGs6tDDPH5jgNe2yuSVEB+jC8VaV64tQe6uSeKkPTUlv574C/T6c1WCdCf8PiKQ==
X-Received: by 2002:a65:5b49:: with SMTP id y9mr21836208pgr.153.1585739742212;
        Wed, 01 Apr 2020 04:15:42 -0700 (PDT)
Received: from localhost ([103.195.202.232])
        by smtp.gmail.com with ESMTPSA id u41sm1277117pgn.8.2020.04.01.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:15:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, lukasz.luba@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
Date:   Wed,  1 Apr 2020 16:45:26 +0530
Message-Id: <d1884aed542fdd5ac1178f7195fb7c189179c631.1585738725.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585738725.git.amit.kucheria@linaro.org>
References: <cover.1585738725.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of moving the thermal bindings to YAML, split it up into 3
bindings: thermal sensors, cooling devices and thermal zones.

The property #cooling-cells is required in each device that acts as a
cooling device - whether active or passive. So any device that can
throttle its performance to passively reduce heat dissipation (e.g.
cpus, gpus) and any device that can actively dissipate heat at different
levels (e.g. fans) will contain this property.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v3:
 - Clarify example by using cooling state numbers and a comment

 .../thermal/thermal-cooling-devices.yaml      | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
new file mode 100644
index 0000000000000..0dc4a743a1351
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright 2020 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal cooling device binding
+
+maintainers:
+  - Amit Kucheria <amitk@kernel.org>
+
+description: |
+  Thermal management is achieved in devicetree by describing the sensor hardware
+  and the software abstraction of cooling devices and thermal zones required to
+  take appropriate action to mitigate thermal overload.
+
+  The following node types are used to completely describe a thermal management
+  system in devicetree:
+   - thermal-sensor: device that measures temperature, has SoC-specific bindings
+   - cooling-device: device used to dissipate heat either passively or artively
+   - thermal-zones: a container of the following node types used to describe all
+     thermal data for the platform
+
+  This binding describes the cooling devices.
+
+  There are essentially two ways to provide control on power dissipation:
+    - Passive cooling: by means of regulating device performance. A typical
+      passive cooling mechanism is a CPU that has dynamic voltage and frequency
+      scaling (DVFS), and uses lower frequencies as cooling states.
+    - Active cooling: by means of activating devices in order to remove the
+      dissipated heat, e.g. regulating fan speeds.
+
+  Any cooling device has a range of cooling states (i.e. different levels of
+  heat dissipation). They also have a way to determine the state of cooling in
+  which the device is. For example, a fan's cooling states correspond to the
+  different fan speeds possible. Cooling states are referred to by single
+  unsigned integers, where larger numbers mean greater heat dissipation. The
+  precise set of cooling states associated with a device should be defined in
+  a particular device's binding.
+
+select: true
+
+properties:
+  "#cooling-cells":
+    description:
+        Must be 2, in order to specify minimum and maximum cooling state used in
+        the cooling-maps reference. The first cell is the minimum cooling state
+        and the second cell is the maximum cooling state requested.
+    const: 2
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/thermal/thermal.h>
+
+    // Example 1: Cpufreq cooling device on CPU0
+    cpus {
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            CPU0: cpu@0 {
+                    device_type = "cpu";
+                    compatible = "qcom,kryo385";
+                    reg = <0x0 0x0>;
+                    enable-method = "psci";
+                    cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+                                       &LITTLE_CPU_SLEEP_1
+                                       &CLUSTER_SLEEP_0>;
+                    capacity-dmips-mhz = <607>;
+                    dynamic-power-coefficient = <100>;
+                    qcom,freq-domain = <&cpufreq_hw 0>;
+                    #cooling-cells = <2>;
+                    next-level-cache = <&L2_0>;
+                    L2_0: l2-cache {
+                            compatible = "cache";
+                            next-level-cache = <&L3_0>;
+                            L3_0: l3-cache {
+                                    compatible = "cache";
+                            };
+                    };
+          };
+
+          /* ... */
+
+    };
+
+    /* ... */
+
+    thermal-zones {
+            cpu0-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+
+                    thermal-sensors = <&tsens0 1>;
+
+                    trips {
+                            cpu0_alert0: trip-point0 {
+                                    temperature = <90000>;
+                                    hysteresis = <2000>;
+                                    type = "passive";
+                            };
+                    };
+
+                    cooling-maps {
+                            map0 {
+                                    trip = <&cpu0_alert0>;
+                                    /* Corresponds to 1000MHz in OPP table */
+                                    cooling-device = <&CPU0 5 5>;
+                            };
+                    };
+            };
+
+            /* ... */
+    };
+...
-- 
2.20.1

