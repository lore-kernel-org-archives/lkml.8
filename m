Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5847AC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF01206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Cmu5iigQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgDITNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:13:36 -0400
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:6035
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgDITMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqgdtsOb/wrfibTbBMFjg+hhlT4XX+P0ub00Wddujei+ZO7hDFfY0n0IQVebGqqoTtkMztoDypA4zAkJIAAccEBxzQoG8KCs3hvy5RQtYA/cC7eweQO8lONI6G+ctV5eNMDkNMxbkLNYzr06zydaN/MU+mDc9lnyLI+eTDuQtENzxeZPs7UZ1epyEjs4YslAq6+76t/s1yLCfmqM6rWFOE1eai/UOCMJetIjlr4RYv7D+ABlgqVkmpo/ikzJpipnnmsTL4Tr7gXF0NEE8r1F/0RfJd1LjdHf39Tw4mvZlRHLuKQV2GGGey0OMj8TkelnJXZA/tpC4UaFhOJr6Li41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An6sxhm+TBGl8GeXDnw/WHSzdO8zQFMnivsWUDsRNj8=;
 b=Q/cPDqDSAtjV0t+TqN3RFvKqtMYBYTWcINBMhZTJfRnvyc2sese1fwY/e7aUN8aH2XiUQ4tBY1T59d02lie7wwjKPy1NufVOYcTY+sqmpoYAICT5aqrRTVkSWE+XagOV++9S+VAI/6E3B81bAP+oIyHyKgmxFfJvWPMRoWwejhIqhepoQaKYuWVOv0UnVjVIJaTGfVkMuR3QMb0u7b1/VUR7lYUglZyNb+rdbUKimCVePGywhVL8Q7etTb4HlvY9YnFuJGRsjF5jABh1/Th6PWIfGQnYu2TDlGrTllsNLXwGsSd/RpUXFawMEM3fWr4RsmldMIJU1pcl591cBMMaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An6sxhm+TBGl8GeXDnw/WHSzdO8zQFMnivsWUDsRNj8=;
 b=Cmu5iigQjpCMZl0yKoB4xq6b09YWvwQhnu/I/dv1v2L6YgUG6wcikOMXN53g6H4lMrat4yETpMh2MO0vxj6Kcpos2+cnRvCDCBwHMtM7hE/x/qbJsfre5XqTwT4vA9Jb+OWLJ+PV4UInHjNzb6IPHf0KMjGc/huKSnWcyN7ECq4=
Received: from BL0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:91::38)
 by MWHPR02MB2669.namprd02.prod.outlook.com (2603:10b6:300:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 19:12:51 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::96) by BL0PR05CA0028.outlook.office365.com
 (2603:10b6:208:91::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.14 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44362 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbA-00060l-3J; Thu, 09 Apr 2020 12:12:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcba-0007NV-I3; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-MR; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 16/25] firmware: xilinx: Remove eemi ops for request_node
Date:   Thu,  9 Apr 2020 12:12:05 -0700
Message-Id: <1586459534-8997-17-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(36756003)(2906002)(9786002)(8676002)(4326008)(6666004)(107886003)(7696005)(81156014)(82740400003)(44832011)(356004)(47076004)(26005)(7416002)(186003)(2616005)(70586007)(8936002)(336012)(6636002)(426003)(81166007)(316002)(54906003)(5660300002)(70206006)(478600001);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b83c6c-7761-47d4-4c90-08d7dcb9ff85
X-MS-TrafficTypeDiagnostic: MWHPR02MB2669:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2669659B7A85FEF9013DF93CB8C10@MWHPR02MB2669.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Y5h0J01QS3ya+Er5axFLv/CmPn8+YYUxlrLS4avxBBE2Nr3R+MpI3dVzHfOIDd3zcNK+qQ51bGJcslUPWFMTTnJw73DPHTZ7trfkffdYVQ7z3ClEG/o/j3ZOLrJeFVjmiW9ZnGa/8ruMgvXsbhdyY+jYj6OQRKZO9dfprrjew581VpUxq6JKPRRLqQDmsSXenbtWlyhQPf3I7Al8+mCjwX72F+vuIPLTQnN1DCIqLdEdKUO+OC2OiH7FPNueVepObh0ydtnEF3t+CxVOXr+IAUsXf9CxxZOfUF3LQqOoK7Ad+ApsCgUTrReYWlcVJovr794e+0yhy+Oqobnyj1uhXE+MYpBKEdsPBBE/wcA3tNDe1LGGnQdXn2cwdJCfXTOa+PrMxSVF0Sd8sTqAgAzqh+v+VykRagZ25Crxr9D+NmnH3VMiCo8b0ZQRNelIkZRqMiTSVC+0TkcAq/MMXXVOP4OqAD5gNYoar4QGawlgZBqL0pSStURxdavtEUVNjC+6LUkclQPnpCg1KecRLWyeg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.9976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b83c6c-7761-47d4-4c90-08d7dcb9ff85
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2669
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of using eemi ops for request_node.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c       |  7 +++----
 drivers/soc/xilinx/zynqmp_pm_domains.c |  5 +----
 include/linux/firmware/xlnx-zynqmp.h   | 12 ++++++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index cc74165..e65ee76 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -742,13 +742,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
-				  const u32 qos,
-				  const enum zynqmp_pm_request_ack ack)
+int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+			   const u32 qos, const enum zynqmp_pm_request_ack ack)
 {
 	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
 				   qos, ack, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
 
 /**
  * zynqmp_pm_release_node() - Release a node
@@ -810,7 +810,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
 	.set_requirement = zynqmp_pm_set_requirement,
 	.fpga_load = zynqmp_pm_fpga_load,
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index 23d90cb..cf4eed0 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -163,16 +163,13 @@ static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
 	int ret;
 	struct zynqmp_pm_domain *pd;
 
-	if (!eemi_ops->request_node)
-		return -ENXIO;
-
 	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
 
 	/* If this is not the first device to attach there is nothing to do */
 	if (domain->device_count)
 		return 0;
 
-	ret = eemi_ops->request_node(pd->node_id, 0, 0,
+	ret = zynqmp_pm_request_node(pd->node_id, 0, 0,
 				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
 	/* If requesting a node fails print and return the error */
 	if (ret) {
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 761caed..fb7e5c9 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,10 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*request_node)(const u32 node,
-			    const u32 capabilities,
-			    const u32 qos,
-			    const enum zynqmp_pm_request_ack ack);
 	int (*release_node)(const u32 node);
 	int (*set_requirement)(const u32 node,
 			       const u32 capabilities,
@@ -336,6 +332,8 @@ int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
 int zynqmp_pm_init_finalize(void);
 int zynqmp_pm_set_suspend_mode(u32 mode);
+int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+			   const u32 qos, const enum zynqmp_pm_request_ack ack);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -432,6 +430,12 @@ static inline int zynqmp_pm_set_suspend_mode(u32 mode)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+					 const u32 qos,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

