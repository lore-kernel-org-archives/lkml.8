Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF11C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819362073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sey9rFdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCMNXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:23:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36843 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCMNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:23:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so1091044pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uhG/24QG2V0Xvo4gbhTdi+VNYSRRPHVYttLMEUxAx8w=;
        b=Sey9rFdH0KB3+dsBVhATAQBmrjTBPTbezaomhwRZsuGoZOxoC24ZuQxFWo3y8zGRCN
         DjP3LHeT9hYu96GVe9za8gD33S1U1UTFWZTjWShSfV/oOZ2y66sW7AoM1hODDyAHmThR
         lMMwpFAIip6qzFNaNMQDfmQBL8PxkRPyYJTfHEldCIgSgHOqOocrpoM3oGf0G0vmxO8O
         EiFFgAV4AQcvbAR241uAK10jiu6yUdaN7RkweH4wvlWqWxOaYKBgH2rRKEvLdAh5CP/0
         hrYFN+7DUnGUdCv/VBBbOPBPdF6hmBICVZ/TpDs1fvs0R+YREWO3TLRiyUTlM34Ktfyf
         0vBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uhG/24QG2V0Xvo4gbhTdi+VNYSRRPHVYttLMEUxAx8w=;
        b=ENLkCjrLmuL2rvd41WUGkEudxd08hU0F5dE9hzHc/8M/oE81BOnmprxDqK81zumuFd
         ggYEj0xuV1ucxr4f+HT1NhiuXqdu44Bzdn5wp10+0sd5WnsdvtFstuCo3tPPN4o0bnKy
         YVfrg6s7wFo6lHFOfhIWnXl9hDtbBRyyDV+DKND9UVcdycMEniiliMmwMw9b3YlWTVnY
         K/7O+gJ8zJRFxjcsQOuvjkQhuTXG3CuPHN0O4FqsEgKhfgGx46+dIbVA2X6RHHDPJElx
         2gRqri+R/yqD3GNSo84MfgpvULd8XBefS5aZ4HPtcoLbgngli55YJngexCdIyOTlaQKp
         CnuA==
X-Gm-Message-State: ANhLgQ0vxdnhTXroQWWj3KXUdNbi6Rxuk0Zgmnyq2yIai4GUT9mUBqby
        d6yxThOCIcXRA1cyTUUckgHq2Z7u
X-Google-Smtp-Source: ADFU+vvsReo36P7yxkGNjF6J7YSGD0VUssKBi9nFhIc6hB/Y8pwmD40nlzr6I/q3CsK5o4dbt6NB5A==
X-Received: by 2002:a17:90a:6545:: with SMTP id f5mr10103614pjs.42.1584105785921;
        Fri, 13 Mar 2020 06:23:05 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y9sm21490296pgo.80.2020.03.13.06.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2020 06:23:05 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v5 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Fri, 13 Mar 2020 21:22:44 +0800
Message-Id: <1584105767-11963-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584105767-11963-1-git-send-email-kevin3.tang@gmail.com>
References: <1584105767-11963-1-git-send-email-kevin3.tang@gmail.com>
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
 .../devicetree/bindings/display/sprd/dpu.yaml      | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/dpu.yaml b/Documentation/devicetree/bindings/display/sprd/dpu.yaml
new file mode 100644
index 0000000..54ba9b6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dpu.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc SoC Display Processor Unit (DPU)
+
+maintainers:
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

