Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DAEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997AC20716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j0U2buWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgFWGBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:01:16 -0400
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:54054
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730149AbgFWGBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaYKAgzM3sfcrQ7i1v8Unn34igBgCJrqhpDE84SzFKSQDppJtCBO5rvMnW3E+PpEWKGuBYJRlB07wAelwe4LMKo5qqhMmwtm26ZMqCHd2NdgwwanNZi8z2uvoT+QN11knXI+wqa7DOnQmPD6Zrt8KzXdGyE4+RuNGPNyvpSlFfzurPfIIvBODo4m9HBMnlLuxzU8iYOM9Va/7oBKq7safsHGKgwbV9URm+nGdXxSv3rVb0+T9IJTXtoKpO7zT4NioxpjQ4bt4ErdjNHSxuODFA0kumzgYl6QagYfg0cln9EIKOkIlVI0U1j1DDbdgIowBzGJ16f9gtIXlBGBecFrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh4UjRhhIBmUKolvOKbc3UFhQvGuCwxQsjYZq4xFLBM=;
 b=J7WB3Bl4Cq1O7HOPhU/jaLXk9Ht1Br4FC3bzpM54mdMLCDixHL9sMsbxVsCEvocDPtq9eN8N5Mg5hYtl6UxY0AeCVzf+VfoORt9YV7uWK/Ny0Ov1JrcXOeKfSONY4EBnSMQvHfojy97uLiOJgaRuUPMm0lhBwncelx3clkha5XAcATzM3FIWgKHVV3mbLPQ+ALF56jEvtBhHFvdz33MsMEGJD74qtpbKmutu8BR9pmHQXtFPcsGPh4kFr7wi7Oyl6jZgQ5ysuwnQDbYNRn8A6vzIFYGZdT8gUZKpkQYuRKtOz5FdFUaVspqa96XUTeMaGTnfzGgmQbPMlUWykvgfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh4UjRhhIBmUKolvOKbc3UFhQvGuCwxQsjYZq4xFLBM=;
 b=j0U2buWv4Kkv5/BCAyiLLYF0JAphDGlh2C89WYF8gO2dideqt5dBI1qOUP57onNu4X1AE6hb9xQTu15BD0//ig5zsIsJgSyzHiPmLHXVR3bJY9nZlI1vL1NvMuzdLR9J+Yoeu7ej2F5wdtdFjZ/EFQXwUxwJcGuzAtBz7PtKIz4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6654.eurprd04.prod.outlook.com (2603:10a6:803:129::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 06:01:12 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 06:01:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v1] regulator: pfuze100: add condition check for 'ramp_delay = 0'
Date:   Tue, 23 Jun 2020 22:01:10 +0800
Message-Id: <1592920870-12693-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR04CA0196.apcprd04.prod.outlook.com (2603:1096:4:14::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.27 via Frontend Transport; Tue, 23 Jun 2020 06:01:10 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79fdb41e-b198-48d7-07d9-08d8173ad4a3
X-MS-TrafficTypeDiagnostic: VE1PR04MB6654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB665415275B88E99C22EC281689940@VE1PR04MB6654.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HBlN/uasuXIu5x42jpqhTvSlq/76d4YoXOnJUNcNtVcR0BuO6Y13LrO21cnIY/KwtySjGyvu2Gk7LduWAbTjiLOaxx1yjotzFq5qhuEBHhc+nvlN1XiJ3Ep0axMM9DOOqfBU/ekJUsASJbdUDVPAP6vMesOlye48SofEVEg4pf+i59hRmlhgdRX6eBQE8De0iDst9fjeqAwHHBCkLM1O8aS6YwQgYALr2ADjjZWgVZyFzmcD/h9YBxM7Ukg+zANzSawlCQTE3eG8Ftw0V9zJKQx/6RxuZ/FSDzK0pwKktzb9+Y26HXgwe0Q9bhr64FBrmT9hkOi+SlabFwjzRXGyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6506007)(83380400001)(26005)(8676002)(6486002)(6512007)(316002)(2906002)(186003)(52116002)(16526019)(478600001)(5660300002)(66946007)(4326008)(66556008)(956004)(8936002)(36756003)(86362001)(2616005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pljGW0dxhuHZ70AQumNrl8ys6O+1+WDI90tFj2eF7Ch+fRpLvRuFqoXHq0lFBmm/jzHtLRCrBr6f5/LmyheGRpWXJTlERpXZiExxMjHMG9mkjZp93xgrbNFElnx1gUOsc8n4YOTm6c3rKGDTTCzPMqMd8m+48A1vn6pRU47tCrUUpvFmuDwDFtWExBvdgkHfH62Hg4C3cey7xvTHjuBDw/lHQ2zzt1vpHdLaP9u8+TXCpbxplmEyggfrYxxGYzSDQcugUED3HqBrKumYqQbeQbbid9mJtIJoMQYlrWg346FHUWoGJA83k2EywTx0+Wm7EJ7pYXPYDWHM3cNZFKAvpTIcNkNwmOpsJZJBFgB8C/txeSOH425vSYSvQUElhiXkMxJ6JM0B8Zx8X4W1avOdW3VSjpYWAuH7fjm7Fv4Q65MyLdU4ZJKsZ1gui8nQAihhl/RFTLOsO6fmpNRMVAuGXEJ0yNNjortE2dKfjzFwoDk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fdb41e-b198-48d7-07d9-08d8173ad4a3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 06:01:11.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwYDYlMvja5H8TrqhJ8FHcyKT5sDxNOtkmkXWhOtjDnUxzYFrmNUFoOHvE2if6pRsquCe19TzC0LJBefx3eDJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for 'ramp_delay = 0' to avoid Coverity warning report.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/regulator/pfuze100-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 6895379..e75e61f 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -128,7 +128,7 @@ static int pfuze100_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 	struct pfuze_chip *pfuze100 = rdev_get_drvdata(rdev);
 	int id = rdev_get_id(rdev);
 	bool reg_has_ramp_delay;
-	unsigned int ramp_bits;
+	unsigned int ramp_bits = 0;
 	int ret;
 
 	switch (pfuze100->chip_id) {
@@ -149,8 +149,11 @@ static int pfuze100_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 	}
 
 	if (reg_has_ramp_delay) {
-		ramp_delay = 12500 / ramp_delay;
-		ramp_bits = (ramp_delay >> 1) - (ramp_delay >> 3);
+		if (ramp_delay > 0) {
+			ramp_delay = 12500 / ramp_delay;
+			ramp_bits = (ramp_delay >> 1) - (ramp_delay >> 3);
+		}
+
 		ret = regmap_update_bits(pfuze100->regmap,
 					 rdev->desc->vsel_reg + 4,
 					 0xc0, ramp_bits << 6);
-- 
2.7.4

