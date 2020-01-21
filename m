Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14500C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4B721734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tt8utxli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgAUIvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:51:33 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35340 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgAUIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:51:32 -0500
Received: by mail-pg1-f176.google.com with SMTP id l24so1121642pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9s/89tFhK8CsKwuJAyzex+lyypM4LteBbs7SvUHMAY4=;
        b=tt8utxlivBi46vyypQ0AjDfDNHASYlVHLEyQcJgCFQSxOaF/IGDxV1LRkt01PA94Md
         0puZzgmn3/LFmAsdUmGqYVzAxl7CcHewfOB9ymG6nRJ9BwGI6t8HPYVBEfHZk8nRWiL1
         ph2rdhKVTwbd9thyF+8D1Wsxfq9XNKFvFiG//DZj1bbT7l84HqhLcMuwpiEPHBlv2mjR
         LV3Q1e/Np98JnNa5o0rcVtnL/AXFKHmVonHZ/AK5tw0RfdBSmrCnoYXhAmM3PuVy8Yd2
         RfnLw4gRxz9QzJGjAojzsLuW4V0i67+RGupWlCbFBjRhjcEPYSP1Bqv5ZNiiUf+CUmNT
         fw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9s/89tFhK8CsKwuJAyzex+lyypM4LteBbs7SvUHMAY4=;
        b=quAqnhwiTGSvWzIbldPp+LtqhRBVE3wHrFopa6eFnmN3QgSkpXiYALjyq6mNEoljdu
         Qd4hw/N/4sdI11YYW+iS0wV5VUka/jVaoJiUC+nPpi9glJoAHMdDTchECgi4cqBEJLIp
         WGj4STGWA2iUz25CodTIQXpgyT5dm75HAm4UiwnmmcfGuxpPJBopfwbXI5olFT8uSJu/
         mGEkXF9AjU5LmUhZvriZwiVryJQFCHVQSt/YiGSrTzuJdb6sZWnkZb6/aL5ckCPMZj10
         9RpIeNpdeZoMtbyHnGB11Mcy3nJBpk0L/mCy2JdrbG9S8N1+yTAACB+NOw5U1j8gqgG7
         30jQ==
X-Gm-Message-State: APjAAAU07pfG5y3FkiG98qIlYJBXiUOPyojqweLQdgB798LwGAH+Sy1u
        dXsheaZSEtoHUTq/syTXlzQ=
X-Google-Smtp-Source: APXvYqy13RiY1TBvmIvqMlcCN6QslDD5Y7O40UJOSKLL8wAy+5n8it2ql98MYZhxBMkLRVv7TmaFxw==
X-Received: by 2002:a62:e80a:: with SMTP id c10mr3438207pfi.91.1579596691547;
        Tue, 21 Jan 2020 00:51:31 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 80sm42820957pfw.123.2020.01.21.00.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jan 2020 00:51:31 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v2 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Tue, 21 Jan 2020 16:50:59 +0800
Message-Id: <1579596662-15466-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579596662-15466-1-git-send-email-kevin3.tang@gmail.com>
References: <1579596662-15466-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
which transfers the image data from a video memory buffer to an internal
LCD interface.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/dpu.yaml      | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/dpu.yaml b/Documentation/devicetree/bindings/display/sprd/dpu.yaml
new file mode 100644
index 0000000..7695d94
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dpu.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc SoC Display Processor Unit (DPU)
+
+maintainers:
+  - David Airlie <airlied@linux.ie>
+  - Daniel Vetter <daniel@ffwll.ch>
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+description: |
+  DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
+  which transfers the image data from a video memory buffer to an internal
+  LCD interface.
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dpu
+
+  reg:
+    maxItems: 1
+    description:
+      Physical base address and length of the DPU registers set
+
+  interrupts:
+    maxItems: 1
+    description:
+      The interrupt signal from DPU
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: clk_src_128m
+      - const: clk_src_384m
+
+  power-domains:
+    description: A phandle to DPU power domain node.
+
+  iommus:
+    description: A phandle to DPU iommu node.
+
+  port:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the output endpoint, usually output to
+      the associated DSI.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dpu: dpu@0x63000000 {
+          compatible = "sprd,sharkl3-dpu";
+          reg = <0x0 0x63000000 0x0 0x1000>;
+          interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+          clock-names = "clk_src_128m",
+      	        "clk_src_384m";
+
+          clocks = <&pll CLK_TWPLL_128M>,
+                <&pll CLK_TWPLL_384M>;
+
+          dpu_port: port {
+                  dpu_out: endpoint {
+                          remote-endpoint = <&dsi_in>;
+                  };
+          };
+    };
-- 
2.7.4

