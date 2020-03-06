Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C99206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hfruAj8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCFXtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:03 -0500
Received: from mail-eopbgr760051.outbound.protection.outlook.com ([40.107.76.51]:41444
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbgCFXsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWwS9UWntt+KOrCVGs71H/ONEFV5AfE184MQEhD7E435+ng8F9Wmvx2kjj36zOGtLhEURENc7QJ9mG8F5GMIWNST6ASwu01yfu3TAo2yCABSC+4O8qcSlTEFnDMXAl1sVUuOTKpQoNpBBYG8YhAD9EzyYF6OJKRcy2+lsxAFPTM249KGMWCFNLYGI1DkiDHW6B0EOyy8jQXL0fl1eyfmuJG17h9bJTMnSGYY0b5n/NLE6V984hrzllfwJGgcgoe0ePI8Z9TPHfN5ksAwpcBKuZ20k/lOrva7Z7HgOF1t37d3PRSTU+3OY5pJVah207GLYrTWVFL9NOb5L/B0wPs5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8twyJT56fHZYPnV/HZTKsbxZxVM3icH2+aOeiifo1Y=;
 b=LuD0+n5GobIex7NR8zYAjh6Ad66Uzsa8hjP5Fljkhg5vDhX6rKAQvzIrtPna/M05UG9476VUeUWevythMHje/TaSHA803O9PYxESYRGT8/R7at2EURW8nvcc+wluB+8UfdmB4bNNWLh+UUoYahRflarkmUUwNtFEO1Ryz5+p/6qqv9nHfhAmjl9DFCCdfCgZJfuMivOg5bpvxiNxPfGsyndgiYk8gWo/b7qUWOZWLJw3B4LKbtv/OkqZtTNWt4PgzHnYgV1ze6SbvnWC9deh1YG4M8XN60LcobS2+sO1lWMyCgbb/IPWjpsEGQ7rqbTUjrayaDu1WywIj8JRYv0QUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8twyJT56fHZYPnV/HZTKsbxZxVM3icH2+aOeiifo1Y=;
 b=hfruAj8HdNbyPAPPH9afIAP/uQRgdObD8M7iChMkAiEDaI9ujmaub3giClXq+ngPbQhIQ6UNUAnPOV3AdHtIOjsYx2OGghHsGCNo/n1d9mCiQfrLvUp4MtbbHK3r9dm4z1AP1nx+krOCHS2ujCcIFw6sj8fAfS2QOEcCd+IKa2s=
Received: from MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) by
 BN7PR02MB4129.namprd02.prod.outlook.com (2603:10b6:406:f2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Fri, 6 Mar 2020 23:47:59 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23f:cafe::ff) by MN2PR01CA0052.outlook.office365.com
 (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhC-0003QI-Iz; Fri, 06 Mar 2020 15:47:58 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh7-0002g8-Fx; Fri, 06 Mar 2020 15:47:53 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026NlkHk001013;
        Fri, 6 Mar 2020 15:47:46 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh0-0002eg-Hr; Fri, 06 Mar 2020 15:47:46 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 16/24] firmware: xilinx: Remove eemi ops for request_node
Date:   Fri,  6 Mar 2020 15:47:24 -0800
Message-Id: <1583538452-1992-17-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(199004)(189003)(107886003)(70206006)(2906002)(478600001)(426003)(54906003)(2616005)(8936002)(70586007)(6636002)(9786002)(7696005)(336012)(81166006)(4326008)(6666004)(7416002)(81156014)(5660300002)(8676002)(316002)(36756003)(356004)(26005)(44832011)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4129;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cac05b29-2860-4f56-0d52-08d7c228cd40
X-MS-TrafficTypeDiagnostic: BN7PR02MB4129:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4129D9CFFF0856F03AB9A041B8E30@BN7PR02MB4129.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyV96Z4JkpRreudfNquM2Rj7AsHsmaO8P1uek+0ZBkRepzEnc1omxIOFC4t0rNHIzOqw5Kw9fnQd5CJsTkpbZSQnlUwh0Y2CV+rkjIpFxZUQ1BuHi9ECYo1vz6Mqc3H52h1Pcx96JC7sIr4qIEUVxD2GhBUeJko+yuve5YTSSYo1/Ycuuo+nRbPCeYxADPcwOTd3iZpHI2iie8twf0wTEZDuyrmNs6jS+cZ1R14VAjfcFU3bPE2C7aoVf4l49SgfOYio0vNPbaKXlnyDi9pW2O9p4H19mJFkT8lQxJoO3QT1j2ZhWZa8EFbWYsdJsRkVIGu4XUaks56qXKC86lQtROs6FuHIrf1bfZZrUi3w/otiw6XwEGGcR3b1kzeKrAqc4/dMceVxX4kr4j+bkwx/xnKdq7DZjY8ybHjXzH9/QhncU7ZppCow1djCu9ISAq8h
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:59.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac05b29-2860-4f56-0d52-08d7c228cd40
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of using eemi ops for request_node.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c       | 7 +++----
 drivers/soc/xilinx/zynqmp_pm_domains.c | 5 +----
 include/linux/firmware/xlnx-zynqmp.h   | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 334d16d..08c6960 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -725,13 +725,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
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
@@ -769,7 +769,6 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
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
index dc60802..3e14bd7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -288,10 +288,6 @@ struct zynqmp_pm_query_data {
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
@@ -321,6 +317,8 @@ int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
 int zynqmp_pm_init_finalize(void);
 int zynqmp_pm_set_suspend_mode(u32 mode);
+int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+			   const u32 qos, const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.7.4

