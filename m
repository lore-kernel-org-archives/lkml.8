Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C281DC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3DC24670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+g7h50V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBSIGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:11 -0500
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:27265
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgBSIGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtrNqCwaXx8JK2smgkrfNRS7wHaLiVWxhCnsLfkZ2YqO37+1VAAc3qwxENE3OdAzT5pH2dq8sCGCblMA8XdNAF2Eh3DP4m4LT4Qn7KTsdhY2b9gMEpadMS48WmcMNxAAQ+knvkIMDm4vO/EnzbcOkYBgJb9UBnm6/gwmCjZovrCCR8JmnXqU2FmK5bH95PpbdvL3XSQ/p3DhKwrsTB9Muintp0b3lJPdF1kix3YdSHC6aanEcGtM0DnDT4th58fG3WgtleERJOAeH6+9IsEFjojrWRtBkXopT65NCM8n5c6ZtT9wDNHl0EwKutyLQaJvI6GETxMoBRBmSQLf8GJg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df5ritx7B5D6lOHcf8L1nv7tKL8flDA1EfZkxehyBis=;
 b=UlAWL4A+06AFl2f0tpXVNf0FsnVRrVmDOXyTAGMT8CxgV+pWC73+GchKn4UsZM29atnDki5YNEbz4ZKXm7h6zgiJCFXDXqo2oIC2Qgq4uXGxI3rF2RrGiEpbDLlqDxwTZ3tw0PsfoHwzDmqTxbOujF3SFuDMAsR6HVdumaeGoCYnOwoOQ6Bw6jTWbiM15VSS/s5n5Sn2M8eMKiVgWmmmM4M9C/ioEENFRowXCPuFPA9HlPRmTSQysKT+6jFrDyMIkz2hP1ul9XyShWwaR7Ex6QkFPS1KcZQxdgb14bWmGXFPtx6c9AmiRoxS2TByPXllmn+wojJN7fPcPBGk36JJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df5ritx7B5D6lOHcf8L1nv7tKL8flDA1EfZkxehyBis=;
 b=T+g7h50VXgkf5ALIWJxhanuSATu0daahVRYkUZTrhtR51WzX1PlcHZ3hpVSFRvmYLqeCocxDp2kFAE2DH72Zw8n6U2T0DxiXC/LTkA/fgVsv2FR92jbhgLkv3MdY1UJVx1X1SMAA4BDWevdjzXdBLemn/3s/7yuGgddYk+rtrwQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:07 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 01/14] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Date:   Wed, 19 Feb 2020 15:59:44 +0800
Message-Id: <1582099197-20327-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51cdb211-25ff-415e-5e8f-08d7b512925e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB64016AB925518DBDADB9874788100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(966005)(26005)(6486002)(36756003)(16526019)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjmGaNWP0Asrk0kV5c92Vsf7GL376th+0SEFXobh2AvZGlNDfflJNNYuSuA5CLT4Bl1In0GKUO722AeAxfYqyqXgrXmJRYbASSALDJHBwJq50UNvo/V52XhrUNA6vSOHamibCPsvrlBL5yig0Fi5oYmM78S7gge4+OakCZrGJEBmHN2MX8fKAl2xOK2a3kwoVaMR0r+kHonFWrT8NB63x001WftC0dAStc/m8gy/BkG1BaBh+JOCUEsWviwsbKaLht7zAshhAaoLiCky3Foxb3vi/t3q5UwnV0Lp0ryfMeRVGTMr/FkcY50ijMsmGitgz4KfjBZYed4KPZUctFjJQwPKgTcvLtgIW1FAh0DeFAzCGaDn+/W3pT+JKhOd4Zs9XqQ1KvCdA+vYxcXLaT46VeZdeZ6SzczfxcTFKxqhJ1AL3C7rpuCNJD/ueOQRqqvMEyjDT8NuVxf+VDdGL9Loettvv8eT2DHB9BULemIgWpAwVUz7BrJ/KEgDWp5+ZLdo4HgofuIk4jCqxpcKtD1jRYyQH9++gW6II/DEAcio6/yLhkgT0buedToApyDrUDMl/HVeXjNBY3+R748bJ7oGT7ZfoNxtkn7iTR1qEzCk1oj62HgG5BDylk62SpOK2Iu3
X-MS-Exchange-AntiSpam-MessageData: 0dn9N7oM/tAaDtirpdiS0lHOYDZuZ82ldd1JxTh9P2vuOYc8MQaEglXXGMMMPsr7PyJDrmHxhduUwJVCOynDrPUWp2cMEsh1SIHNvShSPRdvX+2V2022+uthVKRpSoW6UrYU7JXO8dfFsZh0cjvc8Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cdb211-25ff-415e-5e8f-08d7b512925e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:06.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8KQQg8zQnEyeN4XuNEv/UNwHk3tRIb30hNdbszov1l/xsvI9VvFgH4zLTgmPMs0jee9C4TgSjZN5tlOJ3e7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP Power Management Controller binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
new file mode 100644
index 000000000000..992a5ea29d39
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/freescale/imx7ulp_pmc.yaml#
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

