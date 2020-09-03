Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FCC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9E4206CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gAKLmrQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgICVX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:23:28 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:16672
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728107AbgICVXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+HupyKmm5YSSvxfNhsIpPiOn4pgv7M6mrK3Y27E1cLQ1kJdtQZPqEToO+tbCEOSCeM49iTA1NEuPygK4fJ7qcKD4DwiEpcEcB5Rn9s8ZHMlOtG1WbDzvLVxQ6lW3ctpoRAHJh3NHqAiC3OC/KLPXqWpTOvPBzgBASFa1XJrL6mNYyLUaI8eNmNVFAROuE0Wtufu1y96RmCR+Av+GDgeMJHSMwLsrkL82j7/St386Ew55ag74oXgA9awWmvsCWfz8ZEh2tETrAHhv3lWju1zrsEj3T8C44CvETMfC3dsAdD1LmzSIgNyCqa3grnoKUYPKcZHBVbdSjQaBIMRnXdCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=dPVpk2KTjh6ogzOSleG0AhuXxjSwcbMGLzVnhaPCQPMt4DtUHOcG2d5rIzc0jcN74lP3S87IoXACB03OpmF4brhSkYzQvJ0bBhtD9yBJpheFBKtyT2dZsx5W6iRWtfNm89dYQrdnZoyxsq+VlzdhfmyynfVR+1JUBjuxXtuEFrt1ZAY5jZ630pM7A860GvvcOX6L+ZQ5DS2ipavuXGXAEArV1xUuZQ3bZb6DT2NJ6HFSw/qA5StdWmcSgmoyFtZa6tigbgAMkCzZX59Vj79BTtx7vAZQ3mTdzL61hi2iTbFgKgb0QOfykQSwb46fYo0ZC0VP3bKXpw1UpP+/MZrvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=gAKLmrQzvtq4XoFV3IFLoqjDV13kgpa8QIYaNG3Ogo6LEmRceKo7YIf10Z2skkJm7iEwT9Dm7Ydi8JniFBX1rXGJBXkdijLvD2vcRlQIi9gX+u5OL7odKnryAx3zyW2MQGSZ+amRedagSFYbjIOgz+MkYwth1UaFBieFqa51cb0=
Received: from CY4PR22CA0041.namprd22.prod.outlook.com (2603:10b6:903:ed::27)
 by BY5PR02MB6452.namprd02.prod.outlook.com (2603:10b6:a03:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 21:23:16 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ed:cafe::57) by CY4PR22CA0041.outlook.office365.com
 (2603:10b6:903:ed::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 21:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 21:23:16
 +0000
Received: from [149.199.38.66] (port=37610 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhJ-0006tr-Kr; Thu, 03 Sep 2020 14:23:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhP-0000OF-VM; Thu, 03 Sep 2020 14:23:16 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 083LNAfB023389;
        Thu, 3 Sep 2020 14:23:10 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhK-0000M3-5y; Thu, 03 Sep 2020 14:23:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     punit1.agrawal@toshiba.co.jp, stefanos@xilinx.com,
        michals@xilinx.com
Cc:     michael.auchter@ni.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, emooring@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jliang@xilinx.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v12 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Thu,  3 Sep 2020 14:23:06 -0700
Message-Id: <20200903212310.17990-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903212310.17990-1-ben.levinsky@xilinx.com>
References: <20200903212310.17990-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1b724122-9dbd-4017-10f6-08d8504f926e
X-MS-TrafficTypeDiagnostic: BY5PR02MB6452:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6452F175EC3488AEBBED95C7B52C0@BY5PR02MB6452.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnnanBYmtfPex2ByblmS8Ns1oI4Xuddcqqg77S/iyYZ8An38VjduR/rjARmVwIpzNxnAYhGVjVbdAnH4UzModYZgFY7CY36dJmnC8zs0jSS2o137aoDPftJEc8Z9u11IGzV3eRXEDPw5DnwNQif9Yd3Ct1LB19PcntdXXlTMzJotAneeyQktDul+QF7JkZUHttcmNqbu2cnM4PTUXTpQWFYOizZiobvts1vNUAAI4Xc2oxPvJN23v5R8oU8hnprPl5w9DD1BUlOI2KBuTVFk8qX4BRpX1uZ5ZBUcamF/JKVCn5khy5sXcCYSHCJTnC45g3QPGsWOtu7SkuAz2ZulzdZcL4PDSmWTR1ZmRXdbMwed0miJDNu82jJ46eBqs5Lc66pyzjTjrJBx+qIrH8jfiJHwD0SqtZ2PjzRYdPhd7Is=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(46966005)(336012)(6666004)(83380400001)(7696005)(47076004)(82310400003)(2906002)(82740400003)(36756003)(81166007)(356005)(5660300002)(26005)(186003)(70586007)(2616005)(1076003)(6636002)(70206006)(44832011)(9786002)(4326008)(426003)(8676002)(8936002)(316002)(478600001)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 21:23:16.2030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b724122-9dbd-4017-10f6-08d8504f926e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6452
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

