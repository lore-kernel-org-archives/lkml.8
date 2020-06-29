Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9D8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130F42063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="VWtqmuPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbgF2VnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgF2Shx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32631C03142C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:09 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e3so1683303qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNFf1AHiZrCdSiYdBqYQtf+nkqBR/m0y7WTyi1yw8FM=;
        b=VWtqmuPqPQ/Wmey41mf2SgkPFEQeVhfHg2KV97SKy14BZK+kLMSbjYN+ZPvMGC5i0Y
         +r4q9jtPqzscxAPUihxpI+WhVY4fA2fOb5wNdVYpsw7mHOTtH58z96/Me2kJL2riWq1/
         Ri2ca9uK/R3fhW8iFGRWnFah8BahMMXcCU19Dc5bqR+XweDTz9Bs6jxVG0mGLwyN2okP
         y35pEgnQfrTJ39nlz4rC58djQsnMs3TyogejJSjEdxLWK4354Bmk8SX4uWlf82+Yf5yB
         tUrfhKqMTiJD8nKznciNwm0aDEqSDMW6Hb5j9mXpIPahzmXfvyGuwkkpd48KuK7PXvCn
         +Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNFf1AHiZrCdSiYdBqYQtf+nkqBR/m0y7WTyi1yw8FM=;
        b=YxttSBh3gmy5uKjmrczBTOHdc/+DCtuK6AtCnraQXLfdnICPqvx6N2byP8Lbfpm0Ch
         uqX7b/0517iWh5vKGzS+ORkzelAnSzJKQeLIJgk2yQufsAtfC2pmalvai5QEse5B2luw
         62kgWRZFEeC4BW7W5XRKzCCyXNXqdf4OnbY1QWmwe8pjsZHDwSebFpBk+2+sfLKvIJZu
         BFy/jvQF1a9dmkFdgXD6O/7yhaJJRW20lHH+g9dsBEN1LYz/Y5EJdVcWR7IKPb0zrCjv
         TcCdVbw3OJwigitlntlC51WQO7ZxT/YXc2EdFbP1ZjSpOe8p3TEIfM5E9idMnaQWyC/T
         in0g==
X-Gm-Message-State: AOAM5331tZsKKRH75zsar+oyRBdhxQHZ8Py9rwlod4gxzX425XaKW59k
        WGCOASifKNdmof9e+QOyCOEq7uWL+bA=
X-Google-Smtp-Source: ABdhPJyflHo+JB8zV+2M63HtV4/+CmvoKImlgNTrNPL+fJa4r4o9hHcti8JR5R4KbbSHo/VHx0tpug==
X-Received: by 2002:a05:6214:13c6:: with SMTP id cg6mr16481717qvb.160.1593451268441;
        Mon, 29 Jun 2020 10:21:08 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q5sm408363qtf.12.2020.06.29.10.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:21:08 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/13] dt-bindings: clock: Introduce SM8150 QCOM Graphics clock bindings
Date:   Mon, 29 Jun 2020 13:20:36 -0400
Message-Id: <20200629172049.30452-7-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629172049.30452-1-jonathan@marek.ca>
References: <20200629172049.30452-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SM8150 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../bindings/clock/qcom,sm8150-gpucc.yaml     | 74 +++++++++++++++++++
 include/dt-bindings/clock/qcom,gpucc-sm8150.h | 40 ++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8150-gpucc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8150.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8150-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8150-gpucc.yaml
new file mode 100644
index 000000000000..683b50dd3492
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8150-gpucc.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8150-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller Binding for SM8150
+
+maintainers:
+  -
+
+description: |
+  Qualcomm graphics clock control module which supports the clocks, resets and
+  power domains on SM8150.
+
+  See also dt-bindings/clock/qcom,gpucc-sm8150.h.
+
+properties:
+  compatible:
+    const: qcom,sm8150-gpucc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 main branch source
+      - description: GPLL0 div branch source
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: gcc_gpu_gpll0_clk_src
+      - const: gcc_gpu_gpll0_div_clk_src
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@2c90000 {
+      compatible = "qcom,sm8150-gpucc";
+      reg = <0x2c90000 0x9000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+               <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+      clock-names = "bi_tcxo",
+                    "gcc_gpu_gpll0_clk_src",
+                    "gcc_gpu_gpll0_div_clk_src";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8150.h b/include/dt-bindings/clock/qcom,gpucc-sm8150.h
new file mode 100644
index 000000000000..e7cac7fe9739
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm8150.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8150_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8150_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_AHB_CLK				0
+#define GPU_CC_CRC_AHB_CLK			1
+#define GPU_CC_CX_APB_CLK			2
+#define GPU_CC_CX_GMU_CLK			3
+#define GPU_CC_CX_QDSS_AT_CLK			4
+#define GPU_CC_CX_QDSS_TRIG_CLK			5
+#define GPU_CC_CX_QDSS_TSCTR_CLK		6
+#define GPU_CC_CX_SNOC_DVM_CLK			7
+#define GPU_CC_CXO_AON_CLK			8
+#define GPU_CC_CXO_CLK				9
+#define GPU_CC_GMU_CLK_SRC			10
+#define GPU_CC_GX_GMU_CLK			11
+#define GPU_CC_GX_QDSS_TSCTR_CLK		12
+#define GPU_CC_GX_VSENSE_CLK			13
+#define GPU_CC_PLL1				14
+#define GPU_CC_PLL_TEST_CLK			15
+#define GPU_CC_SLEEP_CLK			16
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_CX_BCR			0
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		1
+#define GPUCC_GPU_CC_GMU_BCR			2
+#define GPUCC_GPU_CC_GX_BCR			3
+#define GPUCC_GPU_CC_SPDM_BCR			4
+#define GPUCC_GPU_CC_XO_BCR			5
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
-- 
2.26.1

