Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D95C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BE320775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMUEFfFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgD2JtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:49:09 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:39044
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgD2JtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROo7qnHGaLvs8EgQt1SB1CN3yNQzIgJR8RmekHSmfihfmhYXAq60owx+pC2rUPcNvVKptvjqTGWd+4pVMOtUWtn1S62y0nDJvSPG3qkNTWs1CLvXRP5IrsAPU6kfnTtv3CQ53OWfuo9cSVcfMSvaIe0fNQ5QGWUETccxJZYgO2kVxHKpQiH/Woi4Z2gW8mCZEc6pmNKJPrVVS3Plrw9VHq+tTh9z4IiXATPWg1gddIggUQElzxqOemhhfnEDI9G2FQWDPKdIpJO+ls4b+choH3FV/qmKPVZlj/5DG08v6oWNBZ1DHpeKNPxWSWBdyrH2/MbGIXkrbBSCAbtcFnhl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMBCOvT6fWNLrnzzoGDJGxvxVhRpiMAF9NJoFg95TNU=;
 b=PDw4IVZymP1QFOB/drUMH442mQRXhBQRrqOclZUDkOxB+/YWMZcjmCGQjmtZn9SFUxilmllzrj5cDGhW01ky9z87VsiVOwIMfvid6PAA+dYFVzU4hCQUeMp5BPF8YeWNigHRL/0auSlJ860H95+hw+zKukjpXex4laYbRgWYRG+zWbChXyUe9blG7isD+XduBbvy1OLVN3+HWuTQNNNWytytTZKg4gEE+X2W/fjNa/iC2+bwbn7IaDhogM+9DqEEKhpHOXrJ6cNgaCO+85fT4n+F8dXppNocCPIYV5qoc8mkcpVJ45+HU6yv2gNenWZ/sTd834o3t8bDFBA+rJqlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMBCOvT6fWNLrnzzoGDJGxvxVhRpiMAF9NJoFg95TNU=;
 b=KMUEFfFBr/PGORa/NBWbbQmeAtxEsTGf4giFsvtqNs3LTxcTxlSI/uHjJLzOF4Yb4oSItALRJMWjpWcJNxu1O+WDHWpPgq3eA1bH7eWLn/S640BnD16I2dKx5Wu/uaeZKmMzUwBZLbN8KwxHTHlrcgsqz3qdJir8qekqFk65gJc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2744.eurprd04.prod.outlook.com (2603:10a6:4:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 29 Apr
 2020 09:49:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 09:49:05 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: select ARM_GIC_V3 for i.MX8M
Date:   Wed, 29 Apr 2020 17:40:15 +0800
Message-Id: <1588153215-2435-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0114.apcprd01.prod.exchangelabs.com (2603:1096:4:40::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 09:49:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c223ad46-8f4b-47a8-901f-08d7ec228e22
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2744:|DB6PR0402MB2744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27446A62E674B62920AC079F88AD0@DB6PR0402MB2744.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDhkkdMU2mo61SnxwV1UxhDRsaqMy7W6lY5D07mi3oESgqiU72Z8sVDz02FHsWGjhKGXjIoMA3KnXmWMm+9uN8yb7u9mojzbZ0WkrScXFYakJDkSTanfT3FltfWX1B0WYFw0QZIuENso/F/DmFKxUEAzexs0eRr645dyPK0Zp7ae2+JxP2vd866EqcHG5uaW/mo8XDA7VQoUpLTwAgB4fdOh3sf0A+i2PPbBgn5Xwg07wBBeOedgBan/+LWdq/3seY4fAIDdt7AF1pUIUhqhWtBDc5evWaUOH9FuZmwxsPjiAOlzAdfwfKWRooiE59SXv1qvKfUaY05RADwnE65NowjR8Hsy9tIGTZ402yoZzBBHzv/yY1HwpuZY32KPeNJ3BHcUoqRyTh/teZz59hZwf5rMitTzxLMPjsiZdHe3iMh6yZFMaqaw+L2c6vdW9nR85K55yy8mGGej78KEWuUrm+0dartxqfXlwg1nvCQWeaDOioSXj7wJRYVCljmkIpPT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(66556008)(66476007)(26005)(4326008)(66946007)(186003)(16526019)(6486002)(4744005)(2616005)(956004)(6512007)(36756003)(9686003)(2906002)(69590400007)(6506007)(8936002)(6666004)(8676002)(86362001)(316002)(52116002)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iO5lUNLjmJIGD9QVz0FzRm4vEmKnO+50ELDjBmT2aEg2FspXnA7IlACdFcLdwvQu5Yd6b8atQerOU0iOLp8XuguphaZuppx67vo30kZCcl5nQ+Me3Rg6tz6+JTHqv9nmRZTPpdDVRyXUrhNFj4YFGPRPyhtMAbz43HNcnDDXtCiZ7tIRP/FQAdSgCxglGXPWZ7KQ64FDqTqFYETCh1ahvr3bbQ7TWqAE3G3rLGlRrarRwNkyPnH3BDzv32APvUriGfu8GBDB2QldT+yQoLzSYRB4R5997r1MtQO+C46GlIim8+4e96PgJmjPPmhkmON3rPY+E7gzizRLRmxkumXgGUzXS5tGAcRJSXn8jbR29mBSYAsJLYxYZbatlJFTny4a4QLedpbEjWdwt4g3EjE5SBvdkYXxaLMaioDuNsbbsHcLglcEXAGfpxYIe2OtnCxTb+8efjKIJJYk2cywkTTpL/kGkpScjyqiJyqj5+2mhTjETeN/eiPKMSHlEyAT1GmEcesMeqK3DRl+aBPEaEbHKsLZ1pk+krOsqgADwYHL7InCjAOiz+yxSsooGJn4v56eUjpgDdF6oS9YQzwhpoWxgcClvXXYRCu8fnfvaVHPyRRHJLUPsRnDxYdJ8+lQLKvteyApyZsoyKNnX2vOCZuEe9uQXAYFjvFRLoYCAtqv0uJs7bVLL+rcFofdmPvmO4bQ26dLh8BddtJgilCrw/92DuYbh17LUHAF6mtaWnftof1fi231XtVOuyTbEq1QzUAWQsUcL+V19vUve1GOsWElFCrk+BQSRoxuN7BvWN/vttY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c223ad46-8f4b-47a8-901f-08d7ec228e22
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 09:49:05.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kv86qiUboQIi5gwVQ2bc/fbb0tC9gUFMTVf5Y8BGNAPcJimL1bv3y8xwhYwyJt52wGOHwRTX3txF09gFPiLn3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Select ARM_GIC_V3, then it is able to use gic v3 driver in aarch32
mode linux on aarch64 hardware. For aarch64 mode, it not hurts
to select ARM_GIC_V3.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 67aa94b2481b..f4006b784312 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,7 +20,8 @@ config IMX_SCU_SOC
 config SOC_IMX8M
 	bool "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
-	default ARCH_MXC && ARM64
+	default ARCH_MXC
+	select ARM_GIC_V3
 	help
 	  If you say yes here you get support for the NXP i.MX8M family
 	  support, it will provide the SoC info like SoC family,
-- 
2.16.4

