Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C373C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64C206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Oyv9fYBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDITNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:13:04 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:17935
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbgDITMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F786lz5YDBn91ogJwElS1mzJT05yEihYKMs7shzpbJ8GC45BpFjSdvW2x5w35zk3pGVGbd4oHYjHO77gyLV9cYhZi/57cTwMtVny2Zxi/kqcvsAp1YfylHedl5NltnG29JWc9TfPLWawqO9MaKFSI82ghjxALFc8fzo6emWj4Egmu/ZAgLnw2ataV0j1NCY1tL8nCEG43zfH3tpt3B5nss/i/dNF3PV6T+hGF6Uf/5SaRlz3SnfGVG/kW7INbpzEbi5iWKB5gTZHkml6AMgxN9qt8j1+nB9Ww/Jb5g+RU5KhEY3x2LoW74ld1JoDB1icZtHRUfEFfRsn+RvNWwTZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYMpy/m/kT2XAeV+FuLIblvsW8H16frR16o5kpPnYbw=;
 b=L+KhDkPhZBq5wP9EpXQ0NQXdn7Vox6Pu2JNgPL3R0D8bvPX+EH1s7aBMDgMnVFgFlxIXycYUWH1KWkCeqv3ZnMtfh2r7bAXIRhDTIuNzfh1gXRbvB5yVGBlMTDhV0W3+OU2TXO152ynclrqyhVnazq7XtlDDxXUxP7f56xImbbUYJSrK7alEtQkXhd+hVEUY0HMuYCM+kffGuPnSHXnVlOINll8s5M8xDJbvq8Z6LoI1SmIYGQfTjvoc05wOK2IgKrQ9YoMa8nidHB9uKW3L7l3+2zL8CFvnNHvtfaTUr5rmOoKPWxLzhVHf5eEoga+4H8NWla8kXl2Az4ZPgrKzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYMpy/m/kT2XAeV+FuLIblvsW8H16frR16o5kpPnYbw=;
 b=Oyv9fYBq3hlnP8bDe8pSLiTU5X7BbIouqEMU3hvO6xmNVwy+oQJIG+s7kkyWrCpHJQgNcxtaVFccOvgO0z7MyAnoJE7iePjvofiuinxdjfrnvj9MQKutodo+SksLaLWhPlTa1P0K2zKd2ZSjKMjNKi/lX1lbga3bHbzM8CARenQ=
Received: from MN2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:208:134::29)
 by BN6PR02MB2404.namprd02.prod.outlook.com (2603:10b6:404:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 19:12:50 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::3f) by MN2PR16CA0016.outlook.office365.com
 (2603:10b6:208:134::29) with Microsoft SMTP Server (version=TLS1_2,
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
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44302 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcb9-00060D-A9; Thu, 09 Apr 2020 12:12:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbZ-0007NV-Oj; Thu, 09 Apr 2020 12:12:49 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbT-0007La-GO; Thu, 09 Apr 2020 12:12:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 25/25] firmware: xilinx: Add sysfs and API to set boot health status
Date:   Thu,  9 Apr 2020 12:12:14 -0700
Message-Id: <1586459534-8997-26-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(26005)(186003)(6666004)(356004)(426003)(44832011)(7416002)(5660300002)(107886003)(336012)(2616005)(70206006)(70586007)(8936002)(81156014)(82740400003)(54906003)(9786002)(4326008)(36756003)(478600001)(7696005)(6636002)(8676002)(2906002)(316002)(81166007)(47076004);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb03e767-73af-4cee-57f2-08d7dcb9ff0f
X-MS-TrafficTypeDiagnostic: BN6PR02MB2404:
X-Microsoft-Antispam-PRVS: <BN6PR02MB24041E30811FAC3C76A14C1BB8C10@BN6PR02MB2404.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEcM9csIqACiZrObfXVOFrvlRK/CiWPkGxwU/2cucTqzvhBHaya9YAxr4+1C9aHZRbyrmfg/L+vOUSIelDKnyhaTIm1ju7ovc+gZoiXmvhrqAeYbsRkRgKSLzR0SaOU+ilUkC40hsn7rRsR6AOgnqa1kjUKCdVEB9Qtg2RvUkmPROx7xMM5geNLG8gczzVCmadfvx8nHyU0EoZV5KmMOq6yn531P38dOjGZ3o7EeXSeNfMqCNwQ4mFr4KjnQOGxTu2aUpQxHfIdEvhsRIb0wiEkU+9N/j6tib7zjyIik5Q8HQAGzqcZ9gEIu4uryWrUXD2N1ivZPC+3rFk4uCPOZP27wjV3IBMBBIu4Ahh9SJiDBXt1i27l+WwhgBzZksW0gXF7zs52KEiTUZ0qJPXt1ZMFW3seDisiJOVtBKLnfI2kVlaLlx0URtyT6L1TXunaKYbJ/Iw0WsEOKBqv1T+sUIPEt/M7+rb778ttqWY2jZ4lAxub/vVlakPK+OGdIZtxvC13PQs8ir+PtwO7RtpF/Yg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.2310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb03e767-73af-4cee-57f2-08d7dcb9ff0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2404
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

