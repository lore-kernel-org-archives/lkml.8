Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA45EC3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B070215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOifVUFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgCDH22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:28:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46043 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgCDH21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:28:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id m15so551589pgv.12;
        Tue, 03 Mar 2020 23:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRgD+252PCsvlhNAz0vO9tBUHxQGbMfaFtY79oefoJQ=;
        b=gOifVUFwWC9T0jWec27WTt+/Zf6q6mN576zuKFDmyOLnnk1jDxRmgCfZX5m9HhV/jp
         l7+x1G4m7N2PpaoylJ6oT5GMVAHoIEvYo4g4m3p6rUseu6ORimKXcdNhL+hDdWd7emSd
         GiE1UldRBrxVcwGG02/0xiv7ZbPz0M4fmwIPMFNqRxL8gJZNFFCZ6WgqkOvVpREH6uHZ
         ZulqQPjOmbMyX0KTxxUYRoQ7zsy/YIMIO0NnPSgRhU1QDlpyOpGynDTdQhPcWJ0UtvwF
         iglC6+dZlkD8jZvv0Yo1/ziqme3CCsmgSz98iQHPoUiKV9szkn5gP119kxSaN9uTd5Vy
         OBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRgD+252PCsvlhNAz0vO9tBUHxQGbMfaFtY79oefoJQ=;
        b=ZCu0XmHrge73RO5Tes6NtGOWvyN6xuKT/kGLRZhDPzy0J82mwisKKjJBiQZ0XPRTi0
         mA9WZ49uAVyetRegHAqgjPrJdyNtlKG1CBAfG+ey6ihAFSL/DUYj4u52fB8IO11TGkzw
         flhcm9oveOdwZe8nFVWtBiPPqKPcGVGJAQO5y2GLqjKKyjSRmvJIdHstVkScX3b+EEu1
         Jv7QQ5HRpg3vwaHnPbJRps96mALVLOar5Ra7uYmr5FLjQXtWbOVxkvXWIYPHAgZmUMJI
         ixAIshoOw3uG/w0NSVtiO2hiph0YQyI5f8vC/pZSo5IY7I7JndTRyJZgKubTb6ZsMc2z
         4D3w==
X-Gm-Message-State: ANhLgQ0ujX1t4unAXzIHzoseMDl79oikRFV0M9GzgOpXBse/ia+4bptH
        WLtjxT4+MeUfn6wKfpf6HLI=
X-Google-Smtp-Source: ADFU+vulA+2kHlrvVJox6uKoCGsHBPw/nxVX46ffVNCz0ndyM3V2rjqOt/I4VoitTqBgn7LDo1vMsA==
X-Received: by 2002:a63:d845:: with SMTP id k5mr1305177pgj.183.1583306904865;
        Tue, 03 Mar 2020 23:28:24 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j38sm23435859pgi.51.2020.03.03.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:28:24 -0800 (PST)
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
Subject: [PATCH v6 3/7] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
Date:   Wed,  4 Mar 2020 15:27:26 +0800
Message-Id: <20200304072730.9193-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304072730.9193-1-zhang.lyra@gmail.com>
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
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
 .../bindings/clock/sprd,sc9863a-clk.yaml      | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
new file mode 100644
index 000000000000..bb3a78d8105e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -0,0 +1,105 @@
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
+    items:
+      - const: ext-26m
+      - const: ext-32k
+      - const: ext-4m
+      - const: rco-100m
+
+  reg:
+    maxItems: 1
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
+    Other SC9863a clock nodes should be the child of a syscon node in
+    which compatible string shoule be:
+            "sprd,sc9863a-glbregs", "syscon", "simple-mfd"
+
+    The 'reg' property for the clock node is also required if there is a sub
+    range of registers for the clocks.
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

