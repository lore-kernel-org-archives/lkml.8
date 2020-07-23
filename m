Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F8BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B5520888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l1g7SCF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGWIqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:46:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53964 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGWIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:46:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kew5107714;
        Thu, 23 Jul 2020 03:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595494000;
        bh=t9YE4lg+6PQxT8zKxJ+FacG5A5qj0EjARIpmw9jJFB0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=l1g7SCF4NUcPfKEnl7qw7znDEZgHspcupR1vKkFkx4Cbr4ashXkogIHOco0pq78d8
         LYYWVZ8W0uH86l519DfVWqjYAhYx7+GJ9rryf0E00uEMhFgxjdb/K0EludwE3hj3Zr
         273Y59rZ+UJfKKaIt16MiJl8IodV6iXH/nX+zfxg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06N8keTV026191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 03:46:40 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 03:46:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 03:46:39 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kTEM123087;
        Thu, 23 Jul 2020 03:46:37 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/4] dt-bindings: arm: ti: Convert K3 board/soc bindings to DT schema
Date:   Thu, 23 Jul 2020 14:16:26 +0530
Message-ID: <20200723084628.19241-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723084628.19241-1-lokeshvutla@ti.com>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert TI K3 Board/SoC bindings to DT schema format.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../devicetree/bindings/arm/ti/k3.txt         | 29 -------------------
 .../devicetree/bindings/arm/ti/k3.yaml        | 28 ++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 29 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.yaml

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
deleted file mode 100644
index 33419cce0afa..000000000000
--- a/Documentation/devicetree/bindings/arm/ti/k3.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Texas Instruments K3 Multicore SoC architecture device tree bindings
---------------------------------------------------------------------
-
-Platforms based on Texas Instruments K3 Multicore SoC architecture
-shall follow the following scheme:
-
-SoCs
-----
-
-Each device tree root node must specify which exact SoC in K3 Multicore SoC
-architecture it uses, using one of the following compatible values:
-
-- AM654
-  compatible = "ti,am654";
-
-- J721E
-  compatible = "ti,j721e";
-
-- J7200
-  compatible = "ti,j7200";
-
-Boards
-------
-
-In addition, each device tree root node must specify which one or more
-of the following board-specific compatible values:
-
-- AM654 EVM
-  compatible = "ti,am654-evm", "ti,am654";
diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
new file mode 100644
index 000000000000..b8ecb430429f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti/k3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 Multicore SoC architecture device tree bindings
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  Platforms based on Texas Instruments K3 Multicore SoC architecture
+  shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,am654-evm
+          - const: ti,am654
+      - items:
+          - const: ti,j721e
+      - items:
+          - const: ti,j7200
diff --git a/MAINTAINERS b/MAINTAINERS
index d53db30d1365..4f2092e5282d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2597,7 +2597,7 @@ M:	Tero Kristo <t-kristo@ti.com>
 M:	Nishanth Menon <nm@ti.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+F:	Documentation/devicetree/bindings/arm/ti/k3.yaml
 F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
 F:	include/dt-bindings/pinctrl/k3.h
-- 
2.27.0

