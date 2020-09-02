Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD8220767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nlfjaQLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgIBQ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:59:21 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:15232
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728495AbgIBQ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT5ayBwVaG/BLCrVVAwS9tc/3CbpAmi/pPIN+zb7x/jJBlwqlsscjjYbrehRpi2K5YUfVNOKrVYtGiUO9DkGGicXgSscBGfFU4XzDBYRinvc031+/6ir1L/Iy0k+J12z295EQzaRqiEPI+tMUJRY0gcg6LdNkNR6eh5mvBqmFIbeDD5n3JRx2UmZF38+rQtNRyfs9AZ68W7wn4mmZAvpFZIfSwmJbFY1kO0uJ8SoS0eb+uVNAAJBzD0Q3jUbKw0SmyAuBgMX2lhl5DMW90RMe8pDoVEJWes5Vy6Opx/gjJXqexx6fOWaDQEsDp9f2cWHpzOY4qQoKmmj+lltvYp3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=YXPnDywNM3RaUT9eoESQHXNffNdrPQpygLAVcf+3NMl7R7QASlJfR0WAkmjNy0lmt6dZUEmRF29+oVOTTuEdl4jcwvLINYSNEHh+Ay+TixiIVznxDwib1cGUySKv9Rz9DjTVUqS2H/G9h0X2X3LdYg1yaSwtOHvjaEhv1sA27Cs+sBNKNduFDJy23YSQh7plsJZW7u91OGDtFsGkhTCC3lT2FnFsUr9H+ENQMIXpLz0qYQtikS9fS/vq/SciXrAOaFX7x+pPHTJm2/l8i7XgjMHQztkxvzP7HQRtdZvmvPKF21dyCBsh+WntGcX/r7tPMUkPJ6d2E7W9mR/tRXbMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=nlfjaQLCu2H2uiP1bgv4J1YI9S9bpR3oDqJ9PDA4wyzVaN/WoNJfQ30MHHi0IKjbyzphmxJbn0k5+P1Hoi9QKXc7SLzPSuxgInvXCTwvNWvpTuCv5+BMfDstca9muFxkhPEdwYrMjsXiM/FPBwnQ061sBO2xO0iS6N9984FKEIM=
Received: from CY4PR19CA0037.namprd19.prod.outlook.com (2603:10b6:903:103::23)
 by SN1PR02MB3678.namprd02.prod.outlook.com (2603:10b6:802:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 16:58:51 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:103:cafe::b1) by CY4PR19CA0037.outlook.office365.com
 (2603:10b6:903:103::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 16:58:50
 +0000
Received: from [149.199.38.66] (port=52905 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5t-0004kZ-U6; Wed, 02 Sep 2020 09:58:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5y-0004Hg-Gr; Wed, 02 Sep 2020 09:58:50 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 082Gwkwt003909;
        Wed, 2 Sep 2020 09:58:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5u-0004H9-A5; Wed, 02 Sep 2020 09:58:46 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com, michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed,  2 Sep 2020 09:58:42 -0700
Message-Id: <20200902165846.3366-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902165846.3366-1-ben.levinsky@xilinx.com>
References: <20200902165846.3366-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 52364fa0-0e6a-485c-9964-08d84f617779
X-MS-TrafficTypeDiagnostic: SN1PR02MB3678:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3678338A580B2E7FEFCA9196B52F0@SN1PR02MB3678.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4j4py1jNUrDgJHMlKiH9s84ZLVMCPbuSdSqdMjr+zVgHd3XKi+HA8eFLFgMzOejb+T/PYDzYhhX6jdKttNPaxlUsdqOwnCWSR8vphWg4/ZQdwWxtv9PVl5xl+oXAJ5mXt1IMAydctb6tgeAe+K2ABVmmINLDaL8oWmAoou8BX45PL9dr6Qfu92+iW3yptXETrpox1d3B31PCC9c8fc8+bDc9dJbCrJhNMzqmnMN7GLH0jFDFBUYQDW8FHX/Ebf8ez4Q/GO3rh9uBlH/U7FbkXb2v3HMOk84whwsGkf25vkStcUpVPEn4SGMkhbmsPeUakm0bqr/fc8+FQB/b+SHmPuzAzN+em8wYJEwLFtliXFvYPSl9jh3PkiIrNlNBHbLfCQACrBT7caT8PSF+h4J0OdpmSrZacy1x3Ljxp1cQ9fQ=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(46966005)(1076003)(426003)(82740400003)(8936002)(47076004)(2616005)(9786002)(2906002)(5660300002)(44832011)(356005)(7696005)(26005)(186003)(36756003)(316002)(83380400001)(70206006)(6666004)(336012)(82310400003)(81166007)(4326008)(8676002)(478600001)(70586007)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 16:58:50.7685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52364fa0-0e6a-485c-9964-08d84f617779
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3678
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

