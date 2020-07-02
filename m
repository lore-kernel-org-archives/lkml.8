Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F6EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647F3207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="BYQ3+zU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGBCCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:02:19 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:11854
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727917AbgGBCCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrRAgB85ixiE8cL/9yHBJTRZ/1z0mA50Z7lJP1icDppLXh6kAqBsTTvCgsnBUaqXPIwGsJuj7/F0LQR9F2GpR8BkBrAdrPuQArOVMpu96HGbZBZ7F8y/vrUpBaRfxSh9KH5vsLkEmM6k3/rqNWNXI74GXMtNHqmmzKH29oDDCES7105UvwItSr/oaBoRv5AhHpak8wBDH4oCuTU5OuNQfnxdltNo1aju6SfFRcjrcrmkf1HH/DiD8QnvxuXBvrleRmKiJAUCQctfzwgdjmv66UGn+xwqzPUP0CSwwmiMxtvy8o9eH+42tb9TteJvwovGLwEQjkeIeW/dwzrqZzIkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USgFVIrUhty86XLsv4ZRhXiO3hpo9HIrX+3GMS/1nuY=;
 b=lhkhgon1PgKc3BKTPqS08H25Gk1wZbiBNAq7O8lppgUzullAIK/GNHDXahftT9qI4SPGXbYqNNsBP6/V2MQ1jdhl2mWvI+vZcnrIAcPKsnDG9v2m00VodXBgdt8FplODh4AaPfqJ5NVBfn/7pYDaWqvHTSgwtac+onvBPhf8l6z+f5bfHI0TmiNFqHHHjBAh/sZy9h3b8z/3s8oVqrLr3VtE5ogvtngDUFmg6ObD6zmvPtk2pwiOyLo1quHmMubylyTm+oGn4Ea3Vc7Qb/BpGBUnMqdbvXCs2Uou361afyAOxQukt0TBcj5jxQ+nM5WYlxUMpzSJ4t3Z7LKrQvpvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USgFVIrUhty86XLsv4ZRhXiO3hpo9HIrX+3GMS/1nuY=;
 b=BYQ3+zU7Zgu+B6d1Dfr2JXI+kWYH6B1WvCmkUlzKd47Ag01VS/g5JoFnq1DcVc5RNFYoGcxeMNCMcp7AnGF/zPYvKu/J2p+kQrNC7CbN7h0LEp885wqH1d7O5JPCK7vo1F52ozmq08vkYqWcpNExND5mtCLvpMwC1s8nMF1d0kU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3703.namprd03.prod.outlook.com (2603:10b6:a02:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 02:02:14 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 02:02:14 +0000
Date:   Thu, 2 Jul 2020 10:02:00 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: mp886x: use .probe_new
Message-ID: <20200702100200.1a4c65d1@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::35) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0143.jpnprd01.prod.outlook.com (2603:1096:404:2d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Thu, 2 Jul 2020 02:02:12 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb758784-64ea-49e0-135d-08d81e2bf073
X-MS-TrafficTypeDiagnostic: BYAPR03MB3703:
X-Microsoft-Antispam-PRVS: <BYAPR03MB37035E781EF8A120059C8F0EED6D0@BYAPR03MB3703.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+ZM2rmCtLAgQjeD7c/MM2tG6CHeT/QqRkUEFWodwe1bJkL3InI9DlLIHN4wMvRGnjHO8QruZze9u3xKdb8SYlpnly6xjYqgPTJ9kg1OIpzd1K765Gu1vE2ZxwmZqw194pP0QJr5YfU0HYMf7L1//TTrSDmykMTg+V/UZhHE5dXCu5G5u0+IBl3Iwj3cBHNS2f+bWF9Tdz7FxHL0g+wpfihE65WLPbxYs8ApGEmGc2Hv0gLCeiJrUDGSgst0WcN9QNHgvDPovxRg+GWPJ2HcLLv7U+GJMksp52KqoDFi4dfbnQtlsmjF5EpFuLdjsdkMs616RaLWyJ0It1SZuNyebBsC7bU81fTg4JPvbjugWAlA8dbMatYIrdQwdv5bG4lg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(956004)(8936002)(83380400001)(6666004)(5660300002)(55016002)(16526019)(26005)(1076003)(52116002)(186003)(66556008)(66946007)(66476007)(7696005)(86362001)(498600001)(110136005)(6506007)(9686003)(8676002)(4326008)(2906002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VtIFngrXTJmnjEuB55Ng10q7W2lHo57uY2ktOaHmTlphDcy6WVsK5NEFOwp2R+ru3DxO3LjYmn8htmd+0csqr6AZVHlmRRr+giv0xvPmVxcUGRg2WrbeWLmreSIkEmOPFKvEJewL/WBvYRYhs6f8RAXCXouKHfSIj/cJeKeRq6BvrYaEgysrgfadN2hyqgbS2AkD9MPjLCie789iKykcvy8s0fVm4Vve9PfhNHVzMbmw4qlZuLroSOLFRQNtjfIdShKAFytedc49oJ7jNrq3tSy2fW0iQuFpfWZc3LW6r6h0uP2nIMOXvYSZqmYDxKHj4tRfuPj3f7IiPKXg1e6qNmvIqeVNPHileYGQN5Us2bKZ43tsyI2uFCMZDYToKiZ2bWh0dDXux748PEeCqk6zT/lj7fMKYcK7uFBT2BJlTU7XHjTGbxSmACJOGZlet7ohKI37vcBgJWEqvL9UMMzlOlX2CZS8jZDwnhOh32BRvw0Dr9/eFKP0dFjwawabbg3B
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb758784-64ea-49e0-135d-08d81e2bf073
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 02:02:14.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfDWW/4sBU6zY9hLDO+MkbDtorWjj5hCmx8jw6yRDr0xV8lkFlllIujOxSFUOovEVfvpVYqlPVLYoCWL1yYE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3703
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new .probe_new for mp886x. It does not use the const
struct i2c_device_id * argument, so convert it to utilise the
simplified i2c driver registration.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/mp886x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 1786f7162019..d3d475f717f4 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -206,8 +206,7 @@ static const struct regmap_config mp886x_regmap_config = {
 	.val_bits = 8,
 };
 
-static int mp886x_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int mp886x_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
@@ -280,7 +279,7 @@ static struct i2c_driver mp886x_regulator_driver = {
 		.name = "mp886x-regulator",
 		.of_match_table = of_match_ptr(mp886x_dt_ids),
 	},
-	.probe = mp886x_i2c_probe,
+	.probe_new = mp886x_i2c_probe,
 	.id_table = mp886x_id,
 };
 module_i2c_driver(mp886x_regulator_driver);
-- 
2.27.0

