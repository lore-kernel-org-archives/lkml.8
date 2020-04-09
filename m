Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0CC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE18206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hC7qGK+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDITNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:13:16 -0400
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:60864
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbgDITNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:13:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhVdk8BVwqGdA+HiXqgL8xKJfKHx1Z59CEtKPURiTNv6xrtDeOtS+u8MC4J08pDPqiMIcYYJnVCKjrHEJsUwjrFyVK7gyXjOeYGa4Eg1oXS8zuIoH9UWKXaQcA92AF9AojpqhkuAXiwKbFv++y/1W6pBK0E58UCvjxE55Vq6dLbHxfYsAJ3v8yj7ivLxthhIVAmMVUnvWlC7QvBWwjskdTr1ragKa6xc6f1/Lm9IL/30Bfw1npHJbJ/BwzHzqPN2TqxRB2Rs7NtJ0zL2Lke8ECROlM+CbrVrNIxCaM3IxqkJgIlooamj8aJUyP/Q3ejD4zkhbYSZ0eHDWYXogLW9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zYd+PdfJZ+DlAsLw2nYnCZox51wYur3HUdv1Q+qJEc=;
 b=YTB8XMnq8yWIxMPY4tCPFW/zcYC5c5m1JdAbHv2/hSMJs/xAuXaT8FgGdCchHLl5xsp1zzbFWq0Cx/dor/ejRo0AUAPjJuZUWEsE61sY5Tnf9+zJ4wd5gZpPKw17P+3Lk+pGgaWOrWejUbH8r+E6H1k1eiSG+7nY8KRs9ZCWeiF2LCJPD9ZZR7rwIwGwAJrC+Msa+ebDqcuFLr5ErrLHyo+BBXfTMtsRbxFtoJPZRjhs28lHpw1RDlgrpy7ZyPb+/DVmN4Y/gE0hFEVlWyEH06wTDPEkWIPcuczXsthKxi4AmES1qgx5TqVIROV6O4F1LLn6UjjFTHI5HtkCmQ6NKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zYd+PdfJZ+DlAsLw2nYnCZox51wYur3HUdv1Q+qJEc=;
 b=hC7qGK+4bpSU+qxsGMCRyXiy+/p6KcXgXV1tnjROJue03vRS9hsiQrHLHU9L5fYTm4vACm9193FANMoGAzWjiWMdLAxoWYIUnMVZ6H8q78tP3pvOUcIQEMVEgKuZ8yP/OZW/8RH5ulMyept7nYzTDKEStDrgcAZ4ooahtjM/ufM=
Received: from SN4PR0501CA0084.namprd05.prod.outlook.com
 (2603:10b6:803:22::22) by CY4PR0201MB3570.namprd02.prod.outlook.com
 (2603:10b6:910:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 9 Apr
 2020 19:12:51 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:22:cafe::c2) by SN4PR0501CA0084.outlook.office365.com
 (2603:10b6:803:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44330 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcb9-00060Z-Lr; Thu, 09 Apr 2020 12:12:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcba-0007NV-4Q; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-KQ; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 15/25] firmware: xilinx: Remove eemi ops for set_suspend_mode
Date:   Thu,  9 Apr 2020 12:12:04 -0700
Message-Id: <1586459534-8997-16-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966005)(7696005)(4326008)(81156014)(47076004)(6666004)(356004)(70206006)(426003)(478600001)(44832011)(54906003)(7416002)(82740400003)(6636002)(70586007)(81166007)(107886003)(186003)(316002)(5660300002)(8936002)(8676002)(9786002)(2616005)(336012)(26005)(2906002)(36756003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8cfb223-2c47-4dd3-e486-08d7dcb9ff38
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3570:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3570446CFD66ABE0AA4E3F17B8C10@CY4PR0201MB3570.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oimK77UJ54iKO3zvMa5LYMpeHJPdgNmB/AOMQSnbskuzov31ZLW0By/nXwwlZKDbQTS1wYLNLy8vDhKfAXsHgFtErHLZBB8lAVa7EKIA8q/Eh0FTd5Y798lR36fkYDkFrGHVEV4Md1I35jKqwTO7ecpALvRqwxjA+XkmtsOVVsfILuOiEjIbngHZvkDZRPTZad2yOqn344zk5/8i7CbnnnwY+ygdN+Vb+rvNLtZ4ID5oZXGK0AqISdk+Z6B4Ns8Ce+7qjVBRmxxrMta37mz1TJmVCb7nslFteb9KfwfjfGq136BWoFwI9bk5sFfG0LPPGBafkIhOzrOP2JlB5ksA3g9v0pEITuHMpAX5SZgaf/sC0UCtNgy9YqIq4o9/3/UrdiEVA0By2OpasLy6BMWApgEShki/mtWaQLTeYz5f/5Vb8ysdZrMRkN2wHhyZMC7l8DgUfVi5pkUJrCCcSjqRtJpGVnN55qJDIRs9qMzWrL85Y2mMP+oDJYhPXdvz831rZLHlizc7WxovlrYpYGOYCg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.5043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cfb223-2c47-4dd3-e486-08d7dcb9ff38
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of eemi ops for set_suspend_mode.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 drivers/soc/xilinx/zynqmp_power.c    | 6 +-----
 include/linux/firmware/xlnx-zynqmp.h | 6 +++++-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 869366f..cc74165 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -724,10 +724,11 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_set_suspend_mode(u32 mode)
+int zynqmp_pm_set_suspend_mode(u32 mode)
 {
 	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
 
 /**
  * zynqmp_pm_request_node() - Request a node with specific capabilities
@@ -809,7 +810,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
 	.set_requirement = zynqmp_pm_set_requirement,
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index f4a9371..31ff49f 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -30,7 +30,6 @@ struct zynqmp_pm_work_struct {
 
 static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
 static struct mbox_chan *rx_chan;
-static const struct zynqmp_eemi_ops *eemi_ops;
 
 enum pm_suspend_mode {
 	PM_SUSPEND_MODE_FIRST = 0,
@@ -155,9 +154,6 @@ static ssize_t suspend_mode_store(struct device *dev,
 {
 	int md, ret = -EINVAL;
 
-	if (!eemi_ops->set_suspend_mode)
-		return ret;
-
 	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
 		if (suspend_modes[md] &&
 		    sysfs_streq(suspend_modes[md], buf)) {
@@ -166,7 +162,7 @@ static ssize_t suspend_mode_store(struct device *dev,
 		}
 
 	if (!ret && md != suspend_mode) {
-		ret = eemi_ops->set_suspend_mode(md);
+		ret = zynqmp_pm_set_suspend_mode(md);
 		if (likely(!ret))
 			suspend_mode = md;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9aa5fe8..761caed 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*set_suspend_mode)(u32 mode);
 	int (*request_node)(const u32 node,
 			    const u32 capabilities,
 			    const u32 qos,
@@ -336,6 +335,7 @@ int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag);
 int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
 int zynqmp_pm_init_finalize(void);
+int zynqmp_pm_set_suspend_mode(u32 mode);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -428,6 +428,10 @@ static inline int zynqmp_pm_init_finalize(void)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

