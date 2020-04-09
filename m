Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42044C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8C420784
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MirtrZrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDIIa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:30:56 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:15185
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbgDIIay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMYsn/wbtahym03kJhldnQS6Jo6M9jjDCHww2SQeJboGSv5MY7SUFRox9UpawXP9PLgjD910q35g2qHcTu4qV4nSuSpVCKli19FZqCmVd/4gAxbaOrLR6tgvZJFA3a7zAWx5JbbvYs+HBcklkqwcxAfGeySzF68gKuKDF1hNL9EPjxa/r3XqvxEl1e2qgrl7uA3IDLsBC9UfKdxYB6cccZAZMe6FqUtorm8znPuKDVbQZKxcrmRd2tBqeCl+N1/owxTtq+JfYwoJ3set1k2WRSxb8EKdrI9sgcp2BjP2PceriwdFdO+Ub0Z9QIkxuYAhk6L/t67Akbm+Aq1VyGPewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6azocKQaryjCgl7bacQy7gAlThzCAyLJBD0cymiy+n4=;
 b=bjOjrFj1IxjPXQDLx+on3W8ePd29Yjn0zxRLDloHL3HVsdj8TZACr/cqUdgyjd0hXh1jgdgLJqBoNsP9Q+03RYa1lGPgUJWuowfFeYLx4GXJ3zXisZVygCDY2XQebzXbLIHA39J1klb915mvTDT+draIyTVcivPhnWN1+c23kYYadX9hZ6WnweAAqz1JElO+F0xH6Xh0+Kj6jEgrIIBKQ8AkTSdPeR18NTU/DzdtJ17MOkDJYJ6KgA+ZFub9FIpbryhv4XK57V8BTMVpSC/UEGNwPGnnmVCxfijish5cNH79o8YCoW/2XP/B+mRCJ/q5Q12LYoA7O+bLJKC532Bavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6azocKQaryjCgl7bacQy7gAlThzCAyLJBD0cymiy+n4=;
 b=MirtrZrC2imQHAgJcy2+f8950rKxGIaALNpEei2Ww5Ww9JNWOdA3+TZOJfkcFZLgLSUyAKysfEaYfH/D7u/mmEfklFIokaYLtzGCF8dyrwZnR7Z2ig6TqMgUXEdSrZYooRpeCxCgZDQFIsSKVImCST1ftSEu/btNrV8uiIwIP1Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB6626.eurprd04.prod.outlook.com (2603:10a6:208:176::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 08:30:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 08:30:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] remoteproc: use filesz as backup when translate memsz fail
Date:   Thu,  9 Apr 2020 16:22:52 +0800
Message-Id: <1586420572-28353-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0133.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 08:30:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb80e521-3435-423a-6afa-08d7dc605010
X-MS-TrafficTypeDiagnostic: AM0PR04MB6626:|AM0PR04MB6626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6626362ACA98B2CF268F613488C10@AM0PR04MB6626.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(6486002)(86362001)(478600001)(44832011)(316002)(2906002)(6666004)(36756003)(4744005)(6506007)(66946007)(66556008)(52116002)(66476007)(16526019)(81156014)(26005)(186003)(8936002)(8676002)(956004)(5660300002)(6512007)(81166007)(4326008)(2616005)(69590400007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ/gxFV95QEIqqEVp4/syRHekkw+Ihuj9K09DisMsSu3iqi0gtE4CH9q/NsiA05rzRqE/ayl73owZ18+dqJepTL0VhIy3wNS6a9IaqqpprS1zV0b5OOT+jxHBt9KReJ7X+sYNgu9uzFOFQzOicQ7dLuXvDxOcsqz5J0AEBFYaUWdlYUDHIi+n7YU/zZhJ/vDzR0Dgd3Kz5TrIbNgTD58kjuTrQqHPynjJRnWPk3PbpYxHyUE0LbqDxaEC7081eU8PHG66RAVhZ0WmD9fSHb3Wsz4LoEHfJqi2/fmonLNj3mEAn1+1qNivsBb/7Y9gr83/TSBwu6g3Z3pXOs2g0AoMeuOr+YHTpNzRoRwCJTdKKlrA2NeIt86pvPBG8hbfsNjMv3t67/BMWWzijcxv/0Qm67HSelh1xH2UiTLnlc2bZrt2fbYpsdUMUyibYnXZTw2GqNvVY0Zw2R3V6ZZF6FeVI5i8s/y/f6KovBKnrgdseo4gX59pdvt/Mu3YGpd9Uo/
X-MS-Exchange-AntiSpam-MessageData: oeBW26BXhJs3NSoTUt9hAWLO/aHd1w4KaF8vd4LXLTF4fbjU/NkxFiyxw6hCCk56ImvbZ2cio/hr4apuABod8+s7pkcfYCGewmDP/rgJOwOXpNnUKezLqSxJcN9rtWaJIOIyvTnw9mLpox/uWszIhw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb80e521-3435-423a-6afa-08d7dc605010
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 08:30:51.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoZz+DkwyUBmuDviKHKQf2F8j3qyDvINIs1VmzxnWwou9mlm8fG+Da7mNFQpMzcKylqYygn/LjkkzQaZUmNlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we no need memset if memsz is larger than filesz, we could
use filesz for the da to va translation when memsz translation fail.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index cc50fe70d50c..74d425a4b34c 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -229,8 +229,16 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		if (!ptr) {
 			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
 				memsz);
-			ret = -EINVAL;
-			break;
+
+			ptr = rproc_da_to_va(rproc, da, filesz);
+			if (!ptr) {
+				dev_err(dev,
+					"bad phdr da 0x%llx mem 0x%llx\n",
+					da, filesz);
+				ret = -EINVAL;
+				break;
+			}
+
 		}
 
 		/* put the segment where the remote processor expects it */
-- 
2.16.4

