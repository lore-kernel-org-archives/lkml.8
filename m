Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3752C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B9C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Gck8h7+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBXRxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:53:03 -0500
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:6162
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbgBXRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:52:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXbXzo6hToWz32seZn+8nsKwirXIb7AU7j3xUYTDOGc1RiXm31F2ThXVR+iX75y6pwERzR/JRwskt3LBQReNoeGjUO9gAWHJ8614zNlfFu+DeTOxjC6gZ3D3yps6NPj9XugjaL9s43WcwFGshsrv1WN1WFoOJdtI+S3dENaBtQpzwgfcKYHuaBbdcdYAfV+eAjHns2Hpnur6I3An6sco1+ZHab/2Et7rPsJdn60qO5JNOlvghvmsopv0f4/C82JHmrkpPCH7TBc2V1TARvDhW9s92XofWa+W+qEvc6cLyPXgc/3nW2ylrGkCxJENTlu5XqtA73nb8NtK7/MVW5Fkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11XDYm6UWIwtSXXZurQJReOgCig6+1VQ+tT/cbFAWzU=;
 b=COA80ukOakGQVNIuThHVKKgd062lel5Vgnai4R+Gop/KiSwNjw7LUcJWIGpPZMaeoPLUOD7WuOYJEbZoKOKKPHKCqrMSvtKeAtCoUM8AvRixVzQO2YLvdCRz3VJLcd02rDFPFl7uNdc9B5rpFZQPmnHBs1obTa0Exft0ixPiNWT1DQObgwsL29GmmQQMxaUzT9TMdLK3GtWikRhqzHgWuenTv85HFConq/wHQZnw0EDxNLqp/W2aGkFcV+KqrpvRIyb/SRs7mQDcJ5tDiyc2ZAX59aYxTfzaXsGz5lNixAaF9fqqyVvo9XRuv3VKj6iYnij1vUpkUILZRxjF/InJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11XDYm6UWIwtSXXZurQJReOgCig6+1VQ+tT/cbFAWzU=;
 b=Gck8h7+BRi1qsVC0IMdP6YVs4S3N3M0gP/GJAt1bS74mrbKRkvojmLUTPPgfsYVcFOwPeir6Neg1cwqrds7Dsqs0Lm2tWEmu7YyC2a0wD34UfJNrOR3UCxpFVMC/0EM7jRn+eo8kv8A2eRRpi+lfTo+pKB/ssCTPd8G561xfFc4=
Received: from BYAPR02CA0054.namprd02.prod.outlook.com (2603:10b6:a03:54::31)
 by BYAPR02MB5655.namprd02.prod.outlook.com (2603:10b6:a03:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Mon, 24 Feb
 2020 17:52:41 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BYAPR02CA0054.outlook.office365.com
 (2603:10b6:a03:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21 via Frontend
 Transport; Mon, 24 Feb 2020 17:52:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Mon, 24 Feb 2020 17:52:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1j6HuK-0006VD-Kd; Mon, 24 Feb 2020 09:52:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1j6HuF-0007aa-Hq; Mon, 24 Feb 2020 09:52:35 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01OHqVfZ015188;
        Mon, 24 Feb 2020 09:52:31 -0800
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1j6HuB-0007aE-Ko; Mon, 24 Feb 2020 09:52:31 -0800
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Mon, 24 Feb 2020 09:52:28 -0800
Message-Id: <1582566751-13118-3-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582566751-13118-1-git-send-email-ben.levinsky@xilinx.com>
References: <1582566751-13118-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39850400004)(346002)(396003)(199004)(189003)(26005)(4326008)(5660300002)(336012)(186003)(426003)(36756003)(478600001)(70206006)(7696005)(70586007)(8676002)(8936002)(316002)(2906002)(356004)(6666004)(9786002)(44832011)(81156014)(81166006)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5655;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 180d51a3-8b9e-47ab-5189-08d7b952582a
X-MS-TrafficTypeDiagnostic: BYAPR02MB5655:
X-Microsoft-Antispam-PRVS: <BYAPR02MB565518D45F0DA59B19CA088DB5EC0@BYAPR02MB5655.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rp0MjG951sRbhwv+Mz1QbAe4Img8tkYZoBjB2++tU6eDiE6yhiDp7OyPy6QWRyd2xyAvp8XGSrd89WInUdnqZf9IYVjdu3DDCxl1obkho0g3EYTrZxslp4Jj5uPefAuR4oCcN2MO3WgVPJALmxgsRa6fhPCnvaTonq5YFq79T7+LCuARI9Ff5BnX8Q9gVQr3FIVJ365pWEaKZEGA8jkid6ojstCGbx/uHg8lN8+tlU+bAvaIeeGOd3LaMkJQ6ilTB+eANTR67Rx1YbapXHSIP8jn/xdJyMW/0ecsDcJrUImkZBvkZ5Y40HyjLnvBPUlRU0vMI5MY5RTqoKkrUSzhJj1M7u9lxy19lYVxqD6T2yE4xzfk1iK9xmO8W76ONy5ufmF49nGoXerAJqevOd/sMbvqotcmZtQtSHqfzRXIfBnsKzFQi89ocr+Y2zIu6BsU
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:52:41.1447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180d51a3-8b9e-47ab-5189-08d7b952582a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 20e4574..486dcb1 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -692,6 +692,39 @@ static int zynqmp_pm_release_node(const u32 node)
 }
 
 /**
+ * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
+ *             be powered down forcefully
+ * @target:    Node ID of the targeted PU or subsystem
+ * @ack:   Flag to specify whether acknowledge is requested
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_force_powerdown(const u32 target,
+				   const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
+ * @node:  Node ID of the master or subsystem
+ * @set_addr:  Specifies whether the address argument is relevant
+ * @address:   Address from which to resume when woken up
+ * @ack:   Flag to specify whether acknowledge requested
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_wakeup(const u32 node,
+				   const bool set_addr,
+				   const u64 address,
+				   const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+					address >> 32, ack, NULL);
+}
+
+/**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
  * @capabilities:	Requested capabilities of the slave
@@ -731,6 +764,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
+	.force_powerdown = zynqmp_pm_force_powerdown,
+	.request_wakeup = zynqmp_pm_request_wakeup,
 	.set_requirement = zynqmp_pm_set_requirement,
 	.fpga_load = zynqmp_pm_fpga_load,
 	.fpga_get_status = zynqmp_pm_fpga_get_status,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index b8ca118..0a68849 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -82,6 +82,8 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE,
 	PM_CLOCK_SETPARENT,
 	PM_CLOCK_GETPARENT,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_FEATURE_CHECK = 63,
 	PM_API_MAX,
 };
@@ -330,6 +332,12 @@ struct zynqmp_eemi_ops {
 			    const u32 qos,
 			    const enum zynqmp_pm_request_ack ack);
 	int (*release_node)(const u32 node);
+	int (*force_powerdown)(const u32 target,
+				const enum zynqmp_pm_request_ack ack);
+	int (*request_wakeup)(const u32 node,
+				const bool set_addr,
+				const u64 address,
+				const enum zynqmp_pm_request_ack ack);
 	int (*set_requirement)(const u32 node,
 			       const u32 capabilities,
 			       const u32 qos,
-- 
2.7.4

