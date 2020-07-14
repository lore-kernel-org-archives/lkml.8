Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE13C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5201B221E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MwozJUyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGNGWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:22:53 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:9955
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbgGNGWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:22:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsRaI+jYsYWVBuAtx6Dg3Q6GMP+82x1IsMqhEQCW1sOcvPOk6B18SUiKvBxMcVFMSF5jWaqdGgULo1r2UTze47oNmxfhGQGVE4nmU3E6eRpH9fTjRv9+ySAX78RJkB4LSNn7hIw7sIYLCHvjqB0TLqZmgpIkbxr+tz7zPQC4Nynd/2T25gNFuLx7F3prMZ8efFZFJ4cWRsfy/oAcWCk65NLhzzbI2fBcVZIOxJ6CchBxYmLuoZOer3bbgX38uGDzcBWPS8KErwbFKq5wUWmomo9/FufR3+O1tWWzDpPK86s0OVcL+nKPyRJEZpcorge6a8TUC4cimbmzoeqscZ0F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQVpxY9/TFCjIlq2ZXDNOjZ121+4YVrQlaJhBZjfwls=;
 b=NWXQSYh66NjA7A9+TD0BN8Oa7TZyTKDH0SopS+tk+AeI7FqQrJv6VrQx4EyXMaxxtiSZQHBnomiZOrofFIry6YRxfwGSYVUjmZwVWdmdgq+vkBd+aewriEuMGbpkWPfId1Se9weQEma/QJcmnFgEmvqIAbD4NUjUYp5c1lWnkGa3rdlkJn2aV6r/tKNizAJR6iWxZjCVfNzVHB5UHS9ESLqUHaM2THRdm2fHko5PgxdYqLo9cDDkmgvaB5PPm0M8yULfqCxNeGnkGe8vUSOhCPMVsMNvfl4N9RAx0m0t1xr6q5Lo90McY5/b1rc2PCOZ246Ax+TUcMZgsYnxoCw4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=avnet.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQVpxY9/TFCjIlq2ZXDNOjZ121+4YVrQlaJhBZjfwls=;
 b=MwozJUytGZXoxztso/7XxyHtrXzpJWJYA1qiSYPJTYfsK9Eo3FyAgGjpfLsixSmaFn+5JLvJWAxKMJhvxU5MHiubFYD65et8ZZN+y/n5eOB3R08vKxmUnV+ee1ZW30Lv7+MHi8NPGeu9/J7aKiR9wD47NEqMqq7UA9weyVzGGME=
Received: from SN4PR0701CA0010.namprd07.prod.outlook.com
 (2603:10b6:803:28::20) by DM6PR02MB5306.namprd02.prod.outlook.com
 (2603:10b6:5:41::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 06:22:35 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::a3) by SN4PR0701CA0010.outlook.office365.com
 (2603:10b6:803:28::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Tue, 14 Jul 2020 06:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; avnet.com; dkim=none (message not signed)
 header.d=none;avnet.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 06:22:34
 +0000
Received: from [149.199.38.66] (port=48880 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jvEJB-00033w-J7; Mon, 13 Jul 2020 23:20:53 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jvEKn-00046D-Vz; Mon, 13 Jul 2020 23:22:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmis@xhdsaipava40.xilinx.com>)
        id 1jvEKn-000467-9O; Mon, 13 Jul 2020 23:22:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14964)
        id 6237213C05CF; Tue, 14 Jul 2020 11:59:11 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 2/2] reset: reset-zynqmp: Added support for Versal platform
Date:   Tue, 14 Jul 2020 11:59:09 +0530
Message-Id: <1594708149-29944-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(396003)(136003)(346002)(46966005)(81166007)(110136005)(82310400002)(2616005)(356005)(336012)(426003)(186003)(70586007)(26005)(83380400001)(70206006)(47076004)(8676002)(6266002)(107886003)(36756003)(82740400003)(316002)(42186006)(6636002)(2906002)(478600001)(8936002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: baa13902-8122-4216-6e4f-08d827be4c3a
X-MS-TrafficTypeDiagnostic: DM6PR02MB5306:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR02MB53063F3E21DF1B63FB51E106BD610@DM6PR02MB5306.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIp/ytC/rIKSF1LQlx2U9eWVrcE2nKgJwvBveTYXG3vczxjwkMMbtFFSH9CywbnzKebx4UEg8InCbn4b/5gYHNW9L9+pf/Cm33k6imTNzHeDUpAPZbWgLbZ6ryZA5F1zbj9UIusGHfcwSOej4A4Qz3L6/c5oO8GASI0jmZ0lKJTitqYkMIfsRH6pm89jX6851Ko3ZUwp2pHEw1YC9rvSz779qPlbuhB2SPiG6z/iJySgzebtV9L1kDmoWwHnpKqfF7iF3MJv6huReBhlMUWqE7OVDavdmGESZSx5B0KDH8oCQOdJsLGqpf3EP/PHYEKOoK2rzggbgDUn5lJQoIfAYx/O0CBYjF+i8b7pxFJudcNRo2BBHe0FdgXWQHJGJlbYYfDs8RLdqlCgUrAcu1P6lA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 06:22:34.8982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa13902-8122-4216-6e4f-08d827be4c3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5306
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
 drivers/reset/reset-zynqmp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 373ea8d4f7a1..17aa4532ec5e 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -12,9 +12,11 @@
 
 #define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)
 #define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
+#define VERSAL_NR_RESETS	95
 
 struct zynqmp_reset_data {
 	struct reset_controller_dev rcdev;
+	u32 reset_id;
 };
 
 static inline struct zynqmp_reset_data *
@@ -26,23 +28,28 @@ to_zynqmp_reset_data(struct reset_controller_dev *rcdev)
 static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return zynqmp_pm_reset_assert(priv->reset_id + id,
 				      PM_RESET_ACTION_ASSERT);
 }
 
 static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
-	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return zynqmp_pm_reset_assert(priv->reset_id + id,
 				      PM_RESET_ACTION_RELEASE);
 }
 
 static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
 	int val, err;
 
-	err = zynqmp_pm_reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	err = zynqmp_pm_reset_get_status(priv->reset_id + id, &val);
 	if (err)
 		return err;
 
@@ -52,7 +59,9 @@ static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
 static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
-	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return zynqmp_pm_reset_assert(priv->reset_id + id,
 				      PM_RESET_ACTION_PULSE);
 }
 
@@ -76,13 +85,20 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
 	priv->rcdev.ops = &zynqmp_reset_ops;
 	priv->rcdev.owner = THIS_MODULE;
 	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->reset_id = ZYNQMP_RESET_ID;
 	priv->rcdev.nr_resets = ZYNQMP_NR_RESETS;
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,versal-reset")) {
+		priv->reset_id = 0;
+		priv->rcdev.nr_resets = VERSAL_NR_RESETS;
+	}
 
 	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
 }
 
 static const struct of_device_id zynqmp_reset_dt_ids[] = {
 	{ .compatible = "xlnx,zynqmp-reset", },
+	{ .compatible = "xlnx,versal-reset", },
 	{ /* sentinel */ },
 };
 
-- 
2.17.1

