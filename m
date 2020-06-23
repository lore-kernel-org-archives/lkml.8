Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8702076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbgFWCve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:32924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731842AbgFWCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AA9FAE35;
        Tue, 23 Jun 2020 02:51:29 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 01/29] dt-bindings: soc: Add Realtek RTD1195 chip info binding
Date:   Tue, 23 Jun 2020 04:50:38 +0200
Message-Id: <20200623025106.31273-2-afaerber@suse.de>
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

Define a binding for RTD1195 and later DHC SoCs' chip info registers.
Add the new directory to MAINTAINERS.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Note: The binding gets extended compatibly twice with additional properties.
 Could be squashed later if approved.
 
 v1 -> v2:
 * Dropped quotes for compatible (Rob)
 * Added additionalProperties: false (Rob)
 
 .../soc/realtek/realtek,rtd1195-chip.yaml     | 34 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml

diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
new file mode 100644
index 000000000000..86a1de214782
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/realtek/realtek,rtd1195-chip.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Realtek Digital Home Center chip identification
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |
+  The Realtek DHC SoCs have some registers to identify the chip and revision.
+
+properties:
+  compatible:
+    const: realtek,rtd1195-chip
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    chip-info@1801a200 {
+        compatible = "realtek,rtd1195-chip";
+        reg = <0x1801a200 0x8>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d282ee3492e0..78adbc3cc101 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2307,6 +2307,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/realtek.yaml
+F:	Documentation/devicetree/bindings/soc/realtek/
 F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
-- 
2.26.2

