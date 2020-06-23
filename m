Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D519C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88332076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgFWCwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbgFWCvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D6B6B199;
        Tue, 23 Jun 2020 02:51:37 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 17/29] dt-bindings: nvmem: Add Realtek RTD1195 eFuse
Date:   Tue, 23 Jun 2020 04:50:54 +0200
Message-Id: <20200623025106.31273-18-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT binding for eFuse on Realtek Digital Home Center SoCs.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 .../bindings/nvmem/realtek,rtd1195-efuse.yaml | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/realtek,rtd1195-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/realtek,rtd1195-efuse.yaml b/Documentation/devicetree/bindings/nvmem/realtek,rtd1195-efuse.yaml
new file mode 100644
index 000000000000..a616cb22673e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/realtek,rtd1195-efuse.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/nvmem/realtek,rtd1195-efuse.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Realtek Digital Home Center eFuse
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |
+  The Realtek DHC SoCs have an eFuse block with non-volatile OTP memory.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: realtek,rtd1195-efuse
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    efuse@18017000 {
+        compatible = "realtek,rtd1195-efuse";
+        reg = <0x18017000 0x400>;
+    };
+  - |
+    efuse@98017000 {
+        compatible = "realtek,rtd1195-efuse";
+        reg = <0x98017000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        efuse_package_id: package-id@1d8 {
+            reg = <0x1d8 0x1>;
+            bits = <0 2>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index ff0ee48fee6f..1d0d6ab20451 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2307,6 +2307,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/realtek.yaml
+F:	Documentation/devicetree/bindings/nvmem/realtek,rtd1195-efuse.yaml
 F:	Documentation/devicetree/bindings/soc/realtek/
 F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
-- 
2.26.2

