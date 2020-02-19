Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5591C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63C724655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZItLMh6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSEKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:10:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40077 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSEKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:10:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id b185so1477644pfb.7;
        Tue, 18 Feb 2020 20:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKlJRpoW9s+CgdzRUCrPuzBWK4DQihLvmq9CGNyP4lA=;
        b=ZItLMh6SA8L9EyV537aXVGFMLyAMANRXSzL+QqaNhZW02LAZqICLhsOWWO3WGrjG+S
         mGhcXvuKZC5n990traPG3Xjvi2hqitCNXwkzMpHyG6pqmhRZq6Lrqg6rsrXnQ7kjN9ko
         Pq3hCFya24/h+dJprthoML0ujjUymHdIVhFSdFj/PpiKIO1sMQgd0gtXdXHqkoDq7sgP
         tHE3n/LYGWMdtWHGxgcKedJPm9UInECVZelp3yhJol8XWyKuj+AlmbrOpV6x4B+wgOVu
         QOqdTmPmxIeSV4N0iziZVzZ9sgZS3ozHgrW7xlzJtVPWnyg2Mwxm7a0w6lSjLyAzvo72
         q19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKlJRpoW9s+CgdzRUCrPuzBWK4DQihLvmq9CGNyP4lA=;
        b=i31+4mS5B0BHHueWmjufiY8q2qWpJMjIVK5PQfe+ln1mTYUa6QnByK71+rw8cykiiB
         n4volOpV8dPEig9txUgbjELdewObEWYcoAet2kgRCWzWaY8YmU5zeWhxd5xXyw85+pxo
         xBeHEauBm6dZJnsKWMhCA2ugdUQff5n5U7Agp8tj6R6XujgXa3V6JjwK2r2f8rJxHJ/b
         2vwmgGmp2tR+YrSmttYX2ZlF4RrQPk6Q8ERDGjCoHfa6zxIgs6LzBJK9MgYJmCVHCV2H
         sGYLdYGC/DbnyZxPF3UpfaSp8cOKcSk5mh5+6ff19tkF0Six1zg993iPTMWs7MzQUJS9
         nElQ==
X-Gm-Message-State: APjAAAWW9tYAayL5wliQC1CBbCdIAnCJo9hLjrPWne76WVgcLV82IncH
        WCV5hpPdiTouEIKIKvvCq2Q=
X-Google-Smtp-Source: APXvYqxxjMfV7xqxQfc/G3Yhj/QeithAd0Mqy67t/II5o6d43lcF3CeAZhESzuR3aWID4Hjsos9+BQ==
X-Received: by 2002:a63:e30e:: with SMTP id f14mr23444786pgh.260.1582085418233;
        Tue, 18 Feb 2020 20:10:18 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm578748pfq.27.2020.02.18.20.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:10:17 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v5 3/7] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
Date:   Wed, 19 Feb 2020 12:09:11 +0800
Message-Id: <20200219040915.2153-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219040915.2153-1-zhang.lyra@gmail.com>
References: <20200219040915.2153-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

add a new bindings to describe sc9863a clock compatible string.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/clock/sprd,sc9863a-clk.yaml      | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
new file mode 100644
index 000000000000..b31569b524e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: SC9863A Clock Control Unit Device Tree Bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  compatible :
+    enum:
+      - sprd,sc9863a-ap-clk
+      - sprd,sc9863a-aon-clk
+      - sprd,sc9863a-apahb-gate
+      - sprd,sc9863a-pmu-gate
+      - sprd,sc9863a-aonapb-gate
+      - sprd,sc9863a-pll
+      - sprd,sc9863a-mpll
+      - sprd,sc9863a-rpll
+      - sprd,sc9863a-dpll
+      - sprd,sc9863a-mm-gate
+      - sprd,sc9863a-apapb-gate
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description: |
+      The input parent clock(s) phandle for this clock, only list fixed
+      clocks which are declared in devicetree.
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    description: |
+      Clock name strings used for driver to reference.
+    items:
+      - const: ext-26m
+      - const: ext-32k
+      - const: ext-4m
+      - const: rco-100m
+
+  reg:
+    description: |
+      Contain the registers base address and length.
+
+required:
+  - compatible
+  - '#clock-cells'
+
+if:
+  properties:
+    compatible:
+      enum:
+        - sprd,sc9863a-ap-clk
+        - sprd,sc9863a-aon-clk
+then:
+  required:
+    - reg
+
+else:
+  description: |
+    Other SC9863a clock nodes should be the child of a syscon node with
+    the required property:
+
+    - compatible: Should be the following:
+                  "sprd,sc9863a-glbregs", "syscon", "simple-mfd"
+
+    The 'reg' property is also required if there is a sub range of
+    registers for the clocks that are contiguous.
+
+examples:
+  - |
+    ap_clk: clock-controller@21500000 {
+      compatible = "sprd,sc9863a-ap-clk";
+      reg = <0 0x21500000 0 0x1000>;
+      clocks = <&ext_26m>, <&ext_32k>;
+      clock-names = "ext-26m", "ext-32k";
+      #clock-cells = <1>;
+    };
+
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      ap_ahb_regs: syscon@20e00000 {
+        compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
+        reg = <0 0x20e00000 0 0x4000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0 0x20e00000 0x4000>;
+
+        apahb_gate: apahb-gate@0 {
+          compatible = "sprd,sc9863a-apahb-gate";
+          reg = <0x0 0x1020>;
+          #clock-cells = <1>;
+        };
+      };
+    };
+
+...
-- 
2.20.1

