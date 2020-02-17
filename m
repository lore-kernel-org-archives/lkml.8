Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55931C7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259A621744
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlFu3q16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBQDXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:23:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40543 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBQDXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:23:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so6134085plp.7;
        Sun, 16 Feb 2020 19:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAETbxCl8IAYjntzNuV1cIygcRyKTpAcBKJGXiWaLcU=;
        b=JlFu3q16yhz44m7chMf8W+QtIub4myDX5raEIXjbyMFxtfSXqmzMvCYp72R4bWCSj0
         Mv+3GbZEXJ7v3Foz0QTpSrFMF9DTuL0VW+jlEQa/Rx42tDLqAJvJE0r3RoQKlISTJg6R
         eEcErGRNzS0M4QKITtxM2AucJ1R4I2kbyWDpRP0XHanVUIbyv1QNuR7wM2o3H8kCmsSs
         xZREJU8IDPDVLeSkTXcc/vYpuJWHiD8xzj46ORMLACQ0/QFLynpH4xFXKxL/o33qA8QR
         JC8YuVu+w8+qlOld85kMCOp2k8n240oBNZreLc2LYi4xKwktKTn5yx8bObcEMH37qmxv
         7nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAETbxCl8IAYjntzNuV1cIygcRyKTpAcBKJGXiWaLcU=;
        b=ulKAoxkY7RoQlib902UXGzYqnYmS6PpT90J0UCIVZ4XKpV0R2nYCFpYRFXU19R5DbB
         S0A7QU6EuM1agaiToqxibuFIyFs0u2iLhDVSt9RTYd0aNoUNY2NlkmE9Y4nsnW0ZJhVs
         UwQ8vBfYgWMF++eyd8TlbixHdAOdf5powhka3pm58hlbeHi48hxaYHCol97C/put0kk0
         G6qGuhi0iFtFowDsfVobThPLEb1EmdNzt+653PDcLm2eOvuC5YUzEK8D4SFWZRlHRD3R
         tSQCbOkm8wKxYaZbyN+RfveYGM6DGSyGBJMdBcnVf2uk2lkP6ZpmPitTzHM57bV4y94B
         lidA==
X-Gm-Message-State: APjAAAV0ks/eCzIciJNJ5Lu5y8ttVEnotHiuu5Gk/AcrlYVtGB0P2SJw
        g+IAV7tTluw0xO/L0h1nvBs=
X-Google-Smtp-Source: APXvYqx4tDtYCRw53wNY5f+kZZO8jJbBSMhqUCwwat+bKykNiLCIyUVe5Vryr+9zpOnwaVHCtpj+lg==
X-Received: by 2002:a17:902:a701:: with SMTP id w1mr13115667plq.165.1581909831506;
        Sun, 16 Feb 2020 19:23:51 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 76sm14644383pfx.97.2020.02.16.19.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 19:23:50 -0800 (PST)
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
Subject: [PATCH v4 3/7] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
Date:   Mon, 17 Feb 2020 11:23:17 +0800
Message-Id: <20200217032321.15164-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217032321.15164-1-zhang.lyra@gmail.com>
References: <20200217032321.15164-1-zhang.lyra@gmail.com>
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

