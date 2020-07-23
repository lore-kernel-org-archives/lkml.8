Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D149C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5697B206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZibBjkqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgGWP06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgGWP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:26:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FDCC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:26:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so5534030wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/f3+aWQD6jv0BacPrlT71wq4KzB+QZIhzZYF2sQn5E=;
        b=ZibBjkqePpOt6wdwejuWLwFNSiWg1V3RghiCXkrwZ2zbCXKNFcgMngbifiPD7ZtIaV
         CFUA1mvy/F3qhrX9YIPJSSK7Q8Fo7PxR7DTTvYzuxwE5/norGhp3rzrM3aKgsreCQxpS
         gKcQCwfO7PqBQOJ+9jYGEOZzc8BbHwaX8G89pODVWQCyEX5sLYkDzrgtxzOiKQ29i/gQ
         SIGKnrd/qVDvMLdd8i4EmC2OX//b5pZBDRK5adLOz/qQBYM2Cndq6lSgFo+lJB4ATZf5
         R3UnYH8RMDu4xBC++zoGIK5FvqM07FPesWZRz/y0saCEQPXrBPpDcKcCemI+MZEn06lQ
         QVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/f3+aWQD6jv0BacPrlT71wq4KzB+QZIhzZYF2sQn5E=;
        b=YKafbTITafEdICw3HrUoV5ZZsvTKo9TH7bQjYW5R5e3h2vFxiWt82IFZ5cZOw8H8Sb
         fs/vhD1M35u3gQG3KCTtakfuuzhtQcYGY7Bz7U0zV8s+9KA0purJv/Asp2oaQfDij63H
         j3UFCk/ism8NGP8r0XLD3vox56+fggj2wTHWvzfl1XboseQZ0IiawFCJKSnXo3dhPQ3C
         nZjghXxLfGLLtLNedt9n619Wu5imhOBeEdjTxsD4S5dLbKqDaHT9TLlKytU2U9KXwG7y
         SxkfetnxYTfb/qj4HB/7E5WISKHCub3Xl1h4QB3ILQz28VfjF6un7oDJNuU/Jty2oBvq
         aAGA==
X-Gm-Message-State: AOAM530gNDxHeCT9gwmW2QGPHp0SkmGFQNaDnlY3fK9w62xO2b6WB1Qo
        0Xo/kbfkn4Qenwzwt00gWpIq5A==
X-Google-Smtp-Source: ABdhPJyn+xE4PapUaCreq7vHX+H11qIZL6P1+k5pEK9vPxvIc+2dE+6m1P5/FmInnfl2ePCjghmB9Q==
X-Received: by 2002:a5d:4e92:: with SMTP id e18mr4588679wru.107.1595518015861;
        Thu, 23 Jul 2020 08:26:55 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:26:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/16] dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible
Date:   Thu, 23 Jul 2020 17:26:22 +0200
Message-Id: <20200723152639.639771-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The sama5d2 TC block TIMER_CLOCK1 is different from the at91sam9x5 one.
Instead of being MCK / 2, it is the TCB GCLK.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-3-alexandre.belloni@bootlin.com
---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 9d680e0b9109..d226fd7d5258 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - atmel,at91rm9200-tcb
           - atmel,at91sam9x5-tcb
+          - atmel,sama5d2-tcb
       - const: simple-mfd
       - const: syscon
 
@@ -36,15 +37,6 @@ properties:
     description:
       List of clock names. Always includes t0_clk and slow clk. Also includes
       t1_clk and t2_clk if a clock per channel is available.
-    oneOf:
-      - items:
-        - const: t0_clk
-        - const: slow_clk
-      - items:
-        - const: t0_clk
-        - const: t1_clk
-        - const: t2_clk
-        - const: slow_clk
     minItems: 2
     maxItems: 4
 
@@ -75,6 +67,38 @@ patternProperties:
       - compatible
       - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,sama5d2-tcb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: t0_clk
+            - const: gclk
+            - const: slow_clk
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 4
+        clock-names:
+          oneOf:
+            - items:
+              - const: t0_clk
+              - const: slow_clk
+            - items:
+              - const: t0_clk
+              - const: t1_clk
+              - const: t2_clk
+              - const: slow_clk
+
 required:
   - compatible
   - reg
-- 
2.25.1

