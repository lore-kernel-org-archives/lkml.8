Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E0FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71972166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IOmI/LJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCDF4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:56:02 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:40051
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725271AbgCDF4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:56:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQdG75g+c1MluQiGOukN+zWSy5k5BSb0OKVyCg40lmNL4y4G6s/2iR/umH3eOTmiHoUAAipAg1vzIEAgK1+L5MumnhN2HSRPskwQfs41Xpo8Ea7rZfG4t1plJovAyVGRgUh+zSv07mRCbJdhiP6w51vRTVZg+nT5E/U0Kja4zHY8SyM7gm8hJpvt0kggUThGvu69OsfjEwxI7ANsrHbDovOajp2ys8WxmJtKUycKHT1edxOdp7H9awE2tuXKE7Ggng0N9UzIPs4zYxn/ormBUPFcuplBjid47JNjIssxKW5g5QFjqfv/m7J08bekVfdruPqB31pHonQXHZBuYpPJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr92hGZuKIh06Igyl5AYDzuWtSjd7z2poO3nMYN9BHY=;
 b=iJcIBVfKyiZ8RA2ygV0ZqLzU0o+3e7Vp3D/qkklJLwy9+Z7Hlcvh2TvWZehw+tiBGT7Qe6ao+TTCKx2fXCYCadeNzlMsf8CKfgZenBlssX+dw+s25enNTjtXQSskL8bt2UP+SVfQLGFqezHMQZaXffiy0QCXADzNlQF2bP0dSDHkcmDiZoa1RS8ZIKCZtjagh9c0H0+tRBXbWLeO26QZebuyz2InmrD2SBKSM713CCFE9So1e8I5D0eoEasw62Ed4iSRNXp2rmNwusjhomTLxF2Kjaoz4u2itT8I2eOUcraHlAduvwPq5KEwpqlRGjapvm1SAVE1qk/j634KewZiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr92hGZuKIh06Igyl5AYDzuWtSjd7z2poO3nMYN9BHY=;
 b=IOmI/LJwsN8UX47bQEBnQuS7xvXLHZniWkvGiqDbbyMdMdwxLZIFIu6APmi39yULWf3wyLrKy0oLApHLrGBWkpZR7peYV5OAAsmhQYhoVDVhk1Sm+H0wD4xi1EZhdHN++KYgeOuuC7XBFTVA+XbuR5jbZiZ+4BErayCJB7E5jNQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4947.eurprd04.prod.outlook.com (20.177.40.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 05:55:58 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 05:55:58 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 1/4] dt-bindings: mailbox: imx-mu: add SCU MU support
Date:   Wed,  4 Mar 2020 13:49:34 +0800
Message-Id: <1583300977-2327-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:3:1::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:3:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 05:55:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dcc045b-43c2-48d3-816e-08d7c000b60b
X-MS-TrafficTypeDiagnostic: AM0PR04MB4947:|AM0PR04MB4947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB494764416BB2248570BEEFA188E50@AM0PR04MB4947.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(52116002)(66556008)(66476007)(316002)(478600001)(66946007)(2906002)(81166006)(8676002)(6506007)(956004)(2616005)(81156014)(4326008)(69590400007)(6512007)(9686003)(6486002)(5660300002)(26005)(36756003)(15650500001)(16526019)(6666004)(8936002)(186003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4947;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afPJE9Qyw/GXNPZQHH7dnr5NvTH3NEeJAnsFc/f3F14jcxZBI03emLTkrKUeQ/qoB3wkZhiFcWdUDwskVkokvUDLaJZqOasjcOaHyOkDFGteKlYeb5BsYzsGKvyzVV5d6nyg3d4Bj0deA8kjTifkZM98hi0f5onfinr8wUUOIuVnMdo7QgmRIOdU7cTTJI7+qDKQ94cxKf7vxik8BxY3vhTVzGMTJQGnJc1L++fDWrjYwQ3eluWW0wurngPcA5MfASVFkzK7Uef++fF+XXJHMj6jkepOdBTOS3ZzJE6vg2ORV4LLAu7FMyupGa73CUSTs+akwOlaroCG1u4+XkTwHkXd97EPnciSfvx55KbHlW8BT0AQHBH3EhdFWD6/65V9USvbk4nRxLBpsDCQ8K8RfEbNKo71kUKPGzlmcPE7Xj/J7137HaPmPE3T2QlBQJTqL6+8r1xJdjuad5T2jV1LXJZdeXTk7jUOVmhfdhuJhq8nr1nt6THvkH138xzFmlnP
X-MS-Exchange-AntiSpam-MessageData: 44sMmWrfM2ALYY/mYw67GemgTkkmRfIboq+ZI3kuAts9AMsHHX9cH48wfb5ZMfG4xUICf+lV18UNPiPkzPUgYunzw5Swg4vOL8ZnG+RrBMIUGe9etJnl2OHfd0DGKC7XwVycdaArvzgfp0/lBmN/bA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcc045b-43c2-48d3-816e-08d7c000b60b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 05:55:58.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX+/GoNXYw7yAtR/9cU8n7ArpnftYSHSPVkFoQkck7I/y/uUuMHibbydkx7gaH6Ybx+pjDiTm4Wl4uOYAEVLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4947
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

