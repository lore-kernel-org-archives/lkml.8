Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF4C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59440206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkkX/ox3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgDCUWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:22:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38133 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgDCUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:22:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id c7so10001293wrx.5;
        Fri, 03 Apr 2020 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds23RDty3T9KSp1T//1bKmXLBRBBOLQ6ILYzvtVdGuk=;
        b=WkkX/ox3pxwosR0x0gjkJmKmzUbhartWZp9pSZVVDqgH437Km9+myxlO7waBXheKip
         0dKE9MWfkgaX/bfUFgvbHwfU8Q7sMbwq9roXr/Vg/ltyDIe4HvfDTdARfVxf4gpEBBsl
         uwU6KSayyZSr577rYckhT9MMLNcocOEA6V8R7rOP/rCbNNiyRk0UV28uTQ4DKQV5Uyni
         7NDwUyirqKg7ut6yR9n0YG0mT6kiQo58ohap779Oh6f31/Un5KlwL0Ry2gL4Bvsz9c2z
         ZDYqPr+Va648b+UuXNTSyg5Ibds758YzBdXY2O3Ml8MXC6IhIyLiDVwyKGlvlhThZvbs
         FqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds23RDty3T9KSp1T//1bKmXLBRBBOLQ6ILYzvtVdGuk=;
        b=Do8I1DizsCYj6eIMOBNYyaLZp3vCeOQXzZwxZH3phbOyfb1jco0t2n2jHbvwrOaeAm
         D+1QmirkJA/Q3ZDZgqIgS53hrHVNUBEvi/yFp7bqhqyMovHjeWCemEhU+xkm2TLMxIm4
         2/xwP0H+qEcVX7r1+nyFGgvAffwcsWoKHXQeZ95zH13a3bYKob0PkhMBQydhk8dxUZpW
         Sfm48ELQ8zyQxq7iqMXlNHCa4zzNTHUOG9DGpnv2p83B0dG+nMKlTKsMQvDbQTOAkPCH
         F6xc6vs3l9DePcIWgGO5Xcqyem+Rnfeee1xYcnwzco8OGyBRJWig4lJ7mEjPQGnFdpRn
         GopA==
X-Gm-Message-State: AGi0PuZyj3xD9zuhL7yoo5jlQYVNLw1ajvWanSt06eXg5yXPaxy7y2nG
        zP2xLoXLv81SVd6p+UCDApIWbB4C
X-Google-Smtp-Source: APiQypIlXc3c4rHatTLupXgeOHasAqZiJ/mK3qaB+KZQH4fd7SrGbTqkI3398BCNgxbrqwTlELQAjA==
X-Received: by 2002:adf:e403:: with SMTP id g3mr10252917wrm.333.1585945338024;
        Fri, 03 Apr 2020 13:22:18 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id z129sm12870112wmb.7.2020.04.03.13.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:22:17 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: timer: Add bindings for NVIDIA Tegra186 timers
Date:   Fri,  3 Apr 2020 22:22:03 +0200
Message-Id: <20200403202209.299823-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403202209.299823-1-thierry.reding@gmail.com>
References: <20200403202209.299823-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The NVIDIA Tegra186 SoC contains an IP block that provides a register
interface for ten timers with a 29-bit counter that can generate one-
shot, periodic or watchdog interrupts.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add required properties section
- add additionalProperties: false
- do not show status in example

 .../bindings/timer/nvidia,tegra186-timer.yaml | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
new file mode 100644
index 000000000000..d722cd267bf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra186 timers
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+description: |
+  The Tegra186 timer provides ten 29-bit timer counters and one 32-bit TSC
+  (timestamp counter). The timers run at either a fixed 1 MHz clock rate
+  derived from the oscillator clock. Each timer can be programmed to raise
+  one-shot, periodic, or watchdog interrupts.
+
+properties:
+  compatible:
+    oneOf:
+      - description: NVIDIA Tegra186
+        items:
+          - const: nvidia,tegra186-timer
+
+      - description: NVIDIA Tegra194
+        items:
+          - const: nvidia,tegra194-timer
+          - const: nvidia,tegra186-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 10
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@3010000 {
+        compatible = "nvidia,tegra186-timer";
+        reg = <0x03010000 0x000e0000>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.24.1

