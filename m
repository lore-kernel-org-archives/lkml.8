Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDDAC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C3120714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlCrX5i3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgG1KIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgG1KIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:08:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA843C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lw1so2520533pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9stfAM+ZdeHh3qDD2ZttFiTlZK9f5XlMjB7C2Y230oQ=;
        b=IlCrX5i3kdsGXTRcTZEioU2wTVLe2QnYkzgYUSvcAqajkHC6du/RlolyPjSYi+1tGT
         bLy+oro58RsI/QMLRKJDDDdfTgTNYk9yTQ4rWqf0SqdKKVaC5Oz4/YPbZx1UQtfe5Hus
         ucKHTB3moUk2x76laFxN6Ol0+CZszRS8rMcCe9OPgBi4URomdBNfcJn1s35xo/N5FugY
         awzGx7Q2FO/fy8cGMcN74eUZ5Ay0dfPj9bYjy5Y0QCFnR80bqxsBMSDWHc2Ba0MvXHXb
         +21d7C5VfIMi17Ay55F37OxtxAbIuu3JXAlv4RUbST4wM8zQLwM+yzmaNt+i3Iub4Dcp
         PsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9stfAM+ZdeHh3qDD2ZttFiTlZK9f5XlMjB7C2Y230oQ=;
        b=OlSiysaHRp8MhUFoTE+KaFjNU8fZSi7ZsGACmys3qM9A81zs+vFtFhvxh9TvopAsAC
         FEuDt9maOa4BmNHlaDWvNBWjmzE6Fv23isr84okaVdm7x4PaUa0p56USTFxWp+p4jYml
         oWihTecYfqYIR6ciX09ouTUO3g/ZDZP9z9ovFY90ZHs9ZWJ+7SSZ6pByuXTyc6Z0l65K
         tvhaWm24CydbhnurJ/Un0XAFBGfvK6mlH5xS1/FE+KGZ+gjfGVRr1f5brH8yPa/wiktu
         xIwAUFMlddAm6q3tX3ePInuTMHJpZIY+AvoQ8LmyN9SARrNVpsDLahdUKFVD0Pit5xTO
         hdPg==
X-Gm-Message-State: AOAM530x7TzTwDGeLQye4X7wG1aKho4ZTR0kufMLQQhKCebeMh8q+1iD
        7SMHbap3SXYfejuD+NPe1Jc=
X-Google-Smtp-Source: ABdhPJzZLlwYKqSfnQbtrST5Aj19ru81oKwhh3BOdIy3UgAspQ7opzxAfjyCQ31aJJObydQ9QI34dg==
X-Received: by 2002:a17:90a:eb17:: with SMTP id j23mr3532882pjz.151.1595930896191;
        Tue, 28 Jul 2020 03:08:16 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e76sm1704593pfh.108.2020.07.28.03.08.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 03:08:15 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v6 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Tue, 28 Jul 2020 18:07:56 +0800
Message-Id: <1595930879-2478-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
which transfers the image data from a video memory buffer to an internal
LCD interface.

Cc: Orson Zhai <orsonzhai@gmail.com>
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

