Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB8121D81
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrHdOgQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgIHIU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgIHIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:20:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1990C061573;
        Tue,  8 Sep 2020 01:20:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z23so21184043ejr.13;
        Tue, 08 Sep 2020 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ps6oy10ORdikw70XKA0O8bVm8SaRqDQHF3zytkb03qM=;
        b=HrHdOgQBo+a4rq90+PO/XkrIM65WRoaZk5aVcCGXI6szdjicSPLMTOMjq/ed62Z78H
         tI3p9FdIdlpqAwQhpKnw4eERJqQTRSxIsaVnsgnjpHMmAEYw5/6832Z0ITrzo7E/z0hN
         KxmAMyNN9tKOZDJ1zMhOm7839nkrT6N4n/eIc88luuXvXLkcvWnojC1iFeS4MRxJnfLz
         zajEboGaFstjthaPn5cLuqAzbavhUaMdHzgCt/ig90H6ISNK+rY+WXk5uPgHtPolj0cw
         RWvfdhoEcYtXyfgUkZX7Rfxdp+WkSgkPFH7R8uc3b80QAh/RrkdwrsD5NhxSqLJCSo2a
         xWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ps6oy10ORdikw70XKA0O8bVm8SaRqDQHF3zytkb03qM=;
        b=OGuxl6Wb3nu4IVOpZwsQEvLXbz681wg/ahNC5/2l0b2hqI3j+oIvvfY5QrVG1EUADi
         e/ReyRBhyqjxHbstAnh3h1oigtM5ib90aXEGE2ouKIrL8Lh8ZUTMqYlOxWbkysdVSwGn
         8nzWLK9CynjGnaC3LqAKG5bEh/olKfTOJJTMf/TWYPIHK9YXr2Yd69p6ERkw+Lf5p6mF
         rnUNB9fSxctQyda844p5gZ/DZgLm+t1NswJ0mT7RTsa96ii8WAQswH9vBmU3F/P86aWw
         r0sdiEgPyNtQI2i/bA//qGSa3EiEl715jWo0nNRHR3s5UgbODGiPxdFkZsoWnWgBbcSh
         OhGA==
X-Gm-Message-State: AOAM530LiLJxqOToTIfwP+mZnYmkEY0j5FoyYRrzzu+Lip30s7u3ICIy
        QzB61OA1vZtVlzoS79jex00=
X-Google-Smtp-Source: ABdhPJyTAgqrwRdZP1j6C9LpWaBsGtPZvOlIDukUOwzhQk9h9U88BuYYYbnw4mXuA8xJBLi49arH2Q==
X-Received: by 2002:a17:906:c289:: with SMTP id r9mr20901895ejz.402.1599553254323;
        Tue, 08 Sep 2020 01:20:54 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g24sm13172326edy.51.2020.09.08.01.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:20:53 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v6 1/3] dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
Date:   Tue,  8 Sep 2020 11:20:48 +0300
Message-Id: <c2046b747574ea56c1cf05c05b402c7f01d5e4fc.1599552438.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
and S900 SoCs and provides support for handling up to 3 external
interrupt lines.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v6:
 - Got rid of the 'actions,owl-sirq' compatible, per Robs's feedback
 - Replaced 'actions,ext-interrupts' with 'interrupts', as agreed with
   Rob and Marc

Changes in v5:
 - Updated controller description statements both in the commit message
   and the binding doc

 .../actions,owl-sirq.yaml                     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
new file mode 100644
index 000000000000..5da333c644c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoCs SIRQ interrupt controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
+  and S900) and provides support for handling up to 3 external interrupt lines.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-sirq
+      - actions,s700-sirq
+      - actions,s900-sirq
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the input IRQ number, between 0 and 2, while the second
+      cell is the trigger type as defined in interrupt.txt in this directory.
+
+  'interrupts':
+    description: |
+      Contains the GIC SPI IRQs mapped to the external interrupt lines.
+      They shall be specified sequentially from output 0 to 2.
+    minItems: 3
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - 'interrupts'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sirq: interrupt-controller@b01b0200 {
+      compatible = "actions,s500-sirq";
+      reg = <0xb01b0200 0x4>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ0 */
+                   <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ1 */
+                   <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>; /* SIRQ2 */
+    };
+
+...
-- 
2.28.0

