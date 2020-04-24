Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E791C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2138D215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kB3Ed5a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDXU7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:59:01 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:48576
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgDXU6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHeKW3y+IwV03XznX/bZ3A26tfr7LoMruW3ON0wzUoC38FG9ONyZ7PsqWWegGy4cAe6xUfmLXgZlsgQ2u2zk3GZZOumVjuIqjsU5yomD7MnrMECDJGMZuNaCXnG+LgUzscujDHU53zJ6QESqE34d/5K1GiTxB9COYseRJe/9w0XiNk+i3iknSo01dxF+JcA1qPD9i/l1NQGzIkOWvYybsJPf3IlHKDglC70cf7N0wrmVO3EWikXNP4ixGvLKpZ5wz2ld2w6Wyw1oHDcXQfuHd78LuWQn7RPhfM7d571UWWnvbz7OnYsiItu5PSWLOYRnhyYaFWR9BGsmNptdFGQMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE9E4UqxZHPRPsIR6m5we0QgvAqlAAnOxx20TYuDZ5A=;
 b=mtGmPsbZ4N08hoXvPVOS7CY0tHobarmVI/0o8bvwaJoKOJ2w1YntxfMvKKoDQU0HU+rW5qSMAIrLipUqldBfqOQV4Iyi+oeYpGc6jQA2qZB0BHcy3c08BrYJOEcEMDKmkF4lHrAd8fXxcxwfAzAz8yns6X44+vov6/Lo2Lhzwo4IXSA8OpJhX2XC7qk7NNwsu9nGGAM6h2evfxB+a/8bdu4Hw6VsOoLMrltB8Q/LbNvN1cFfC+sUN8CE4gBy3z8qSSwcr5xRucei4AswYmw1ZRlyL37mvz9VlV6VgqedD5JeePqPn41IyYKqo5xUJafUS1hkqyxkWSGk8ZkmobKODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE9E4UqxZHPRPsIR6m5we0QgvAqlAAnOxx20TYuDZ5A=;
 b=kB3Ed5a4dK+uIq2gey81KEzTY6Mn4pt/jXOgoUcjHEDGtkUfLlLi0ha8hV13XEciGLWNxR7ZwwbDr+mWYdFgCNgg1dRPgNc4eNNScqHaKorqBEJ/vi558mJLxRJJLb/s3GHzqeOralLn5zpQrHUv+3LVeIc6koUqyaO2/GnV2i0=
Received: from CY4PR22CA0068.namprd22.prod.outlook.com (2603:10b6:903:ae::30)
 by BN7PR02MB4001.namprd02.prod.outlook.com (2603:10b6:406:f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 20:58:33 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ae:cafe::8a) by CY4PR22CA0068.outlook.office365.com
 (2603:10b6:903:ae::30) with Microsoft SMTP Server (version=TLS1_2,
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
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:33
 +0000
Received: from [149.199.38.66] (port=33466 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ny-0002Du-1y; Fri, 24 Apr 2020 13:57:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5P7-0007Pe-1J; Fri, 24 Apr 2020 13:58:33 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwKw6030401;
        Fri, 24 Apr 2020 13:58:20 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ou-0007Lo-18; Fri, 24 Apr 2020 13:58:20 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 22/25] firmware: xilinx: Add sysfs interface
Date:   Fri, 24 Apr 2020 13:58:04 -0700
Message-Id: <1587761887-4279-23-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
References: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966005)(4326008)(6636002)(26005)(54906003)(7696005)(5660300002)(316002)(186003)(44832011)(2616005)(36756003)(336012)(426003)(356005)(70206006)(107886003)(70586007)(478600001)(7416002)(9786002)(81156014)(47076004)(6666004)(8676002)(82310400002)(81166007)(8936002)(82740400003)(2906002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 379f6440-a152-4787-376f-08d7e892400a
X-MS-TrafficTypeDiagnostic: BN7PR02MB4001:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4001D9CFA8769C6E3CE9A9FAB8D00@BN7PR02MB4001.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6BW+zxCqjd9Sm6gZsVcaz7DhrhAvZDCMRu+R6h8pgvuzDy5iTjgB0sT2XE5ud4OgWektnK8RIK0w2cSfHTvCmK0bR9NoJ/qwzq1OebY0cpEIV6/vut3EbzxuYlWe/BcLjKk7ZSawV6m+jnVXup8oi+u2qrcFr9FKEYEAnkRRUjyHoZWqblHN3pXTJZZFVvCf6pQG9pknRN3cXzBRQ9AQX0vJHYQmCZzKVN5ltemWb6VJGKnHYovFs1G3JdhyMypT7vWs4vmTJi41HaO/uJTnHOi5OWfZyOPA0sXZvZVq58NU3B3XFCbdPHzSSaEe00n/+Cxoar+aNnBsvSG8Mb24aERu/mQ7L5iKHyV/zy785kh5vL6e6jpBVcEYdm8x45TrfhScNX1p/wx37X4Be2VhX0UpiRcnPAEF3c53vfhePQaDAgBMpicHzO0tvE5vGJqmtzAqnTtNT3wUDza4cFpAXgq6BldHqfLIMI7vNCUu6Lc96Bb0d9F2UWop26nuTuh
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:33.3345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379f6440-a152-4787-376f-08d7e892400a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add firmware-ggs sysfs interface which provides read/write
interface to global storage registers.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp        |  50 ++++++
 drivers/firmware/xilinx/zynqmp.c                   | 167 ++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h               |   2 +
 3 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-firmware-zynqmp

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
new file mode 100644
index 0000000..2e3aebd
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -0,0 +1,50 @@
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/ggs*
+Date:		March 2020
+KernelVersion:	5.6
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU global general storage register value,
+		GLOBAL_GEN_STORAGE{0:3}.
+		Global general storage register that can be used
+		by system to pass information between masters.
+
+		The register is reset during system or power-on
+		resets. Three registers are used by the FSBL and
+		other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
+
+		Usage:
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
+		# echo <value> > /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
+
+		Example:
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
+		# echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
+
+Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/pggs*
+Date:		March 2020
+KernelVersion:	5.6
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU persistent global general storage register
+		value, PERS_GLOB_GEN_STORAGE{0:3}.
+		Persistent global general storage register that
+		can be used by system to pass information between
+		masters.
+
+		This register is only reset by the power-on reset
+		and maintains its value through a system reset.
+		Four registers are used by the FSBL and other Xilinx
+		software products: PERS_GLOB_GEN_STORAGE{4:7}.
+		Register is reset only by a POR reset.
+
+		Usage:
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
+		# echo <value> > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
+
+		Example:
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
+		# echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 3518456..2fe4f57 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -2,7 +2,7 @@
 /*
  * Xilinx Zynq MPSoC Firmware layer
  *
- *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *  Copyright (C) 2014-2020 Xilinx, Inc.
  *
  *  Michal Simek <michal.simek@xilinx.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -875,6 +875,170 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
+static ssize_t ggs_show(struct device *device,
+			struct device_attribute *attr,
+			char *buf,
+			u32 reg)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	ret = zynqmp_pm_read_ggs(reg, ret_payload);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", ret_payload[1]);
+}
+
+static ssize_t ggs_store(struct device *device,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count,
+			 u32 reg)
+{
+	long value;
+	int ret;
+
+	if (reg >= GSS_NUM_REGS)
+		return -EINVAL;
+
+	ret = kstrtol(buf, 16, &value);
+	if (ret) {
+		count = -EFAULT;
+		goto err;
+	}
+
+	ret = zynqmp_pm_write_ggs(reg, value);
+	if (ret)
+		count = -EFAULT;
+
+err:
+	return count;
+}
+
+/* GGS register show functions */
+#define GGS0_SHOW(N)						\
+	ssize_t ggs##N##_show(struct device *device,		\
+			      struct device_attribute *attr,	\
+			      char *buf)			\
+	{							\
+		return ggs_show(device, attr, buf, N);		\
+	}
+
+static GGS0_SHOW(0);
+static GGS0_SHOW(1);
+static GGS0_SHOW(2);
+static GGS0_SHOW(3);
+
+/* GGS register store function */
+#define GGS0_STORE(N)						\
+	ssize_t ggs##N##_store(struct device *device,		\
+			       struct device_attribute *attr,	\
+			       const char *buf,			\
+			       size_t count)			\
+	{							\
+		return ggs_store(device, attr, buf, count, N);	\
+	}
+
+static GGS0_STORE(0);
+static GGS0_STORE(1);
+static GGS0_STORE(2);
+static GGS0_STORE(3);
+
+static ssize_t pggs_show(struct device *device,
+			 struct device_attribute *attr,
+			 char *buf,
+			 u32 reg)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	ret = zynqmp_pm_read_pggs(reg, ret_payload);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", ret_payload[1]);
+}
+
+static ssize_t pggs_store(struct device *device,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count,
+			  u32 reg)
+{
+	long value;
+	int ret;
+
+	if (reg >= GSS_NUM_REGS)
+		return -EINVAL;
+
+	ret = kstrtol(buf, 16, &value);
+	if (ret) {
+		count = -EFAULT;
+		goto err;
+	}
+
+	ret = zynqmp_pm_write_pggs(reg, value);
+	if (ret)
+		count = -EFAULT;
+
+err:
+	return count;
+}
+
+#define PGGS0_SHOW(N)						\
+	ssize_t pggs##N##_show(struct device *device,		\
+			       struct device_attribute *attr,	\
+			       char *buf)			\
+	{							\
+		return pggs_show(device, attr, buf, N);		\
+	}
+
+#define PGGS0_STORE(N)						\
+	ssize_t pggs##N##_store(struct device *device,		\
+				struct device_attribute *attr,	\
+				const char *buf,		\
+				size_t count)			\
+	{							\
+		return pggs_store(device, attr, buf, count, N);	\
+	}
+
+/* PGGS register show functions */
+static PGGS0_SHOW(0);
+static PGGS0_SHOW(1);
+static PGGS0_SHOW(2);
+static PGGS0_SHOW(3);
+
+/* PGGS register store functions */
+static PGGS0_STORE(0);
+static PGGS0_STORE(1);
+static PGGS0_STORE(2);
+static PGGS0_STORE(3);
+
+/* GGS register attributes */
+static DEVICE_ATTR_RW(ggs0);
+static DEVICE_ATTR_RW(ggs1);
+static DEVICE_ATTR_RW(ggs2);
+static DEVICE_ATTR_RW(ggs3);
+
+/* PGGS register attributes */
+static DEVICE_ATTR_RW(pggs0);
+static DEVICE_ATTR_RW(pggs1);
+static DEVICE_ATTR_RW(pggs2);
+static DEVICE_ATTR_RW(pggs3);
+
+static struct attribute *zynqmp_firmware_attrs[] = {
+	&dev_attr_ggs0.attr,
+	&dev_attr_ggs1.attr,
+	&dev_attr_ggs2.attr,
+	&dev_attr_ggs3.attr,
+	&dev_attr_pggs0.attr,
+	&dev_attr_pggs1.attr,
+	&dev_attr_pggs2.attr,
+	&dev_attr_pggs3.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(zynqmp_firmware);
+
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -952,6 +1116,7 @@ static struct platform_driver zynqmp_firmware_driver = {
 	.driver = {
 		.name = "zynqmp_firmware",
 		.of_match_table = zynqmp_firmware_of_match,
+		.dev_groups = zynqmp_firmware_groups,
 	},
 	.probe = zynqmp_firmware_probe,
 	.remove = zynqmp_firmware_remove,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e23251d..c1356e9 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -42,6 +42,8 @@
 
 #define ZYNQMP_PM_MAX_QOS		100U
 
+#define GSS_NUM_REGS	(4)
+
 /* Node capabilities */
 #define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
 #define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
-- 
2.7.4

