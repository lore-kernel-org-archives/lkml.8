Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6861207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/8D7+ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgHSQin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHSQiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:38:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6335C061383;
        Wed, 19 Aug 2020 09:38:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so27025230ejb.11;
        Wed, 19 Aug 2020 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TuH/A+TLhIqSrIh/+j5/Udbr5P8a39mUMZfeyoIlU/w=;
        b=D/8D7+ku6SuLxAxkrqYBmZtTY2pwUEyxTVhSH6OKU7hhbUc+xJIZ8x60PLkIX2fofP
         mmVUFjE+Uy3G/Mcwsloq3bLkpaPZTg6DeB3hh6AwhJbq2BREsjJAOkns9J2UnH99k6S2
         lncVGYk97MOTBtMRGZbA7gN2a0GIThuXF5lYj6SsEL7Yu3PP15GxLRED4RtX3Dp3YiVz
         LFN1x8oa6Rha41fIsB2RH1avptfU371iKfRGMCt6iq/Bs6E/b3agcZM4vBIAr5jjPpl5
         R+H7V26Q4C0bpiPCScX/X9Dh++dwA7O/BcAMCUeiSRdkJkehGmctFpeWe9nt9uy686+g
         dJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TuH/A+TLhIqSrIh/+j5/Udbr5P8a39mUMZfeyoIlU/w=;
        b=H+5rUFsCVCkwR1Sk3syoFn3LWFoAuDFUts14tkeRoz8F5qfMOAwtcDIcJjaF4HHJdd
         si6pcctU7TG7E7q/6WL+L3wiFLG3274yMF5jH5zyyWUqM9mnPEq3x2ZncOwlBeuk3j17
         mjoPgvjdiPxo9ZO526A75ZoJCs7uFlgIzpssFJrUq9bfUoJERl6anNE83p4LtxqSpdfX
         B2fLLvFpIPY5GPkAcaUrMcEEVaP+RrD9H9xWfx9B3eyntDG8VnbIbpNR0WnLoycwp5Zm
         +8EbWwtSldoDVYaZr1zK53TehBR09UTA6/9gk9kOLF2TL2ZElNN6z8yth8NBmhp2B0SX
         PG7w==
X-Gm-Message-State: AOAM5309eJy8wLJSk1gQnN06DQiqUdJ3LnIQTWz12RoyELePgkRzfLNx
        4vgJy25a5cfi3XUr42Q5p9o=
X-Google-Smtp-Source: ABdhPJyo3385Y+2uIOP+A+Fice2EOP+hjz7YqhO0o8J64f+YbCPbsU8/1z50hqp4u3O3AJ+fhvMxtQ==
X-Received: by 2002:a17:906:841:: with SMTP id f1mr5185696ejd.158.1597855082086;
        Wed, 19 Aug 2020 09:38:02 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id m13sm18310774edi.89.2020.08.19.09.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:38:01 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
Date:   Wed, 19 Aug 2020 19:37:56 +0300
Message-Id: <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
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
Changes in v5:
 - Updated controller description statements both in the commit message
   and the binding doc

 .../actions,owl-sirq.yaml                     | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
new file mode 100644
index 000000000000..cf9b7a514e4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -0,0 +1,68 @@
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
+    oneOf:
+      - items:
+        - enum:
+          - actions,s500-sirq
+          - actions,s700-sirq
+          - actions,s900-sirq
+        - const: actions,owl-sirq
+      - const: actions,owl-sirq
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
+  'actions,ext-interrupts':
+    description: |
+      Contains the GIC SPI IRQ numbers mapped to the external interrupt
+      lines. They shall be specified sequentially from output 0 to 2.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - 'actions,ext-interrupts'
+
+additionalProperties: false
+
+examples:
+  - |
+    sirq: interrupt-controller@b01b0200 {
+      compatible = "actions,s500-sirq", "actions,owl-sirq";
+      reg = <0xb01b0200 0x4>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      actions,ext-interrupts = <13>, /* SIRQ0 */
+                               <14>, /* SIRQ1 */
+                               <15>; /* SIRQ2 */
+    };
+
+...
-- 
2.28.0

