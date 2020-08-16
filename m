Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EE6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B1F20760
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2InCRRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgHPLhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgHPLe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:34:29 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2791DC061385;
        Sun, 16 Aug 2020 04:34:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so10123339eds.2;
        Sun, 16 Aug 2020 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pASTdGuPftaeTWSCXTF0+lwxdm1UnEjBR3A/qFpOqAQ=;
        b=I2InCRRd5xgKuWxHbUvIzN64E3tJfg+5Hs1GBxpc+F5ecJWbP8lm5HB+sb35BcvuVZ
         KXqDH3dkgL0Ep00fgmmqt70nCxrZDhcAe+NZAyZMlROJhngNpykETkvu6uu0Xm1+VuJO
         Dh2GLx7Q4shBeRDfz+VsI1jAsPT2fVGn0LODq6K3N916SyJNf/n2jA+DdgtFskl9qZeN
         85CiJW1a5KLa3S/+WSJWUgir0qDxuugu5ASL9EIzq8rEC6dM+czC+2hVASqZGEsDSfbg
         pNvpze2oOHb3B/ZfdIbz5G4mqA0RWpDdqY7K6af7SI89olqGMyGP+5yO+0yINnl0bG+D
         pyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pASTdGuPftaeTWSCXTF0+lwxdm1UnEjBR3A/qFpOqAQ=;
        b=cyxKVtcSu/35Mm/hcqx5pla8ZRnrhLTyvj5vjGNQHv6qz90d+nhsmpY9mQcQ0yq0tV
         jRuipy2RGRs3Nl4gjz3dLvzcGGjXrJkucQom9nmjHOA+bSbBPv4alqmOpuQWMB+i6LaL
         kSwfDXARCYIqWntt+YNB+YbyqoQFklNtNQj/PtZiQHOrQZZtSV8NfXalLd55nbxnsK2t
         zo2cj3kkt03ZWBopskYuXsSXaPUC6jSiqOrlAHmVXjGG/V4rEV4YJ4uLx449dvimGBND
         hRqrC5gMuzvGAZaj9seNmYBaRvJWZD16QJZ1CSwQ+l3FiswjcV5D5WPeEIVZk2INIjYh
         NlHA==
X-Gm-Message-State: AOAM5323cQ3wzN0lR6M19lk3rrIGekEL43h2G/F4ZNJinZB8rsiFzp2/
        rsAkUP4uIoa7bQJqxkizLXk=
X-Google-Smtp-Source: ABdhPJxs8Amnz2/5iDHD63BHcgYMrRkARtzwlXg1devjc6qDigDBj+XdHUxnwGKvaJ9jZmo267tTiA==
X-Received: by 2002:a05:6402:1d92:: with SMTP id dk18mr10221674edb.206.1597577640766;
        Sun, 16 Aug 2020 04:34:00 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id p1sm11272945edu.11.2020.08.16.04.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 04:34:00 -0700 (PDT)
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
Subject: [PATCH v4 1/3] dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
Date:   Sun, 16 Aug 2020 14:33:54 +0300
Message-Id: <2dfc51680d37eea74374a130e7c9bc40e06b1b0e.1597571397.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
References: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
and S900 SoCs and provides support for connecting up to 3 independent
external interrupt controllers through dedicated SIRQ pins.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 .../actions,owl-sirq.yaml                     | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
new file mode 100644
index 000000000000..b9903f9d7449
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -0,0 +1,69 @@
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
+  and S900) and provides support for connecting up to 3 independent external
+  interrupt controllers through SIRQ0, SIRQ1 and SIRQ2 pins.
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

