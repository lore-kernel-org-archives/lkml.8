Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D93C55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B02A20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ER+RW8R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgDWNTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:19:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58502 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727777AbgDWNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:19:39 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NDCX7e009209;
        Thu, 23 Apr 2020 15:19:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=RDeGUX1kaDX+4Hwp31TbURyze55b7oE/AwyPuMTSu6o=;
 b=ER+RW8R1Df5fKRZgzVQupOOWnnA5P+l4hX9mZMAYQOgrpVB+r42b2dOndz8Qqb3U4rfj
 HVPXtRJDSK60BIMOam5+r9VTheNlDicG6u8Oggv1S7p08skEVNsnIr4451UCetCEWap8
 +Y/22wrYfGNayqu5wiBYhDAsqY/IJ3JeROVMgXHkBoNRIrKKyk8MrepBF9k57NYbHMoq
 5EpT0EWSbHnF60jZ9UGc9AlMHhmVTLUI4e8sgDvTAAOPPPUxDDl1PsyIRKb8wYqymXK/
 +8YVrinz9G+6TcuoH7nCUJhhE+b1YbNniVF9vlfH/GQCz+4PI5Vx5WeGa1SWzjpOLbZ6 PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fregw0ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 15:19:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 325EF10002A;
        Thu, 23 Apr 2020 15:19:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25A1A20758D;
        Thu, 23 Apr 2020 15:19:19 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Apr 2020 15:19:17
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <gregkh@linuxfoundation.org>,
        <loic.pallardy@st.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/5] bus: stm32: Introduce firewall controller helpers
Date:   Thu, 23 Apr 2020 15:19:10 +0200
Message-ID: <20200423131913.30786-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200423131913.30786-1-benjamin.gaignard@st.com>
References: <20200423131913.30786-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_10:2020-04-23,2020-04-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of these helpers are to offer an interface for the
hardware blocks controlling bus accesses rights.

Bus firewall controllers are typically used to control if a
hardware block can perform read or write operations on bus.

Smarter firewall controllers could be able to define accesses
rights per hardware blocks to control where they can read
or write.

Firewall controller configurations are provided in device node,
parsed by the helpers and send to the driver to apply them.
Each controller may need different number and type of inputs
to configure the firewall so device-tree properties size have to
be define by using "#firewall-cells".
Firewall configurations properties have to be named "firewall-X"
on device node.
"firewall-names" keyword can also be used to give a name to
a specific configuration.

Example of device-tree:
ctrl0: firewall@0 {
	#firewall-cells = <2>;
      };

foo: foo@0 {
	firewall-names = "default", "setting1";
	firewall-0 = <&ctrl0 1 2>;
	firewall-1 = <&ctrl0 3 4>;
};

Configurations could be applied with functions like
firewall_set_config_by_index() or firewall_set_config_by_name().

firewall_set_default_config() function will apply the
configuration named "default" (if existing) or the configuration
with index 0 (i.e. firewall-0).

Drivers could register/unregister themselves be calling
firewall_register/firewall_unregister functions.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/bus/Kconfig          |   2 +
 drivers/bus/Makefile         |   2 +
 drivers/bus/stm32/Kconfig    |   3 +
 drivers/bus/stm32/Makefile   |   1 +
 drivers/bus/stm32/firewall.c | 266 +++++++++++++++++++++++++++++++++++++++++++
 drivers/bus/stm32/firewall.h |  75 ++++++++++++
 6 files changed, 349 insertions(+)
 create mode 100644 drivers/bus/stm32/Kconfig
 create mode 100644 drivers/bus/stm32/Makefile
 create mode 100644 drivers/bus/stm32/firewall.c
 create mode 100644 drivers/bus/stm32/firewall.h

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6d4e4497b59b..843b356322d9 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -203,4 +203,6 @@ config DA8XX_MSTPRI
 source "drivers/bus/fsl-mc/Kconfig"
 source "drivers/bus/mhi/Kconfig"
 
+source "drivers/bus/stm32/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 05f32cd694a4..5e0e34b10235 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -37,3 +37,5 @@ obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
 
 # MHI
 obj-$(CONFIG_MHI_BUS)		+= mhi/
+
+obj-$(CONFIG_MACH_STM32MP157) 	+= stm32/
\ No newline at end of file
diff --git a/drivers/bus/stm32/Kconfig b/drivers/bus/stm32/Kconfig
new file mode 100644
index 000000000000..57221e833e2d
--- /dev/null
+++ b/drivers/bus/stm32/Kconfig
@@ -0,0 +1,3 @@
+config FIREWALL_CONTROLLERS
+	bool "Support of bus firewall controllers"
+	depends on OF
diff --git a/drivers/bus/stm32/Makefile b/drivers/bus/stm32/Makefile
new file mode 100644
index 000000000000..eb6b978d6450
--- /dev/null
+++ b/drivers/bus/stm32/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_FIREWALL_CONTROLLERS) += firewall.o
diff --git a/drivers/bus/stm32/firewall.c b/drivers/bus/stm32/firewall.c
new file mode 100644
index 000000000000..95f716cf926f
--- /dev/null
+++ b/drivers/bus/stm32/firewall.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "firewall.h"
+
+/* Mutex taken to protect firewall_list */
+static DEFINE_MUTEX(firewall_list_mutex);
+
+/* Global list of firewall control devices */
+static LIST_HEAD(firewall_list);
+
+struct firewall_ctrl {
+	struct list_head list;
+	struct firewall_ops *ops;
+	struct device_node *np;
+	void *priv;
+};
+
+static struct firewall_ctrl *get_firewallctrl_from_node(struct device_node *np)
+{
+	struct firewall_ctrl *ctrl;
+
+	mutex_lock(&firewall_list_mutex);
+
+	list_for_each_entry(ctrl, &firewall_list, list) {
+		if (ctrl->np == np) {
+			mutex_unlock(&firewall_list_mutex);
+			return ctrl;
+		}
+	}
+
+	mutex_unlock(&firewall_list_mutex);
+
+	return NULL;
+}
+
+/**
+ * firewall_dt_has_default
+ *
+ * Check if the device node provide firewall configuration
+ *
+ * @np: device node with possible firewall configuration
+ *
+ * Return: true is firewall-0 property exist in the device node
+ */
+static bool firewall_dt_has_default(struct device_node *np)
+{
+	struct property *prop;
+	int size;
+
+	if (!np)
+		return false;
+
+	prop = of_find_property(np, "firewall-0", &size);
+
+	return prop ? true : false;
+}
+
+/**
+ * firewall_set_config_by_index
+ *
+ * Set a firewall controller configuration based on given index.
+ *
+ * @np: device node with firewall configuration to apply.
+ * @index: the index of the configuration in device node.
+ *
+ * Return: 0 if OK, -EPROBE_DEFER if waiting for firewall controller to be
+ * registered or negative value on other errors.
+ */
+int firewall_set_config_by_index(struct device_node *np, int index)
+{
+	char *propname;
+	int configs, i, err = 0;
+
+	if (!np)
+		return 0;
+
+	propname = kasprintf(GFP_KERNEL, "firewall-%d", index);
+	configs = of_count_phandle_with_args(np, propname, "#firewall-cells");
+	if (configs < 0) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	for (i = 0; i < configs; i++) {
+		struct firewall_ctrl *ctrl;
+		struct of_phandle_args args;
+
+		err = of_parse_phandle_with_args(np, propname,
+						 "#firewall-cells",
+						 i, &args);
+		if (err)
+			goto error;
+
+		/* Test if the controller is (or will be) available */
+		if (!of_device_is_available(args.np)) {
+			of_node_put(args.np);
+			continue;
+		}
+
+		ctrl = get_firewallctrl_from_node(args.np);
+		of_node_put(args.np);
+
+		/* Controller is not yet registered */
+		if (!ctrl) {
+			err = -EPROBE_DEFER;
+			goto error;
+		}
+
+		err = ctrl->ops->set_config(ctrl->priv, &args);
+		if (err)
+			goto error;
+	}
+
+error:
+	kfree(propname);
+	return err;
+}
+EXPORT_SYMBOL_GPL(firewall_set_config_by_index);
+
+/**
+ * firewall_set_config_by_name
+ *
+ * Set a firwall controller configuration based on given name.
+ *
+ * @np: device node with firewall configuration to apply.
+ * @name: the name of the configuration in device node.
+ *
+ * Return: 0 if OK, -EPROBE_DEFER if waiting for firewall controller to be
+ * registered or negative value on other errors.
+ */
+int firewall_set_config_by_name(struct device_node *np, char *name)
+{
+	const char *configname;
+	int count, i;
+
+	count = of_property_count_strings(np, "firewall-names");
+	for (i = 0; i < count; i++) {
+		int err;
+
+		err = of_property_read_string_index(np,
+						    "firewall-names",
+						    i, &configname);
+		if (err)
+			return err;
+
+		if (strcmp(name, configname))
+			continue;
+
+		return firewall_set_config_by_index(np, i);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(firewall_set_config_by_name);
+
+/**
+ * firewall_set_default_config
+ *
+ * Set the default configuration for device.
+ * First try to apply configuration named "default", if it fails
+ * or doesn't exist, try to apply firewall-0 configuration.
+ *
+ * @np: device node with firewall configuration to apply.
+ *
+ * Return: 0 if OK, -EPROBE_DEFER if waiting for firewall controller to be
+ * registered or negative value on other errors.
+ */
+int firewall_set_default_config(struct device_node *np)
+{
+	int ret;
+
+	/* Nothing to do if device node doesn't contain at least
+	 * one configuration
+	 */
+	if (!firewall_dt_has_default(np))
+		return 0;
+
+	ret = firewall_set_config_by_name(np, "default");
+	if (!ret || (ret == -EPROBE_DEFER))
+		return ret;
+
+	return firewall_set_config_by_index(np, 0);
+}
+EXPORT_SYMBOL_GPL(firewall_set_default_config);
+
+/**
+ * firewall_register
+ *
+ * Register a firewall controller.
+ *
+ * @np: node implementing firewall controller.
+ * @ops: firewall controller operations.
+ * @priv: caller private data.
+ *
+ * Return: 0 if OK or negative value on error.
+ */
+int firewall_register(struct device_node *np,
+		      struct firewall_ops *ops,
+		      void *priv)
+{
+	struct firewall_ctrl *ctrl;
+
+	if (!np || !ops || !ops->set_config)
+		return -EINVAL;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctrl->list);
+
+	ctrl->np = np;
+	ctrl->ops = ops;
+	ctrl->priv = priv;
+
+	mutex_lock(&firewall_list_mutex);
+	list_add_tail(&ctrl->list, &firewall_list);
+	mutex_unlock(&firewall_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(firewall_register);
+
+/**
+ * firewall_unregister
+ *
+ * Unregister a firewall controller.
+ *
+ * @np: node implementing firewall controller.
+ */
+void firewall_unregister(struct device_node *np)
+{
+	struct firewall_ctrl *ctrl;
+
+	ctrl = get_firewallctrl_from_node(np);
+	if (!ctrl)
+		return;
+
+	mutex_lock(&firewall_list_mutex);
+	list_del(&ctrl->list);
+	mutex_unlock(&firewall_list_mutex);
+
+	kfree(ctrl);
+}
+EXPORT_SYMBOL_GPL(firewall_unregister);
+
+static int __init firewall_init(void)
+{
+	pr_info("initialized bus firewall controller subsystem\n");
+	return 0;
+}
+
+/* Init early since drivers really need to configure firewall early */
+core_initcall(firewall_init);
diff --git a/drivers/bus/stm32/firewall.h b/drivers/bus/stm32/firewall.h
new file mode 100644
index 000000000000..d6fd720a229e
--- /dev/null
+++ b/drivers/bus/stm32/firewall.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#ifndef _FIREWALL_H_
+#define _FIREWALL_H_
+
+#include <linux/device.h>
+#include <linux/of.h>
+
+/**
+ * struct firewall_ops
+ *
+ * Firewall controller operations structure to be filled by drivers.
+ */
+struct firewall_ops {
+	/**
+	 * @set_config:
+	 *
+	 * Driver callback to set a firewall configuration on a controller.
+	 * Configuration arguments are provided in out_args parameter.
+	 *
+	 * Return: 0 on success, a negative error code on failure.
+	 */
+	int (*set_config)(void *priv, struct of_phandle_args *out_args);
+};
+
+#ifdef CONFIG_FIREWALL_CONTROLLERS
+
+int firewall_set_config_by_index(struct device_node *np, int index);
+int firewall_set_config_by_name(struct device_node *np, char *name);
+int firewall_set_default_config(struct device_node *np);
+
+int firewall_register(struct device_node *np,
+		      struct firewall_ops *ops,
+		      void *priv);
+
+void firewall_unregister(struct device_node *np);
+
+#else
+
+static inline int firewall_set_config_by_index(struct device_node *np,
+					       int index)
+{
+	return 0;
+}
+
+static inline int firewall_set_config_by_name(struct device_node *np,
+					      char *name)
+{
+	return 0;
+}
+
+static inline int firewall_set_default_config(struct device_node *np)
+{
+	return 0;
+}
+
+static inline int firewall_register(struct device_node *np,
+				    struct firewall_ops *ops,
+				    void *priv)
+{
+	return 0;
+}
+
+static inline void firewall_unregister(struct device_node *np)
+{
+	/* Empty */
+}
+
+#endif
+
+#endif /* _FIREWALL_H_ */
-- 
2.15.0

