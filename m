Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B76C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5004120736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XI2c6th4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgDXRg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:36:29 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:6268
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729067AbgDXRg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBioZ57QyJpc5CODc62GB0NugZfYsscpp+QNn0UH32bNBBSs7O3J0ltbuu1wRexNlH3Pz5stkfctKZGsJAf10n38I6xfvhegIsfqffHhPdXC+Pf51MNOqivV2yCRyvAv1tW3JxOVk/duY61rZkLQi3xBQ5jFItRmPJ2AqiD1g25cyrtwA+A4uAlwCPGwxXND0oq29afcBrYb5Dhysll+G876cnBvXFjrsVxU4mp0S//+CoRUlxZ+GrRyhvf/a40IBjPfblikl7PFyNeOUpMoL+YBoxIdbYBHjwAhcq/UxZbJiq2ctBJYLs2DIOrNwL2tpC3NEBF/hrPkXYZqtstcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2uJTK7FZlizxilhrEMccVTJJywvg+fjRCT5ql8HyzY=;
 b=K5npfWFzPLjHCGc+ScllP4Q3YuRiwrMwqlJmuuQnzWwONh6FIKwu5IInJvPs8I6PGgy8bs0U+7EKKnCd42W8twDHnZgNjPmUuzABw0zoJ35uaL7ZN7aA3xefaKqn08k4Zage/5baU7WMd2UjapxoewgdD20dO1NMbQG1sw7ZfB30dx7MEB6Fipi/1cRfrRJp5VMe1MEZnyhjAkD7VPS82unElJe6OWf+65A/I3Yqo49AzpgGieQ+NHca/WykaX1Mdkq1Tx3zVTAi8ADS1x325g3MXPmAHqUh9QPGuEofLP6IMb8+1uoMuB+D2fhbLR7RqG2t3cvpWkPmllcnLFwdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2uJTK7FZlizxilhrEMccVTJJywvg+fjRCT5ql8HyzY=;
 b=XI2c6th4/NObskD/D1+s3Q66Ax3jHxRxST+D6zSWKHMV+sJkZJrCW3xIkODzb4WSOnlXXU3figaLWhokv8UAs2RB64PLmeQmhzHwDyuz99SCJOI2uZGx8FdnMXh8uF1GaTKGAYGm53nKITVdlekp6yD44VN5yB8wmWWF6d1hBZk=
Received: from SN4PR0201CA0040.namprd02.prod.outlook.com
 (2603:10b6:803:2e::26) by SN6PR02MB4383.namprd02.prod.outlook.com
 (2603:10b6:805:a6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 17:36:22 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::c2) by SN4PR0201CA0040.outlook.office365.com
 (2603:10b6:803:2e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 17:36:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 17:36:22
 +0000
Received: from [149.199.38.66] (port=41700 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jS2EJ-0005BD-G6; Fri, 24 Apr 2020 10:35:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jS2FS-0006l0-1o; Fri, 24 Apr 2020 10:36:22 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OHaAww026364;
        Fri, 24 Apr 2020 10:36:11 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jS2FG-0006h9-QV; Fri, 24 Apr 2020 10:36:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Fri, 24 Apr 2020 10:36:06 -0700
Message-Id: <1587749770-15082-2-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966005)(26005)(70586007)(81156014)(44832011)(82310400002)(2616005)(81166007)(7696005)(426003)(336012)(4326008)(70206006)(8676002)(186003)(8936002)(356005)(2906002)(6666004)(82740400003)(5660300002)(9786002)(47076004)(36756003)(316002)(478600001);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68db3aa4-0c1e-429b-c8aa-08d7e8760165
X-MS-TrafficTypeDiagnostic: SN6PR02MB4383:
X-Microsoft-Antispam-PRVS: <SN6PR02MB43838F07165B784F11E8A2E7B5D00@SN6PR02MB4383.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0FcwqGUgdPmywJvLKj01OE/FLyWkfGcDMf8947yjWou9ru2osIyOXLwiTzTGp/o6y040fnEAnTllCG8se/aIWV45l3SLU6bv3zJmzQiIPIOUFh3XTPADDYbqmxWu4oAJar+y0nOQU/YjiDSSO23b7d67pzLIfcrT3A8djZLS+7ue/j9MizE1hsuHVuKsRX2PwTzIrLsG36/zLSFoSpOs+0ezN4beumkZyDgWEPh1VPK12WV5W4XQFmsHsZI83EOlwqpg9WRyGkLa2c/t9wRTHi+4OPOpOyNbNyo7XeS3Wgb/2H1xGeSiLZiFj09JjfphC4YeThEZIOs478JYsSmjYCYMBMahw8wwoWxrPZ4kj4+E6fg7VCPMaHgh1Pd19VodCPyHa9bs+sgQfpIxc+doqtJdghPMgBbiinEgUF1jp6hQfQiku/R0TMcdsmXvFCTebod4FCO+P4O/Y00QnnRXF95vNH1r2TlewGW4ZbjZdN3PD7ag2+Rw4xarlIg/hYO3QOFbRHok9MkkaSJaKv0zQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 17:36:22.3267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68db3aa4-0c1e-429b-c8aa-08d7e8760165
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware ioctl enums for RPU configuration.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
changes since v3:
- add default values for enums
---
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df8..bb347df 100644
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
2.7.4

