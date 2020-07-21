Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65179C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF1D20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sqn+kAwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgGUPUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:20:52 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:28932
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729938AbgGUPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+VWa2kBwQmoyFTlst44zknoq71S7qvjg29klpuIJD/ZT41d8RGZkZmm0oripHC2HmrZlgzZwr59fCLjwvS6LEaQgEZZ1ZnVGsbGN24+bMMOAwKGqL3m5CIpnerWs80klCG2tgb3Ag489cv1B+sFBbzuVUip35zSvuxkW8g2LD8nJ4dl7A3sbqeWZuhv9ui6nEsnH4AS3rW7TZPjYLaoinFNDV7pdPTByG7olkEnrKpJjbDU5HP6tnfarOIbTQplaWrsjzjK7BjS8KP/rXg+e+le1Z1J+TjXqxupVyRWXL9vfVSa8wGz0zVUZ6EEnS33aoAJ7FZSnCiBbzPC7OPPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uteGmeVdh6mwbpu9EYw+XDYU2Cv6F6tTCTsYliI4J9c=;
 b=BmwtRVv5IEYjbLVTDS5taxmisi29ADtvStEqFkyW41Bsi+yJGwliGvtaOkoH3JrsMtkejHggllmNTjGK1K9QwdsqckAVMF3mIYJNO5oOBxSxFbYX0EjeNGU5cfSNs4Ji7R4OV9aKQMVDS8FfTjNgKSwKL0IktVgkpEn14+dEKUCGGAmPSRCKBpjYTeDlVVfpQWX2ymvXGZqvmPT1C3vnfOrHnGkBWmjgOc8SDFZAoP4eIhYeZvDO16ofGtGaSujScP2llHY4MYivPqV6/C0o2fJpXft8y9Z7+nViRsWCyJQm1YZAwEzLtc6UraHXx69LbUoB6I7SEGf38OYbhL1nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uteGmeVdh6mwbpu9EYw+XDYU2Cv6F6tTCTsYliI4J9c=;
 b=Sqn+kAwewiEU05ZTTGP1A95UUNi6ETRhJM/iUkic9gFDvh5K2dAbRLWn9Jv9n2+oU+/+Y8cmdvo07QLBAUlk80FKvGh7tdvEN8+M22pMdSvHqgyylt6QR3E+ysRHoUzgUJDrvWB6gXZNLgcE+aMrW23ws+8p3qjbPeZW5hUn1G0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB6212.eurprd04.prod.outlook.com
 (2603:10a6:208:148::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 15:20:40 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 15:20:40 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v2 3/5] dt-bindings: firmware: imx-scu: Add SECVIO resource
Date:   Tue, 21 Jul 2020 17:20:33 +0200
Message-Id: <1595344835-67746-4-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.21 via Frontend Transport; Tue, 21 Jul 2020 15:20:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d70f572a-70f2-4bf2-38d1-08d82d89a0d4
X-MS-TrafficTypeDiagnostic: AM0PR04MB6212:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6212A174482B74B460F10505D3780@AM0PR04MB6212.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPWrDh0fscDBt9SMOjBxH7bdZ92q6/uqwjVqRKUF0EZOsMgaR6RWGuoFcXicJFIY7alAvd/OQVDzog0uMstbXCRc1FOhj9UVL5H2ecXDeJyROG0Y/XzkfB2/UbrKKwEZZeW/rFLHJ/joaaCVmI/iiRzTVwl22aOwHaffXJTzB5JirSSdtfxQp38Wd7YuA2cIXb7zoak65RzWFQ0Lq01PDZxYuMhSm0mmOPy7OllW30QTtUv1hZ9//rGzgpHLTBpa7oHrCkKv1omSPkOp1xt3DpTM/yQYwtDi8qmqADTWcCHZ/RZS83BfplWUS4i9jLKGT7YF3B1nbuqcesa0Ab9crg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(2906002)(8936002)(8676002)(86362001)(66476007)(66556008)(316002)(6506007)(66946007)(52116002)(186003)(26005)(6486002)(4326008)(2616005)(956004)(6666004)(9686003)(6512007)(478600001)(83380400001)(16526019)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: f8/GbpkgZFApU1FybFbyArvyRFDnWkbucZPzZ7R51gVAwqlvMz3Zud2/fHNPnV1/XzVMXBOvdAyrUtuLUmwwO+IOSnmHq9VacTgT16UxZAy4a7c43tygGbjaPgfzl4pRSc4gG88HyWAk+M0ztDNDocucAyDOjQ5pj+IsmLuqAV3YLktV3MHPvy9BTenHgQJu5nub/xRdu1WKqGs1SIamdGi1pR6VBwYTaqrEL4BFbmzYt4RIwnXTK2VWVCcww8LKNdrMKGFsJjwA93lGBhMbVTPnCQxKn7GahmM09k+4j9oYI0KFm/6ne3KzGjttYzvKObhHH2b+Q61mCpRMdsSycExMBZGLRRY8JKHPSRyXE7k78qQ3lk9ubNN3E9mP4fzSIXgvmfkhvrvDYYXE/YMci0FqLDIUr78onEhty6Tl2Es8zIUBmEaNGhAnDrSJHGBwY7IJJjqSSqKJJHW9chMvFHcfmKEmWrljBVsZOufc5ls=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70f572a-70f2-4bf2-38d1-08d82d89a0d4
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 15:20:40.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kScYTj7x2NvfhDIc5VYNVLQ8Pg+CMBB3h2GqCacog6Cg05Uemt5HnMVb6r9EkY30Ube08GoMRMmIuKWpZfQl4TjuxKpVGr6qYvTFoz0xLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

The SNVS can trigger interruption when detecting a SECurity
VIOlation.
This patch adds the definition of the resource.

Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 54278d5..fe5f25f 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2018, 2020 NXP
  */
 
 #ifndef __DT_BINDINGS_RSCRC_IMX_H
@@ -50,6 +50,7 @@
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-- 
2.7.4

