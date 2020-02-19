Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF5C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242E321D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lgiTBooi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBSIG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:26 -0500
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:15456
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbgBSIGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8fJIigb8m+N1CxPwzqBKFxEV29HCm8P5aNw5UtgRdIQxpYlWZcv3tg0QA+TZ0XQ43yqqbpQ5O9nhC4UHJTFguMdTa+o4DDLn6sFkoM6DVcbTfAMsfuSvANjPU2dL26Q0kTLEcdSxD0+/lKaGgSIGS168yh0j/n4/XK3Um51y8f0XepVo1Rll0Wu3hp5iRAVP4BF9wBWa4Hm8Lm/bQxP9kRhj8LsYvb1jVpn8ksNHZGmCm4Df3fQoPUh/pFsA3F6paULlIoYD6Z/VHNK1B4f4iXPUF0qeAxOvnlNYl2CQWNbQD3DaBFHHn3btqQNHQMKFAWBnmAhd1ap+prH06XKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUlRr8faB/i66fx3x80G7m9tQuoYyRbLoNWtPavuV8Y=;
 b=n1DKiA0cQWOz4WIOYhs6dzcAHXPF0v1FGlFgpYVP5J0zJ/grCQL0XR1cmJI11PJIlxDQuAf+wlueakSzi6fG5ayhy4FGo513969a3H6Q5F0+WoKxl3Psd82+w2pBlkmdWKriEPZRsWAOU9qD8hEnGa3N36/lJHvUaU56l6P3yn1sJcjHHTtWWPyn/Gv+OLIAfALUFmi/bihSrBMDDGAm7+lo++sAWWuN0CMLACmXMVTqOUSjU4HYnS5r76yMOXMFv9bYCCHoHJYH8PvT1zex7eopoVF19IYb3DaFTS/B2RqxkHWDDNx0FqYiyl6lyiaJqgD+0xImmhl06OAOH6nD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUlRr8faB/i66fx3x80G7m9tQuoYyRbLoNWtPavuV8Y=;
 b=lgiTBooi5hxsFR2J92ZUL0/l80A8T+/1ETeYRJu0mg1El8ETzIBo32AFVmv1UDt1w8RwisQAzCb/TfD8uVzxgFTHStLW5DI8eyBMBaZ5Zg7XECX6tiB4Rx2jr9R44f2OSWZj64pZyu6tPyl0bVFTmSTGvK2LGmvnEkSWLwGB6SI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:19 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 04/14] clk: imx: pfdv2: switch to use determine_rate
Date:   Wed, 19 Feb 2020 15:59:47 +0800
Message-Id: <1582099197-20327-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dc1bda3-4b84-45c4-261a-08d7b5129a36
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB640127C07D11F1DC95D6DA7F88100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(26005)(6486002)(36756003)(16526019)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKHoMv0jwmNhA8VdWaVNXdENEJc8OlGDfPiAr3M4P3WSV++GXw2EfhSZJDwlX4drExXcUgBTvLDCYLIlPdqioB0CbescY4Qs3QzVTTtHNBzy2Bp7Xh4pcIqGu4aVOsWk2OCmMtKqgyTg/EYvEg78dk0pUsuYfMB/NpXm87DkWOpfxMjQNV7R9205b1DJ20IgysN50MNBxrRb24Ksd129DwFzrJxKNh4pUwkJ7S3EnEhX664Z7X5VuV+Li7FZf84FsYVCNQKLHujtdI1YrPtAR3KXB+aGUZnhZsfU9nYLrYZNdC62vT6yiX5kTmUFXbYss/kahxb6Vd2XpbuBzqx4LQmN0CwCg7jZlBuPrMZA5rLWhc6KBt35Lhv8tacCJibTLKyEQn0ghX87qkq95INT7tA3+yN4/8bb4Z3j1l5x0RDyZdpBhg9RPJ6nfyj9MzoniKEMynSVXhrEP9xZzqE8MzmmyrmHm39feauwuME2a2cYk8yfWti9l38s1rIANefLPJZPDHpu85dbV6ykq4T/3S4d1jnN5wKczvHWqRYcajU=
X-MS-Exchange-AntiSpam-MessageData: upd6ubCi+A9kV29cYtjZEOYHAETZ+KM+6R8F+ko8hJdum8LJk3xqD3st2pBoQGPe+SkY7sngBLBKWIawt8jxuwUNOjK2mfnBuXgMlNzpsOoROQ4rDsOQI+BS1lqu8AsyqRIRIzdPmXj3sumGHLlYLQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc1bda3-4b84-45c4-261a-08d7b5129a36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:19.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXYvNwqvX1QusE1J8fZ6rt2c6GgMmLjLo06VFI3qp5hodWXSiMoHg14Ju+ArzqXEmEWjl77bTEOLT+4JJ+LPtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per clk_ops, compared with round_rate, determine_rate could optionally
support the parent clock that should be used to provide the clock rate.

In this patch, the parent clock is just parent->rate as round_rate.

The following patch will calculate the best parent clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pfdv2.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index f8707278aad9..28b5f208ced9 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -98,10 +98,11 @@ static unsigned long clk_pfdv2_recalc_rate(struct clk_hw *hw,
 	return tmp;
 }
 
-static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_pfdv2_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
-	u64 tmp = *prate;
+	u64 tmp = req->best_parent_rate;
+	u64 rate = req->rate;
 	u8 frac;
 
 	tmp = tmp * 18 + rate / 2;
@@ -113,11 +114,13 @@ static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
 	else if (frac > 35)
 		frac = 35;
 
-	tmp = *prate;
+	tmp = req->best_parent_rate;
 	tmp *= 18;
 	do_div(tmp, frac);
 
-	return tmp;
+	req->rate = tmp;
+
+	return 0;
 }
 
 static int clk_pfdv2_is_enabled(struct clk_hw *hw)
@@ -167,7 +170,7 @@ static const struct clk_ops clk_pfdv2_ops = {
 	.enable		= clk_pfdv2_enable,
 	.disable	= clk_pfdv2_disable,
 	.recalc_rate	= clk_pfdv2_recalc_rate,
-	.round_rate	= clk_pfdv2_round_rate,
+	.determine_rate	= clk_pfdv2_determine_rate,
 	.set_rate	= clk_pfdv2_set_rate,
 	.is_enabled     = clk_pfdv2_is_enabled,
 };
-- 
2.16.4

