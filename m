Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF36BC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E27920717
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cCx+uenh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgCFXsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:48:14 -0500
Received: from mail-eopbgr680071.outbound.protection.outlook.com ([40.107.68.71]:29786
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727263AbgCFXsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IswnCnn+AQK82d1g7C4UxeurfYbLZiDEaJmIgKChlnxUFBczn49LUB4XYWTGDZhxi2Eh9izhW9xe+Omld6q2fuyblXWxkGheIuKI8RGCjU2Zf38dZlFySiL+cHZ5/8k2fIIyWlW1OICRamSRyjdsDswcL2X/FAdlMgU2Ht2J9lLRKcIC92GGWK+sHDYBp1YPj+v52q/QAk3ry+sndcP3go4oXB52Zu3uCFUyRWPc58gX0rJziU9/f9+IZWhGxVqt/xSNzwmuRHrwZd4oxHqgbx2BCkfpMMuN9gXX1Il/BK8SDdhjJTfLhuetYEYKmaFnM1llyaAT+MnyXPAA5rOGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7/77s3eD14O5PIofcgKUXo1YvIOKplIw+paqyHGlGQ=;
 b=Efc6zV4ZjCUHK2kle4BFCddS8Weg3qxw1u6xmS4uO1cfs6o6oxxNUNZb8RXMr7LLKHyP1cXRtaGFNQ1s92uVEMGh58rY9npHRZdlGvphFK9yMC8kpfsIQq3Atk+TZ2hJth9kGd0IYphPtqyjeg2w9iCJYbmsk5ZvPFNE+7MD40xOzWHFYt/+L8vW6QExCbzEMFWMvPqloTIYxyncE+zZkidtZZ3U+HTBCuwf6ZJ4NOPMWE0wOd5/AS3n0x48Kh/j0ScLWooWA+i+CjnGpMwdM4eMXaM6NnWqVRzC7zuZh1IFOVM9ih+Jnedlp81+zKYo+WX0HCelr5UXuYqBG4V2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7/77s3eD14O5PIofcgKUXo1YvIOKplIw+paqyHGlGQ=;
 b=cCx+uenh2qFrRuOI5oMmFK1cOTuJekLczf3uqpq61b2E3g1CQLVfzHvNhkvw3jgjng8gUvQpdifBmXU8wHoA6nVPjJWt9EWRdREUfLCwq7nfX1k6YvBFo/+2p43FnQwdV20D5ju/41FRZWzt+QY0O/9aOTbjQelOaEI7e2o01So=
Received: from MN2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:208:120::21)
 by SN4PR0201MB3421.namprd02.prod.outlook.com (2603:10b6:803:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 6 Mar
 2020 23:47:59 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::fa) by MN2PR10CA0008.outlook.office365.com
 (2603:10b6:208:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhC-0003QL-S4; Fri, 06 Mar 2020 15:47:58 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh7-0002g8-Ou; Fri, 06 Mar 2020 15:47:53 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026Nljcj002387;
        Fri, 6 Mar 2020 15:47:45 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMgz-0002eg-MD; Fri, 06 Mar 2020 15:47:45 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 01/24] firmware: xilinx: Remove eemi ops for get_api_version
Date:   Fri,  6 Mar 2020 15:47:09 -0800
Message-Id: <1583538452-1992-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(36756003)(7696005)(9786002)(6636002)(426003)(26005)(2616005)(336012)(70586007)(70206006)(54906003)(316002)(186003)(44832011)(81166006)(478600001)(8676002)(356004)(107886003)(8936002)(81156014)(4326008)(2906002)(6666004)(5660300002)(7416002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3421;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43198ba5-7845-44fb-62f5-08d7c228cd68
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3421:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3421875D04904143C597A3FAB8E30@SN4PR0201MB3421.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Mahzi8+In/k1KK8nGkNT0QbiJKjqfbwIz1GpnfwpfzMgwI31TEj9wpndsOzalQsB47DqS231Q1augKnW4LubvXm0bXtaI9eBAg2/Cb3bWsJ44veb3fwp7KrwrcPgZdrPGOMxqb4pp02/5wSXWrDYV4leQMW1IqUffT8+pX54F5b85BBZECqTcRDh2eFSC4HcMTBjU6Asg9MyVUZsbC5Wmjtnj6vTGlhCBw5BHlZiK4c9FPyaRFNTr7W9r88lrH8e6URp7orKpfWIdVLjsk/FHRt5C8FUW6mVurpQ3WjFiTBN6KlN3UvwLVPsqp88UaI1QDOuZWlS96wf9CSCteotZGsrhVtvPJk4loPTAH6So1JkOcNAQhifRjZAvOZ/TfkYfqwYT2We6OlkBQ8EqALLn6iCmDq2ksVN3elvjzIOMKDEALfibnNqRILnUaTaDynDvEUFpclowu/eUCyc90b54cH2Cr7DZzQES/FScXEBBUkZlWCXzXm6avlZQrFYtp0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:59.4467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43198ba5-7845-44fb-62f5-08d7c228cd68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function calls instead of using eemi ops. So remove
eemi ops for get_api_version and use direct function call.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 2 +-
 drivers/firmware/xilinx/zynqmp.c       | 4 ++--
 drivers/soc/xilinx/zynqmp_power.c      | 4 ++--
 include/linux/firmware/xlnx-zynqmp.h   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index c6d0724..de4faf2 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -92,7 +92,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 
 	switch (pm_id) {
 	case PM_GET_API_VERSION:
-		ret = eemi_ops->get_api_version(&pm_api_version);
+		ret = zynqmp_pm_get_api_version(&pm_api_version);
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ecc339d..f7725d1 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -219,7 +219,7 @@ static u32 pm_tz_version;
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_get_api_version(u32 *version)
+int zynqmp_pm_get_api_version(u32 *version)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
@@ -237,6 +237,7 @@ static int zynqmp_pm_get_api_version(u32 *version)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_api_version);
 
 /**
  * zynqmp_pm_get_chipid - Get silicon ID registers
@@ -708,7 +709,6 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.get_api_version = zynqmp_pm_get_api_version,
 	.get_chipid = zynqmp_pm_get_chipid,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 0922789..d327d9e 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -186,11 +186,11 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	if (IS_ERR(eemi_ops))
 		return PTR_ERR(eemi_ops);
 
-	if (!eemi_ops->get_api_version || !eemi_ops->init_finalize)
+	if (!eemi_ops->init_finalize)
 		return -ENXIO;
 
 	eemi_ops->init_finalize();
-	eemi_ops->get_api_version(&pm_api_version);
+	zynqmp_pm_get_api_version(&pm_api_version);
 
 	/* Check PM API version number */
 	if (pm_api_version < ZYNQMP_PM_VERSION)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2cd12eb..7529383 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -286,7 +286,6 @@ struct zynqmp_pm_query_data {
 };
 
 struct zynqmp_eemi_ops {
-	int (*get_api_version)(u32 *version);
 	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
@@ -317,6 +316,7 @@ struct zynqmp_eemi_ops {
 			       const enum zynqmp_pm_request_ack ack);
 };
 
+int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.7.4

