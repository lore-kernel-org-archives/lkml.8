Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB977C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8550D206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Wlb5z7Ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgHKDck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:32:40 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:43232
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727901AbgHKDcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:32:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRKCBlylXWtqWGYrZqBqR/Szl2O61pJzPoy+DrsSx0Lj+7YUNHZdNtvvULvDo1BgrGtLrHN4f/tPHg3JbUNiRBSqeNNNPdGXvF48E9zs5Y3v7X34PgUBLayzShmimv+KkwQOgWYncW1lAMiPYgnCg5i2vnuR15YnBHwIyouRu8Qisz2kbztRXoTI3MyY+9PAeAv0T2IwcC/Jh3R79Fowjq+qlsPMInQ0/Lh/FnuHUqgcl9GpKe9EXT4sUAlBZ12RNbOVyTJU6YwVsJsT8NrvGb4i/LKDGomJ28ZlZ1kl0+y9f2//O4d0GGsPyLH8IvOqFXCgRrBYCmecRpIuQJ70YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvpATgbAlOU7ZYV6eeiVH6RiPk6bYsAaWIhuUVinaak=;
 b=LEMkDwBlBYFCr1ogXBNkjwegM2jRrAl+jP7eN03lQoURITFcPWEd23lYUjoyeFPI6JDxZ/9VDyUGBXJIevj/Pfn18RiubRWOVLo5veV/cZvi/wzVrWZrwyfCXR+Fd6KbLnqg8hy/Xe4cbAe5jJM6ti6V1HUMvKyUQC194DdrDoiQrlirwCn7W2Z+qk2a1e+gUlIvwa+iymZrzZg2oX/OYeqwyhEWkPXzZFPDAxaDgAZLKFC2SNsvS3aPyZZosBvx2IVvKs3CPK6TSEG+FxFqjQGuvU6PfUn2HQkGrDtSSeAIX/ymBBjBDjrLn8zuCcsxFOL+7yVo7+uR7Umc+YFLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvpATgbAlOU7ZYV6eeiVH6RiPk6bYsAaWIhuUVinaak=;
 b=Wlb5z7CiemcvfqeMj1RkUuQnxx7cJpX8MkPyv96zVxE4YdxKuDocngQwa8dkZ9Jx/07RN/5YwbH2fgggjIrHThCn2l+gpKu8FZSpLsKMRtwrzYT7U+oFmCIS4Y+KAfqS0bZR4rdHqVodLqrPDbrSIDatOt64R3DKEODdM0L2lvg=
Received: from DM6PR06CA0015.namprd06.prod.outlook.com (2603:10b6:5:120::28)
 by MW2PR02MB3898.namprd02.prod.outlook.com (2603:10b6:907:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 03:32:22 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::e9) by DM6PR06CA0015.outlook.office365.com
 (2603:10b6:5:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20 via Frontend
 Transport; Tue, 11 Aug 2020 03:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server id 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 03:32:21
 +0000
Received: from [149.199.38.66] (port=60899 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1K-0000i8-QD; Mon, 10 Aug 2020 20:32:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1R-0004hE-Cd; Mon, 10 Aug 2020 20:32:21 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1J-0004gc-4L; Mon, 10 Aug 2020 20:32:13 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wendy.liang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Mon, 10 Aug 2020 20:32:09 -0700
Message-Id: <20200811033213.20088-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811033213.20088-1-ben.levinsky@xilinx.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c747d442-96c4-4ce4-88c2-08d83da72832
X-MS-TrafficTypeDiagnostic: MW2PR02MB3898:
X-Microsoft-Antispam-PRVS: <MW2PR02MB38984A1EFE71E927C0AE4209B5450@MW2PR02MB3898.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxmBLzBzK9hJ9QPK+5lllj/8eAeY3niWh5f0nW54Wmj4wnT2Li1Y4IzTXkgDcG9iF6SIVX3ytPwvsvo03APQm2FW4X8/Hv+7G/9fmfHc+qFiNdD1hE1SspLf5KMzaz0O5XkoedBE/hsY5iBDmG/v9K5aRksE4i5MOHDweacUmKjfJ9MUUZdUG+hUPYVhaQxWe4BLVytkw8SqrBsaacrmcqbH0YzWzl+SX/5fM4DYJB+Uk0yMKQVipi4+/mWwlPjHjDHnAqsGYiuKunay13QE7K/YwWLQVY+wEO5v9LQXkOTE2XnHT+C8c49dozt0DKX4uwPtuEPIEQRZnAal7hnBVELQZeoL1N+ZeYJeGL+V3ADhdizA2QYSGCEiFLtJ8JvqdbHAuMtQQ5bSqcdX92AISA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(346002)(136003)(46966005)(356005)(186003)(7696005)(70206006)(336012)(81166007)(478600001)(70586007)(26005)(36756003)(82740400003)(4326008)(82310400002)(2616005)(8676002)(316002)(5660300002)(8936002)(2906002)(6666004)(83380400001)(1076003)(9786002)(426003)(6636002)(47076004)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:32:21.6078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c747d442-96c4-4ce4-88c2-08d83da72832
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3898
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

