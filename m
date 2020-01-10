Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BCBC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5BA20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myXI5vdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgAJGKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:10:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36636 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731478AbgAJGKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:10:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so615434pfb.3;
        Thu, 09 Jan 2020 22:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAETbxCl8IAYjntzNuV1cIygcRyKTpAcBKJGXiWaLcU=;
        b=myXI5vdv8m/UDJStGZIBdVULuR/JEYpnig4/eTxZX5Jj96ykHFQ5hUyTczaCHC5ec1
         Wod2Y/Q9oKRXXYZApH7Oraw/LvZb7hgcrwo3LhfhT1FCTARmPTRCavGxWWPZSlZWvWZJ
         sXq6jD0ZJ8yyuA7GQHJsIzHJuibrTX0RjpgQZCrcPAYlZTcXgaBfKdw4N9o+rbcnVkeC
         T2PlR2AnEL7WA/yFO2afb86P8HB32om8+OS8xLzE59x8LtvySNErrCBFpTln0zXc0r4t
         gfn3XRjJXUnlG3VRXoP5CC605XWyRZV6RDOYvNo/HHGsXNJYzPWHZIHTWsZEm4Z3WcwY
         SvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAETbxCl8IAYjntzNuV1cIygcRyKTpAcBKJGXiWaLcU=;
        b=kq1DyjHApIw5E7GjkkH9Mbjp6sJKIScvX7H1IWut1LDzT7/ChE1XL351c6XYu6a/5D
         VvyWXcIyZtPfJ+jlN/VyIiSYUxdbtfq/rhIC4hblI7Y6icfwvpW1KidUZ8ZhEyhQdgHN
         Auizw36naMaSvpAfTTYJT5osxrdjmEKUDg5z2M+f64E1kdvWeMJ3fwmwS6g4v/8pyh3J
         yI8c3e4IIuwlXoqyCi+5L4d3SuM8hEW5d+ZAw4oPtzm1uDcUaSZWlXTacVGou/WF5FPi
         b51/pjbMRRtPRecIrRG1PumAg3tjTBjWPgGF9jbRCGUMpFr1Wtru5I+TrJYU/9idyJkY
         nY4A==
X-Gm-Message-State: APjAAAV1L1YSC1Gm1GaIf9Jf/EKv+1DXjTvAW6iCTYUVGT5yQDoxanRb
        h04uK4j8HFo7/0P/6WORGm2xgdKB
X-Google-Smtp-Source: APXvYqx8YEZXI3rPjZZSWaJeSHuC9BngnJC4D0/JZGx5EHA3KVZ6jerRvCCigqHxdMUwVPBuypgQ2Q==
X-Received: by 2002:a65:6794:: with SMTP id e20mr2362777pgr.152.1578636612290;
        Thu, 09 Jan 2020 22:10:12 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y76sm1195814pfc.87.2020.01.09.22.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:10:11 -0800 (PST)
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
Subject: [PATCH v3 3/7] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
Date:   Fri, 10 Jan 2020 14:09:14 +0800
Message-Id: <20200110060918.18416-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110060918.18416-1-zhang.lyra@gmail.com>
References: <20200110060918.18416-1-zhang.lyra@gmail.com>
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
 .../bindings/clock/sprd,sc9863a-clk.yaml      | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
new file mode 100644
index 000000000000..e19577a6142a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -0,0 +1,103 @@
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
+    maxItems: 4
+    description: |
+      The input parent clock(s) phandle for this clock, only list fixed
+      clocks which are declared in devicetree.
+
+  clock-names:
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
+    ap_ahb_regs: syscon@20e00000 {
+      compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
+      reg = <0 0x20e00000 0 0x4000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0 0x20e00000 0x4000>;
+
+      apahb_gate: apahb-gate@0 {
+        compatible = "sprd,sc9863a-apahb-gate";
+        reg = <0x0 0x1020>;
+        #clock-cells = <1>;
+      };
+    };
+
+...
-- 
2.20.1

