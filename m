Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653CEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481412075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="bQQ2WKLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgE0URk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:17:40 -0400
Received: from mail-am6eur05on2120.outbound.protection.outlook.com ([40.107.22.120]:52449
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727787AbgE0URj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku0PpfQWo5zELnjSd8IG8FdYtLc38aD9uTIDdLUlTOYcT02h1zs5Wc2IK1gxkpjqts2/rWwTlxXqxaR5gWt9ZHKo3fj8AM3jSnA1fMb6bj+pzuSymAI2FR7DGwLgjiMreSNTlRM6jt8tamcdBdyQKZDuKz5sMciJwbMgKmhjEAQlv2+vmp4XEtZbFy1JORehcT37FQVOZQO0I56GBbdoUvFUbDxgKdMJ0fKLtWOxLe5h2UMWXJ/jdeqLq9XcVGGbakpPb25MJJjl2LMdZDYq1Fd/Muhzr0wawVPi63oI2aaY2P7ezFxN0kWoPombVTsQBRcPOPm+K+O/+e0IwHLZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMM91Ih9F2eN44FQ2d+iuPgvHRlH/0Kfwrti6jwFeT0=;
 b=nMIZ+0VDDH0DmKCvpCngxTd2qP9cpjc7CZEomA5wurPjo+1MqPJf8q4VnLWS3uL1XRPbm9DZW/joGNHFIa2DD8IxRDtVaKjLizp6C2uTelCk8X+06XTwbWHmSk98lziK27LRjNrswdIqpU4SGt8uQ+3AGXwLVWWO2vIYwEHw5/rRUzPFtuHPhbC6sT9WltATOJhf8O0sAQI6YGZnmcL58YRGRr+RjAfr+NhxLl/iTOqgLdlsyTGoZbT2X3Ll6CL0DEklNESKYxX83M+83MGj1BBJ1WUuOWm/qsewm4gaXrFj4qfINcEMD2dhuvkCFSo2N5E77ooePjWostmnVEhLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMM91Ih9F2eN44FQ2d+iuPgvHRlH/0Kfwrti6jwFeT0=;
 b=bQQ2WKLmUMoSuTpwxkywtWdGz3oef/o+VM9cgkem7tEB4QUoMQm+4Tp95yHtdtvbybOWkdN1uNn90aCVTb6hJEhrrUHchlolypkv+OaZNJky+RzpRc3DIC+Xa8O6y9hoIUw4fXlYgmO3jpmtJBTB1s9l3VpqCLkbD7dN6nDQMsw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Wed, 27 May
 2020 20:17:33 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:17:33 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Taras Chornyi <taras.chornyi@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 1/2] nvmem: core: allow to register cells for existing device
Date:   Wed, 27 May 2020 23:17:14 +0300
Message-Id: <20200527201715.3660-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527201715.3660-1-vadym.kochan@plvision.eu>
References: <20200527201715.3660-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0106.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::47) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P192CA0106.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:17:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a5f4fb-0b50-4fa8-3a4e-08d8027afd2d
X-MS-TrafficTypeDiagnostic: VI1P190MB0399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB039958D55E94B3AD562FBEEB95B10@VI1P190MB0399.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNHijKDbnlsDMCoVn5nlg+CFxR8Qc7aVnP14ESSNdY/mmY94NkuD4RLyXK9kMVe/Bhek0Ni3pvSk/q0160hboLzGVL11tUz/YX9Xyf1O3mudR7LnmUv90HkAirocd6bLZG7HavIJyEmHn8nvAQkwwBeiDVgCIBJ0ziuIXwx56JB0NwMsgIne1p6AWDmLs+9plwkzYLbPMZpDdHpxqeXkPpF1MBnqx6GUTiKzwqgVh1vsjAEjJG32lcRRgrVeiC0onMiZMkwP20+Ceb6Nd9pc3mjWjcU1qc6EqELoCe2ttunuvbGWCZPlUmh2Dqu2jFdzWC/pLNmZ3D6UxD7ZhZl1+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(39830400003)(136003)(396003)(6486002)(6506007)(6666004)(36756003)(66946007)(66556008)(66476007)(4326008)(83380400001)(5660300002)(44832011)(16526019)(8936002)(956004)(186003)(52116002)(2616005)(8676002)(107886003)(316002)(26005)(86362001)(2906002)(1076003)(508600001)(6512007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VNj+mkdthAO2VjHSDImhZnkqcFZJHk0oROD2Ihs2AE774rN0HTXSXjGZrasoXXpnYx43W5jgAxBIJGw0flCh40ZDKZfW0KX/AtODL0sDnke3KeoaqIojsyy4/iexnvsaPcepXnaMDkJspwPRZYjWPhWZhJg1yRO86urnornp9JCvOktYbMKOdLW7rT+EGcxC1kOTRAkBFhIzHLd+/jOsOZ1xl3JDFra7vP522xq0vzbBP7pGgnikKTgp5YGssVlAfm9dueuKe2ByLM2c2T9tYEA0pvz6ze1rCfdtfL06w9UzV2TZsE5gzuhyvzTLbDJDCDipEOQvsp/+5cBe6WL6U27JFD+/H4wE4QP6gjZdHMWj43J1qankSG1T4v5x9Wlqvjsr/CtHo2fRkxMo+RTL1KID0sbLuWwSH8F9FPMxVm/OCKYb2pgglhVzgOSUAEaaQMRL9ve/qnvgRtX+Y6LM2wrnor7vlW7/4oLe8U3nDTo=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a5f4fb-0b50-4fa8-3a4e-08d8027afd2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:17:33.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKbBkq5Y+wEIAtOiDPaVmMlZpAswgddrLrF3AwZ5rTvX1EINrkpw+lNTIm7r2PMZUK18tk0DK/Ns151snp2eifgsEN2GoWHbvq5wgGIxLXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0399
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

