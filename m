Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7C42076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbgFYJ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:59:49 -0400
Received: from foss.arm.com ([217.140.110.172]:55292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390451AbgFYJ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:59:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0E9D1F1;
        Thu, 25 Jun 2020 02:59:47 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0A9D3F73C;
        Thu, 25 Jun 2020 02:59:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Francois Ozog <francois.ozog@linaro.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com,
        Etienne Carriere <etienne.carriere@st.com>
Subject: [PATCH v3] firmware: smccc: Add ARCH_SOC_ID support
Date:   Thu, 25 Jun 2020 10:59:39 +0100
Message-Id: <20200625095939.50861-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
SiP defined SoC identification value. Add support for the same.

Also using the SoC bus infrastructure, let us expose the platform
specific SoC atrributes under sysfs.

There are various ways in which it can be represented in shortened form
for efficiency and ease of parsing for userspace. The chosen form is
described in the ABI document.

Cc: Etienne Carriere <etienne.carriere@st.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/ABI/testing/sysfs-devices-soc |  30 ++++++
 drivers/firmware/smccc/Kconfig              |   9 ++
 drivers/firmware/smccc/Makefile             |   1 +
 drivers/firmware/smccc/soc_id.c             | 114 ++++++++++++++++++++
 include/linux/arm-smccc.h                   |   5 +
 5 files changed, 159 insertions(+)
 create mode 100644 drivers/firmware/smccc/soc_id.c


Changes from v2[2] -> v3:
	- Addressed comments from Steven Price and added his Reviewed-by

Changes from v1[1] -> v2[2]:
	- Dropped new jep106_id added to SoC infrastructure
	- Dropped all the tags(acks/reviews) as there is change in the format
	- Updated the format for SoC id to ensure there will be no
	  conflict in the namespace

[1] https://lore.kernel.org/lkml/20200522124951.35776-1-sudeep.holla@arm.com/

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index ba3a3fac0ee1..ea999e292f11 100644
--- a/Documentation/ABI/testing/sysfs-devices-soc
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -26,6 +26,30 @@ contact:	Lee Jones <lee.jones@linaro.org>
 		Read-only attribute common to all SoCs. Contains SoC family name
 		(e.g. DB8500).

+		On many of ARM based silicon with SMCCC v1.2+ compliant firmware
+		this will contain the JEDEC JEP106 manufacturer’s identification
+		code. The format is "jep106:XXYY" where XX is identity code and
+		YY is continuation code.
+
+		This manufacturer’s identification code is defined by one
+		or more eight (8) bit fields, each consisting of seven (7)
+		data bits plus one (1) odd parity bit. It is a single field,
+		limiting the possible number of vendors to 126. To expand
+		the maximum number of identification codes, a continuation
+		scheme has been defined.
+
+		The specified mechanism is that an identity code of 0x7F
+		represents the "continuation code" and implies the presence
+		of an additional identity code field, and this mechanism
+		may be extended to multiple continuation codes followed
+		by the manufacturer's identity code.
+
+		For example, ARM has identity code 0x7F 0x7F 0x7F 0x7F 0x3B,
+		which is code 0x3B on the fifth 'page'. This is shortened
+		as JEP106 identity code of 0x3B and a continuation code of
+		0x4 to represent the four continuation codes preceding the
+		identity code.
+
 What:		/sys/devices/socX/serial_number
 Date:		January 2019
 contact:	Bjorn Andersson <bjorn.andersson@linaro.org>
@@ -40,6 +64,12 @@ contact:	Lee Jones <lee.jones@linaro.org>
 		Read-only attribute supported by most SoCs. In the case of
 		ST-Ericsson's chips this contains the SoC serial number.

+		On many of ARM based silicon with SMCCC v1.2+ compliant firmware
+		this will contain the SOC ID appended to the family attribute
+		to ensure there is no conflict in this namespace across various
+		vendors. The format is "jep106:XXYY:ZZZZ" where XX is identity
+		code, YY is continuation code and ZZZZ is the SOC ID.
+
 What:		/sys/devices/socX/revision
 Date:		January 2012
 contact:	Lee Jones <lee.jones@linaro.org>
diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
index 27b675d76235..15e7466179a6 100644
--- a/drivers/firmware/smccc/Kconfig
+++ b/drivers/firmware/smccc/Kconfig
@@ -14,3 +14,12 @@ config HAVE_ARM_SMCCC_DISCOVERY
 	 to add SMCCC discovery mechanism though the PSCI firmware
 	 implementation of PSCI_FEATURES(SMCCC_VERSION) which returns
 	 success on firmware compliant to SMCCC v1.1 and above.
+
+config ARM_SMCCC_SOC_ID
+	bool "SoC bus device for the ARM SMCCC SOC_ID"
+	depends on HAVE_ARM_SMCCC_DISCOVERY
+	default y
+	select SOC_BUS
+	help
+	  Include support for the SoC bus on the ARM SMCCC firmware based
+	  platforms providing some sysfs information about the SoC variant.
diff --git a/drivers/firmware/smccc/Makefile b/drivers/firmware/smccc/Makefile
index 6f369fe3f0b9..72ab84042832 100644
--- a/drivers/firmware/smccc/Makefile
+++ b/drivers/firmware/smccc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc.o
+obj-$(CONFIG_ARM_SMCCC_SOC_ID)	+= soc_id.o
diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
new file mode 100644
index 000000000000..581aa5e9b077
--- /dev/null
+++ b/drivers/firmware/smccc/soc_id.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Arm Limited
+ */
+
+#define pr_fmt(fmt) "SMCCC: SOC_ID: " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define SMCCC_SOC_ID_JEP106_BANK_IDX_MASK	GENMASK(30, 24)
+/*
+ * As per the SMC Calling Convention specification v1.2 (ARM DEN 0028C)
+ * Section 7.4 SMCCC_ARCH_SOC_ID bits[23:16] are JEP-106 identification
+ * code with parity bit for the SiP. We can drop the parity bit.
+ */
+#define SMCCC_SOC_ID_JEP106_ID_CODE_MASK	GENMASK(22, 16)
+#define SMCCC_SOC_ID_IMP_DEF_SOC_ID_MASK	GENMASK(15, 0)
+
+#define JEP106_BANK_CONT_CODE(x)	\
+	(u8)(FIELD_GET(SMCCC_SOC_ID_JEP106_BANK_IDX_MASK, (x)))
+#define JEP106_ID_CODE(x)	\
+	(u8)(FIELD_GET(SMCCC_SOC_ID_JEP106_ID_CODE_MASK, (x)))
+#define IMP_DEF_SOC_ID(x)	\
+	(u16)(FIELD_GET(SMCCC_SOC_ID_IMP_DEF_SOC_ID_MASK, (x)))
+
+static struct soc_device *soc_dev;
+static struct soc_device_attribute *soc_dev_attr;
+
+static int __init smccc_soc_init(void)
+{
+	struct arm_smccc_res res;
+	int soc_id_rev, soc_id_version;
+	static char soc_id_str[20], soc_id_rev_str[12];
+	static char soc_id_jep106_id_str[12];
+
+	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
+		return 0;
+
+	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
+		pr_err("%s: invalid SMCCC conduit\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			     ARM_SMCCC_ARCH_SOC_ID, &res);
+
+	if (res.a0 == SMCCC_RET_NOT_SUPPORTED) {
+		pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
+		return 0;
+	}
+
+	if ((int)res.a0 < 0) {
+		pr_info("ARCH_FEATURES(ARCH_SOC_ID) returned error: %lx\n",
+			res.a0);
+		return -EINVAL;
+	}
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
+	if ((int)res.a0 < 0) {
+		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
+		return -EINVAL;
+	}
+
+	soc_id_version = res.a0;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
+	if ((int)res.a0 < 0) {
+		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
+		return -EINVAL;
+	}
+
+	soc_id_rev = res.a0;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
+	sprintf(soc_id_jep106_id_str, "jep106:%02x%02x",
+		JEP106_BANK_CONT_CODE(soc_id_version),
+		JEP106_ID_CODE(soc_id_version));
+	sprintf(soc_id_str, "%s:%04x", soc_id_jep106_id_str,
+		IMP_DEF_SOC_ID(soc_id_version));
+
+	soc_dev_attr->soc_id = soc_id_str;
+	soc_dev_attr->revision = soc_id_rev_str;
+	soc_dev_attr->family = soc_id_jep106_id_str;
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	pr_info("ID = %s Revision = %s\n", soc_dev_attr->soc_id,
+		soc_dev_attr->revision);
+
+	return 0;
+}
+module_init(smccc_soc_init);
+
+static void __exit smccc_soc_exit(void)
+{
+	if (soc_dev)
+		soc_device_unregister(soc_dev);
+	kfree(soc_dev_attr);
+}
+module_exit(smccc_soc_exit);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 56d6a5c6e353..8254e11ea857 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -71,6 +71,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 1)

+#define ARM_SMCCC_ARCH_SOC_ID						\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 2)
+
 #define ARM_SMCCC_ARCH_WORKAROUND_1					\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
 			   ARM_SMCCC_SMC_32,				\
--
2.17.1
