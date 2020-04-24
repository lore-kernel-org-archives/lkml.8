Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F44C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA33A215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bTh4bz0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgDXU7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:59:51 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:18145
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgDXU6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqRC70NgCD21WCOfsNWwgt50kBC5AZyBn4YVH455efxnPMgSm/jNd1jnVmyMocPXl/gseMK+Z3GHGLOZZlnhwI8P1quh4lCv6+xsH0uwJqkVy2YzsYtA+5i5Lq92MLUSsdIP6+tcfaX/3RpCCRReCXZcoQL4PyovB5bVywdTnQKnekn0nMrTlgosxBPxEwvPdqyrkmcqRL7X43wBjvu9dctnopDdoss5MavZYKkujC5KfiBEPZHiaaOKf1bm4weUn2fbVaTLzrZs1PWsgFrp0DRn3kcKW+2poay5vczZI4/gsZqgOdVkCN2wzr3+1sJiJwPRrE9nI/RIKqpF0VdkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfmEnL2YqOWyoqg9Fcj4RqboB3Ro6xRW533lmqY/d1U=;
 b=X3aXYp1HczK25HySWoOywQaFJ0CgDOIiSusgPgX/OO03EQ74LujhmPDif7gjW/upZWSGSJEXWKh6BVPDXci2EZBxm8FsQKvBA2pPfvZW3hzcGNxqljNYcQemN8Sw5qSoPdw8ouWCPMK2IsEb9xVisXPooBDwqDEoNmu5givNaM8IDEWExGUxEbK60XfpJluHiVTWtyfge8jz+Aud/77XEkTWz8wkSpTqBFMemKyO8/lzXubbJvBScjd6r6CdEVu/bJZrgR4mYfG0yACYsPkHt90+++Gqr8on1sd9IFKVE0GfYp3H37RUpIts4rTLLXl/xlUR+iwnNu3nDuEoGADFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfmEnL2YqOWyoqg9Fcj4RqboB3Ro6xRW533lmqY/d1U=;
 b=bTh4bz0q84FZXkyNdpp1ZvdGinvJT0EbO9hNeefVZrX46T+u6FIC1/XVC7cZ7ylePlS9s1We2zn6taU7pe6jynUX/rVOWW4pahStVOIvbkQVxqzn8TQViI8QJJ4wTlW0mHEzNPOc4I6DSGXWCKgQBqaA1E9f1G/pqmSTZRw15Dk=
Received: from SN2PR01CA0045.prod.exchangelabs.com (2603:10b6:800::13) by
 BY5PR02MB6705.namprd02.prod.outlook.com (2603:10b6:a03:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 20:58:21 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::eb) by SN2PR01CA0045.outlook.office365.com
 (2603:10b6:800::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 20:58:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:21
 +0000
Received: from [149.199.38.66] (port=33218 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Nl-0002Cb-QV; Fri, 24 Apr 2020 13:57:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ou-0007N4-Pr; Fri, 24 Apr 2020 13:58:20 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwIr2030379;
        Fri, 24 Apr 2020 13:58:18 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Os-0007Lo-Ma; Fri, 24 Apr 2020 13:58:18 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 01/25] firmware: xilinx: Remove eemi ops for get_api_version
Date:   Fri, 24 Apr 2020 13:57:43 -0700
Message-Id: <1587761887-4279-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
References: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(81156014)(8936002)(6636002)(107886003)(82740400003)(54906003)(36756003)(7416002)(2906002)(186003)(81166007)(478600001)(9786002)(47076004)(4326008)(316002)(70206006)(426003)(8676002)(26005)(7696005)(6666004)(2616005)(44832011)(82310400002)(336012)(356005)(5660300002)(70586007);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be89ad78-972d-4d50-103a-08d7e89238c1
X-MS-TrafficTypeDiagnostic: BY5PR02MB6705:
X-Microsoft-Antispam-PRVS: <BY5PR02MB67057A7A1A65B7E5D170B2F3B8D00@BY5PR02MB6705.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwqyQH3QYdqDNtL0lsO0gMVP5QsiZH8k8dry3Uyq9rsqRGPbQta6d1Ne8KyVL0YokviplcOZZ1TsUz3mDhNkY5GmskwAQYJZWLDs1khSM7ipbSpWqxWPTu4pmU1hWu+uxbdNjGrhkOhiMRJnCX48fHngaMMDPTgXldaW/J7kFeOUYqpwlH5Q6DvntwVD1CClFAl+QYeWwpo8ENX5cLFtvK45y8MWlOJtpdFN1EsdPsHRxd8UyY9BkmRH6JZJ4YCPPBwOoMaD+P4CjNS/xNTwX45arrLtOAPzm3Yq9TRJ7lkfhl0Guf9yICOSl2mU0Ym6AYneSFClamRDwe+gNBrO23HW9KA2cVPHgE6XtDvAKI1HYeucE3LF8YHeyPIWYyAmnQoITDR1Sf1BNrwRiN7qFlNNXuC0dtFzEvDSvc4gicLcF3Lxsc7GqHbn60rNQdgC9rVzmAikgPW2t1ecvBzT33yoW/feFTkqP9O6VtCqyseIJzSbnnNPwlICWeDl/7i1qLyZi5sLEmBXCetzOaTxHg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:21.1110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be89ad78-972d-4d50-103a-08d7e89238c1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6705
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
 include/linux/firmware/xlnx-zynqmp.h   | 6 +++++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 43bc6cf..06a21ef 100644
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
index 41b6516..36dab68 100644
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
@@ -734,7 +735,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
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
index 8efa5ac..a21abcd 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -294,7 +294,6 @@ struct zynqmp_pm_query_data {
 };
 
 struct zynqmp_eemi_ops {
-	int (*get_api_version)(u32 *version);
 	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
@@ -331,11 +330,16 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+int zynqmp_pm_get_api_version(u32 *version);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
 	return ERR_PTR(-ENODEV);
 }
+static inline int zynqmp_pm_get_api_version(u32 *version)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

