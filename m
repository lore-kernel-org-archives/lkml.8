Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099F2C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D42071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYeq5fRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgBUIrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:47:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39061 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgBUHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:49:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so560114pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9s/89tFhK8CsKwuJAyzex+lyypM4LteBbs7SvUHMAY4=;
        b=FYeq5fRl/qH/XEUZDrffiETx7mSYEoysXSDKfoCD8vugyXXzbaSVd1+NbJutdsIDFJ
         6TRvVT4c3trRe5JdG9v2FnfceZrgA1E+fgzWlQaKKLydgSE2Jxq0jRZxbc5pSswPrl0q
         kqI5ccN7TYTfChx6xQXGx7dNPwzqD1X1fPFblfem1I5UAxtmYALsjsYpkwqXUVuazDvq
         P2DEtqOVy7pNW4fVc3dBNTO+WxPswVMzQiHebeysHi2iHu8qiadOc6A1s8r4RANg3yF8
         nuf2jqREWcFkLO9xpoFj5e3EN6g0huypZW3dq6HxbjEttngfOCGDyh/ChEfHAGXuGcvF
         d5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9s/89tFhK8CsKwuJAyzex+lyypM4LteBbs7SvUHMAY4=;
        b=ToEKs+gWv3kduRVbTuB/87+6wPejKfZDb6RlFPvA0mWVutagn+6FvR783S8251VG+r
         wC5j5WtxR4rZhw9sFM+pcGcfAKJguyBWMf8//fkt33WdI3K59ThLkkx8Won1fcdHHt/s
         qN1AVfrM0HCrFqpmwWuiBWP1HeLdxWYwzUe0zFaTNju7BFhT+s0ioY19voUaYHbK10dc
         Jc1sdkh3YHZhWep+u1xcKeB1LFpJnTdx0PKDX5HXdLrfLshD3yOsA3AxQZBkEAL2esru
         KodMbMM8l24HaxGL6DAHKiCJOD18DUvW8FROJkCkg7eRpCUbKH0jkCMD6pYjgNsipKqY
         6ulg==
X-Gm-Message-State: APjAAAUwb2y1KGS8GuwbOrdgjOEndF7FGCRbV/V3dR2RkcTeK7QCR2+r
        wSr6UF8yRkDofWRPAW/ftS8=
X-Google-Smtp-Source: APXvYqxKqdVRyRdtOGfIJxeRmGLjwNsFH6v00he3QSjaziEmGGmxu/92M0N39l7riAZg/3ddqVQ/GQ==
X-Received: by 2002:a62:18c9:: with SMTP id 192mr35752390pfy.117.1582271354610;
        Thu, 20 Feb 2020 23:49:14 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d1sm1444653pgj.79.2020.02.20.23.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 23:49:14 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v3 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Fri, 21 Feb 2020 15:48:53 +0800
Message-Id: <1582271336-3708-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
References: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
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

