Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1697CC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1ED206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="W5neKHtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgDGIa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:30:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgDGIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:30:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id c15so2786031wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yx+tINXIME57q+zwEQX7GUc2q689uTp0DHJLLnExQdI=;
        b=W5neKHtjNtN2qdnv1EvBBnImqR/p9wXjP7dgPXGwM/blFqUYA7aAi2smhDGUZHSlHm
         GC+u8nxbhK0TtsfGPwGJaxlYofw4lDL03SA0S9RtvV7czkvO7xqJ7uaSF5uxlpKqIKu3
         XDWeph6xHiOQQus/xjYANK53ks31G8BjXyA1wlGzZ3z3CczDE7U8l0YEXy6Qvx4JoKUa
         lXcfhPtLMEhFrudtWs5VSyUsGdD59bWXr17rDRV8XFntWaRx5kWpRA/rkg8sl7EcGu2E
         IqYh4TseoEft8/r2v6EV6fP9pplaWVVAnI6cwL5KydbTXhgPID/CpHCE78eQNZVXH35u
         hnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yx+tINXIME57q+zwEQX7GUc2q689uTp0DHJLLnExQdI=;
        b=Itx9eIHW7BzGd9ftcPCn3IGyoRnY3LVNZ/ImjGRQcHEj8Rzmr2QzoxVZ8/YFpWyOvc
         rG4h8RclJxSwHD6WfSMiHg9Mo5GnDfqbPf01BjB/1smd5XzDM9aPncJQGP7VsQmaqt8H
         0/kCuSo7vU4BI1VxbfmjFIMgVGenikA0dcVp8r2297bIl6B1QUKWhlXVz77RkIih5CIN
         mO0Sv0MVwLbZZGLmCabWZZGNsFtNIMAx8gSpUp4eRWxRR2NF3kHkzPJsUXFupssw4zVE
         zQuifcPdPfbCMNUh6TIwNLHdwifIuvOSN4K/w841eOenha5W6YLFvt2h5agdwilSS2uh
         zTAA==
X-Gm-Message-State: AGi0PubDCm/85/NSh9EZsTZjaEMXLb2gcH+7eQqgKdxVJMeX79Iv8IFk
        8wy/DPbiQnbCJrVW7sgDfgLmayRC1LD1UUxl
X-Google-Smtp-Source: APiQypLn1I5bDOjHiqrEKv9WNcKpmBw+2qlHgD1bJnnUppVm6vexnSseG8TsgmdvTfuAFULHBEUvrQ==
X-Received: by 2002:a5d:5447:: with SMTP id w7mr270939wrv.312.1586248254215;
        Tue, 07 Apr 2020 01:30:54 -0700 (PDT)
Received: from localhost.localdomain (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id t16sm31190743wra.17.2020.04.07.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 01:30:53 -0700 (PDT)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 2/2] firmware: google: Expose coreboot tables over sysfs
Date:   Tue,  7 Apr 2020 10:29:07 +0200
Message-Id: <20200407082923.2001556-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Make all coreboot table entries available to userland. This is useful for
tools that are currently using /dev/mem.

Besides the tag and size also expose the raw table data itself.

Update the ABI documentation to explain the new sysfs interface.

Tools can easily scan for the right coreboot table by reading
/sys/bus/coreboot/devices/coreboot*/attributes/id
The binary table data can then be read from
/sys/bus/coreboot/devices/coreboot*/attributes/data

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 -v2:
        - Add ABI documentation
        - Add 0x prefix on hex values
        - Remove wrong ioremap hint as found by CI
 -v3:
        - Use BIN_ATTR_RO
 -v4:
        - Updated ABI documentation
---
 Documentation/ABI/stable/sysfs-bus-coreboot | 30 +++++++++++
 drivers/firmware/google/coreboot_table.c    | 58 +++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/ABI/stable/sysfs-bus-coreboot
index 6055906f41f2..328153a1b3f4 100644
--- a/Documentation/ABI/stable/sysfs-bus-coreboot
+++ b/Documentation/ABI/stable/sysfs-bus-coreboot
@@ -42,3 +42,33 @@ Description:
 		buffer.
 		The file holds a read-only binary representation of the CBMEM
 		buffer.
+
+What:		/sys/bus/coreboot/devices/.../attributes/id
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named attributes/id.
+		The file holds an ASCII representation of the coreboot table ID
+		in hex (e.g. 0x000000ef). On coreboot enabled platforms the ID is
+		usually called TAG.
+
+What:		/sys/bus/coreboot/devices/.../attributes/size
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		attributes/size.
+		The file holds an ASCII representation as decimal number of the
+		coreboot table size (e.g. 64).
+
+What:		/sys/bus/coreboot/devices/.../attributes/data
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		attributes/data.
+		The file holds a read-only binary representation of the coreboot
+		table.
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 0205987a4fd4..d0fc3eb93f4f 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -3,9 +3,11 @@
  * coreboot_table.c
  *
  * Module providing coreboot table access.
+ * Exports coreboot tables as attributes in sysfs.
  *
  * Copyright 2017 Google Inc.
  * Copyright 2017 Samuel Holland <samuel@sholland.org>
+ * Copyright 2019 9elements Agency GmbH
  */
 
 #include <linux/acpi.h>
@@ -84,6 +86,60 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
 }
 EXPORT_SYMBOL(coreboot_driver_unregister);
 
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buffer)
+{
+	struct coreboot_device *device = CB_DEV(dev);
+
+	return sprintf(buffer, "0x%08x\n", device->entry.tag);
+}
+
+static ssize_t size_show(struct device *dev,
+			 struct device_attribute *attr, char *buffer)
+{
+	struct coreboot_device *device = CB_DEV(dev);
+
+	return sprintf(buffer, "%u\n", device->entry.size);
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(size);
+
+static struct attribute *cb_dev_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_size.attr,
+	NULL
+};
+
+static ssize_t data_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr,
+			 char *buffer, loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct coreboot_device *device = CB_DEV(dev);
+
+	return memory_read_from_buffer(buffer, count, &offset,
+				       &device->entry, device->entry.size);
+}
+
+static BIN_ATTR_RO(data, 0);
+
+static struct bin_attribute *cb_dev_bin_attrs[] = {
+	&bin_attr_data,
+	NULL
+};
+
+static const struct attribute_group cb_dev_attr_group = {
+	.name = "attributes",
+	.attrs = cb_dev_attrs,
+	.bin_attrs = cb_dev_bin_attrs,
+};
+
+static const struct attribute_group *cb_dev_attr_groups[] = {
+	&cb_dev_attr_group,
+	NULL
+};
+
 static int coreboot_table_populate(struct device *dev, void *ptr)
 {
 	int i, ret;
@@ -104,6 +160,8 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
+		device->dev.groups = cb_dev_attr_groups;
+
 		memcpy(&device->entry, ptr_entry, entry->size);
 
 		ret = device_register(&device->dev);
-- 
2.24.1

