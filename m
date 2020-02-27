Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C335EC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9197624680
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EUKO06WG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgB0FfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:35:18 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53024 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB0FfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:35:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01R5ZCOb054711;
        Wed, 26 Feb 2020 23:35:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582781712;
        bh=enAypGWazK2kqwZ8nxNXMQcJLm8H/qWvCmZ0pdJVfVQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EUKO06WGbdpknYBwRrZYpjeL4SNKXAeoveknl25I8RTtmPuMffja1Vj8xMgxnmNJC
         6Zzv3IGkCLWKt0pmnqf/ijp3H/yRUOFSci6+Zj8KKlxqDXmcSd6Ts5nDVeH36VBL4i
         qkF6OpXnfaYjynh8HzJcwd5NSxAnsTYQbCV/e9zY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01R5ZCbR020305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 23:35:12 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 23:35:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 23:35:12 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01R5Z6ef022834;
        Wed, 26 Feb 2020 23:35:09 -0600
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
Subject: [PATCH v4 1/2] dt-bindings: clock: Add binding documentation for TI EHRPWM TBCLK
Date:   Thu, 27 Feb 2020 11:05:28 +0530
Message-ID: <20200227053529.16479-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227053529.16479-1-vigneshr@ti.com>
References: <20200227053529.16479-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for TI EHRPWM's TimeBase clock (TBCLK) on TI's AM654 SoC.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
new file mode 100644
index 000000000000..869b18ac88d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI EHRPWM Time Base Clock
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
2.25.1

