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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81FDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3526208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjYvfiUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgH1JZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgH1JYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:24:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812BC06121B;
        Fri, 28 Aug 2020 02:24:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so318965pjq.0;
        Fri, 28 Aug 2020 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=htXOCVPrq8HdJeur07eO9bXCbnwDHC4OtbEI9rP9Tn4=;
        b=ZjYvfiUHWn6qehl41HAVN9MqkMLYMd1N1f2XYzRGEsH4Fm4wlkCNW0vbRL7jFh0pRC
         3EVL2pLNlBbx1ES7doz+uRkg63ku2FJvNDTRZy2bJcGWm51jN4SM2KJ1NlMoylEBA0tw
         4Q0W4DDa4aji4Qy0KWMM1l0F9VzH7KiAkeuZqmX7+6yNKAUA5tH9mOqXPLUBcR+RLPRs
         d+3Z4fFh5wLml/0GwHJualYTyRME93NCPdJARqL58hG3iXWgGltsHyLMDsgfrPDOi1oe
         uQE6MCXJ8+Zvlmq/XCmNNRwAmSO0Ufja96aovK6Y3Sy8YZ/l6g4d772FZ+kwzvW8ZIkk
         XKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=htXOCVPrq8HdJeur07eO9bXCbnwDHC4OtbEI9rP9Tn4=;
        b=UWX3+pg1Xdw9Er8nDk6UR9rm9QJjDOd21JUp++60AWbWjoXjro7zWuhbp+97yYnpWm
         W/6qosKXHuuqwY7tOcpl/+saNP/VgH49ySRp7x4eztr2kL3PLk54CKfZ1ZUPGo0TAE2p
         zCZUZHNmOR7bBVE/keLV8d+gqSv2+d6UmUMsld4Kh/Rn8owrnS4tAzClh4RkyAGEeDeg
         UXJ0g7rwBa2X/1Y0bEIv8BL3TtBshfUAPTYKDSya3IfJ58yYFBpr9vQDlJwngUSGBdW6
         qdWDOooq4UwuNksbL81NnZ0j1tjt3/BlllqYrdXqcYAq21mXjR6kTk+S7TJEFb4srINf
         i/cQ==
X-Gm-Message-State: AOAM531yIs1FYZKznID9Weq7+tMJA3zXhMPE7Vs+E/TrNDWQjbs3eFhu
        2lRtqF41T1VEk5zS34rUciQ=
X-Google-Smtp-Source: ABdhPJwmM74/2Z6OmFics2+KVisBB1kXdKlLOQYV835VuXBGe2zlkLUneUWcyioQm8nI52NOwQVmhw==
X-Received: by 2002:a17:90a:1992:: with SMTP id 18mr441099pji.135.1598606689274;
        Fri, 28 Aug 2020 02:24:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:912:593d:4bfb:3bf8:35e0])
        by smtp.gmail.com with ESMTPSA id n68sm813563pfn.145.2020.08.28.02.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 02:24:48 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
Date:   Fri, 28 Aug 2020 17:24:34 +0800
Message-Id: <1598606674-32326-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598606674-32326-1-git-send-email-u0084500@gmail.com>
References: <1598606674-32326-1-git-send-email-u0084500@gmail.com>
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

