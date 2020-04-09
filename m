Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B830C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F040206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lGnit14v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDITNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:13:24 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:13779
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgDITM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElGWHadgKf5a7SDkfnnMKLAX1idqrzJzRKSqdmP0tJF/lBBr+ttQjTvJfu0ssIByOwZvKi66DgJfCmpCBJMk9l2sB1C1xCib0yiGBxn5Rg5XKgTDkYqui+YszmiCzWDbnVEXJdSlg+AMZg8nB39eznMiXjljJ1pPcVdT25c4KGifa/VLdYV1IOUo72w+q8ofByj36WlTzvW3k7E7p7up0s/jBurQWy9UC9VvXPLpRIKJ0Y5GwtY1K3x3IisHSRlKz0m0zU4aY0BujhHGd015MJwdGOqg0yjpOo6kA5UOVGTHgDqY3F4SghVD3c8MQkn3a04fNiKHvfZl7uoUlSxAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtkfAb+OctstBJIdILKS1FBwP2Cp3vedcBC+0xJGhUE=;
 b=cfniobyZlttjFvV/4mqwVKl2psNH6hNqbpalr3gbYQZUSfarL/JBthvqjFGc9mlb9Hb+PQcrC4lNH81SjxQIB9U44CRw6mSUCFGoBDc9k7cCpQc9v0J3iS8XRGGZYnFy2od2qMd6n6tQfqrv6mGlRpG/Anv79/uzMKqTwSwvwtWnpRzSAL4d0V9ZN2ZGfUHGja/1yUAs0xAjPrYO6JAagNz5mnLivjepsH38uqRiB29g/ZAuXYtsVlr1ic1ozk/sFhFjmtxzz5QX5NZcir9Yvlh7FM5+SyCR0MEENJRxQLVCRCcBYzNvT6khmhDRomDIvdFGmfnMsUfZKg7S6Wv4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtkfAb+OctstBJIdILKS1FBwP2Cp3vedcBC+0xJGhUE=;
 b=lGnit14vCdZf7Eg6wNeSwLh3Km9PRY0iI9YGyQFp6nX9q88kXSCGlP4ixaMxTc5ftYLf518MqZIh+5cmmaOQefvUyXfuKvx/SlTvqg2H8vxRtAlg7/okvOuVo6MoGSqeSJj9bCme2OMAdwD0QC7Hk3gd8p/JFMIbmmj3wQ4lmN8=
Received: from MN2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:208:23e::21)
 by SN6PR02MB5342.namprd02.prod.outlook.com (2603:10b6:805:74::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 19:12:50 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::e5) by MN2PR14CA0016.outlook.office365.com
 (2603:10b6:208:23e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44311 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcb9-00060J-D7; Thu, 09 Apr 2020 12:12:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbZ-0007NV-Rp; Thu, 09 Apr 2020 12:12:49 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbT-0007La-ED; Thu, 09 Apr 2020 12:12:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Stefan Krsmanovic <stefan.krsmanovic@aggios.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 24/25] firmware: xilinx: Add sysfs to set shutdown scope
Date:   Thu,  9 Apr 2020 12:12:13 -0700
Message-Id: <1586459534-8997-25-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(46966005)(186003)(70586007)(36756003)(26005)(8936002)(9786002)(81156014)(81166007)(70206006)(4326008)(7696005)(498600001)(5660300002)(54906003)(8676002)(107886003)(7416002)(44832011)(2616005)(6636002)(2906002)(356004)(6666004)(47076004)(336012)(426003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bc3e54-a723-4e42-7e09-08d7dcb9ff17
X-MS-TrafficTypeDiagnostic: SN6PR02MB5342:
X-Microsoft-Antispam-PRVS: <SN6PR02MB53423C22E7C815B6D350B5F3B8C10@SN6PR02MB5342.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spfkOjKsCRjJ3KPONTci/YKDmf4I0pZDWOteQQxykvffaMHfC8MvC9WWLM79FULS6cVze2JYSGiNvNnXS74linS9AosGrSaXkB3KdGPecmrrLSBk94spxrC3Q/Z97KN60GpVRsCVPaEBXMff50lHE6cDYQDv2Dex5sfR9XoNASMC0eR2M5LqX2sZezVYae1cvs0RgxxaIeIdnAULECJ4s2ucsXXBUHOrdB3TiT0BRs/EeRXcDq4JoQB9vX1SxePdh7vfR+G+x5LUDBQ5Vo+KuVeP/yw8yeLtmwgW0rFYlxARrYXhOHFeexVf2OorG/V0eyo3Kcm2/1KElQpmhhLomoksgRX1J49dkTiQrXp0d+fD/8WtPRJHH8wd0qNs9lfHkDHnAuNhonjo/858oesOIBvj3Tu5AGjJbS7ng1H0nlZk2zyCUZqtb01t1CE0mhCFPWrYIKwbFcXScmmUy+2OJ6KAU2thcNFCfPDMJBnIgF9xlBMvhDKXdd400XbmEW0mgbnRyPgJgIPFxXNycN2tIA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.2839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bc3e54-a723-4e42-7e09-08d7dcb9ff17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5342
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
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp        | 32 +++++++
 drivers/firmware/xilinx/zynqmp.c                   | 98 +++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h               | 12 +++
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
index 2e3aebd..554f30c 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -48,3 +48,35 @@ Description:
 		# echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
 
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
index 9ba376c..8d36618 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -888,6 +888,102 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 				   0, 0, NULL);
 }
 
+/**
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
 static ssize_t ggs_show(struct device *device,
 			struct device_attribute *attr,
 			char *buf,
@@ -923,7 +1019,6 @@ static ssize_t ggs_store(struct device *device,
 	ret = zynqmp_pm_write_ggs(reg, value);
 	if (ret)
 		count = -EFAULT;
-
 err:
 	return count;
 }
@@ -1047,6 +1142,7 @@ static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_pggs1.attr,
 	&dev_attr_pggs2.attr,
 	&dev_attr_pggs3.attr,
+	&dev_attr_shutdown_scope.attr,
 	NULL,
 };
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2254c7c..c297333 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -286,6 +286,18 @@ enum dll_reset_type {
 	PM_DLL_RESET_PULSE,
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

