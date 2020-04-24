Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5827C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8434215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Wv4tX+k+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDXU65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:58:57 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:47288
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbgDXU6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep2fDbaovIlfayfsWtvDmzs8eia03O++lRWYd3wXeR3X0wkd6gpiPtG+D0861teM1Pv2lkC5gCJHVquZ1IzimNbKpx+kOvBnK/1RTehXJZOzd2L9yvrnsvykgptBsl5PAdp2HVfQ1hoWenK5hYqLy446t2KuaXC0EqQcBtMJgaolPH9rr4oifNGkwV9CfmswwPv4BDzTTDXPSx3eN5QM6E6olR2IFatc3TVp2q5BSgmIbrCCijzwJxS+56oSK0dOQp3f70o8NxDn9qEVX3TgBd1kt+bngVGX9CThS5T/7p1XzYrpJ7a/7971XpMHp5PQXjpRoSxmFJhJV9+Wl7TZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS8FwPDarqj06h6I7+4l8DbmQvhTNtRxErn/anQkua8=;
 b=Xph9bcCLTU9HeVYE2FdU408M+ce/mtQNKGmmB3WPD9CePZ4xOV7O8T1r9S203UVXzN/RXj0ljNR1Iyws1R6Zo3xAtqCs/QnjXoHbx5ARykmCLhAQzVXJ9OWkNtVl3YFf8mgMtkFRfWRzRzPYbwbOi4d1d9UFVNC1v84ggER1BuHfQf8lj6kGbArlWluvt2gkbaDH+ELDEwTlKx87u1yBQ4hy9K3SVNuGtrHdVOwnlbef4mmL6Gi6Ye+eNjFJMaHZP0IXa8sLc0LxE6InkerFVuANua6qsG+/tpyXmBBFnVX7cArHZn7/hSdANlYHcyyKa5AeDu6gaWATwtjjs43grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS8FwPDarqj06h6I7+4l8DbmQvhTNtRxErn/anQkua8=;
 b=Wv4tX+k+H0LTHix7/w4+HObH+SISz+OC1LtCHAolUPsOyvdBFK4THX0+Bd0HHMnlmikiBPWT6HVJjktDZnY3isIKJ9iPEdSyOWfI9a5LGLufa4R9MElRY7Yt9LU8lQRaJYVNr7a1GPYx573Bv02g+JUs3OJGK5rf7J/7i9xjOWI=
Received: from BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) by
 BY5PR02MB6452.namprd02.prod.outlook.com (2603:10b6:a03:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 20:58:33 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::40) by BL0PR0102CA0018.outlook.office365.com
 (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 20:58:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:32
 +0000
Received: from [149.199.38.66] (port=33410 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Nx-0002DW-9z; Fri, 24 Apr 2020 13:57:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5P6-0007Pe-9N; Fri, 24 Apr 2020 13:58:32 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwKJ3030403;
        Fri, 24 Apr 2020 13:58:20 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ou-0007Lo-46; Fri, 24 Apr 2020 13:58:20 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 23/25] firmware: xilinx: Add system shutdown API interface
Date:   Fri, 24 Apr 2020 13:58:05 -0700
Message-Id: <1587761887-4279-24-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
References: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(81166007)(356005)(47076004)(82310400002)(4326008)(36756003)(82740400003)(8936002)(26005)(2906002)(8676002)(7416002)(9786002)(81156014)(6666004)(478600001)(44832011)(6636002)(186003)(54906003)(2616005)(70586007)(7696005)(426003)(5660300002)(107886003)(316002)(70206006)(336012);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5bba921-f839-456a-5189-08d7e8923fa2
X-MS-TrafficTypeDiagnostic: BY5PR02MB6452:
X-Microsoft-Antispam-PRVS: <BY5PR02MB64524671B6BEE2AF6DF6BD36B8D00@BY5PR02MB6452.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZ8xU4Curd+TFwdZSNT3s2qfDL7VWfbfxaxJNuBMV6uWWSpGAUJirujFrYa2Nz0ciXxMMId8hCGzCllJ3axg9eBvjySn0S/9kZTBU5fSqNXAfOMTmQUuajFN8JeBpVgAbuvYQS5ybtY3CNCerQQNsnvkTghwLaBqQCCBmS1AKWQNLPszoj6FjPAsqL5eYivdiGKFy8SgHHVuHL27gdPedRC4PEWSZ2iTO98XQ2PuicU9C15nCAmYgj6N5aqPWX+Rdt3iYg5quUhVH++kMCowhdcCvzYbFSg4qo/zpK7rQe7Q4aJv1KbuOp3PMNR66pRtutC6hcsIp8GO8H1Vt2FuWnE2AdibYqKmNg0CHkfyFYKbGODRvDnEA0Sz0qIEU1OOYp2TKDFHs4i4cOxHxoJLKnvnsLIts9C8Cw99TTuomjnsD7mtYJDtT8zQCa1lhXyMwlOItqnLQDo/rOnAQ4EdHu3G12xlM1Kf63jH23l8Ka0oV/kVvmhR0O15B6EqPtckJRmAk3o5cpmC8gHch7zPvg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:32.6476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bba921-f839-456a-5189-08d7e8923fa2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add system shutdown API interface which asks firmware to
perform system shutdown/restart.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 13 +++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 2fe4f57..9ba376c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -875,6 +875,19 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
+/**
+ * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
+ * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
+ * @subtype:	Specifies which system should be restarted or shut down
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
+{
+	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
+				   0, 0, NULL);
+}
+
 static ssize_t ggs_show(struct device *device,
 			struct device_attribute *attr,
 			char *buf,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index c1356e9..2254c7c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -64,6 +64,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE,
 	PM_SET_REQUIREMENT,
@@ -340,6 +341,7 @@ int zynqmp_pm_write_ggs(u32 index, u32 value);
 int zynqmp_pm_read_ggs(u32 index, u32 *value);
 int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
+int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -482,6 +484,10 @@ static inline int zynqmp_pm_read_pggs(u32 index, u32 *value)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

