Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A58C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7EA208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="svxPFXRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgDITgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:36:04 -0400
Received: from mail.efficios.com ([167.114.26.124]:47262 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgDITgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:36:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C4D51280F69;
        Thu,  9 Apr 2020 15:36:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Iu2B-BGqI4gr; Thu,  9 Apr 2020 15:36:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1705C281200;
        Thu,  9 Apr 2020 15:36:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1705C281200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460961;
        bh=VbkSSTgEtg5EweJjkn8hi6f0BIj1Gk8/vOXExdpl4Pk=;
        h=From:To:Date:Message-Id;
        b=svxPFXRcR0UdQNb5ymUKBSaXopWx+XQiXtrgSBwsBwopPVopZZ0HKU6m9RcEd6zuC
         G1MTLl1x0y01dRvfVKVUAH91txYrn2MAr6+4RBp9aklXjvc1oO2o6k6Ykya1fAIkoG
         XZbmma7Es/pyJRMR9OQld6rQlH88IT54q+1AzPqcmsJaOb3FZb1wdRPaRr/zwF9LUA
         EXLgXyq8n6v+H8bohmfoYL4uKU+EcLjusUZ0siXoUoddBgimW608/rCv7cAeXi4Npb
         EXvOG+6g6dbAW0b6dc2Wk/pUCsFcW3TKyStp5hI5RKKnrUeMKTqWivoql/FHarPrqb
         hReId+6XhagvQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UU5w3AgyhBhd; Thu,  9 Apr 2020 15:36:01 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id CD40A280DFB;
        Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 9/9] block: genhd: export-GPL generic disk block class
Date:   Thu,  9 Apr 2020 15:35:43 -0400
Message-Id: <20200409193543.18115-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "block_class" symbol is currently used across the kernel tree
without a clear namespace. It is also unavailable for GPL modules for
iteration over generic disks.

Introduce a GPL-exported gendisk_block_class() to get the generic disk
block class. Make "block_class" static, therefore limiting its scope to
genhd.c.

Replace all use of "block_class" across the kernel tree by use of the
new getter function.

This is useful for tracing a meaningful list of block devices from
tracers implemented as GPL modules.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 block/genhd.c           | 16 +++++++++++++---
 block/partitions/core.c |  2 +-
 drivers/base/class.c    |  2 +-
 drivers/base/core.c     | 15 ++++++++-------
 drivers/base/devtmpfs.c |  2 +-
 include/linux/genhd.h   |  2 +-
 init/do_mounts.c        |  4 ++--
 7 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e104b696002f..c87c83983d72 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -40,6 +40,10 @@ static DEFINE_IDR(ext_devt_idr);
 
 static const struct device_type disk_type;
 
+static struct class block_class = {
+	.name		= "block",
+};
+
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr);
 static void disk_alloc_events(struct gendisk *disk);
@@ -1525,9 +1529,15 @@ static void disk_release(struct device *dev)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
-struct class block_class = {
-	.name		= "block",
-};
+
+/*
+ * Return the generic disk block class.
+ */
+struct class *gendisk_block_class(void)
+{
+	return &block_class;
+}
+EXPORT_SYMBOL_GPL(gendisk_block_class);
 
 static char *block_devnode(struct device *dev, umode_t *mode,
 			   kuid_t *uid, kgid_t *gid)
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 56f0b730a2a0..419dcdb811b3 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -413,7 +413,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		dev_set_name(pdev, "%s%d", dname, partno);
 
 	device_initialize(pdev);
-	pdev->class = &block_class;
+	pdev->class = gendisk_block_class();
 	pdev->type = &part_type;
 	pdev->parent = ddev;
 
diff --git a/drivers/base/class.c b/drivers/base/class.c
index bcd410e6d70a..a6dea6d8bfd6 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -176,7 +176,7 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 
 #if defined(CONFIG_BLOCK)
 	/* let the block class directory show up in the root of sysfs */
-	if (!sysfs_deprecated || cls != &block_class)
+	if (!sysfs_deprecated || cls != gendisk_block_class())
 		cp->subsys.kobj.kset = class_kset;
 #else
 	cp->subsys.kobj.kset = class_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 139cdf7e7327..84657fca67f5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2062,13 +2062,14 @@ static struct kobject *get_device_parent(struct device *dev,
 		struct kobject *kobj = NULL;
 		struct kobject *parent_kobj;
 		struct kobject *k;
-
 #ifdef CONFIG_BLOCK
+		struct class *block_class = gendisk_block_class();
+
 		/* block disks show up in /sys/block */
-		if (sysfs_deprecated && dev->class == &block_class) {
-			if (parent && parent->class == &block_class)
+		if (sysfs_deprecated && dev->class == block_class) {
+			if (parent && parent->class == block_class)
 				return &parent->kobj;
-			return &block_class.p->subsys.kobj;
+			return &block_class->p->subsys.kobj;
 		}
 #endif
 
@@ -2228,7 +2229,7 @@ static int device_add_class_symlinks(struct device *dev)
 
 #ifdef CONFIG_BLOCK
 	/* /sys/block has directories and does not need symlinks */
-	if (sysfs_deprecated && dev->class == &block_class)
+	if (sysfs_deprecated && dev->class == gendisk_block_class())
 		return 0;
 #endif
 
@@ -2262,7 +2263,7 @@ static void device_remove_class_symlinks(struct device *dev)
 		sysfs_remove_link(&dev->kobj, "device");
 	sysfs_remove_link(&dev->kobj, "subsystem");
 #ifdef CONFIG_BLOCK
-	if (sysfs_deprecated && dev->class == &block_class)
+	if (sysfs_deprecated && dev->class == gendisk_block_class())
 		return;
 #endif
 	sysfs_delete_link(&dev->class->p->subsys.kobj, &dev->kobj, dev_name(dev));
@@ -3603,7 +3604,7 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 		goto out;
 
 #ifdef CONFIG_BLOCK
-	if (sysfs_deprecated && dev->class == &block_class)
+	if (sysfs_deprecated && dev->class == gendisk_block_class())
 		goto out;
 #endif
 
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index c9017e0584c0..05cbc8ead4d8 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -83,7 +83,7 @@ static struct file_system_type dev_fs_type = {
 #ifdef CONFIG_BLOCK
 static inline int is_blockdev(struct device *dev)
 {
-	return dev->class == &block_class;
+	return dev->class == gendisk_block_class();
 }
 #else
 static inline int is_blockdev(struct device *dev) { return 0; }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 3307dfae72cb..953c03da3ed0 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -27,7 +27,6 @@
 #define part_to_dev(part)	(&((part)->__dev))
 
 extern struct device_type part_type;
-extern struct class block_class;
 
 #define DISK_MAX_PARTS			256
 #define DISK_NAME_LEN			32
@@ -354,6 +353,7 @@ extern void blk_register_region(dev_t devt, unsigned long range,
 extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 extern const struct device_type *gendisk_device_type(void);
+extern struct class *gendisk_block_class(void);
 
 #define alloc_disk_node(minors, node_id)				\
 ({									\
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 29d326b6c29d..b94a47589cee 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -138,7 +138,7 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 		goto done;
 	}
 
-	dev = class_find_device(&block_class, NULL, &cmp,
+	dev = class_find_device(gendisk_block_class(), NULL, &cmp,
 				&match_dev_by_uuid);
 	if (!dev)
 		goto done;
@@ -237,7 +237,7 @@ dev_t name_to_dev_t(const char *name)
 	} else if (strncmp(name, "PARTLABEL=", 10) == 0) {
 		struct device *dev;
 
-		dev = class_find_device(&block_class, NULL, name + 10,
+		dev = class_find_device(gendisk_block_class(), NULL, name + 10,
 					&match_dev_by_label);
 		if (!dev)
 			goto fail;
-- 
2.17.1

