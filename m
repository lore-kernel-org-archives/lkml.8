Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541AFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA482074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgFAJp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:45:28 -0400
Received: from foss.arm.com ([217.140.110.172]:35670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAJpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:45:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 142C31063;
        Mon,  1 Jun 2020 02:45:23 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16F5F3F305;
        Mon,  1 Jun 2020 02:45:21 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 3/3] firmware: Add example PSA FF-A non-secure VM partition
Date:   Mon,  1 Jun 2020 10:45:12 +0100
Message-Id: <20200601094512.50509-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601094512.50509-1-sudeep.holla@arm.com>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just an example non-secure VM partition to show how to create
the device and use the PSA FF-A interface APIs.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_psa_ffa/Kconfig     |  7 +++
 drivers/firmware/arm_psa_ffa/Makefile    |  1 +
 drivers/firmware/arm_psa_ffa/partition.c | 71 ++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 drivers/firmware/arm_psa_ffa/partition.c

diff --git a/drivers/firmware/arm_psa_ffa/Kconfig b/drivers/firmware/arm_psa_ffa/Kconfig
index ba699ec68ec4..34ad61e79234 100644
--- a/drivers/firmware/arm_psa_ffa/Kconfig
+++ b/drivers/firmware/arm_psa_ffa/Kconfig
@@ -13,3 +13,10 @@ config ARM_PSA_FFA_TRANSPORT
 
 	  This driver provides interface for all the client drivers making
 	  use of the features offered by ARM PSA-FF-A.
+
+config ARM_PSA_FFA_PARTITION
+	tristate "Arm PSA FF-A compliant partition"
+	depends on ARM_PSA_FFA_TRANSPORT
+	help
+	  This driver provides example for ARM PSA-FF-A client driver
+	  making use of the interfaces offered by ARM PSA-FF-A driver.
diff --git a/drivers/firmware/arm_psa_ffa/Makefile b/drivers/firmware/arm_psa_ffa/Makefile
index ac0455ff71a4..8eb03898baf7 100644
--- a/drivers/firmware/arm_psa_ffa/Makefile
+++ b/drivers/firmware/arm_psa_ffa/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ARM_PSA_FFA_TRANSPORT) += driver.o
+obj-$(CONFIG_ARM_PSA_FFA_PARTITION) += partition.o
diff --git a/drivers/firmware/arm_psa_ffa/partition.c b/drivers/firmware/arm_psa_ffa/partition.c
new file mode 100644
index 000000000000..8549f8d61454
--- /dev/null
+++ b/drivers/firmware/arm_psa_ffa/partition.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Arm PSA FFA example partition driver
+ *
+ * Copyright (C) 2020 Arm Ltd.
+ */
+
+#include <linux/arm_psa_ffa.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+static int psa_ffa_partition_probe(struct platform_device *pdev)
+{
+	u16 vm_id;
+	uuid_t uuid;
+	const char *uuid_str;
+	u32 uuid0_4[4];
+	struct device *dev = &pdev->dev;
+	const struct device_node *np = dev->of_node;
+	struct arm_psa_ffa_handle *handle;
+	struct psa_ffa_partition_info **buffer;
+
+	handle = arm_psa_ffa_handle_get(dev);
+	if (!handle)
+		return -ENODEV;
+
+	if (of_property_read_string(np, "uuid", &uuid_str)) {
+		dev_err(dev, "failed to parse \"uuid\" property in '%pOF'\n", np);
+		return -ENODEV;
+	}
+
+	if (uuid_parse(uuid_str, &uuid)) {
+		dev_err(dev, "invalid \"uuid\" property (%s)\n", uuid_str);
+		return -ENODEV;
+	}
+
+	export_uuid((u8 *)uuid0_4, &uuid);
+
+	vm_id = handle->id_get();
+
+	handle->partition_info_get(uuid0_4[0], uuid0_4[1], uuid0_4[2],
+				   uuid0_4[3], buffer);
+
+	return 0;
+}
+
+static const struct of_device_id psa_ffa_partition_of_match[] = {
+	{.compatible = "arm,psa-ffa-partition"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, psa_ffa_partition_of_match);
+
+static struct platform_driver psa_ffa_partition_driver = {
+	.driver = {
+		   .name = "psa-ffa-partition",
+		   .of_match_table = psa_ffa_partition_of_match,
+		   },
+	.probe = psa_ffa_partition_probe,
+};
+
+module_platform_driver(psa_ffa_partition_driver);
+
+MODULE_ALIAS("platform: arm-psa-ffa");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("Arm PSA FF-A example partition driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

