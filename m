Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5274C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A77206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="i/eFrLI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCFXtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:06 -0500
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:6019
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbgCFXsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dADUdlZDFnfM57UPKmt8fQNjOMXI88XW6n5wsW2Gb6bEjeB9AXepTbApQJ5TztxeAl29OtWytXQP1cjjaS7+ZxAz0zk5Aq82qt5Ln0yIjr8McRO3zMLJd0Evkn5+cpfRpPN22e/D+NWTA9SunTi6ap1yRvAbWjl2x9F0e5kVmaGA2SB6xU4vqJOz6XWbMyYNhjQKWgj/nZ/9Fx/HEcMKWPNpXQVs3y9k09akqxYM0BoRGKx3issG3YCZWUG4P4soc2AGYIMktJoKFF9mlKgrag2ZuQxKW8BdphMQJ9NBwCkH7iv4JOOm8p3I9EMB3Pcm09MyXRw1C7vxehSCHueCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRGEhLru2qbJkPaZbYnydkIWA9EZTA0fNm6DB8AvTsQ=;
 b=klsH74nTzvgumnWKXySmP0dANt81qCrnZ/Gkne7eMwTRd/+FXE50+btv/uKZUxG6GUSkpIHGXuySZ8KK0GiwuLpulPCirjR6lWouuqzdj7Imllcu//05MK9k2qnRMXgNKQy+E3I8r4xeTOZE7X1LNn2qVcKiNe33IfAW/satoGHInLErcTQYZXDLjufSO3tWHXa0xBtCrmswyEZyDBvesPeQcJqQ0F6itdfSDBRtwZ4REqEtZ6adxq3o4O6AZVLy3tPRcfhxXNRjZiSz3zsAbdI4TQv/uNkk4cPwlSvfWSTjg931HP4ec3q7V2Gs2Wuqtto3IB6Lq8y9yTKVuyBEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=aggios.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRGEhLru2qbJkPaZbYnydkIWA9EZTA0fNm6DB8AvTsQ=;
 b=i/eFrLI9nSDIrIQHxJiE6pw9HKcQuF33UkANi5SXmZ8/SFHf/BhZQg7OmnSrCpDa+amULNo5H/FiDWwStEm1Kuks569WxenyyL6aMbGid0HMn6nZe+GFR/vjfWmGYAY+R7ECzRlBV1R8zuiHswIlBRpkFf3/Q+S/fxgsPX64aY0=
Received: from BL0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:207:3c::21)
 by CH2PR02MB6919.namprd02.prod.outlook.com (2603:10b6:610:82::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 6 Mar
 2020 23:47:57 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::a1) by BL0PR02CA0008.outlook.office365.com
 (2603:10b6:207:3c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; aggios.com; dkim=none (message not signed)
 header.d=none;aggios.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhA-0003Pz-Rv; Fri, 06 Mar 2020 15:47:56 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh5-0002g8-Ov; Fri, 06 Mar 2020 15:47:51 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026NlloY002432;
        Fri, 6 Mar 2020 15:47:47 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh1-0002eg-0g; Fri, 06 Mar 2020 15:47:47 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Stefan Krsmanovic <stefan.krsmanovic@aggios.com>,
        Jolly Shah <jollys@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 23/24] firmware: xilinx: Add sysfs to set shutdown scope
Date:   Fri,  6 Mar 2020 15:47:31 -0800
Message-Id: <1583538452-1992-24-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(4326008)(5660300002)(2906002)(107886003)(36756003)(478600001)(316002)(6666004)(356004)(54906003)(81166006)(81156014)(8676002)(9786002)(6636002)(7696005)(70586007)(2616005)(70206006)(7416002)(8936002)(336012)(426003)(186003)(26005)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6919;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a1c622f-d939-4980-1633-08d7c228cc39
X-MS-TrafficTypeDiagnostic: CH2PR02MB6919:
X-Microsoft-Antispam-PRVS: <CH2PR02MB69191F4D76CF3A1049C7976DB8E30@CH2PR02MB6919.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lasrMdreFeckn6udklNUg4UzyIu9Uw8la6bbpfT4ngDKIWM1IR67mqn2Y/uy1lHCtTYJtcYzFTcbD8PXcHk/DtIGH3aYcocpbAQEoTTo92e2lUDnI56cxKGVyBXbJZj8jiAKr/HoBZoyS+iH8KXYOff49CkwN2Eg2mie9fivVgnqsvI8NgyjgsONw0mYAQo9k3QruXsoajM1XoUBVLODTYPjYBNiHCz5NNLFtMJfEMo5pPm6K59xk3DXrJFkKbdoPY5DwbG/VyRFXCooGs9YO5qFrVBVCyQ0U7EwyYUg30a+SO36p1Xg6aUx/Ihgn6YChYATpESVK7cuCdjDAbklyhfHOCtpNGUkHp0q2wKEioVbxt30D8lhAwywGGZ76eEGyv0v+i+paruH/B8NIMaJPFZ8TS4+R2L7NxGJWeirtAJ+bfVTJ/fa78ztmAOH9Ze
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:57.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1c622f-d939-4980-1633-08d7c228cc39
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

The Linux shutdown functionality implemented via PSCI system_off does
not include an option to set a scope, i.e. which parts of the system to
shut down.

This patch creates sysfs that allows to set the shutdown scope for the
next shutdown request. When the next shutdown is performed, the platform
specific portion of PSCI-system_off can use the chosen shutdown scope.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Stefan Krsmanovic <stefan.krsmanovic@aggios.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp        |  32 +++++
 drivers/firmware/xilinx/zynqmp.c                   | 150 ++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h               |  12 ++
 3 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
index 7fd6e70..b46ec0c 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -48,3 +48,35 @@ Description:
 		# echo 0xFFFFFFFF 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
 
 Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
+Date:		March 2020
+KernelVersion:	5.6
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		This sysfs interface allows to set the shutdown scope for the
+		next shutdown request. When the next shutdown is performed, the
+		platform specific portion of PSCI-system_off can use the chosen
+		shutdown scope.
+
+		Following are available shutdown scopes(subtypes):
+
+		subsystem:	Only the APU along with all of its peripherals
+				not used by other processing units will be
+				shut down. This may result in the FPD power
+				domain being shut down provided that no other
+				processing unit uses FPD peripherals or DRAM.
+		ps_only:	The complete PS will be shut down, including the
+				RPU, PMU, etc.  Only the PL domain (FPGA)
+				remains untouched.
+		system:		The complete system/device is shut down.
+
+		Usage:
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
+		# echo <scope> > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
+
+		Example:
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
+		# echo "subsystem" > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d3f637b..9caf1cf 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -847,6 +847,154 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 }
 
 /**
+ * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
+ * @subtype:	Shutdown subtype
+ * @name:	Matching string for scope argument
+ *
+ * This struct encapsulates mapping between shutdown scope ID and string.
+ */
+struct zynqmp_pm_shutdown_scope {
+	const enum zynqmp_pm_shutdown_subtype subtype;
+	const char *name;
+};
+
+static struct zynqmp_pm_shutdown_scope shutdown_scopes[] = {
+	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM] = {
+		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM,
+		.name = "subsystem",
+	},
+	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY] = {
+		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY,
+		.name = "ps_only",
+	},
+	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM] = {
+		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM,
+		.name = "system",
+	},
+};
+
+static struct zynqmp_pm_shutdown_scope *selected_scope =
+		&shutdown_scopes[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM];
+
+/**
+ * zynqmp_pm_is_shutdown_scope_valid - Check if shutdown scope string is valid
+ * @scope_string:	Shutdown scope string
+ *
+ * Return:		Return pointer to matching shutdown scope struct from
+ *			array of available options in system if string is valid,
+ *			otherwise returns NULL.
+ */
+static struct zynqmp_pm_shutdown_scope*
+		zynqmp_pm_is_shutdown_scope_valid(const char *scope_string)
+{
+	int count;
+
+	for (count = 0; count < ARRAY_SIZE(shutdown_scopes); count++)
+		if (sysfs_streq(scope_string, shutdown_scopes[count].name))
+			return &shutdown_scopes[count];
+
+	return NULL;
+}
+
+/**
+ * shutdown_scope_show - Show shutdown_scope sysfs attribute
+ * @device:	Device structure
+ * @attr:	Device attribute structure
+ * @buf:	Requested available shutdown_scope attributes string
+ *
+ * User-space interface for viewing the available scope options for system
+ * shutdown. Scope option for next shutdown call is marked with [].
+ *
+ * Usage: cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
+ *
+ * Return:	Number of bytes printed into the buffer.
+ */
+static ssize_t shutdown_scope_show(struct device *device,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(shutdown_scopes); i++) {
+		if (&shutdown_scopes[i] == selected_scope) {
+			strcat(buf, "[");
+			strcat(buf, shutdown_scopes[i].name);
+			strcat(buf, "]");
+		} else {
+			strcat(buf, shutdown_scopes[i].name);
+		}
+		strcat(buf, " ");
+	}
+	strcat(buf, "\n");
+
+	return strlen(buf);
+}
+
+/**
+ * shutdown_scope_store - Store shutdown_scope sysfs attribute
+ * @device:	Device structure
+ * @attr:	Device attribute structure
+ * @buf:	User entered shutdown_scope attribute string
+ * @count:	Buffer size
+ *
+ * User-space interface for setting the scope for the next system shutdown.
+ * Usage: echo <scope> > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
+ *
+ * The Linux shutdown functionality implemented via PSCI system_off does not
+ * include an option to set a scope, i.e. which parts of the system to shut
+ * down.
+ *
+ * This API function allows to set the shutdown scope for the next shutdown
+ * request by passing it to the ATF running in EL3. When the next shutdown
+ * is performed, the platform specific portion of PSCI-system_off can use
+ * the chosen shutdown scope.
+ *
+ * subsystem:	Only the APU along with all of its peripherals not used by other
+ *		processing units will be shut down. This may result in the FPD
+ *		power domain being shut down provided that no other processing
+ *		unit uses FPD peripherals or DRAM.
+ * ps_only:	The complete PS will be shut down, including the RPU, PMU, etc.
+ *		Only the PL domain (FPGA) remains untouched.
+ * system:	The complete system/device is shut down.
+ *
+ * Return:	count argument if request succeeds, the corresponding error
+ *		code otherwise
+ */
+static ssize_t shutdown_scope_store(struct device *device,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int ret;
+	struct zynqmp_pm_shutdown_scope *scope;
+
+	scope = zynqmp_pm_is_shutdown_scope_valid(buf);
+	if (!scope)
+		return -EINVAL;
+
+	ret = zynqmp_pm_system_shutdown(ZYNQMP_PM_SHUTDOWN_TYPE_SETSCOPE_ONLY,
+					scope->subtype);
+	if (ret) {
+		pr_err("unable to set shutdown scope %s\n", buf);
+		return ret;
+	}
+
+	selected_scope = scope;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(shutdown_scope);
+
+static struct attribute *zynqmp_shutdown_scope_attrs[] = {
+	&dev_attr_shutdown_scope.attr,
+	NULL,
+};
+
+static const struct attribute_group shutdown_scope_attribute_group = {
+	.attrs = zynqmp_shutdown_scope_attrs,
+};
+
+/**
  * ggs_show - Show global general storage (ggs) sysfs attribute
  * @device: Device structure
  * @attr: Device attribute structure
@@ -955,7 +1103,6 @@ static ssize_t ggs_store(struct device *device,
 	ret = zynqmp_pm_write_ggs(reg, value);
 	if (ret)
 		count = -EFAULT;
-
 err:
 	kfree(kern_buff);
 
@@ -1159,6 +1306,7 @@ static const struct attribute_group ggs_attribute_group = {
 
 const struct attribute_group *firmware_attribute_groups[] = {
 	&ggs_attribute_group,
+	&shutdown_scope_attribute_group,
 	NULL,
 };
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 13b9fdb..31ed58c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -280,6 +280,18 @@ enum tap_delay_type {
 	PM_TAPDELAY_OUTPUT,
 };
 
+enum zynqmp_pm_shutdown_type {
+	ZYNQMP_PM_SHUTDOWN_TYPE_SHUTDOWN,
+	ZYNQMP_PM_SHUTDOWN_TYPE_RESET,
+	ZYNQMP_PM_SHUTDOWN_TYPE_SETSCOPE_ONLY,
+};
+
+enum zynqmp_pm_shutdown_subtype {
+	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM,
+	ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY,
+	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.7.4

