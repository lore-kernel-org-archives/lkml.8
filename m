Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC5C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A2D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBtctP/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgDWHIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:08:25 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:37685
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgDWHIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:08:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjCgockGVONWTR1/HSbHOjTA9NbGSxrSC0dwe6mOy9PBnA1ejqiVC2WQEQWz6eAu2myorM3mxStiIHnuFCZTOu9+lY3vdaO27yGg5tTVVTzRGwGIZVrEk80cWKVW5n5fM4ZRTwFBx+IHB7tSky7CZ0DOWigqdB0kdp1iS4szEzMBVNLx1LRMMyz1DZrDEGtbCUIChnzeX0bzk9K+W/CFXBvoPtKd2u6Z2yADHhyr7akUCUPav7h2wSXAbhzjOW8ymAHZRVfKmPBTgUaJxY9X+2gQn0TWhjIs+bJDSFO4dG41pBUT1qhWkheL9MFPVEuGW3r7BMeWUYH7RNsvHO2PJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur8Au3O0xO7Md6JZwcMzv0kfcjxps9aYPr10QkeweZg=;
 b=jo6MG9V94ht0pi9wJlj+2fLQ6xUi2rlxzGknRmeI7QSfVY3YT5A+978bthf3q28Tkm6hkqB85PJlBzBUoclrajg7a9mgDsKR6r/HZHFhc6vBFcDXK4QgkbBA0PGHqtDxV9TpNeiuvztvqzq8agMvpOkWRibjnZgpRGW7Up5s7LyScBIpvIo69nRQLI15ibEbPRcIJXr1CpaXQq5q8d/ZRNVzeIUd+0aMsqjWAMLXOKfRNCY4bmjz5zHj736wjXa6sC8VcLYX6r8KK62jKnLaOjUWbE/5Dl9FML4pl4uHHjhMQpP5w5m7yl65JvyxyYA1oLYbni8vw1REs17GoKD2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur8Au3O0xO7Md6JZwcMzv0kfcjxps9aYPr10QkeweZg=;
 b=gBtctP/Dw3RhZ7DBKXRcDuFgGRCHVEXrDBqf488fWv2xEfCgV3+u/h0d4okeSs7FkxwzWEMkjgFJdR4UnwTTbYDznJFoxYE/hBOgxn6EKynmc3HAwTAt0GS1ZJ03StzhLYt/T2p5vlxs5bQMZBAXIbYM1hE77vFWIjTXeCP3ROY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2855.eurprd04.prod.outlook.com (2603:10a6:4:98::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:08:21 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:08:21 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] firmware: imx: scu-pd: fix cm40 power domain
Date:   Thu, 23 Apr 2020 14:59:31 +0800
Message-Id: <1587625174-32668-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0149.apcprd04.prod.outlook.com (2603:1096:3:16::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 07:08:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71d9c54d-9967-4146-50d4-08d7e7551b02
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2855:|DB6PR0402MB2855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2855164FCE981F81C2A18D2388D30@DB6PR0402MB2855.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(26005)(66946007)(4326008)(6512007)(9686003)(66476007)(4744005)(6486002)(66556008)(69590400007)(6666004)(5660300002)(86362001)(8676002)(81156014)(6506007)(52116002)(16526019)(8936002)(2616005)(316002)(2906002)(478600001)(186003)(956004)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdJIvjKUk7r7WM6lRRx+NL5CVTHr+8ElrocAA2CrDHECFhFLUBtZqduHSKyk6UTAJpySL+mXng611jNeano9myrknuC0H0ft3ZaS3Bq1a9EJEFmLUH1+ctp/NHo56yvNlpxVdrZas/pgW1TJsgcDVcfYdBIBD3sssHRL1ZIH9WSSqye7lv1O9yTMj5+4zPNsPmell9b/zQ3qyedHdZF/eWZmj63eyg+8fbHVwpQEBPvQrK0Tm0S9vDgI8iwxMxWnNESVbmn8jef1uKFWp8XqpB/4E8oyxV4mLlCy/doZQNUxv/bugWgt2GlCnvwf2FF+t0Vp9vvTD2/qNAVAQkYG07DLJNeh54AYmDcKO7HnRt+yLB05JA7wCS3trI92uEjRFsUMr1rODTcTT0P6VsdI6GusOd0kd8Xz6qW6f0Yw/ODTEx2iwbcABygxU0MI6k/YvZc5lwrRO+xe8bRLaPF3AdkEcYqHGIiLNp4HdktL4u17QPxB0BzY3FkpCOZxcdyr
X-MS-Exchange-AntiSpam-MessageData: KChe8/LwsqOcGv+2+CYapbG0xu9zIsQh3G3IYZ+uZR5+RFVJfoCxTvYumzCj4VeO2GfScmrUqKZrETylRZcBZkj6lFnhaBkrXyk7+SxaPrFKqjB5NbPNej1pqryJ/A0NWNpYVtVU8iWO0A2h6UMdhA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d9c54d-9967-4146-50d4-08d7e7551b02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:08:21.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCro14OwojSUdZ8ikP4TgrD/IwfPwtNiwHai0HGGmzgh0wo9cQqpbLxp/0Djy2QHRiHKIEDHAMPFe3cLLXiq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The postfix needs to be false. Alought compiler use 0 for postfix now,
and take start_from as 0, it is better we add explicit false to postfix.

Fixes: 705dcca91d0a("firmware: imx: scu-pd: add power domain for I2C and INTMUX in CM40 SS")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index fb5523aa16ee..d1b313fa7b96 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -167,8 +167,8 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 
 	/* CM40 SS */
-	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, 0 },
-	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, 0 },
+	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
+	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.16.4

