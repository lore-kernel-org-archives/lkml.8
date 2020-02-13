Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D6EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866A224676
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm4N8Ii1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgBMQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:40:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43681 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgBMQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:40:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so7471072wrq.10;
        Thu, 13 Feb 2020 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3xvzwyOcTX6jrZCmLPn1xPCdXLA1nzGkBSyRyltXjk=;
        b=pm4N8Ii165b0PL12/aNBBO5dsYM8aT8KKCzM91JjbkYwNvHB/6EX4CQPfvsbfw5ZqM
         soIkHHO1hk9pg6Jy/SZrIVazNboCiqilkZbQliAWBBXhpfdpc2rUJedclINykTjcT0uo
         n+AukqdJAxj6ugTbe8ZfvoK4zx07WeCleRfyXQxAnNctcWsDFAQ9Yb7c5L5tE8iWqw69
         p62DM8N16wex4hZ+q0adAW5uJyygpNEVO0nznpRY8xy57ZQeZkyk8wdRxFmIKkLIulml
         gnpsIXEaCqJqsUaRhMPBxlHeidD9vefcuyZMCN3gw4VbIE/eCwhAmVwP9W3Rq3gByTQa
         MnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3xvzwyOcTX6jrZCmLPn1xPCdXLA1nzGkBSyRyltXjk=;
        b=unvzy+BAyp2ySQNWSU+Ri3kF+2dVS3RGjuf2i6bHArkPp70ibVXiVkzdP0KOhbiiui
         El8u2R/Y01Y6qnRU3eAfgS7XT0Kl0rcBqHeGueyH4d639ajlnZHU5Yxon1u96ZkzHdPt
         ENojfo//8hdoTS5vV1x1m+PKh2IeD2/jETlItCHQmVUkxnNyfTbAaZLOj81kPV72uqln
         4hqtKLoyotwrO7WOZMzpwk+/SNoebBXqTkiS04Gwkfj8N3VMV9I5C7VFad4Iq+0/E1J/
         vgw1UsztioxFWfwc+H+0ZcGJvW1qjNqSIsZf2EXiz+c/Zl5lkxzdIPe3Q/YhjA1ObIhW
         AzSw==
X-Gm-Message-State: APjAAAVilCx6uGTXFi6xJd6hRCmbpu83CVYaRndWvh+9D9bUqN/TJu25
        mio7cFfCle0T5+9Lab7T5Gw=
X-Google-Smtp-Source: APXvYqwAQ8ZhIMvrFsFR4RRaNhv2IV0NL2QgoB1KS82Vk12y4CqKdnUSuXVHDuARmEIGukcWcD/GVA==
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr23670566wrq.164.1581612013884;
        Thu, 13 Feb 2020 08:40:13 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id w19sm3553724wmc.22.2020.02.13.08.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:40:12 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] memory: Introduce memory controller mini-framework
Date:   Thu, 13 Feb 2020 17:39:57 +0100
Message-Id: <20200213163959.819733-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This new framework is currently nothing more than a registry of memory
controllers, with the goal being to order device probing. One use-case
where this is useful, for example, is a memory controller device which
needs to program some registers before the system MMU can be enabled.
Associating the memory controller with the SMMU allows the SMMU driver
to defer the probe until the memory controller has been registered.

One such example is Tegra186 where the memory controller contains some
registers that are used to program stream IDs for the various memory
clients (display, USB, PCI, ...) in the system. Programming these SIDs
is required for the memory clients to emit the proper SIDs as part of
their memory requests. The memory controller driver therefore needs to
be programmed prior to the SMMU driver. To achieve that, the memory
controller will be referenced via phandle from the SMMU device tree
node, the SMMU driver can then use the memory controller framework to
find it and defer probe until it has been registered.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- add device-managed variants of the consumer APIs
- add kerneldoc

Changes in v2:
- fix double unlock (Dan Carpenter, kbuild test robot)
- add helper to get optional memory controllers
- acquire and release module reference

 drivers/memory/Makefile           |   1 +
 drivers/memory/core.c             | 248 ++++++++++++++++++++++++++++++
 include/linux/memory-controller.h |  34 ++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/memory/core.c
 create mode 100644 include/linux/memory-controller.h

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 27b493435e61..d16e7dca8ef9 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -3,6 +3,7 @@
 # Makefile for memory devices
 #
 
+obj-y				+= core.o
 obj-$(CONFIG_DDR)		+= jedec_ddr_data.o
 ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
diff --git a/drivers/memory/core.c b/drivers/memory/core.c
new file mode 100644
index 000000000000..b2fbd2e808de
--- /dev/null
+++ b/drivers/memory/core.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2020 NVIDIA Corporation.
+ */
+
+#include <linux/memory-controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+static DEFINE_MUTEX(controllers_lock);
+static LIST_HEAD(controllers);
+
+static void memory_controller_release(struct kref *ref)
+{
+	struct memory_controller *mc = container_of(ref, struct memory_controller, ref);
+
+	WARN_ON(!list_empty(&mc->list));
+}
+
+/**
+ * memory_controller_register() - register a memory controller
+ * @mc: memory controller
+ */
+int memory_controller_register(struct memory_controller *mc)
+{
+	kref_init(&mc->ref);
+
+	mutex_lock(&controllers_lock);
+	list_add_tail(&mc->list, &controllers);
+	mutex_unlock(&controllers_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(memory_controller_register);
+
+/**
+ * memory_controller_unregister() - unregister a memory controller
+ * @mc: memory controller
+ */
+void memory_controller_unregister(struct memory_controller *mc)
+{
+	mutex_lock(&controllers_lock);
+	list_del_init(&mc->list);
+	mutex_unlock(&controllers_lock);
+
+	kref_put(&mc->ref, memory_controller_release);
+}
+EXPORT_SYMBOL_GPL(memory_controller_unregister);
+
+static struct memory_controller *
+of_memory_controller_get(struct device *dev, struct device_node *np,
+			 const char *con_id)
+{
+	const char *cells = "#memory-controller-cells";
+	const char *names = "memory-controller-names";
+	const char *prop = "memory-controllers";
+	struct memory_controller *mc;
+	struct of_phandle_args args;
+	int index = 0, err;
+
+	if (con_id) {
+		index = of_property_match_string(np, names, con_id);
+		if (index < 0)
+			return ERR_PTR(index);
+	}
+
+	err = of_parse_phandle_with_args(np, prop, cells, index, &args);
+	if (err) {
+		if (err == -ENOENT)
+			err = -ENODEV;
+
+		return ERR_PTR(err);
+	}
+
+	mutex_lock(&controllers_lock);
+
+	list_for_each_entry(mc, &controllers, list) {
+		if (mc->dev && mc->dev->of_node == args.np) {
+			__module_get(mc->dev->driver->owner);
+			kref_get(&mc->ref);
+			goto unlock;
+		}
+	}
+
+	mc = ERR_PTR(-EPROBE_DEFER);
+
+unlock:
+	mutex_unlock(&controllers_lock);
+	of_node_put(args.np);
+	return mc;
+}
+
+/**
+ * memory_controller_get() - obtain a reference to a memory controller
+ * @dev: consumer device
+ * @con_id: consumer name
+ *
+ * Returns: A pointer to the requested memory controller or an ERR_PTR()-
+ * encoded error code on failure.
+ */
+struct memory_controller *
+memory_controller_get(struct device *dev, const char *con_id)
+{
+	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
+		return of_memory_controller_get(dev, dev->of_node, con_id);
+
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(memory_controller_get);
+
+/**
+ * memory_controller_get_optional() - obtain a reference to an optional
+ *                                    memory controller
+ * @dev: consumer device
+ * @con_id: consumer name
+ *
+ * Returns: A pointer to the requested memory controller, NULL if no memory
+ * controller for the consumer device/name pair exists, or an ERR_PTR()-
+ * encoded error code on failure.
+ */
+struct memory_controller *
+memory_controller_get_optional(struct device *dev, const char *con_id)
+{
+	struct memory_controller *mc;
+
+	mc = memory_controller_get(dev, con_id);
+	if (IS_ERR(mc)) {
+		if (mc == ERR_PTR(-ENODEV))
+			return NULL;
+	}
+
+	return mc;
+}
+EXPORT_SYMBOL_GPL(memory_controller_get_optional);
+
+/**
+ * memory_controller_put() - release a reference to a memory controller
+ * @mc: memory controller
+ */
+void memory_controller_put(struct memory_controller *mc)
+{
+	if (mc) {
+		kref_put(&mc->ref, memory_controller_release);
+		module_put(mc->dev->driver->owner);
+	}
+}
+EXPORT_SYMBOL_GPL(memory_controller_put);
+
+static void devm_memory_controller_release(struct device *dev, void *res)
+{
+	memory_controller_put(*(struct memory_controller **)res);
+}
+
+/**
+ * devm_memory_controller_get() - obtain a reference to a memory controller
+ * @dev: consumer device
+ * @con_id: consumer name
+ *
+ * This is a device-managed variant of memory_controller_get(). The memory
+ * controller reference obtained with this function is automatically released
+ * when the device is unbound from its driver.
+ *
+ * Returns: A pointer to the requested memory controller or an ERR_PTR()-
+ * encoded error code on failure.
+ */
+struct memory_controller *devm_memory_controller_get(struct device *dev,
+						     const char *con_id)
+{
+	struct memory_controller **ptr, *mc;
+
+	ptr = devres_alloc(devm_memory_controller_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mc = memory_controller_get(dev, con_id);
+	if (!IS_ERR(mc)) {
+		*ptr = mc;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return mc;
+}
+EXPORT_SYMBOL_GPL(devm_memory_controller_get);
+
+/**
+ * memory_controller_get_optional() - obtain a reference to an optional
+ *                                    memory controller
+ * @dev: consumer device
+ * @con_id: consumer name
+ *
+ * This is a device-managed variant of memory_controller_get_optional(). The
+ * memory controller reference obtained with this function is automatically
+ * released when the device is unbound from its driver.
+ *
+ * Returns: A pointer to the requested memory controller, NULL if no memory
+ * controller for the consumer device/name pair exists, or an ERR_PTR()-
+ * encoded error code on failure.
+ */
+struct memory_controller *
+devm_memory_controller_get_optional(struct device *dev, const char *con_id)
+{
+	struct memory_controller **ptr, *mc;
+
+	ptr = devres_alloc(devm_memory_controller_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mc = memory_controller_get_optional(dev, con_id);
+	if (!IS_ERR(mc)) {
+		*ptr = mc;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return mc;
+}
+EXPORT_SYMBOL_GPL(devm_memory_controller_get_optional);
+
+static int devm_memory_controller_match(struct device *dev, void *res, void *data)
+{
+	struct memory_controller **mc = res;
+
+	if (WARN_ON(!mc || !*mc))
+		return 0;
+
+	return *mc == data;
+}
+
+/**
+ * devm_memory_controller_put() - release a reference to a memory controller
+ * @mc: memory controller
+ *
+ * This is a device-managed variant of memory_controller_put(). Typically it
+ * should never be necessary to call this function, since the device-managed
+ * code should take care of releasing the reference at the right time.
+ */
+void devm_memory_controller_put(struct device *dev,
+				struct memory_controller *mc)
+{
+	WARN_ON(devres_release(dev, devm_memory_controller_release,
+			       devm_memory_controller_match, mc));
+}
+EXPORT_SYMBOL_GPL(devm_memory_controller_put);
diff --git a/include/linux/memory-controller.h b/include/linux/memory-controller.h
new file mode 100644
index 000000000000..54490cb5e625
--- /dev/null
+++ b/include/linux/memory-controller.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2020 NVIDIA Corporation.
+ */
+
+#ifndef _LINUX_MEMORY_CONTROLLER_H
+#define _LINUX_MEMORY_CONTROLLER_H
+
+#include <linux/device.h>
+#include <linux/list.h>
+
+struct memory_controller {
+	struct device *dev;
+	struct kref ref;
+	struct list_head list;
+};
+
+int memory_controller_register(struct memory_controller *mc);
+void memory_controller_unregister(struct memory_controller *mc);
+
+struct memory_controller *memory_controller_get(struct device *dev,
+						const char *con_id);
+struct memory_controller *memory_controller_get_optional(struct device *dev,
+							 const char *con_id);
+void memory_controller_put(struct memory_controller *mc);
+
+struct memory_controller *devm_memory_controller_get(struct device *dev,
+						     const char *con_id);
+struct memory_controller *
+devm_memory_controller_get_optional(struct device *dev, const char *con_id);
+void devm_memory_controller_put(struct device *dev,
+				struct memory_controller *mc);
+
+#endif
-- 
2.24.1

