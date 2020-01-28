Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B908C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BB124687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HXFaUv5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgA1IUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:20:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43514 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgA1IUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:20:33 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S8CWBu018839;
        Tue, 28 Jan 2020 09:20:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=7sMqxWd5lXQvkypn4E66JYHlpZmXuZ2B+QHR4mmj7Pk=;
 b=HXFaUv5vV7USw0zoakjnap62XQMcoyu7oaPnAodi0BgwVr9IIrBhtSphazQS5y1ZFKKK
 469m2LIlQoJdqXgHFBL43k/kpyK1YWH+O/GAIWtnGmXkDktHJ0wkBncQ+5U/Z3TPeAya
 +L37FuUuSHDDO3ibuznp010X8RRGIC3tI1qD4NfubS7tdJpyRbO6vbRnHRFj2uFMoche
 fM64xCF/8ShJGoly3PAtRY34MysEGw1pBebJ+lntcFFCDRsUBG0bcbpSZOQfZgluqO2C
 fGYqCJ6eA4iKzlo9hZLHFw2mzQggwT5fXr5SKHtdj1FfmFx/kC/i+FPLdT+Irp9/pxaL oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdekcmhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 09:20:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0EEEA100034;
        Tue, 28 Jan 2020 09:20:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA4922116D8;
        Tue, 28 Jan 2020 09:20:15 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 09:20:15
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <l.stach@pengutronix.de>, <linux+etnaviv@armlinux.org.uk>,
        <christian.gmeiner@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <etnaviv@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <philippe.cornu@st.com>, <pierre-yves.mordret@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2] dt-bindings: display: Convert etnaviv to json-schema
Date:   Tue, 28 Jan 2020 09:20:13 +0100
Message-ID: <20200128082013.15951-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert etnaviv bindings to yaml format.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/display/etnaviv/etnaviv-drm.txt       | 36 -----------
 .../devicetree/bindings/gpu/vivante,gc.yaml        | 72 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/vivante,gc.yaml

diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
deleted file mode 100644
index 8def11b16a24..000000000000
--- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Vivante GPU core devices
-========================
-
-Required properties:
-- compatible: Should be "vivante,gc"
-  A more specific compatible is not needed, as the cores contain chip
-  identification registers at fixed locations, which provide all the
-  necessary information to the driver.
-- reg: should be register base and length as documented in the
-  datasheet
-- interrupts: Should contain the cores interrupt line
-- clocks: should contain one clock for entry in clock-names
-  see Documentation/devicetree/bindings/clock/clock-bindings.txt
-- clock-names:
-   - "bus":    AXI/master interface clock
-   - "reg":    AHB/slave interface clock
-               (only required if GPU can gate slave interface independently)
-   - "core":   GPU core clock
-   - "shader": Shader clock (only required if GPU has feature PIPE_3D)
-
-Optional properties:
-- power-domains: a power domain consumer specifier according to
-  Documentation/devicetree/bindings/power/power_domain.txt
-
-example:
-
-gpu_3d: gpu@130000 {
-	compatible = "vivante,gc";
-	reg = <0x00130000 0x4000>;
-	interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks IMX6QDL_CLK_GPU3D_AXI>,
-	         <&clks IMX6QDL_CLK_GPU3D_CORE>,
-	         <&clks IMX6QDL_CLK_GPU3D_SHADER>;
-	clock-names = "bus", "core", "shader";
-	power-domains = <&gpc 1>;
-};
diff --git a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
new file mode 100644
index 000000000000..c4f549c0d750
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/vivante,gc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vivante GPU Bindings
+
+description: Vivante GPU core devices
+
+maintainers:
+  -  Lucas Stach <l.stach@pengutronix.de>
+
+properties:
+  compatible:
+    const: vivante,gc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AXI/master interface clock
+      - description: GPU core clock
+      - description: Shader clock (only required if GPU has feature PIPE_3D)
+      - description: AHB/slave interface clock (only required if GPU can gate slave interface independently)
+    minItems: 2
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: bus
+      - const: core
+      - const: shader
+      - const: reg
+    minItems: 2
+    maxItems: 4
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    gpu@130000 {
+      compatible = "vivante,gc";
+      reg = <0x00130000 0x4000>;
+      interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clks IMX6QDL_CLK_GPU3D_AXI>,
+               <&clks IMX6QDL_CLK_GPU3D_CORE>,
+               <&clks IMX6QDL_CLK_GPU3D_SHADER>;
+      clock-names = "bus", "core", "shader";
+      power-domains = <&gpc 1>;
+    };
+
+...
-- 
2.15.0

