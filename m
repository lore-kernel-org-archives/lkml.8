Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471D1C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBFF2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKjiT2EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYNUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:20:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgCYNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:19:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id c187so2451030wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeWwoiTwnnQBgQeaDINh2+YlH10mlEqxsqlmp3qMGMk=;
        b=kKjiT2EPU4sTiC29H2tKkyDmu+P91BptvBts+v0o7QcFQL2hZD/tz38Tz2CGBe4IrF
         FjNQGYAEyuO7/ZirFGo+5N12cfcnbMl2JwXzqhUMXfU6bZDYOrYr9nxX7BBLOAFxo56J
         YxmEYyc21uaP+3Reky0cCvkODFXRZGtwburxBMCXjgpkXKf+5CBZ30g2HZGgtJ7wUzXo
         A6QBrh3G260RYd3W+6uGjGXBOiOL26dxZJciW2EQKP2m+TkFffU2IMyb8y8iCgkB91M9
         8SpJwmUHhE6iCe5NMLFEOr0Sn/wOjenLLpWrzxhXRdiNQwfGtzv2RWOSesZ+ZKU76Q+B
         W6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeWwoiTwnnQBgQeaDINh2+YlH10mlEqxsqlmp3qMGMk=;
        b=HHx7gwXsWjBcedDv1TQ87yr1zgxRAlEZaoluIE2El79ZYmW1gSLZkaEwY6TFnhiyA+
         ymzDiBR7D6R88EtjTD/Fheg/CrhiXItPWlgLN1iYyKd4oXxJLKHngbqGLaLsn0yoDCkF
         Lz4etIRXlbGxT4bl8gSmTcTUMQbqKDcNXullio45vICXTd6VD8V+HFnSpxm7F+Y7dfxy
         S3+y+dBpV4HQkH9i0e2QJ+ew3jybmHxmKL13eAOr+Wzol2ccRkiYp5o4URpjlSsg4RRb
         I9zKFHE/+1MCskv7iPER3fKUpoaAfDQ6Szj5ld9US5QImR91PgPReZIADj9RtQP8ZkRK
         0wAw==
X-Gm-Message-State: ANhLgQ287xQYNNkIEQwSJBun5L5xQhtlPACE4d5G4g0/4RnOacOZVS+Z
        qa88LWeMyzx71i9pk5GKwd+ftA==
X-Google-Smtp-Source: ADFU+vvLt45pn+G7MwQCKN4DFBvQSIJk1lk+U7DmpY/iTXR84dw9yhD1NYsmnvhgmR9+j5OlpyH4zQ==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr3450110wmc.178.1585142396276;
        Wed, 25 Mar 2020 06:19:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d21sm33558302wrb.51.2020.03.25.06.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:19:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 2/2] nvmem: core: remove nvmem_sysfs_get_groups()
Date:   Wed, 25 Mar 2020 13:19:51 +0000
Message-Id: <20200325131951.31887-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325131951.31887-1-srinivas.kandagatla@linaro.org>
References: <20200325131951.31887-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are using is_bin_visible callback, we do not need
nvmem_sysfs_get_groups() anymore so move all the relevant data-structures
and code to core.c

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Makefile      |   3 -
 drivers/nvmem/core.c        | 274 +++++++++++++++++++++++++++++++++++-
 drivers/nvmem/nvmem-sysfs.c | 240 -------------------------------
 drivers/nvmem/nvmem.h       |  61 --------
 4 files changed, 272 insertions(+), 306 deletions(-)
 delete mode 100644 drivers/nvmem/nvmem-sysfs.c
 delete mode 100644 drivers/nvmem/nvmem.h

diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 65a268d17807..a7c377218341 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -6,9 +6,6 @@
 obj-$(CONFIG_NVMEM)		+= nvmem_core.o
 nvmem_core-y			:= core.o
 
-obj-$(CONFIG_NVMEM_SYSFS)	+= nvmem_sysfs.o
-nvmem_sysfs-y			:= nvmem-sysfs.o
-
 # Devices
 obj-$(CONFIG_NVMEM_BCM_OCOTP)	+= nvmem-bcm-ocotp.o
 nvmem-bcm-ocotp-y		:= bcm-ocotp.o
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 477085208957..05c6ae4b0b97 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -18,7 +18,31 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/slab.h>
-#include "nvmem.h"
+
+struct nvmem_device {
+	struct module		*owner;
+	struct device		dev;
+	int			stride;
+	int			word_size;
+	int			id;
+	struct kref		refcnt;
+	size_t			size;
+	bool			read_only;
+	bool			root_only;
+	int			flags;
+	enum nvmem_type		type;
+	struct bin_attribute	eeprom;
+	struct device		*base_dev;
+	struct list_head	cells;
+	nvmem_reg_read_t	reg_read;
+	nvmem_reg_write_t	reg_write;
+	struct gpio_desc	*wp_gpio;
+	void *priv;
+};
+
+#define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
+
+#define FLAG_COMPAT		BIT(0)
 
 struct nvmem_cell {
 	const char		*name;
@@ -42,6 +66,250 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
+#ifdef CONFIG_NVMEM_SYSFS
+static const char * const nvmem_type_str[] = {
+	[NVMEM_TYPE_UNKNOWN] = "Unknown",
+	[NVMEM_TYPE_EEPROM] = "EEPROM",
+	[NVMEM_TYPE_OTP] = "OTP",
+	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
+};
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key eeprom_lock_key;
+#endif
+
+static ssize_t type_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
+}
+
+static DEVICE_ATTR_RO(type);
+
+static struct attribute *nvmem_attrs[] = {
+	&dev_attr_type.attr,
+	NULL,
+};
+
+static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf,
+				   loff_t pos, size_t count)
+{
+	struct device *dev;
+	struct nvmem_device *nvmem;
+	int rc;
+
+	if (attr->private)
+		dev = attr->private;
+	else
+		dev = container_of(kobj, struct device, kobj);
+	nvmem = to_nvmem_device(dev);
+
+	/* Stop the user from reading */
+	if (pos >= nvmem->size)
+		return 0;
+
+	if (count < nvmem->word_size)
+		return -EINVAL;
+
+	if (pos + count > nvmem->size)
+		count = nvmem->size - pos;
+
+	count = round_down(count, nvmem->word_size);
+
+	if (!nvmem->reg_read)
+		return -EPERM;
+
+	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
+
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *attr, char *buf,
+				    loff_t pos, size_t count)
+{
+	struct device *dev;
+	struct nvmem_device *nvmem;
+	int rc;
+
+	if (attr->private)
+		dev = attr->private;
+	else
+		dev = container_of(kobj, struct device, kobj);
+	nvmem = to_nvmem_device(dev);
+
+	/* Stop the user from writing */
+	if (pos >= nvmem->size)
+		return -EFBIG;
+
+	if (count < nvmem->word_size)
+		return -EINVAL;
+
+	if (pos + count > nvmem->size)
+		count = nvmem->size - pos;
+
+	count = round_down(count, nvmem->word_size);
+
+	if (!nvmem->reg_write)
+		return -EPERM;
+
+	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
+
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
+					 struct bin_attribute *attr, int i)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+	umode_t mode = 0400;
+
+	if (!nvmem->root_only)
+		mode |= 0044;
+
+	if (!nvmem->read_only)
+		mode |= 0200;
+
+	if (!nvmem->reg_write)
+		mode &= ~0200;
+
+	if (!nvmem->reg_read)
+		mode &= ~0444;
+
+	return mode;
+}
+
+/* default read/write permissions */
+static struct bin_attribute bin_attr_rw_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0644,
+	},
+	.read	= bin_attr_nvmem_read,
+	.write	= bin_attr_nvmem_write,
+};
+
+static struct bin_attribute *nvmem_bin_attributes[] = {
+	&bin_attr_rw_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_group = {
+	.bin_attrs	= nvmem_bin_attributes,
+	.attrs		= nvmem_attrs,
+	.is_bin_visible = nvmem_bin_attr_is_visible,
+};
+
+static const struct attribute_group *nvmem_dev_groups[] = {
+	&nvmem_bin_group,
+	NULL,
+};
+
+/* read only permission */
+static struct bin_attribute bin_attr_ro_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0444,
+	},
+	.read	= bin_attr_nvmem_read,
+};
+
+/* default read/write permissions, root only */
+static struct bin_attribute bin_attr_rw_root_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0600,
+	},
+	.read	= bin_attr_nvmem_read,
+	.write	= bin_attr_nvmem_write,
+};
+
+/* read only permission, root only */
+static struct bin_attribute bin_attr_ro_root_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0400,
+	},
+	.read	= bin_attr_nvmem_read,
+};
+
+/*
+ * nvmem_setup_compat() - Create an additional binary entry in
+ * drivers sys directory, to be backwards compatible with the older
+ * drivers/misc/eeprom drivers.
+ */
+static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
+				    const struct nvmem_config *config)
+{
+	int rval;
+
+	if (!config->compat)
+		return 0;
+
+	if (!config->base_dev)
+		return -EINVAL;
+
+	if (nvmem->read_only) {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_ro_root_nvmem;
+		else
+			nvmem->eeprom = bin_attr_ro_nvmem;
+	} else {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_rw_root_nvmem;
+		else
+			nvmem->eeprom = bin_attr_rw_nvmem;
+	}
+	nvmem->eeprom.attr.name = "eeprom";
+	nvmem->eeprom.size = nvmem->size;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	nvmem->eeprom.attr.key = &eeprom_lock_key;
+#endif
+	nvmem->eeprom.private = &nvmem->dev;
+	nvmem->base_dev = config->base_dev;
+
+	rval = device_create_bin_file(nvmem->base_dev, &nvmem->eeprom);
+	if (rval) {
+		dev_err(&nvmem->dev,
+			"Failed to create eeprom binary file %d\n", rval);
+		return rval;
+	}
+
+	nvmem->flags |= FLAG_COMPAT;
+
+	return 0;
+}
+
+static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
+			      const struct nvmem_config *config)
+{
+	if (config->compat)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
+}
+
+#else /* CONFIG_NVMEM_SYSFS */
+
+static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
+				    const struct nvmem_config *config)
+{
+	return -ENOSYS;
+}
+static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
+				      const struct nvmem_config *config)
+{
+}
+
+#endif /* CONFIG_NVMEM_SYSFS */
 
 static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			  void *val, size_t bytes)
@@ -396,7 +664,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-	nvmem->dev.groups = nvmem_sysfs_get_groups();
+#ifdef CONFIG_NVMEM_SYSFS
+	nvmem->dev.groups = nvmem_dev_groups;
+#endif
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
deleted file mode 100644
index b1bb3e5d1221..000000000000
--- a/drivers/nvmem/nvmem-sysfs.c
+++ /dev/null
@@ -1,240 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019, Linaro Limited
- */
-#include "nvmem.h"
-
-static const char * const nvmem_type_str[] = {
-	[NVMEM_TYPE_UNKNOWN] = "Unknown",
-	[NVMEM_TYPE_EEPROM] = "EEPROM",
-	[NVMEM_TYPE_OTP] = "OTP",
-	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
-};
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-static struct lock_class_key eeprom_lock_key;
-#endif
-
-static ssize_t type_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	struct nvmem_device *nvmem = to_nvmem_device(dev);
-
-	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
-}
-
-static DEVICE_ATTR_RO(type);
-
-static struct attribute *nvmem_attrs[] = {
-	&dev_attr_type.attr,
-	NULL,
-};
-
-static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr,
-				    char *buf, loff_t pos, size_t count)
-{
-	struct device *dev;
-	struct nvmem_device *nvmem;
-	int rc;
-
-	if (attr->private)
-		dev = attr->private;
-	else
-		dev = container_of(kobj, struct device, kobj);
-	nvmem = to_nvmem_device(dev);
-
-	/* Stop the user from reading */
-	if (pos >= nvmem->size)
-		return 0;
-
-	if (count < nvmem->word_size)
-		return -EINVAL;
-
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
-	count = round_down(count, nvmem->word_size);
-
-	if (!nvmem->reg_read)
-		return -EPERM;
-
-	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
-
-	if (rc)
-		return rc;
-
-	return count;
-}
-
-static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr,
-				     char *buf, loff_t pos, size_t count)
-{
-	struct device *dev;
-	struct nvmem_device *nvmem;
-	int rc;
-
-	if (attr->private)
-		dev = attr->private;
-	else
-		dev = container_of(kobj, struct device, kobj);
-	nvmem = to_nvmem_device(dev);
-
-	/* Stop the user from writing */
-	if (pos >= nvmem->size)
-		return -EFBIG;
-
-	if (count < nvmem->word_size)
-		return -EINVAL;
-
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
-	count = round_down(count, nvmem->word_size);
-
-	if (!nvmem->reg_write)
-		return -EPERM;
-
-	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
-
-	if (rc)
-		return rc;
-
-	return count;
-}
-
-static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
-					 struct bin_attribute *attr, int i)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvmem_device *nvmem = to_nvmem_device(dev);
-	umode_t mode = 0400;
-
-	if (!nvmem->root_only)
-		mode |= 0044;
-
-	if (!nvmem->read_only)
-		mode |= 0200;
-
-	if (!nvmem->reg_write)
-		mode &= ~0200;
-
-	if (!nvmem->reg_read)
-		mode &= ~0444;
-
-	return mode;
-}
-
-/* default read/write permissions */
-static struct bin_attribute bin_attr_rw_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0644,
-	},
-	.read	= bin_attr_nvmem_read,
-	.write	= bin_attr_nvmem_write,
-};
-
-static struct bin_attribute *nvmem_bin_attributes[] = {
-	&bin_attr_rw_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_group = {
-	.bin_attrs	= nvmem_bin_attributes,
-	.attrs		= nvmem_attrs,
-	.is_bin_visible = nvmem_bin_attr_is_visible,
-};
-
-static const struct attribute_group *nvmem_dev_groups[] = {
-	&nvmem_bin_group,
-	NULL,
-};
-
-/* read only permission */
-static struct bin_attribute bin_attr_ro_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0444,
-	},
-	.read	= bin_attr_nvmem_read,
-};
-
-/* default read/write permissions, root only */
-static struct bin_attribute bin_attr_rw_root_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0600,
-	},
-	.read	= bin_attr_nvmem_read,
-	.write	= bin_attr_nvmem_write,
-};
-
-/* read only permission, root only */
-static struct bin_attribute bin_attr_ro_root_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0400,
-	},
-	.read	= bin_attr_nvmem_read,
-};
-
-const struct attribute_group **nvmem_sysfs_get_groups(void)
-{
-	return nvmem_dev_groups;
-}
-
-/*
- * nvmem_setup_compat() - Create an additional binary entry in
- * drivers sys directory, to be backwards compatible with the older
- * drivers/misc/eeprom drivers.
- */
-int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
-			      const struct nvmem_config *config)
-{
-	int rval;
-
-	if (!config->compat)
-		return 0;
-
-	if (!config->base_dev)
-		return -EINVAL;
-
-	if (nvmem->read_only) {
-		if (config->root_only)
-			nvmem->eeprom = bin_attr_ro_root_nvmem;
-		else
-			nvmem->eeprom = bin_attr_ro_nvmem;
-	} else {
-		if (config->root_only)
-			nvmem->eeprom = bin_attr_rw_root_nvmem;
-		else
-			nvmem->eeprom = bin_attr_rw_nvmem;
-	}
-	nvmem->eeprom.attr.name = "eeprom";
-	nvmem->eeprom.size = nvmem->size;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	nvmem->eeprom.attr.key = &eeprom_lock_key;
-#endif
-	nvmem->eeprom.private = &nvmem->dev;
-	nvmem->base_dev = config->base_dev;
-
-	rval = device_create_bin_file(nvmem->base_dev, &nvmem->eeprom);
-	if (rval) {
-		dev_err(&nvmem->dev,
-			"Failed to create eeprom binary file %d\n", rval);
-		return rval;
-	}
-
-	nvmem->flags |= FLAG_COMPAT;
-
-	return 0;
-}
-
-void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
-			      const struct nvmem_config *config)
-{
-	if (config->compat)
-		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
-}
diff --git a/drivers/nvmem/nvmem.h b/drivers/nvmem/nvmem.h
deleted file mode 100644
index 478b796bd637..000000000000
--- a/drivers/nvmem/nvmem.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _DRIVERS_NVMEM_H
-#define _DRIVERS_NVMEM_H
-
-#include <linux/device.h>
-#include <linux/fs.h>
-#include <linux/kref.h>
-#include <linux/list.h>
-#include <linux/nvmem-consumer.h>
-#include <linux/nvmem-provider.h>
-#include <linux/gpio/consumer.h>
-
-struct nvmem_device {
-	struct module		*owner;
-	struct device		dev;
-	int			stride;
-	int			word_size;
-	int			id;
-	struct kref		refcnt;
-	size_t			size;
-	bool			read_only;
-	bool			root_only;
-	int			flags;
-	enum nvmem_type		type;
-	struct bin_attribute	eeprom;
-	struct device		*base_dev;
-	struct list_head	cells;
-	nvmem_reg_read_t	reg_read;
-	nvmem_reg_write_t	reg_write;
-	struct gpio_desc	*wp_gpio;
-	void *priv;
-};
-
-#define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
-#define FLAG_COMPAT		BIT(0)
-
-#ifdef CONFIG_NVMEM_SYSFS
-const struct attribute_group **nvmem_sysfs_get_groups(void);
-int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
-			      const struct nvmem_config *config);
-void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
-			      const struct nvmem_config *config);
-#else
-static inline const struct attribute_group **nvmem_sysfs_get_groups(void)
-{
-	return NULL;
-}
-
-static inline int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
-				      const struct nvmem_config *config)
-{
-	return -ENOSYS;
-}
-static inline void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
-			      const struct nvmem_config *config)
-{
-}
-#endif /* CONFIG_NVMEM_SYSFS */
-
-#endif /* _DRIVERS_NVMEM_H */
-- 
2.21.0

