Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C56C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2399220737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X5QYqljn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370398AbgDOMuJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:50:09 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:6154
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S370338AbgDOMtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A06RtMnieG7I1kIm8ygYH1RBJ2vPyMk6xhh777qb/RRdooFGwCALISG4GSppqJ5rMyrFfzBunRMrr0PRlY7JBuF4CJgAyJkmA+XR2WFGXC/BBuL+Xyrpc/v6zGLKHJzyZjGAYmBVQAB7WKufYPTMnOAPVXv+CxhH/pt6ehfcYSyfzQ355xFMDeuMULnr8yLQhcYjA/YC1Fhs4BwsY+60EDHhGtE6jGMCrlaVVnmYg73l5jamfi8AKC8yPY55REnW+bSJCbjAvjTj3tKYMLngXBFq7U4yZ/6a50xeX9oJcEea9jAvUbhDPIdobNhLwJgJf5itYDHxMllQ8ko5eKf1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dByjc0tAMfIXhOiJhJHOqIaqT4YU/kTo4Kdenzn1qY=;
 b=CcMXu9RtLqcGQmK7/URTQaIniwI2XC552/Kwwn6Aa2wOH+UitP3gA/pz4j1L4vFGv9DNlfCdyKqJHqPXMMBPZ3cMES0qnbw0E0xc2CfqAwXl6q0Ng3umCrFBzjyADUAV1sTgU5nXU7nlkGOqpkUBLxgNioqM79IxOejxk3uPuLvW8BB7JZ17mZkkbSN2IAfWVciMz7M1ebfZQLFNb2NQrUGHmGxwIGZcejnXgdqOUBXvtSZsXVBq1U2eO69Ot9jnHoz0LMxOhlo9WKp4X/tvrEIURWlpRte4foGkp5d7mRSLc9TtwPEj9m7hmXJFsA3XIiYJILuiMpkK+SbO1p3y5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dByjc0tAMfIXhOiJhJHOqIaqT4YU/kTo4Kdenzn1qY=;
 b=X5QYqljn4jGb5WbuiQHcLNNWfDbd1brkp++LYZx9cdEVPeKJp7Gm/okTqIe+jSAc96WY0sg8dcgofXKHsZbUiKKFMzEsI+kL9TxQzt6QUgKX6Nvegjj9zq/QPLPynb2Y/0RvUtz8pNXZB1Lza6tvXiFQ/oxDU9bDCGzXfVcEt3A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2856.eurprd04.prod.outlook.com (2603:10a6:4:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 15 Apr
 2020 12:49:09 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 12:49:09 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Date:   Wed, 15 Apr 2020 20:40:46 +0800
Message-Id: <1586954449-17463-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
References: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR02CA0098.apcprd02.prod.outlook.com (2603:1096:4:92::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.17 via Frontend Transport; Wed, 15 Apr 2020 12:49:05 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6140373a-d7b6-4320-8fb7-08d7e13b63d2
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2856:|DB6PR0402MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB28560CACB99C9A80C0C9987388DB0@DB6PR0402MB2856.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6486002)(66946007)(26005)(186003)(52116002)(16526019)(6506007)(956004)(5660300002)(2616005)(6512007)(4326008)(6666004)(2906002)(316002)(8936002)(966005)(69590400007)(66556008)(9686003)(36756003)(81156014)(8676002)(478600001)(86362001)(66476007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoekhTfE4jsnEr6cPOcSdUI0DZRfBNhWN7pDR/GR3qA6jqAks4rKW4WLDdrxFLWv+FlImisBFG9pilXN4zcONSKTXygMobIrnI/DV3BMthfY6Lg2rRSPgsbndJ38waTQsAP+qHOw624P2TKHhz4+YLGNV2sgdIIiQAef4tiF4cKd8HExdsRYskLgVTXo1FlW8bBu+O/uhvGL7YujwHvOKSQKbNbIyNckuMfpB5LFXy/Tcy5UpRnX/56aIrErsoWAHd7l9GkqrzkYK8pXKmPEgMu8f4a9A+kkyouwTkmo45nMO0k4Qb+sByU7KVGoorcIPDIv/AdKzrcj1q2QlX1/CiKdCJaTnQ08KmlgQS4McRJixDGPc18WX+hllVB/KnUjuWB6pgkYnf9neiSdbiKDyUSg0B9E4FdOzKgGtnFcrGuYWq+L8bS/8+wLgTSVl4g4i9BUr1Vyamc2/tnSSSsPo5QiovxwTGPqFXDGtcoYWgn7pELf0PNzX7uvTM2jjhSBBKr3RqaikPtiaki+eJxfgt3Hazc85oJW0t/kPebeeMdPmGQF6DZ07tlz9terGcUNo5PpYijkynzD93GgTMLaHA==
X-MS-Exchange-AntiSpam-MessageData: 1DDFCWNXnI/iz78KZakS19QrwunLvlUfIR1rn0E2O3PU8ZGp9iiRtWqKF+peu48GZRTACDKcgEjMtw6xcODSiOqa511+/5nGZ89S2exTzOJRevLqbi6KiZqHJae+N+UCAABnwcIlSz9rCqgndEJK3w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6140373a-d7b6-4320-8fb7-08d7e13b63d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 12:49:09.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYTJlCG+5K2LCEoO+6dyshEYyIaWHKP3ad8dC9EcW1sYUDK9nNFImyUY9+7EvBUbiNOM575zo0pKGRmkSwTcOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP Power Management Controller binding doc
pmc0 is used by M4, pmc1 is used by A7, they have different
register name and usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
new file mode 100644
index 000000000000..c60903039718
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/imx7ulp_pmc.yaml#
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
+          - fsl,imx7ulp-pmc0
+          - fsl,imx7ulp-pmc1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    pmc0: pmc0@410a1000 {
+        compatible = "fsl,imx7ulp-pmc0";
+        reg = <0x410a1000 0x1000>;
+    };
+...
-- 
2.16.4

