Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4931EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2732075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="r5vX9K8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgE2XFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:05:21 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com ([40.107.20.101]:10081
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbgE2XFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:05:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU7c83g7yjpqOC1b+vnBDEvm8eedJnAbiv0+X91d8nPRZUS7A8BZzisUN68HxXIBdj4H+SJDpLSlDPhsL77+FDm8QHCEYWXqESF/E0XuyYQrohCkJedPcB2Axy7im0Ip+3ukYXohDVKLvFCQilI37ei2lYOq8m81mi17TGOJO8F+gXO3qeSASv4E7//awfGwc3QvI/RkgWhoaH0SoCI3hNen/NCrv+HpRP8CjMTxt38xro/XcIxaLpqN0HatSy6+mKic0ZnXhfDaIO3KeDlwU2+JMjYblN2GPNz6LPdZPvJwDJTKys8khalyRRk/JMZf4rm0UOiM53qd0dO0/zrvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMM91Ih9F2eN44FQ2d+iuPgvHRlH/0Kfwrti6jwFeT0=;
 b=f7tfU0/e9uWGHCdMo9hVJzrOOxDHcwndA4stic7JK8S33T0vact8wj1pmoi5aAGzEb75QUwkPKQq47tG4GJvir4hNCLv8FxiBF3NH9BhajmPkb7Uj4voAQI0Cu2a4JUNwyOQHVRUxmUtEDr3qi+qPPA4D7JMKxf6C8N6itTxkXexE9tez9/S3hswnAzBcKFBagIN0K+SQTVWDun08rAnTl2rU5SQIMy5nsg68iGv+AjGKpG9JQIj0HdtylqzsRe0X2cRvFgOjPI9O7l/pBsW23luJ6cpQWtUvZgcjK4S+hzvU9GmauzKB3krJ30+fVsCK5UwOhXPRc84MnI5pzvwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMM91Ih9F2eN44FQ2d+iuPgvHRlH/0Kfwrti6jwFeT0=;
 b=r5vX9K8FRRp35fhX+fu4YU2oTJX/14pgOp7j99KRdPS4M1NXbhIGV8sCVO3azbTA/Y8CeuCeio2sN/Y9Us6w1axR3P5pnQ9JXRTlEAoSwSbxTsZouUoIFZucYqXYj6eXctK60AZLmuvQ27yyh1z9BClBBSJMoQ+xWtbNxeU8MLI=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0622.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:12d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 23:05:15 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 23:05:15 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Taras Chornyi <taras.chornyi@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 1/2] nvmem: core: allow to register cells for existing device
Date:   Sat, 30 May 2020 02:04:50 +0300
Message-Id: <20200529230451.21337-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529230451.21337-1-vadym.kochan@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::22) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 23:05:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb69217b-df90-4083-a386-08d80424befa
X-MS-TrafficTypeDiagnostic: VI1P190MB0622:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB06225C719FDD0F574D59A768958F0@VI1P190MB0622.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaLTzMZP97VNV86KlnMbCmnkAVpeP0uZqJibcJgKt4sUX/YH19THh9gX50hVUBLiBeLYav9YWnm4Rzk43LIMIxciJPf/VFmDH1UKWbQA95q44ZuDJtj8Jb7/FeaQwQSWMPzKmkKSZrMTK7z5Vf6zZLE9spp3eIfNrZPgCjaj44JjHSrUjj/9SC8An1BOtnr9T4ybUuDCYqjBf0yW71D3EInYRRDuMWIrMXVSLu/qqZ1tTLy0wJ2ErkD0DS2xxgPmg2GNjJkOy0Hzx0wUu2FKWAqkuKaZ27ZVPR1EIn5lzD3PzBLrDejdl2ABuRdIVFb6ZUychN8nA5KgPAF89MQLww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39830400003)(346002)(376002)(66946007)(54906003)(8676002)(6666004)(6512007)(4326008)(8936002)(110136005)(316002)(6486002)(508600001)(5660300002)(52116002)(86362001)(107886003)(186003)(2616005)(16526019)(44832011)(2906002)(83380400001)(66556008)(66476007)(6506007)(956004)(1076003)(36756003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UJwJI0yGFODWkZQu2w7ef2xKiDE7xR/Ge/R7vRDSWlSME+PVI0CYKRVKHxbUDsnyn30D/c+lOQiQPG1+vCikmmYcFG8bdyZWYPQteq/mUolXbYxstqKDMI83sSqlEA8xABAQPh+OzL0Ks8p1xTIb36ARu2TkJSqfr+w74ob37IB4rxG4OvYsbeZaO5uA0bs2yiXMp95OHKyg/Wxoksqg1ueLd929k+JhpK0WaXev+zDNoiVDAspqGCIlWo7BCLFIwu8mNEZuk71QOgvvTXdsnMoFV/9+3CgxmwWNDRpLjm84GBcy8bsexdWeFy/+DAOT6YMv4VRaWHNuKFQa/vcUSKJBybUpZGSnR68fQnFDWSDrcpJ/WcWYPj6JXCJWBbD8AwjvgVWmYgMKI/enIiWtHw3ci2RFBHqiCVx5aGGdJQMX5+L6L0wSNtmetffesB3dZi6NYbRIO8bz0SwBWqoCNa1tcr3tLtM583DNVa1sV5Y=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bb69217b-df90-4083-a386-08d80424befa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 23:05:14.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8blzd2N6xnFGK0o8TKVkY5uvDAOErr+Z6oexpvTwEdETzU4kqEhDgPBcZc9OMU9i0gEThagYT36RjFei1gczmGqb4MSRjV7mcxrzAdJlSOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation does not allow to register nvmem cells for
existing device and requires that this will be done before device is
registered.

But there might a driver which provides only cells info which needs to
be added for already registered nvmem device.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/nvmem/core.c | 59 +++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 05c6ae4b0b97..39c9df9ae9a0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -482,35 +482,43 @@ int nvmem_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
 
-static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
+static int __nvmem_add_cells_from_table(struct nvmem_device *nvmem,
+					struct nvmem_cell_table *table)
 {
 	const struct nvmem_cell_info *info;
-	struct nvmem_cell_table *table;
 	struct nvmem_cell *cell;
-	int rval = 0, i;
+	int err, i;
+
+	for (i = 0; i < table->ncells; i++) {
+		info = &table->cells[i];
+
+		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+		if (!cell)
+			return -ENOMEM;
+
+		err = nvmem_cell_info_to_nvmem_cell(nvmem, info, cell);
+		if (err) {
+			kfree(cell);
+			return err;
+		}
+
+		nvmem_cell_add(cell);
+	}
+
+	return 0;
+}
+
+static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
+{
+	struct nvmem_cell_table *table;
+	int rval = 0;
 
 	mutex_lock(&nvmem_cell_mutex);
 	list_for_each_entry(table, &nvmem_cell_tables, node) {
 		if (strcmp(nvmem_dev_name(nvmem), table->nvmem_name) == 0) {
-			for (i = 0; i < table->ncells; i++) {
-				info = &table->cells[i];
-
-				cell = kzalloc(sizeof(*cell), GFP_KERNEL);
-				if (!cell) {
-					rval = -ENOMEM;
-					goto out;
-				}
-
-				rval = nvmem_cell_info_to_nvmem_cell(nvmem,
-								     info,
-								     cell);
-				if (rval) {
-					kfree(cell);
-					goto out;
-				}
-
-				nvmem_cell_add(cell);
-			}
+			rval = __nvmem_add_cells_from_table(nvmem, table);
+			if (rval)
+				goto out;
 		}
 	}
 
@@ -1560,6 +1568,13 @@ EXPORT_SYMBOL_GPL(nvmem_device_write);
  */
 void nvmem_add_cell_table(struct nvmem_cell_table *table)
 {
+	const char *dev_name = table->nvmem_name;
+	struct nvmem_device *nvmem;
+
+	nvmem = __nvmem_device_get((void *)dev_name, device_match_name);
+	if (nvmem)
+		__nvmem_add_cells_from_table(nvmem, table);
+
 	mutex_lock(&nvmem_cell_mutex);
 	list_add_tail(&table->node, &nvmem_cell_tables);
 	mutex_unlock(&nvmem_cell_mutex);
-- 
2.17.1

