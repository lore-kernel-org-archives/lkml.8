Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496AAC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207782166E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dNSJebt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgDXU6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:58:46 -0400
Received: from mail-eopbgr690066.outbound.protection.outlook.com ([40.107.69.66]:51363
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgDXU6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjaJWtTMWIiy8XatBjCPsib4ysZ1d8S89CzzQY+ktU8mg+y/n/BLc6fiXaHZGBDSoU5nBXs9y/iBmesQICFhc3x4MnsOCyl8YOOTpz91YzHb8qyKaHWU7KigYviUPigipHuONgd8y1uypLYnPebHZFtc1LRgT7OXmH08AER6XqgetmRrcU59EBJXvuRgSV140MUK6Sm5NWvbSeQLaDGY4RRyA9dtUWbyYi8a5H28WtRUU7P+BSoz/kAlBXZZd9uKviRhL1tkEI0o/WQwdJ8oAASnCbkbAc6Yj7/2H62G41Sy91sFvzJ1APVOEiAWaL5SZdGybmv/pYEpuVdL+enmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T32OOAPHxyyBNEPv25Ih83UMrYS5F6JrbYgIF8E0JTg=;
 b=Rgf9cQmlI0KaOQ31RPgyVHuoWkhHbq+MZHUXTOU9bw3bcPoAWcdYNdhHnY+ks61WWBm0QhjP9i4iq2FdwHEakQSsL80nJ6YZnROdja7ErTU4VaSFJFlA9oImwTCtuahO0xk02t0to5ng70eLK63mVupyoWbCLg0Dt+9MU5HGz14JNs8PcJjTwcFGqScmczjhxGV+e1CoRTdAsLMpk8d9bRv0RkyAAPw8jAtZQjrKbm2u97qRAScxp2O75QgD3gWmlx8CLytramrdt/TGJec2ALSl5MO/ZRm9EYNvBA0+R3pY4CKfpyXPauBngNUHsAuFWIEwhxay4LhCnXJsI+9yRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T32OOAPHxyyBNEPv25Ih83UMrYS5F6JrbYgIF8E0JTg=;
 b=dNSJebt6LZgp/s4KAJhr3eCKapwV9g/w2ukFw/qomKisMLHYFg9bq9KBvfGjBvvMVvxkdb75TUQiDp1q+vdSVfyd4nDGMtDPhoFJQDBqsgp6sHExBvH3by0+BGH+cf0+HcQGhcyEqMAfDVxueu/dxr3vKFlDzsrtZsyzJFGTsI0=
Received: from SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) by BY5PR02MB6930.namprd02.prod.outlook.com
 (2603:10b6:a03:23e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 20:58:32 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::c7) by SN4PR0401CA0007.outlook.office365.com
 (2603:10b6:803:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 20:58:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:32
 +0000
Received: from [149.199.38.66] (port=33389 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Nx-0002DN-10; Fri, 24 Apr 2020 13:57:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5P6-0007Pe-0M; Fri, 24 Apr 2020 13:58:32 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwJYn030391;
        Fri, 24 Apr 2020 13:58:19 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ot-0007Lo-H8; Fri, 24 Apr 2020 13:58:19 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 14/25] firmware: xilinx: Remove eemi ops for init_finalize
Date:   Fri, 24 Apr 2020 13:57:56 -0700
Message-Id: <1587761887-4279-15-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
References: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(316002)(54906003)(82740400003)(70206006)(82310400002)(6636002)(81156014)(7416002)(6666004)(70586007)(186003)(356005)(81166007)(47076004)(478600001)(5660300002)(8936002)(336012)(2906002)(26005)(426003)(2616005)(44832011)(7696005)(8676002)(4326008)(36756003)(9786002)(107886003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d1fd838-ba6e-4dfa-5fcf-08d7e8923f70
X-MS-TrafficTypeDiagnostic: BY5PR02MB6930:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6930BE4A6040200F6B41A5CAB8D00@BY5PR02MB6930.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thAVleiVuH+UCkmoO3WxP3AQwvsjfUuABYFmWCL2DXm9aaoHsAeW6v3/XsaVQ0QEfpYw7i5VOGX2YM0Wci9yN5NYSzumrDMosBrGKSUF2S6os0HtyUM5lQa+EtcYlK1KDhNCPdVbZO8oGasf4FL5p4jUB6gWhRo2KcBP2rJmXYMaMgB4pdJm4k+wyLYN7vJD7NUaOpUVbf3FjYWEnLduoLsSmgCHtjkVraD2j8afTrH2oonGD8OBTpdrVS3BBemes41M4ZlUKlxQ8pk92453Q5iRbRvDHpRHJg3nGIgRaDnPq+rjx59vYcGk+rGXaJbTjlWG/3NhloU4WWUwpMW7GFyHaoWCg9+H3r8WUQRZK+IQn63gfVWv2rRTKBY9Za7I8kod2ZX/+r0znXpXPHYX3Sa8VxQ3MgdNSncPwr0mJGyT+NFTiwlW8AGE74TBE3njfLg91tw3iBVUWxCbpJxPZ4iqceyPs3+RkI7Oxp+yvmlFKcVtqUWbrMeXDrousYoBEgZ5tNmL6sSGSdFTHkJKOw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:32.3263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1fd838-ba6e-4dfa-5fcf-08d7e8923f70
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of eemi ops for init_finalize.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 drivers/soc/xilinx/zynqmp_power.c    | 9 +--------
 include/linux/firmware/xlnx-zynqmp.h | 6 +++++-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 4380853..869366f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -710,10 +710,11 @@ static int zynqmp_pm_fpga_get_status(u32 *value)
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_init_finalize(void)
+int zynqmp_pm_init_finalize(void)
 {
 	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
 
 /**
  * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
@@ -808,7 +809,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.init_finalize = zynqmp_pm_init_finalize,
 	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index d327d9e..f4a9371 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -182,14 +182,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	u32 pm_api_version;
 	struct mbox_client *client;
 
-	eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (IS_ERR(eemi_ops))
-		return PTR_ERR(eemi_ops);
-
-	if (!eemi_ops->init_finalize)
-		return -ENXIO;
-
-	eemi_ops->init_finalize();
+	zynqmp_pm_init_finalize();
 	zynqmp_pm_get_api_version(&pm_api_version);
 
 	/* Check PM API version number */
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 200f9e0..9aa5fe8 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*init_finalize)(void);
 	int (*set_suspend_mode)(u32 mode);
 	int (*request_node)(const u32 node,
 			    const u32 capabilities,
@@ -336,6 +335,7 @@ int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
 int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag);
 int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
+int zynqmp_pm_init_finalize(void);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -424,6 +424,10 @@ static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_init_finalize(void)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

