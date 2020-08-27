Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3999EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1365F207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gLYJjGT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgH0B6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:58:32 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:43169
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbgH0B6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c30J9ooyWpRHS6zBiF4EFH+jupE/n+2j4lHROLXEOlB1eSP3b1/byx+Cscmpfsje6knpiGKr5j1apqs2ZMMP04wmweDnyW6fezTkVHYl9y87yy9cTmBkjskR6xkzSAFBdA+F0mkyYaFBI3J8fiyP7135t6VCXaOnt5ezQaLgb2R+cIWuAFypTnh1gWHW8fhJVCIN7jaLhZyKK6tSP3YKNoJp6PqrjqyrNfbWWcM2isDGwa1+YXMR76Jppxint3nit6o7FD5+C+/5ulBQ6E3rMSvHXgQEKTPHnpZw/bZ0M96dEc+Q2Qx5OQEnLvGHW6MCCiJ/CskSwC1WpwqdPBd8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8QxPMisC2+k/+yHudjuCuQoA5DHOOu3ciktYDpZmyQ=;
 b=oAGYA5YcNXhDTq+b/hJQfuUJ1fhkTMJshJSTB9CuGOx2RloVFjKqpalIkIZ4Q0Nhdm3Oco0z0Z9JjYp7G+Sro3dC+7kDXujBx70F91J2HjRxk6Ui2nBB7qo1c7+PhAX+JEeaPghgxO8nRQbu8sEr8Uf2HyjoRtlLUtFjs8mnRUKotTDRiovxupnLUtRUMs33pdtqQx47w9SDk9zrK1bfv+QZcGezw9EdIDLHUzIzT/EZxVFP8NOq8YMdl0Ci9gQPvJg8yxc8U+Zkf98ifvob5ZvG+WF7PaxQh0opteFoPVAbrAiGzkGg3lyii5HmhbAQe+1cqYx4OOfqCSuM/gTLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8QxPMisC2+k/+yHudjuCuQoA5DHOOu3ciktYDpZmyQ=;
 b=gLYJjGT4mXLXAutMiD7Kjis3hfeVC96cvS/QAlKWV5GnV9ztdBsgRcNI5rHhWCb6KBRAv16DIx7DVyC+dAwLOpHniDQMvjQHd5jEorg0+Yl+8AhSYCGQa9B74OPl4fRh4I1UTk+SIuR8YCV0tnzXE/b4rdFCvKDbzUAi/nkD7LM=
Received: from BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) by BYAPR02MB5559.namprd02.prod.outlook.com
 (2603:10b6:a03:a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 01:58:17 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:17:cafe::5) by BL0PR1501CA0034.outlook.office365.com
 (2603:10b6:207:17::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Thu, 27 Aug 2020 01:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 01:58:15
 +0000
Received: from [149.199.38.66] (port=58724 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7Ad-0002AS-OR; Wed, 26 Aug 2020 18:57:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B9-000183-CW; Wed, 26 Aug 2020 18:58:15 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07R1wATw015256;
        Wed, 26 Aug 2020 18:58:11 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B4-000155-Pw; Wed, 26 Aug 2020 18:58:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com,
        michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed, 26 Aug 2020 18:58:06 -0700
Message-Id: <20200827015810.11157-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827015810.11157-1-ben.levinsky@xilinx.com>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d32f913c-e99d-4747-47e2-08d84a2ca997
X-MS-TrafficTypeDiagnostic: BYAPR02MB5559:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5559F6EB9AE226F3D2C809EFB5550@BYAPR02MB5559.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woSdLsUuhd83tujIVQSoyGL+yvtLKkLuCjD1XvzRk8Z0SjuFgcRXIPounCk36+CyHCpMB73dkEFcvbW2GYrX6WhJf29wE4+txADqCDX5CzJQajvrkFDKRepDfvOY09M+ogXI8Gf6AHhDbEaZz/yGwdQGbyMRwz8pJlfH6zSL+oh+LWwHj4wSoVi+3isfifrt+ge32zImCjO1zt2ymGM2iccLER/H98wnJRYICYy6Vlot2lClG/zGt9SfOZDcP//ZHzz4Oo/2wdhzkzU+GVTFAOyx7PE+0IP1p57X2HUxGyBUd4ROV/aepS/WD33kBNMlfdXt6ll73vskDC13abC1axl1eldvXxG3mq5idbyJ9NylcUoS0hS7UFsL0V5Y87sTWBZ8wAgQundGwuEQ+LIiZQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(346002)(39860400002)(396003)(376002)(46966005)(336012)(8676002)(9786002)(82310400002)(356005)(478600001)(2906002)(316002)(81166007)(83380400001)(426003)(82740400003)(47076004)(70586007)(44832011)(8936002)(7696005)(2616005)(70206006)(1076003)(186003)(5660300002)(4326008)(6666004)(26005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 01:58:15.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32f913c-e99d-4747-47e2-08d84a2ca997
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware ioctl enums for RPU configuration.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
---

 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df82b991..bb347dfe4ba4 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -104,6 +104,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY,
 	IOCTL_SET_PLL_FRAC_MODE,
@@ -129,6 +133,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP = 0,
+	PM_RPU_MODE_SPLIT = 1,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC = 0,
+	PM_RPU_BOOTMEM_HIVEC = 1,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT = 0,
+	PM_RPU_TCM_COMB = 1,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE,
 	PM_RESET_ACTION_ASSERT,
-- 
2.17.1

