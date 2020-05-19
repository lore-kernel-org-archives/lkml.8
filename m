Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C05C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEFD207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qGaloqvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgESOE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:04:58 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:9587
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbgESOE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:04:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5R8/SAh0dhHAtoMMTolIHdnQWnRVD8rHIVS4gxCSVL6MftPZWdTv+dYCUSKs48jBF9jOZ2MF3DXSJeI8BXmUE6wWvA7bXj7VleOSc+EEw6TR4MnzaJxi/SSkntxareYeXdLU5pWrgQCyN4JAdXGvXhARVkpeBQijBxvK/4dl69/qCPqTPR+YigYQZ0ITty31Lqeal3KvgsUoBK6I2qMXlSeLvcM/TJTERJ23SR7mQ1L0w9xoxTXQMhg/jrwbXMGqXBzHEGsxxEy2lchB+Du4IItxdeJvRRdn8DyChZEUm0Fjf8ij5q1+gME6yx5orRvzQ2LM6AL/PUn28NPKgSokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBvEJf0oabcgwzpi0IwPs/l5WrX1Dy4UZSYUiPRLB5E=;
 b=P8fiwH5B4QCDUnrjzwzrD9FxqiAF2bPq7jC3U/klCXqW3loNy7+pwgT9IHsUWYMe8le4XUzCFbVVaemlBaTkddJ6bzYIxVau+RvGaujUS0s78ic51w3h8wHVGw9mGpi8oIZP3dpAanbcE7LYgYnA2ESDCKLYsdFA2JY+oFT00HDHmiscxU1kGJ6rfrTlug7O3alVhoT+2gSZh+NnDurENgoNwubfoiB99xx/xr7vn5sMJUdcL7LM+87dmKp+YkzSlqOlocBnpCCdKOF1cocFeyWqSPneKhOyT21cTP/oWHKzLddOWsjtpQYA30CCcpbgQQTtzrIp72XH2zipSKjtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBvEJf0oabcgwzpi0IwPs/l5WrX1Dy4UZSYUiPRLB5E=;
 b=qGaloqvZlp8lt5VjY99dy6k7x0UeVpB54XtTMRcRdBQnpFNnkqzS9WX78U6j1cO1X0g/+1T7KWdcUIo0OhhQnaDIJ8I5Tz4ywzSJ320m/3vfbcHPZTDplW8Ze8C3gEG42gO6gNG6p1D1WsIRysp+G34akstqaqJLaUYz43xNG80=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 14:04:50 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 14:04:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        anson.huang@nxp.com, festevam@gmail.com, s.hauer@pengutronix.de,
        john.lee@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 2/4] dt-bindings: regulator: add pca9450 regulator yaml
Date:   Wed, 20 May 2020 06:05:05 +0800
Message-Id: <1589925907-9195-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589925907-9195-1-git-send-email-yibin.gong@nxp.com>
References: <1589925907-9195-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0128.apcprd03.prod.outlook.com (2603:1096:4:91::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Tue, 19 May 2020 14:04:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ee72500-f8a9-4a2d-3c70-08d7fbfd9859
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6429D5A0287B98315F681AF489B90@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgZIdKBL8D7cbdv4eDlOBkLTvStteW+X2ekKg96Uu9pYSL5fgG486m+odc3YpuCB+6I4Y5MM8C0A8cTHDu2xPd+yr1lT/qeCaSMtm36/DL2NvK9RhVSE33hLTghHIjUjmBYQgnr78fhHnhM/JNaTGBL72qkVjpCLQYGy0DmKGR+xSgJ76dC0B+QGLS9omrIsZhMK6m9OZZPc4pmr+bQj3R9ZCq6gFvvuVV1KEr5buMdOUGBZkVSiY2FApdci8HPtYeJKua9o8NDhGKzzI3zU0BBUasovgkQ+utW6BGiNtJA7bprv/EIJJZ2D3OxMfvx/OFcMQnGBzsewlOUknrkvFk5ZKFnbfxCi7gj0ztejoDgUlxulsqKkwje6YzEJ/nhz8ja1SPVhqHi8EaXACWce+yZ853MOc3RXqWKFRcXTv9ODOHoE9jg4GBVJ3EyoKYOz7Bd3ZO2KGBwlJZ2+BsdBtyU/ROYiWZkh9mt2UYRA3d9UE7sRsK5hdvVY6282iEOAyikgGe8Hd2bFWEjt+6c+P3TVcqHsH7G4CUA4pqJ8onvfJkenoqDd/CqEOSNzC+C7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(498600001)(966005)(6506007)(6486002)(5660300002)(4326008)(186003)(2906002)(2616005)(6636002)(956004)(16526019)(86362001)(52116002)(6512007)(26005)(8676002)(36756003)(6666004)(7416002)(8936002)(66476007)(66556008)(66946007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: K0gPAcs/fxydnulcUNb324uWFlwTO13knk14Ooc0csM7Q1noaY+vMuju7AeHEbGwkad4Rq9HLBIP7llkHJQmAKpKCKOZ7QshcWbNt868vS9CmCuOJnABTFZQPRY/UmaKxLvpss6kgy9LUmXxRgJ5eUwhJg7l06xPe0vshCNhWs3HWxKRi8XZ/EbwgWZNgJR9UBHIB2rt7Rt9hUlm9E4+u2QPW1zWiqUdgCVCngVN4Epoi6gM/XD+EA/1UlHaNH2wGBpEWD0MEazKmvH/8j+BZmpyg5+jFTFuxAxlYelwDL8/3L54fOiMW61HXfGwIj8fiallePsLQBZQPZT3NhGVUSY0pADxUvwKosTq2dqr4EwJyeilW/4oq/1X0lBc3tUPyGcvz5spKw094cbq9ZYbKZB2Z3Fn6WTAz5BywI+VVdbClULesrTtFxFxhlZV6+iXdym04Cy3xi5OoFjjqOqsSQSK3rS+FRgtKdMp4VrsZTM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee72500-f8a9-4a2d-3c70-08d7fbfd9859
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 14:04:50.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2Gur4akdCwOjY8vjr0xb2L1u3ELVhYWANr+c0HbqZRAKOy6EhZHIPLMX+UUu4Lmum8YhakdgGFi9cau4H/wwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding doc for pca9450 pmic driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 190 +++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
new file mode 100644
index 00000000..c2b0a8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pca9450-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCA9450A/B/C Power Management Integrated Circuit regulators
+
+maintainers:
+  - Robin Gong <yibin.gong@nxp.com>
+
+description: |
+  Regulator nodes should be named to BUCK_<number> and LDO_<number>. The
+  definition for each of these nodes is defined using the standard
+  binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Datasheet is available at
+  https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
+
+#The valid names for PCA9450 regulator nodes are:
+#BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
+#LDO1, LDO2, LDO3, LDO4, LDO5
+#Note: Buck3 removed on PCA9450B and connect with Buck1 on PCA9450C.
+
+properties:
+  compatible:
+    enum:
+      - nxp,pca9450a
+      - nxp,pca9450b
+      - nxp,pca9450c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller
+
+    patternProperties:
+      "^LDO[1-5]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^LDO[1-5]$"
+            description:
+              should be "LDO1", ..., "LDO5"
+
+        unevaluatedProperties: false
+
+      "^BUCK[1-6]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single BUCK regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^BUCK[1-6]$"
+            description:
+              should be "BUCK1", ..., "BUCK6"
+
+          nxp,dvs-run-voltage:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            minimum: 600000
+            maximum: 2187500
+            description:
+              PMIC default "RUN" state voltage in uV. Only Buck1~3 have such
+              dvs(dynamic voltage scaling) property.
+
+          nxp,dvs-standby-voltage:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            minimum: 600000
+            maximum: 2187500
+            description:
+              PMIC default "STANDBY" state voltage in uV. Only Buck1~3 have such
+              dvs(dynamic voltage scaling) property.
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic: pmic@25 {
+            compatible = "nxp,pca9450b";
+            reg = <0x25>;
+            pinctrl-0 = <&pinctrl_pmic>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+            regulators {
+                buck1: BUCK1 {
+                    regulator-name = "BUCK1";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <2187500>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <3125>;
+                };
+                buck2: BUCK2 {
+                    regulator-name = "BUCK2";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <2187500>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <3125>;
+                    nxp,dvs-run-voltage = <950000>;
+                    nxp,dvs-standby-voltage = <850000>;
+                };
+                buck4: BUCK4 {
+                    regulator-name = "BUCK4";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <3400000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                buck5: BUCK5 {
+                    regulator-name = "BUCK5";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <3400000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                buck6: BUCK6 {
+                    regulator-name = "BUCK6";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <3400000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo1: LDO1 {
+                    regulator-name = "LDO1";
+                    regulator-min-microvolt = <1600000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                ldo2: LDO2 {
+                    regulator-name = "LDO2";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1150000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                ldo3: LDO3 {
+                    regulator-name = "LDO3";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                ldo4: LDO4 {
+                    regulator-name = "LDO4";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                ldo5: LDO5 {
+                    regulator-name = "LDO5";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
-- 
2.7.4

