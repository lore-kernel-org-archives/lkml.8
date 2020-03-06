Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB1BC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B1E206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iLhgd8AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCFXsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:48:08 -0500
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:20608
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727220AbgCFXsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnxfiJ7pRqBk5ftEADKvy6Eg6VI/kQ3PBXryjTmzEibBuPddNrLda9DdwDmJ0wiak+ISLDOl3fYBM1Zah0fHj6lTSs/kez44DujynLLQJynYJxB24Hlhy1zF1cxchUdJ6Df+7RHvOXOYd6MW8v8fYDIs8EV0ykq0p+3VHh8vQTw1iDdkYC8EzDx+E9yPkq6rKUMFczpWgRwvhHrDEUFGoj5G+Ay8leXchMpyC+HVTKi1pQnPyJD6xNcmoU3QEh/w/ck9JTsxj+L3CF8XhNzBjk+L4Pufh5FqmWyshAsJUb41zt+hBMh4lJSnRQKkFJU2uQmoV9EiUPAErAYOd6C/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aycpGsfr7l7M5LMGRUVvOc9nwPw3Yz+Hi2W+IySN6tE=;
 b=nN4AVSxRFE0LMRbkQ86/CJdWyGo1tqXwev0UsGXtsZB2NfKqKTB3AEWohWhHm3w2mUs4AV1hRy/Tiuvjo/4BSfiFP8dNz7ylf5ikHG6NFH1bZ8ALGXITtKOqZJjwugOdRVrJYfz6pPT/t59edfpLTm9qb31r/l62xE4JP3pht8V3vl4evTuV6quv/oyVOvKglNXs8RxrwfVWUxcKlnKGg5hMlHoGiY08/fR4HuLIzvo+4KZLxBHnw3sBHjCamrxtNY57JFuLGUM7LuN9gb8fh6YppLvqBHdlQz9qZJhMW6KtVDhauOkrM6sFJOz8IzmvaPsvTgX2KyEFrbHwheZlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aycpGsfr7l7M5LMGRUVvOc9nwPw3Yz+Hi2W+IySN6tE=;
 b=iLhgd8ASif4vnJ5tzPs1w8jZw+YnbR1UkK/WJHMXuLhT6Mg4IGnaS6GZuyJd6ORkHOwfj9c+N5/b+9ef7nYn0RrP5/2+TQH2ytVojVBS1C+BtTCumYDc4Pk25rTVySvJdrmwtxjNKvSeuTnraTTa9V4eVbZ6K9g50fif19+bnmQ=
Received: from BL0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:91::17)
 by CH2PR02MB6280.namprd02.prod.outlook.com (2603:10b6:610:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 6 Mar
 2020 23:47:59 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::ba) by BL0PR05CA0007.outlook.office365.com
 (2603:10b6:208:91::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.5 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhC-0003QD-6s; Fri, 06 Mar 2020 15:47:58 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh7-0002g8-3i; Fri, 06 Mar 2020 15:47:53 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026NlkKO001015;
        Fri, 6 Mar 2020 15:47:46 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh0-0002eg-Jt; Fri, 06 Mar 2020 15:47:46 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 17/24] firmware: xilinx: Remove eemi ops for release_node
Date:   Fri,  6 Mar 2020 15:47:25 -0800
Message-Id: <1583538452-1992-18-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(186003)(70206006)(426003)(478600001)(4326008)(7416002)(26005)(316002)(44832011)(336012)(70586007)(2906002)(8936002)(107886003)(356004)(6636002)(2616005)(7696005)(81156014)(81166006)(36756003)(6666004)(5660300002)(8676002)(9786002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6280;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8738a718-4832-4c6b-8b0b-08d7c228cd01
X-MS-TrafficTypeDiagnostic: CH2PR02MB6280:
X-Microsoft-Antispam-PRVS: <CH2PR02MB628091DE27A7200915FEEB96B8E30@CH2PR02MB6280.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yF4RmLxY9SCOjQTWBOiVYPvPpUsGDtyaMn2TmgdWUOvGsWDXMRxj6pS9dQw3Uc4cukJRUtt6BQ9Nulytb5xbhthBfdLAiCwSmyMF7mrr4I16XHrfR7hp9uB9CF5LYAkCmeX/vrUqMSKZ3pWNMCm3w0BwLu3ntJHzYKoDmsEe0KS0r8q1qQcNDrE6utq3BbcYvXcgTDn+jZl3CdjSUIsvfz8esn/vYmnnmK13Jtvx4dYgqeohDAqsd4/eKVKh+KzmzBdAVDjx1mTr3YESd70niUgUu4oLpTGBGLJ+5Dx2l5RSDG5IpFfa9spb20nqmz+ah6mvu5pckCy1+9xOV+iIY1jTlw9Ruau4LJ9iTZbTf5hFL+x8PIDzHbV+lTbjS2Om8t9UtHEJIalwN3G00RA5IXlYHOlsc/3K9gp1IuJx/8JLc7rFevn1s911LQuPuUC
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:58.7653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8738a718-4832-4c6b-8b0b-08d7c228cd01
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of using eemi ops for release_node.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c       | 4 ++--
 drivers/soc/xilinx/zynqmp_pm_domains.c | 5 +----
 include/linux/firmware/xlnx-zynqmp.h   | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 08c6960..d59a00f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -743,10 +743,11 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_release_node(const u32 node)
+int zynqmp_pm_release_node(const u32 node)
 {
 	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
 /**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
@@ -769,7 +770,6 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.release_node = zynqmp_pm_release_node,
 	.set_requirement = zynqmp_pm_set_requirement,
 	.fpga_load = zynqmp_pm_fpga_load,
 	.fpga_get_status = zynqmp_pm_fpga_get_status,
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index cf4eed0..20bee26 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -196,16 +196,13 @@ static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
 	int ret;
 	struct zynqmp_pm_domain *pd;
 
-	if (!eemi_ops->release_node)
-		return;
-
 	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
 
 	/* If this is not the last device to detach there is nothing to do */
 	if (domain->device_count)
 		return;
 
-	ret = eemi_ops->release_node(pd->node_id);
+	ret = zynqmp_pm_release_node(pd->node_id);
 	/* If releasing a node fails print the error and return */
 	if (ret) {
 		pr_err("%s() %s release failed for node %d: %d\n",
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3e14bd7..e51332e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -288,7 +288,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*release_node)(const u32 node);
 	int (*set_requirement)(const u32 node,
 			       const u32 capabilities,
 			       const u32 qos,
@@ -319,6 +318,7 @@ int zynqmp_pm_init_finalize(void);
 int zynqmp_pm_set_suspend_mode(u32 mode);
 int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
 			   const u32 qos, const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_release_node(const u32 node);
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.7.4

