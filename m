Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728BC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7002054F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgDRQWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:22:49 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:5644 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgDRQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 12:22:49 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 2D1144E14F9;
        Sun, 19 Apr 2020 00:22:35 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, oss@buserror.net,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, rdunlap@infradead.org,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v6,4/4] drivers: misc: new driver sram_uapi for user level SRAM  access
Date:   Sat, 18 Apr 2020 09:21:57 -0700
Message-Id: <20200418162157.50428-5-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418162157.50428-1-wenhu.wang@vivo.com>
References: <20200418162157.50428-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVLS05LS0tKSk9PT0tCSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6OQw5DjgxFg05OCkBLDUd
        QwsKFCFVSlVKTkNMSUlNQk5DTEpLVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUpLQk9CNwY+
X-HM-Tid: 0a718e194eef9376kuws2d1144e14f9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A generic User-Kernel interface that allows a misc device created
by it to support file-operations of ioctl and mmap to access SRAM
memory from user level. Different kinds of SRAM alloction and free
APIs could be added to the available array and could be configured
from user level.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
Notes:
	Implement the interface driver for SRAM access from user
	level upon the comments from Scott.
	The former versions(1-5) were implemented with UIO, but for this
	version, UIO is not used as suggested by Scott.
Links:
	https://lore.kernel.org/patchwork/patch/1226475/
	https://lore.kernel.org/patchwork/patch/1225798/
---
 drivers/misc/Kconfig     |  25 ++++
 drivers/misc/Makefile    |   1 +
 drivers/misc/sram_uapi.c | 294 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/misc/sram_uapi.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 99e151475d8f..e6897ba22684 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -465,6 +465,31 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config SRAM_UAPI
+	bool "Generic SRAM User Level API driver"
+	help
+	  This driver allows you to create a misc device which could be used
+	  as an interface to allocate SRAM memory from user level.
+
+	  It is extremely helpful for some user space applications that require
+	  high performance memory accesses.
+
+	  If unsure, say N.
+
+if SRAM_UAPI
+
+config FSL_85XX_SRAM_UAPI
+	bool "Freescale MPC85xx Cache-SRAM UAPI support"
+	depends on FSL_SOC_BOOKE && PPC32
+	select FSL_85XX_CACHE_SRAM
+	help
+	  This adds the Freescale MPC85xx Cache-SRAM memory allocation and
+	  free interfaces to the available SRAM API array, which finally could
+	  be used from user level to access the Freescale MPC85xx Cache-SRAM
+	  memory.
+
+endif
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9abf2923d831..794447ca07ca 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
+obj-$(CONFIG_SRAM_UAPI)		+= sram_uapi.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
diff --git a/drivers/misc/sram_uapi.c b/drivers/misc/sram_uapi.c
new file mode 100644
index 000000000000..53f818e1898d
--- /dev/null
+++ b/drivers/misc/sram_uapi.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
+ * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
+ * All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+
+#define DRIVER_NAME	"sram_uapi"
+
+#define SRAM_UAPI_IOCTL_SET_SRAM_TYPE	0
+#define SRAM_UAPI_IOCTL_ALLOC		1
+#define SRAM_UAPI_IOCTL_FREE		2
+
+struct res_info {
+	u32 offset;
+	u32 size;
+};
+
+struct sram_resource {
+	struct list_head	list;
+	struct res_info		info;
+	phys_addr_t		phys;
+	void			*virt;
+	struct vm_area_struct	*vma;
+	struct sram_uapi	*parent;
+};
+
+struct sram_api {
+	u32 type;
+	long (*sram_alloc)(u32 size, phys_addr_t *phys, u32 align);
+	void (*sram_free)(void *ptr);
+};
+
+struct sram_uapi {
+	struct list_head	res_list;
+	struct sram_api		*sa;
+};
+
+enum SRAM_TYPE {
+#ifdef FSL_85XX_CACHE_SRAM
+	SRAM_TYPE_FSL_85XX_CACHE_SRAM,
+#endif
+	SRAM_TYPE_MAX,
+};
+
+/* keep the SRAM_TYPE value the same with array index */
+static struct sram_api srams[] = {
+#ifdef FSL_85XX_CACHE_SRAM
+	{
+		.type		= SRAM_TYPE_FSL_85XX_CACHE_SRAM,
+		.sram_alloc	= mpc85xx_cache_sram_alloc,
+		.sram_free	= mpc85xx_cache_sram_free,
+	},
+#endif
+};
+
+static void sram_uapi_res_insert(struct sram_uapi *uapi,
+				 struct sram_resource *res)
+{
+	struct sram_resource *cur, *tmp;
+	struct list_head *head = &uapi->res_list;
+
+	list_for_each_entry_safe(cur, tmp, head, list) {
+		if (&tmp->list != head &&
+		    (cur->info.offset + cur->info.size + res->info.size <=
+		    tmp->info.offset)) {
+			res->info.offset = cur->info.offset + cur->info.size;
+			res->parent = uapi;
+			list_add(&res->list, &cur->list);
+			return;
+		}
+	}
+
+	if (list_empty(head))
+		res->info.offset = 0;
+	else {
+		tmp = list_last_entry(head, struct sram_resource, list);
+		res->info.offset = tmp->info.offset + tmp->info.size;
+	}
+	list_add_tail(&res->list, head);
+}
+
+static struct sram_resource *sram_uapi_res_delete(struct sram_uapi *uapi,
+						  struct res_info *info)
+{
+	struct sram_resource *res, *tmp;
+
+	list_for_each_entry_safe(res, tmp, &uapi->res_list, list) {
+		if (res->info.offset == info->offset) {
+			list_del(&res->list);
+			res->parent = NULL;
+			return res;
+		}
+	}
+
+	return NULL;
+}
+
+static struct sram_resource *sram_uapi_find_res(struct sram_uapi *uapi,
+						u32 offset)
+{
+	struct sram_resource *res;
+
+	list_for_each_entry(res, &uapi->res_list, list) {
+		if (res->info.offset == offset)
+			return res;
+	}
+
+	return NULL;
+}
+
+static int sram_uapi_open(struct inode *inode, struct file *filp)
+{
+	struct sram_uapi *uapi;
+
+	uapi = kzalloc(sizeof(*uapi), GFP_KERNEL);
+	if (!uapi)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&uapi->res_list);
+	filp->private_data = uapi;
+
+	return 0;
+}
+
+static long sram_uapi_ioctl(struct file *filp, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct sram_uapi *uapi = filp->private_data;
+	struct sram_resource *res;
+	struct res_info info;
+	long ret = -EINVAL;
+	int size;
+	u32 type;
+
+	if (!uapi)
+		return ret;
+
+	switch (cmd) {
+	case SRAM_UAPI_IOCTL_SET_SRAM_TYPE:
+		size = copy_from_user((void *)&type, (const void __user *)arg,
+				      sizeof(type));
+		if (type >= SRAM_TYPE_MAX)
+			return -EINVAL;
+
+		uapi->sa = &srams[type];
+
+		ret = 0;
+		break;
+
+	case SRAM_UAPI_IOCTL_ALLOC:
+		if (!uapi->sa)
+			return -EINVAL;
+
+		res = kzalloc(sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		size = copy_from_user((void *)&res->info,
+				      (const void __user *)arg,
+				      sizeof(res->info));
+		if (!PAGE_ALIGNED(res->info.size) || !res->info.size)
+			return -EINVAL;
+
+		res->virt = (void *)uapi->sa->sram_alloc(res->info.size,
+					&res->phys,
+					roundup_pow_of_two(res->info.size));
+		if (!res->virt) {
+			kfree(res);
+			return -ENOMEM;
+		}
+
+		sram_uapi_res_insert(uapi, res);
+		size = copy_to_user((void __user *)arg,
+				    (const void *)&res->info,
+				    sizeof(res->info));
+
+		ret = 0;
+		break;
+
+	case SRAM_UAPI_IOCTL_FREE:
+		if (!uapi->sa)
+			return -EINVAL;
+
+		size = copy_from_user((void *)&info, (const void __user *)arg,
+				      sizeof(info));
+
+		res = sram_uapi_res_delete(uapi, &info);
+		if (!res) {
+			pr_err("error no sram resource found\n");
+			return -EINVAL;
+		}
+
+		uapi->sa->sram_free(res->virt);
+		kfree(res);
+
+		ret = 0;
+		break;
+
+	default:
+		pr_err("error no cmd not supported\n");
+		break;
+	}
+
+	return ret;
+}
+
+static int sram_uapi_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct sram_uapi *uapi = filp->private_data;
+	struct sram_resource *res;
+
+	res = sram_uapi_find_res(uapi, vma->vm_pgoff);
+	if (!res)
+		return -EINVAL;
+
+	if (vma->vm_end - vma->vm_start > res->info.size)
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return remap_pfn_range(vma, vma->vm_start,
+				res->phys >> PAGE_SHIFT,
+				vma->vm_end - vma->vm_start,
+				vma->vm_page_prot);
+}
+
+static void sram_uapi_res_release(struct sram_uapi *uapi)
+{
+	struct sram_resource *res, *tmp;
+
+	list_for_each_entry_safe(res, tmp, &uapi->res_list, list) {
+		list_del(&res->list);
+		uapi->sa->sram_free(res->virt);
+		kfree(res);
+	}
+}
+
+static int sram_uapi_release(struct inode *inodp, struct file *filp)
+{
+	struct sram_uapi *uapi = filp->private_data;
+
+	sram_uapi_res_release(uapi);
+
+	kfree(uapi);
+
+	return 0;
+}
+
+static const struct file_operations sram_uapi_ops = {
+	.owner = THIS_MODULE,
+	.open = sram_uapi_open,
+	.unlocked_ioctl = sram_uapi_ioctl,
+	.mmap = sram_uapi_mmap,
+	.release = sram_uapi_release,
+};
+
+static struct miscdevice sram_uapi_miscdev = {
+	MISC_DYNAMIC_MINOR,
+	"sram-uapi",
+	&sram_uapi_ops,
+};
+
+static int __init sram_uapi_init(void)
+{
+	int ret;
+
+	ret = misc_register(&sram_uapi_miscdev);
+	if (ret)
+		pr_err("failed to register sram_uapi misc device\n");
+
+	return ret;
+}
+
+static void __exit sram_uapi_exit(void)
+{
+	misc_deregister(&sram_uapi_miscdev);
+}
+
+module_init(sram_uapi_init);
+module_exit(sram_uapi_exit);
+
+MODULE_AUTHOR("Wang Wenhu <wenhu.wang@vivo.com>");
+MODULE_DESCRIPTION("SRAM User API Driver");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

