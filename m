Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58078C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EB32076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbgFWCwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731964AbgFWCvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC84FAE89;
        Tue, 23 Jun 2020 02:51:40 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 24/29] dt-bindings: soc: realtek: rtd1195-chip: Allow nvmem-cells property
Date:   Tue, 23 Jun 2020 04:51:01 +0200
Message-Id: <20200623025106.31273-25-afaerber@suse.de>
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

Allow to optionally specify nvmem cells to identify the chip.
RTD1295 family will want the eFuse package_id cell.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Instead of extending reg, allow nvmem-cells reference for eFuse
 
 .../bindings/soc/realtek/realtek,rtd1195-chip.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
index dfe33c95f68d..57a6e0df4494 100644
--- a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
+++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
@@ -22,6 +22,10 @@ properties:
 
   iso-syscon: true
 
+  nvmem-cells: true
+
+  nvmem-cell-names: true
+
 required:
   - compatible
   - reg
@@ -40,4 +44,12 @@ examples:
         reg = <0x9801a200 0x8>;
         iso-syscon = <&iso>;
     };
+  - |
+    chip-info@9801a200 {
+        compatible = "realtek,rtd1195-chip";
+        reg = <0x9801a200 0x8>;
+        iso-syscon = <&iso>;
+        nvmem-cells = <&efuse_package_id>;
+        nvmem-cell-names = "efuse_package_id";
+    };
 ...
-- 
2.26.2

