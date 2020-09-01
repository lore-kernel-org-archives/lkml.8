Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32D620719
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjuHh/3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIAClF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIACk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:40:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2DEC06137B;
        Mon, 31 Aug 2020 19:40:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so1849282pgl.2;
        Mon, 31 Aug 2020 19:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mpQRzRezfXU62e+8TDK+z83E5tTJuYg+gT1MoPG0gVY=;
        b=jjuHh/3CNZSy7dvGLvUmAbOXdMQ2I3W1R677A+eeozOOjWRmiz1ReDPkuODw50ytKV
         I7jAkkDBMuoemdQjizD79fOkLMy2QNycJfemfOhNA89BL+25in69H9JiU7teOSvMDKgF
         rjPCwpUo/sO6Ozf6kNfzFE6TOLJlxQSY36uI3IfS1y26Nlkl3Esbx8AEaP2LrbEED3th
         BcfDG3m6UHUACeOVgo5JkqF6HefbTzkjTJYQXAu8S3xv5iqMmw82C3gzr+pACvps0+v9
         kwcXuKzof8h11ugpFHUpQl8qpUm8VBH3akJGaZ5DHunDa9lzf1wgDdhcxh/NHhznleLx
         tBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mpQRzRezfXU62e+8TDK+z83E5tTJuYg+gT1MoPG0gVY=;
        b=HRyj7U+aOO4xS6QUZscn0qaNXHg5CRmqoDwbw6QyqydtyIusU831xTfNBy0chUAGnX
         dF0wLD96fFJW2o3Z67/duUucFc/q0HapF/JowXOQTr4TbOckgqWE+mu4VHDvTS8983lN
         LbLI4NMeAZLxeLCS36vL/DjI9+d+3p20g+/nJVVnkwQ6Ow5lOR3C+/ZD7eUp/P13Iene
         IpE/k4II8BHvPpXfhWmooVT6nFElJWVBlTyoMOour2tQgPti1JBiL2pi2clQcJOJJBbr
         zQ2qtYYm8vKEO/cnP9GfMrtiDEl1ltdaJ6HvVgDeHE4/PGNiP1pSPTjCfPUv8TLt/isu
         rjSQ==
X-Gm-Message-State: AOAM532tJDF8ZTn0eKP+iX4azoGtdlG2w35b7Mt6Y11B7pfgy4D1glPT
        efMuGi1FElbO/AsjLSiZHcY=
X-Google-Smtp-Source: ABdhPJz1exJ6TSG9FtABDIklkVB98Roi4JYSCOUPc6GzPAFpHNU5NhAle/okUZGBBC3SzyLrZWZPog==
X-Received: by 2002:a63:dc4a:: with SMTP id f10mr3533240pgj.394.1598928058419;
        Mon, 31 Aug 2020 19:40:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:32f7:442c:d2ca:adcb:b859])
        by smtp.gmail.com with ESMTPSA id u2sm933743pjj.57.2020.08.31.19.40.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 19:40:57 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
Date:   Tue,  1 Sep 2020 10:40:42 +0800
Message-Id: <1598928042-22115-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598928042-22115-1-git-send-email-u0084500@gmail.com>
References: <1598928042-22115-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add a devicetree binding documentation for the MT6360 Type-C driver.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
new file mode 100644
index 00000000..1e8e1c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
@@ -0,0 +1,95 @@
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
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: PD_IRQB
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mt6360@34 {
+        compatible = "mediatek,mt6360";
+        reg = <0x34>;
+        tcpc {
+          compatible = "mediatek,mt6360-tcpc";
+          interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+          interrupt-names = "PD_IRQB";
+
+          connector {
+            compatible = "usb-c-connector";
+            label = "USB-C";
+            data-role = "dual";
+            power-role = "dual";
+            try-power-role = "sink";
+            source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            op-sink-microwatt = <10000000>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                reg = <0>;
+                endpoint {
+                  remote-endpoint = <&usb_hs>;
+                };
+              };
+              port@1 {
+                reg = <1>;
+                endpoint {
+                  remote-endpoint = <&usb_ss>;
+                };
+              };
+              port@2 {
+                reg = <2>;
+                endpoint {
+                  remote-endpoint = <&dp_aux>;
+                };
+              };
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.7.4

