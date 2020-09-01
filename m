Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C0C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26EB20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbgIATXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:23:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:26017 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgIATVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:35 -0400
IronPort-SDR: xpdgfdapnRX7flKFFYBBAheH7zDOwugIZ69YbsjmcEWP0uxUFFY/ueijQCv0MrBk/PMLtY+tUl
 5Gpb5WDOo3pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144995653"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="144995653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:29 -0700
IronPort-SDR: CNOPhV2lFgJxy3Rs4Jfa+1fkfg5TDSJeiLfcYw3SciB3Zs17qloGBkc6Jj8fjVHS34BIWxKHnU
 GnIqdo2+zwoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480453"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:28 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 04/19] dlb2: add device ioctl layer and first three ioctls
Date:   Tue,  1 Sep 2020 14:15:33 -0500
Message-Id: <20200901191548.31646-5-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the dlb2 device ioctl layer, and the first three
ioctls: query device version, query available resources, and create a
scheduling domain. This commit also introduces the user-space interface
file dlb2_user.h.

The device version query is designed to allow each DLB device version/type
to have its own unique ioctl API through the /dev/dlb%d node. Each such API
would share in common the device version command as its first command, and
all subsequent commands can be unique to the particular device.

The PF hardware operation for scheduling domain creation will be added in a
subsequent commit.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 drivers/misc/dlb2/Makefile                         |   1 +
 drivers/misc/dlb2/dlb2_bitmap.h                    |  63 ++++++++
 drivers/misc/dlb2/dlb2_ioctl.c                     |  86 +++++++++++
 drivers/misc/dlb2/dlb2_ioctl.h                     |  12 ++
 drivers/misc/dlb2/dlb2_main.c                      |   6 +
 drivers/misc/dlb2/dlb2_main.h                      |   7 +
 drivers/misc/dlb2/dlb2_pf_ops.c                    |  21 +++
 drivers/misc/dlb2/dlb2_resource.c                  |  46 ++++++
 drivers/misc/dlb2/dlb2_resource.h                  |  22 +++
 include/uapi/linux/dlb2_user.h                     | 163 +++++++++++++++++++++
 11 files changed, 428 insertions(+)
 create mode 100644 drivers/misc/dlb2/dlb2_ioctl.c
 create mode 100644 drivers/misc/dlb2/dlb2_ioctl.h
 create mode 100644 include/uapi/linux/dlb2_user.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2a198838fca9..6cd2c1550024 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -241,6 +241,7 @@ Code  Seq#    Include File                                           Comments
 'h'   00-7F                                                          conflict! Charon filesystem
                                                                      <mailto:zapman@interlan.net>
 'h'   00-1F  linux/hpet.h                                            conflict!
+'h'   00-1F  uapi/linux/dlb2_user.h                                  conflict!
 'h'   80-8F  fs/hfsplus/ioctl.c
 'i'   00-3F  linux/i2o-dev.h                                         conflict!
 'i'   0B-1F  linux/ipmi.h                                            conflict!
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
index 000000000000..39f772d80215
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -0,0 +1,86 @@
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
+/* [7:0]: device revision, [15:8]: device version */
+#define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
+
+static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
+					 unsigned long user_arg)
+{
+	struct dlb2_get_device_version_args arg;
+
+	arg.response.status = 0;
+	arg.response.id = DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
+
+	if (copy_to_user((void __user *)user_arg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
+					  unsigned long user_arg)
+{
+	struct dlb2_create_sched_domain_args arg;
+	struct dlb2_cmd_response response = {0};
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->create_sched_domain(&dev->hw, &arg, &response);
+
+	mutex_unlock(&dev->resource_mutex);
+
+	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
+
+	if (copy_to_user((void __user *)user_arg, &response, sizeof(response)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static int dlb2_ioctl_get_num_resources(struct dlb2_dev *dev,
+					unsigned long user_arg)
+{
+	struct dlb2_get_num_resources_args arg;
+	int ret;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->get_num_resources(&dev->hw, &arg);
+
+	mutex_unlock(&dev->resource_mutex);
+
+	if (copy_to_user((void __user *)user_arg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	return ret;
+}
+
+long dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct dlb2_dev *dev;
+
+	dev = container_of(f->f_inode->i_cdev, struct dlb2_dev, cdev);
+
+	switch (cmd) {
+	case DLB2_IOC_GET_DEVICE_VERSION:
+		return dlb2_ioctl_get_device_version(dev, arg);
+	case DLB2_IOC_CREATE_SCHED_DOMAIN:
+		return dlb2_ioctl_create_sched_domain(dev, arg);
+	case DLB2_IOC_GET_NUM_RESOURCES:
+		return dlb2_ioctl_get_num_resources(dev, arg);
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/drivers/misc/dlb2/dlb2_ioctl.h b/drivers/misc/dlb2/dlb2_ioctl.h
new file mode 100644
index 000000000000..367c93b98414
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_ioctl.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2017-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_IOCTL_H
+#define __DLB2_IOCTL_H
+
+#include "dlb2_main.h"
+
+long dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg);
+
+#endif /* __DLB2_IOCTL_H */
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index f6d78d1532b0..a6e0eead7de4 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -11,12 +11,16 @@
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
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
 MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer 2.0 Driver");
@@ -63,6 +67,8 @@ static const struct file_operations dlb2_fops = {
 	.owner   = THIS_MODULE,
 	.open    = dlb2_open,
 	.release = dlb2_close,
+	.unlocked_ioctl = dlb2_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 /**********************************/
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 115cfadc0f12..5445736d86b2 100644
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
index cc35c3537507..1f5998862e31 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -175,6 +175,25 @@ dlb2_pf_init_hardware(struct dlb2_dev *dlb2_dev)
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
@@ -190,5 +209,7 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.cdev_del = dlb2_pf_cdev_del,
 	.enable_pm = dlb2_pf_enable_pm,
 	.wait_for_device_ready = dlb2_pf_wait_for_device_ready,
+	.create_sched_domain = dlb2_pf_create_sched_domain,
+	.get_num_resources = dlb2_pf_get_num_resources,
 	.init_hardware = dlb2_pf_init_hardware,
 };
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 70036a2f5d60..3b36bfef1e9b 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -185,6 +185,52 @@ int dlb2_resource_init(struct dlb2_hw *hw)
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
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		arg->num_cos_ldb_ports[i] = rsrcs->num_avail_ldb_ports[i];
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
index af20fcf0a0cb..b23676df22a6 100644
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
index 000000000000..49a8a39f79a2
--- /dev/null
+++ b/include/uapi/linux/dlb2_user.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
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
+/* 'dlb2' device file commands  */
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
+ *	Each DLB device version has its own unique ioctl API, but all share
+ *	this as the first command in their interface, which tells user-space
+ *	which API to use. The device revision is provided in case of any
+ *	hardware errata.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id[7:0]: Device revision.
+ * - response.id[15:8]: Device version.
+ */
+
+struct dlb2_get_device_version_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+};
+
+/*
+ * DLB2_CMD_CREATE_SCHED_DOMAIN: Create a DLB 2.0 scheduling domain and reserve
+ *	its hardware resources. This command returns the newly created domain
+ *	ID and a file descriptor for accessing the domain.
+ *
+ * Input parameters:
+ * - num_ldb_queues: Number of load-balanced queues.
+ * - num_ldb_ports: Number of load-balanced ports that can be allocated from
+ *	from any class-of-service with available ports.
+ * - num_cos_ldb_ports[4]: Number of load-balanced ports from
+ *	classes-of-service 0-3.
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
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: domain ID.
+ * - domain_fd: file descriptor for performing the domain's ioctl operations
+ * - padding0: Reserved for future use.
+ */
+struct dlb2_create_sched_domain_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	__u32 domain_fd;
+	__u32 padding0;
+	/* Input parameters */
+	__u32 num_ldb_queues;
+	__u32 num_ldb_ports;
+	__u32 num_cos_ldb_ports[4];
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
+ * - num_cos_ldb_ports[4]: Number of available load-balanced ports from
+ *	classes-of-service 0-3.
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
+	__u32 num_cos_ldb_ports[4];
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
+		_IOR(DLB2_IOC_MAGIC,				\
+		     DLB2_CMD_GET_DEVICE_VERSION,		\
+		     struct dlb2_get_device_version_args)
+#define DLB2_IOC_CREATE_SCHED_DOMAIN				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_CREATE_SCHED_DOMAIN,		\
+		      struct dlb2_create_sched_domain_args)
+#define DLB2_IOC_GET_NUM_RESOURCES				\
+		_IOR(DLB2_IOC_MAGIC,				\
+		     DLB2_CMD_GET_NUM_RESOURCES,		\
+		     struct dlb2_get_num_resources_args)
+
+#endif /* __DLB2_USER_H */
-- 
2.13.6

