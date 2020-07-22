Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B374C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59733206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aMBLaj7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgGVHKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:10:02 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:49959
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728063AbgGVHJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:09:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSJ/BlPehGoAIMJjkGwCiv9Wq3PQ8jbVn8BRtD8wHIdzE3qPc4K+5GbGFCyUYcnWgn1lyfXuU88QmG847m0e6L4bFoqXkYoj7otcDsf+9KroeyyL/JDXzzWkliivjCYj48PeAV4TkhZbhkXaL4fR4kHZ+xLGKIGTObyOyf7ymDNlIdeYZh6xPNgrTnf4+huoxWQeay6DsOoTP7j6qJXs8lTGDdYw4ps0yPrhA5ivlyXn0sacvHvZgL8zZPVo/4PObVE8aJRrT7fIfPWabpogmMtdRhsygaFHrvW1AEdUzit/RYRoQMvaW4ICpZrSpbEWOR7m0pD+KU+ny48UgotBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmFdi2scGz1OVqTFGp8mqvD/8d5wjmTPuW7BfwhRvKM=;
 b=TLLeYRNoNCU798GiopG62WsElEZAg2ckY3tmxhWsBrfwpQR9IRDhkpKro9kOL2lHxerT0jM/ZHXsNMaIGomA3bIh2POmLF6cOIWbvv2dcwtzImnOErnJygddXOSPOjt3T2vFRqKu7FyTZLMsNGQuYwlXer11PyOlGrHZsA+qlup94wESt1gEh3TYSF94ANnmmK5BYN9N0olq+82D6039mk+xwhD/Ee3OEMANEQXUnlEOpflAE2v4YMVxoiFd41fKgT9tLFUZwVSkprZdm1yT5XaQ9j72vXU2so/Gvqk+Z2eTSsRjdiKyWyG6vZWr/2vEHxlJgmEspSKr8E9jtS9hdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=avnet.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmFdi2scGz1OVqTFGp8mqvD/8d5wjmTPuW7BfwhRvKM=;
 b=aMBLaj7ct0jYLuO43XgcRXyUWsaAPxWbC8Vx2LMZRjjzMSJPTIhZCEpkerQfriRydzaO/bC6IYg3iCF6fnZo2c8/mKX0LNavaHOxjP2g7qsPR1elh5xMq17QkYN/KI/oZ9voFdJdhD8bUFpp28v+OWDMwC6Vcl6v8tmlMZHGEr4=
Received: from CY4PR12CA0039.namprd12.prod.outlook.com (2603:10b6:903:129::25)
 by DM6PR02MB5913.namprd02.prod.outlook.com (2603:10b6:5:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 07:09:54 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:129:cafe::8a) by CY4PR12CA0039.outlook.office365.com
 (2603:10b6:903:129::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Wed, 22 Jul 2020 07:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; avnet.com; dkim=none (message not signed)
 header.d=none;avnet.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 07:09:53
 +0000
Received: from [149.199.38.66] (port=60679 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jy8rB-0002Jq-4f; Wed, 22 Jul 2020 00:08:01 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jy8sy-0001GB-G2; Wed, 22 Jul 2020 00:09:52 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M79pe8016849;
        Wed, 22 Jul 2020 00:09:51 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmis@xhdsaipava40.xilinx.com>)
        id 1jy8sw-0001Fr-OU; Wed, 22 Jul 2020 00:09:50 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14964)
        id 1D36413C0556; Wed, 22 Jul 2020 12:46:07 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH v2 2/2] reset: reset-zynqmp: Added support for Versal platform
Date:   Wed, 22 Jul 2020 12:46:05 +0530
Message-Id: <1595402165-8282-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595402165-8282-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1595402165-8282-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39860400002)(396003)(46966005)(2616005)(2906002)(26005)(81166007)(82310400002)(8676002)(8936002)(356005)(4326008)(47076004)(186003)(6266002)(336012)(107886003)(5660300002)(316002)(426003)(70586007)(82740400003)(6636002)(42186006)(70206006)(478600001)(83380400001)(110136005)(36756003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fcf61859-c539-42a7-96bc-08d82e0e3b7e
X-MS-TrafficTypeDiagnostic: DM6PR02MB5913:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR02MB5913DEAB569DBD116F0CA691BD790@DM6PR02MB5913.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2aDVX5/bv2JOUhocJCG4fWTiaC82uf1YZuHZxSAbxwsyZFbr1OcdvIdopt4tpBMKxMuXZic1fMOtCEF2T5K7SbKdqviR+rY00Pj4w/OiP3ot8997BXLPgQ4mTrWnYiN2zKxqbbR7ChEP+DJIAt5ySSUDFsEYJMTSSgcWot8Im45eb1Vz2afv/6Skfqu5yOdkgu/m6K3eq6Iy323FKezRz2RsMqPG0tBKWZkh+IjfABR7sVUSvAXk6F5wDQc8aEttX4P4THusoXxkXmhP7lbiL9GLQ3pWXHK6fF8VBmgEQ7EQyI0fQMbXiOCGZUQNLHiPJmONV6TvBl8X6N0sDmDvbgGvyRosipsEd0q59Q7Krtv7PAKTDnPas9culEHKw18+bVkEXuFbHAzVgDxywQ30A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:09:53.5366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf61859-c539-42a7-96bc-08d82e0e3b7e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the reset driver to support Versal platform.
As part of adding Versal support
- Added Versal specific compatible string.
- Reset Id and number of resets are different for Versal and ZynqMP,
hence taken care of these two based on compatible string.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/reset/reset-zynqmp.c | 50 +++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 373ea8d4f7a1..ebd433fa09dd 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -9,12 +9,20 @@
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/of_device.h>
 
 #define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)
 #define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
+#define VERSAL_NR_RESETS	95
+
+struct zynqmp_reset_soc_data {
+	u32 reset_id;
+	u32 num_resets;
+};
 
 struct zynqmp_reset_data {
 	struct reset_controller_dev rcdev;
+	const struct zynqmp_reset_soc_data *data;
 };
 
 static inline struct zynqmp_reset_data *
@@ -26,23 +34,28 @@ to_zynqmp_reset_data(struct reset_controller_dev *rcdev)
 static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return zynqmp_pm_reset_assert(priv->data->reset_id + id,
 				      PM_RESET_ACTION_ASSERT);
 }
 
 static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
-	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return zynqmp_pm_reset_assert(priv->data->reset_id + id,
 				      PM_RESET_ACTION_RELEASE);
 }
 
 static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
 	int val, err;
 
-	err = zynqmp_pm_reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	err = zynqmp_pm_reset_get_status(priv->data->reset_id + id, &val);
 	if (err)
 		return err;
 
@@ -52,10 +65,28 @@ static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
 static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
-	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return zynqmp_pm_reset_assert(priv->data->reset_id + id,
 				      PM_RESET_ACTION_PULSE);
 }
 
+static int zynqmp_reset_of_xlate(struct reset_controller_dev *rcdev,
+				 const struct of_phandle_args *reset_spec)
+{
+	return reset_spec->args[0];
+}
+
+static const struct zynqmp_reset_soc_data zynqmp_reset_data = {
+	.reset_id = ZYNQMP_RESET_ID,
+	.num_resets = ZYNQMP_NR_RESETS,
+};
+
+static const struct zynqmp_reset_soc_data versal_reset_data = {
+        .reset_id = 0,
+        .num_resets = VERSAL_NR_RESETS,
+};
+
 static const struct reset_control_ops zynqmp_reset_ops = {
 	.reset = zynqmp_reset_reset,
 	.assert = zynqmp_reset_assert,
@@ -71,18 +102,25 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->data = of_device_get_match_data(&pdev->dev);
+	if (!priv->data)
+		return -EINVAL;
+
 	platform_set_drvdata(pdev, priv);
 
 	priv->rcdev.ops = &zynqmp_reset_ops;
 	priv->rcdev.owner = THIS_MODULE;
 	priv->rcdev.of_node = pdev->dev.of_node;
-	priv->rcdev.nr_resets = ZYNQMP_NR_RESETS;
+	priv->rcdev.nr_resets = priv->data->num_resets;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.of_xlate = zynqmp_reset_of_xlate;
 
 	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
 }
 
 static const struct of_device_id zynqmp_reset_dt_ids[] = {
-	{ .compatible = "xlnx,zynqmp-reset", },
+	{ .compatible = "xlnx,zynqmp-reset", .data = &zynqmp_reset_data, },
+	{ .compatible = "xlnx,versal-reset", .data = &versal_reset_data, },
 	{ /* sentinel */ },
 };
 
-- 
2.17.1

