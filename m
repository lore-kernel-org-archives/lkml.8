Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17669C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADDB2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WDyMDzkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgDITOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:14:08 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:2848
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbgDITMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpU2Uoq1Jr8C2j2yU7+/1QxRLxh0Rr+LOTWtEIe+Cu0xBkhG2Ezm+af56yRdUCkECEHUCYNESl5Z+/5RuQOnrDp4mUaXlshOGhCdxv/pUTisTLu6qqiDYjLrguUIpRK3hukrWQOTZhreg8rQU05lHF99Ab9HJyoDkmFsBS+crQofrFDOD36iI6pVHaznV2pFN1EjnFlYaRjWRPOYZjtBx48aDz1lzC+ZwsMK4o/y9AwAH2B8acyJq4LN0D8mX3+5Ml0+Q+aon9lP4erotmajTq9IuuvejtriwpReK6ZZxjU67AYJr1NBpsMjtnR1twks/Gk0R1xAM4zQr0eREFmcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXDpwfmUqNZ3tgxJZ1ZwTJgsq8EuORoJLksCgzjN2JA=;
 b=Mov4osWoUU9r44ufq1cI/IwYhfTxgI1Um4uBNUHz7PBB4267G6gVbCHbtx5/jNPeuCO17T3bTDO21xU7JWNGzcHYv2r1jf1SBQ/QOq71cBF5tCag/S9n0ydMqZExqpPGFovxKqGmKFcI5Oz0cLY5HVnwONY3PnwlqJHtQzZmIRJpFVBT+g+r9/8i3pyIupUZFxHn3YMIaO168o54RIzXAXkcYB6Rml6tAhsmVAsCHXsRtVpeYRzSfIz2iEzdIKUCyrtJJglxaDXK23sh0staYUOIBQEXKdyaPdZFdRca2PDGAKxx+Kw9V3qE1Y4dAdoDjUiQV18HrjCYs/RGTLRqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXDpwfmUqNZ3tgxJZ1ZwTJgsq8EuORoJLksCgzjN2JA=;
 b=WDyMDzkfAtc1qqJM980YlXu+IiUbjUx3rkXDW2Qzx8AJ003xNo36iUhKqesfI+tumzX5OIG2fshfZHS2S6P1js2y/uVXtHjVxnM4vnryu6+aOMMyx+Q/ijI1I/+eetcvMgxvLTJTaRcZXFr2WE0EnWHFmf7ZUtspbj177gd5kLs=
Received: from MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45)
 by DM5PR02MB2602.namprd02.prod.outlook.com (2603:10b6:3:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 19:12:51 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:19b:cafe::7a) by MN2PR19CA0068.outlook.office365.com
 (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:51
 +0000
Received: from [149.199.38.66] (port=44379 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbA-00060s-Am; Thu, 09 Apr 2020 12:12:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcba-0007NV-PV; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-GO; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 13/25] firmware: xilinx: Remove eemi ops for reset_get_status
Date:   Thu,  9 Apr 2020 12:12:02 -0700
Message-Id: <1586459534-8997-14-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(70206006)(8936002)(6636002)(426003)(26005)(4326008)(70586007)(5660300002)(47076004)(336012)(36756003)(2616005)(7416002)(82740400003)(7696005)(81166007)(81156014)(478600001)(356004)(6666004)(107886003)(9786002)(316002)(54906003)(186003)(8676002)(44832011)(2906002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a21636-b690-49e5-0221-08d7dcb9ffa6
X-MS-TrafficTypeDiagnostic: DM5PR02MB2602:
X-Microsoft-Antispam-PRVS: <DM5PR02MB26027357E8FD69946D71199AB8C10@DM5PR02MB2602.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiRGQrq6q/itbmjLG4pbf5enHjeX2tm9V0k5yxSbLixROXaLQ5Dj49BsOCExAGYat7BHMmqSo8GqM6x75WrHTqo2rGZwXY4Sawu17iIlimxV4OKvblC9cBoW2k4tQgB0QZeVl0L1Ce1+lmn7lQaQ9WBYN/ojb47eBww/03Y29oC169A0Dq2rvSAaRJs3iILTLLUbGZv9dm5pbjnozZP5bU4tHAEOF/tAZjeOqT2CgAuc6j5+mt7vEVsNSc9W99yTnzDDxRkjfVA166hlpSkyd86Q3rHUl7zoKeknAQG6QbK4MGB97zEydgS5KEY8usvzSGiCChpdsx86TK6Gt044KkscjwEzqqWWjiNxR9JYZWB4lOWwEd3fXZdDvNMVdw/fRoLpIely8I4ufJWrKZeX3PnxUWyNvmAKmWajZmcIAxhfHUE7B9uGRC+jHuPxvG65Gd00zTNwogAx2+MFRqM0rDv7MYyL+Uqyde+/deMTU7/yj4Lz2VQKQLgBlAIWzovL7P020NUwB3PfNvKZB7j3dg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:51.2184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a21636-b690-49e5-0221-08d7dcb9ffa6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of using eemi ops for
reset_get_status.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 5 ++---
 drivers/reset/reset-zynqmp.c         | 8 +-------
 include/linux/firmware/xlnx-zynqmp.h | 7 ++++++-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 2a79091..4380853 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -642,8 +642,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
-				      u32 *status)
+int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
@@ -657,6 +656,7 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_reset_get_status);
 
 /**
  * zynqmp_pm_fpga_load - Perform the fpga load
@@ -808,7 +808,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.reset_get_status = zynqmp_pm_reset_get_status,
 	.init_finalize = zynqmp_pm_init_finalize,
 	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 	.request_node = zynqmp_pm_request_node,
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 4a01b7e..373ea8d4 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -15,7 +15,6 @@
 
 struct zynqmp_reset_data {
 	struct reset_controller_dev rcdev;
-	const struct zynqmp_eemi_ops *eemi_ops;
 };
 
 static inline struct zynqmp_reset_data *
@@ -41,10 +40,9 @@ static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
 static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
 	int val, err;
 
-	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	err = zynqmp_pm_reset_get_status(ZYNQMP_RESET_ID + id, &val);
 	if (err)
 		return err;
 
@@ -73,10 +71,6 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (IS_ERR(priv->eemi_ops))
-		return PTR_ERR(priv->eemi_ops);
-
 	platform_set_drvdata(pdev, priv);
 
 	priv->rcdev.ops = &zynqmp_reset_ops;
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 22b2bbe..200f9e0 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 	int (*init_finalize)(void);
 	int (*set_suspend_mode)(u32 mode);
 	int (*request_node)(const u32 node,
@@ -336,6 +335,7 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
 int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag);
+int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -419,6 +419,11 @@ static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+					     u32 *status)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

