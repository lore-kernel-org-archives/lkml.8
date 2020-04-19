Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B2C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD90214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lw3YZBs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDSPFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgDSPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:05:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE1C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:05:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so8815628wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJyu1goMDawsMnyU0ATkWtgXzvVpCCNTMOr5sgRr7ks=;
        b=lw3YZBs2+CzmIxZI4c3R3pem5y/CkiFmzRnZyNY7Bnf7YgR7rv3/tEW4U3QCw1cJuR
         JAjxjhIrSd8BHtGQgYGVXEaVIbTEoh7lNMbD58r+pHlObobJUZav5O+Cc3o+oU8uOkZ9
         yCTEEIslPZ7vsAwTxVuFMRbUHWG97mC0EGITQ1XgSy6q7nBXtrCeRTXgSSO/JXmk0soZ
         sLZiVluJA6lsFDi0v2Vd05a16Rt68tWfwT+RvNzxYItfV07ZvnAYk+r/nmOFIQSGWylk
         MzjN+ra5yIZUYPtsdejrSqk2POYyQZKivf0qnn13HKiB6zvPW2ZcN7iMvJYdysovuunm
         LFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJyu1goMDawsMnyU0ATkWtgXzvVpCCNTMOr5sgRr7ks=;
        b=KSr7TaymBbk3khdJbTI9Xxyds3xHmcthXU8qfzaRz2KSFCtlPQ1JXq2PxmJbAjmmHg
         QgWtx8vBx6NGvLwEQUIsF9CRLzgMtUw22le5JKXHdbEOxKBSlwaVWyVBND5kEQbDTown
         AJN/WBU/RXoqVT2qvmZZOdOn/k+4nnXC4Vf7IXkYKKAnelwopSnuXtf2m9gphLDeINOF
         uiHGl+/KJ9XhTstO9Wtj56qkMik54i9R3eXx1XjQHeAnu30g7ZjkI5XrSWBRSMwhEP3O
         mGX5fdruI2YFaURTRgjvyBWfCjIAvyGqfCdfvvqiN4717YCzA+nBdoNoT2WEkf/85xMk
         j+QQ==
X-Gm-Message-State: AGi0PubOvDREyQ0E/Xvb1Op8cr4qVNmP1sYU7Kge8Ic03A2vN6Anc4dX
        njWtyK1sxoa9CN6Il5HSWpf4p3c0ABg9XzAFXug=
X-Google-Smtp-Source: APiQypJBj7hPW2geuzSFyXnoAMnke+GfIXWdXk6/g0HHLzsza5OPiJnU8GrVfqyYrFIcoUaY+qYCbg==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr6894861wrw.291.1587308736034;
        Sun, 19 Apr 2020 08:05:36 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id w12sm25948635wrk.56.2020.04.19.08.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 08:05:35 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 1/6] firmware: helper functions for SMCCC v1.0 invocation conduit
Date:   Sun, 19 Apr 2020 17:05:25 +0200
Message-Id: <20200419150530.20508-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419150530.20508-1-etienne.carriere@linaro.org>
References: <20200419150530.20508-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce invocation helper functions for driver that interact with
firmware supporting Arm SMCCC v1.0 specification based on existing
arm_smccc_1_1_*() helpers. The new functions suit device where secure
world supports SMCCC v1.0 but not v1.1.

This change allows devices to ensure consistency of the conduit
used among drivers defining a conduit method as at runtime all
devices are expected to use the very same SMCCC invocation conduit.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/arm_smccc_conduit.c | 147 +++++++++++++++++++++++++++
 include/linux/arm-smccc.h            | 106 +++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 drivers/firmware/arm_smccc_conduit.c

diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index e9fb838af4df..5a4a72a06346 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
+obj-$(CONFIG_HAVE_ARM_SMCCC)	+= arm_smccc_conduit.o
 obj-$(CONFIG_DMI)		+= dmi_scan.o
 obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
 obj-$(CONFIG_EDD)		+= edd.o
diff --git a/drivers/firmware/arm_smccc_conduit.c b/drivers/firmware/arm_smccc_conduit.c
new file mode 100644
index 000000000000..37b90e92a4b3
--- /dev/null
+++ b/drivers/firmware/arm_smccc_conduit.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, Linaro Limited
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/of.h>
+
+static enum arm_smccc_conduit arm_smccc_1_0_conduit = SMCCC_CONDUIT_NONE;
+
+/* Helpers for nice trace when called outside a device instance */
+#define PRINT_INFO(dev, ...)				\
+	do {						\
+		if (dev)				\
+			dev_info(dev, __VA_ARGS__);	\
+		else					\
+			pr_info(__VA_ARGS__);		\
+	} while (0)
+
+#define PRINT_WARN(dev, ...)				\
+	do {						\
+		if (dev)				\
+			dev_warn(dev, __VA_ARGS__);	\
+		else					\
+			pr_warn(__VA_ARGS__);		\
+	} while (0)
+
+#define PRINT_ERROR(dev, ...)				\
+	do {						\
+		if (dev)				\
+			dev_err(dev, __VA_ARGS__);	\
+		else					\
+			pr_err(__VA_ARGS__);		\
+	} while (0)
+
+static const char *conduit_str(enum arm_smccc_conduit conduit)
+{
+	static const char hvc_str[] = "HVC";
+	static const char smc_str[] = "SMC";
+	static const char unknown[] = "unknown";
+
+	switch (conduit) {
+	case SMCCC_CONDUIT_HVC:
+		return hvc_str;
+	case SMCCC_CONDUIT_SMC:
+		return smc_str;
+	default:
+		return unknown;
+	}
+}
+
+static int set_conduit(struct device *dev, enum arm_smccc_conduit conduit)
+{
+	switch (conduit) {
+	case SMCCC_CONDUIT_HVC:
+	case SMCCC_CONDUIT_SMC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (arm_smccc_1_0_conduit == SMCCC_CONDUIT_NONE) {
+		arm_smccc_1_0_conduit = conduit;
+		return 0;
+	}
+
+	if (conduit == arm_smccc_1_0_conduit)
+		return 0;
+
+	PRINT_ERROR(dev, "inconsistent conduits %u (%s) vs %u (%s)\n",
+		    conduit, conduit_str(conduit),
+		    arm_smccc_1_0_conduit, conduit_str(arm_smccc_1_0_conduit));
+
+	return -EINVAL;
+}
+
+static enum arm_smccc_conduit method_to_conduit(const char *method)
+{
+	if (!strcmp("hvc", method))
+		return SMCCC_CONDUIT_HVC;
+	else if (!strcmp("smc", method))
+		return SMCCC_CONDUIT_SMC;
+	else
+		return SMCCC_CONDUIT_NONE;
+}
+
+static int set_conduit_from_node(struct device *dev, struct device_node *np)
+{
+	const char *method;
+
+	PRINT_INFO(dev, "probing for conduit method from DT.\n");
+
+	if (!np)
+		return -EINVAL;
+
+	if (!of_property_read_string(np, "method", &method)) {
+		enum arm_smccc_conduit dev_conduit = method_to_conduit(method);
+
+		if (dev_conduit == SMCCC_CONDUIT_NONE) {
+			PRINT_WARN(dev, "invalid \"method\" property \"%s\"\n",
+				   method);
+			return -EINVAL;
+		}
+
+		return set_conduit(dev, dev_conduit);
+	}
+
+	if (arm_smccc_1_0_conduit != SMCCC_CONDUIT_NONE)
+		return 0;
+
+	PRINT_WARN(dev, "missing \"method\" property\n");
+	return -ENXIO;
+}
+
+int devm_arm_smccc_1_0_set_conduit(struct device *dev)
+{
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	return set_conduit_from_node(dev, dev->of_node);
+}
+EXPORT_SYMBOL_GPL(devm_arm_smccc_1_0_set_conduit);
+
+int of_arm_smccc_1_0_set_conduit(struct device_node *np)
+{
+	if (!np)
+		return -EINVAL;
+
+	return set_conduit_from_node(NULL, np);
+}
+EXPORT_SYMBOL_GPL(of_arm_smccc_1_0_set_conduit);
+
+int arm_smccc_1_0_set_conduit(enum arm_smccc_conduit conduit)
+{
+	if (set_conduit(NULL, conduit))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arm_smccc_1_0_set_conduit);
+
+enum arm_smccc_conduit arm_smccc_1_0_get_conduit(void)
+{
+	return arm_smccc_1_0_conduit;
+}
+EXPORT_SYMBOL_GPL(arm_smccc_1_0_get_conduit);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 59494df0f55b..4f5f17b00a6b 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -377,5 +377,111 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
 			   0x21)
 
+/* SMCCC v1.0 compliant invocation helpers */
+
+/*
+ * Like arm_smccc_1_0* but always returns SMCCC_RET_NOT_SUPPORTED.
+ * Used when the SMCCC conduit is not defined. The empty asm statement
+ * avoids compiler warnings about unused variables.
+ */
+#define __fail_smccc_1_0(...)						\
+	do {								\
+		__declare_args(7, __VA_ARGS__);				\
+		asm ("" __constraints(7));				\
+		___res->a0 = SMCCC_RET_NOT_SUPPORTED;			\
+	} while (0)
+
+/*
+ * arm_smccc_1_0_invoke() - make an SMCCC v1.0 compliant call
+ *
+ * This is a macro taking eight source arguments and an return structure.
+ * It uses the SMCCC conduit registered during driver(s) initialization.
+ *
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This macro will make either an HVC call or an SMC call depending on the
+ * specified SMCCC conduit. If no valid conduit is available then -1
+ * (SMCCC_RET_NOT_SUPPORTED) is returned in @res.a0.
+ *
+ * The return value provides the conduit that was used.
+ */
+#define arm_smccc_1_0_invoke(...) ({					\
+		enum arm_smccc_conduit conduit = arm_smccc_1_0_get_conduit(); \
+		switch (conduit) {					\
+		case SMCCC_CONDUIT_HVC:					\
+			arm_smccc_hvc(__VA_ARGS__);			\
+			break;						\
+		case SMCCC_CONDUIT_SMC:					\
+			arm_smccc_smc(__VA_ARGS__);			\
+			break;						\
+		default:						\
+			__fail_smccc_1_0(__VA_ARGS__);			\
+			conduit = SMCCC_CONDUIT_NONE;			\
+		}							\
+		conduit;						\
+	})
+
+struct device;
+struct device_node;
+
+#ifdef CONFIG_HAVE_ARM_SMCCC
+/**
+ * arm_smccc_1_0_get_conduit() - Return registered SMCCC conduit
+ */
+enum arm_smccc_conduit arm_smccc_1_0_get_conduit(void);
+
+/**
+ * arm_smccc_1_0_set_conduit - Register SMCCC invocation conduit
+ * @conduit: conduit to register
+ *
+ * Return 0 on success and -EINVAL on failure.
+ */
+int arm_smccc_1_0_set_conduit(enum arm_smccc_conduit);
+
+/**
+ * devm_arm_smccc_1_0_set_conduit() - Set SMCCC v1.0 conduit if found in device
+ * @dev: Device instance
+ *
+ * Set the SMCCC invocation conduit based on device node if it has a "methhod"
+ * property that defines the SMCCC conduit to be used. If it has not, check a
+ * conduit is already registered.
+ *
+ * Return 0 on success, -ENXIO if no conduit found, -EINVAL otherwise.
+ */
+int devm_arm_smccc_1_0_set_conduit(struct device *dev);
+
+/**
+ * of_arm_smccc_1_0_set_conduit() - Set SMCCC v1.0 conduit if found in FDT node
+ * @np: Node instance
+ *
+ * Set the SMCCC invocation conduit based on device node if it has a "methhod"
+ * property that defines the SMCCC conduit to be used. If it has not, check a
+ * conduit is already registered.
+ *
+ * Return 0 on success, -ENXIO if no conduit found, -EINVAL otherwise.
+ */
+int of_arm_smccc_1_0_set_conduit(struct device_node *np);
+#else
+static inline enum arm_smccc_conduit arm_smccc_1_0_get_conduit(void)
+{
+	return SMCCC_CONDUIT_NONE;
+}
+
+static inline int arm_smccc_1_0_set_conduit(enum arm_smccc_conduit);
+{
+	return -EINVAL;
+}
+
+static inline int devm_arm_smccc_1_0_set_conduit(struct device *dev);
+{
+	return -EINVAL;
+}
+
+static inline int of_arm_smccc_1_0_set_conduit(struct device_node *np);
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_HAVE_ARM_SMCCC */
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
2.17.1

