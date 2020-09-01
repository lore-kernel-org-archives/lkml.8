Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC669C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695C120767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgIATWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:53437 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgIATVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:38 -0400
IronPort-SDR: 4uI4pBTBh2bwMjSCq9HmWdDmj9Hwv38HEcOwPQYd4e7Pm90mEaCOVjJV/TX7BvyNH940MSxfWp
 zdU/si+i3oOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807326"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:31 -0700
IronPort-SDR: B2pQb+cOkGia/u9yw9FKF9Dga41z0osw6iTAdzF3L8+hdgv2aiqdGBshVQu+q+iu597QKCDOaE
 DVS9oHQS3VbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480477"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:31 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 09/19] dlb2: add port mmap support
Date:   Tue,  1 Sep 2020 14:15:38 -0500
Message-Id: <20200901191548.31646-10-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once a port is created, the application can mmap the corresponding DMA
memory and MMIO into user-space. This allows user-space applications to
do (performance-sensitive) enqueue and dequeue independent of the kernel
driver.

The mmap callback is only available through special port files: a producer
port (PP) file and a consumer queue (CQ) file. User-space gets an fd for
these files by calling a new ioctl, DLB2_DOMAIN_CMD_GET_{LDB,
DIR}_PORT_{PP, CQ}_FD, and passing in a port ID. If the ioctl succeeds, the
returned fd can be used to mmap that port's PP/CQ.

Device reset requires first unmapping all user-space mappings, to prevent
applications from interfering with the reset operation. To this end, the
driver uses a single inode -- allocated when the first PP/CQ file is
created, and freed when the last such file is closed -- and attaches all
port files to this common inode, as done elsewhere in Linux (e.g. cxl,
dax).

Allocating this inode requires creating a pseudo-filesystem. The driver
initializes this FS when the inode is allocated, and frees the FS after the
inode is freed.

The driver doesn't use anon_inode_getfd() for these port mmap files because
the anon inode layer uses a single inode that is shared with other kernel
components -- calling unmap_mapping_range() on that shared inode would
likely break the kernel.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/Makefile        |   1 +
 drivers/misc/dlb2/dlb2_file.c     | 133 ++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_file.h     |  19 +++++
 drivers/misc/dlb2/dlb2_ioctl.c    | 154 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.c     | 100 +++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h     |  13 ++++
 drivers/misc/dlb2/dlb2_pf_ops.c   |  22 ++++++
 drivers/misc/dlb2/dlb2_resource.c |  99 ++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h |  50 +++++++++++++
 include/uapi/linux/dlb2_user.h    |  59 +++++++++++++++
 10 files changed, 650 insertions(+)
 create mode 100644 drivers/misc/dlb2/dlb2_file.c
 create mode 100644 drivers/misc/dlb2/dlb2_file.h

diff --git a/drivers/misc/dlb2/Makefile b/drivers/misc/dlb2/Makefile
index 18b5498b20e6..12361461dcff 100644
--- a/drivers/misc/dlb2/Makefile
+++ b/drivers/misc/dlb2/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_INTEL_DLB2) := dlb2.o
 
 dlb2-objs :=      \
   dlb2_main.o     \
+  dlb2_file.o     \
   dlb2_ioctl.o    \
   dlb2_pf_ops.o   \
   dlb2_resource.o \
diff --git a/drivers/misc/dlb2/dlb2_file.c b/drivers/misc/dlb2/dlb2_file.c
new file mode 100644
index 000000000000..8e73231336d7
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_file.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation */
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/pseudo_fs.h>
+
+#include "dlb2_file.h"
+#include "dlb2_main.h"
+
+/*
+ * dlb2 tracks its memory mappings so it can revoke them when an FLR is
+ * requested and user-space cannot be allowed to access the device. To achieve
+ * that, the driver creates a single inode through which all driver-created
+ * files can share a struct address_space, and unmaps the inode's address space
+ * during the reset preparation phase. Since the anon inode layer shares its
+ * inode with multiple kernel components, we cannot use that here.
+ *
+ * Doing so requires a custom pseudo-filesystem to allocate the inode. The FS
+ * and the inode are allocated on demand when a file is created, and both are
+ * freed when the last such file is closed.
+ *
+ * This is inspired by other drivers (cxl, dax, mem) and the anon inode layer.
+ */
+static int dlb2_fs_cnt;
+static struct vfsmount *dlb2_vfs_mount;
+
+#define DLB2FS_MAGIC 0x444C4232
+static int dlb2_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, DLB2FS_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type dlb2_fs_type = {
+	.name	 = "dlb2",
+	.owner	 = THIS_MODULE,
+	.init_fs_context = dlb2_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static struct inode *dlb2_alloc_inode(struct dlb2_dev *dev)
+{
+	struct inode *inode;
+	int ret;
+
+	/* Increment the pseudo-FS's refcnt and (if not already) mount it. */
+	ret = simple_pin_fs(&dlb2_fs_type, &dlb2_vfs_mount, &dlb2_fs_cnt);
+	if (ret < 0) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Cannot mount pseudo filesystem: %d\n",
+			__func__, ret);
+		return ERR_PTR(ret);
+	}
+
+	if (dlb2_fs_cnt > 1) {
+		/*
+		 * Return the previously allocated inode. In this case, there
+		 * is guaranteed >= 1 reference and so ihold() is safe to call.
+		 */
+		ihold(dev->inode);
+		return dev->inode;
+	}
+
+	inode = alloc_anon_inode(dlb2_vfs_mount->mnt_sb);
+	if (IS_ERR(inode)) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Cannot allocate inode: %d\n",
+			__func__, ret);
+		simple_release_fs(&dlb2_vfs_mount, &dlb2_fs_cnt);
+	}
+
+	dev->inode = inode;
+
+	return inode;
+}
+
+/*
+ * Decrement the inode reference count and release the FS. Intended for
+ * unwinding dlb2_alloc_inode(). Must hold the resource mutex while calling.
+ */
+static void dlb2_free_inode(struct inode *inode)
+{
+	iput(inode);
+	simple_release_fs(&dlb2_vfs_mount, &dlb2_fs_cnt);
+}
+
+/*
+ * Release the FS. Intended for use in a file_operations release callback,
+ * which decrements the inode reference count separately. Must hold the
+ * resource mutex while calling.
+ */
+void dlb2_release_fs(struct dlb2_dev *dev)
+{
+	simple_release_fs(&dlb2_vfs_mount, &dlb2_fs_cnt);
+
+	/* When the fs refcnt reaches zero, the inode has been freed */
+	if (dlb2_fs_cnt == 0)
+		dev->inode = NULL;
+}
+
+/*
+ * Allocate a file with the requested flags, file operations, and name that
+ * uses the device's shared inode. Must hold the resource mutex while calling.
+ *
+ * Caller must separately allocate an fd and install the file in that fd.
+ */
+struct file *dlb2_getfile(struct dlb2_dev *dev,
+			  int flags,
+			  const struct file_operations *fops,
+			  const char *name)
+{
+	struct inode *inode;
+	struct file *f;
+
+	if (!try_module_get(THIS_MODULE))
+		return ERR_PTR(-ENOENT);
+
+	inode = dlb2_alloc_inode(dev);
+	if (IS_ERR(inode)) {
+		module_put(THIS_MODULE);
+		return ERR_CAST(inode);
+	}
+
+	f = alloc_file_pseudo(inode, dlb2_vfs_mount, name, flags, fops);
+	if (IS_ERR(f)) {
+		dlb2_free_inode(inode);
+		module_put(THIS_MODULE);
+	}
+
+	return f;
+}
diff --git a/drivers/misc/dlb2/dlb2_file.h b/drivers/misc/dlb2/dlb2_file.h
new file mode 100644
index 000000000000..20a3b04eb00e
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_file.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2020 Intel Corporation
+ */
+
+#ifndef __DLB2_FILE_H
+#define __DLB2_FILE_H
+
+#include <linux/file.h>
+
+#include "dlb2_main.h"
+
+void dlb2_release_fs(struct dlb2_dev *dev);
+
+struct file *dlb2_getfile(struct dlb2_dev *dev,
+			  int flags,
+			  const struct file_operations *fops,
+			  const char *name);
+
+#endif /* __DLB2_FILE_H */
diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 7a3fea60c302..68db45842e34 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -6,6 +6,7 @@
 
 #include <uapi/linux/dlb2_user.h>
 
+#include "dlb2_file.h"
 #include "dlb2_ioctl.h"
 #include "dlb2_main.h"
 
@@ -171,6 +172,151 @@ static int dlb2_domain_ioctl_create_dir_port(struct dlb2_dev *dev,
 	return ret;
 }
 
+static int dlb2_create_port_fd(struct dlb2_dev *dev,
+			       struct dlb2_domain *domain,
+			       const char *prefix,
+			       u32 id,
+			       const struct file_operations *fops,
+			       int *fd,
+			       struct file **f)
+{
+	char *name;
+	int ret;
+
+	ret = get_unused_fd_flags(O_RDWR);
+	if (ret < 0)
+		return ret;
+
+	*fd = ret;
+
+	name = kasprintf(GFP_KERNEL, "%s:%d", prefix, id);
+	if (!name) {
+		put_unused_fd(*fd);
+		return -ENOMEM;
+	}
+
+	*f = dlb2_getfile(dev, O_RDWR, fops, name);
+
+	kfree(name);
+
+	if (IS_ERR(*f)) {
+		put_unused_fd(*fd);
+		return PTR_ERR(*f);
+	}
+
+	return 0;
+}
+
+static int dlb2_domain_get_port_fd(struct dlb2_dev *dev,
+				   struct dlb2_domain *domain,
+				   unsigned long user_arg,
+				   const char *name,
+				   const struct file_operations *fops,
+				   bool is_ldb)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_get_port_fd_args arg;
+	struct file *file = NULL;
+	struct dlb2_port *port;
+	int ret, fd;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	if ((is_ldb &&
+	     dev->ops->ldb_port_owned_by_domain(&dev->hw,
+						domain->id,
+						arg.port_id) != 1)) {
+		response.status = DLB2_ST_INVALID_PORT_ID;
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (!is_ldb &&
+	    dev->ops->dir_port_owned_by_domain(&dev->hw,
+					       domain->id,
+					       arg.port_id) != 1) {
+		response.status = DLB2_ST_INVALID_PORT_ID;
+		ret = -EINVAL;
+		goto end;
+	}
+
+	port = (is_ldb) ? &dev->ldb_port[arg.port_id] :
+			  &dev->dir_port[arg.port_id];
+
+	if (!port->valid) {
+		response.status = DLB2_ST_INVALID_PORT_ID;
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = dlb2_create_port_fd(dev, domain, name, arg.port_id,
+				  fops, &fd, &file);
+	if (ret < 0)
+		goto end;
+
+	file->private_data = port;
+
+	response.id = fd;
+	ret = 0;
+
+end:
+	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
+
+	if (copy_to_user((void __user *)user_arg, &response, sizeof(response)))
+		ret = -EFAULT;
+
+	/*
+	 * Save fd_install() until after the last point of failure. The domain
+	 * and pm refcnt are decremented in the close callback.
+	 */
+	if (ret == 0) {
+		kref_get(&domain->refcnt);
+
+		dev->ops->inc_pm_refcnt(dev->pdev, true);
+
+		fd_install(fd, file);
+	}
+
+	mutex_unlock(&dev->resource_mutex);
+
+	return ret;
+}
+
+static int dlb2_domain_ioctl_get_ldb_port_pp_fd(struct dlb2_dev *dev,
+						struct dlb2_domain *domain,
+						unsigned long user_arg)
+{
+	return dlb2_domain_get_port_fd(dev, domain, user_arg,
+				       "dlb2_ldb_pp:", &dlb2_pp_fops, true);
+}
+
+static int dlb2_domain_ioctl_get_ldb_port_cq_fd(struct dlb2_dev *dev,
+						struct dlb2_domain *domain,
+						unsigned long user_arg)
+{
+	return dlb2_domain_get_port_fd(dev, domain, user_arg,
+				       "dlb2_ldb_cq:", &dlb2_cq_fops, true);
+}
+
+static int dlb2_domain_ioctl_get_dir_port_pp_fd(struct dlb2_dev *dev,
+						struct dlb2_domain *domain,
+						unsigned long user_arg)
+{
+	return dlb2_domain_get_port_fd(dev, domain, user_arg,
+				       "dlb2_dir_pp:", &dlb2_pp_fops, false);
+}
+
+static int dlb2_domain_ioctl_get_dir_port_cq_fd(struct dlb2_dev *dev,
+						struct dlb2_domain *domain,
+						unsigned long user_arg)
+{
+	return dlb2_domain_get_port_fd(dev, domain, user_arg,
+				       "dlb2_dir_cq:", &dlb2_cq_fops, false);
+}
+
 long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct dlb2_domain *dom = f->private_data;
@@ -189,6 +335,14 @@ long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_domain_ioctl_create_ldb_port(dev, dom, arg);
 	case DLB2_IOC_CREATE_DIR_PORT:
 		return dlb2_domain_ioctl_create_dir_port(dev, dom, arg);
+	case DLB2_IOC_GET_LDB_PORT_PP_FD:
+		return dlb2_domain_ioctl_get_ldb_port_pp_fd(dev, dom, arg);
+	case DLB2_IOC_GET_LDB_PORT_CQ_FD:
+		return dlb2_domain_ioctl_get_ldb_port_cq_fd(dev, dom, arg);
+	case DLB2_IOC_GET_DIR_PORT_PP_FD:
+		return dlb2_domain_ioctl_get_dir_port_pp_fd(dev, dom, arg);
+	case DLB2_IOC_GET_DIR_PORT_CQ_FD:
+		return dlb2_domain_ioctl_get_dir_port_cq_fd(dev, dom, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index a7512832fc1c..3fe59e99b402 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
+#include "dlb2_file.h"
 #include "dlb2_ioctl.h"
 #include "dlb2_main.h"
 #include "dlb2_resource.h"
@@ -226,6 +227,105 @@ const struct file_operations dlb2_domain_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 };
 
+static int dlb2_pp_mmap(struct file *f, struct vm_area_struct *vma)
+{
+	struct dlb2_port *port = f->private_data;
+	struct dlb2_domain *domain = port->domain;
+	struct dlb2_dev *dev = domain->dlb2_dev;
+	unsigned long pgoff;
+	pgprot_t pgprot;
+	int ret;
+
+	mutex_lock(&dev->resource_mutex);
+
+	if ((vma->vm_end - vma->vm_start) != DLB2_PP_SIZE) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	pgprot = pgprot_noncached(vma->vm_page_prot);
+
+	pgoff = dev->hw.func_phys_addr;
+
+	if (port->is_ldb)
+		pgoff += DLB2_LDB_PP_OFFS(port->id);
+	else
+		pgoff += DLB2_DIR_PP_OFFS(port->id);
+
+	ret = io_remap_pfn_range(vma,
+				 vma->vm_start,
+				 pgoff >> PAGE_SHIFT,
+				 vma->vm_end - vma->vm_start,
+				 pgprot);
+
+end:
+	mutex_unlock(&dev->resource_mutex);
+
+	return ret;
+}
+
+static int dlb2_cq_mmap(struct file *f, struct vm_area_struct *vma)
+{
+	struct dlb2_port *port = f->private_data;
+	struct dlb2_domain *domain = port->domain;
+	struct dlb2_dev *dev = domain->dlb2_dev;
+	struct page *page;
+	int ret;
+
+	mutex_lock(&dev->resource_mutex);
+
+	if ((vma->vm_end - vma->vm_start) != DLB2_CQ_SIZE) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	page = virt_to_page(port->cq_base);
+
+	ret = remap_pfn_range(vma,
+			      vma->vm_start,
+			      page_to_pfn(page),
+			      vma->vm_end - vma->vm_start,
+			      vma->vm_page_prot);
+
+end:
+	mutex_unlock(&dev->resource_mutex);
+
+	return ret;
+}
+
+static int dlb2_port_close(struct inode *i, struct file *f)
+{
+	struct dlb2_port *port = f->private_data;
+	struct dlb2_domain *domain = port->domain;
+	struct dlb2_dev *dev = domain->dlb2_dev;
+	int ret = 0;
+
+	mutex_lock(&dev->resource_mutex);
+
+	kref_put(&domain->refcnt, dlb2_free_domain);
+
+	dev->ops->dec_pm_refcnt(dev->pdev);
+
+	/* Decrement the refcnt of the pseudo-FS used to allocate the inode */
+	dlb2_release_fs(dev);
+
+	mutex_unlock(&dev->resource_mutex);
+
+	return ret;
+}
+
+const struct file_operations dlb2_pp_fops = {
+	.owner   = THIS_MODULE,
+	.release = dlb2_port_close,
+	.mmap    = dlb2_pp_mmap,
+};
+
+const struct file_operations dlb2_cq_fops = {
+	.owner   = THIS_MODULE,
+	.release = dlb2_port_close,
+	.mmap    = dlb2_cq_mmap,
+};
+
 /**********************************/
 /****** PCI driver callbacks ******/
 /**********************************/
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index ceb5512a104c..06b9130643cb 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -81,6 +81,12 @@ struct dlb2_device_ops {
 	int (*get_num_resources)(struct dlb2_hw *hw,
 				 struct dlb2_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb2_hw *hw, u32 domain_id);
+	int (*ldb_port_owned_by_domain)(struct dlb2_hw *hw,
+					u32 domain_id,
+					u32 port_id);
+	int (*dir_port_owned_by_domain)(struct dlb2_hw *hw,
+					u32 domain_id,
+					u32 port_id);
 	int (*get_ldb_queue_depth)(struct dlb2_hw *hw,
 				   u32 domain_id,
 				   struct dlb2_get_ldb_queue_depth_args *args,
@@ -96,6 +102,8 @@ struct dlb2_device_ops {
 
 extern struct dlb2_device_ops dlb2_pf_ops;
 extern const struct file_operations dlb2_domain_fops;
+extern const struct file_operations dlb2_pp_fops;
+extern const struct file_operations dlb2_cq_fops;
 
 struct dlb2_port {
 	void *cq_base;
@@ -123,6 +131,11 @@ struct dlb2_dev {
 	struct dlb2_port ldb_port[DLB2_MAX_NUM_LDB_PORTS];
 	struct dlb2_port dir_port[DLB2_MAX_NUM_DIR_PORTS];
 	/*
+	 * Anonymous inode used to share an address_space for all domain
+	 * device file mappings.
+	 */
+	struct inode *inode;
+	/*
 	 * The resource mutex serializes access to driver data structures and
 	 * hardware registers.
 	 */
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 8556dcdff8c4..1e2e89d6945e 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -307,6 +307,26 @@ dlb2_pf_query_cq_poll_mode(struct dlb2_dev *dlb2_dev,
 	return 0;
 }
 
+/**************************************/
+/****** Resource query callbacks ******/
+/**************************************/
+
+static int
+dlb2_pf_ldb_port_owned_by_domain(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 u32 port_id)
+{
+	return dlb2_ldb_port_owned_by_domain(hw, domain_id, port_id, false, 0);
+}
+
+static int
+dlb2_pf_dir_port_owned_by_domain(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 u32 port_id)
+{
+	return dlb2_dir_port_owned_by_domain(hw, domain_id, port_id, false, 0);
+}
+
 /********************************/
 /****** DLB2 PF Device Ops ******/
 /********************************/
@@ -331,6 +351,8 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.create_dir_port = dlb2_pf_create_dir_port,
 	.get_num_resources = dlb2_pf_get_num_resources,
 	.reset_domain = dlb2_pf_reset_domain,
+	.ldb_port_owned_by_domain = dlb2_pf_ldb_port_owned_by_domain,
+	.dir_port_owned_by_domain = dlb2_pf_dir_port_owned_by_domain,
 	.get_ldb_queue_depth = dlb2_pf_get_ldb_queue_depth,
 	.get_dir_queue_depth = dlb2_pf_get_dir_queue_depth,
 	.init_hardware = dlb2_pf_init_hardware,
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 03824fd48f60..454a1aacfaf2 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -237,6 +237,32 @@ static struct dlb2_hw_domain *dlb2_get_domain_from_id(struct dlb2_hw *hw,
 	return NULL;
 }
 
+static struct dlb2_ldb_port *
+dlb2_get_domain_ldb_port(u32 id,
+			 bool vdev_req,
+			 struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_port *port;
+	int i;
+
+	if (id >= DLB2_MAX_NUM_LDB_PORTS)
+		return NULL;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port)
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+
+		DLB2_DOM_LIST_FOR(domain->avail_ldb_ports[i], port)
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+	}
+
+	return NULL;
+}
+
 static struct dlb2_dir_pq_pair *
 dlb2_get_domain_used_dir_pq(u32 id,
 			    bool vdev_req,
@@ -255,6 +281,29 @@ dlb2_get_domain_used_dir_pq(u32 id,
 	return NULL;
 }
 
+static struct dlb2_dir_pq_pair *
+dlb2_get_domain_dir_pq(u32 id,
+		       bool vdev_req,
+		       struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *port;
+
+	if (id >= DLB2_MAX_NUM_DIR_PORTS)
+		return NULL;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port)
+		if ((!vdev_req && port->id.phys_id == id) ||
+		    (vdev_req && port->id.virt_id == id))
+			return port;
+
+	DLB2_DOM_LIST_FOR(domain->avail_dir_pq_pairs, port)
+		if ((!vdev_req && port->id.phys_id == id) ||
+		    (vdev_req && port->id.virt_id == id))
+			return port;
+
+	return NULL;
+}
+
 static struct dlb2_ldb_queue *
 dlb2_get_ldb_queue_from_id(struct dlb2_hw *hw,
 			   u32 id,
@@ -4949,6 +4998,56 @@ int dlb2_reset_domain(struct dlb2_hw *hw,
 	return 0;
 }
 
+int dlb2_ldb_port_owned_by_domain(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  u32 port_id,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+
+	if (vdev_req && vdev_id >= DLB2_MAX_NUM_VDEVS)
+		return -EINVAL;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain || !domain->configured)
+		return -EINVAL;
+
+	port = dlb2_get_domain_ldb_port(port_id, vdev_req, domain);
+
+	if (!port)
+		return -EINVAL;
+
+	return port->domain_id.phys_id == domain->id.phys_id;
+}
+
+int dlb2_dir_port_owned_by_domain(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  u32 port_id,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *port;
+	struct dlb2_hw_domain *domain;
+
+	if (vdev_req && vdev_id >= DLB2_MAX_NUM_VDEVS)
+		return -EINVAL;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain || !domain->configured)
+		return -EINVAL;
+
+	port = dlb2_get_domain_dir_pq(port_id, vdev_req, domain);
+
+	if (!port)
+		return -EINVAL;
+
+	return port->domain_id.phys_id == domain->id.phys_id;
+}
+
 int dlb2_hw_get_num_resources(struct dlb2_hw *hw,
 			      struct dlb2_get_num_resources_args *arg,
 			      bool vdev_req,
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index d355bc1a8f08..ffdc35ebbc1e 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -239,6 +239,56 @@ int dlb2_reset_domain(struct dlb2_hw *hw,
 		      unsigned int vdev_id);
 
 /**
+ * dlb2_ldb_port_owned_by_domain() - query whether a port is owned by a domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @port_id: port ID.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function returns whether a load-balanced port is owned by a specified
+ * domain.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 if false, 1 if true, <0 otherwise.
+ *
+ * EINVAL - Invalid domain or port ID, or the domain is not configured.
+ */
+int dlb2_ldb_port_owned_by_domain(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  u32 port_id,
+				  bool vdev_request,
+				  unsigned int vdev_id);
+
+/**
+ * dlb2_dir_port_owned_by_domain() - query whether a port is owned by a domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @port_id: port ID.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function returns whether a directed port is owned by a specified
+ * domain.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 if false, 1 if true, <0 otherwise.
+ *
+ * EINVAL - Invalid domain or port ID, or the domain is not configured.
+ */
+int dlb2_dir_port_owned_by_domain(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  u32 port_id,
+				  bool vdev_request,
+				  unsigned int vdev_id);
+
+/**
  * dlb2_hw_get_num_resources() - query the PCI function's available resources
  * @hw: dlb2_hw handle for a particular device.
  * @arg: pointer to resource counts.
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index df7bb72096cd..898ff4df3462 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -422,6 +422,40 @@ struct dlb2_create_dir_port_args {
 	__s32 queue_id;
 };
 
+/*
+ * DLB2_CMD_GET_LDB_PORT_PP_FD: Get file descriptor to mmap a load-balanced
+ *	port's producer port (PP).
+ * DLB2_CMD_GET_LDB_PORT_CQ_FD: Get file descriptor to mmap a load-balanced
+ *	port's consumer queue (CQ).
+ *
+ *	The load-balanced port must have been previously created with the ioctl
+ *	DLB2_CMD_CREATE_LDB_PORT. The fd is used to mmap the PP/CQ region.
+ *
+ * DLB2_CMD_GET_DIR_PORT_PP_FD: Get file descriptor to mmap a directed port's
+ *	producer port (PP).
+ * DLB2_CMD_GET_DIR_PORT_CQ_FD: Get file descriptor to mmap a directed port's
+ *	consumer queue (CQ).
+ *
+ *	The directed port must have been previously created with the ioctl
+ *	DLB2_CMD_CREATE_DIR_PORT. The fd is used to mmap PP/CQ region.
+ *
+ * Input parameters:
+ * - port_id: port ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: fd.
+ */
+struct dlb2_get_port_fd_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 padding0;
+};
+
 enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
@@ -429,12 +463,21 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
 	DLB2_DOMAIN_CMD_CREATE_LDB_PORT,
 	DLB2_DOMAIN_CMD_CREATE_DIR_PORT,
+	DLB2_DOMAIN_CMD_GET_LDB_PORT_PP_FD,
+	DLB2_DOMAIN_CMD_GET_LDB_PORT_CQ_FD,
+	DLB2_DOMAIN_CMD_GET_DIR_PORT_PP_FD,
+	DLB2_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,
 
 	/* NUM_DLB2_DOMAIN_CMD must be last */
 	NUM_DLB2_DOMAIN_CMD,
 };
 
+/*
+ * Mapping sizes for memory mapping the consumer queue (CQ) memory space, and
+ * producer port (PP) MMIO space.
+ */
 #define DLB2_CQ_SIZE 65536
+#define DLB2_PP_SIZE 4096
 
 /********************/
 /* dlb2 ioctl codes */
@@ -482,5 +525,21 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_CREATE_DIR_PORT,		\
 		      struct dlb2_create_dir_port_args)
+#define DLB2_IOC_GET_LDB_PORT_PP_FD				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_GET_LDB_PORT_PP_FD,	\
+		      struct dlb2_get_port_fd_args)
+#define DLB2_IOC_GET_LDB_PORT_CQ_FD				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_GET_LDB_PORT_CQ_FD,	\
+		      struct dlb2_get_port_fd_args)
+#define DLB2_IOC_GET_DIR_PORT_PP_FD				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_GET_DIR_PORT_PP_FD,	\
+		      struct dlb2_get_port_fd_args)
+#define DLB2_IOC_GET_DIR_PORT_CQ_FD				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,	\
+		      struct dlb2_get_port_fd_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

