Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBEEC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC1422464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X7F/D8y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgBGEn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:43:58 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33646 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBGEn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:43:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0174hrp3125809;
        Thu, 6 Feb 2020 22:43:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581050633;
        bh=XP+OOfItiOjqBusVos+C2GAWEl5MFhK0cPoMBEWJerY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X7F/D8y3NPB2GDY/mI7lUK5rfIn2nzUGCSl8rxzz8/pUqns25nAo7RNFu34Ai5vb9
         NQ8MbO5sMqhhevP/RDFoCidd/MFSFJXDPivDVTKNsqbRBU2hBkHDWu5vRQ+nd2MPah
         Bhgbkl3aioNzjVDF1cIzxB2VzFZZHI/dMo1nUlgA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0174hr8T051347;
        Thu, 6 Feb 2020 22:43:53 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 6 Feb
 2020 22:43:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 6 Feb 2020 22:43:53 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0174hkKD120043;
        Thu, 6 Feb 2020 22:43:50 -0600
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
Subject: [PATCH v2 1/2] dt-bindings: clock: Add binding documentation for TI syscon gate clock
Date:   Fri, 7 Feb 2020 10:14:24 +0530
Message-ID: <20200207044425.32398-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207044425.32398-1-vigneshr@ti.com>
References: <20200207044425.32398-1-vigneshr@ti.com>
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
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
new file mode 100644
index 000000000000..98fcac2b41f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
@@ -0,0 +1,47 @@
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
+description: |
+
+  This binding uses common clock bindings
+  Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+properties:
+  compatible:
+    items:
+      - const: ti,am654-ehrpwm-tbclk
+
+  "#clock-cells":
+    const: 1
+
+  ti,tbclk-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the system controller node that has bits to
+      control eHRPWM's TBCLK
+
+required:
+  - compatible
+  - "#clock-cells"
+  - ti,tbclk-syscon
+
+examples:
+  - |
+    tbclk_ctrl: tbclk_ctrl@4140 {
+        compatible = "syscon";
+        reg = <0x4140 0x18>;
+    };
+
+    ehrpwm_tbclk: clk0 {
+        compatible = "ti,am654-ehrpwm-tbclk";
+        #clock-cells = <1>;
+        ti,tbclk-syscon = <&tbclk_ctrl>;
+    };
-- 
2.25.0

