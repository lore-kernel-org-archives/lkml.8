Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC565C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B10206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgGLNvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:51:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:8462 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgGLNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:51:47 -0400
IronPort-SDR: uWMPa/5fD4M6kwcdOPxPqEmG2kjMa3jdzudBfABfTSKODfIHTZPH4Fu1RkEhPFbPeiFjxzdlkD
 1geifb8Wq+sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540892"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540892"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:44 -0700
IronPort-SDR: TLxZT3gxS/4JCCSXQmZm/BK8hvlm9buq6S0nfbNCVGAHIerQDlafFC6UJeic04UlKxjKXCrbNr
 UNdyAb83SqkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148603"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:44 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Date:   Sun, 12 Jul 2020 08:43:15 -0500
Message-Id: <20200712134331.8169-5-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200712134331.8169-1-gage.eads@intel.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the dlb2 device ioctl layer, and the first four
ioctls: query device version, driver version, and available resources; and
create a scheduling domain. This commit also introduces the user-space
interface file dlb2_user.h.

The PF hardware operation for scheduling domain creation will be added in a
subsequent commit.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/Makefile        |   1 +
 drivers/misc/dlb2/dlb2_bitmap.h   |  63 ++++++++++
 drivers/misc/dlb2/dlb2_ioctl.c    | 186 ++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_ioctl.h    |  14 +++
 drivers/misc/dlb2/dlb2_main.c     |  33 +++++-
 drivers/misc/dlb2/dlb2_main.h     |   7 ++
 drivers/misc/dlb2/dlb2_pf_ops.c   |  21 ++++
 drivers/misc/dlb2/dlb2_resource.c |  48 ++++++++
 drivers/misc/dlb2/dlb2_resource.h |  22 ++++
 include/uapi/linux/dlb2_user.h    | 236 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 630 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/dlb2/dlb2_ioctl.c
 create mode 100644 drivers/misc/dlb2/dlb2_ioctl.h
 create mode 100644 include/uapi/linux/dlb2_user.h

diff --git a/drivers/misc/dlb2/Makefile b/drivers/misc/dlb2/Makefile
index 4fdf7ffc555b..18b5498b20e6 100644
--- a/drivers/misc/dlb2/Makefile
+++ b/drivers/misc/dlb2/Makefile
@@ -6,5 +6,6 @@ obj-$(CONFIG_INTEL_DLB2) := dlb2.o
 
 dlb2-objs :=      \
   dlb2_main.o     \
+  dlb2_ioctl.o    \
   dlb2_pf_ops.o   \
   dlb2_resource.o \
diff --git a/drivers/misc/dlb2/dlb2_bitmap.h b/drivers/misc/dlb2/dlb2_bitmap.h
index c5bb4ba84d5c..2d2d2927b0ec 100644
--- a/drivers/misc/dlb2/dlb2_bitmap.h
+++ b/drivers/misc/dlb2/dlb2_bitmap.h
@@ -118,4 +118,67 @@ static inline int dlb2_bitmap_zero(struct dlb2_bitmap *bitmap)
 	return 0;
 }
 
+/**
+ * dlb2_bitmap_count() - returns the number of set bits
+ * @bitmap: pointer to dlb2_bitmap structure.
+ *
+ * This function looks for a single set bit.
+ *
+ * Return:
+ * Returns the number of set bits upon success, <0 otherwise.
+ *
+ * Errors:
+ * EINVAL - bitmap is NULL or is uninitialized.
+ */
+static inline int dlb2_bitmap_count(struct dlb2_bitmap *bitmap)
+{
+	if (!bitmap || !bitmap->map)
+		return -EINVAL;
+
+	return bitmap_weight(bitmap->map, bitmap->len);
+}
+
+/**
+ * dlb2_bitmap_longest_set_range() - returns longest contiguous range of set
+ *				     bits
+ * @bitmap: pointer to dlb2_bitmap structure.
+ *
+ * Return:
+ * Returns the bitmap's longest contiguous range of of set bits upon success,
+ * <0 otherwise.
+ *
+ * Errors:
+ * EINVAL - bitmap is NULL or is uninitialized.
+ */
+static inline int dlb2_bitmap_longest_set_range(struct dlb2_bitmap *bitmap)
+{
+	unsigned int bits_per_long;
+	unsigned int i, j;
+	int max_len, len;
+
+	if (!bitmap || !bitmap->map)
+		return -EINVAL;
+
+	if (dlb2_bitmap_count(bitmap) == 0)
+		return 0;
+
+	max_len = 0;
+	len = 0;
+	bits_per_long = sizeof(unsigned long) * BITS_PER_BYTE;
+
+	for (i = 0; i < BITS_TO_LONGS(bitmap->len); i++) {
+		for (j = 0; j < bits_per_long; j++) {
+			if ((i * bits_per_long + j) >= bitmap->len)
+				break;
+
+			len = (test_bit(j, &bitmap->map[i])) ? len + 1 : 0;
+
+			if (len > max_len)
+				max_len = len;
+		}
+	}
+
+	return max_len;
+}
+
 #endif /*  __DLB2_OSDEP_BITMAP_H */
diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
new file mode 100644
index 000000000000..97a7220f0ea0
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2017-2020 Intel Corporation */
+
+#include <linux/uaccess.h>
+
+#include <uapi/linux/dlb2_user.h>
+
+#include "dlb2_ioctl.h"
+#include "dlb2_main.h"
+
+/* Verify the ioctl argument size and copy the argument into kernel memory */
+static int dlb2_copy_from_user(struct dlb2_dev *dev,
+			       unsigned long user_arg,
+			       u16 user_size,
+			       void *arg,
+			       size_t size)
+{
+	if (user_size != size) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Invalid ioctl size\n", __func__);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(arg, (void __user *)user_arg, size)) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Invalid ioctl argument pointer\n", __func__);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int dlb2_copy_resp_to_user(struct dlb2_dev *dev,
+				  unsigned long user_resp,
+				  struct dlb2_cmd_response *resp)
+{
+	if (copy_to_user((void __user *)user_resp, resp, sizeof(*resp))) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Invalid ioctl response pointer\n", __func__);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/* [7:0]: device revision, [15:8]: device version */
+#define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
+
+static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
+					 unsigned long user_arg,
+					 u16 size)
+{
+	struct dlb2_get_device_version_args arg;
+	struct dlb2_cmd_response response;
+	int ret;
+
+	dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
+
+	response.status = 0;
+	response.id = DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
+
+	ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
+	if (ret)
+		return ret;
+
+	ret = dlb2_copy_resp_to_user(dev, arg.response, &response);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev->dlb2_device, "Exiting %s()\n", __func__);
+
+	return 0;
+}
+
+static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
+					  unsigned long user_arg,
+					  u16 size)
+{
+	struct dlb2_create_sched_domain_args arg;
+	struct dlb2_cmd_response response = {0};
+	int ret;
+
+	dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
+
+	ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
+	if (ret)
+		return ret;
+
+	/* Copy zeroes to verify the user-provided response pointer */
+	ret = dlb2_copy_resp_to_user(dev, arg.response, &response);
+	if (ret)
+		return ret;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->create_sched_domain(&dev->hw, &arg, &response);
+
+	mutex_unlock(&dev->resource_mutex);
+
+	if (copy_to_user((void __user *)arg.response,
+			 &response,
+			 sizeof(response)))
+		return -EFAULT;
+
+	dev_dbg(dev->dlb2_device, "Exiting %s()\n", __func__);
+
+	return ret;
+}
+
+static int dlb2_ioctl_get_num_resources(struct dlb2_dev *dev,
+					unsigned long user_arg,
+					u16 size)
+{
+	struct dlb2_get_num_resources_args arg;
+	int ret;
+
+	dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->get_num_resources(&dev->hw, &arg);
+
+	mutex_unlock(&dev->resource_mutex);
+
+	if (copy_to_user((void __user *)user_arg, &arg, sizeof(arg))) {
+		dev_err(dev->dlb2_device, "Invalid DLB resources pointer\n");
+		return -EFAULT;
+	}
+
+	dev_dbg(dev->dlb2_device, "Exiting %s()\n", __func__);
+
+	return ret;
+}
+
+static int dlb2_ioctl_get_driver_version(struct dlb2_dev *dev,
+					 unsigned long user_arg,
+					 u16 size)
+{
+	struct dlb2_get_driver_version_args arg;
+	struct dlb2_cmd_response response;
+	int ret;
+
+	dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
+
+	response.status = 0;
+	response.id = DLB2_VERSION;
+
+	ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
+	if (ret)
+		return ret;
+
+	ret = dlb2_copy_resp_to_user(dev, arg.response, &response);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev->dlb2_device, "Exiting %s()\n", __func__);
+
+	return 0;
+}
+
+typedef int (*dlb2_ioctl_callback_fn_t)(struct dlb2_dev *dev,
+					unsigned long arg,
+					u16 size);
+
+static dlb2_ioctl_callback_fn_t dlb2_ioctl_callback_fns[NUM_DLB2_CMD] = {
+	dlb2_ioctl_get_device_version,
+	dlb2_ioctl_create_sched_domain,
+	dlb2_ioctl_get_num_resources,
+	dlb2_ioctl_get_driver_version,
+};
+
+int dlb2_ioctl_dispatcher(struct dlb2_dev *dev,
+			  unsigned int cmd,
+			  unsigned long arg)
+{
+	u16 sz = _IOC_SIZE(cmd);
+
+	if (_IOC_NR(cmd) >= NUM_DLB2_CMD) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Unexpected DLB command %d\n",
+			__func__, _IOC_NR(cmd));
+		return -1;
+	}
+
+	return dlb2_ioctl_callback_fns[_IOC_NR(cmd)](dev, arg, sz);
+}
diff --git a/drivers/misc/dlb2/dlb2_ioctl.h b/drivers/misc/dlb2/dlb2_ioctl.h
new file mode 100644
index 000000000000..476548cdd33c
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_ioctl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2017-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_IOCTL_H
+#define __DLB2_IOCTL_H
+
+#include "dlb2_main.h"
+
+int dlb2_ioctl_dispatcher(struct dlb2_dev *dev,
+			  unsigned int cmd,
+			  unsigned long arg);
+
+#endif /* __DLB2_IOCTL_H */
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index ae39dfea51e3..e3e32c6f3d63 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -11,15 +11,25 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
+#include "dlb2_ioctl.h"
 #include "dlb2_main.h"
 #include "dlb2_resource.h"
 
 static const char
 dlb2_driver_copyright[] = "Copyright(c) 2018-2020 Intel Corporation";
 
+#define TO_STR2(s) #s
+#define TO_STR(s) TO_STR2(s)
+
+#define DRV_VERSION \
+	TO_STR(DLB2_VERSION_MAJOR_NUMBER) "." \
+	TO_STR(DLB2_VERSION_MINOR_NUMBER) "." \
+	TO_STR(DLB2_VERSION_REVISION_NUMBER)
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
 MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer 2.0 Driver");
+MODULE_VERSION(DRV_VERSION);
 
 /* The driver lock protects data structures that used by multiple devices. */
 static DEFINE_MUTEX(dlb2_driver_lock);
@@ -59,10 +69,28 @@ static int dlb2_close(struct inode *i, struct file *f)
 	return 0;
 }
 
+static long
+dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct dlb2_dev *dev;
+
+	dev = container_of(f->f_inode->i_cdev, struct dlb2_dev, cdev);
+
+	if (_IOC_TYPE(cmd) != DLB2_IOC_MAGIC) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Bad magic number!\n", __func__);
+		return -EINVAL;
+	}
+
+	return dlb2_ioctl_dispatcher(dev, cmd, arg);
+}
+
 static const struct file_operations dlb2_fops = {
 	.owner   = THIS_MODULE,
 	.open    = dlb2_open,
 	.release = dlb2_close,
+	.unlocked_ioctl = dlb2_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 /**********************************/
@@ -260,7 +288,10 @@ static int __init dlb2_init_module(void)
 {
 	int err;
 
-	pr_info("%s\n", dlb2_driver_name);
+	pr_info("%s - version %d.%d.%d\n", dlb2_driver_name,
+		DLB2_VERSION_MAJOR_NUMBER,
+		DLB2_VERSION_MINOR_NUMBER,
+		DLB2_VERSION_REVISION_NUMBER);
 	pr_info("%s\n", dlb2_driver_copyright);
 
 	dlb2_class = class_create(THIS_MODULE, dlb2_driver_name);
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 0bb646b82e5c..9211a6d999d1 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -13,6 +13,8 @@
 #include <linux/pci.h>
 #include <linux/types.h>
 
+#include <uapi/linux/dlb2_user.h>
+
 #include "dlb2_hw_types.h"
 
 static const char dlb2_driver_name[] = KBUILD_MODNAME;
@@ -53,6 +55,11 @@ struct dlb2_device_ops {
 	void (*enable_pm)(struct dlb2_dev *dev);
 	int (*wait_for_device_ready)(struct dlb2_dev *dev,
 				     struct pci_dev *pdev);
+	int (*create_sched_domain)(struct dlb2_hw *hw,
+				   struct dlb2_create_sched_domain_args *args,
+				   struct dlb2_cmd_response *resp);
+	int (*get_num_resources)(struct dlb2_hw *hw,
+				 struct dlb2_get_num_resources_args *args);
 	void (*init_hardware)(struct dlb2_dev *dev);
 };
 
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 01664211d60a..8142b302ba95 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -194,6 +194,25 @@ dlb2_pf_init_hardware(struct dlb2_dev *dlb2_dev)
 {
 }
 
+/*****************************/
+/****** IOCTL callbacks ******/
+/*****************************/
+
+static int
+dlb2_pf_create_sched_domain(struct dlb2_hw *hw,
+			    struct dlb2_create_sched_domain_args *args,
+			    struct dlb2_cmd_response *resp)
+{
+	return 0;
+}
+
+static int
+dlb2_pf_get_num_resources(struct dlb2_hw *hw,
+			  struct dlb2_get_num_resources_args *args)
+{
+	return dlb2_hw_get_num_resources(hw, args, false, 0);
+}
+
 /********************************/
 /****** DLB2 PF Device Ops ******/
 /********************************/
@@ -209,5 +228,7 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.cdev_del = dlb2_pf_cdev_del,
 	.enable_pm = dlb2_pf_enable_pm,
 	.wait_for_device_ready = dlb2_pf_wait_for_device_ready,
+	.create_sched_domain = dlb2_pf_create_sched_domain,
+	.get_num_resources = dlb2_pf_get_num_resources,
 	.init_hardware = dlb2_pf_init_hardware,
 };
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 036ab10d7a98..44da2a3d3061 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -185,6 +185,54 @@ int dlb2_resource_init(struct dlb2_hw *hw)
 	return ret;
 }
 
+int dlb2_hw_get_num_resources(struct dlb2_hw *hw,
+			      struct dlb2_get_num_resources_args *arg,
+			      bool vdev_req,
+			      unsigned int vdev_id)
+{
+	struct dlb2_function_resources *rsrcs;
+	struct dlb2_bitmap *map;
+	int i;
+
+	if (vdev_req && vdev_id >= DLB2_MAX_NUM_VDEVS)
+		return -EINVAL;
+
+	if (vdev_req)
+		rsrcs = &hw->vdev[vdev_id];
+	else
+		rsrcs = &hw->pf;
+
+	arg->num_sched_domains = rsrcs->num_avail_domains;
+
+	arg->num_ldb_queues = rsrcs->num_avail_ldb_queues;
+
+	arg->num_ldb_ports = 0;
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		arg->num_ldb_ports += rsrcs->num_avail_ldb_ports[i];
+
+	arg->num_cos0_ldb_ports = rsrcs->num_avail_ldb_ports[0];
+	arg->num_cos1_ldb_ports = rsrcs->num_avail_ldb_ports[1];
+	arg->num_cos2_ldb_ports = rsrcs->num_avail_ldb_ports[2];
+	arg->num_cos3_ldb_ports = rsrcs->num_avail_ldb_ports[3];
+
+	arg->num_dir_ports = rsrcs->num_avail_dir_pq_pairs;
+
+	arg->num_atomic_inflights = rsrcs->num_avail_aqed_entries;
+
+	map = rsrcs->avail_hist_list_entries;
+
+	arg->num_hist_list_entries = dlb2_bitmap_count(map);
+
+	arg->max_contiguous_hist_list_entries =
+		dlb2_bitmap_longest_set_range(map);
+
+	arg->num_ldb_credits = rsrcs->num_avail_qed_entries;
+
+	arg->num_dir_credits = rsrcs->num_avail_dqed_entries;
+
+	return 0;
+}
+
 void dlb2_clr_pmcsr_disable(struct dlb2_hw *hw)
 {
 	union dlb2_cfg_mstr_cfg_pm_pmcsr_disable r0;
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index 73528943d36e..33c0b0ea6025 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -35,6 +35,28 @@ int dlb2_resource_init(struct dlb2_hw *hw);
 void dlb2_resource_free(struct dlb2_hw *hw);
 
 /**
+ * dlb2_hw_get_num_resources() - query the PCI function's available resources
+ * @hw: dlb2_hw handle for a particular device.
+ * @arg: pointer to resource counts.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function returns the number of available resources for the PF or for a
+ * VF.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, -EINVAL if vdev_request is true and vdev_id is
+ * invalid.
+ */
+int dlb2_hw_get_num_resources(struct dlb2_hw *hw,
+			      struct dlb2_get_num_resources_args *arg,
+			      bool vdev_request,
+			      unsigned int vdev_id);
+
+/**
  * dlb2_clr_pmcsr_disable() - power on bulk of DLB 2.0 logic
  * @hw: dlb2_hw handle for a particular device.
  *
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
new file mode 100644
index 000000000000..4742efae0b38
--- /dev/null
+++ b/include/uapi/linux/dlb2_user.h
@@ -0,0 +1,236 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+ * Copyright(c) 2016-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_USER_H
+#define __DLB2_USER_H
+
+#include <linux/types.h>
+
+struct dlb2_cmd_response {
+	__u32 status; /* Interpret using enum dlb2_error */
+	__u32 id;
+};
+
+/********************************/
+/* 'dlb2' device file commands */
+/********************************/
+
+#define DLB2_DEVICE_VERSION(x) (((x) >> 8) & 0xFF)
+#define DLB2_DEVICE_REVISION(x) ((x) & 0xFF)
+
+enum dlb2_revisions {
+	DLB2_REV_A0 = 0,
+};
+
+/*
+ * DLB2_CMD_GET_DEVICE_VERSION: Query the DLB device version.
+ *
+ *	This ioctl interface is the same in all driver versions and is always
+ *	the first ioctl.
+ *
+ * Output parameters:
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ *	response.id[7:0]: Device revision.
+ *	response.id[15:8]: Device version.
+ */
+
+struct dlb2_get_device_version_args {
+	/* Output parameters */
+	__u64 response;
+};
+
+#define DLB2_VERSION_MAJOR_NUMBER 1
+#define DLB2_VERSION_MINOR_NUMBER 0
+#define DLB2_VERSION_REVISION_NUMBER 0
+#define DLB2_VERSION (DLB2_VERSION_MAJOR_NUMBER << 24 | \
+		      DLB2_VERSION_MINOR_NUMBER << 16 | \
+		      DLB2_VERSION_REVISION_NUMBER)
+
+#define DLB2_VERSION_GET_MAJOR_NUMBER(x) (((x) >> 24) & 0xFF)
+#define DLB2_VERSION_GET_MINOR_NUMBER(x) (((x) >> 16) & 0xFF)
+#define DLB2_VERSION_GET_REVISION_NUMBER(x) ((x) & 0xFFFF)
+
+static inline __u8 dlb2_version_incompatible(__u32 version)
+{
+	__u8 inc;
+
+	inc = DLB2_VERSION_GET_MAJOR_NUMBER(version) !=
+		DLB2_VERSION_MAJOR_NUMBER;
+	inc |= (int)DLB2_VERSION_GET_MINOR_NUMBER(version) <
+		DLB2_VERSION_MINOR_NUMBER;
+
+	return inc;
+}
+
+/*
+ * DLB2_CMD_GET_DRIVER_VERSION: Query the DLB2 driver version. The major
+ *	number is changed when there is an ABI-breaking change, the minor
+ *	number is changed if the API is changed in a backwards-compatible way,
+ *	and the revision number is changed for fixes that don't affect the API.
+ *
+ *	If the kernel driver's API version major number and the header's
+ *	DLB2_VERSION_MAJOR_NUMBER differ, the two are incompatible, or if the
+ *	major numbers match but the kernel driver's minor number is less than
+ *	the header file's, they are incompatible. The DLB2_VERSION_INCOMPATIBLE
+ *	macro should be used to check for compatibility.
+ *
+ *	This ioctl interface is the same in all driver versions. Applications
+ *	should check the driver version before performing any other ioctl
+ *	operations.
+ *
+ * Output parameters:
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ *	response.id: Driver API version. Use the DLB2_VERSION_GET_MAJOR_NUMBER,
+ *		DLB2_VERSION_GET_MINOR_NUMBER, and
+ *		DLB2_VERSION_GET_REVISION_NUMBER macros to interpret the field.
+ */
+
+struct dlb2_get_driver_version_args {
+	/* Output parameters */
+	__u64 response;
+};
+
+/*
+ * DLB2_CMD_CREATE_SCHED_DOMAIN: Create a DLB 2.0 scheduling domain and reserve
+ *	its hardware resources. This command returns the newly created domain
+ *	ID and a file descriptor for accessing the domain. Additional file
+ *	descriptors can be opened using DLB2_CMD_GET_SCHED_DOMAIN_FD.
+ *
+ * Input parameters:
+ * - num_ldb_queues: Number of load-balanced queues.
+ * - num_ldb_ports: Number of load-balanced ports that can be allocated from
+ *	from any class-of-service with available ports.
+ * - num_cos0_ldb_ports: Number of load-balanced ports from class-of-service 0.
+ * - num_cos1_ldb_ports: Number of load-balanced ports from class-of-service 1.
+ * - num_cos2_ldb_ports: Number of load-balanced ports from class-of-service 2.
+ * - num_cos3_ldb_ports: Number of load-balanced ports from class-of-service 3.
+ * - num_dir_ports: Number of directed ports. A directed port has one directed
+ *	queue, so no num_dir_queues argument is necessary.
+ * - num_atomic_inflights: This specifies the amount of temporary atomic QE
+ *	storage for the domain. This storage is divided among the domain's
+ *	load-balanced queues that are configured for atomic scheduling.
+ * - num_hist_list_entries: Amount of history list storage. This is divided
+ *	among the domain's CQs.
+ * - num_ldb_credits: Amount of load-balanced QE storage (QED). QEs occupy this
+ *	space until they are scheduled to a load-balanced CQ. One credit
+ *	represents the storage for one QE.
+ * - num_dir_credits: Amount of directed QE storage (DQED). QEs occupy this
+ *	space until they are scheduled to a directed CQ. One credit represents
+ *	the storage for one QE.
+ * - cos_strict: If set, return an error if there are insufficient ports in
+ *	class-of-service N to satisfy the num_ldb_ports_cosN argument. If
+ *	unset, attempt to fulfill num_ldb_ports_cosN arguments from other
+ *	classes-of-service if class N does not contain enough free ports.
+ * - padding1: Reserved for future use.
+ *
+ * Output parameters:
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ *	response.id: domain ID.
+ * - domain_fd: file descriptor for performing the domain's ioctl operations
+ * - padding0: Reserved for future use.
+ */
+struct dlb2_create_sched_domain_args {
+	/* Output parameters */
+	__u64 response;
+	__u32 domain_fd;
+	__u32 padding0;
+	/* Input parameters */
+	__u32 num_ldb_queues;
+	__u32 num_ldb_ports;
+	__u32 num_cos0_ldb_ports;
+	__u32 num_cos1_ldb_ports;
+	__u32 num_cos2_ldb_ports;
+	__u32 num_cos3_ldb_ports;
+	__u32 num_dir_ports;
+	__u32 num_atomic_inflights;
+	__u32 num_hist_list_entries;
+	__u32 num_ldb_credits;
+	__u32 num_dir_credits;
+	__u8 cos_strict;
+	__u8 padding1[3];
+};
+
+/*
+ * DLB2_CMD_GET_NUM_RESOURCES: Return the number of available resources
+ *	(queues, ports, etc.) that this device owns.
+ *
+ * Output parameters:
+ * - num_domains: Number of available scheduling domains.
+ * - num_ldb_queues: Number of available load-balanced queues.
+ * - num_ldb_ports: Total number of available load-balanced ports.
+ * - num_cos0_ldb_ports: Number of available load-balanced ports from
+ *	class-of-service 0.
+ * - num_cos1_ldb_ports: Number of available load-balanced ports from
+ *	class-of-service 1.
+ * - num_cos2_ldb_ports: Number of available load-balanced ports from
+ *	class-of-service 2.
+ * - num_cos3_ldb_ports: Number of available load-balanced ports from
+ *	class-of-service 3.
+ * - num_dir_ports: Number of available directed ports. There is one directed
+ *	queue for every directed port.
+ * - num_atomic_inflights: Amount of available temporary atomic QE storage.
+ * - num_hist_list_entries: Amount of history list storage.
+ * - max_contiguous_hist_list_entries: History list storage is allocated in
+ *	a contiguous chunk, and this return value is the longest available
+ *	contiguous range of history list entries.
+ * - num_ldb_credits: Amount of available load-balanced QE storage.
+ * - num_dir_credits: Amount of available directed QE storage.
+ */
+struct dlb2_get_num_resources_args {
+	/* Output parameters */
+	__u32 num_sched_domains;
+	__u32 num_ldb_queues;
+	__u32 num_ldb_ports;
+	__u32 num_cos0_ldb_ports;
+	__u32 num_cos1_ldb_ports;
+	__u32 num_cos2_ldb_ports;
+	__u32 num_cos3_ldb_ports;
+	__u32 num_dir_ports;
+	__u32 num_atomic_inflights;
+	__u32 num_hist_list_entries;
+	__u32 max_contiguous_hist_list_entries;
+	__u32 num_ldb_credits;
+	__u32 num_dir_credits;
+};
+
+enum dlb2_user_interface_commands {
+	DLB2_CMD_GET_DEVICE_VERSION,
+	DLB2_CMD_CREATE_SCHED_DOMAIN,
+	DLB2_CMD_GET_NUM_RESOURCES,
+	DLB2_CMD_GET_DRIVER_VERSION,
+
+	/* NUM_DLB2_CMD must be last */
+	NUM_DLB2_CMD,
+};
+
+/********************/
+/* dlb2 ioctl codes */
+/********************/
+
+#define DLB2_IOC_MAGIC  'h'
+
+#define DLB2_IOC_GET_DEVICE_VERSION				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_GET_DEVICE_VERSION,		\
+		      struct dlb2_get_device_version_args)
+#define DLB2_IOC_CREATE_SCHED_DOMAIN				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_CREATE_SCHED_DOMAIN,		\
+		      struct dlb2_create_sched_domain_args)
+#define DLB2_IOC_GET_NUM_RESOURCES				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_GET_NUM_RESOURCES,		\
+		      struct dlb2_get_num_resources_args)
+#define DLB2_IOC_GET_DRIVER_VERSION				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_GET_DRIVER_VERSION,		\
+		      struct dlb2_get_driver_version_args)
+
+#endif /* __DLB2_USER_H */
-- 
2.13.6

