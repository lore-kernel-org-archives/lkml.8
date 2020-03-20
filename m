Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1669C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BEF20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db5vCvVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCTNfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbgCTNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so7478591wrw.7;
        Fri, 20 Mar 2020 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADXJiGCDvrv56l+ieUm/SAdymbh3Yub2i9bAMUxwsik=;
        b=Db5vCvVX3kdDDG4TWQ8K/qx0s58cL0uzjYWQQmQTNfhrKnN21Q7JfcSVcOHBO9DvvT
         8GtzJL3B98vqCSPLQVyf5XXk/obGzEtkLVgtMrwKgA/o8OK6Gp6gQZ/+zk3VCbj2iPlp
         WhefUdDx9INTUnwRmkNK/kJjn/aGSszGNZsQPPjbTIbkYgG9LSwKBA+IIwIBkSsDv7oH
         QmaqGTpi+xyKgha+bxzMQ0QUk78LI3ZX3ogmR1JY7K55sO08YrnWZ2jL8UHo2Z9ESKWe
         v9j44atOsFMmnz8YgW6rd65wfjQ6Muf9VPLO6KoX0EFa+U3KdtkZC+SpQ75SS3xB1z8m
         OMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADXJiGCDvrv56l+ieUm/SAdymbh3Yub2i9bAMUxwsik=;
        b=oXLjnsvLH5069hf+/ZSOUX7KqMlweazw2gIu1k4K+8M1SzuJZwszwGlq59Wfu0PKgT
         REpu+uXfjuQFh/MYPYqaSdvdRSOzKgqVEcxapORXaYo/yIN27FjKka69F7oPuH/N+ZOH
         Re2TAB+etnWunIJuiLHl4ktc3kdOl+0szAEEuKS7sLcAAq9fzQC5F9HWLLC8iGFvLOkZ
         EGYoVJehJV7ZvgSbvQYFqoZ1FkDjGfsNftQGe2qg+BrvcdH9RbTh5I14whtGQSe2NKfT
         QJD9zpvbl3IqZcTSrS3oehC54yl3TL1G8FpFwwdkijunht5Z2jlDqVawxcxg1c1jOvZI
         Me0Q==
X-Gm-Message-State: ANhLgQ2UX3FE9QTmqMwqNMJOqdOzFenF30A9TrFvEHTCkrvdxEBejNqX
        bKpbWBF4OQUJcEy4T1DqzE0=
X-Google-Smtp-Source: ADFU+vuqshN9lSmln+18D87rL++S+Fb8k19lx7heUddfv7aKn737EG+IaVZYk9R/pOva1OhAL3A7bw==
X-Received: by 2002:adf:e98a:: with SMTP id h10mr202766wrm.370.1584711304489;
        Fri, 20 Mar 2020 06:35:04 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id g14sm7963218wme.32.2020.03.20.06.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: timer: Add bindings for NVIDIA Tegra186 timers
Date:   Fri, 20 Mar 2020 14:34:46 +0100
Message-Id: <20200320133452.3705040-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320133452.3705040-1-thierry.reding@gmail.com>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
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
 .../bindings/timer/nvidia,tegra186-timer.yaml | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
new file mode 100644
index 000000000000..f9b55041a5ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
@@ -0,0 +1,55 @@
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
+        status = "disabled";
+    };
-- 
2.24.1

