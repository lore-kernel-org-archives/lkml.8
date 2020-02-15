Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F68C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 14:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E52217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 14:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T9EsM/Rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgBOORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 09:17:06 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60138 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgBOORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 09:17:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01FEGqZh044799;
        Sat, 15 Feb 2020 08:16:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581776212;
        bh=WZXkWl3IfnVa0IDvxbQPCJ82BydIGf/LaycMkPFaGPg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T9EsM/RfcUFXnhV+ne8jVZ0dLaxhy1GjVIjcRtL03kiZsh2JJDePK6kiCyPiqFhU/
         qJyM9NKdnfu2YE5+PvCLFgONIyHHBxkTIOXV3onVQdgLfrSGDVqLbO9OInDk9zeJmR
         8u2lVBIUnIhjEu9/Rk/kg3YbxHisiCrHJiaRTiDs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01FEGqZS077545
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Feb 2020 08:16:52 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sat, 15
 Feb 2020 08:16:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sat, 15 Feb 2020 08:16:51 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01FEGjP6004147;
        Sat, 15 Feb 2020 08:16:49 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: clock: Add binding documentation for TI syscon gate clock
Date:   Sat, 15 Feb 2020 19:47:23 +0530
Message-ID: <20200215141724.32291-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200215141724.32291-1-vigneshr@ti.com>
References: <20200215141724.32291-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for TI syscon gate clock driver that is used to control
EHRPWM's TimeBase clock (TBCLK) on TI's AM654 SoC.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
new file mode 100644
index 000000000000..3bf954ecb803
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI syscon gate clock driver
+
+maintainers:
+  - Vignesh Raghavendra <vigneshr@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,am654-ehrpwm-tbclk
+      - const: syscon
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - reg
+
+examples:
+  - |
+    ehrpwm_tbclk: syscon@4140 {
+        compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+        reg = <0x4140 0x18>;
+        #clock-cells = <1>;
+    };
-- 
2.25.0

