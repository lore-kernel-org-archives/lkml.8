Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D528207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FBvl+JiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGCIGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:06:00 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:40128
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgGCIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVlthqE0TorOwXZ7zgatUK2LopcvyBNwiVKT15IG+PQd6WnwPPWTIpI0hGrCSG2OpOOrni7vTF1VzI9YD4CtYIBiS2l1+IKftKsaNDydsNT9LmZklYvpoQcNKx9AM2tJeO+PduXXJKsFXtDyHWE1hUrdTFslfd6ffZEM/uhVTMIijZ9jqxiPdUBP4fWxCxchRU/0VPL9TkXojLWKAuXS1dtmWYvofHnbRREbazvXObB3yZYPdQXkAof2FXTHiaujUYwaUWrlClRIFGdwpgoW3aoBjezVzqJ7vlRFC6SaNN9+7MQ2iV6vGQSQcd1jPRX6I8K/RzxYvl2uMHCfbCApbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaZn2Dp9YJTni9oBa5AX89n3ebdN3VokJQ1vr4rWkpM=;
 b=Mlf9kbj6eTg22zUQhzxXsTwBl/e/f6AXt4i7X0qHHkIcTYUdLz3P6NnB8nncAW3SpANpYViW1FaCjShLadpx8Z9Dr3ykLjp9RJiZ8HOhg5PgkP3UrdhCXvyaa59JNf+tAmwLm1PXGD0LKMMoKxF6hElSI6/L8AxNSwT1Vw38ItEOxU6ITDqGfAkLe1vbRFup8mdNwAJg3GLZrS2aI8OaG8OhKuBWo9ndue4Mme09UnZYsJI0wVdByzGhDcMv5SQrbTlqgrYQqt6BLyju5NOIsVa+TdhzjCzZOtKZXTZKRh/TAVm8GOlL+16Wd2W1uV8+txX/JjWEn6506GeXoEBvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaZn2Dp9YJTni9oBa5AX89n3ebdN3VokJQ1vr4rWkpM=;
 b=FBvl+JiPjdRmTE4Y8IMh2M+NQLoWVwtA1NnxV+VXBajjp82WMHnJgUFV9q3PbdnqGFXp7jXddnNSE6BeF4vjouJfaX1zztJ/KXcJgkUfLzQMZZk8xx9/m94Qb6Xzidk0Xfe3cXU7A1bTqsf20MLwn7daSblvnImY5E46SVYRgBU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2302.eurprd04.prod.outlook.com (2603:10a6:800:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 08:05:22 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 08:05:22 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        frieder.schrempf@kontron.de, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, anson.huang@nxp.com,
        festevam@gmail.com, s.hauer@pengutronix.de, john.lee@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v2 2/4] dt-bindings: regulator: add pca9450 regulator yaml
Date:   Sat,  4 Jul 2020 00:19:36 +0800
Message-Id: <1593793178-9737-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 08:05:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8dae1606-aab4-4fdf-ad5e-08d81f27d543
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2302EBD4A2DB2522CA8231BC896A0@VI1PR0401MB2302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUofrX3kgEtKokpnvG6GKNa4AM/qXJ2yHeG8Bv3BIQO3qqYe+4lQMXd5LnEE6SBtx51arQyJaYXrDJh7dNQxaZwwP2cwco00Qe+bw3ccxNIApiXsT4rr8My38EPnZcAVaAUoZdjiT6KVwEnfeHf3z1wLStTijC3puwdkePSnvuyVSoXqJOPQ2zXU3t4fHAIGHKmTGiw+3N0dJE+O9ers+LCW2cZJTRDDNl/pw+IRhAjCIJ+lJfr/AE5mKRht6j3PcTxP1tC300xXOC8n0z0vPXs74aBz/eERoZQBaSzAKVoPmCdIVD8dNDXsoNPn1nLcwbBRT0JcuTu1IrFU4wZq93eRVUqhTbTVPUILJjnR0Lvjeq6mz+MgFk77dx/N1WHWmQoZEeBqUAu8/fIXzcVieJKwXhnj5ArHO6C2rF48X7qrn9+TwIIxOaiAzEE0S7zD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(7416002)(6512007)(8676002)(6636002)(6666004)(8936002)(86362001)(52116002)(478600001)(5660300002)(16526019)(316002)(6506007)(2906002)(966005)(4326008)(2616005)(66556008)(26005)(186003)(66946007)(36756003)(956004)(6486002)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /fJ8weH4FA4bKqyUgdZsMZuOYa7aSykRPtkE3XecmagTG8pYAx4p7OsCy/fJgzOKuU1ompDR2XiQIU1VHf/1/YQKQYdSnd0qxItonrVBrQ4PD7ztY/eILS6lpe250gsW+8X+5MlnaMZU7UzOScUA3uLn8rpQVobVuddlDe/eYGzv8sDaZTlDOv1EYoH3i8EaPANtW4++t8IdsSPA6GX5BZR3in4bUFyvR1rv5YpvDZu7Uo9NIBBGsttaFffdQT/RXUfIJmQGxC7naZgYZfneKnbv+BOwhlLOmSNQ+Exq+vmm9EBxWDQ/jXLsmpzDkLFdpnPSxZ1O4eHD8Ka4YSt6uD5BTLXuTZxHNhy+IWaJhO+Ppn88SUZfVD/MN02e2DTIBFcozxA1/H5Kn5Bwq270NqWL0I1qWy05dejTzypOarRNY0hVW+t93i5CD6tzID9VXonctYFoN7ixlGsMWLNyyrlimbzIkVtZf3h6yPHyqUw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dae1606-aab4-4fdf-ad5e-08d81f27d543
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:05:21.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9agee+jjp8bXnpZP/O/0b2WVUsfPJb0sWdaJ2UsVcU8so2uAESnnRlnizFMwh+20GwpW48jdjtwwxdn4K/RMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding doc for pca9450 pmic driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

