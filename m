Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E09C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E96321D79
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GiE5I5cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgDXU71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:59:27 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:23104
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgDXU6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs3hnA8100CaxQnZaJWxIuiWWn5xxTPCJWeqKH9qHG+qR2jStSZ1hD2uRafLVQ3BqJIz3foc5AhbdfxAfQCVeOeT+7oLJUvkOAZ9j2BOMpJI+ffH0MbAuIjBfVw6tVmoc/dDNIr4X72W2HszqH+/7k9F6tmH2birZAdtEseIUJDYZ//qVIa3lR1x1WeHS332frinrHBhQiuvJJfEnYwkuOT1W8F003KGTBwkYPzGM/alEMDwTOif60L05l8blZPQHCz1YTSyrxYKExQ2i6lqz7U/WitkvpjakcxjetBrUcaikz4JIttNUHIt698UwYwhcTz0wvkb/o5uVmiBQ3WNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYMpy/m/kT2XAeV+FuLIblvsW8H16frR16o5kpPnYbw=;
 b=jHKRm47EU4yZPqAjeN3zFz6l5TBjxJ8+JIdY+opn8EENp+M5RqpXMcTJ0Q2cAWtSEa7cWvN4T8uDQySoVY/hX8KMqPKp/arCef+XF+3JE/ONmkhYhQOl6Vhq7heZMkcIRI3PRDk54tGui6OGOm9cxJnIdYfGt6HaSr0nH+xQWxg5cO0a8l09+9nU+82OaxPLxnVQXR7dOHYP68+nvbC4XLAp5nsD0nMwQLkgxSCTU6NHsy+06M30opMplbUX3tDrGhYuV/HPhlJRFzC1LgBGtpRxNDinAgg0m3rEqj4YdBgxHmvQIg7FQNGckXXwNS1SJ7ronIUEHiGpRvlzIjzl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYMpy/m/kT2XAeV+FuLIblvsW8H16frR16o5kpPnYbw=;
 b=GiE5I5cmxpJ8H/C1Ptg4e6GCGnSFTHHXN3gsk95bkcHBjbmzhyOXOHEfa7TLujmIkC6mqPkopYPr08YKbCri8mckJzaanzQG3day/XSI/gZbGVQKGU6uMeAbmsNTDPKtjSB0lzV3O1y/tsCu44ViEyroM44ssekHQE1gfGEbZTU=
Received: from SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) by SN6PR02MB4717.namprd02.prod.outlook.com
 (2603:10b6:805:8f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 20:58:32 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::dc) by SN6PR2101CA0019.outlook.office365.com
 (2603:10b6:805:106::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2 via Frontend
 Transport; Fri, 24 Apr 2020 20:58:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:32
 +0000
Received: from [149.199.38.66] (port=33396 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Nx-0002DR-3v; Fri, 24 Apr 2020 13:57:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5P6-0007Pe-3N; Fri, 24 Apr 2020 13:58:32 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwKmT026353;
        Fri, 24 Apr 2020 13:58:20 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ou-0007Lo-8a; Fri, 24 Apr 2020 13:58:20 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 25/25] firmware: xilinx: Add sysfs and API to set boot health status
Date:   Fri, 24 Apr 2020 13:58:07 -0700
Message-Id: <1587761887-4279-26-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
References: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(107886003)(2906002)(336012)(186003)(426003)(81166007)(356005)(2616005)(47076004)(82310400002)(70206006)(70586007)(44832011)(26005)(7696005)(8936002)(82740400003)(6666004)(36756003)(316002)(7416002)(9786002)(54906003)(81156014)(8676002)(4326008)(6636002)(478600001)(5660300002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4620a28a-ac8b-4bba-65bf-08d7e8923f80
X-MS-TrafficTypeDiagnostic: SN6PR02MB4717:
X-Microsoft-Antispam-PRVS: <SN6PR02MB47176391287728525743D7F6B8D00@SN6PR02MB4717.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBIGI+yyV3Af9CHlRHzx3HfBPSempGH3GNnKMFuEv6l7XabRMyNMPASUn0xv6r+7LYeAZD3R5LJY9m/Gu8Ubp3o+7Z+JhuZtEfAzIRMATIwiY6yoVszCr1WjBW+V7q8DswyeKmYeU5s3MmTWTgp5uULqRy8TPehvljDSH29h8fWbZ6OgYi4X7CAB+hKFkLgxETi8ON3hrmtRKax8OLKrx8umzMT84TuSs00KUDcXFbPF164kjEQ7jQ9+z+++9Ghgq43Jp5CKmIg0DnMfL+17u6pUKLWTUkRWXTPKVD3ex+JVSyH3iZpsl1pjd6RyeDsLgTKPs5l0igwffTV+o1biteTThi68ctx0fQ0UH7qlmOD4XLtmGfz4XUa5Lj3Dlg3PHoADwL9NUzB9wUoiOyKjjdUYP+OpQL6CHEBGnldclImW0B4Cgte6Fz6aynv2YS97h1SK/VVknswgjF4ON2pYbasRS6PbWoChWYVNTy1e79NY45/ptjBFJXMJncCoLjMkybU94Y6wcG4afTkXq4zlhA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:32.4303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4620a28a-ac8b-4bba-65bf-08d7e8923f80
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add sysfs interface to set boot health status from user space.
Add API used by this interface to communicate with firmware.

If PMUFW is compiled with CHECK_HEALTHY_BOOT, it will check the
healthy bit on FPD WDT expiration. If healthy bit is set by a user
application running in Linux, PMUFW will do APU only restart. If
healthy bit is not set during FPD WDT expiration, PMUFW will do
system restart.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp        | 21 ++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   | 39 ++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  7 ++++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
index 554f30c..00fa04c 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -80,3 +80,24 @@ Description:
 		# echo "subsystem" > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
 
 Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/health_status
+Date:		March 2020
+KernelVersion:	5.6
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		This sysfs interface allows to set the health status. If PMUFW
+		is compiled with CHECK_HEALTHY_BOOT, it will check the healthy
+		bit on FPD WDT expiration. If healthy bit is set by a user
+		application running in Linux, PMUFW will do APU only restart. If
+		healthy bit is not set during FPD WDT expiration, PMUFW will do
+		system restart.
+
+		Usage:
+		Set healthy bit
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
+
+		Unset healthy bit
+		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8d36618..bfaf29a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -684,6 +684,21 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
 /**
+ * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
+ * @value	Status value to be written
+ *
+ * This function sets healthy bit value to indicate boot health status
+ * to firmware.
+ *
+ * @return      Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_boot_health_status(u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS,
+				   value, 0, NULL);
+}
+
+/**
  * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
  * @reset:		Reset to be configured
  * @assert_flag:	Flag stating should reset be asserted (1) or
@@ -984,6 +999,29 @@ static ssize_t shutdown_scope_store(struct device *device,
 
 static DEVICE_ATTR_RW(shutdown_scope);
 
+static ssize_t health_status_store(struct device *device,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int ret;
+	unsigned int value;
+
+	ret = kstrtouint(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	ret = zynqmp_pm_set_boot_health_status(value);
+	if (ret) {
+		dev_err(device, "unable to set healthy bit value to %u\n",
+			value);
+		return ret;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(health_status);
+
 static ssize_t ggs_show(struct device *device,
 			struct device_attribute *attr,
 			char *buf,
@@ -1143,6 +1181,7 @@ static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_pggs2.attr,
 	&dev_attr_pggs3.attr,
 	&dev_attr_shutdown_scope.attr,
+	&dev_attr_health_status.attr,
 	NULL,
 };
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index c297333..5968df8 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -114,6 +114,8 @@ enum pm_ioctl_id {
 	IOCTL_READ_GGS = 13,
 	IOCTL_WRITE_PGGS = 14,
 	IOCTL_READ_PGGS = 15,
+	/* Set healthy bit value */
+	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
 };
 
 enum pm_query_id {
@@ -354,6 +356,7 @@ int zynqmp_pm_read_ggs(u32 index, u32 *value);
 int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
+int zynqmp_pm_set_boot_health_status(u32 value);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -500,6 +503,10 @@ static inline int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_set_boot_health_status(u32 value)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

