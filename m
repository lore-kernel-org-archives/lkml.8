Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB2EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48057206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgFAJpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:45:31 -0400
Received: from foss.arm.com ([217.140.110.172]:35662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgFAJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:45:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0F481045;
        Mon,  1 Jun 2020 02:45:21 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3DE23F305;
        Mon,  1 Jun 2020 02:45:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 2/3] firmware: Add support for PSA FF-A transport for VM partitions
Date:   Mon,  1 Jun 2020 10:45:11 +0100
Message-Id: <20200601094512.50509-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601094512.50509-1-sudeep.holla@arm.com>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for PSA FF-A interface providing APIs for non-secure VM
partitions.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/Kconfig              |   1 +
 drivers/firmware/Makefile             |   1 +
 drivers/firmware/arm_psa_ffa/Kconfig  |  15 ++
 drivers/firmware/arm_psa_ffa/Makefile |   2 +
 drivers/firmware/arm_psa_ffa/driver.c | 250 ++++++++++++++++++++++++++
 include/linux/arm_psa_ffa.h           |  42 +++++
 6 files changed, 311 insertions(+)
 create mode 100644 drivers/firmware/arm_psa_ffa/Kconfig
 create mode 100644 drivers/firmware/arm_psa_ffa/Makefile
 create mode 100644 drivers/firmware/arm_psa_ffa/driver.c
 create mode 100644 include/linux/arm_psa_ffa.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 4843e94713a4..1ee421974cba 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -295,6 +295,7 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
+source "drivers/firmware/arm_psa_ffa/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 99510be9f5ed..1c0b5f130d7d 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
 
+obj-y				+= arm_psa_ffa/
 obj-$(CONFIG_ARM_SCMI_PROTOCOL)	+= arm_scmi/
 obj-y				+= broadcom/
 obj-y				+= meson/
diff --git a/drivers/firmware/arm_psa_ffa/Kconfig b/drivers/firmware/arm_psa_ffa/Kconfig
new file mode 100644
index 000000000000..ba699ec68ec4
--- /dev/null
+++ b/drivers/firmware/arm_psa_ffa/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config ARM_PSA_FFA_TRANSPORT
+	tristate "Arm Platform Security Architecture Firmware Framework for Armv8-A"
+	depends on ARM64 && HAVE_ARM_SMCCC_DISCOVERY
+	help
+	  This Firmware Framework(FF) of the Platform Security Architecture
+	  (PSA) for Arm A-profile processors describes interfaces that
+	  standardize communication between the various software images which
+	  includes communication between images in the Secure world and
+	  Normal world. It also leverages the virtualization extension to
+	  isolate software images provided by an ecosystem of vendors from
+	  each other.
+
+	  This driver provides interface for all the client drivers making
+	  use of the features offered by ARM PSA-FF-A.
diff --git a/drivers/firmware/arm_psa_ffa/Makefile b/drivers/firmware/arm_psa_ffa/Makefile
new file mode 100644
index 000000000000..ac0455ff71a4
--- /dev/null
+++ b/drivers/firmware/arm_psa_ffa/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ARM_PSA_FFA_TRANSPORT) += driver.o
diff --git a/drivers/firmware/arm_psa_ffa/driver.c b/drivers/firmware/arm_psa_ffa/driver.c
new file mode 100644
index 000000000000..700bd5850746
--- /dev/null
+++ b/drivers/firmware/arm_psa_ffa/driver.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Arm Platform Security Architecture(PSA) Firmware Framework for ARMv8-A(FFA)
+ * interface driver
+ *
+ * The Arm PSA FFA specification[1] describes a software architecture to
+ * leverages the virtualization extension to isolate software images
+ * provided by an ecosystem of vendors from each other and describes
+ * interfaces that standardize communication between the various software
+ * images including communication between images in the Secure world and
+ * Normal world. Any Hypervisor could use the PSA FFA interfaces to enable
+ * communication between VMs it manages.
+ *
+ * The Hypervisor a.k.a Partition managers in FFA terminology can assign
+ * system resources(Memory regions, Devices, CPU cycles) to the partitions
+ * and manage isolation amongst them.
+ *
+ * [1] https://developer.arm.com/docs/den0077/latest
+ *
+ * Copyright (C) 2020 Arm Ltd.
+ */
+
+#define pr_fmt(fmt) "ARM PSA FF-A: " fmt
+
+#include <linux/arm_psa_ffa.h>
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#define PSA_FFA_SMC(calling_convention, func_num)			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, (calling_convention),	\
+			   ARM_SMCCC_OWNER_STANDARD, (func_num))
+
+#define PSA_FFA_SMC_32(func_num)	PSA_FFA_SMC(ARM_SMCCC_SMC_32, (func_num))
+#define PSA_FFA_SMC_64(func_num)	PSA_FFA_SMC(ARM_SMCCC_SMC_64, (func_num))
+
+#define PSA_FFA_ERROR				PSA_FFA_SMC_32(0x60)
+#define PSA_FFA_SUCCESS				PSA_FFA_SMC_32(0x61)
+#define PSA_FFA_INTERRUPT			PSA_FFA_SMC_32(0x62)
+#define PSA_FFA_VERSION				PSA_FFA_SMC_32(0x63)
+#define PSA_FFA_FEATURES			PSA_FFA_SMC_32(0x64)
+#define PSA_FFA_PARTITION_INFO_GET		PSA_FFA_SMC_32(0x68)
+#define PSA_FFA_ID_GET				PSA_FFA_SMC_32(0x69)
+
+/* PSA_FFA error codes. */
+#define PSA_FFA_RET_SUCCESS            (0)
+#define PSA_FFA_RET_NOT_SUPPORTED      (-1)
+#define PSA_FFA_RET_INVALID_PARAMETERS (-2)
+#define PSA_FFA_RET_NO_MEMORY          (-3)
+#define PSA_FFA_RET_BUSY               (-4)
+#define PSA_FFA_RET_INTERRUPTED        (-5)
+#define PSA_FFA_RET_DENIED             (-6)
+#define PSA_FFA_RET_RETRY              (-7)
+#define PSA_FFA_RET_ABORTED            (-8)
+
+#define MAJOR_VERSION_MASK	GENMASK(30, 16)
+#define MINOR_VERSION_MASK	GENMASK(15, 0)
+#define MAJOR_VERSION(x)	(u16)(FIELD_GET(MAJOR_VERSION_MASK, (x)))
+#define MINOR_VERSION(x)	(u16)(FIELD_GET(MINOR_VERSION_MASK, (x)))
+#define PACK_VERSION_INFO(major, minor)			\
+	(FIELD_PREP(MAJOR_VERSION_MASK, (major)) | 	\
+	FIELD_PREP(MINOR_VERSION_MASK, (minor)))
+#define PSA_FFA_VERSION_1_0	PACK_VERSION_INFO(1, 0)
+#define PSA_FFA_MIN_VERSION	PSA_FFA_VERSION_1_0
+#define PSA_FFA_DRIVER_VERSION	PSA_FFA_VERSION_1_0
+
+#define SENDER_ID_MASK		GENMASK(31, 16)
+#define RECEIVER_ID_MASK	GENMASK(15, 0)
+#define SENDER_ID(x)		(u16)(FIELD_GET(SENDER_ID_MASK, (x)))
+#define RECEIVER_ID(x)		(u16)(FIELD_GET(RECEIVER_ID_MASK, (x)))
+#define PACK_TARGET_INFO(s, r)		\
+	(FIELD_PREP(SENDER_ID_MASK, (s)) | FIELD_PREP(RECEIVER_ID_MASK, (r)))
+
+typedef struct arm_smccc_res
+(arm_psa_ffa_fn)(unsigned long, unsigned long, unsigned long, unsigned long,
+		 unsigned long, unsigned long, unsigned long, unsigned long);
+static arm_psa_ffa_fn *invoke_arm_psa_ffa_fn;
+
+static struct device *psa_ffa_dev;
+
+static const int psa_ffa_linux_errmap[] = {
+	/* better than switch case as long as return value is continuous */
+	0,		/* PSA_FFA_RET_SUCCESS */
+	-EOPNOTSUPP,	/* PSA_FFA_RET_NOT_SUPPORTED */
+	-EINVAL,	/* PSA_FFA_RET_INVALID_PARAMETERS */
+	-ENOMEM,	/* PSA_FFA_RET_NO_MEMORY */
+	-EBUSY,		/* PSA_FFA_RET_BUSY */
+	-EINTR,		/* PSA_FFA_RET_INTERRUPTED */
+	-EACCES,	/* PSA_FFA_RET_DENIED */
+	-EAGAIN,	/* PSA_FFA_RET_RETRY */
+	-ECANCELED,	/* PSA_FFA_RET_ABORTED */
+};
+
+static inline int psa_ffa_to_linux_errno(int errno)
+{
+	if (errno < PSA_FFA_RET_SUCCESS && errno >= PSA_FFA_RET_ABORTED)
+		return psa_ffa_linux_errmap[-errno];
+	return -EINVAL;
+}
+
+struct arm_smccc_res
+__arm_psa_ffa_fn_smc(unsigned long function_id,unsigned long arg0,
+		     unsigned long arg1, unsigned long arg2,
+		     unsigned long arg3, unsigned long arg4,
+		     unsigned long arg5, unsigned long arg6)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4, arg5, arg6,
+		      &res);
+
+	return res;
+}
+
+struct arm_smccc_res
+__arm_psa_ffa_fn_hvc(unsigned long function_id,unsigned long arg0,
+		     unsigned long arg1, unsigned long arg2,
+		     unsigned long arg3, unsigned long arg4,
+		     unsigned long arg5, unsigned long arg6)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, arg5, arg6,
+		      &res);
+
+	return res;
+}
+
+static u16 psa_ffa_id_get(void)
+{
+	struct arm_smccc_res id;
+
+	id = invoke_arm_psa_ffa_fn(PSA_FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0);
+
+	if (id.a0 == PSA_FFA_ERROR)
+		return psa_ffa_to_linux_errno((int)id.a2);
+	else
+		return id.a2 & 0xffff;
+}
+
+static int psa_ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
+				      struct psa_ffa_partition_info **buffer)
+{
+	struct arm_smccc_res partition_info;
+
+	partition_info = invoke_arm_psa_ffa_fn(PSA_FFA_PARTITION_INFO_GET,
+					       uuid0, uuid1, uuid2, uuid3,
+					       0, 0, 0);
+
+	if (partition_info.a0 == PSA_FFA_ERROR)
+		return psa_ffa_to_linux_errno((int)partition_info.a2);
+
+	/* TODO: read data from RX buffers */
+	return partition_info.a2;
+}
+
+static struct arm_psa_ffa_handle drv_handle = {
+	.id_get = psa_ffa_id_get,
+	.partition_info_get = psa_ffa_partition_info_get,
+};
+
+struct arm_psa_ffa_handle *arm_psa_ffa_handle_get(struct device *dev)
+{
+	 struct arm_psa_ffa_handle *handle = NULL;
+
+	if (dev->parent == psa_ffa_dev)
+		handle = &drv_handle;
+
+	return handle;
+}
+
+EXPORT_SYMBOL_GPL(arm_psa_ffa_handle_get);
+
+static int psa_ffa_version_check(void)
+{
+	struct arm_smccc_res version;
+
+	version = invoke_arm_psa_ffa_fn(PSA_FFA_VERSION, PSA_FFA_DRIVER_VERSION,
+					0, 0, 0, 0, 0, 0);
+
+	if (version.a0 == PSA_FFA_RET_NOT_SUPPORTED) {
+		pr_info("PSA_FFA_VERSION returned not supported\n");
+		return -ENOTSUPP;
+	}
+
+	if (version.a0 < PSA_FFA_MIN_VERSION ||
+	    version.a0 > PSA_FFA_DRIVER_VERSION) {
+		pr_err("Incompatible version %d.%d found\n",
+		       MAJOR_VERSION(version.a0), MINOR_VERSION(version.a0));
+		return -EINVAL;
+	}
+
+	pr_info("Found version %d.%d found\n", MAJOR_VERSION(version.a0),
+		MINOR_VERSION(version.a0));
+	return 0;
+}
+
+static int psa_ffa_probe(struct platform_device *pdev)
+{
+	int ret;
+	enum arm_smccc_conduit conduit;
+
+	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
+		return 0;
+
+	conduit = arm_smccc_1_1_get_conduit();
+	if (conduit == SMCCC_CONDUIT_NONE) {
+		pr_err("%s: invalid SMCCC conduit\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	if (conduit == SMCCC_CONDUIT_SMC)
+		invoke_arm_psa_ffa_fn = __arm_psa_ffa_fn_smc;
+	else
+		invoke_arm_psa_ffa_fn = __arm_psa_ffa_fn_hvc;
+
+	ret = psa_ffa_version_check();
+	if (ret)
+		return ret;
+
+	psa_ffa_dev = &pdev->dev;
+
+	return devm_of_platform_populate(psa_ffa_dev);
+}
+
+static const struct of_device_id psa_ffa_of_match[] = {
+	{.compatible = "arm,psa-ffa"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, psa_ffa_of_match);
+
+static struct platform_driver psa_ffa_driver = {
+	.driver = {
+		   .name = "arm-psa-ffa",
+		   .of_match_table = psa_ffa_of_match,
+		   },
+	.probe = psa_ffa_probe,
+};
+
+module_platform_driver(psa_ffa_driver);
+
+MODULE_ALIAS("platform: arm-psa-ffa");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("Arm PSA FF-A interface driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/arm_psa_ffa.h b/include/linux/arm_psa_ffa.h
new file mode 100644
index 000000000000..03a4ff559fa3
--- /dev/null
+++ b/include/linux/arm_psa_ffa.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019, 2020 Arm Ltd.
+ */
+
+#ifndef __LINUX_ARM_PSA_FFA_H
+#define __LINUX_ARM_PSA_FFA_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+struct psa_ffa_partition_info {
+	/* The ID of the VM the information is about */
+	uint16_t id;
+	/* The number of execution contexts implemented by the partition */
+	uint16_t execution_context;
+	/* The Partition's properties, e.g. supported messaging methods */
+	uint32_t partition_properties;
+};
+
+
+/**
+ * struct psa_ffa_ops - represents the various PSA_FFA protocol operations
+ * available for an endpoint.
+ */
+struct arm_psa_ffa_handle {
+	u16 (*id_get)(void);
+	int (*partition_info_get)(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
+				  struct psa_ffa_partition_info**);
+};
+
+#if IS_REACHABLE(CONFIG_ARM_PSA_FFA_TRANSPORT)
+struct arm_psa_ffa_handle *arm_psa_ffa_handle_get(struct device *dev);
+#else
+static inline
+struct arm_psa_ffa_handle * arm_psa_ffa_handle_get(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
+#endif /*__LINUX_ARM_PSA_FFA_H*/
-- 
2.17.1

