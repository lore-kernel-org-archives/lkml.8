Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E302EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C155C207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbgFWCvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:51:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731858AbgFWCve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6987AE70;
        Tue, 23 Jun 2020 02:51:31 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 05/29] dt-bindings: soc: realtek: rtd1195-chip: Add iso-syscon property
Date:   Tue, 23 Jun 2020 04:50:42 +0200
Message-Id: <20200623025106.31273-6-afaerber@suse.de>
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

Allow to optionally specify a phandle to iso syscon to identify the chip.
RTD1295 family will want to check the ISO_CHIP_INFO1 register.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 A SoC specific binding would defeat the purpose of the generic Linux driver
 detecting the SoC based on registers.
 Simply allowing it all for SoC families seems the most flexible.
 
 v1 -> v2:
 * Instead of extending reg, allow optional iso-syscon property for RTD129x.
   Iso syscon currently does not have a compatible, and it may need to differ
   across SoC families.
 
 .../bindings/soc/realtek/realtek,rtd1195-chip.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
index 86a1de214782..dfe33c95f68d 100644
--- a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
+++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 description: |
   The Realtek DHC SoCs have some registers to identify the chip and revision.
+  To identify the exact model within a family, further registers are needed.
 
 properties:
   compatible:
@@ -19,6 +20,8 @@ properties:
   reg:
     maxItems: 1
 
+  iso-syscon: true
+
 required:
   - compatible
   - reg
@@ -31,4 +34,10 @@ examples:
         compatible = "realtek,rtd1195-chip";
         reg = <0x1801a200 0x8>;
     };
+  - |
+    chip-info@9801a200 {
+        compatible = "realtek,rtd1195-chip";
+        reg = <0x9801a200 0x8>;
+        iso-syscon = <&iso>;
+    };
 ...
-- 
2.26.2

