Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E27C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F97206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="s6UVgtJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgIDOdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:33:51 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:56417
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730625AbgIDOcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3laIxmldZQ5Ek/tgw6zKrCbylV4ko9TYiuKOAUlR4wpGzKHSVXjAkjrisi9nnBNdLS2NyMxQaRyJdhjcWT5cFwL1ao3t4wnF6wzcHjAA1KZ0Z7Vruyv8kTUTXCX2MYDxEVeNwmZxjORS0OHefeEvB4b0lkfpG7zysw6WOZjfvylU14t2NOaR2QlN0DDhaHMAjTYs3LZZYY/xlen72/V3sM7pVhf5rkWrL0b8xDUblqAr+/jdc6a79HYjeqduFdH3fklGNWZfxL9OsIKHDc85/cMkKDs1zDEZXDnoHAVmcZOpGRKg7nxOB4xE7B4jkg619DPiTTkj0KEvCPSRrZpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=AVDWaWnXSflJsurGuRWDK8uMcHH7Rfw6rXbAWcDhO75r35dW2ziHr10xRLy6lUYFIx6C3eVCI1Y0L6fO386zIgxeXkha/yKcP0CEs+mWr4L6tyYsFk9el5Kzd+mYPG3p/WI3N3vIoqBNNzUiWFU7bBMCqvToBh7EnCAUU03CXWLMp5oPPHsvJrveu7bNYThuk2UBkTi5V426+GqFWsAyr7CiOHNxEhORUcXQgox4vIY3jtKWnvJZXj4UFko7Klt2v16/QPWjF9ohnW9Wk1ycf8BTGYKTSoVvoYcegB8YBRB5xe4gsguoFc8aiyaMPZOnkKLHhIyq0ox5EirgKReqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=toshiba.co.jp smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=s6UVgtJaikdPRQLDSwin2YKlQ1BsHrz63R5tQ0yVlyZFZoiRYRA7pRidzhwtRRwqQGuoAYDiztQYkA30LAxREY0o5kzSHfBZizpVg5EbWo23v9qHgkOT9PrdewZKf+qh1rym1t3pwk3ZVrChCeymSvFxo1O7B90Lt4Mvz4+4UI0=
Received: from SN2PR01CA0017.prod.exchangelabs.com (2603:10b6:804:2::27) by
 BYAPR02MB4727.namprd02.prod.outlook.com (2603:10b6:a03:4b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.21; Fri, 4 Sep 2020 14:32:16 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::b2) by SN2PR01CA0017.outlook.office365.com
 (2603:10b6:804:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Fri, 4 Sep 2020 14:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; toshiba.co.jp; dkim=none (message not signed)
 header.d=none;toshiba.co.jp; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Fri, 4 Sep 2020 14:32:15
 +0000
Received: from [149.199.38.66] (port=38242 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kECl6-0002aS-5h; Fri, 04 Sep 2020 07:32:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kEClD-0003ng-Ld; Fri, 04 Sep 2020 07:32:15 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kECl7-0003lx-MS; Fri, 04 Sep 2020 07:32:09 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     punit1.agrawal@toshiba.co.jp, stefanos@xilinx.com,
        michals@xilinx.com
Cc:     michael.auchter@ni.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, emooring@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jliang@xilinx.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Fri,  4 Sep 2020 07:32:05 -0700
Message-Id: <20200904143209.31235-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904143209.31235-1-ben.levinsky@xilinx.com>
References: <20200904143209.31235-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4ed2223-53e7-4bb0-559f-08d850df5235
X-MS-TrafficTypeDiagnostic: BYAPR02MB4727:
X-Microsoft-Antispam-PRVS: <BYAPR02MB472753C4BD36A72FFE2AB854B52D0@BYAPR02MB4727.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITSMSzgjKJnQWM/9/JmjjGxfFm9Yzaau3KwP1oIY+uew1CXKwYTlTEINO/7FYT6ZYHQ/mdwBB1LkBy0XTzCrFRtqQWaHCrWGGUWWzJSS+dXloePNd0TMuszzZIbR6zOPeelOQYHrn/j2Cevy1TwxqqvWbjIi4F3f+gU73BdfhkPHI+EgavK/xx4Rog3Isrz3oYjc7YLnugLuckPPHILTg+hCfg9K/mpGRwZ7ri7eNGGQmBRFMzfD8wwuE6bioq3vLU2vrvREvLirLBqZ9BXe9vqPeDq1bngevAA3EDtgfx7BCi5sY5JsBuP8319HGP3wSJ+9+cDcjE+AlLVaz8NgkKbKC5uu4gVVeneXokKe9lSEh6+40wgjoRVGO2WO6F88ik4+KgNPKuO/g9IPF1erMw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(46966005)(82310400003)(26005)(2616005)(82740400003)(81166007)(6636002)(1076003)(426003)(478600001)(47076004)(70206006)(6666004)(70586007)(83380400001)(316002)(5660300002)(356005)(44832011)(186003)(4326008)(7696005)(2906002)(336012)(9786002)(8936002)(36756003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 14:32:15.9961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ed2223-53e7-4bb0-559f-08d850df5235
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4727
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

