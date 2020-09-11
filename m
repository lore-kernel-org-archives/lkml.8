Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D131C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB00221D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PDE0DSKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKDhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:37:46 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:36230
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgIKDhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:37:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlJJuLepDnXuM92LB/B0YCTvCpOmJPIhvSqpKG9Ka33QJmB5LudHd6aw+xh0gIs6y1L8hvJhBPOUeSofCv1xdRorO9+mXv/16F5fL2NKktAkLwNGGyQ3QnvKDZHkhdz+sVoXxRTlUGh1/DmOghuAJad6N9cmzIst7ZOBmkTX9VpjrfXmRVfbz/GgVORpKltxl1UlKCBAkYLpoQ2SGoZSEfbmTmJpK394CNIhJGDGtlRXv4lBT9w8YsKanfUxcJ/RwaUqm6cDTa1dDauHxlgemS8sLwH6lilR2F3r2aB3B9wdjMp5FEOI3eAxiXHkkzdvfc0fCGkrW19fwHBu1OWvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkqNNX8tGoTJNzu7prVFfRg4yGpsrrdB+3Q1nbWK0E4=;
 b=b7fEt2bCGCQXgHhm5QfsipEi37FPi0mSW0vyH0sCsS493uNJYyJTrefL1VzOVunivVCwN/dNj7JHiQ0xZbLiiO+Hzce62aP//OxGYD1ON8wXdqdf4EBkz8Rf2qUf/xEmDR/43PULz5KZAJQY1sSilKVRp5juIl8g6VxHBe3FRDvhwAkmg2aINMHaNa58GPdHqNC3tHqlx48dJyjZQKrLznoNilB7nwI96UlfMJpX8qG9itlnCr0tX7YYhC0djn00GwIfVxMvyGkZ0JdYjfMKkREOPQenD7ZyqtMTNWUSUESQdzKsTCsm1FkGC+DrhSKzqd9hMoSXPtXI6K19wkmgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkqNNX8tGoTJNzu7prVFfRg4yGpsrrdB+3Q1nbWK0E4=;
 b=PDE0DSKrzqw9XlxRPCJiHZXMWTTLlHRyT4rdTggqWGHQ73lCZ1RkvGkGb+dTkGWaAYkGFsTzlEfd2FETG6kGsld9CNcb2WcB48EvIEuY9ruALWiFZRqISiIlmI/1PPRDfToXPG5654d4Ag4l4/1IgQSJWhmNaq82GTazLWVmgwE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 03:37:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Fri, 11 Sep
 2020 03:37:33 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Date:   Fri, 11 Sep 2020 11:30:50 +0800
Message-Id: <1599795053-5091-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:4:54::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 03:37:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4dfe1d9-8653-4a46-3b31-08d85604046b
X-MS-TrafficTypeDiagnostic: DB7PR04MB5084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB508414F120FC45384B74FDCE88240@DB7PR04MB5084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cg1v7sBId85YFfL74n/MgPDbAzQ3DuUFjv8zV/btsuxba+CafBfRcWv9a9Q1W/owrMZFUs52kNPBEAh+JZ73CN3UH+/HxjIE75KiDs26z4RL8ts3VtojLHwz7t/N+6CRmrBb4UXiRFLJ1H8wpLCsE4LcJhryjIb1u/qc80qE65RQkteQ2DMcJvj51Ux+1/ZUqO4V6NSC7yZH4NM/fvayzkFcJKBQL9DAZDatrYfAbZuRsxLqTCCMexYItQZmKuip9XOtu0VqtIQS7BFP4FEp8w0QG+Mp+yrSZ+V00/5BhmEdtp7nkZVfIUYXoJ2gPNFEzRqqGP60zLSckW/7N/TBNxUSj4mmfu11EQiyvDru+T8uqxjLzHcr0jBzgBGuwq/kaP5fb34O988+dovi6T5Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(2906002)(966005)(8936002)(5660300002)(4326008)(66946007)(6486002)(316002)(16576012)(478600001)(66556008)(66476007)(86362001)(36756003)(956004)(2616005)(26005)(16526019)(186003)(8676002)(6666004)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pgIvcdxCMEcxi/mcx53fN1wlNmknwrmmxG9L2+ykIfmJ+Y3rPZLvI2d/CCG2iTUKbP3IBGs7N0fRwoLm9ZxM3kzUnzy1SLHZFwQIV29a8Mfme79sEK/dK+KqhE8sSKXFUOa3uHODQO8X01TJsrqt1X8BnOWL/AGbBZCw/hfMfgH/NLaT1ylmOVxAA6Bgsy0uaABRX7Y+s7GrhxZIgwSNY6mXSO8feXdbxePG8XIo6RzE0dt/V7Cef39af2h+kuygsPDWg107bI1469uBxFrDmFXd4Ndeedd5IUyO10Qx4rb6Y50Bhbf+XtQmUu7g8GDV7g1SfaFvH/2htgxhqQBYOeYIfQyQZEUhE/sgdh7/u3GPCAbY7bgEaH0/OKvbXeKS3mmUzOI5QSmwzz10wtfXDx8635I+kaI5UuHshG3VdETKcCZXIdtkKxDyWqbQ8Ps9Q4pKQcde7JzePBaOi3lIimeAPh+uTHu7yhUvkMKLfWwPkRpxCBLLY4PUoh6oGXt5OtB3DWfirDogMxJjmbJpH1tA72hkLyc0dSLyE6Y5Cha0cLFjuTgHOxA9lwvEspeuZaEc8Womni/A1dfBiV7JtEYi/eVFg2/V52KA5sn2gJ62mx5wKrWXwrLlhizKFqsQUoyLw71ejbfSsolEKwbqKg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dfe1d9-8653-4a46-3b31-08d85604046b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 03:37:33.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWlyjcNHV7RY3NZ+SuOIxuEMG3MgyXkZz6mfXpql3mDI9rz40e1fXTZ0UNNyjcU04H6qWoqnOt4+TdV+vfWjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP Power Management Controller binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/arm/freescale/imx7ulp-pmc.yaml   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp-pmc.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/imx7ulp-pmc.yaml b/Documentation/devicetree/bindings/arm/freescale/imx7ulp-pmc.yaml
new file mode 100644
index 000000000000..33a31d87dd62
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/imx7ulp-pmc.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/imx7ulp-pmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX7ULP Power Management Controller(PMC) Device Tree Bindings
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx7ulp-pmc-m4
+          - fsl,imx7ulp-pmc-a7
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
+    pmc0: pmc-m4@410a1000 {
+        compatible = "fsl,imx7ulp-pmc-m4";
+        reg = <0x410a1000 0x1000>;
+    };
-- 
2.28.0

