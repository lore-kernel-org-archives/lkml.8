Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EF920725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pKleIxWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGJBrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:47:32 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:28897
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbgGJBrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:47:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKKejgdMiww0M0YuxuCyd8ZaMB8a5e5atiw9Lfkc8Y7B8g4Czv1gWHQ/2Na3E1VIwAAxtckAu0lVw4ymASDx/01S/QX/+S8lNvPWYDpQIWWxFlGuPiAmuMF3PYsrpvsgsuS7EpS8DIrRPbPUCW9LQHIPqZw8j5Iua15UIntLNN6H2XEK31Tt2hcsJ34y43U5JnCv/h30WgdL+IMj+f05H0T/63pq/n/R0BQj8+S/zpU1rKAm3gC6uoTFaZSj18ZA7aVf2rGl2MfJNy1GOetB32xt1i2k/0J6EeJlEgnffm7uY1s/L2jyjGD19ZAmpfhGD4lUtZFxkdHYW+VHyYqtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEiA1XaGnzqBvcCf47ubC2kRinUa+1W79CZhA+Q/cAw=;
 b=EdE0VJkVcd+hEDWOJMJDUqz+6YmB8aaHkCi2eqznsELomXHOxzzaWBtehqu8NRgdvbOUtkA4TA8wl1Sfs33crAN7rbpmhzyVapV9+NzlW64wIINlmly088AGUHSNo8GC+7Ib3knhwXDetiG9PIvPTr6i9guyZNn8V9N17wudUwwhV//xXbDVksrFkvsHXWGQv5SuEpm8UQ1JygxpaOhT5bFd8jVvzMGdX63ng4/KuzAHKGWgzmxudv+nmUUAr4I0lqpVOsXxGF9POIeG/q5Vwapdc0PB6yvf8oqd66im+9h4R2b4qyNFzrXjprNVZxyiIhOpqaTtQQ5qlKVmoUNKng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEiA1XaGnzqBvcCf47ubC2kRinUa+1W79CZhA+Q/cAw=;
 b=pKleIxWfX9NxDN9Hw0W8Kory2Vzjq1HcwH6E6mYzk1S/innTRWTg1lq3A90WnRAThgM8db2e1eYn5kmUAG3HCPWjhxfhCdXF4QovGp1xG5sdMhSiHXSueh1xMMaaL3eJYVHxWthsaUInMdceCYuyQ1St35ulkcWLo6myWiwG1ac=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5993.eurprd04.prod.outlook.com (2603:10a6:10:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 01:47:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3153.032; Fri, 10 Jul 2020
 01:47:28 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] soc: imx: select ARM_GIC_V3 for i.MX8M
Date:   Fri, 10 Jul 2020 09:43:53 +0800
Message-Id: <1594345433-18001-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 01:47:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1389c86e-b978-47b9-9e07-08d8247333b6
X-MS-TrafficTypeDiagnostic: DB7PR04MB5993:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB599357AD37C74AB5A67F78FD88650@DB7PR04MB5993.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6gcIs0h1wcfY8B2pcY44WeFqZ7rpIcRaqVzGqFL7yl/teNbw9wWYIXBCL/2jWYAKWkup7xNMaFYVFS8OkzpsohptKQB+hvzf8ztFMpkNqbxPIoZ9OrBpq8fnZ3wKFqzlZ/a/emmnJ8son2mCFh+L1i1CLYsmsvoMq9YcSd7D54yR9AuqViGQskV1jcA5BP4AxOnKz9xxZElBkdqPqg1+bNvmjvreOueMgzxRXn24qr3bVhTCTxWwYam+tpHTIbnHbXi/pYwW8fqzEMA4cQ1VMdsJIvUzxN9BNerwNLaa883MqxuXzDfN5UNa6jiugJ2ChaW8BT578GltpDQsZlFynwqGSL+la6wjFM4IU0h/HDCC0FGb08BBTHu+o4AYA4v9GKihqPbHEAVSIsCIkB8tmTiXZbbb6FIvLN0ImXyOcwQdkY0ac5av99Ek/G381LkkRZI8zkBeKiiJ+ZS2VGZ/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(186003)(6506007)(8676002)(66556008)(26005)(16526019)(4744005)(2616005)(6666004)(956004)(66476007)(66946007)(36756003)(69590400007)(86362001)(5660300002)(6486002)(6512007)(966005)(9686003)(2906002)(478600001)(316002)(4326008)(8936002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: paW8Iumoz4HD8QV8UlfLar/glvYRWHwQBqOBUBaGbWfHZuIovNmqmibdeixDIGxpgUU+MxtzEwfwZrKQn+zYaF6pMPrh/LUAVW8rhBujRk4PTt/6/qY0wyGhjz7RGJ02rx8U30RddhgtL7klZQrbIBcnPTJpIfL8KThkmrUDxxjKG4VwAdpkOkgZTCnMtuQkFh3rGC4qiuYjJkwKKDUlgj0zqQs/Co8/hBhR148z4ZEolmmaY6YjrgFw/FL9vFNQqBcdklKH2Ha1vK63iCHq7AoQ6K3NsdoiUQ4TUqv+xmb/4Ic1oHcZzWZXiGQDYkg8t82kMRMyu208qWLc7MK4FOJ4aA+fTH4oZ6sSZQRUVSjVsoTSnwDzW98dzWtv97cTj+6NbteO/9yXhprpnccZJTyKmWJGaBo9+4/zi/9zWbJiTBOzial88XgxjJDmqeQV9PfTnSgHaCTbCKAGRK3+eYg7Zh5Mt1496Z1bJO+47S9A298A22XA4SfF2GU0g2G4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1389c86e-b978-47b9-9e07-08d8247333b6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 01:47:28.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1SjYiYTt5rH/lyVI4DE+MixZI4yY/n6num6YtMvXb3SBtbqlftqObXGx0uuvKushIzbGWnFk5qdMW/PwiI6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5993
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

V2:
 Select GIC V3 when ARCH_MXC is selected to avoid compile test error
 https://patchwork.kernel.org/patch/11516553/#23321403

 drivers/soc/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index d515d2cc20ed..7da10bc99d21 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -22,6 +22,7 @@ config SOC_IMX8M
 	depends on ARCH_MXC || COMPILE_TEST
 	default ARCH_MXC && ARM64
 	select SOC_BUS
+	select ARM_GIC_V3 if ARCH_MXC
 	help
 	  If you say yes here you get support for the NXP i.MX8M family
 	  support, it will provide the SoC info like SoC family,
-- 
2.16.4

