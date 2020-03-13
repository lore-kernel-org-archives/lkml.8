Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19105C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36C3206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ic+gFwS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCMCFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:05:08 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:38091
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgCMCFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:05:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To0N281RWkUwUgzM8kLesiOrwDQ0P6s/Qjce0DCJyUh7yVSU909bfoqZrq2c0X2R0Dmd6s0rFAVGvNdNYiphZC80XGzPEJtSd/8dy3AOqAkPLHprHItywh7r2I2PTbxsjUwmOM+AVuXws1dJ3MFFw/vcPdvsznRedoOmYqehib1oQSmGjVE/iGSeo8/8lwtSqE3Ip2hV58982PwA9lVyWHHuejSp/vlyWfBx/8A58U/NkhEqb18p+qH6YqUZocL4N8Pntow1P7wU2tXY46Cy6EBv50DFFONtlvzrM1tZj2cOf1SOUH8gtvcWHu8xxMVHbTCzIrhLfZ3ZKAUbuvajqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiXC1bkJhvkPhtJJc2/V1Kn8ft8EI+LD5V+/7IkcqlI=;
 b=k4bHetj2rzSZK3Iszpxt1EMwt4D9YDlWVa4rdEEpD3dp0n7DLoVf0+foGDHhbocsR9WvajuqmegHFyStQT8F19AwL2XqrfZ0wOgYvWPm4EcYroAeGY4YJNj5eQAhJ0UQcPDspMFH4HESDw8140X1ZgSpheBPfpF5Qe6bu55AJ5ltYV3y1uzb6ICxut+T8c4BYadiVb50DY6ujCssEecS62XDG20JIQllG8lSGBOS7smwnNPyRAaJlwCjZyFAQRbx+o0xaA2QKhpcPPwGgJlTwSfIeY8mQqc1e6tEJ21cgNN7pXaYmz/V40bZ0GmhAgnya8vvzP28ZIXnnxLvNNAX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiXC1bkJhvkPhtJJc2/V1Kn8ft8EI+LD5V+/7IkcqlI=;
 b=ic+gFwS7msvMwX6K1HnkBNqgu+n++7yW8MkblFcLgsh3+yJfziGsek4w4BGK8FWgMmHGTcGTeE0B6Cmqs0SfS3HZUUrnxzAS4Brxq5TtHNjGHFK5dkUX42h4/oUNnHuPtSUHq/5+4ccYQou2kjcSkwxUYwOGMSJ5nyaIjzr1NPM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6324.eurprd04.prod.outlook.com (20.179.34.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 02:05:05 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 02:05:05 +0000
From:   peng.fan@nxp.com
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] regmap: debugfs: check count when read regmap file
Date:   Fri, 13 Mar 2020 09:58:07 +0800
Message-Id: <1584064687-12964-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0112.apcprd03.prod.outlook.com (2603:1096:4:91::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Fri, 13 Mar 2020 02:05:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ec3658b-4c2b-4daf-2df6-08d7c6f2f25e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6324:|AM0PR04MB6324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6324CF4CCECA4E9ED453CB1888FA0@AM0PR04MB6324.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(2906002)(478600001)(52116002)(86362001)(316002)(66556008)(9686003)(81166006)(6512007)(4326008)(81156014)(8936002)(6486002)(956004)(66946007)(8676002)(66476007)(6506007)(69590400007)(186003)(5660300002)(26005)(2616005)(36756003)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6324;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+mRxw7MuNlAM6dM1lbR79g3gsg4NYaXbBeuwgLt+ukX9TdDenRqNMwWAOybd3SaQecoNwiKrKN6nU0BN7N+BgxC4P4KtJsICnEU9V36Z6cvv6+4NYk2o6aaZ12LyJ7stBj5FSfOtTC5YN11qxZ8xT7GNY7iiGYeJnaifiXBivkFEswe4xovs/NgRsT9kFailv6NdmAbD7GD+pEf4CmbQJrBHfa+z4SU4Xo9i1De85g5R19PzHpaCg5DpIBy8lbbRnyVzEoc3gnQJMJrTSODXmLGKk2a4Ws4jZHH2YOmaA599M1ys9cgqv6xYfFAo7DND0x3egPmGfMRafurLebHH4inn5o8pKv6ZJVxDVmF4GM5T/eRukY9iIYhKKTARj7FKw3fPlzMHjdWIRO167XWakAHODf7u+wbjY5/ZFcdlss4UR1rlSkk8VlwQO6vnf15BrmE+GxktJAYTL6Ku/GGEGA4vkY7yTtzbswCm2dyKFdbLIJ3o5sEP5HcQo8ctQsG
X-MS-Exchange-AntiSpam-MessageData: n1XuXhBx/RnR+y/9dYzmJ7+BIZFaHerJKXeZBFmLL95q2JLtjZX6pU/E5aipioOFX/M+KBIczESOpbF5rqNsdAtEVbCaxOy3j2gFey5xEGLE67G9iXwApES9R2Yk21f79WbxvpEcrZNf/cx2vdwjbA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec3658b-4c2b-4daf-2df6-08d7c6f2f25e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 02:05:05.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f3oYFpQObBsI/QKbc74ZsDkaDzltcSjNL7bP/fGVnzX9dcqerqBmrnIBYL/Z3objjKMHLEBprQBr+/NHUOAdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When executing the following command, we met kernel dump.
dmesg -c > /dev/null; cd /sys;
for i in `ls /sys/kernel/debug/regmap/* -d`; do
	echo "Checking regmap in $i";
	cat $i/registers;
done && grep -ri "0x02d0" *;

It is because the count value is too big, and kmalloc fails. So add an
upper bound check to allow max size `PAGE_SIZE << (MAX_ORDER - 1)`.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/regmap/regmap-debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index e72843fe41df..089e5dc7144a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -227,6 +227,9 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -371,6 +374,9 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.16.4

