Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BF02075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aT1LOY9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbgDNNgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:36:48 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:14995
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728395AbgDNNdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi92amGerpA6nAbGKdaNuFLRulK7/xISCpGQ+K1GfNqYKlH47YCE+FovY6uI2rGl8QxKLzwIHgavbBXnp54NRgl+V0Hj82G9dMvLQmIdl4kpwGFeNO26pMoh6ejdCkDh1tnDKDsXcWuFN0pv2eOWntX0GJSdcvsz60dG1vQ5zzQZP9u6nkFtjVZY0N2Sw+aCToEX/KPR1AE4cQ2WHd7xAbFsYDi+ldELesTIOuMlc+qmuSrf7iCS6BjaAj/3bW1TmDOlwrH609XrJPwy3xXKwdkiLEnMeLg2GElqbQ61LEwUs+lA/rMSmauwFHtZYCxpVahiSB89UGZBSfjmLhyinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8r56iU6nx/DKLqagQWCqusB9o+EarkpsCAau+xRQlo=;
 b=Ti+hh6h6Yg0e3gR50xXC+XHOcZEy8J5OmxOdEbsM/GKedGa4Ii69hPRoh6hRSUj1s4c+n4emkvlEUMQT4hUmSg2Cshs+2yAwkkUG/BMKatbn/cuntKDmbHamo4CfEgTHKVC9T/TE4H9ZUX9uUKeKcgNu4xOF3eyE7tj8oGBVJpTpL+HyyzHa8AbzK2u+t52nQOFL9p+kiiHiIC+hGjyAIT39RtYREgcULWmR2i4bZs3lwiIqmhEBWbhoIIk5mFz4Bfg3rXNHZEHyYxA/OMvz1c65NvmScpP80WlUgqiXHZE1URLCCRttZXlVPwiKzgzZt565Pcf/EYXsAUUocPBCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8r56iU6nx/DKLqagQWCqusB9o+EarkpsCAau+xRQlo=;
 b=aT1LOY9erm1exX3/WEHhb3zNeeqx9Kgioy9hbsM904VkUjtaXNNU285Y5SpdDx0ZOHO21ypcZ2aQ2bnnsUScsc3TF/L4eJPcSjygbOdbU9Y63Du25ln0hOtKQR5SS6dgGGcVk442y3YHvjpUBWUNF2VRQLMleGYa4+8DG71sVlI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB6868.eurprd04.prod.outlook.com (2603:10a6:208:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 13:32:56 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 13:32:56 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        jaswinder.singh@linaro.org, linux@rempel-privat.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: mailbox: imx-mu: correct example
Date:   Tue, 14 Apr 2020 21:24:27 +0800
Message-Id: <1586870668-32630-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR03CA0118.apcprd03.prod.outlook.com (2603:1096:4:91::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2921.12 via Frontend Transport; Tue, 14 Apr 2020 13:32:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65831955-a08f-4087-1f54-08d7e0785782
X-MS-TrafficTypeDiagnostic: AM0PR04MB6868:|AM0PR04MB6868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6868973C7AFF1E98885E6B4D88DA0@AM0PR04MB6868.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(2906002)(16526019)(7416002)(5660300002)(956004)(2616005)(15650500001)(6666004)(26005)(69590400007)(86362001)(316002)(186003)(8936002)(6506007)(4744005)(6486002)(478600001)(4326008)(52116002)(81156014)(9686003)(66556008)(8676002)(66476007)(36756003)(66946007)(6512007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpnXO7c5PJ3B5T5985cGHJPZKkBsTaF5TRb9zBFKIicyR3f2QcQ20AwS1PxnULm1dyJ0EuvGxWWZiZBiWaTq9Dp+1jfyCM0M7CMKbER5x8tzu3yFq3EA9b9BKedcArSV86fN3KccDLZ6RUF4Cvx49NVX8pbpoorKYiPQPOCojWg4ZAx1tSpcK0u6QXTeeeneodPuPmP+CY6D1FboENIC6E4wdZ2RpsxmeWJvg+X4lA9z8cf1s7ZINGj9zLZM6uY+E1CRcX7c7wZLyckYhSfpN7Fp3PkccaLoPAhxPNnLHzTRd2NXhAyE0JOtycLf6QD//qHG6gEZ7TaW+rQr9pIF/xMuNzE9l7Dmkb202nruTFr5FATKqXPRJVjVpRQpVLaxyjQg/d31VNYph6Mracax5W4ki8eEcCBM9vbVcuD0LwS3hodUV9KVBAXpSDfdWcbIANbXyVuBLQHg4tAzLbj9hdpaG+HnDZ5MyRkpvdzKjZVgTRY14fdsOX8eTKC0Z+Mv
X-MS-Exchange-AntiSpam-MessageData: 6lwQ1bCmp2oYRoZEEG5lHJ1EmE77+mXjgP4+bXt5kJ3I9th10oBjBrNy/UBJsBXSkRmsowbrRZyZSCNawTM032soiaUkG847c/MIRKdmThKFpJdVudbNt9qyl5knKwtuzpAkoZMLYsPbjXxHfJmE8A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65831955-a08f-4087-1f54-08d7e0785782
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 13:32:56.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NidV26Tm2GkekpePOo5kc+94hIYfR2Uzn4LNyq079n3jtbW9qqnARr+1D9AVndBW5QzQzlGIvSVvxhz4nHLNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The example use i.MX8QXP MU, but actually the MU is compatible with
i.MX6SX, so add the compatible.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 31486c9f6443..26b7a88c2fea 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -51,7 +51,7 @@ Optional properties:
 Examples:
 --------
 lsio_mu0: mailbox@5d1b0000 {
-	compatible = "fsl,imx8qxp-mu";
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 	reg = <0x0 0x5d1b0000 0x0 0x10000>;
 	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
 	#mbox-cells = <2>;
-- 
2.16.4

