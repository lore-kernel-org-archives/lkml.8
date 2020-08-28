Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B239BC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8710E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSBYefrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgH1KbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgH1Kax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:30:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38706C06121B;
        Fri, 28 Aug 2020 03:30:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so434603pfb.10;
        Fri, 28 Aug 2020 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=htXOCVPrq8HdJeur07eO9bXCbnwDHC4OtbEI9rP9Tn4=;
        b=jSBYefrAZXpv+3xnFQAVI3JPtpbLw5e930QLjDyJDlEkHKYU2qNN12+NjMaQQzrdhQ
         fdX6N3fidTAAbijg9JQiMFWxIUcc3HVVueSN6wzz9SPfw4uiExWh6sznbWhsU/Fcu3KM
         R20xoHhTwxxlJ0aX2p8ly+aJYWVGThFICBRCqj/xEspdxM8KdfNk92AIRQZ9NmydSJ81
         dOtxXTo9mkC3FY+NqlDGvv/ePYMpgKGMukDsFJJxYTSCPYdjbK0P1gk9DCCzj3Vnzd98
         O5zhLjChK8mr5lIrUoXUs9vrpIdA/M94HcRFLeLMaEfA7MimARXiG7Z11228tIuv2kNr
         1reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=htXOCVPrq8HdJeur07eO9bXCbnwDHC4OtbEI9rP9Tn4=;
        b=iGJ2Id1or82QR7+1jd3ixZ5IfcvUePNaGyQ5pOg/rtdunvasatjM/rM35tKNFtxudq
         nrdsizFV+xOMnBFR5FGAPiV3lqTu8oo874seNYAUiOV9Ey0BX5ceO5H4mIlAbRpNz7pG
         CZ1RfQI1h7NlN5qpgYk7EJRHK+DjHDJjrLv7mzyNl2Cz5YN2Ops7fRQVK8TLvkjtv+UI
         EgY/WLyGvU3YhyQ65YEFTQvssmK8MDL1XO6W3/gpyPh0CyTUOCJ2DxSKx32RP+03YLiZ
         7Kli5dd/79S3oNdjYR3SAnVi5a9QFxXdg3WcUsv7lVKaFyAvhwYACucy0RDhYtahGPtK
         9cbg==
X-Gm-Message-State: AOAM530jgxzvyrLBuEvjToY+4Mx2X3K0Y5bSD6hZPyzQv6J2dWbLOn7V
        tvraMsJU3FenAL5l6cl63Jk=
X-Google-Smtp-Source: ABdhPJzAikASnfF5fhZ0b1hQfPKicQB/myOGamaEIpzFEbCmIe0pEQH3qzKz0PISqby+vMHZzrUaeQ==
X-Received: by 2002:a62:4ed4:: with SMTP id c203mr688174pfb.151.1598610649951;
        Fri, 28 Aug 2020 03:30:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:912:790c:5a03:60b5:8987])
        by smtp.gmail.com with ESMTPSA id g25sm1232224pfk.37.2020.08.28.03.30.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 03:30:49 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
Date:   Fri, 28 Aug 2020 18:30:36 +0800
Message-Id: <1598610636-4939-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
References: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add a devicetree binding documentation for the MT6360 Type-C driver.

usb typec: mt6360: Rename DT binding doument from mt6360 to mt636x

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
new file mode 100644
index 00000000..9e8ab0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek MT6360 Type-C Port Switch and Power Delivery controller DT bindings
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Mediatek MT6360 is a multi-functional device. It integrates charger, ADC, flash, RGB indicators,
+  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6360 Type-C Port Switch and Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6360-tcpc
+
+  interrupts-extended:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: PD_IRQB
+
+patternProperties:
+  "connector":
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts-extended
+  - interrupt-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mt6360@34 {
+            compatible = "mediatek,mt6360";
+            reg = <0x34>;
+
+            tcpc {
+                compatible = "mediatek,mt6360-tcpc";
+                interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+                interrupt-names = "PD_IRQB";
+
+                connector {
+                        compatible = "usb-c-connector";
+                        label = "USB-C";
+                        data-role = "dual";
+                        power-role = "dual";
+                        try-power-role = "sink";
+                        source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+                        sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+                        op-sink-microwatt = <10000000>;
+                };
+            };
+        };
+    };
+...
-- 
2.7.4

