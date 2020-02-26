Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA10C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EF324673
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4AqN5u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBZJqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:46:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41907 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBZJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:46:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so839970pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uhG/24QG2V0Xvo4gbhTdi+VNYSRRPHVYttLMEUxAx8w=;
        b=t4AqN5u9aZHEyTXvEvetqO8lREDWT2EfTwCzpTpij/ZPqr5Rcx8Cui8SZokdbMz0fE
         iHNuDTlyfK5BBbwq/KSS6aj7leLs7yazWnUWoN1vYrtT7HNmghVO0apKn278N2U5qMPW
         QY4i6lCMhJpgKR93EPr2h7BBoieaWVRg2RoWXoKtxXM/8d5XEicVD48Z6CViP0NSuEra
         RDLbwHUMAfjOsU9nCzWNYffLnjxwlohPyudAKqrMkrRkxS8w+iuz7wKtGsoawJVgkc2H
         Fm9hNwiKLqIWdjUKXsdstb73Mq9W1o3yVM+ReS+C+8efGPqvkejlgCU7GUbMJFz6ZnTl
         tPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uhG/24QG2V0Xvo4gbhTdi+VNYSRRPHVYttLMEUxAx8w=;
        b=Xh4vpu0lwQAly8ZmtDG83VaGlRGFKUacyfYLzUSxWLatlNjuO7h4kUJuk6xQLD1pJp
         K17c2xTFvyt6sm2t73k+sMdD9hhfNSOvfbQ1km0IQc8KfJHl+CCa26uPWVzMEtdBanA0
         9qD2lKTrYpfBDetvtwV2lrqKdfqD3lwVxcj+5/T96TXewudaxAVX8V/twUYfFYGbH2iq
         QddqXWPxFdvVgHPoCn8THZ1T5rAqoAOINEz1P0nkPkfOojjUpw160vDlGnIE5tLcxKG6
         XH8uz26hnjpnKmBlfLXicqOOhvm91aEioPogtiHchKnrsvrLoA6dl/1+hoB0WZv4dP1C
         WTHQ==
X-Gm-Message-State: APjAAAXdDXrYEWjrTh3Sc9WUzvaQftlBGp09dJzyiGGnfkFawPZCZMpa
        K4iYnrHLaGh5I+8ClsD7d62NIAB5CL4=
X-Google-Smtp-Source: APXvYqx7xFhoX8ieFIAHgnO+VksXJBFPWUHPzeaafb7B5odTeANXxL2kutWQ2HwgGcmwYG4vanpQ5g==
X-Received: by 2002:a62:5447:: with SMTP id i68mr3574464pfb.44.1582710399881;
        Wed, 26 Feb 2020 01:46:39 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h185sm2276518pfg.135.2020.02.26.01.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 01:46:39 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v4 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Wed, 26 Feb 2020 17:46:14 +0800
Message-Id: <1582710377-15489-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
References: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
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

