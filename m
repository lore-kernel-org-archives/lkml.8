Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74C8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94828206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SJqHCgGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCFXt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:29 -0500
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:34145
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbgCFXsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCRIp0GH0BIB+/KmEvBOcEOpEByHUB4pPOPxQq25gOP0HDastXD9AgL7jGbzYwwOY8tP7cX+yLS9phqZ3XDaSnVRYKCfwXswPVUUOlKXUJzXVLfUjdXArSxPGdHFEbk6tsLjvAddlIytWLyO6cU8Lurig8D3tsAUjJXSxLHAP6X7UNq7iuKYw7SnQP/NPHT5iXBOtAVZCJ2e2bVKLIv/O9YCrq2LxO1SUC5T5qTYvKXS9x7UaY3/I28b8Lo0njqwFAfKivF1Q8m195+mQh34zmsgmufh4nWoFLr5AchbZM02FgjHlyvw3BK1GfslgWPO2oWmw7hK9mPaPqnhtAEyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0dJ8TYLdjOgrq0HqfeN6hjk+mNLBLnegGeUKLDMDrA=;
 b=ZtQnncQnQAYfq06YEli0uxMkxK59ijxraXn1xzuij1i3O4ws09rFVnA5gQk4JiId3Ebs7d54B89XIRZpXwaPRscJOgKB75MDr1tS5eawZ3ejLSWVby1Eh2OJcuu6w8HVignzATqIpOcJ+spfMO0wozHdjqHUu2Ldz7w4d+OQG2lZIQIDpSI5x3fE+wphL/JMr89bYEPK9G2cANSY6zPXcn7fQsWLUyY4JrIY6rFSaSDwPCuayMd4DlOfj9LZ83LfJMWlrJMP6fByczLU7yS0QB3h0MXcjLsx107JOe3Jgi86oKuHk3x6qDGXD+/dfPXxgerTcJz0hJ7A1ZqQSPLy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0dJ8TYLdjOgrq0HqfeN6hjk+mNLBLnegGeUKLDMDrA=;
 b=SJqHCgGMe7HuBldRWO6OHlpLHiD1lmJvYa5BjUNp45AQlGIQz86Lx8X9IeliGskWV/Tx+l4z8EZ4H+BEMPdaiN4SsaNA22M5Cas0NwkpI7uCRj3oQzjftl6ObpwbtI5qv44aCsY+WqI0kiSMaxYLhM4y+3E5SNUVEdprH7xNkhY=
Received: from SN6PR04CA0081.namprd04.prod.outlook.com (2603:10b6:805:f2::22)
 by BY5PR02MB6353.namprd02.prod.outlook.com (2603:10b6:a03:1fb::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 6 Mar
 2020 23:47:58 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::61) by SN6PR04CA0081.outlook.office365.com
 (2603:10b6:805:f2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhB-0003Q2-3D; Fri, 06 Mar 2020 15:47:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh6-0002g8-05; Fri, 06 Mar 2020 15:47:52 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026Nlk8Y001017;
        Fri, 6 Mar 2020 15:47:47 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh0-0002eg-QA; Fri, 06 Mar 2020 15:47:46 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 20/24] firmware: xilinx: Add APIs to read/write GGS/PGGS registers
Date:   Fri,  6 Mar 2020 15:47:28 -0800
Message-Id: <1583538452-1992-21-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(199004)(189003)(426003)(2906002)(54906003)(26005)(81156014)(81166006)(8676002)(6636002)(7696005)(356004)(44832011)(186003)(336012)(2616005)(9786002)(8936002)(6666004)(107886003)(4326008)(70586007)(70206006)(5660300002)(316002)(36756003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6353;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ec6f9eb-8ee9-4c0e-c22d-08d7c228cc7a
X-MS-TrafficTypeDiagnostic: BY5PR02MB6353:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6353A631FE67798CF52CF224B8E30@BY5PR02MB6353.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEKYSlb6n4GksizgMHxqvonzDDt0KieQjmp/xczYNT7Uc/OHa7SW3aZCHVixtrwZ5Q5F1JqQ4tDZ27xkBCOclyfkJxICbdeLT/I8i4gLFfR+zkSJ39bxiSCD8t3dtTTOUxLd3OrVey8alN1ERcddwiBco0oX3lPYbwrsl/tJE78R902piMOyv3wHDxA8Q5k5aIvgC181OhVMtQLB+YdD1aMyBdEXRHWqgp7tsTF+O1dnS2IPIpqFM9lBYv0pSyUzoJw+3z2BtSC8jY612mn/CZdJMTa8nbkVDmKDxf/1WpFmAm5gr5/58AtSdsRydqpvgFlz+hUEov9kcDmkPZr9REf4cO1Oe5Eh6G6XH4Auxkvv2jWpB053tLmijHb7cb3qIkn5XfMpuaGqGig5MHGq2is95vYAUty073CIRGqV68sAi2ghjoCWUtdSY/WpB02p
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:57.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec6f9eb-8ee9-4c0e-c22d-08d7c228cc7a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add APIs to read/write PGGS and GGS registers.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 66 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 +++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 36d5a3e..de99613 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -601,6 +601,72 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
 
 /**
+ * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
+ * @index	GGS register index
+ * @value	Register value to be written
+ *
+ * This function writes value to GGS register.
+ *
+ * @return      Returns status, either success or error+reason
+ */
+int zynqmp_pm_write_ggs(u32 index, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
+				   index, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
+
+/**
+ * zynqmp_pm_write_ggs() - PM API for reading global general storage (ggs)
+ * @index	GGS register index
+ * @value	Register value to be written
+ *
+ * This function returns GGS register value.
+ *
+ * @return      Returns status, either success or error+reason
+ */
+int zynqmp_pm_read_ggs(u32 index, u32 *value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
+				   index, 0, value);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
+
+/**
+ * zynqmp_pm_write_pggs() - PM API for writing persistent global general
+ *			     storage (pggs)
+ * @index	PGGS register index
+ * @value	Register value to be written
+ *
+ * This function writes value to PGGS register.
+ *
+ * @return      Returns status, either success or error+reason
+ */
+int zynqmp_pm_write_pggs(u32 index, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, value,
+				   NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
+
+/**
+ * zynqmp_pm_write_pggs() - PM API for reading persistent global general
+ *			     storage (pggs)
+ * @index	PGGS register index
+ * @value	Register value to be written
+ *
+ * This function returns PGGS register value.
+ *
+ * @return      Returns status, either success or error+reason
+ */
+int zynqmp_pm_read_pggs(u32 index, u32 *value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0,
+				   value);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
+
+/**
  * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
  * @reset:		Reset to be configured
  * @assert_flag:	Flag stating should reset be asserted (1) or
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1734d12..725dccf 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -105,6 +105,10 @@ enum pm_ioctl_id {
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
+	IOCTL_WRITE_GGS,
+	IOCTL_READ_GGS,
+	IOCTL_WRITE_PGGS,
+	IOCTL_READ_PGGS,
 };
 
 enum pm_query_id {
@@ -315,6 +319,10 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
+int zynqmp_pm_write_ggs(u32 index, u32 value);
+int zynqmp_pm_read_ggs(u32 index, u32 *value);
+int zynqmp_pm_write_pggs(u32 index, u32 value);
+int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.7.4

