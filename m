Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C812C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710BE2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UZ9WiU5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCSH51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:57:27 -0400
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:34791
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726846AbgCSH50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:57:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFttWGmCYmz3B095XcYV5A8dYmFZVETk+nbSHW82SQm967//WWz+qpfGIri76UO+ncoIc+Q+VOqnYNOM2NVAYh73orUwtgYTrkyW9bGpdp0DDZUhJzf+wIZ1D4RUSqpTdH/CVT51uPuSc7unHydfVIuXrh46Cyx13SzFY0L5avr2TZL+Wlqa8T/CkgcrkWCYpC7izqJoDXUfO/DMAKIIYN8vnWP5Zly+O5PGPll6OwMEbawVSK06ylQcsZ7Z60v6VMLvgXjnXWfSAcePoTbrocIqfhEuj8ib1q8NSsLIBrpmXRwOa7vqYs8LSP/477vAM2IbR3geC+kyP/liL0kRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbdLfxIXuTTzXcK3eSZNp44a1DH83hgbfLpATB5pTiE=;
 b=AupWXONMRV5Kye3UWP71iM+YQo6UynaQaJHUENBjtx0m7K2dM4NVChSYmyOTcdy7U70p8aDeEGvzWesMlDEdsQuRUDx/PDcr5Kdu4cKtUHTgp6WS7Xko+6HwShbmfFR8bSj/GxXiP7GNw6WxbuRpebz61EG4VXPkuPKFxbhvU9t161rNETMP6BxUhm2vcDPBji+g5z4YrQICen/v87LLKAVNePiqDYPWg6+fPg7EhYc6Y2P/5s4dgoEu+REr3k6h13Ri993rg8ZuVHwmMsfKGui0Sqp53v8SIx6SoTN6dy2arbx0qI76hDQFdvxARXDLJETRPJPjZX+WKfy+fq+Mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbdLfxIXuTTzXcK3eSZNp44a1DH83hgbfLpATB5pTiE=;
 b=UZ9WiU5Z7ffcOeCyYl5x/pVKvFgw+Kda6RF4zEOi2M6AlSmimONBe66sOhn65YKj7vX16/ZrvXXVw7Jl7r4qbD4lFadm+y7MuS+OV0oZUNTZAJp2sxRBg3qlti2pclhWoOO3RioM1e1hd8bNic9esfvDsY2RMdIvAbI35W3sRho=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5780.eurprd04.prod.outlook.com (20.178.118.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 07:57:23 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 07:57:23 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 1/4] dt-bindings: mailbox: imx-mu: add SCU MU support
Date:   Thu, 19 Mar 2020 15:49:50 +0800
Message-Id: <1584604193-2945-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
References: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0118.apcprd02.prod.outlook.com (2603:1096:4:92::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:57:19 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e57b533c-432e-4ec2-677f-08d7cbdb2853
X-MS-TrafficTypeDiagnostic: AM0PR04MB5780:|AM0PR04MB5780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB578005E715FD4D4C8A68F1BC88F40@AM0PR04MB5780.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(6666004)(66946007)(36756003)(66476007)(15650500001)(6486002)(5660300002)(478600001)(6512007)(9686003)(69590400007)(16526019)(4326008)(81166006)(81156014)(52116002)(6506007)(8676002)(66556008)(316002)(2906002)(8936002)(2616005)(186003)(86362001)(956004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5780;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CialMPpOVPQ96D/FgiNdGJE0cQ1DR2Epjwoauz/NnebdUCPPUOKCqFrfDccGx2sQfaHeapgtCOPc76TRRAgunO92uzuz438MSKQwN/wGtqiaZG3pJNiRrMSpjWeoR7YtY5LfSwZHpeX8ldvS/qQUn1TX6EMirHnzkURVEsLkvoqeNk6aHw8dMKYPqwHAhYPuEU9Jjljb77gkb3/qOGIlp7sQ18VaV/uEtpTj1FrBTNtivmVB232XjUdxdYknnelkM3FJ0OMxptGt3D8sJH9XzBeUDmItScgGlYt/LYDKTfOGFQaRVh+GJWkBPvba8OUPZJWISjHZFuFpVnG5zappKpgari6oSb/7fvbkJTczomcqTFkEy72nbXukRKGhTSluif5jfL9ney1UNCm4l7BA+7HXZydx0PiY8w/Q/RLZqU7BRgUNeF6KzTsMak8MffFY3kBBZWWb79NMjtAE1zw+1GOCK5OatD3wdPyjxARGJUWbU7KRIZximuuSaNernY0x
X-MS-Exchange-AntiSpam-MessageData: Wa0kX+WVRKirMD83wHC/eEalENE2lqWEkNuiYTN5SG5J7UYCI4GAmbIFCWZ9yVwPm9FStelQv+jAzGX7E5tItJEeplOXKczaBuYYVTGaGHo70kUocZvr38JNuloChWcpDrvCzPHiPMyuT9eYuGsyIA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57b533c-432e-4ec2-677f-08d7cbdb2853
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:57:23.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGZ9VEAVfIUVZvObMyw9vRM4LNMlI7p0zjYi8IJacPAOOYFqyUW31v3wWRlGkQzwXSazZKSeQYbwFzGy94lfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8/8X SCU MU is dedicated for communication between SCU
and Cortex-A cores from hardware design, it could not be reused
for other purpose. To use SCU MU more effectivly, add "fsl,imx8-scu-mu"
compatile to support fast IPC.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
V7:
 None
V6:
 Add R-b tag
V5:
 None
V4:
 None
V3:
 New patch

 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 9c43357c5924..31486c9f6443 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -23,6 +23,8 @@ Required properties:
 		be included together with SoC specific compatible.
 		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
 		compatible to support it.
+		To communicate with i.MX8 SCU, "fsl,imx8-mu-scu" could be
+		used for fast IPC
 - reg :		Should contain the registers location and length
 - interrupts :	Interrupt number. The interrupt specifier format depends
 		on the interrupt controller parent.
-- 
2.16.4

