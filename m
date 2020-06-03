Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4804C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B313E205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ACXS2IXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFCJkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:40:08 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:46051
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgFCJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aztJNJL/D2fgvn4taM6gQUOjKEFNU1ctl0ziAjJxc65Y7BH/Um3Q0YO5sqddLvvNA6R1dZ44+8Li05KJrGy744mdlFZGN7h3eHEpXbk29Z7651UVnzYk1/lml9v4YGfK0Ckld0em0avAkOLit01yRyC091KNIGEFIPw1ph8UhqC47LBrNY2736O1bbmeKP+4OSfUhgwMdajxJrPFlGZW/IsQhrRPu4g9AXMf7kjiQaI3IiDYgOA7fyHh8iUfX/xmkRXpCIhsUde6mdUcZs6o1uA4Gq4PYob0p99TqoFlQ1Th4G8JLg6c0iF03ANRN7Ta0LZmmxq0Modab30W4jGuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMEY2ra3VmJNtDhGs/eKIOXbVsOomvkoqWKOLXOIapQ=;
 b=EjD1Wx7bU0RY0UAqHQbBEWCTm/zGBxJ/uQ29EYUZ/3DABSTSPVRhKOX5m6itD5B/p3lefEG+JvmTPlN5BsBeC5J+IEKViOFmkjgPJdKAZEC+JxT1En6deoGu6lsbiRMNjf9pNH57N+C2SaPfX1st14BpNn9A8YSWgsjJvZX49ciMyyGg4ge+yiAgPTqbsBHu8LYzEDqT79zJIwCVhKkC2TYYKuhFVO9zW2V1ezLfV+LK1ParXN5WbDxjjCt8Fu8V6w0P+hlgszUNoph49db+TPBEZNE9XUA3bx+4KTCnQtLKtzW+CNMOU1a+EQtJMuxyCq7KOUSe3tdFYM05RcW6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMEY2ra3VmJNtDhGs/eKIOXbVsOomvkoqWKOLXOIapQ=;
 b=ACXS2IXLrAqd3BYvstNzD54vVT0ICxUlWzP8ElP5WWU6TlZw75L/n01C2KCnK0b5QQ+IaXdYLynm2thfUY/hX+KOd/FwdnKtpz8b4gK8Xltg92Rx05V7hKsi3OfzPs1RJg6xgcUOPWKgY6f+7YJ0+EH8jfLMG8xXHkBfxXm3x7Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2856.eurprd04.prod.outlook.com (2603:10a6:4:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 09:40:03 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 09:40:03 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: scu: use devm_kasprintf
Date:   Wed,  3 Jun 2020 17:29:32 +0800
Message-Id: <1591176572-9693-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:4:54::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.25 via Frontend Transport; Wed, 3 Jun 2020 09:40:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 968e6474-ad19-4ef5-a439-08d807a21764
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB28560A4A78E4B58086F52AA488880@DB6PR0402MB2856.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12XAsF9tEZf4nQsGfd+jV9EykKeYnJw/fNUDp0drfiO+fW6ezIKiZawKl/VwD0pk87levIH8YiSYBqQxBiN4Tmj/KrxE96YXj6ItokC/72FXeZrVjnN3jjQazznsH+ci4UCSoNfp1ScPDCrM3S76JA2xrQZaz3hoOSqYe/Hzm+37TGtVB4JvdNAJnXczLDM7HM5NgM2OWtiDOCMf9M32axiMO68gIx34IK/hkdP4zlsUN8iAqL4KQ8p4Inu8beht9BTHbefaWxd5IJmD6RkWAySC4IuoreQgxaApSYVk03y48kVfOihsc/nQ0ACf2+ZxP4keuUs0xOJpS3iDI18DUU1b8F5atx7r/B3CZMscqaijM+s3NepA/SI3zgPWUs/6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(316002)(5660300002)(8936002)(69590400007)(86362001)(83380400001)(6506007)(36756003)(478600001)(52116002)(66556008)(66946007)(8676002)(4326008)(66476007)(6512007)(9686003)(2616005)(186003)(26005)(16526019)(2906002)(956004)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LCE4Jv334FGUoRWjfS4gtftsAfbXAfT4aDGgtmNEKOyyHIZzkryruNoMQoc5qB5bt/qF60v7fr2VYqVbI5uITKJFLrgGLx/m2Z7xY0CpMEUye8gfAXeC7TJp2IdtStAHoATq6CqXnDdTZamqyz65lJrwKwkKkPLyUQsOV0sdE3bQuW44KVH5xwTV9Yt6AZe4xuV3mNP6sKOJ2Y9KhiMHPTv6BF2rv6Fu47THrNYt1z5u6g8ITMftWmuR2g4jLhfOnOCQZ0nOkbRPUtBO5POQqrdizan0r4T928bkmxw3Ublj/FbyTHbKSEHb0yk+ekhJYOJ5HwgigKUcR/hkwU9q6ApaJE0V0DPjDI9ivduEt59AD7NYG36D281lI6vArnDUfHOutiuA9ocm0uJvTgVlDOhUqf1761XLs7KX8Ba7HpG3lgUn4fQZ00rW4MJqXrZOKmikMCCt/nMu78sRRm6nblD6YVsusEugVgT6ft2WGMv5LQoeb5c0QngpIKqJgtAO
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968e6474-ad19-4ef5-a439-08d807a21764
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 09:40:03.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccq5Biz/yie/NneAkByHNAEBsvDwUTyx+XnNBD6zbkD4f6Z5BoA5snLGyXhCl2qTnU0EFJBAjTMgDAWZPnSwrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use devm_kasprintf to simplify code

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/soc-imx-scu.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
index 20d37eaeb5f2..92448ca9a6f8 100644
--- a/drivers/soc/imx/soc-imx-scu.c
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -115,43 +115,28 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
 
 	/* format soc_id value passed from SCU firmware */
 	val = id & 0x1f;
-	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%x", val);
+	soc_dev_attr->soc_id = devm_kasprintf(&pdev->dev, GFP_KERNEL, "0x%x", val);
 	if (!soc_dev_attr->soc_id)
 		return -ENOMEM;
 
 	/* format revision value passed from SCU firmware */
 	val = (id >> 5) & 0xf;
 	val = (((val >> 2) + 1) << 4) | (val & 0x3);
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL,
-					   "%d.%d",
-					   (val >> 4) & 0xf,
-					   val & 0xf);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
-		goto free_soc_id;
-	}
+	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%d.%d",
+						(val >> 4) & 0xf, val & 0xf);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", uid);
-	if (!soc_dev_attr->serial_number) {
-		ret = -ENOMEM;
-		goto free_revision;
-	}
+	soc_dev_attr->serial_number = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						     "%016llX", uid);
+	if (!soc_dev_attr->serial_number)
+		return -ENOMEM;
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		ret = PTR_ERR(soc_dev);
-		goto free_serial_number;
-	}
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
 
 	return 0;
-
-free_serial_number:
-	kfree(soc_dev_attr->serial_number);
-free_revision:
-	kfree(soc_dev_attr->revision);
-free_soc_id:
-	kfree(soc_dev_attr->soc_id);
-	return ret;
 }
 
 static struct platform_driver imx_scu_soc_driver = {
-- 
2.16.4

