Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A178C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1B720767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbgIATWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:26019 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgIATVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:55 -0400
IronPort-SDR: XIa6FwRGIrbogh0T4hXs+rgQYehxvxNzaRnll0Zt9O1sWo84e65lMp9Fpo7hyWTKR14e0rnCLP
 nak8f41RR6dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144995656"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="144995656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:30 -0700
IronPort-SDR: 54EexoVEkYf+3sn3QXrJlpi2eYXvizzSRpglznjMJ0Y7+vRw1vq8J/iwuLmMEXWtvBFOz9nonF
 GjydWshc9/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480459"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:29 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 05/19] dlb2: add sched domain config and reset support
Date:   Tue,  1 Sep 2020 14:15:34 -0500
Message-Id: <20200901191548.31646-6-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user requests to create a scheduling domain, the requested resources
are validated then reserved for the scheduling domain. This takes place in
dlb2_resource.c. Finally, the ioctl handler allocates an anonymous file
descriptor for the domain.

Once created, user-space can use its file descriptor for the scheduling
domain to configure the domain's resources (to be added in a subsequent
commit). User-space can also get additional file descriptors (for
multiprocess usage).

The driver maintains a reference count for each scheduling domain,
incrementing it each time user-space requests a file descriptor and
decrementing it in the file's release callback.

When the reference count transitions from 1->0 the driver automatically
resets the scheduling domain's resources and makes them available for use
by future applications. This ensures that applications that crash without
explicitly cleaning up do not orphan device resources.

Broadly speaking, the scheduling domain reset logic progressively disables
resources and flushes/drains them. The driver uses iosubmit_cmds512() to
flush load-balanced and directed ports. At the end of the domain reset
function, it resets hardware (register) state and software state.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/dlb2_bitmap.h   |  102 ++
 drivers/misc/dlb2/dlb2_hw_types.h |   92 +
 drivers/misc/dlb2/dlb2_ioctl.c    |   42 +-
 drivers/misc/dlb2/dlb2_main.c     |   73 +
 drivers/misc/dlb2/dlb2_main.h     |   25 +
 drivers/misc/dlb2/dlb2_pf_ops.c   |    9 +-
 drivers/misc/dlb2/dlb2_regs.h     | 3619 +++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.c | 3132 ++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h |   74 +
 include/uapi/linux/dlb2_user.h    |   86 +
 10 files changed, 7252 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/dlb2/dlb2_bitmap.h b/drivers/misc/dlb2/dlb2_bitmap.h
index 2d2d2927b0ec..ecc31c8b8288 100644
--- a/drivers/misc/dlb2/dlb2_bitmap.h
+++ b/drivers/misc/dlb2/dlb2_bitmap.h
@@ -119,6 +119,108 @@ static inline int dlb2_bitmap_zero(struct dlb2_bitmap *bitmap)
 }
 
 /**
+ * dlb2_bitmap_set_range() - set a range of bitmap entries
+ * @bitmap: pointer to dlb2_bitmap structure.
+ * @bit: starting bit index.
+ * @len: length of the range.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - bitmap is NULL or is uninitialized, or the range exceeds the bitmap
+ *	    length.
+ */
+static inline int dlb2_bitmap_set_range(struct dlb2_bitmap *bitmap,
+					unsigned int bit,
+					unsigned int len)
+{
+	if (!bitmap || !bitmap->map)
+		return -EINVAL;
+
+	if (bitmap->len <= bit)
+		return -EINVAL;
+
+	bitmap_set(bitmap->map, bit, len);
+
+	return 0;
+}
+
+/**
+ * dlb2_bitmap_clear_range() - clear a range of bitmap entries
+ * @bitmap: pointer to dlb2_bitmap structure.
+ * @bit: starting bit index.
+ * @len: length of the range.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - bitmap is NULL or is uninitialized, or the range exceeds the bitmap
+ *	    length.
+ */
+static inline int dlb2_bitmap_clear_range(struct dlb2_bitmap *bitmap,
+					  unsigned int bit,
+					  unsigned int len)
+{
+	if (!bitmap || !bitmap->map)
+		return -EINVAL;
+
+	if (bitmap->len <= bit)
+		return -EINVAL;
+
+	bitmap_clear(bitmap->map, bit, len);
+
+	return 0;
+}
+
+/**
+ * dlb2_bitmap_find_set_bit_range() - find an range of set bits
+ * @bitmap: pointer to dlb2_bitmap structure.
+ * @len: length of the range.
+ *
+ * This function looks for a range of set bits of length @len.
+ *
+ * Return:
+ * Returns the base bit index upon success, < 0 otherwise.
+ *
+ * Errors:
+ * ENOENT - unable to find a length *len* range of set bits.
+ * EINVAL - bitmap is NULL or is uninitialized, or len is invalid.
+ */
+static inline int dlb2_bitmap_find_set_bit_range(struct dlb2_bitmap *bitmap,
+						 unsigned int len)
+{
+	struct dlb2_bitmap *complement_mask = NULL;
+	int ret;
+
+	if (!bitmap || !bitmap->map || len == 0)
+		return -EINVAL;
+
+	if (bitmap->len < len)
+		return -ENOENT;
+
+	ret = dlb2_bitmap_alloc(&complement_mask, bitmap->len);
+	if (ret)
+		return ret;
+
+	dlb2_bitmap_zero(complement_mask);
+
+	bitmap_complement(complement_mask->map, bitmap->map, bitmap->len);
+
+	ret = bitmap_find_next_zero_area(complement_mask->map,
+					 complement_mask->len,
+					 0,
+					 len,
+					 0);
+
+	dlb2_bitmap_free(complement_mask);
+
+	/* No set bit range of length len? */
+	return (ret >= (int)bitmap->len) ? -ENOENT : ret;
+}
+
+/**
  * dlb2_bitmap_count() - returns the number of set bits
  * @bitmap: pointer to dlb2_bitmap structure.
  *
diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
index 0db398aeccd5..e43860a215ff 100644
--- a/drivers/misc/dlb2/dlb2_hw_types.h
+++ b/drivers/misc/dlb2/dlb2_hw_types.h
@@ -48,6 +48,29 @@
 #define DLB2_MAX_QID_EMPTY_CHECK_LOOPS		(32 * 64 * 1024 * (800 / 30))
 #define DLB2_HZ					800000000
 
+/*
+ * Hardware-defined base addresses. Those prefixed 'DLB2_DRV' are only used by
+ * the PF driver.
+ */
+#define DLB2_DRV_LDB_PP_BASE   0x2300000
+#define DLB2_DRV_LDB_PP_STRIDE 0x1000
+#define DLB2_DRV_LDB_PP_BOUND  (DLB2_DRV_LDB_PP_BASE + \
+				DLB2_DRV_LDB_PP_STRIDE * DLB2_MAX_NUM_LDB_PORTS)
+#define DLB2_DRV_DIR_PP_BASE   0x2200000
+#define DLB2_DRV_DIR_PP_STRIDE 0x1000
+#define DLB2_DRV_DIR_PP_BOUND  (DLB2_DRV_DIR_PP_BASE + \
+				DLB2_DRV_DIR_PP_STRIDE * DLB2_MAX_NUM_DIR_PORTS)
+#define DLB2_LDB_PP_BASE       0x2100000
+#define DLB2_LDB_PP_STRIDE     0x1000
+#define DLB2_LDB_PP_BOUND      (DLB2_LDB_PP_BASE + \
+				DLB2_LDB_PP_STRIDE * DLB2_MAX_NUM_LDB_PORTS)
+#define DLB2_LDB_PP_OFFS(id)   (DLB2_LDB_PP_BASE + (id) * DLB2_PP_SIZE)
+#define DLB2_DIR_PP_BASE       0x2000000
+#define DLB2_DIR_PP_STRIDE     0x1000
+#define DLB2_DIR_PP_BOUND      (DLB2_DIR_PP_BASE + \
+				DLB2_DIR_PP_STRIDE * DLB2_MAX_NUM_DIR_PORTS)
+#define DLB2_DIR_PP_OFFS(id)   (DLB2_DIR_PP_BASE + (id) * DLB2_PP_SIZE)
+
 struct dlb2_resource_id {
 	u32 phys_id;
 	u32 virt_id;
@@ -66,6 +89,29 @@ static inline u32 dlb2_freelist_count(struct dlb2_freelist *list)
 	return list->bound - list->base - list->offset;
 }
 
+struct dlb2_hcw {
+	u64 data;
+	/* Word 3 */
+	u16 opaque;
+	u8 qid;
+	u8 sched_type:2;
+	u8 priority:3;
+	u8 msg_type:3;
+	/* Word 4 */
+	u16 lock_id;
+	u8 ts_flag:1;
+	u8 rsvd1:2;
+	u8 no_dec:1;
+	u8 cmp_id:4;
+	u8 cq_token:1;
+	u8 qe_comp:1;
+	u8 qe_frag:1;
+	u8 qe_valid:1;
+	u8 int_arm:1;
+	u8 error:1;
+	u8 rsvd:2;
+};
+
 struct dlb2_ldb_queue {
 	struct list_head domain_list;
 	struct list_head func_list;
@@ -148,6 +194,49 @@ struct dlb2_sn_group {
 	u32 id;
 };
 
+static inline bool dlb2_sn_group_full(struct dlb2_sn_group *group)
+{
+	u32 mask[] = {
+		0x0000ffff,  /* 64 SNs per queue */
+		0x000000ff,  /* 128 SNs per queue */
+		0x0000000f,  /* 256 SNs per queue */
+		0x00000003,  /* 512 SNs per queue */
+		0x00000001}; /* 1024 SNs per queue */
+
+	return group->slot_use_bitmap == mask[group->mode];
+}
+
+static inline int dlb2_sn_group_alloc_slot(struct dlb2_sn_group *group)
+{
+	u32 bound[6] = {16, 8, 4, 2, 1};
+	u32 i;
+
+	for (i = 0; i < bound[group->mode]; i++) {
+		if (!(group->slot_use_bitmap & (1 << i))) {
+			group->slot_use_bitmap |= 1 << i;
+			return i;
+		}
+	}
+
+	return -1;
+}
+
+static inline void
+dlb2_sn_group_free_slot(struct dlb2_sn_group *group, int slot)
+{
+	group->slot_use_bitmap &= ~(1 << slot);
+}
+
+static inline int dlb2_sn_group_used_slots(struct dlb2_sn_group *group)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < 32; i++)
+		cnt += !!(group->slot_use_bitmap & (1 << i));
+
+	return cnt;
+}
+
 struct dlb2_hw_domain {
 	struct dlb2_function_resources *parent_func;
 	struct list_head func_list;
@@ -225,6 +314,9 @@ struct dlb2_hw {
 	struct dlb2_function_resources vdev[DLB2_MAX_NUM_VDEVS];
 	struct dlb2_hw_domain domains[DLB2_MAX_NUM_DOMAINS];
 	u8 cos_reservation[DLB2_NUM_COS_DOMAINS];
+
+	/* Virtualization */
+	int virt_mode;
 };
 
 #endif /* __DLB2_HW_TYPES_H */
diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 39f772d80215..56ebd9387e31 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2017-2020 Intel Corporation */
 
+#include <linux/anon_inodes.h>
 #include <linux/uaccess.h>
 
 #include <uapi/linux/dlb2_user.h>
@@ -30,15 +31,54 @@ static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
 {
 	struct dlb2_create_sched_domain_args arg;
 	struct dlb2_cmd_response response = {0};
-	int ret;
+	struct dlb2_domain *domain;
+	size_t offset;
+	int ret, fd;
 
 	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
 		return -EFAULT;
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (dev->domain_reset_failed) {
+		response.status = DLB2_ST_DOMAIN_RESET_FAILED;
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	ret = dev->ops->create_sched_domain(&dev->hw, &arg, &response);
+	if (ret)
+		goto unlock;
+
+	ret = dlb2_init_domain(dev, response.id);
+	if (ret) {
+		dev->ops->reset_domain(&dev->hw, response.id);
+		goto unlock;
+	}
+
+	domain = dev->sched_domains[response.id];
+
+	fd = anon_inode_getfd("[dlb2domain]", &dlb2_domain_fops,
+			      domain, O_RDWR);
+
+	if (fd < 0) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Failed to get anon fd.\n", __func__);
+		kref_put(&domain->refcnt, dlb2_free_domain);
+		ret = fd;
+		goto unlock;
+	}
+
+	offset = offsetof(struct dlb2_create_sched_domain_args, domain_fd);
+
+	/* There's no reason this should fail, since the copy was validated by
+	 * dlb2_copy_from_user() earlier in the function. Regardless, check for
+	 * an error (but skip the unwind code).
+	 */
+	if (copy_to_user((void __user *)user_arg + offset, &fd, sizeof(fd)))
+		return -EFAULT;
 
+unlock:
 	mutex_unlock(&dev->resource_mutex);
 
 	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index a6e0eead7de4..2e9b8c2d479c 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -55,6 +55,12 @@ static int dlb2_reset_device(struct pci_dev *pdev)
 
 static int dlb2_open(struct inode *i, struct file *f)
 {
+	struct dlb2_dev *dev;
+
+	dev = container_of(f->f_inode->i_cdev, struct dlb2_dev, cdev);
+
+	f->private_data = dev;
+
 	return 0;
 }
 
@@ -71,6 +77,73 @@ static const struct file_operations dlb2_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 };
 
+int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id)
+{
+	struct dlb2_domain *domain;
+
+	domain = devm_kzalloc(dlb2_dev->dlb2_device,
+			      sizeof(*domain),
+			      GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	domain->id = domain_id;
+
+	kref_init(&domain->refcnt);
+	domain->dlb2_dev = dlb2_dev;
+
+	dlb2_dev->sched_domains[domain_id] = domain;
+
+	return 0;
+}
+
+static int __dlb2_free_domain(struct dlb2_dev *dev, struct dlb2_domain *domain)
+{
+	int ret = 0;
+
+	ret = dev->ops->reset_domain(&dev->hw, domain->id);
+	if (ret) {
+		dev->domain_reset_failed = true;
+		dev_err(dev->dlb2_device,
+			"Internal error: Domain reset failed. To recover, reset the device.\n");
+	}
+
+	dev->sched_domains[domain->id] = NULL;
+
+	devm_kfree(dev->dlb2_device, domain);
+
+	return ret;
+}
+
+void dlb2_free_domain(struct kref *kref)
+{
+	struct dlb2_domain *domain;
+
+	domain = container_of(kref, struct dlb2_domain, refcnt);
+
+	__dlb2_free_domain(domain->dlb2_dev, domain);
+}
+
+static int dlb2_domain_close(struct inode *i, struct file *f)
+{
+	struct dlb2_domain *domain = f->private_data;
+	struct dlb2_dev *dev = domain->dlb2_dev;
+	int ret = 0;
+
+	mutex_lock(&dev->resource_mutex);
+
+	kref_put(&domain->refcnt, dlb2_free_domain);
+
+	mutex_unlock(&dev->resource_mutex);
+
+	return ret;
+}
+
+const struct file_operations dlb2_domain_fops = {
+	.owner   = THIS_MODULE,
+	.release = dlb2_domain_close,
+};
+
 /**********************************/
 /****** PCI driver callbacks ******/
 /**********************************/
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 5445736d86b2..79378a47127f 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -60,10 +60,18 @@ struct dlb2_device_ops {
 				   struct dlb2_cmd_response *resp);
 	int (*get_num_resources)(struct dlb2_hw *hw,
 				 struct dlb2_get_num_resources_args *args);
+	int (*reset_domain)(struct dlb2_hw *hw, u32 domain_id);
 	void (*init_hardware)(struct dlb2_dev *dev);
 };
 
 extern struct dlb2_device_ops dlb2_pf_ops;
+extern const struct file_operations dlb2_domain_fops;
+
+struct dlb2_domain {
+	struct dlb2_dev *dlb2_dev;
+	struct kref refcnt;
+	u8 id;
+};
 
 struct dlb2_dev {
 	struct pci_dev *pdev;
@@ -72,6 +80,7 @@ struct dlb2_dev {
 	struct dlb2_device_ops *ops;
 	struct list_head list;
 	struct device *dlb2_device;
+	struct dlb2_domain *sched_domains[DLB2_MAX_NUM_DOMAINS];
 	/*
 	 * The resource mutex serializes access to driver data structures and
 	 * hardware registers.
@@ -80,6 +89,22 @@ struct dlb2_dev {
 	enum dlb2_device_type type;
 	int id;
 	dev_t dev_number;
+	u8 domain_reset_failed;
 };
 
+int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id);
+void dlb2_free_domain(struct kref *kref);
+
+#define DLB2_HW_ERR(dlb2, ...) do {		       \
+	struct dlb2_dev *dev;			       \
+	dev = container_of(dlb2, struct dlb2_dev, hw); \
+	dev_err(dev->dlb2_device, __VA_ARGS__);        \
+} while (0)
+
+#define DLB2_HW_DBG(dlb2, ...) do {		       \
+	struct dlb2_dev *dev;			       \
+	dev = container_of(dlb2, struct dlb2_dev, hw); \
+	dev_dbg(dev->dlb2_device, __VA_ARGS__);	       \
+} while (0)
+
 #endif /* __DLB2_MAIN_H */
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 1f5998862e31..d7bff677abda 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -184,7 +184,7 @@ dlb2_pf_create_sched_domain(struct dlb2_hw *hw,
 			    struct dlb2_create_sched_domain_args *args,
 			    struct dlb2_cmd_response *resp)
 {
-	return 0;
+	return dlb2_hw_create_sched_domain(hw, args, resp, false, 0);
 }
 
 static int
@@ -194,6 +194,12 @@ dlb2_pf_get_num_resources(struct dlb2_hw *hw,
 	return dlb2_hw_get_num_resources(hw, args, false, 0);
 }
 
+static int
+dlb2_pf_reset_domain(struct dlb2_hw *hw, u32 id)
+{
+	return dlb2_reset_domain(hw, id, false, 0);
+}
+
 /********************************/
 /****** DLB2 PF Device Ops ******/
 /********************************/
@@ -211,5 +217,6 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.wait_for_device_ready = dlb2_pf_wait_for_device_ready,
 	.create_sched_domain = dlb2_pf_create_sched_domain,
 	.get_num_resources = dlb2_pf_get_num_resources,
+	.reset_domain = dlb2_pf_reset_domain,
 	.init_hardware = dlb2_pf_init_hardware,
 };
diff --git a/drivers/misc/dlb2/dlb2_regs.h b/drivers/misc/dlb2/dlb2_regs.h
index b1a3ef2f4537..6b5ac6c2932d 100644
--- a/drivers/misc/dlb2/dlb2_regs.h
+++ b/drivers/misc/dlb2/dlb2_regs.h
@@ -7,6 +7,3554 @@
 
 #include "linux/types.h"
 
+#define DLB2_FUNC_PF_VF2PF_MAILBOX_BYTES 256
+#define DLB2_FUNC_PF_VF2PF_MAILBOX(vf_id, x) \
+	(0x1000 + 0x4 * (x) + (vf_id) * 0x10000)
+#define DLB2_FUNC_PF_VF2PF_MAILBOX_RST 0x0
+union dlb2_func_pf_vf2pf_mailbox {
+	struct {
+		u32 msg : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_PF_VF2PF_MAILBOX_ISR(vf_id) \
+	(0x1f00 + (vf_id) * 0x10000)
+#define DLB2_FUNC_PF_VF2PF_MAILBOX_ISR_RST 0x0
+union dlb2_func_pf_vf2pf_mailbox_isr {
+	struct {
+		u32 vf0_isr : 1;
+		u32 vf1_isr : 1;
+		u32 vf2_isr : 1;
+		u32 vf3_isr : 1;
+		u32 vf4_isr : 1;
+		u32 vf5_isr : 1;
+		u32 vf6_isr : 1;
+		u32 vf7_isr : 1;
+		u32 vf8_isr : 1;
+		u32 vf9_isr : 1;
+		u32 vf10_isr : 1;
+		u32 vf11_isr : 1;
+		u32 vf12_isr : 1;
+		u32 vf13_isr : 1;
+		u32 vf14_isr : 1;
+		u32 vf15_isr : 1;
+		u32 rsvd0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_PF_VF2PF_FLR_ISR(vf_id) \
+	(0x1f04 + (vf_id) * 0x10000)
+#define DLB2_FUNC_PF_VF2PF_FLR_ISR_RST 0x0
+union dlb2_func_pf_vf2pf_flr_isr {
+	struct {
+		u32 vf0_isr : 1;
+		u32 vf1_isr : 1;
+		u32 vf2_isr : 1;
+		u32 vf3_isr : 1;
+		u32 vf4_isr : 1;
+		u32 vf5_isr : 1;
+		u32 vf6_isr : 1;
+		u32 vf7_isr : 1;
+		u32 vf8_isr : 1;
+		u32 vf9_isr : 1;
+		u32 vf10_isr : 1;
+		u32 vf11_isr : 1;
+		u32 vf12_isr : 1;
+		u32 vf13_isr : 1;
+		u32 vf14_isr : 1;
+		u32 vf15_isr : 1;
+		u32 rsvd0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_PF_VF2PF_ISR_PEND(vf_id) \
+	(0x1f10 + (vf_id) * 0x10000)
+#define DLB2_FUNC_PF_VF2PF_ISR_PEND_RST 0x0
+union dlb2_func_pf_vf2pf_isr_pend {
+	struct {
+		u32 isr_pend : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_PF_PF2VF_MAILBOX_BYTES 64
+#define DLB2_FUNC_PF_PF2VF_MAILBOX(vf_id, x) \
+	(0x2000 + 0x4 * (x) + (vf_id) * 0x10000)
+#define DLB2_FUNC_PF_PF2VF_MAILBOX_RST 0x0
+union dlb2_func_pf_pf2vf_mailbox {
+	struct {
+		u32 msg : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_PF_PF2VF_MAILBOX_ISR(vf_id) \
+	(0x2f00 + (vf_id) * 0x10000)
+#define DLB2_FUNC_PF_PF2VF_MAILBOX_ISR_RST 0x0
+union dlb2_func_pf_pf2vf_mailbox_isr {
+	struct {
+		u32 vf0_isr : 1;
+		u32 vf1_isr : 1;
+		u32 vf2_isr : 1;
+		u32 vf3_isr : 1;
+		u32 vf4_isr : 1;
+		u32 vf5_isr : 1;
+		u32 vf6_isr : 1;
+		u32 vf7_isr : 1;
+		u32 vf8_isr : 1;
+		u32 vf9_isr : 1;
+		u32 vf10_isr : 1;
+		u32 vf11_isr : 1;
+		u32 vf12_isr : 1;
+		u32 vf13_isr : 1;
+		u32 vf14_isr : 1;
+		u32 vf15_isr : 1;
+		u32 rsvd0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_PF_VF_RESET_IN_PROGRESS(vf_id) \
+	(0x3000 + (vf_id) * 0x10000)
+#define DLB2_FUNC_PF_VF_RESET_IN_PROGRESS_RST 0xffff
+union dlb2_func_pf_vf_reset_in_progress {
+	struct {
+		u32 vf0_reset_in_progress : 1;
+		u32 vf1_reset_in_progress : 1;
+		u32 vf2_reset_in_progress : 1;
+		u32 vf3_reset_in_progress : 1;
+		u32 vf4_reset_in_progress : 1;
+		u32 vf5_reset_in_progress : 1;
+		u32 vf6_reset_in_progress : 1;
+		u32 vf7_reset_in_progress : 1;
+		u32 vf8_reset_in_progress : 1;
+		u32 vf9_reset_in_progress : 1;
+		u32 vf10_reset_in_progress : 1;
+		u32 vf11_reset_in_progress : 1;
+		u32 vf12_reset_in_progress : 1;
+		u32 vf13_reset_in_progress : 1;
+		u32 vf14_reset_in_progress : 1;
+		u32 vf15_reset_in_progress : 1;
+		u32 rsvd0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_MSIX_MEM_VECTOR_CTRL(x) \
+	(0x100000c + (x) * 0x10)
+#define DLB2_MSIX_MEM_VECTOR_CTRL_RST 0x1
+union dlb2_msix_mem_vector_ctrl {
+	struct {
+		u32 vec_mask : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_COMP_MASK1(x) \
+	(0x8002024 + (x) * 0x40)
+#define DLB2_IOSF_SMON_COMP_MASK1_RST 0xffffffff
+union dlb2_iosf_smon_comp_mask1 {
+	struct {
+		u32 comp_mask1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_COMP_MASK0(x) \
+	(0x8002020 + (x) * 0x40)
+#define DLB2_IOSF_SMON_COMP_MASK0_RST 0xffffffff
+union dlb2_iosf_smon_comp_mask0 {
+	struct {
+		u32 comp_mask0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_MAX_TMR(x) \
+	(0x800201c + (x) * 0x40)
+#define DLB2_IOSF_SMON_MAX_TMR_RST 0x0
+union dlb2_iosf_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_TMR(x) \
+	(0x8002018 + (x) * 0x40)
+#define DLB2_IOSF_SMON_TMR_RST 0x0
+union dlb2_iosf_smon_tmr {
+	struct {
+		u32 timer_val : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_ACTIVITYCNTR1(x) \
+	(0x8002014 + (x) * 0x40)
+#define DLB2_IOSF_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_iosf_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_ACTIVITYCNTR0(x) \
+	(0x8002010 + (x) * 0x40)
+#define DLB2_IOSF_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_iosf_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_COMPARE1(x) \
+	(0x800200c + (x) * 0x40)
+#define DLB2_IOSF_SMON_COMPARE1_RST 0x0
+union dlb2_iosf_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_COMPARE0(x) \
+	(0x8002008 + (x) * 0x40)
+#define DLB2_IOSF_SMON_COMPARE0_RST 0x0
+union dlb2_iosf_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_CFG1(x) \
+	(0x8002004 + (x) * 0x40)
+#define DLB2_IOSF_SMON_CFG1_RST 0x0
+union dlb2_iosf_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvd : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_SMON_CFG0(x) \
+	(0x8002000 + (x) * 0x40)
+#define DLB2_IOSF_SMON_CFG0_RST 0x40000000
+union dlb2_iosf_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 rsvd2 : 3;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvd1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvd0 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_IOSF_FUNC_VF_BAR_DSBL(x) \
+	(0x20 + (x) * 0x4)
+#define DLB2_IOSF_FUNC_VF_BAR_DSBL_RST 0x0
+union dlb2_iosf_func_vf_bar_dsbl {
+	struct {
+		u32 func_vf_bar_dis : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_TOTAL_VAS 0x1000011c
+#define DLB2_SYS_TOTAL_VAS_RST 0x20
+union dlb2_sys_total_vas {
+	struct {
+		u32 total_vas : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_TOTAL_DIR_PORTS 0x10000118
+#define DLB2_SYS_TOTAL_DIR_PORTS_RST 0x40
+union dlb2_sys_total_dir_ports {
+	struct {
+		u32 total_dir_ports : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_TOTAL_LDB_PORTS 0x10000114
+#define DLB2_SYS_TOTAL_LDB_PORTS_RST 0x40
+union dlb2_sys_total_ldb_ports {
+	struct {
+		u32 total_ldb_ports : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_TOTAL_DIR_QID 0x10000110
+#define DLB2_SYS_TOTAL_DIR_QID_RST 0x40
+union dlb2_sys_total_dir_qid {
+	struct {
+		u32 total_dir_qid : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_TOTAL_LDB_QID 0x1000010c
+#define DLB2_SYS_TOTAL_LDB_QID_RST 0x20
+union dlb2_sys_total_ldb_qid {
+	struct {
+		u32 total_ldb_qid : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_TOTAL_DIR_CRDS 0x10000108
+#define DLB2_SYS_TOTAL_DIR_CRDS_RST 0x1000
+union dlb2_sys_total_dir_crds {
+	struct {
+		u32 total_dir_credits : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_TOTAL_LDB_CRDS 0x10000104
+#define DLB2_SYS_TOTAL_LDB_CRDS_RST 0x2000
+union dlb2_sys_total_ldb_crds {
+	struct {
+		u32 total_ldb_credits : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_ALARM_PF_SYND2 0x10000508
+#define DLB2_SYS_ALARM_PF_SYND2_RST 0x0
+union dlb2_sys_alarm_pf_synd2 {
+	struct {
+		u32 lock_id : 16;
+		u32 meas : 1;
+		u32 debug : 7;
+		u32 cq_pop : 1;
+		u32 qe_uhl : 1;
+		u32 qe_orsp : 1;
+		u32 qe_valid : 1;
+		u32 cq_int_rearm : 1;
+		u32 dsi_error : 1;
+		u32 rsvd0 : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_ALARM_PF_SYND1 0x10000504
+#define DLB2_SYS_ALARM_PF_SYND1_RST 0x0
+union dlb2_sys_alarm_pf_synd1 {
+	struct {
+		u32 dsi : 16;
+		u32 qid : 8;
+		u32 qtype : 2;
+		u32 qpri : 3;
+		u32 msg_type : 3;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_ALARM_PF_SYND0 0x10000500
+#define DLB2_SYS_ALARM_PF_SYND0_RST 0x0
+union dlb2_sys_alarm_pf_synd0 {
+	struct {
+		u32 syndrome : 8;
+		u32 rtype : 2;
+		u32 rsvd0 : 3;
+		u32 is_ldb : 1;
+		u32 cls : 2;
+		u32 aid : 6;
+		u32 unit : 4;
+		u32 source : 4;
+		u32 more : 1;
+		u32 valid : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_LDB_VPP_V(x) \
+	(0x10000f00 + (x) * 0x1000)
+#define DLB2_SYS_VF_LDB_VPP_V_RST 0x0
+union dlb2_sys_vf_ldb_vpp_v {
+	struct {
+		u32 vpp_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_LDB_VPP2PP(x) \
+	(0x10000f04 + (x) * 0x1000)
+#define DLB2_SYS_VF_LDB_VPP2PP_RST 0x0
+union dlb2_sys_vf_ldb_vpp2pp {
+	struct {
+		u32 pp : 6;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_DIR_VPP_V(x) \
+	(0x10000f08 + (x) * 0x1000)
+#define DLB2_SYS_VF_DIR_VPP_V_RST 0x0
+union dlb2_sys_vf_dir_vpp_v {
+	struct {
+		u32 vpp_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_DIR_VPP2PP(x) \
+	(0x10000f0c + (x) * 0x1000)
+#define DLB2_SYS_VF_DIR_VPP2PP_RST 0x0
+union dlb2_sys_vf_dir_vpp2pp {
+	struct {
+		u32 pp : 6;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_LDB_VQID_V(x) \
+	(0x10000f10 + (x) * 0x1000)
+#define DLB2_SYS_VF_LDB_VQID_V_RST 0x0
+union dlb2_sys_vf_ldb_vqid_v {
+	struct {
+		u32 vqid_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_LDB_VQID2QID(x) \
+	(0x10000f14 + (x) * 0x1000)
+#define DLB2_SYS_VF_LDB_VQID2QID_RST 0x0
+union dlb2_sys_vf_ldb_vqid2qid {
+	struct {
+		u32 qid : 5;
+		u32 rsvd0 : 27;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_QID2VQID(x) \
+	(0x10000f18 + (x) * 0x1000)
+#define DLB2_SYS_LDB_QID2VQID_RST 0x0
+union dlb2_sys_ldb_qid2vqid {
+	struct {
+		u32 vqid : 5;
+		u32 rsvd0 : 27;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_DIR_VQID_V(x) \
+	(0x10000f1c + (x) * 0x1000)
+#define DLB2_SYS_VF_DIR_VQID_V_RST 0x0
+union dlb2_sys_vf_dir_vqid_v {
+	struct {
+		u32 vqid_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_VF_DIR_VQID2QID(x) \
+	(0x10000f20 + (x) * 0x1000)
+#define DLB2_SYS_VF_DIR_VQID2QID_RST 0x0
+union dlb2_sys_vf_dir_vqid2qid {
+	struct {
+		u32 qid : 6;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_VASQID_V(x) \
+	(0x10000f24 + (x) * 0x1000)
+#define DLB2_SYS_LDB_VASQID_V_RST 0x0
+union dlb2_sys_ldb_vasqid_v {
+	struct {
+		u32 vasqid_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_VASQID_V(x) \
+	(0x10000f28 + (x) * 0x1000)
+#define DLB2_SYS_DIR_VASQID_V_RST 0x0
+union dlb2_sys_dir_vasqid_v {
+	struct {
+		u32 vasqid_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_ALARM_VF_SYND2(x) \
+	(0x10000f48 + (x) * 0x1000)
+#define DLB2_SYS_ALARM_VF_SYND2_RST 0x0
+union dlb2_sys_alarm_vf_synd2 {
+	struct {
+		u32 lock_id : 16;
+		u32 debug : 8;
+		u32 cq_pop : 1;
+		u32 qe_uhl : 1;
+		u32 qe_orsp : 1;
+		u32 qe_valid : 1;
+		u32 isz : 1;
+		u32 dsi_error : 1;
+		u32 dlbrsvd : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_ALARM_VF_SYND1(x) \
+	(0x10000f44 + (x) * 0x1000)
+#define DLB2_SYS_ALARM_VF_SYND1_RST 0x0
+union dlb2_sys_alarm_vf_synd1 {
+	struct {
+		u32 dsi : 16;
+		u32 qid : 8;
+		u32 qtype : 2;
+		u32 qpri : 3;
+		u32 msg_type : 3;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_ALARM_VF_SYND0(x) \
+	(0x10000f40 + (x) * 0x1000)
+#define DLB2_SYS_ALARM_VF_SYND0_RST 0x0
+union dlb2_sys_alarm_vf_synd0 {
+	struct {
+		u32 syndrome : 8;
+		u32 rtype : 2;
+		u32 vf_synd0_parity : 1;
+		u32 vf_synd1_parity : 1;
+		u32 vf_synd2_parity : 1;
+		u32 is_ldb : 1;
+		u32 cls : 2;
+		u32 aid : 6;
+		u32 unit : 4;
+		u32 source : 4;
+		u32 more : 1;
+		u32 valid : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_QID_CFG_V(x) \
+	(0x10000f58 + (x) * 0x1000)
+#define DLB2_SYS_LDB_QID_CFG_V_RST 0x0
+union dlb2_sys_ldb_qid_cfg_v {
+	struct {
+		u32 sn_cfg_v : 1;
+		u32 fid_cfg_v : 1;
+		u32 rsvd0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_QID_ITS(x) \
+	(0x10000f54 + (x) * 0x1000)
+#define DLB2_SYS_LDB_QID_ITS_RST 0x0
+union dlb2_sys_ldb_qid_its {
+	struct {
+		u32 qid_its : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_QID_V(x) \
+	(0x10000f50 + (x) * 0x1000)
+#define DLB2_SYS_LDB_QID_V_RST 0x0
+union dlb2_sys_ldb_qid_v {
+	struct {
+		u32 qid_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_QID_ITS(x) \
+	(0x10000f64 + (x) * 0x1000)
+#define DLB2_SYS_DIR_QID_ITS_RST 0x0
+union dlb2_sys_dir_qid_its {
+	struct {
+		u32 qid_its : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_QID_V(x) \
+	(0x10000f60 + (x) * 0x1000)
+#define DLB2_SYS_DIR_QID_V_RST 0x0
+union dlb2_sys_dir_qid_v {
+	struct {
+		u32 qid_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_AI_DATA(x) \
+	(0x10000fa8 + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ_AI_DATA_RST 0x0
+union dlb2_sys_ldb_cq_ai_data {
+	struct {
+		u32 cq_ai_data : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_AI_ADDR(x) \
+	(0x10000fa4 + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ_AI_ADDR_RST 0x0
+union dlb2_sys_ldb_cq_ai_addr {
+	struct {
+		u32 rsvd1 : 2;
+		u32 cq_ai_addr : 18;
+		u32 rsvd0 : 12;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_PASID(x) \
+	(0x10000fa0 + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ_PASID_RST 0x0
+union dlb2_sys_ldb_cq_pasid {
+	struct {
+		u32 pasid : 20;
+		u32 exe_req : 1;
+		u32 priv_req : 1;
+		u32 fmt2 : 1;
+		u32 rsvd0 : 9;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_AT(x) \
+	(0x10000f9c + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ_AT_RST 0x0
+union dlb2_sys_ldb_cq_at {
+	struct {
+		u32 cq_at : 2;
+		u32 rsvd0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_ISR(x) \
+	(0x10000f98 + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ_ISR_RST 0x0
+/* CQ Interrupt Modes */
+#define DLB2_CQ_ISR_MODE_DIS  0
+#define DLB2_CQ_ISR_MODE_MSI  1
+#define DLB2_CQ_ISR_MODE_MSIX 2
+#define DLB2_CQ_ISR_MODE_ADI  3
+union dlb2_sys_ldb_cq_isr {
+	struct {
+		u32 vector : 6;
+		u32 vf : 4;
+		u32 en_code : 2;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ2VF_PF_RO(x) \
+	(0x10000f94 + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ2VF_PF_RO_RST 0x0
+union dlb2_sys_ldb_cq2vf_pf_ro {
+	struct {
+		u32 vf : 4;
+		u32 is_pf : 1;
+		u32 ro : 1;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_PP_V(x) \
+	(0x10000f90 + (x) * 0x1000)
+#define DLB2_SYS_LDB_PP_V_RST 0x0
+union dlb2_sys_ldb_pp_v {
+	struct {
+		u32 pp_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_PP2VDEV(x) \
+	(0x10000f8c + (x) * 0x1000)
+#define DLB2_SYS_LDB_PP2VDEV_RST 0x0
+union dlb2_sys_ldb_pp2vdev {
+	struct {
+		u32 vdev : 4;
+		u32 rsvd0 : 28;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_PP2VAS(x) \
+	(0x10000f88 + (x) * 0x1000)
+#define DLB2_SYS_LDB_PP2VAS_RST 0x0
+union dlb2_sys_ldb_pp2vas {
+	struct {
+		u32 vas : 5;
+		u32 rsvd0 : 27;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_ADDR_U(x) \
+	(0x10000f84 + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ_ADDR_U_RST 0x0
+union dlb2_sys_ldb_cq_addr_u {
+	struct {
+		u32 addr_u : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_ADDR_L(x) \
+	(0x10000f80 + (x) * 0x1000)
+#define DLB2_SYS_LDB_CQ_ADDR_L_RST 0x0
+union dlb2_sys_ldb_cq_addr_l {
+	struct {
+		u32 rsvd0 : 6;
+		u32 addr_l : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_FMT(x) \
+	(0x10000fec + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_FMT_RST 0x0
+union dlb2_sys_dir_cq_fmt {
+	struct {
+		u32 keep_pf_ppid : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_AI_DATA(x) \
+	(0x10000fe8 + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_AI_DATA_RST 0x0
+union dlb2_sys_dir_cq_ai_data {
+	struct {
+		u32 cq_ai_data : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_AI_ADDR(x) \
+	(0x10000fe4 + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_AI_ADDR_RST 0x0
+union dlb2_sys_dir_cq_ai_addr {
+	struct {
+		u32 rsvd1 : 2;
+		u32 cq_ai_addr : 18;
+		u32 rsvd0 : 12;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_PASID(x) \
+	(0x10000fe0 + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_PASID_RST 0x0
+union dlb2_sys_dir_cq_pasid {
+	struct {
+		u32 pasid : 20;
+		u32 exe_req : 1;
+		u32 priv_req : 1;
+		u32 fmt2 : 1;
+		u32 rsvd0 : 9;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_AT(x) \
+	(0x10000fdc + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_AT_RST 0x0
+union dlb2_sys_dir_cq_at {
+	struct {
+		u32 cq_at : 2;
+		u32 rsvd0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_ISR(x) \
+	(0x10000fd8 + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_ISR_RST 0x0
+union dlb2_sys_dir_cq_isr {
+	struct {
+		u32 vector : 6;
+		u32 vf : 4;
+		u32 en_code : 2;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ2VF_PF_RO(x) \
+	(0x10000fd4 + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ2VF_PF_RO_RST 0x0
+union dlb2_sys_dir_cq2vf_pf_ro {
+	struct {
+		u32 vf : 4;
+		u32 is_pf : 1;
+		u32 ro : 1;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_PP_V(x) \
+	(0x10000fd0 + (x) * 0x1000)
+#define DLB2_SYS_DIR_PP_V_RST 0x0
+union dlb2_sys_dir_pp_v {
+	struct {
+		u32 pp_v : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_PP2VDEV(x) \
+	(0x10000fcc + (x) * 0x1000)
+#define DLB2_SYS_DIR_PP2VDEV_RST 0x0
+union dlb2_sys_dir_pp2vdev {
+	struct {
+		u32 vdev : 4;
+		u32 rsvd0 : 28;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_PP2VAS(x) \
+	(0x10000fc8 + (x) * 0x1000)
+#define DLB2_SYS_DIR_PP2VAS_RST 0x0
+union dlb2_sys_dir_pp2vas {
+	struct {
+		u32 vas : 5;
+		u32 rsvd0 : 27;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_ADDR_U(x) \
+	(0x10000fc4 + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_ADDR_U_RST 0x0
+union dlb2_sys_dir_cq_addr_u {
+	struct {
+		u32 addr_u : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_ADDR_L(x) \
+	(0x10000fc0 + (x) * 0x1000)
+#define DLB2_SYS_DIR_CQ_ADDR_L_RST 0x0
+union dlb2_sys_dir_cq_addr_l {
+	struct {
+		u32 rsvd0 : 6;
+		u32 addr_l : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_COMP_MASK1 0x10003024
+#define DLB2_SYS_PM_SMON_COMP_MASK1_RST 0xffffffff
+union dlb2_sys_pm_smon_comp_mask1 {
+	struct {
+		u32 comp_mask1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_COMP_MASK0 0x10003020
+#define DLB2_SYS_PM_SMON_COMP_MASK0_RST 0xffffffff
+union dlb2_sys_pm_smon_comp_mask0 {
+	struct {
+		u32 comp_mask0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_MAX_TMR 0x1000301c
+#define DLB2_SYS_PM_SMON_MAX_TMR_RST 0x0
+union dlb2_sys_pm_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_TMR 0x10003018
+#define DLB2_SYS_PM_SMON_TMR_RST 0x0
+union dlb2_sys_pm_smon_tmr {
+	struct {
+		u32 timer_val : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_ACTIVITYCNTR1 0x10003014
+#define DLB2_SYS_PM_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_sys_pm_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_ACTIVITYCNTR0 0x10003010
+#define DLB2_SYS_PM_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_sys_pm_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_COMPARE1 0x1000300c
+#define DLB2_SYS_PM_SMON_COMPARE1_RST 0x0
+union dlb2_sys_pm_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_COMPARE0 0x10003008
+#define DLB2_SYS_PM_SMON_COMPARE0_RST 0x0
+union dlb2_sys_pm_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_CFG1 0x10003004
+#define DLB2_SYS_PM_SMON_CFG1_RST 0x0
+union dlb2_sys_pm_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvd : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_PM_SMON_CFG0 0x10003000
+#define DLB2_SYS_PM_SMON_CFG0_RST 0x40000000
+union dlb2_sys_pm_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 rsvd2 : 3;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvd1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvd0 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_COMP_MASK1(x) \
+	(0x18002024 + (x) * 0x40)
+#define DLB2_SYS_SMON_COMP_MASK1_RST 0xffffffff
+union dlb2_sys_smon_comp_mask1 {
+	struct {
+		u32 comp_mask1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_COMP_MASK0(x) \
+	(0x18002020 + (x) * 0x40)
+#define DLB2_SYS_SMON_COMP_MASK0_RST 0xffffffff
+union dlb2_sys_smon_comp_mask0 {
+	struct {
+		u32 comp_mask0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_MAX_TMR(x) \
+	(0x1800201c + (x) * 0x40)
+#define DLB2_SYS_SMON_MAX_TMR_RST 0x0
+union dlb2_sys_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_TMR(x) \
+	(0x18002018 + (x) * 0x40)
+#define DLB2_SYS_SMON_TMR_RST 0x0
+union dlb2_sys_smon_tmr {
+	struct {
+		u32 timer_val : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_ACTIVITYCNTR1(x) \
+	(0x18002014 + (x) * 0x40)
+#define DLB2_SYS_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_sys_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_ACTIVITYCNTR0(x) \
+	(0x18002010 + (x) * 0x40)
+#define DLB2_SYS_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_sys_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_COMPARE1(x) \
+	(0x1800200c + (x) * 0x40)
+#define DLB2_SYS_SMON_COMPARE1_RST 0x0
+union dlb2_sys_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_COMPARE0(x) \
+	(0x18002008 + (x) * 0x40)
+#define DLB2_SYS_SMON_COMPARE0_RST 0x0
+union dlb2_sys_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_CFG1(x) \
+	(0x18002004 + (x) * 0x40)
+#define DLB2_SYS_SMON_CFG1_RST 0x0
+union dlb2_sys_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvd : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_SMON_CFG0(x) \
+	(0x18002000 + (x) * 0x40)
+#define DLB2_SYS_SMON_CFG0_RST 0x40000000
+union dlb2_sys_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 rsvd2 : 3;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvd1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvd0 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_INGRESS_ALARM_ENBL 0x10000300
+#define DLB2_SYS_INGRESS_ALARM_ENBL_RST 0x0
+union dlb2_sys_ingress_alarm_enbl {
+	struct {
+		u32 illegal_hcw : 1;
+		u32 illegal_pp : 1;
+		u32 illegal_pasid : 1;
+		u32 illegal_qid : 1;
+		u32 disabled_qid : 1;
+		u32 illegal_ldb_qid_cfg : 1;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_MSIX_ACK 0x10000400
+#define DLB2_SYS_MSIX_ACK_RST 0x0
+union dlb2_sys_msix_ack {
+	struct {
+		u32 msix_0_ack : 1;
+		u32 msix_1_ack : 1;
+		u32 rsvd0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_MSIX_PASSTHRU 0x10000404
+#define DLB2_SYS_MSIX_PASSTHRU_RST 0x0
+union dlb2_sys_msix_passthru {
+	struct {
+		u32 msix_0_passthru : 1;
+		u32 msix_1_passthru : 1;
+		u32 rsvd0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_MSIX_MODE 0x10000408
+#define DLB2_SYS_MSIX_MODE_RST 0x0
+/* MSI-X Modes */
+#define DLB2_MSIX_MODE_PACKED     0
+#define DLB2_MSIX_MODE_COMPRESSED 1
+union dlb2_sys_msix_mode {
+	struct {
+		u32 mode : 1;
+		u32 poll_mode : 1;
+		u32 poll_mask : 1;
+		u32 poll_lock : 1;
+		u32 rsvd0 : 28;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_31_0_OCC_INT_STS 0x10000440
+#define DLB2_SYS_DIR_CQ_31_0_OCC_INT_STS_RST 0x0
+union dlb2_sys_dir_cq_31_0_occ_int_sts {
+	struct {
+		u32 cq_0_occ_int : 1;
+		u32 cq_1_occ_int : 1;
+		u32 cq_2_occ_int : 1;
+		u32 cq_3_occ_int : 1;
+		u32 cq_4_occ_int : 1;
+		u32 cq_5_occ_int : 1;
+		u32 cq_6_occ_int : 1;
+		u32 cq_7_occ_int : 1;
+		u32 cq_8_occ_int : 1;
+		u32 cq_9_occ_int : 1;
+		u32 cq_10_occ_int : 1;
+		u32 cq_11_occ_int : 1;
+		u32 cq_12_occ_int : 1;
+		u32 cq_13_occ_int : 1;
+		u32 cq_14_occ_int : 1;
+		u32 cq_15_occ_int : 1;
+		u32 cq_16_occ_int : 1;
+		u32 cq_17_occ_int : 1;
+		u32 cq_18_occ_int : 1;
+		u32 cq_19_occ_int : 1;
+		u32 cq_20_occ_int : 1;
+		u32 cq_21_occ_int : 1;
+		u32 cq_22_occ_int : 1;
+		u32 cq_23_occ_int : 1;
+		u32 cq_24_occ_int : 1;
+		u32 cq_25_occ_int : 1;
+		u32 cq_26_occ_int : 1;
+		u32 cq_27_occ_int : 1;
+		u32 cq_28_occ_int : 1;
+		u32 cq_29_occ_int : 1;
+		u32 cq_30_occ_int : 1;
+		u32 cq_31_occ_int : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS 0x10000444
+#define DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS_RST 0x0
+union dlb2_sys_dir_cq_63_32_occ_int_sts {
+	struct {
+		u32 cq_32_occ_int : 1;
+		u32 cq_33_occ_int : 1;
+		u32 cq_34_occ_int : 1;
+		u32 cq_35_occ_int : 1;
+		u32 cq_36_occ_int : 1;
+		u32 cq_37_occ_int : 1;
+		u32 cq_38_occ_int : 1;
+		u32 cq_39_occ_int : 1;
+		u32 cq_40_occ_int : 1;
+		u32 cq_41_occ_int : 1;
+		u32 cq_42_occ_int : 1;
+		u32 cq_43_occ_int : 1;
+		u32 cq_44_occ_int : 1;
+		u32 cq_45_occ_int : 1;
+		u32 cq_46_occ_int : 1;
+		u32 cq_47_occ_int : 1;
+		u32 cq_48_occ_int : 1;
+		u32 cq_49_occ_int : 1;
+		u32 cq_50_occ_int : 1;
+		u32 cq_51_occ_int : 1;
+		u32 cq_52_occ_int : 1;
+		u32 cq_53_occ_int : 1;
+		u32 cq_54_occ_int : 1;
+		u32 cq_55_occ_int : 1;
+		u32 cq_56_occ_int : 1;
+		u32 cq_57_occ_int : 1;
+		u32 cq_58_occ_int : 1;
+		u32 cq_59_occ_int : 1;
+		u32 cq_60_occ_int : 1;
+		u32 cq_61_occ_int : 1;
+		u32 cq_62_occ_int : 1;
+		u32 cq_63_occ_int : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS 0x10000460
+#define DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS_RST 0x0
+union dlb2_sys_ldb_cq_31_0_occ_int_sts {
+	struct {
+		u32 cq_0_occ_int : 1;
+		u32 cq_1_occ_int : 1;
+		u32 cq_2_occ_int : 1;
+		u32 cq_3_occ_int : 1;
+		u32 cq_4_occ_int : 1;
+		u32 cq_5_occ_int : 1;
+		u32 cq_6_occ_int : 1;
+		u32 cq_7_occ_int : 1;
+		u32 cq_8_occ_int : 1;
+		u32 cq_9_occ_int : 1;
+		u32 cq_10_occ_int : 1;
+		u32 cq_11_occ_int : 1;
+		u32 cq_12_occ_int : 1;
+		u32 cq_13_occ_int : 1;
+		u32 cq_14_occ_int : 1;
+		u32 cq_15_occ_int : 1;
+		u32 cq_16_occ_int : 1;
+		u32 cq_17_occ_int : 1;
+		u32 cq_18_occ_int : 1;
+		u32 cq_19_occ_int : 1;
+		u32 cq_20_occ_int : 1;
+		u32 cq_21_occ_int : 1;
+		u32 cq_22_occ_int : 1;
+		u32 cq_23_occ_int : 1;
+		u32 cq_24_occ_int : 1;
+		u32 cq_25_occ_int : 1;
+		u32 cq_26_occ_int : 1;
+		u32 cq_27_occ_int : 1;
+		u32 cq_28_occ_int : 1;
+		u32 cq_29_occ_int : 1;
+		u32 cq_30_occ_int : 1;
+		u32 cq_31_occ_int : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_LDB_CQ_63_32_OCC_INT_STS 0x10000464
+#define DLB2_SYS_LDB_CQ_63_32_OCC_INT_STS_RST 0x0
+union dlb2_sys_ldb_cq_63_32_occ_int_sts {
+	struct {
+		u32 cq_32_occ_int : 1;
+		u32 cq_33_occ_int : 1;
+		u32 cq_34_occ_int : 1;
+		u32 cq_35_occ_int : 1;
+		u32 cq_36_occ_int : 1;
+		u32 cq_37_occ_int : 1;
+		u32 cq_38_occ_int : 1;
+		u32 cq_39_occ_int : 1;
+		u32 cq_40_occ_int : 1;
+		u32 cq_41_occ_int : 1;
+		u32 cq_42_occ_int : 1;
+		u32 cq_43_occ_int : 1;
+		u32 cq_44_occ_int : 1;
+		u32 cq_45_occ_int : 1;
+		u32 cq_46_occ_int : 1;
+		u32 cq_47_occ_int : 1;
+		u32 cq_48_occ_int : 1;
+		u32 cq_49_occ_int : 1;
+		u32 cq_50_occ_int : 1;
+		u32 cq_51_occ_int : 1;
+		u32 cq_52_occ_int : 1;
+		u32 cq_53_occ_int : 1;
+		u32 cq_54_occ_int : 1;
+		u32 cq_55_occ_int : 1;
+		u32 cq_56_occ_int : 1;
+		u32 cq_57_occ_int : 1;
+		u32 cq_58_occ_int : 1;
+		u32 cq_59_occ_int : 1;
+		u32 cq_60_occ_int : 1;
+		u32 cq_61_occ_int : 1;
+		u32 cq_62_occ_int : 1;
+		u32 cq_63_occ_int : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_DIR_CQ_OPT_CLR 0x100004c0
+#define DLB2_SYS_DIR_CQ_OPT_CLR_RST 0x0
+union dlb2_sys_dir_cq_opt_clr {
+	struct {
+		u32 cq : 6;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_SYS_ALARM_HW_SYND 0x1000050c
+#define DLB2_SYS_ALARM_HW_SYND_RST 0x0
+union dlb2_sys_alarm_hw_synd {
+	struct {
+		u32 syndrome : 8;
+		u32 rtype : 2;
+		u32 alarm : 1;
+		u32 cwd : 1;
+		u32 vf_pf_mb : 1;
+		u32 rsvd0 : 1;
+		u32 cls : 2;
+		u32 aid : 6;
+		u32 unit : 4;
+		u32 source : 4;
+		u32 more : 1;
+		u32 valid : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_QID_FID_LIM(x) \
+	(0x20000000 + (x) * 0x1000)
+#define DLB2_AQED_PIPE_QID_FID_LIM_RST 0x7ff
+union dlb2_aqed_pipe_qid_fid_lim {
+	struct {
+		u32 qid_fid_limit : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_QID_HID_WIDTH(x) \
+	(0x20080000 + (x) * 0x1000)
+#define DLB2_AQED_PIPE_QID_HID_WIDTH_RST 0x0
+union dlb2_aqed_pipe_qid_hid_width {
+	struct {
+		u32 compress_code : 3;
+		u32 rsvd0 : 29;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_CFG_ARB_WEIGHTS_TQPRI_ATM_0 0x24000004
+#define DLB2_AQED_PIPE_CFG_ARB_WEIGHTS_TQPRI_ATM_0_RST 0xfefcfaf8
+union dlb2_aqed_pipe_cfg_arb_weights_tqpri_atm_0 {
+	struct {
+		u32 pri0 : 8;
+		u32 pri1 : 8;
+		u32 pri2 : 8;
+		u32 pri3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_ACTIVITYCNTR0 0x2c00004c
+#define DLB2_AQED_PIPE_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_aqed_pipe_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_ACTIVITYCNTR1 0x2c000050
+#define DLB2_AQED_PIPE_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_aqed_pipe_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_COMPARE0 0x2c000054
+#define DLB2_AQED_PIPE_SMON_COMPARE0_RST 0x0
+union dlb2_aqed_pipe_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_COMPARE1 0x2c000058
+#define DLB2_AQED_PIPE_SMON_COMPARE1_RST 0x0
+union dlb2_aqed_pipe_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_CFG0 0x2c00005c
+#define DLB2_AQED_PIPE_SMON_CFG0_RST 0x40000000
+union dlb2_aqed_pipe_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_CFG1 0x2c000060
+#define DLB2_AQED_PIPE_SMON_CFG1_RST 0x0
+union dlb2_aqed_pipe_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_MAX_TMR 0x2c000064
+#define DLB2_AQED_PIPE_SMON_MAX_TMR_RST 0x0
+union dlb2_aqed_pipe_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_AQED_PIPE_SMON_TMR 0x2c000068
+#define DLB2_AQED_PIPE_SMON_TMR_RST 0x0
+union dlb2_aqed_pipe_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_QID2CQIDIX_00(x) \
+	(0x30080000 + (x) * 0x1000)
+#define DLB2_ATM_QID2CQIDIX_00_RST 0x0
+#define DLB2_ATM_QID2CQIDIX(x, y) \
+	(DLB2_ATM_QID2CQIDIX_00(x) + 0x80000 * (y))
+#define DLB2_ATM_QID2CQIDIX_NUM 16
+union dlb2_atm_qid2cqidix_00 {
+	struct {
+		u32 cq_p0 : 8;
+		u32 cq_p1 : 8;
+		u32 cq_p2 : 8;
+		u32 cq_p3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_CFG_ARB_WEIGHTS_RDY_BIN 0x34000004
+#define DLB2_ATM_CFG_ARB_WEIGHTS_RDY_BIN_RST 0xfffefdfc
+union dlb2_atm_cfg_arb_weights_rdy_bin {
+	struct {
+		u32 bin0 : 8;
+		u32 bin1 : 8;
+		u32 bin2 : 8;
+		u32 bin3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_CFG_ARB_WEIGHTS_SCHED_BIN 0x34000008
+#define DLB2_ATM_CFG_ARB_WEIGHTS_SCHED_BIN_RST 0xfffefdfc
+union dlb2_atm_cfg_arb_weights_sched_bin {
+	struct {
+		u32 bin0 : 8;
+		u32 bin1 : 8;
+		u32 bin2 : 8;
+		u32 bin3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_ACTIVITYCNTR0 0x3c000050
+#define DLB2_ATM_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_atm_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_ACTIVITYCNTR1 0x3c000054
+#define DLB2_ATM_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_atm_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_COMPARE0 0x3c000058
+#define DLB2_ATM_SMON_COMPARE0_RST 0x0
+union dlb2_atm_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_COMPARE1 0x3c00005c
+#define DLB2_ATM_SMON_COMPARE1_RST 0x0
+union dlb2_atm_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_CFG0 0x3c000060
+#define DLB2_ATM_SMON_CFG0_RST 0x40000000
+union dlb2_atm_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_CFG1 0x3c000064
+#define DLB2_ATM_SMON_CFG1_RST 0x0
+union dlb2_atm_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_MAX_TMR 0x3c000068
+#define DLB2_ATM_SMON_MAX_TMR_RST 0x0
+union dlb2_atm_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_ATM_SMON_TMR 0x3c00006c
+#define DLB2_ATM_SMON_TMR_RST 0x0
+union dlb2_atm_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_VAS_CRD(x) \
+	(0x40000000 + (x) * 0x1000)
+#define DLB2_CHP_CFG_DIR_VAS_CRD_RST 0x0
+union dlb2_chp_cfg_dir_vas_crd {
+	struct {
+		u32 count : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_VAS_CRD(x) \
+	(0x40080000 + (x) * 0x1000)
+#define DLB2_CHP_CFG_LDB_VAS_CRD_RST 0x0
+union dlb2_chp_cfg_ldb_vas_crd {
+	struct {
+		u32 count : 15;
+		u32 rsvd0 : 17;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_ORD_QID_SN(x) \
+	(0x40100000 + (x) * 0x1000)
+#define DLB2_CHP_ORD_QID_SN_RST 0x0
+union dlb2_chp_ord_qid_sn {
+	struct {
+		u32 sn : 10;
+		u32 rsvd0 : 22;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_ORD_QID_SN_MAP(x) \
+	(0x40180000 + (x) * 0x1000)
+#define DLB2_CHP_ORD_QID_SN_MAP_RST 0x0
+union dlb2_chp_ord_qid_sn_map {
+	struct {
+		u32 mode : 3;
+		u32 slot : 4;
+		u32 rsvz0 : 1;
+		u32 grp : 1;
+		u32 rsvz1 : 1;
+		u32 rsvd0 : 22;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SN_CHK_ENBL(x) \
+	(0x40200000 + (x) * 0x1000)
+#define DLB2_CHP_SN_CHK_ENBL_RST 0x0
+union dlb2_chp_sn_chk_enbl {
+	struct {
+		u32 en : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_DEPTH(x) \
+	(0x40280000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ_DEPTH_RST 0x0
+union dlb2_chp_dir_cq_depth {
+	struct {
+		u32 depth : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_INT_DEPTH_THRSH(x) \
+	(0x40300000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ_INT_DEPTH_THRSH_RST 0x0
+union dlb2_chp_dir_cq_int_depth_thrsh {
+	struct {
+		u32 depth_threshold : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_INT_ENB(x) \
+	(0x40380000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ_INT_ENB_RST 0x0
+union dlb2_chp_dir_cq_int_enb {
+	struct {
+		u32 en_tim : 1;
+		u32 en_depth : 1;
+		u32 rsvd0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_TMR_THRSH(x) \
+	(0x40480000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ_TMR_THRSH_RST 0x1
+union dlb2_chp_dir_cq_tmr_thrsh {
+	struct {
+		u32 thrsh_0 : 1;
+		u32 thrsh_13_1 : 13;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_TKN_DEPTH_SEL(x) \
+	(0x40500000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ_TKN_DEPTH_SEL_RST 0x0
+union dlb2_chp_dir_cq_tkn_depth_sel {
+	struct {
+		u32 token_depth_select : 4;
+		u32 rsvd0 : 28;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_WD_ENB(x) \
+	(0x40580000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ_WD_ENB_RST 0x0
+union dlb2_chp_dir_cq_wd_enb {
+	struct {
+		u32 wd_enable : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_WPTR(x) \
+	(0x40600000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ_WPTR_RST 0x0
+union dlb2_chp_dir_cq_wptr {
+	struct {
+		u32 write_pointer : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ2VAS(x) \
+	(0x40680000 + (x) * 0x1000)
+#define DLB2_CHP_DIR_CQ2VAS_RST 0x0
+union dlb2_chp_dir_cq2vas {
+	struct {
+		u32 cq2vas : 5;
+		u32 rsvd0 : 27;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_HIST_LIST_BASE(x) \
+	(0x40700000 + (x) * 0x1000)
+#define DLB2_CHP_HIST_LIST_BASE_RST 0x0
+union dlb2_chp_hist_list_base {
+	struct {
+		u32 base : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_HIST_LIST_LIM(x) \
+	(0x40780000 + (x) * 0x1000)
+#define DLB2_CHP_HIST_LIST_LIM_RST 0x0
+union dlb2_chp_hist_list_lim {
+	struct {
+		u32 limit : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_HIST_LIST_POP_PTR(x) \
+	(0x40800000 + (x) * 0x1000)
+#define DLB2_CHP_HIST_LIST_POP_PTR_RST 0x0
+union dlb2_chp_hist_list_pop_ptr {
+	struct {
+		u32 pop_ptr : 13;
+		u32 generation : 1;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_HIST_LIST_PUSH_PTR(x) \
+	(0x40880000 + (x) * 0x1000)
+#define DLB2_CHP_HIST_LIST_PUSH_PTR_RST 0x0
+union dlb2_chp_hist_list_push_ptr {
+	struct {
+		u32 push_ptr : 13;
+		u32 generation : 1;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_DEPTH(x) \
+	(0x40900000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ_DEPTH_RST 0x0
+union dlb2_chp_ldb_cq_depth {
+	struct {
+		u32 depth : 11;
+		u32 rsvd0 : 21;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_INT_DEPTH_THRSH(x) \
+	(0x40980000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ_INT_DEPTH_THRSH_RST 0x0
+union dlb2_chp_ldb_cq_int_depth_thrsh {
+	struct {
+		u32 depth_threshold : 11;
+		u32 rsvd0 : 21;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_INT_ENB(x) \
+	(0x40a00000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ_INT_ENB_RST 0x0
+union dlb2_chp_ldb_cq_int_enb {
+	struct {
+		u32 en_tim : 1;
+		u32 en_depth : 1;
+		u32 rsvd0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_TMR_THRSH(x) \
+	(0x40b00000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ_TMR_THRSH_RST 0x1
+union dlb2_chp_ldb_cq_tmr_thrsh {
+	struct {
+		u32 thrsh_0 : 1;
+		u32 thrsh_13_1 : 13;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_TKN_DEPTH_SEL(x) \
+	(0x40b80000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ_TKN_DEPTH_SEL_RST 0x0
+union dlb2_chp_ldb_cq_tkn_depth_sel {
+	struct {
+		u32 token_depth_select : 4;
+		u32 rsvd0 : 28;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_WD_ENB(x) \
+	(0x40c00000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ_WD_ENB_RST 0x0
+union dlb2_chp_ldb_cq_wd_enb {
+	struct {
+		u32 wd_enable : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_WPTR(x) \
+	(0x40c80000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ_WPTR_RST 0x0
+union dlb2_chp_ldb_cq_wptr {
+	struct {
+		u32 write_pointer : 11;
+		u32 rsvd0 : 21;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ2VAS(x) \
+	(0x40d00000 + (x) * 0x1000)
+#define DLB2_CHP_LDB_CQ2VAS_RST 0x0
+union dlb2_chp_ldb_cq2vas {
+	struct {
+		u32 cq2vas : 5;
+		u32 rsvd0 : 27;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_CHP_CSR_CTRL 0x44000008
+#define DLB2_CHP_CFG_CHP_CSR_CTRL_RST 0x180002
+union dlb2_chp_cfg_chp_csr_ctrl {
+	struct {
+		u32 int_cor_alarm_dis : 1;
+		u32 int_cor_synd_dis : 1;
+		u32 int_uncr_alarm_dis : 1;
+		u32 int_unc_synd_dis : 1;
+		u32 int_inf0_alarm_dis : 1;
+		u32 int_inf0_synd_dis : 1;
+		u32 int_inf1_alarm_dis : 1;
+		u32 int_inf1_synd_dis : 1;
+		u32 int_inf2_alarm_dis : 1;
+		u32 int_inf2_synd_dis : 1;
+		u32 int_inf3_alarm_dis : 1;
+		u32 int_inf3_synd_dis : 1;
+		u32 int_inf4_alarm_dis : 1;
+		u32 int_inf4_synd_dis : 1;
+		u32 int_inf5_alarm_dis : 1;
+		u32 int_inf5_synd_dis : 1;
+		u32 dlb_cor_alarm_enable : 1;
+		u32 cfg_64bytes_qe_ldb_cq_mode : 1;
+		u32 cfg_64bytes_qe_dir_cq_mode : 1;
+		u32 pad_write_ldb : 1;
+		u32 pad_write_dir : 1;
+		u32 pad_first_write_ldb : 1;
+		u32 pad_first_write_dir : 1;
+		u32 rsvz0 : 9;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_INTR_ARMED0 0x4400005c
+#define DLB2_CHP_DIR_CQ_INTR_ARMED0_RST 0x0
+union dlb2_chp_dir_cq_intr_armed0 {
+	struct {
+		u32 armed : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_DIR_CQ_INTR_ARMED1 0x44000060
+#define DLB2_CHP_DIR_CQ_INTR_ARMED1_RST 0x0
+union dlb2_chp_dir_cq_intr_armed1 {
+	struct {
+		u32 armed : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_CQ_TIMER_CTL 0x44000084
+#define DLB2_CHP_CFG_DIR_CQ_TIMER_CTL_RST 0x0
+union dlb2_chp_cfg_dir_cq_timer_ctl {
+	struct {
+		u32 sample_interval : 8;
+		u32 enb : 1;
+		u32 rsvz0 : 23;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_WDTO_0 0x44000088
+#define DLB2_CHP_CFG_DIR_WDTO_0_RST 0x0
+union dlb2_chp_cfg_dir_wdto_0 {
+	struct {
+		u32 wdto : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_WDTO_1 0x4400008c
+#define DLB2_CHP_CFG_DIR_WDTO_1_RST 0x0
+union dlb2_chp_cfg_dir_wdto_1 {
+	struct {
+		u32 wdto : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_WD_DISABLE0 0x44000098
+#define DLB2_CHP_CFG_DIR_WD_DISABLE0_RST 0xffffffff
+union dlb2_chp_cfg_dir_wd_disable0 {
+	struct {
+		u32 wd_disable : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_WD_DISABLE1 0x4400009c
+#define DLB2_CHP_CFG_DIR_WD_DISABLE1_RST 0xffffffff
+union dlb2_chp_cfg_dir_wd_disable1 {
+	struct {
+		u32 wd_disable : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_WD_ENB_INTERVAL 0x440000a0
+#define DLB2_CHP_CFG_DIR_WD_ENB_INTERVAL_RST 0x0
+union dlb2_chp_cfg_dir_wd_enb_interval {
+	struct {
+		u32 sample_interval : 28;
+		u32 enb : 1;
+		u32 rsvz0 : 3;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_DIR_WD_THRESHOLD 0x440000ac
+#define DLB2_CHP_CFG_DIR_WD_THRESHOLD_RST 0x0
+union dlb2_chp_cfg_dir_wd_threshold {
+	struct {
+		u32 wd_threshold : 8;
+		u32 rsvz0 : 24;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_INTR_ARMED0 0x440000b0
+#define DLB2_CHP_LDB_CQ_INTR_ARMED0_RST 0x0
+union dlb2_chp_ldb_cq_intr_armed0 {
+	struct {
+		u32 armed : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_LDB_CQ_INTR_ARMED1 0x440000b4
+#define DLB2_CHP_LDB_CQ_INTR_ARMED1_RST 0x0
+union dlb2_chp_ldb_cq_intr_armed1 {
+	struct {
+		u32 armed : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_CQ_TIMER_CTL 0x440000d8
+#define DLB2_CHP_CFG_LDB_CQ_TIMER_CTL_RST 0x0
+union dlb2_chp_cfg_ldb_cq_timer_ctl {
+	struct {
+		u32 sample_interval : 8;
+		u32 enb : 1;
+		u32 rsvz0 : 23;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_WDTO_0 0x440000dc
+#define DLB2_CHP_CFG_LDB_WDTO_0_RST 0x0
+union dlb2_chp_cfg_ldb_wdto_0 {
+	struct {
+		u32 wdto : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_WDTO_1 0x440000e0
+#define DLB2_CHP_CFG_LDB_WDTO_1_RST 0x0
+union dlb2_chp_cfg_ldb_wdto_1 {
+	struct {
+		u32 wdto : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_WD_DISABLE0 0x440000ec
+#define DLB2_CHP_CFG_LDB_WD_DISABLE0_RST 0xffffffff
+union dlb2_chp_cfg_ldb_wd_disable0 {
+	struct {
+		u32 wd_disable : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_WD_DISABLE1 0x440000f0
+#define DLB2_CHP_CFG_LDB_WD_DISABLE1_RST 0xffffffff
+union dlb2_chp_cfg_ldb_wd_disable1 {
+	struct {
+		u32 wd_disable : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_WD_ENB_INTERVAL 0x440000f4
+#define DLB2_CHP_CFG_LDB_WD_ENB_INTERVAL_RST 0x0
+union dlb2_chp_cfg_ldb_wd_enb_interval {
+	struct {
+		u32 sample_interval : 28;
+		u32 enb : 1;
+		u32 rsvz0 : 3;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CFG_LDB_WD_THRESHOLD 0x44000100
+#define DLB2_CHP_CFG_LDB_WD_THRESHOLD_RST 0x0
+union dlb2_chp_cfg_ldb_wd_threshold {
+	struct {
+		u32 wd_threshold : 8;
+		u32 rsvz0 : 24;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_COMPARE0 0x4c000000
+#define DLB2_CHP_SMON_COMPARE0_RST 0x0
+union dlb2_chp_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_COMPARE1 0x4c000004
+#define DLB2_CHP_SMON_COMPARE1_RST 0x0
+union dlb2_chp_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_CFG0 0x4c000008
+#define DLB2_CHP_SMON_CFG0_RST 0x40000000
+union dlb2_chp_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_CFG1 0x4c00000c
+#define DLB2_CHP_SMON_CFG1_RST 0x0
+union dlb2_chp_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_ACTIVITYCNTR0 0x4c000010
+#define DLB2_CHP_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_chp_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_ACTIVITYCNTR1 0x4c000014
+#define DLB2_CHP_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_chp_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_MAX_TMR 0x4c000018
+#define DLB2_CHP_SMON_MAX_TMR_RST 0x0
+union dlb2_chp_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_SMON_TMR 0x4c00001c
+#define DLB2_CHP_SMON_TMR_RST 0x0
+union dlb2_chp_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CHP_CTRL_DIAG_02 0x4c000028
+#define DLB2_CHP_CTRL_DIAG_02_RST 0x1555
+union dlb2_chp_ctrl_diag_02 {
+	struct {
+		u32 egress_credit_status_empty : 1;
+		u32 egress_credit_status_afull : 1;
+		u32 chp_outbound_hcw_pipe_credit_status_empty : 1;
+		u32 chp_outbound_hcw_pipe_credit_status_afull : 1;
+		u32 chp_lsp_ap_cmp_pipe_credit_status_empty : 1;
+		u32 chp_lsp_ap_cmp_pipe_credit_status_afull : 1;
+		u32 chp_lsp_tok_pipe_credit_status_empty : 1;
+		u32 chp_lsp_tok_pipe_credit_status_afull : 1;
+		u32 chp_rop_pipe_credit_status_empty : 1;
+		u32 chp_rop_pipe_credit_status_afull : 1;
+		u32 qed_to_cq_pipe_credit_status_empty : 1;
+		u32 qed_to_cq_pipe_credit_status_afull : 1;
+		u32 egress_lsp_token_credit_status_empty : 1;
+		u32 egress_lsp_token_credit_status_afull : 1;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_DIR_0 0x54000000
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_DIR_0_RST 0xfefcfaf8
+union dlb2_dp_cfg_arb_weights_tqpri_dir_0 {
+	struct {
+		u32 pri0 : 8;
+		u32 pri1 : 8;
+		u32 pri2 : 8;
+		u32 pri3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_DIR_1 0x54000004
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_DIR_1_RST 0x0
+union dlb2_dp_cfg_arb_weights_tqpri_dir_1 {
+	struct {
+		u32 rsvz0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_REPLAY_0 0x54000008
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_REPLAY_0_RST 0xfefcfaf8
+union dlb2_dp_cfg_arb_weights_tqpri_replay_0 {
+	struct {
+		u32 pri0 : 8;
+		u32 pri1 : 8;
+		u32 pri2 : 8;
+		u32 pri3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_REPLAY_1 0x5400000c
+#define DLB2_DP_CFG_ARB_WEIGHTS_TQPRI_REPLAY_1_RST 0x0
+union dlb2_dp_cfg_arb_weights_tqpri_replay_1 {
+	struct {
+		u32 rsvz0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_DIR_CSR_CTRL 0x54000010
+#define DLB2_DP_DIR_CSR_CTRL_RST 0x0
+union dlb2_dp_dir_csr_ctrl {
+	struct {
+		u32 int_cor_alarm_dis : 1;
+		u32 int_cor_synd_dis : 1;
+		u32 int_uncr_alarm_dis : 1;
+		u32 int_unc_synd_dis : 1;
+		u32 int_inf0_alarm_dis : 1;
+		u32 int_inf0_synd_dis : 1;
+		u32 int_inf1_alarm_dis : 1;
+		u32 int_inf1_synd_dis : 1;
+		u32 int_inf2_alarm_dis : 1;
+		u32 int_inf2_synd_dis : 1;
+		u32 int_inf3_alarm_dis : 1;
+		u32 int_inf3_synd_dis : 1;
+		u32 int_inf4_alarm_dis : 1;
+		u32 int_inf4_synd_dis : 1;
+		u32 int_inf5_alarm_dis : 1;
+		u32 int_inf5_synd_dis : 1;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_ACTIVITYCNTR0 0x5c000058
+#define DLB2_DP_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_dp_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_ACTIVITYCNTR1 0x5c00005c
+#define DLB2_DP_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_dp_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_COMPARE0 0x5c000060
+#define DLB2_DP_SMON_COMPARE0_RST 0x0
+union dlb2_dp_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_COMPARE1 0x5c000064
+#define DLB2_DP_SMON_COMPARE1_RST 0x0
+union dlb2_dp_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_CFG0 0x5c000068
+#define DLB2_DP_SMON_CFG0_RST 0x40000000
+union dlb2_dp_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_CFG1 0x5c00006c
+#define DLB2_DP_SMON_CFG1_RST 0x0
+union dlb2_dp_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_MAX_TMR 0x5c000070
+#define DLB2_DP_SMON_MAX_TMR_RST 0x0
+union dlb2_dp_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DP_SMON_TMR 0x5c000074
+#define DLB2_DP_SMON_TMR_RST 0x0
+union dlb2_dp_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_ACTIVITYCNTR0 0x6c000024
+#define DLB2_DQED_PIPE_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_dqed_pipe_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_ACTIVITYCNTR1 0x6c000028
+#define DLB2_DQED_PIPE_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_dqed_pipe_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_COMPARE0 0x6c00002c
+#define DLB2_DQED_PIPE_SMON_COMPARE0_RST 0x0
+union dlb2_dqed_pipe_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_COMPARE1 0x6c000030
+#define DLB2_DQED_PIPE_SMON_COMPARE1_RST 0x0
+union dlb2_dqed_pipe_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_CFG0 0x6c000034
+#define DLB2_DQED_PIPE_SMON_CFG0_RST 0x40000000
+union dlb2_dqed_pipe_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_CFG1 0x6c000038
+#define DLB2_DQED_PIPE_SMON_CFG1_RST 0x0
+union dlb2_dqed_pipe_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_MAX_TMR 0x6c00003c
+#define DLB2_DQED_PIPE_SMON_MAX_TMR_RST 0x0
+union dlb2_dqed_pipe_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_DQED_PIPE_SMON_TMR 0x6c000040
+#define DLB2_DQED_PIPE_SMON_TMR_RST 0x0
+union dlb2_dqed_pipe_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_ACTIVITYCNTR0 0x7c000024
+#define DLB2_QED_PIPE_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_qed_pipe_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_ACTIVITYCNTR1 0x7c000028
+#define DLB2_QED_PIPE_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_qed_pipe_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_COMPARE0 0x7c00002c
+#define DLB2_QED_PIPE_SMON_COMPARE0_RST 0x0
+union dlb2_qed_pipe_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_COMPARE1 0x7c000030
+#define DLB2_QED_PIPE_SMON_COMPARE1_RST 0x0
+union dlb2_qed_pipe_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_CFG0 0x7c000034
+#define DLB2_QED_PIPE_SMON_CFG0_RST 0x40000000
+union dlb2_qed_pipe_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_CFG1 0x7c000038
+#define DLB2_QED_PIPE_SMON_CFG1_RST 0x0
+union dlb2_qed_pipe_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_MAX_TMR 0x7c00003c
+#define DLB2_QED_PIPE_SMON_MAX_TMR_RST 0x0
+union dlb2_qed_pipe_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_QED_PIPE_SMON_TMR 0x7c000040
+#define DLB2_QED_PIPE_SMON_TMR_RST 0x0
+union dlb2_qed_pipe_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_ATQ_0 0x84000000
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_ATQ_0_RST 0xfefcfaf8
+union dlb2_nalb_pipe_cfg_arb_weights_tqpri_atq_0 {
+	struct {
+		u32 pri0 : 8;
+		u32 pri1 : 8;
+		u32 pri2 : 8;
+		u32 pri3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_ATQ_1 0x84000004
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_ATQ_1_RST 0x0
+union dlb2_nalb_pipe_cfg_arb_weights_tqpri_atq_1 {
+	struct {
+		u32 rsvz0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_NALB_0 0x84000008
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_NALB_0_RST 0xfefcfaf8
+union dlb2_nalb_pipe_cfg_arb_weights_tqpri_nalb_0 {
+	struct {
+		u32 pri0 : 8;
+		u32 pri1 : 8;
+		u32 pri2 : 8;
+		u32 pri3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_NALB_1 0x8400000c
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_NALB_1_RST 0x0
+union dlb2_nalb_pipe_cfg_arb_weights_tqpri_nalb_1 {
+	struct {
+		u32 rsvz0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_REPLAY_0 0x84000010
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_REPLAY_0_RST 0xfefcfaf8
+union dlb2_nalb_pipe_cfg_arb_weights_tqpri_replay_0 {
+	struct {
+		u32 pri0 : 8;
+		u32 pri1 : 8;
+		u32 pri2 : 8;
+		u32 pri3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_REPLAY_1 0x84000014
+#define DLB2_NALB_PIPE_CFG_ARB_WEIGHTS_TQPRI_REPLAY_1_RST 0x0
+union dlb2_nalb_pipe_cfg_arb_weights_tqpri_replay_1 {
+	struct {
+		u32 rsvz0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_ACTIVITYCNTR0 0x8c000064
+#define DLB2_NALB_PIPE_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_nalb_pipe_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_ACTIVITYCNTR1 0x8c000068
+#define DLB2_NALB_PIPE_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_nalb_pipe_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_COMPARE0 0x8c00006c
+#define DLB2_NALB_PIPE_SMON_COMPARE0_RST 0x0
+union dlb2_nalb_pipe_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_COMPARE1 0x8c000070
+#define DLB2_NALB_PIPE_SMON_COMPARE1_RST 0x0
+union dlb2_nalb_pipe_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_CFG0 0x8c000074
+#define DLB2_NALB_PIPE_SMON_CFG0_RST 0x40000000
+union dlb2_nalb_pipe_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_CFG1 0x8c000078
+#define DLB2_NALB_PIPE_SMON_CFG1_RST 0x0
+union dlb2_nalb_pipe_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_MAX_TMR 0x8c00007c
+#define DLB2_NALB_PIPE_SMON_MAX_TMR_RST 0x0
+union dlb2_nalb_pipe_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_NALB_PIPE_SMON_TMR 0x8c000080
+#define DLB2_NALB_PIPE_SMON_TMR_RST 0x0
+union dlb2_nalb_pipe_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_GRP_0_SLT_SHFT(x) \
+	(0x96000000 + (x) * 0x4)
+#define DLB2_RO_PIPE_GRP_0_SLT_SHFT_RST 0x0
+union dlb2_ro_pipe_grp_0_slt_shft {
+	struct {
+		u32 change : 10;
+		u32 rsvd0 : 22;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_GRP_1_SLT_SHFT(x) \
+	(0x96010000 + (x) * 0x4)
+#define DLB2_RO_PIPE_GRP_1_SLT_SHFT_RST 0x0
+union dlb2_ro_pipe_grp_1_slt_shft {
+	struct {
+		u32 change : 10;
+		u32 rsvd0 : 22;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_GRP_SN_MODE 0x94000000
+#define DLB2_RO_PIPE_GRP_SN_MODE_RST 0x0
+union dlb2_ro_pipe_grp_sn_mode {
+	struct {
+		u32 sn_mode_0 : 3;
+		u32 rszv0 : 5;
+		u32 sn_mode_1 : 3;
+		u32 rszv1 : 21;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_CFG_CTRL_GENERAL_0 0x9c000000
+#define DLB2_RO_PIPE_CFG_CTRL_GENERAL_0_RST 0x0
+union dlb2_ro_pipe_cfg_ctrl_general_0 {
+	struct {
+		u32 unit_single_step_mode : 1;
+		u32 rr_en : 1;
+		u32 rszv0 : 30;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_ACTIVITYCNTR0 0x9c000030
+#define DLB2_RO_PIPE_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_ro_pipe_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_ACTIVITYCNTR1 0x9c000034
+#define DLB2_RO_PIPE_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_ro_pipe_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_COMPARE0 0x9c000038
+#define DLB2_RO_PIPE_SMON_COMPARE0_RST 0x0
+union dlb2_ro_pipe_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_COMPARE1 0x9c00003c
+#define DLB2_RO_PIPE_SMON_COMPARE1_RST 0x0
+union dlb2_ro_pipe_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_CFG0 0x9c000040
+#define DLB2_RO_PIPE_SMON_CFG0_RST 0x40000000
+union dlb2_ro_pipe_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_CFG1 0x9c000044
+#define DLB2_RO_PIPE_SMON_CFG1_RST 0x0
+union dlb2_ro_pipe_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_MAX_TMR 0x9c000048
+#define DLB2_RO_PIPE_SMON_MAX_TMR_RST 0x0
+union dlb2_ro_pipe_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_RO_PIPE_SMON_TMR 0x9c00004c
+#define DLB2_RO_PIPE_SMON_TMR_RST 0x0
+union dlb2_ro_pipe_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ2PRIOV(x) \
+	(0xa0000000 + (x) * 0x1000)
+#define DLB2_LSP_CQ2PRIOV_RST 0x0
+union dlb2_lsp_cq2priov {
+	struct {
+		u32 prio : 24;
+		u32 v : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ2QID0(x) \
+	(0xa0080000 + (x) * 0x1000)
+#define DLB2_LSP_CQ2QID0_RST 0x0
+union dlb2_lsp_cq2qid0 {
+	struct {
+		u32 qid_p0 : 7;
+		u32 rsvd3 : 1;
+		u32 qid_p1 : 7;
+		u32 rsvd2 : 1;
+		u32 qid_p2 : 7;
+		u32 rsvd1 : 1;
+		u32 qid_p3 : 7;
+		u32 rsvd0 : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ2QID1(x) \
+	(0xa0100000 + (x) * 0x1000)
+#define DLB2_LSP_CQ2QID1_RST 0x0
+union dlb2_lsp_cq2qid1 {
+	struct {
+		u32 qid_p4 : 7;
+		u32 rsvd3 : 1;
+		u32 qid_p5 : 7;
+		u32 rsvd2 : 1;
+		u32 qid_p6 : 7;
+		u32 rsvd1 : 1;
+		u32 qid_p7 : 7;
+		u32 rsvd0 : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_DIR_DSBL(x) \
+	(0xa0180000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_DIR_DSBL_RST 0x1
+union dlb2_lsp_cq_dir_dsbl {
+	struct {
+		u32 disabled : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_DIR_TKN_CNT(x) \
+	(0xa0200000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_DIR_TKN_CNT_RST 0x0
+union dlb2_lsp_cq_dir_tkn_cnt {
+	struct {
+		u32 count : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_DIR_TKN_DEPTH_SEL_DSI(x) \
+	(0xa0280000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_DIR_TKN_DEPTH_SEL_DSI_RST 0x0
+union dlb2_lsp_cq_dir_tkn_depth_sel_dsi {
+	struct {
+		u32 token_depth_select : 4;
+		u32 disable_wb_opt : 1;
+		u32 ignore_depth : 1;
+		u32 rsvd0 : 26;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_DIR_TOT_SCH_CNTL(x) \
+	(0xa0300000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_DIR_TOT_SCH_CNTL_RST 0x0
+union dlb2_lsp_cq_dir_tot_sch_cntl {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_DIR_TOT_SCH_CNTH(x) \
+	(0xa0380000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_DIR_TOT_SCH_CNTH_RST 0x0
+union dlb2_lsp_cq_dir_tot_sch_cnth {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_LDB_DSBL(x) \
+	(0xa0400000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_DSBL_RST 0x1
+union dlb2_lsp_cq_ldb_dsbl {
+	struct {
+		u32 disabled : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_LDB_INFL_CNT(x) \
+	(0xa0480000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_INFL_CNT_RST 0x0
+union dlb2_lsp_cq_ldb_infl_cnt {
+	struct {
+		u32 count : 12;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_LDB_INFL_LIM(x) \
+	(0xa0500000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_INFL_LIM_RST 0x0
+union dlb2_lsp_cq_ldb_infl_lim {
+	struct {
+		u32 limit : 12;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_LDB_TKN_CNT(x) \
+	(0xa0580000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_TKN_CNT_RST 0x0
+union dlb2_lsp_cq_ldb_tkn_cnt {
+	struct {
+		u32 token_count : 11;
+		u32 rsvd0 : 21;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_LDB_TKN_DEPTH_SEL(x) \
+	(0xa0600000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_TKN_DEPTH_SEL_RST 0x0
+union dlb2_lsp_cq_ldb_tkn_depth_sel {
+	struct {
+		u32 token_depth_select : 4;
+		u32 ignore_depth : 1;
+		u32 rsvd0 : 27;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_LDB_TOT_SCH_CNTL(x) \
+	(0xa0680000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_TOT_SCH_CNTL_RST 0x0
+union dlb2_lsp_cq_ldb_tot_sch_cntl {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CQ_LDB_TOT_SCH_CNTH(x) \
+	(0xa0700000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_TOT_SCH_CNTH_RST 0x0
+union dlb2_lsp_cq_ldb_tot_sch_cnth {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_DIR_MAX_DEPTH(x) \
+	(0xa0780000 + (x) * 0x1000)
+#define DLB2_LSP_QID_DIR_MAX_DEPTH_RST 0x0
+union dlb2_lsp_qid_dir_max_depth {
+	struct {
+		u32 depth : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_DIR_TOT_ENQ_CNTL(x) \
+	(0xa0800000 + (x) * 0x1000)
+#define DLB2_LSP_QID_DIR_TOT_ENQ_CNTL_RST 0x0
+union dlb2_lsp_qid_dir_tot_enq_cntl {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_DIR_TOT_ENQ_CNTH(x) \
+	(0xa0880000 + (x) * 0x1000)
+#define DLB2_LSP_QID_DIR_TOT_ENQ_CNTH_RST 0x0
+union dlb2_lsp_qid_dir_tot_enq_cnth {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_DIR_ENQUEUE_CNT(x) \
+	(0xa0900000 + (x) * 0x1000)
+#define DLB2_LSP_QID_DIR_ENQUEUE_CNT_RST 0x0
+union dlb2_lsp_qid_dir_enqueue_cnt {
+	struct {
+		u32 count : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_DIR_DEPTH_THRSH(x) \
+	(0xa0980000 + (x) * 0x1000)
+#define DLB2_LSP_QID_DIR_DEPTH_THRSH_RST 0x0
+union dlb2_lsp_qid_dir_depth_thrsh {
+	struct {
+		u32 thresh : 13;
+		u32 rsvd0 : 19;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_AQED_ACTIVE_CNT(x) \
+	(0xa0a00000 + (x) * 0x1000)
+#define DLB2_LSP_QID_AQED_ACTIVE_CNT_RST 0x0
+union dlb2_lsp_qid_aqed_active_cnt {
+	struct {
+		u32 count : 12;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_AQED_ACTIVE_LIM(x) \
+	(0xa0a80000 + (x) * 0x1000)
+#define DLB2_LSP_QID_AQED_ACTIVE_LIM_RST 0x0
+union dlb2_lsp_qid_aqed_active_lim {
+	struct {
+		u32 limit : 12;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_ATM_TOT_ENQ_CNTL(x) \
+	(0xa0b00000 + (x) * 0x1000)
+#define DLB2_LSP_QID_ATM_TOT_ENQ_CNTL_RST 0x0
+union dlb2_lsp_qid_atm_tot_enq_cntl {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_ATM_TOT_ENQ_CNTH(x) \
+	(0xa0b80000 + (x) * 0x1000)
+#define DLB2_LSP_QID_ATM_TOT_ENQ_CNTH_RST 0x0
+union dlb2_lsp_qid_atm_tot_enq_cnth {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_ATQ_ENQUEUE_CNT(x) \
+	(0xa0c00000 + (x) * 0x1000)
+#define DLB2_LSP_QID_ATQ_ENQUEUE_CNT_RST 0x0
+union dlb2_lsp_qid_atq_enqueue_cnt {
+	struct {
+		u32 count : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_LDB_ENQUEUE_CNT(x) \
+	(0xa0c80000 + (x) * 0x1000)
+#define DLB2_LSP_QID_LDB_ENQUEUE_CNT_RST 0x0
+union dlb2_lsp_qid_ldb_enqueue_cnt {
+	struct {
+		u32 count : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_LDB_INFL_CNT(x) \
+	(0xa0d00000 + (x) * 0x1000)
+#define DLB2_LSP_QID_LDB_INFL_CNT_RST 0x0
+union dlb2_lsp_qid_ldb_infl_cnt {
+	struct {
+		u32 count : 12;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_LDB_INFL_LIM(x) \
+	(0xa0d80000 + (x) * 0x1000)
+#define DLB2_LSP_QID_LDB_INFL_LIM_RST 0x0
+union dlb2_lsp_qid_ldb_infl_lim {
+	struct {
+		u32 limit : 12;
+		u32 rsvd0 : 20;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID2CQIDIX_00(x) \
+	(0xa0e00000 + (x) * 0x1000)
+#define DLB2_LSP_QID2CQIDIX_00_RST 0x0
+#define DLB2_LSP_QID2CQIDIX(x, y) \
+	(DLB2_LSP_QID2CQIDIX_00(x) + 0x80000 * (y))
+#define DLB2_LSP_QID2CQIDIX_NUM 16
+union dlb2_lsp_qid2cqidix_00 {
+	struct {
+		u32 cq_p0 : 8;
+		u32 cq_p1 : 8;
+		u32 cq_p2 : 8;
+		u32 cq_p3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID2CQIDIX2_00(x) \
+	(0xa1600000 + (x) * 0x1000)
+#define DLB2_LSP_QID2CQIDIX2_00_RST 0x0
+#define DLB2_LSP_QID2CQIDIX2(x, y) \
+	(DLB2_LSP_QID2CQIDIX2_00(x) + 0x80000 * (y))
+#define DLB2_LSP_QID2CQIDIX2_NUM 16
+union dlb2_lsp_qid2cqidix2_00 {
+	struct {
+		u32 cq_p0 : 8;
+		u32 cq_p1 : 8;
+		u32 cq_p2 : 8;
+		u32 cq_p3 : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_LDB_REPLAY_CNT(x) \
+	(0xa1e00000 + (x) * 0x1000)
+#define DLB2_LSP_QID_LDB_REPLAY_CNT_RST 0x0
+union dlb2_lsp_qid_ldb_replay_cnt {
+	struct {
+		u32 count : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_NALDB_MAX_DEPTH(x) \
+	(0xa1f00000 + (x) * 0x1000)
+#define DLB2_LSP_QID_NALDB_MAX_DEPTH_RST 0x0
+union dlb2_lsp_qid_naldb_max_depth {
+	struct {
+		u32 depth : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_NALDB_TOT_ENQ_CNTL(x) \
+	(0xa1f80000 + (x) * 0x1000)
+#define DLB2_LSP_QID_NALDB_TOT_ENQ_CNTL_RST 0x0
+union dlb2_lsp_qid_naldb_tot_enq_cntl {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_NALDB_TOT_ENQ_CNTH(x) \
+	(0xa2000000 + (x) * 0x1000)
+#define DLB2_LSP_QID_NALDB_TOT_ENQ_CNTH_RST 0x0
+union dlb2_lsp_qid_naldb_tot_enq_cnth {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_ATM_DEPTH_THRSH(x) \
+	(0xa2080000 + (x) * 0x1000)
+#define DLB2_LSP_QID_ATM_DEPTH_THRSH_RST 0x0
+union dlb2_lsp_qid_atm_depth_thrsh {
+	struct {
+		u32 thresh : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_NALDB_DEPTH_THRSH(x) \
+	(0xa2100000 + (x) * 0x1000)
+#define DLB2_LSP_QID_NALDB_DEPTH_THRSH_RST 0x0
+union dlb2_lsp_qid_naldb_depth_thrsh {
+	struct {
+		u32 thresh : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_QID_ATM_ACTIVE(x) \
+	(0xa2180000 + (x) * 0x1000)
+#define DLB2_LSP_QID_ATM_ACTIVE_RST 0x0
+union dlb2_lsp_qid_atm_active {
+	struct {
+		u32 count : 14;
+		u32 rsvd0 : 18;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CFG_ARB_WEIGHT_ATM_NALB_QID_0 0xa4000008
+#define DLB2_LSP_CFG_ARB_WEIGHT_ATM_NALB_QID_0_RST 0x0
+union dlb2_lsp_cfg_arb_weight_atm_nalb_qid_0 {
+	struct {
+		u32 pri0_weight : 8;
+		u32 pri1_weight : 8;
+		u32 pri2_weight : 8;
+		u32 pri3_weight : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CFG_ARB_WEIGHT_ATM_NALB_QID_1 0xa400000c
+#define DLB2_LSP_CFG_ARB_WEIGHT_ATM_NALB_QID_1_RST 0x0
+union dlb2_lsp_cfg_arb_weight_atm_nalb_qid_1 {
+	struct {
+		u32 rsvz0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CFG_ARB_WEIGHT_LDB_QID_0 0xa4000014
+#define DLB2_LSP_CFG_ARB_WEIGHT_LDB_QID_0_RST 0x0
+union dlb2_lsp_cfg_arb_weight_ldb_qid_0 {
+	struct {
+		u32 pri0_weight : 8;
+		u32 pri1_weight : 8;
+		u32 pri2_weight : 8;
+		u32 pri3_weight : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CFG_ARB_WEIGHT_LDB_QID_1 0xa4000018
+#define DLB2_LSP_CFG_ARB_WEIGHT_LDB_QID_1_RST 0x0
+union dlb2_lsp_cfg_arb_weight_ldb_qid_1 {
+	struct {
+		u32 rsvz0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_LDB_SCHED_CTRL 0xa400002c
+#define DLB2_LSP_LDB_SCHED_CTRL_RST 0x0
+union dlb2_lsp_ldb_sched_ctrl {
+	struct {
+		u32 cq : 8;
+		u32 qidix : 3;
+		u32 value : 1;
+		u32 nalb_haswork_v : 1;
+		u32 rlist_haswork_v : 1;
+		u32 slist_haswork_v : 1;
+		u32 inflight_ok_v : 1;
+		u32 aqed_nfull_v : 1;
+		u32 rsvz0 : 15;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_DIR_SCH_CNT_L 0xa4000034
+#define DLB2_LSP_DIR_SCH_CNT_L_RST 0x0
+union dlb2_lsp_dir_sch_cnt_l {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_DIR_SCH_CNT_H 0xa4000038
+#define DLB2_LSP_DIR_SCH_CNT_H_RST 0x0
+union dlb2_lsp_dir_sch_cnt_h {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_LDB_SCH_CNT_L 0xa400003c
+#define DLB2_LSP_LDB_SCH_CNT_L_RST 0x0
+union dlb2_lsp_ldb_sch_cnt_l {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_LDB_SCH_CNT_H 0xa4000040
+#define DLB2_LSP_LDB_SCH_CNT_H_RST 0x0
+union dlb2_lsp_ldb_sch_cnt_h {
+	struct {
+		u32 count : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CFG_SHDW_CTRL 0xa4000070
+#define DLB2_LSP_CFG_SHDW_CTRL_RST 0x0
+union dlb2_lsp_cfg_shdw_ctrl {
+	struct {
+		u32 transfer : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CFG_SHDW_RANGE_COS(x) \
+	(0xa4000074 + (x) * 4)
+#define DLB2_LSP_CFG_SHDW_RANGE_COS_RST 0x40
+union dlb2_lsp_cfg_shdw_range_cos {
+	struct {
+		u32 bw_range : 9;
+		u32 rsvz0 : 22;
+		u32 no_extra_credit : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_CFG_CTRL_GENERAL_0 0xac000000
+#define DLB2_LSP_CFG_CTRL_GENERAL_0_RST 0x0
+union dlb2_lsp_cfg_ctrl_general_0 {
+	struct {
+		u32 disab_atq_empty_arb : 1;
+		u32 inc_tok_unit_idle : 1;
+		u32 disab_rlist_pri : 1;
+		u32 inc_cmp_unit_idle : 1;
+		u32 rsvz0 : 2;
+		u32 dir_single_op : 1;
+		u32 dir_half_bw : 1;
+		u32 dir_single_out : 1;
+		u32 dir_disab_multi : 1;
+		u32 atq_single_op : 1;
+		u32 atq_half_bw : 1;
+		u32 atq_single_out : 1;
+		u32 atq_disab_multi : 1;
+		u32 dirrpl_single_op : 1;
+		u32 dirrpl_half_bw : 1;
+		u32 dirrpl_single_out : 1;
+		u32 lbrpl_single_op : 1;
+		u32 lbrpl_half_bw : 1;
+		u32 lbrpl_single_out : 1;
+		u32 ldb_single_op : 1;
+		u32 ldb_half_bw : 1;
+		u32 ldb_disab_multi : 1;
+		u32 atm_single_sch : 1;
+		u32 atm_single_cmp : 1;
+		u32 ldb_ce_tog_arb : 1;
+		u32 rsvz1 : 1;
+		u32 smon0_valid_sel : 2;
+		u32 smon0_value_sel : 1;
+		u32 smon0_compare_sel : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_COMPARE0 0xac000048
+#define DLB2_LSP_SMON_COMPARE0_RST 0x0
+union dlb2_lsp_smon_compare0 {
+	struct {
+		u32 compare0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_COMPARE1 0xac00004c
+#define DLB2_LSP_SMON_COMPARE1_RST 0x0
+union dlb2_lsp_smon_compare1 {
+	struct {
+		u32 compare1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_CFG0 0xac000050
+#define DLB2_LSP_SMON_CFG0_RST 0x40000000
+union dlb2_lsp_smon_cfg0 {
+	struct {
+		u32 smon_enable : 1;
+		u32 smon_0trigger_enable : 1;
+		u32 rsvz0 : 2;
+		u32 smon0_function : 3;
+		u32 smon0_function_compare : 1;
+		u32 smon1_function : 3;
+		u32 smon1_function_compare : 1;
+		u32 smon_mode : 4;
+		u32 stopcounterovfl : 1;
+		u32 intcounterovfl : 1;
+		u32 statcounter0ovfl : 1;
+		u32 statcounter1ovfl : 1;
+		u32 stoptimerovfl : 1;
+		u32 inttimerovfl : 1;
+		u32 stattimerovfl : 1;
+		u32 rsvz1 : 1;
+		u32 timer_prescale : 5;
+		u32 rsvz2 : 1;
+		u32 version : 2;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_CFG1 0xac000054
+#define DLB2_LSP_SMON_CFG1_RST 0x0
+union dlb2_lsp_smon_cfg1 {
+	struct {
+		u32 mode0 : 8;
+		u32 mode1 : 8;
+		u32 rsvz0 : 16;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_ACTIVITYCNTR0 0xac000058
+#define DLB2_LSP_SMON_ACTIVITYCNTR0_RST 0x0
+union dlb2_lsp_smon_activitycntr0 {
+	struct {
+		u32 counter0 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_ACTIVITYCNTR1 0xac00005c
+#define DLB2_LSP_SMON_ACTIVITYCNTR1_RST 0x0
+union dlb2_lsp_smon_activitycntr1 {
+	struct {
+		u32 counter1 : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_MAX_TMR 0xac000060
+#define DLB2_LSP_SMON_MAX_TMR_RST 0x0
+union dlb2_lsp_smon_max_tmr {
+	struct {
+		u32 maxvalue : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_LSP_SMON_TMR 0xac000064
+#define DLB2_LSP_SMON_TMR_RST 0x0
+union dlb2_lsp_smon_tmr {
+	struct {
+		u32 timer : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CFG_MSTR_DIAG_RESET_STS 0xb4000000
+#define DLB2_CFG_MSTR_DIAG_RESET_STS_RST 0x80000bff
+union dlb2_cfg_mstr_diag_reset_sts {
+	struct {
+		u32 chp_pf_reset_done : 1;
+		u32 rop_pf_reset_done : 1;
+		u32 lsp_pf_reset_done : 1;
+		u32 nalb_pf_reset_done : 1;
+		u32 ap_pf_reset_done : 1;
+		u32 dp_pf_reset_done : 1;
+		u32 qed_pf_reset_done : 1;
+		u32 dqed_pf_reset_done : 1;
+		u32 aqed_pf_reset_done : 1;
+		u32 sys_pf_reset_done : 1;
+		u32 pf_reset_active : 1;
+		u32 flrsm_state : 7;
+		u32 rsvd0 : 13;
+		u32 dlb_proc_reset_done : 1;
+	} field;
+	u32 val;
+};
+
 #define DLB2_CFG_MSTR_CFG_DIAGNOSTIC_IDLE_STATUS 0xb4000004
 #define DLB2_CFG_MSTR_CFG_DIAGNOSTIC_IDLE_STATUS_RST 0x9d0fffff
 union dlb2_cfg_mstr_cfg_diagnostic_idle_status {
@@ -80,4 +3628,75 @@ union dlb2_cfg_mstr_cfg_pm_pmcsr_disable {
 	u32 val;
 };
 
+#define DLB2_FUNC_VF_VF2PF_MAILBOX_BYTES 256
+#define DLB2_FUNC_VF_VF2PF_MAILBOX(x) \
+	(0x1000 + (x) * 0x4)
+#define DLB2_FUNC_VF_VF2PF_MAILBOX_RST 0x0
+union dlb2_func_vf_vf2pf_mailbox {
+	struct {
+		u32 msg : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_VF_VF2PF_MAILBOX_ISR 0x1f00
+#define DLB2_FUNC_VF_VF2PF_MAILBOX_ISR_RST 0x0
+#define DLB2_FUNC_VF_SIOV_VF2PF_MAILBOX_ISR_TRIGGER 0x8000
+union dlb2_func_vf_vf2pf_mailbox_isr {
+	struct {
+		u32 isr : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_VF_PF2VF_MAILBOX_BYTES 64
+#define DLB2_FUNC_VF_PF2VF_MAILBOX(x) \
+	(0x2000 + (x) * 0x4)
+#define DLB2_FUNC_VF_PF2VF_MAILBOX_RST 0x0
+union dlb2_func_vf_pf2vf_mailbox {
+	struct {
+		u32 msg : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_VF_PF2VF_MAILBOX_ISR 0x2f00
+#define DLB2_FUNC_VF_PF2VF_MAILBOX_ISR_RST 0x0
+union dlb2_func_vf_pf2vf_mailbox_isr {
+	struct {
+		u32 pf_isr : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_VF_VF_MSI_ISR_PEND 0x2f10
+#define DLB2_FUNC_VF_VF_MSI_ISR_PEND_RST 0x0
+union dlb2_func_vf_vf_msi_isr_pend {
+	struct {
+		u32 isr_pend : 32;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_VF_VF_RESET_IN_PROGRESS 0x3000
+#define DLB2_FUNC_VF_VF_RESET_IN_PROGRESS_RST 0x1
+union dlb2_func_vf_vf_reset_in_progress {
+	struct {
+		u32 reset_in_progress : 1;
+		u32 rsvd0 : 31;
+	} field;
+	u32 val;
+};
+
+#define DLB2_FUNC_VF_VF_MSI_ISR 0x4000
+#define DLB2_FUNC_VF_VF_MSI_ISR_RST 0x0
+union dlb2_func_vf_vf_msi_isr {
+	struct {
+		u32 vf_msi_isr : 32;
+	} field;
+	u32 val;
+};
+
 #endif /* __DLB2_REGS_H */
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 3b36bfef1e9b..2cc744cea2d5 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -1,11 +1,40 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2016-2020 Intel Corporation */
 
+#include <linux/frame.h>
+
 #include "dlb2_bitmap.h"
 #include "dlb2_hw_types.h"
+#include "dlb2_main.h"
 #include "dlb2_regs.h"
 #include "dlb2_resource.h"
 
+#define DLB2_DOM_LIST_HEAD(head, type) \
+	list_first_entry_or_null(&(head), type, domain_list)
+
+#define DLB2_FUNC_LIST_HEAD(head, type) \
+	list_first_entry_or_null(&(head), type, func_list)
+
+#define DLB2_DOM_LIST_FOR(head, ptr) \
+	list_for_each_entry(ptr, &(head), domain_list)
+
+#define DLB2_FUNC_LIST_FOR(head, ptr) \
+	list_for_each_entry(ptr, &(head), func_list)
+
+#define DLB2_DOM_LIST_FOR_SAFE(head, ptr, ptr_tmp) \
+	list_for_each_entry_safe(ptr, ptr_tmp, &(head), domain_list)
+
+/*
+ * The PF driver cannot assume that a register write will affect subsequent HCW
+ * writes. To ensure a write completes, the driver must read back a CSR. This
+ * function only need be called for configuration that can occur after the
+ * domain has started; prior to starting, applications can't send HCWs.
+ */
+static inline void dlb2_flush_csr(struct dlb2_hw *hw)
+{
+	DLB2_CSR_RD(hw, DLB2_SYS_TOTAL_VAS);
+}
+
 static void dlb2_init_fn_rsrc_lists(struct dlb2_function_resources *rsrc)
 {
 	int i;
@@ -185,6 +214,3109 @@ int dlb2_resource_init(struct dlb2_hw *hw)
 	return ret;
 }
 
+static struct dlb2_hw_domain *dlb2_get_domain_from_id(struct dlb2_hw *hw,
+						      u32 id,
+						      bool vdev_req,
+						      unsigned int vdev_id)
+{
+	struct dlb2_function_resources *rsrcs;
+	struct dlb2_hw_domain *domain;
+
+	if (id >= DLB2_MAX_NUM_DOMAINS)
+		return NULL;
+
+	if (!vdev_req)
+		return &hw->domains[id];
+
+	rsrcs = &hw->vdev[vdev_id];
+
+	DLB2_FUNC_LIST_FOR(rsrcs->used_domains, domain)
+		if (domain->id.virt_id == id)
+			return domain;
+
+	return NULL;
+}
+
+static struct dlb2_ldb_queue *
+dlb2_get_ldb_queue_from_id(struct dlb2_hw *hw,
+			   u32 id,
+			   bool vdev_req,
+			   unsigned int vdev_id)
+{
+	struct dlb2_function_resources *rsrcs;
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_queue *queue;
+
+	if (id >= DLB2_MAX_NUM_LDB_QUEUES)
+		return NULL;
+
+	rsrcs = (vdev_req) ? &hw->vdev[vdev_id] : &hw->pf;
+
+	if (!vdev_req)
+		return &hw->rsrcs.ldb_queues[id];
+
+	DLB2_FUNC_LIST_FOR(rsrcs->used_domains, domain) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_queues, queue)
+			if (queue->id.virt_id == id)
+				return queue;
+	}
+
+	DLB2_FUNC_LIST_FOR(rsrcs->avail_ldb_queues, queue)
+		if (queue->id.virt_id == id)
+			return queue;
+
+	return NULL;
+}
+
+static int dlb2_attach_ldb_queues(struct dlb2_hw *hw,
+				  struct dlb2_function_resources *rsrcs,
+				  struct dlb2_hw_domain *domain,
+				  u32 num_queues,
+				  struct dlb2_cmd_response *resp)
+{
+	unsigned int i;
+
+	if (rsrcs->num_avail_ldb_queues < num_queues) {
+		resp->status = DLB2_ST_LDB_QUEUES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_queues; i++) {
+		struct dlb2_ldb_queue *queue;
+
+		queue = DLB2_FUNC_LIST_HEAD(rsrcs->avail_ldb_queues,
+					    typeof(*queue));
+		if (!queue) {
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: domain validation failed\n",
+				    __func__);
+			return -EFAULT;
+		}
+
+		list_del(&queue->func_list);
+
+		queue->domain_id = domain->id;
+		queue->owned = true;
+
+		list_add(&queue->domain_list, &domain->avail_ldb_queues);
+	}
+
+	rsrcs->num_avail_ldb_queues -= num_queues;
+
+	return 0;
+}
+
+static struct dlb2_ldb_port *
+dlb2_get_next_ldb_port(struct dlb2_hw *hw,
+		       struct dlb2_function_resources *rsrcs,
+		       u32 domain_id,
+		       u32 cos_id)
+{
+	struct dlb2_ldb_port *port;
+
+	/*
+	 * To reduce the odds of consecutive load-balanced ports mapping to the
+	 * same queue(s), the driver attempts to allocate ports whose neighbors
+	 * are owned by a different domain.
+	 */
+	DLB2_FUNC_LIST_FOR(rsrcs->avail_ldb_ports[cos_id], port) {
+		u32 next, prev;
+		u32 phys_id;
+
+		phys_id = port->id.phys_id;
+		next = phys_id + 1;
+		prev = phys_id - 1;
+
+		if (phys_id == DLB2_MAX_NUM_LDB_PORTS - 1)
+			next = 0;
+		if (phys_id == 0)
+			prev = DLB2_MAX_NUM_LDB_PORTS - 1;
+
+		if (!hw->rsrcs.ldb_ports[next].owned ||
+		    hw->rsrcs.ldb_ports[next].domain_id.phys_id == domain_id)
+			continue;
+
+		if (!hw->rsrcs.ldb_ports[prev].owned ||
+		    hw->rsrcs.ldb_ports[prev].domain_id.phys_id == domain_id)
+			continue;
+
+		return port;
+	}
+
+	/*
+	 * Failing that, the driver looks for a port with one neighbor owned by
+	 * a different domain and the other unallocated.
+	 */
+	DLB2_FUNC_LIST_FOR(rsrcs->avail_ldb_ports[cos_id], port) {
+		u32 next, prev;
+		u32 phys_id;
+
+		phys_id = port->id.phys_id;
+		next = phys_id + 1;
+		prev = phys_id - 1;
+
+		if (phys_id == DLB2_MAX_NUM_LDB_PORTS - 1)
+			next = 0;
+		if (phys_id == 0)
+			prev = DLB2_MAX_NUM_LDB_PORTS - 1;
+
+		if (!hw->rsrcs.ldb_ports[prev].owned &&
+		    hw->rsrcs.ldb_ports[next].owned &&
+		    hw->rsrcs.ldb_ports[next].domain_id.phys_id != domain_id)
+			return port;
+
+		if (!hw->rsrcs.ldb_ports[next].owned &&
+		    hw->rsrcs.ldb_ports[prev].owned &&
+		    hw->rsrcs.ldb_ports[prev].domain_id.phys_id != domain_id)
+			return port;
+	}
+
+	/*
+	 * Failing that, the driver looks for a port with both neighbors
+	 * unallocated.
+	 */
+	DLB2_FUNC_LIST_FOR(rsrcs->avail_ldb_ports[cos_id], port) {
+		u32 next, prev;
+		u32 phys_id;
+
+		phys_id = port->id.phys_id;
+		next = phys_id + 1;
+		prev = phys_id - 1;
+
+		if (phys_id == DLB2_MAX_NUM_LDB_PORTS - 1)
+			next = 0;
+		if (phys_id == 0)
+			prev = DLB2_MAX_NUM_LDB_PORTS - 1;
+
+		if (!hw->rsrcs.ldb_ports[prev].owned &&
+		    !hw->rsrcs.ldb_ports[next].owned)
+			return port;
+	}
+
+	/* If all else fails, the driver returns the next available port. */
+	return DLB2_FUNC_LIST_HEAD(rsrcs->avail_ldb_ports[cos_id],
+				   typeof(*port));
+}
+
+static int __dlb2_attach_ldb_ports(struct dlb2_hw *hw,
+				   struct dlb2_function_resources *rsrcs,
+				   struct dlb2_hw_domain *domain,
+				   u32 num_ports,
+				   u32 cos_id,
+				   struct dlb2_cmd_response *resp)
+{
+	unsigned int i;
+
+	if (rsrcs->num_avail_ldb_ports[cos_id] < num_ports) {
+		resp->status = DLB2_ST_LDB_PORTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_ports; i++) {
+		struct dlb2_ldb_port *port;
+
+		port = dlb2_get_next_ldb_port(hw, rsrcs,
+					      domain->id.phys_id, cos_id);
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: domain validation failed\n",
+				    __func__);
+			return -EFAULT;
+		}
+
+		list_del(&port->func_list);
+
+		port->domain_id = domain->id;
+		port->owned = true;
+
+		list_add(&port->domain_list,
+			 &domain->avail_ldb_ports[cos_id]);
+	}
+
+	rsrcs->num_avail_ldb_ports[cos_id] -= num_ports;
+
+	return 0;
+}
+
+static int dlb2_attach_ldb_ports(struct dlb2_hw *hw,
+				 struct dlb2_function_resources *rsrcs,
+				 struct dlb2_hw_domain *domain,
+				 struct dlb2_create_sched_domain_args *args,
+				 struct dlb2_cmd_response *resp)
+{
+	unsigned int i;
+	int ret, j;
+
+	if (args->cos_strict) {
+		for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+			u32 num = args->num_cos_ldb_ports[i];
+
+			/* Allocate ports from specific classes-of-service */
+			ret = __dlb2_attach_ldb_ports(hw,
+						      rsrcs,
+						      domain,
+						      num,
+						      i,
+						      resp);
+			if (ret)
+				return ret;
+		}
+	} else {
+		unsigned int k;
+		u32 cos_id;
+
+		/*
+		 * Attempt to allocate from specific class-of-service, but
+		 * fallback to the other classes if that fails.
+		 */
+		for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+			for (j = 0; j < args->num_cos_ldb_ports[i]; j++) {
+				for (k = 0; k < DLB2_NUM_COS_DOMAINS; k++) {
+					cos_id = (i + k) % DLB2_NUM_COS_DOMAINS;
+
+					ret = __dlb2_attach_ldb_ports(hw,
+								      rsrcs,
+								      domain,
+								      1,
+								      cos_id,
+								      resp);
+					if (ret == 0)
+						break;
+				}
+
+				if (ret < 0)
+					return ret;
+			}
+		}
+	}
+
+	/* Allocate num_ldb_ports from any class-of-service */
+	for (i = 0; i < args->num_ldb_ports; i++) {
+		for (j = 0; j < DLB2_NUM_COS_DOMAINS; j++) {
+			ret = __dlb2_attach_ldb_ports(hw,
+						      rsrcs,
+						      domain,
+						      1,
+						      j,
+						      resp);
+			if (ret == 0)
+				break;
+		}
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int dlb2_attach_dir_ports(struct dlb2_hw *hw,
+				 struct dlb2_function_resources *rsrcs,
+				 struct dlb2_hw_domain *domain,
+				 u32 num_ports,
+				 struct dlb2_cmd_response *resp)
+{
+	unsigned int i;
+
+	if (rsrcs->num_avail_dir_pq_pairs < num_ports) {
+		resp->status = DLB2_ST_DIR_PORTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_ports; i++) {
+		struct dlb2_dir_pq_pair *port;
+
+		port = DLB2_FUNC_LIST_HEAD(rsrcs->avail_dir_pq_pairs,
+					   typeof(*port));
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: domain validation failed\n",
+				    __func__);
+			return -EFAULT;
+		}
+
+		list_del(&port->func_list);
+
+		port->domain_id = domain->id;
+		port->owned = true;
+
+		list_add(&port->domain_list, &domain->avail_dir_pq_pairs);
+	}
+
+	rsrcs->num_avail_dir_pq_pairs -= num_ports;
+
+	return 0;
+}
+
+static int dlb2_attach_ldb_credits(struct dlb2_function_resources *rsrcs,
+				   struct dlb2_hw_domain *domain,
+				   u32 num_credits,
+				   struct dlb2_cmd_response *resp)
+{
+	if (rsrcs->num_avail_qed_entries < num_credits) {
+		resp->status = DLB2_ST_LDB_CREDITS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	rsrcs->num_avail_qed_entries -= num_credits;
+	domain->num_ldb_credits += num_credits;
+	return 0;
+}
+
+static int dlb2_attach_dir_credits(struct dlb2_function_resources *rsrcs,
+				   struct dlb2_hw_domain *domain,
+				   u32 num_credits,
+				   struct dlb2_cmd_response *resp)
+{
+	if (rsrcs->num_avail_dqed_entries < num_credits) {
+		resp->status = DLB2_ST_DIR_CREDITS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	rsrcs->num_avail_dqed_entries -= num_credits;
+	domain->num_dir_credits += num_credits;
+	return 0;
+}
+
+static int dlb2_attach_atomic_inflights(struct dlb2_function_resources *rsrcs,
+					struct dlb2_hw_domain *domain,
+					u32 num_atomic_inflights,
+					struct dlb2_cmd_response *resp)
+{
+	if (rsrcs->num_avail_aqed_entries < num_atomic_inflights) {
+		resp->status = DLB2_ST_ATOMIC_INFLIGHTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	rsrcs->num_avail_aqed_entries -= num_atomic_inflights;
+	domain->num_avail_aqed_entries += num_atomic_inflights;
+	return 0;
+}
+
+static int
+dlb2_attach_domain_hist_list_entries(struct dlb2_function_resources *rsrcs,
+				     struct dlb2_hw_domain *domain,
+				     u32 num_hist_list_entries,
+				     struct dlb2_cmd_response *resp)
+{
+	struct dlb2_bitmap *bitmap;
+	int base;
+
+	if (num_hist_list_entries) {
+		bitmap = rsrcs->avail_hist_list_entries;
+
+		base = dlb2_bitmap_find_set_bit_range(bitmap,
+						      num_hist_list_entries);
+		if (base < 0)
+			goto error;
+
+		domain->total_hist_list_entries = num_hist_list_entries;
+		domain->avail_hist_list_entries = num_hist_list_entries;
+		domain->hist_list_entry_base = base;
+		domain->hist_list_entry_offset = 0;
+
+		dlb2_bitmap_clear_range(bitmap, base, num_hist_list_entries);
+	}
+	return 0;
+
+error:
+	resp->status = DLB2_ST_HIST_LIST_ENTRIES_UNAVAILABLE;
+	return -EINVAL;
+}
+
+static int
+dlb2_verify_create_sched_dom_args(struct dlb2_function_resources *rsrcs,
+				  struct dlb2_create_sched_domain_args *args,
+				  struct dlb2_cmd_response *resp)
+{
+	u32 num_avail_ldb_ports, req_ldb_ports;
+	struct dlb2_bitmap *avail_hl_entries;
+	unsigned int max_contig_hl_range;
+	int i;
+
+	avail_hl_entries = rsrcs->avail_hist_list_entries;
+
+	max_contig_hl_range = dlb2_bitmap_longest_set_range(avail_hl_entries);
+
+	num_avail_ldb_ports = 0;
+	req_ldb_ports = 0;
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		num_avail_ldb_ports += rsrcs->num_avail_ldb_ports[i];
+
+		req_ldb_ports += args->num_cos_ldb_ports[i];
+	}
+
+	req_ldb_ports += args->num_ldb_ports;
+
+	if (rsrcs->num_avail_domains < 1) {
+		resp->status = DLB2_ST_DOMAIN_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (rsrcs->num_avail_ldb_queues < args->num_ldb_queues) {
+		resp->status = DLB2_ST_LDB_QUEUES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (req_ldb_ports > num_avail_ldb_ports) {
+		resp->status = DLB2_ST_LDB_PORTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	for (i = 0; args->cos_strict && i < DLB2_NUM_COS_DOMAINS; i++) {
+		if (args->num_cos_ldb_ports[i] >
+		    rsrcs->num_avail_ldb_ports[i]) {
+			resp->status = DLB2_ST_LDB_PORTS_UNAVAILABLE;
+			return -EINVAL;
+		}
+	}
+
+	if (args->num_ldb_queues > 0 && req_ldb_ports == 0) {
+		resp->status = DLB2_ST_LDB_PORT_REQUIRED_FOR_LDB_QUEUES;
+		return -EINVAL;
+	}
+
+	if (rsrcs->num_avail_dir_pq_pairs < args->num_dir_ports) {
+		resp->status = DLB2_ST_DIR_PORTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (rsrcs->num_avail_qed_entries < args->num_ldb_credits) {
+		resp->status = DLB2_ST_LDB_CREDITS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (rsrcs->num_avail_dqed_entries < args->num_dir_credits) {
+		resp->status = DLB2_ST_DIR_CREDITS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (rsrcs->num_avail_aqed_entries < args->num_atomic_inflights) {
+		resp->status = DLB2_ST_ATOMIC_INFLIGHTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (max_contig_hl_range < args->num_hist_list_entries) {
+		resp->status = DLB2_ST_HIST_LIST_ENTRIES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (resp->status)
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool dlb2_port_find_slot(struct dlb2_ldb_port *port,
+				enum dlb2_qid_map_state state,
+				int *slot)
+{
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		if (port->qid_map[i].state == state)
+			break;
+	}
+
+	*slot = i;
+
+	return (i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ);
+}
+
+static bool dlb2_port_find_slot_queue(struct dlb2_ldb_port *port,
+				      enum dlb2_qid_map_state state,
+				      struct dlb2_ldb_queue *queue,
+				      int *slot)
+{
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		if (port->qid_map[i].state == state &&
+		    port->qid_map[i].qid == queue->id.phys_id)
+			break;
+	}
+
+	*slot = i;
+
+	return (i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ);
+}
+
+static int dlb2_port_slot_state_transition(struct dlb2_hw *hw,
+					   struct dlb2_ldb_port *port,
+					   struct dlb2_ldb_queue *queue,
+					   int slot,
+					   enum dlb2_qid_map_state new_state)
+{
+	enum dlb2_qid_map_state curr_state = port->qid_map[slot].state;
+	struct dlb2_hw_domain *domain;
+	int domain_id;
+
+	domain_id = port->domain_id.phys_id;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, false, 0);
+	if (!domain) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: unable to find domain %d\n",
+			    __func__, domain_id);
+		return -EINVAL;
+	}
+
+	switch (curr_state) {
+	case DLB2_QUEUE_UNMAPPED:
+		switch (new_state) {
+		case DLB2_QUEUE_MAPPED:
+			queue->num_mappings++;
+			port->num_mappings++;
+			break;
+		case DLB2_QUEUE_MAP_IN_PROG:
+			queue->num_pending_additions++;
+			domain->num_pending_additions++;
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB2_QUEUE_MAPPED:
+		switch (new_state) {
+		case DLB2_QUEUE_UNMAPPED:
+			queue->num_mappings--;
+			port->num_mappings--;
+			break;
+		case DLB2_QUEUE_UNMAP_IN_PROG:
+			port->num_pending_removals++;
+			domain->num_pending_removals++;
+			break;
+		case DLB2_QUEUE_MAPPED:
+			/* Priority change, nothing to update */
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB2_QUEUE_MAP_IN_PROG:
+		switch (new_state) {
+		case DLB2_QUEUE_UNMAPPED:
+			queue->num_pending_additions--;
+			domain->num_pending_additions--;
+			break;
+		case DLB2_QUEUE_MAPPED:
+			queue->num_mappings++;
+			port->num_mappings++;
+			queue->num_pending_additions--;
+			domain->num_pending_additions--;
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB2_QUEUE_UNMAP_IN_PROG:
+		switch (new_state) {
+		case DLB2_QUEUE_UNMAPPED:
+			port->num_pending_removals--;
+			domain->num_pending_removals--;
+			queue->num_mappings--;
+			port->num_mappings--;
+			break;
+		case DLB2_QUEUE_MAPPED:
+			port->num_pending_removals--;
+			domain->num_pending_removals--;
+			break;
+		case DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP:
+			/* Nothing to update */
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP:
+		switch (new_state) {
+		case DLB2_QUEUE_UNMAP_IN_PROG:
+			/* Nothing to update */
+			break;
+		case DLB2_QUEUE_UNMAPPED:
+			/*
+			 * An UNMAP_IN_PROG_PENDING_MAP slot briefly
+			 * becomes UNMAPPED before it transitions to
+			 * MAP_IN_PROG.
+			 */
+			queue->num_mappings--;
+			port->num_mappings--;
+			port->num_pending_removals--;
+			domain->num_pending_removals--;
+			break;
+		default:
+			goto error;
+		}
+		break;
+	default:
+		goto error;
+	}
+
+	port->qid_map[slot].state = new_state;
+
+	DLB2_HW_DBG(hw,
+		    "[%s()] queue %d -> port %d state transition (%d -> %d)\n",
+		    __func__, queue->id.phys_id, port->id.phys_id,
+		    curr_state, new_state);
+	return 0;
+
+error:
+	DLB2_HW_ERR(hw,
+		    "[%s()] Internal error: invalid queue %d -> port %d state transition (%d -> %d)\n",
+		    __func__, queue->id.phys_id, port->id.phys_id,
+		    curr_state, new_state);
+	return -EFAULT;
+}
+
+static void dlb2_configure_domain_credits(struct dlb2_hw *hw,
+					  struct dlb2_hw_domain *domain)
+{
+	union dlb2_chp_cfg_ldb_vas_crd r0 = { {0} };
+	union dlb2_chp_cfg_dir_vas_crd r1 = { {0} };
+
+	r0.field.count = domain->num_ldb_credits;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_LDB_VAS_CRD(domain->id.phys_id), r0.val);
+
+	r1.field.count = domain->num_dir_credits;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_DIR_VAS_CRD(domain->id.phys_id), r1.val);
+}
+
+static int
+dlb2_domain_attach_resources(struct dlb2_hw *hw,
+			     struct dlb2_function_resources *rsrcs,
+			     struct dlb2_hw_domain *domain,
+			     struct dlb2_create_sched_domain_args *args,
+			     struct dlb2_cmd_response *resp)
+{
+	int ret;
+
+	ret = dlb2_attach_ldb_queues(hw,
+				     rsrcs,
+				     domain,
+				     args->num_ldb_queues,
+				     resp);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_attach_ldb_ports(hw,
+				    rsrcs,
+				    domain,
+				    args,
+				    resp);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_attach_dir_ports(hw,
+				    rsrcs,
+				    domain,
+				    args->num_dir_ports,
+				    resp);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_attach_ldb_credits(rsrcs,
+				      domain,
+				      args->num_ldb_credits,
+				      resp);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_attach_dir_credits(rsrcs,
+				      domain,
+				      args->num_dir_credits,
+				      resp);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_attach_domain_hist_list_entries(rsrcs,
+						   domain,
+						   args->num_hist_list_entries,
+						   resp);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_attach_atomic_inflights(rsrcs,
+					   domain,
+					   args->num_atomic_inflights,
+					   resp);
+	if (ret < 0)
+		return ret;
+
+	dlb2_configure_domain_credits(hw, domain);
+
+	domain->configured = true;
+
+	domain->started = false;
+
+	rsrcs->num_avail_domains--;
+
+	return 0;
+}
+
+static void dlb2_ldb_port_cq_enable(struct dlb2_hw *hw,
+				    struct dlb2_ldb_port *port)
+{
+	union dlb2_lsp_cq_ldb_dsbl reg;
+
+	/*
+	 * Don't re-enable the port if a removal is pending. The caller should
+	 * mark this port as enabled (if it isn't already), and when the
+	 * removal completes the port will be enabled.
+	 */
+	if (port->num_pending_removals)
+		return;
+
+	reg.field.disabled = 0;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ_LDB_DSBL(port->id.phys_id), reg.val);
+
+	dlb2_flush_csr(hw);
+}
+
+static void dlb2_ldb_port_cq_disable(struct dlb2_hw *hw,
+				     struct dlb2_ldb_port *port)
+{
+	union dlb2_lsp_cq_ldb_dsbl reg;
+
+	reg.field.disabled = 1;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ_LDB_DSBL(port->id.phys_id), reg.val);
+
+	dlb2_flush_csr(hw);
+}
+
+static void dlb2_dir_port_cq_enable(struct dlb2_hw *hw,
+				    struct dlb2_dir_pq_pair *port)
+{
+	union dlb2_lsp_cq_dir_dsbl reg;
+
+	reg.field.disabled = 0;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ_DIR_DSBL(port->id.phys_id), reg.val);
+
+	dlb2_flush_csr(hw);
+}
+
+static void dlb2_dir_port_cq_disable(struct dlb2_hw *hw,
+				     struct dlb2_dir_pq_pair *port)
+{
+	union dlb2_lsp_cq_dir_dsbl reg;
+
+	reg.field.disabled = 1;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ_DIR_DSBL(port->id.phys_id), reg.val);
+
+	dlb2_flush_csr(hw);
+}
+
+static int dlb2_ldb_port_map_qid_static(struct dlb2_hw *hw,
+					struct dlb2_ldb_port *p,
+					struct dlb2_ldb_queue *q,
+					u8 priority)
+{
+	union dlb2_lsp_cq2priov r0;
+	union dlb2_lsp_cq2qid0 r1;
+	union dlb2_atm_qid2cqidix_00 r2;
+	union dlb2_lsp_qid2cqidix_00 r3;
+	union dlb2_lsp_qid2cqidix2_00 r4;
+	enum dlb2_qid_map_state state;
+	int i;
+
+	/* Look for a pending or already mapped slot, else an unused slot */
+	if (!dlb2_port_find_slot_queue(p, DLB2_QUEUE_MAP_IN_PROG, q, &i) &&
+	    !dlb2_port_find_slot_queue(p, DLB2_QUEUE_MAPPED, q, &i) &&
+	    !dlb2_port_find_slot(p, DLB2_QUEUE_UNMAPPED, &i)) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: CQ has no available QID mapping slots\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port slot tracking failed\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/* Read-modify-write the priority and valid bit register */
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ2PRIOV(p->id.phys_id));
+
+	r0.field.v |= 1 << i;
+	r0.field.prio |= (priority & 0x7) << i * 3;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ2PRIOV(p->id.phys_id), r0.val);
+
+	/* Read-modify-write the QID map register */
+	if (i < 4)
+		r1.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ2QID0(p->id.phys_id));
+	else
+		r1.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ2QID1(p->id.phys_id));
+
+	if (i == 0 || i == 4)
+		r1.field.qid_p0 = q->id.phys_id;
+	if (i == 1 || i == 5)
+		r1.field.qid_p1 = q->id.phys_id;
+	if (i == 2 || i == 6)
+		r1.field.qid_p2 = q->id.phys_id;
+	if (i == 3 || i == 7)
+		r1.field.qid_p3 = q->id.phys_id;
+
+	if (i < 4)
+		DLB2_CSR_WR(hw, DLB2_LSP_CQ2QID0(p->id.phys_id), r1.val);
+	else
+		DLB2_CSR_WR(hw, DLB2_LSP_CQ2QID1(p->id.phys_id), r1.val);
+
+	r2.val = DLB2_CSR_RD(hw,
+			     DLB2_ATM_QID2CQIDIX(q->id.phys_id,
+						 p->id.phys_id / 4));
+
+	r3.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID2CQIDIX(q->id.phys_id,
+						 p->id.phys_id / 4));
+
+	r4.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID2CQIDIX2(q->id.phys_id,
+						  p->id.phys_id / 4));
+
+	switch (p->id.phys_id % 4) {
+	case 0:
+		r2.field.cq_p0 |= 1 << i;
+		r3.field.cq_p0 |= 1 << i;
+		r4.field.cq_p0 |= 1 << i;
+		break;
+
+	case 1:
+		r2.field.cq_p1 |= 1 << i;
+		r3.field.cq_p1 |= 1 << i;
+		r4.field.cq_p1 |= 1 << i;
+		break;
+
+	case 2:
+		r2.field.cq_p2 |= 1 << i;
+		r3.field.cq_p2 |= 1 << i;
+		r4.field.cq_p2 |= 1 << i;
+		break;
+
+	case 3:
+		r2.field.cq_p3 |= 1 << i;
+		r3.field.cq_p3 |= 1 << i;
+		r4.field.cq_p3 |= 1 << i;
+		break;
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_ATM_QID2CQIDIX(q->id.phys_id, p->id.phys_id / 4),
+		    r2.val);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID2CQIDIX(q->id.phys_id, p->id.phys_id / 4),
+		    r3.val);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID2CQIDIX2(q->id.phys_id, p->id.phys_id / 4),
+		    r4.val);
+
+	dlb2_flush_csr(hw);
+
+	p->qid_map[i].qid = q->id.phys_id;
+	p->qid_map[i].priority = priority;
+
+	state = DLB2_QUEUE_MAPPED;
+
+	return dlb2_port_slot_state_transition(hw, p, q, i, state);
+}
+
+static int dlb2_ldb_port_set_has_work_bits(struct dlb2_hw *hw,
+					   struct dlb2_ldb_port *port,
+					   struct dlb2_ldb_queue *queue,
+					   int slot)
+{
+	union dlb2_lsp_qid_aqed_active_cnt r0;
+	union dlb2_lsp_qid_ldb_enqueue_cnt r1;
+	union dlb2_lsp_ldb_sched_ctrl r2 = { {0} };
+
+	/* Set the atomic scheduling haswork bit */
+	r0.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_AQED_ACTIVE_CNT(queue->id.phys_id));
+
+	r2.field.cq = port->id.phys_id;
+	r2.field.qidix = slot;
+	r2.field.value = 1;
+	r2.field.rlist_haswork_v = r0.field.count > 0;
+
+	/* Set the non-atomic scheduling haswork bit */
+	DLB2_CSR_WR(hw, DLB2_LSP_LDB_SCHED_CTRL, r2.val);
+
+	r1.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_LDB_ENQUEUE_CNT(queue->id.phys_id));
+
+	memset(&r2, 0, sizeof(r2));
+
+	r2.field.cq = port->id.phys_id;
+	r2.field.qidix = slot;
+	r2.field.value = 1;
+	r2.field.nalb_haswork_v = (r1.field.count > 0);
+
+	DLB2_CSR_WR(hw, DLB2_LSP_LDB_SCHED_CTRL, r2.val);
+
+	dlb2_flush_csr(hw);
+
+	return 0;
+}
+
+static void dlb2_ldb_port_clear_has_work_bits(struct dlb2_hw *hw,
+					      struct dlb2_ldb_port *port,
+					      u8 slot)
+{
+	union dlb2_lsp_ldb_sched_ctrl r2 = { {0} };
+
+	r2.field.cq = port->id.phys_id;
+	r2.field.qidix = slot;
+	r2.field.value = 0;
+	r2.field.rlist_haswork_v = 1;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_LDB_SCHED_CTRL, r2.val);
+
+	memset(&r2, 0, sizeof(r2));
+
+	r2.field.cq = port->id.phys_id;
+	r2.field.qidix = slot;
+	r2.field.value = 0;
+	r2.field.nalb_haswork_v = 1;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_LDB_SCHED_CTRL, r2.val);
+
+	dlb2_flush_csr(hw);
+}
+
+static void dlb2_ldb_port_clear_queue_if_status(struct dlb2_hw *hw,
+						struct dlb2_ldb_port *port,
+						int slot)
+{
+	union dlb2_lsp_ldb_sched_ctrl r0 = { {0} };
+
+	r0.field.cq = port->id.phys_id;
+	r0.field.qidix = slot;
+	r0.field.value = 0;
+	r0.field.inflight_ok_v = 1;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_LDB_SCHED_CTRL, r0.val);
+
+	dlb2_flush_csr(hw);
+}
+
+static void dlb2_ldb_port_set_queue_if_status(struct dlb2_hw *hw,
+					      struct dlb2_ldb_port *port,
+					      int slot)
+{
+	union dlb2_lsp_ldb_sched_ctrl r0 = { {0} };
+
+	r0.field.cq = port->id.phys_id;
+	r0.field.qidix = slot;
+	r0.field.value = 1;
+	r0.field.inflight_ok_v = 1;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_LDB_SCHED_CTRL, r0.val);
+
+	dlb2_flush_csr(hw);
+}
+
+static void dlb2_ldb_queue_set_inflight_limit(struct dlb2_hw *hw,
+					      struct dlb2_ldb_queue *queue)
+{
+	union dlb2_lsp_qid_ldb_infl_lim r0 = { {0} };
+
+	r0.field.limit = queue->num_qid_inflights;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_QID_LDB_INFL_LIM(queue->id.phys_id), r0.val);
+}
+
+static void dlb2_ldb_queue_clear_inflight_limit(struct dlb2_hw *hw,
+						struct dlb2_ldb_queue *queue)
+{
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID_LDB_INFL_LIM(queue->id.phys_id),
+		    DLB2_LSP_QID_LDB_INFL_LIM_RST);
+}
+
+/*
+ * dlb2_ldb_queue_{enable, disable}_mapped_cqs() don't operate exactly as
+ * their function names imply, and should only be called by the dynamic CQ
+ * mapping code.
+ */
+static void dlb2_ldb_queue_disable_mapped_cqs(struct dlb2_hw *hw,
+					      struct dlb2_hw_domain *domain,
+					      struct dlb2_ldb_queue *queue)
+{
+	struct dlb2_ldb_port *port;
+	int slot, i;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			enum dlb2_qid_map_state state = DLB2_QUEUE_MAPPED;
+
+			if (!dlb2_port_find_slot_queue(port, state,
+						       queue, &slot))
+				continue;
+
+			if (port->enabled)
+				dlb2_ldb_port_cq_disable(hw, port);
+		}
+	}
+}
+
+static void dlb2_ldb_queue_enable_mapped_cqs(struct dlb2_hw *hw,
+					     struct dlb2_hw_domain *domain,
+					     struct dlb2_ldb_queue *queue)
+{
+	struct dlb2_ldb_port *port;
+	int slot, i;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			enum dlb2_qid_map_state state = DLB2_QUEUE_MAPPED;
+
+			if (!dlb2_port_find_slot_queue(port, state,
+						       queue, &slot))
+				continue;
+
+			if (port->enabled)
+				dlb2_ldb_port_cq_enable(hw, port);
+		}
+	}
+}
+
+static int dlb2_ldb_port_finish_map_qid_dynamic(struct dlb2_hw *hw,
+						struct dlb2_hw_domain *domain,
+						struct dlb2_ldb_port *port,
+						struct dlb2_ldb_queue *queue)
+{
+	union dlb2_lsp_qid_ldb_infl_cnt r0;
+	enum dlb2_qid_map_state state;
+	int slot, ret, i;
+	u8 prio;
+
+	r0.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_LDB_INFL_CNT(queue->id.phys_id));
+
+	if (r0.field.count) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: non-zero QID inflight count\n",
+			    __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * Static map the port and set its corresponding has_work bits.
+	 */
+	state = DLB2_QUEUE_MAP_IN_PROG;
+	if (!dlb2_port_find_slot_queue(port, state, queue, &slot))
+		return -EINVAL;
+
+	if (slot >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port slot tracking failed\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	prio = port->qid_map[slot].priority;
+
+	/*
+	 * Update the CQ2QID, CQ2PRIOV, and QID2CQIDX registers, and
+	 * the port's qid_map state.
+	 */
+	ret = dlb2_ldb_port_map_qid_static(hw, port, queue, prio);
+	if (ret)
+		return ret;
+
+	ret = dlb2_ldb_port_set_has_work_bits(hw, port, queue, slot);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ensure IF_status(cq,qid) is 0 before enabling the port to
+	 * prevent spurious schedules to cause the queue's inflight
+	 * count to increase.
+	 */
+	dlb2_ldb_port_clear_queue_if_status(hw, port, slot);
+
+	/* Reset the queue's inflight status */
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			state = DLB2_QUEUE_MAPPED;
+			if (!dlb2_port_find_slot_queue(port, state,
+						       queue, &slot))
+				continue;
+
+			dlb2_ldb_port_set_queue_if_status(hw, port, slot);
+		}
+	}
+
+	dlb2_ldb_queue_set_inflight_limit(hw, queue);
+
+	/* Re-enable CQs mapped to this queue */
+	dlb2_ldb_queue_enable_mapped_cqs(hw, domain, queue);
+
+	/* If this queue has other mappings pending, clear its inflight limit */
+	if (queue->num_pending_additions > 0)
+		dlb2_ldb_queue_clear_inflight_limit(hw, queue);
+
+	return 0;
+}
+
+/**
+ * dlb2_ldb_port_map_qid_dynamic() - perform a "dynamic" QID->CQ mapping
+ * @hw: dlb2_hw handle for a particular device.
+ * @port: load-balanced port
+ * @queue: load-balanced queue
+ * @priority: queue servicing priority
+ *
+ * Returns 0 if the queue was mapped, 1 if the mapping is scheduled to occur
+ * at a later point, and <0 if an error occurred.
+ */
+static int dlb2_ldb_port_map_qid_dynamic(struct dlb2_hw *hw,
+					 struct dlb2_ldb_port *port,
+					 struct dlb2_ldb_queue *queue,
+					 u8 priority)
+{
+	union dlb2_lsp_qid_ldb_infl_cnt r0 = { {0} };
+	enum dlb2_qid_map_state state;
+	struct dlb2_hw_domain *domain;
+	int domain_id, slot, ret;
+
+	domain_id = port->domain_id.phys_id;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, false, 0);
+	if (!domain) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: unable to find domain %d\n",
+			    __func__, port->domain_id.phys_id);
+		return -EINVAL;
+	}
+
+	/*
+	 * Set the QID inflight limit to 0 to prevent further scheduling of the
+	 * queue.
+	 */
+	DLB2_CSR_WR(hw, DLB2_LSP_QID_LDB_INFL_LIM(queue->id.phys_id), 0);
+
+	if (!dlb2_port_find_slot(port, DLB2_QUEUE_UNMAPPED, &slot)) {
+		DLB2_HW_ERR(hw,
+			    "Internal error: No available unmapped slots\n");
+		return -EFAULT;
+	}
+
+	if (slot >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port slot tracking failed\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	port->qid_map[slot].qid = queue->id.phys_id;
+	port->qid_map[slot].priority = priority;
+
+	state = DLB2_QUEUE_MAP_IN_PROG;
+	ret = dlb2_port_slot_state_transition(hw, port, queue, slot, state);
+	if (ret)
+		return ret;
+
+	/*
+	 * Disable the affected CQ, and the CQs already mapped to the QID,
+	 * before reading the QID's inflight count a second time. There is an
+	 * unlikely race in which the QID may schedule one more QE after we
+	 * read an inflight count of 0, and disabling the CQs guarantees that
+	 * the race will not occur after a re-read of the inflight count
+	 * register.
+	 */
+	if (port->enabled)
+		dlb2_ldb_port_cq_disable(hw, port);
+
+	dlb2_ldb_queue_disable_mapped_cqs(hw, domain, queue);
+
+	r0.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_LDB_INFL_CNT(queue->id.phys_id));
+
+	if (r0.field.count) {
+		if (port->enabled)
+			dlb2_ldb_port_cq_enable(hw, port);
+
+		dlb2_ldb_queue_enable_mapped_cqs(hw, domain, queue);
+
+		return 1;
+	}
+
+	return dlb2_ldb_port_finish_map_qid_dynamic(hw, domain, port, queue);
+}
+
+static int dlb2_ldb_port_map_qid(struct dlb2_hw *hw,
+				 struct dlb2_hw_domain *domain,
+				 struct dlb2_ldb_port *port,
+				 struct dlb2_ldb_queue *queue,
+				 u8 prio)
+{
+	if (domain->started)
+		return dlb2_ldb_port_map_qid_dynamic(hw, port, queue, prio);
+	else
+		return dlb2_ldb_port_map_qid_static(hw, port, queue, prio);
+}
+
+static int dlb2_ldb_port_unmap_qid(struct dlb2_hw *hw,
+				   struct dlb2_ldb_port *port,
+				   struct dlb2_ldb_queue *queue)
+{
+	enum dlb2_qid_map_state mapped, in_progress, pending_map, unmapped;
+	union dlb2_lsp_cq2priov r0;
+	union dlb2_atm_qid2cqidix_00 r1;
+	union dlb2_lsp_qid2cqidix_00 r2;
+	union dlb2_lsp_qid2cqidix2_00 r3;
+	u32 queue_id;
+	u32 port_id;
+	int i;
+
+	/* Find the queue's slot */
+	mapped = DLB2_QUEUE_MAPPED;
+	in_progress = DLB2_QUEUE_UNMAP_IN_PROG;
+	pending_map = DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP;
+
+	if (!dlb2_port_find_slot_queue(port, mapped, queue, &i) &&
+	    !dlb2_port_find_slot_queue(port, in_progress, queue, &i) &&
+	    !dlb2_port_find_slot_queue(port, pending_map, queue, &i)) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: QID %d isn't mapped\n",
+			    __func__, __LINE__, queue->id.phys_id);
+		return -EFAULT;
+	}
+
+	if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port slot tracking failed\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	port_id = port->id.phys_id;
+	queue_id = queue->id.phys_id;
+
+	/* Read-modify-write the priority and valid bit register */
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ2PRIOV(port_id));
+
+	r0.field.v &= ~(1 << i);
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ2PRIOV(port_id), r0.val);
+
+	r1.val = DLB2_CSR_RD(hw,
+			     DLB2_ATM_QID2CQIDIX(queue_id, port_id / 4));
+
+	r2.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID2CQIDIX(queue_id, port_id / 4));
+
+	r3.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID2CQIDIX2(queue_id, port_id / 4));
+
+	switch (port_id % 4) {
+	case 0:
+		r1.field.cq_p0 &= ~(1 << i);
+		r2.field.cq_p0 &= ~(1 << i);
+		r3.field.cq_p0 &= ~(1 << i);
+		break;
+
+	case 1:
+		r1.field.cq_p1 &= ~(1 << i);
+		r2.field.cq_p1 &= ~(1 << i);
+		r3.field.cq_p1 &= ~(1 << i);
+		break;
+
+	case 2:
+		r1.field.cq_p2 &= ~(1 << i);
+		r2.field.cq_p2 &= ~(1 << i);
+		r3.field.cq_p2 &= ~(1 << i);
+		break;
+
+	case 3:
+		r1.field.cq_p3 &= ~(1 << i);
+		r2.field.cq_p3 &= ~(1 << i);
+		r3.field.cq_p3 &= ~(1 << i);
+		break;
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_ATM_QID2CQIDIX(queue_id, port_id / 4),
+		    r1.val);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID2CQIDIX(queue_id, port_id / 4),
+		    r2.val);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID2CQIDIX2(queue_id, port_id / 4),
+		    r3.val);
+
+	dlb2_flush_csr(hw);
+
+	unmapped = DLB2_QUEUE_UNMAPPED;
+
+	return dlb2_port_slot_state_transition(hw, port, queue, i, unmapped);
+}
+
+static void
+dlb2_log_create_sched_domain_args(struct dlb2_hw *hw,
+				  struct dlb2_create_sched_domain_args *args,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 create sched domain arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tNumber of LDB queues:          %d\n",
+		    args->num_ldb_queues);
+	DLB2_HW_DBG(hw, "\tNumber of LDB ports (any CoS): %d\n",
+		    args->num_ldb_ports);
+	DLB2_HW_DBG(hw, "\tNumber of LDB ports (CoS 0):   %d\n",
+		    args->num_cos_ldb_ports[0]);
+	DLB2_HW_DBG(hw, "\tNumber of LDB ports (CoS 1):   %d\n",
+		    args->num_cos_ldb_ports[1]);
+	DLB2_HW_DBG(hw, "\tNumber of LDB ports (CoS 2):   %d\n",
+		    args->num_cos_ldb_ports[2]);
+	DLB2_HW_DBG(hw, "\tNumber of LDB ports (CoS 3):   %d\n",
+		    args->num_cos_ldb_ports[3]);
+	DLB2_HW_DBG(hw, "\tStrict CoS allocation:         %d\n",
+		    args->cos_strict);
+	DLB2_HW_DBG(hw, "\tNumber of DIR ports:           %d\n",
+		    args->num_dir_ports);
+	DLB2_HW_DBG(hw, "\tNumber of ATM inflights:       %d\n",
+		    args->num_atomic_inflights);
+	DLB2_HW_DBG(hw, "\tNumber of hist list entries:   %d\n",
+		    args->num_hist_list_entries);
+	DLB2_HW_DBG(hw, "\tNumber of LDB credits:         %d\n",
+		    args->num_ldb_credits);
+	DLB2_HW_DBG(hw, "\tNumber of DIR credits:         %d\n",
+		    args->num_dir_credits);
+}
+
+/**
+ * dlb2_hw_create_sched_domain() - Allocate and initialize a DLB scheduling
+ *	domain and its resources.
+ * @hw:	Contains the current state of the DLB2 hardware.
+ * @args: User-provided arguments.
+ * @resp: Response to user.
+ * @vdev_req: Request came from a virtual device.
+ * @vdev_id: If vdev_req is true, this contains the virtual device's ID.
+ *
+ * Return: returns < 0 on error, 0 otherwise. If the driver is unable to
+ * satisfy a request, resp->status will be set accordingly.
+ */
+int dlb2_hw_create_sched_domain(struct dlb2_hw *hw,
+				struct dlb2_create_sched_domain_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vdev_req,
+				unsigned int vdev_id)
+{
+	struct dlb2_function_resources *rsrcs;
+	struct dlb2_hw_domain *domain;
+	int ret;
+
+	rsrcs = (vdev_req) ? &hw->vdev[vdev_id] : &hw->pf;
+
+	dlb2_log_create_sched_domain_args(hw, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_create_sched_dom_args(rsrcs, args, resp);
+	if (ret)
+		return ret;
+
+	domain = DLB2_FUNC_LIST_HEAD(rsrcs->avail_domains, typeof(*domain));
+
+	if (!domain) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: no available domains\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	if (domain->configured) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: avail_domains contains configured domains.\n",
+			    __func__);
+		return -EFAULT;
+	}
+
+	dlb2_init_domain_rsrc_lists(domain);
+
+	ret = dlb2_domain_attach_resources(hw, rsrcs, domain, args, resp);
+	if (ret < 0) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: failed to verify args.\n",
+			    __func__);
+
+		return ret;
+	}
+
+	list_del(&domain->func_list);
+
+	list_add(&domain->func_list, &rsrcs->used_domains);
+
+	resp->id = (vdev_req) ? domain->id.virt_id : domain->id.phys_id;
+	resp->status = 0;
+
+	return 0;
+}
+
+static void
+dlb2_domain_finish_unmap_port_slot(struct dlb2_hw *hw,
+				   struct dlb2_hw_domain *domain,
+				   struct dlb2_ldb_port *port,
+				   int slot)
+{
+	enum dlb2_qid_map_state state;
+	struct dlb2_ldb_queue *queue;
+
+	queue = &hw->rsrcs.ldb_queues[port->qid_map[slot].qid];
+
+	state = port->qid_map[slot].state;
+
+	/* Update the QID2CQIDX and CQ2QID vectors */
+	dlb2_ldb_port_unmap_qid(hw, port, queue);
+
+	/*
+	 * Ensure the QID will not be serviced by this {CQ, slot} by clearing
+	 * the has_work bits
+	 */
+	dlb2_ldb_port_clear_has_work_bits(hw, port, slot);
+
+	/* Reset the {CQ, slot} to its default state */
+	dlb2_ldb_port_set_queue_if_status(hw, port, slot);
+
+	/* Re-enable the CQ if it wasn't manually disabled by the user */
+	if (port->enabled)
+		dlb2_ldb_port_cq_enable(hw, port);
+
+	/*
+	 * If there is a mapping that is pending this slot's removal, perform
+	 * the mapping now.
+	 */
+	if (state == DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP) {
+		struct dlb2_ldb_port_qid_map *map;
+		struct dlb2_ldb_queue *map_queue;
+		u8 prio;
+
+		map = &port->qid_map[slot];
+
+		map->qid = map->pending_qid;
+		map->priority = map->pending_priority;
+
+		map_queue = &hw->rsrcs.ldb_queues[map->qid];
+		prio = map->priority;
+
+		dlb2_ldb_port_map_qid(hw, domain, port, map_queue, prio);
+	}
+}
+
+static bool dlb2_domain_finish_unmap_port(struct dlb2_hw *hw,
+					  struct dlb2_hw_domain *domain,
+					  struct dlb2_ldb_port *port)
+{
+	union dlb2_lsp_cq_ldb_infl_cnt r0;
+	int i;
+
+	if (port->num_pending_removals == 0)
+		return false;
+
+	/*
+	 * The unmap requires all the CQ's outstanding inflights to be
+	 * completed.
+	 */
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ_LDB_INFL_CNT(port->id.phys_id));
+	if (r0.field.count > 0)
+		return false;
+
+	for (i = 0; i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		struct dlb2_ldb_port_qid_map *map;
+
+		map = &port->qid_map[i];
+
+		if (map->state != DLB2_QUEUE_UNMAP_IN_PROG &&
+		    map->state != DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP)
+			continue;
+
+		dlb2_domain_finish_unmap_port_slot(hw, domain, port, i);
+	}
+
+	return true;
+}
+
+static unsigned int
+dlb2_domain_finish_unmap_qid_procedures(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_port *port;
+	int i;
+
+	if (!domain->configured || domain->num_pending_removals == 0)
+		return 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port)
+			dlb2_domain_finish_unmap_port(hw, domain, port);
+	}
+
+	return domain->num_pending_removals;
+}
+
+static void dlb2_domain_finish_map_port(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain,
+					struct dlb2_ldb_port *port)
+{
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		union dlb2_lsp_qid_ldb_infl_cnt r0;
+		struct dlb2_ldb_queue *queue;
+		int qid;
+
+		if (port->qid_map[i].state != DLB2_QUEUE_MAP_IN_PROG)
+			continue;
+
+		qid = port->qid_map[i].qid;
+
+		queue = dlb2_get_ldb_queue_from_id(hw, qid, false, 0);
+
+		if (!queue) {
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: unable to find queue %d\n",
+				    __func__, qid);
+			continue;
+		}
+
+		r0.val = DLB2_CSR_RD(hw, DLB2_LSP_QID_LDB_INFL_CNT(qid));
+
+		if (r0.field.count)
+			continue;
+
+		/*
+		 * Disable the affected CQ, and the CQs already mapped to the
+		 * QID, before reading the QID's inflight count a second time.
+		 * There is an unlikely race in which the QID may schedule one
+		 * more QE after we read an inflight count of 0, and disabling
+		 * the CQs guarantees that the race will not occur after a
+		 * re-read of the inflight count register.
+		 */
+		if (port->enabled)
+			dlb2_ldb_port_cq_disable(hw, port);
+
+		dlb2_ldb_queue_disable_mapped_cqs(hw, domain, queue);
+
+		r0.val = DLB2_CSR_RD(hw, DLB2_LSP_QID_LDB_INFL_CNT(qid));
+
+		if (r0.field.count) {
+			if (port->enabled)
+				dlb2_ldb_port_cq_enable(hw, port);
+
+			dlb2_ldb_queue_enable_mapped_cqs(hw, domain, queue);
+
+			continue;
+		}
+
+		dlb2_ldb_port_finish_map_qid_dynamic(hw, domain, port, queue);
+	}
+}
+
+static unsigned int
+dlb2_domain_finish_map_qid_procedures(struct dlb2_hw *hw,
+				      struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_port *port;
+	int i;
+
+	if (!domain->configured || domain->num_pending_additions == 0)
+		return 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port)
+			dlb2_domain_finish_map_port(hw, domain, port);
+	}
+
+	return domain->num_pending_additions;
+}
+
+static u32 dlb2_ldb_cq_inflight_count(struct dlb2_hw *hw,
+				      struct dlb2_ldb_port *port)
+{
+	union dlb2_lsp_cq_ldb_infl_cnt r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ_LDB_INFL_CNT(port->id.phys_id));
+
+	return r0.field.count;
+}
+
+static u32 dlb2_ldb_cq_token_count(struct dlb2_hw *hw,
+				   struct dlb2_ldb_port *port)
+{
+	union dlb2_lsp_cq_ldb_tkn_cnt r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ_LDB_TKN_CNT(port->id.phys_id));
+
+	/*
+	 * Account for the initial token count, which is used in order to
+	 * provide a CQ with depth less than 8.
+	 */
+
+	return r0.field.token_count - port->init_tkn_cnt;
+}
+
+static void __iomem *dlb2_producer_port_addr(struct dlb2_hw *hw,
+					     u8 port_id,
+					     bool is_ldb)
+{
+	struct dlb2_dev *dlb2_dev;
+	unsigned long size;
+	uintptr_t address;
+
+	dlb2_dev = container_of(hw, struct dlb2_dev, hw);
+
+	address = (uintptr_t)dlb2_dev->hw.func_kva;
+
+	if (is_ldb) {
+		size = DLB2_LDB_PP_STRIDE;
+		address += DLB2_DRV_LDB_PP_BASE + size * port_id;
+	} else {
+		size = DLB2_DIR_PP_STRIDE;
+		address += DLB2_DRV_DIR_PP_BASE + size * port_id;
+	}
+
+	return (void __iomem *)address;
+}
+
+static void dlb2_fence_hcw(void __iomem *addr)
+{
+	/*
+	 * To ensure outstanding HCWs reach the device before subsequent device
+	 * accesses, fence them.
+	 */
+	mb();
+}
+
+static int dlb2_drain_ldb_cq(struct dlb2_hw *hw, struct dlb2_ldb_port *port)
+{
+	u32 infl_cnt, tkn_cnt;
+	unsigned int i;
+
+	infl_cnt = dlb2_ldb_cq_inflight_count(hw, port);
+	tkn_cnt = dlb2_ldb_cq_token_count(hw, port);
+
+	if (infl_cnt || tkn_cnt) {
+		struct dlb2_hcw hcw_mem[8], *hcw;
+		void __iomem *pp_addr;
+
+		pp_addr = dlb2_producer_port_addr(hw, port->id.phys_id, true);
+
+		/* Point hcw to a 64B-aligned location */
+		hcw = (struct dlb2_hcw *)((uintptr_t)&hcw_mem[4] & ~0x3F);
+
+		/*
+		 * Program the first HCW for a completion and token return and
+		 * the other HCWs as NOOPS
+		 */
+
+		memset(hcw, 0, 4 * sizeof(*hcw));
+		hcw->qe_comp = (infl_cnt > 0);
+		hcw->cq_token = (tkn_cnt > 0);
+		hcw->lock_id = tkn_cnt - 1;
+
+		/* Return tokens in the first HCW */
+		iosubmit_cmds512(pp_addr, hcw, 1);
+
+		hcw->cq_token = 0;
+
+		/* Issue remaining completions (if any) */
+		for (i = 1; i < infl_cnt; i++)
+			iosubmit_cmds512(pp_addr, hcw, 1);
+
+		dlb2_fence_hcw(pp_addr);
+	}
+
+	return 0;
+}
+
+static int dlb2_domain_wait_for_ldb_cqs_to_empty(struct dlb2_hw *hw,
+						 struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_port *port;
+	int i;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			int i;
+
+			for (i = 0; i < DLB2_MAX_CQ_COMP_CHECK_LOOPS; i++) {
+				if (dlb2_ldb_cq_inflight_count(hw, port) == 0)
+					break;
+			}
+
+			if (i == DLB2_MAX_CQ_COMP_CHECK_LOOPS) {
+				DLB2_HW_ERR(hw,
+					    "[%s()] Internal error: failed to flush load-balanced port %d's completions.\n",
+					    __func__, port->id.phys_id);
+				return -EFAULT;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int dlb2_domain_reset_software_state(struct dlb2_hw *hw,
+					    struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *tmp_dir_port;
+	struct dlb2_function_resources *rsrcs;
+	struct dlb2_ldb_queue *tmp_ldb_queue;
+	struct dlb2_ldb_port *tmp_ldb_port;
+	struct dlb2_dir_pq_pair *dir_port;
+	struct dlb2_ldb_queue *ldb_queue;
+	struct dlb2_ldb_port *ldb_port;
+	struct list_head *list;
+	int ret, i;
+
+	rsrcs = domain->parent_func;
+
+	/* Move the domain's ldb queues to the function's avail list */
+	list = &domain->used_ldb_queues;
+	DLB2_DOM_LIST_FOR_SAFE(*list, ldb_queue, tmp_ldb_queue) {
+		if (ldb_queue->sn_cfg_valid) {
+			struct dlb2_sn_group *grp;
+
+			grp = &hw->rsrcs.sn_groups[ldb_queue->sn_group];
+
+			dlb2_sn_group_free_slot(grp, ldb_queue->sn_slot);
+			ldb_queue->sn_cfg_valid = false;
+		}
+
+		ldb_queue->owned = false;
+		ldb_queue->num_mappings = 0;
+		ldb_queue->num_pending_additions = 0;
+
+		list_del(&ldb_queue->domain_list);
+		list_add(&ldb_queue->func_list, &rsrcs->avail_ldb_queues);
+		rsrcs->num_avail_ldb_queues++;
+	}
+
+	list = &domain->avail_ldb_queues;
+	DLB2_DOM_LIST_FOR_SAFE(*list, ldb_queue, tmp_ldb_queue) {
+		ldb_queue->owned = false;
+
+		list_del(&ldb_queue->domain_list);
+		list_add(&ldb_queue->func_list, &rsrcs->avail_ldb_queues);
+		rsrcs->num_avail_ldb_queues++;
+	}
+
+	/* Move the domain's ldb ports to the function's avail list */
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		list = &domain->used_ldb_ports[i];
+		DLB2_DOM_LIST_FOR_SAFE(*list, ldb_port, tmp_ldb_port) {
+			int j;
+
+			ldb_port->owned = false;
+			ldb_port->configured = false;
+			ldb_port->num_pending_removals = 0;
+			ldb_port->num_mappings = 0;
+			ldb_port->init_tkn_cnt = 0;
+			for (j = 0; j < DLB2_MAX_NUM_QIDS_PER_LDB_CQ; j++)
+				ldb_port->qid_map[j].state =
+					DLB2_QUEUE_UNMAPPED;
+
+			list_del(&ldb_port->domain_list);
+			list_add(&ldb_port->func_list,
+				 &rsrcs->avail_ldb_ports[i]);
+			rsrcs->num_avail_ldb_ports[i]++;
+		}
+
+		list = &domain->avail_ldb_ports[i];
+		DLB2_DOM_LIST_FOR_SAFE(*list, ldb_port, tmp_ldb_port) {
+			ldb_port->owned = false;
+
+			list_del(&ldb_port->domain_list);
+			list_add(&ldb_port->func_list,
+				 &rsrcs->avail_ldb_ports[i]);
+			rsrcs->num_avail_ldb_ports[i]++;
+		}
+	}
+
+	/* Move the domain's dir ports to the function's avail list */
+	list = &domain->used_dir_pq_pairs;
+	DLB2_DOM_LIST_FOR_SAFE(*list, dir_port, tmp_dir_port) {
+		dir_port->owned = false;
+		dir_port->port_configured = false;
+		dir_port->init_tkn_cnt = 0;
+
+		list_del(&dir_port->domain_list);
+
+		list_add(&dir_port->func_list, &rsrcs->avail_dir_pq_pairs);
+		rsrcs->num_avail_dir_pq_pairs++;
+	}
+
+	list = &domain->avail_dir_pq_pairs;
+	DLB2_DOM_LIST_FOR_SAFE(*list, dir_port, tmp_dir_port) {
+		dir_port->owned = false;
+
+		list_del(&dir_port->domain_list);
+
+		list_add(&dir_port->func_list, &rsrcs->avail_dir_pq_pairs);
+		rsrcs->num_avail_dir_pq_pairs++;
+	}
+
+	/* Return hist list entries to the function */
+	ret = dlb2_bitmap_set_range(rsrcs->avail_hist_list_entries,
+				    domain->hist_list_entry_base,
+				    domain->total_hist_list_entries);
+	if (ret) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: domain hist list base doesn't match the function's bitmap.\n",
+			    __func__);
+		return ret;
+	}
+
+	domain->total_hist_list_entries = 0;
+	domain->avail_hist_list_entries = 0;
+	domain->hist_list_entry_base = 0;
+	domain->hist_list_entry_offset = 0;
+
+	rsrcs->num_avail_qed_entries += domain->num_ldb_credits;
+	domain->num_ldb_credits = 0;
+
+	rsrcs->num_avail_dqed_entries += domain->num_dir_credits;
+	domain->num_dir_credits = 0;
+
+	rsrcs->num_avail_aqed_entries += domain->num_avail_aqed_entries;
+	rsrcs->num_avail_aqed_entries += domain->num_used_aqed_entries;
+	domain->num_avail_aqed_entries = 0;
+	domain->num_used_aqed_entries = 0;
+
+	domain->num_pending_removals = 0;
+	domain->num_pending_additions = 0;
+	domain->configured = false;
+	domain->started = false;
+
+	/*
+	 * Move the domain out of the used_domains list and back to the
+	 * function's avail_domains list.
+	 */
+	list_del(&domain->func_list);
+	list_add(&domain->func_list, &rsrcs->avail_domains);
+	rsrcs->num_avail_domains++;
+
+	return 0;
+}
+
+static u32 dlb2_dir_queue_depth(struct dlb2_hw *hw,
+				struct dlb2_dir_pq_pair *queue)
+{
+	union dlb2_lsp_qid_dir_enqueue_cnt r0;
+
+	r0.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_DIR_ENQUEUE_CNT(queue->id.phys_id));
+
+	return r0.field.count;
+}
+
+static bool dlb2_dir_queue_is_empty(struct dlb2_hw *hw,
+				    struct dlb2_dir_pq_pair *queue)
+{
+	return dlb2_dir_queue_depth(hw, queue) == 0;
+}
+
+static u32 dlb2_ldb_queue_depth(struct dlb2_hw *hw,
+				struct dlb2_ldb_queue *queue)
+{
+	union dlb2_lsp_qid_aqed_active_cnt r0;
+	union dlb2_lsp_qid_atm_active r1;
+	union dlb2_lsp_qid_ldb_enqueue_cnt r2;
+
+	r0.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_AQED_ACTIVE_CNT(queue->id.phys_id));
+	r1.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_ATM_ACTIVE(queue->id.phys_id));
+
+	r2.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_LDB_ENQUEUE_CNT(queue->id.phys_id));
+
+	return r0.field.count + r1.field.count + r2.field.count;
+}
+
+static bool dlb2_ldb_queue_is_empty(struct dlb2_hw *hw,
+				    struct dlb2_ldb_queue *queue)
+{
+	return dlb2_ldb_queue_depth(hw, queue) == 0;
+}
+
+static void __dlb2_domain_reset_ldb_port_registers(struct dlb2_hw *hw,
+						   struct dlb2_ldb_port *port)
+{
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_PP2VAS(port->id.phys_id),
+		    DLB2_SYS_LDB_PP2VAS_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ2VAS(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ2VAS_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_PP2VDEV(port->id.phys_id),
+		    DLB2_SYS_LDB_PP2VDEV_RST);
+
+	if (port->id.vdev_owned) {
+		unsigned int offs;
+		u32 virt_id;
+
+		/*
+		 * DLB uses producer port address bits 17:12 to determine the
+		 * producer port ID. In Scalable IOV mode, PP accesses come
+		 * through the PF MMIO window for the physical producer port,
+		 * so for translation purposes the virtual and physical port
+		 * IDs are equal.
+		 */
+		if (hw->virt_mode == DLB2_VIRT_SRIOV)
+			virt_id = port->id.virt_id;
+		else
+			virt_id = port->id.phys_id;
+
+		offs = port->id.vdev_id * DLB2_MAX_NUM_LDB_PORTS + virt_id;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_VF_LDB_VPP2PP(offs),
+			    DLB2_SYS_VF_LDB_VPP2PP_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_VF_LDB_VPP_V(offs),
+			    DLB2_SYS_VF_LDB_VPP_V_RST);
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_PP_V(port->id.phys_id),
+		    DLB2_SYS_LDB_PP_V_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_LDB_DSBL(port->id.phys_id),
+		    DLB2_LSP_CQ_LDB_DSBL_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_DEPTH(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ_DEPTH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_LDB_INFL_LIM(port->id.phys_id),
+		    DLB2_LSP_CQ_LDB_INFL_LIM_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_HIST_LIST_LIM(port->id.phys_id),
+		    DLB2_CHP_HIST_LIST_LIM_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_HIST_LIST_BASE(port->id.phys_id),
+		    DLB2_CHP_HIST_LIST_BASE_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_HIST_LIST_POP_PTR(port->id.phys_id),
+		    DLB2_CHP_HIST_LIST_POP_PTR_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_HIST_LIST_PUSH_PTR(port->id.phys_id),
+		    DLB2_CHP_HIST_LIST_PUSH_PTR_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_INT_DEPTH_THRSH(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ_INT_DEPTH_THRSH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_TMR_THRSH(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ_TMR_THRSH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_INT_ENB(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ_INT_ENB_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_CQ_ISR(port->id.phys_id),
+		    DLB2_SYS_LDB_CQ_ISR_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_LDB_TKN_DEPTH_SEL(port->id.phys_id),
+		    DLB2_LSP_CQ_LDB_TKN_DEPTH_SEL_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_TKN_DEPTH_SEL(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ_TKN_DEPTH_SEL_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_WPTR(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ_WPTR_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_LDB_TKN_CNT(port->id.phys_id),
+		    DLB2_LSP_CQ_LDB_TKN_CNT_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_CQ_ADDR_L(port->id.phys_id),
+		    DLB2_SYS_LDB_CQ_ADDR_L_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_CQ_ADDR_U(port->id.phys_id),
+		    DLB2_SYS_LDB_CQ_ADDR_U_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_CQ_AT(port->id.phys_id),
+		    DLB2_SYS_LDB_CQ_AT_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_CQ_PASID(port->id.phys_id),
+		    DLB2_SYS_LDB_CQ_PASID_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_CQ2VF_PF_RO(port->id.phys_id),
+		    DLB2_SYS_LDB_CQ2VF_PF_RO_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_LDB_TOT_SCH_CNTL(port->id.phys_id),
+		    DLB2_LSP_CQ_LDB_TOT_SCH_CNTL_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_LDB_TOT_SCH_CNTH(port->id.phys_id),
+		    DLB2_LSP_CQ_LDB_TOT_SCH_CNTH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ2QID0(port->id.phys_id),
+		    DLB2_LSP_CQ2QID0_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ2QID1(port->id.phys_id),
+		    DLB2_LSP_CQ2QID1_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ2PRIOV(port->id.phys_id),
+		    DLB2_LSP_CQ2PRIOV_RST);
+}
+
+static void dlb2_domain_reset_ldb_port_registers(struct dlb2_hw *hw,
+						 struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_port *port;
+	int i;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port)
+			__dlb2_domain_reset_ldb_port_registers(hw, port);
+	}
+}
+
+static void
+__dlb2_domain_reset_dir_port_registers(struct dlb2_hw *hw,
+				       struct dlb2_dir_pq_pair *port)
+{
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ2VAS(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ2VAS_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_DIR_DSBL(port->id.phys_id),
+		    DLB2_LSP_CQ_DIR_DSBL_RST);
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ_OPT_CLR, port->id.phys_id);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_DEPTH(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ_DEPTH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_INT_DEPTH_THRSH(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ_INT_DEPTH_THRSH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_TMR_THRSH(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ_TMR_THRSH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_INT_ENB(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ_INT_ENB_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ_ISR(port->id.phys_id),
+		    DLB2_SYS_DIR_CQ_ISR_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_DIR_TKN_DEPTH_SEL_DSI(port->id.phys_id),
+		    DLB2_LSP_CQ_DIR_TKN_DEPTH_SEL_DSI_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_TKN_DEPTH_SEL(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ_TKN_DEPTH_SEL_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_WPTR(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ_WPTR_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_DIR_TKN_CNT(port->id.phys_id),
+		    DLB2_LSP_CQ_DIR_TKN_CNT_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ_ADDR_L(port->id.phys_id),
+		    DLB2_SYS_DIR_CQ_ADDR_L_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ_ADDR_U(port->id.phys_id),
+		    DLB2_SYS_DIR_CQ_ADDR_U_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ_AT(port->id.phys_id),
+		    DLB2_SYS_DIR_CQ_AT_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ_PASID(port->id.phys_id),
+		    DLB2_SYS_DIR_CQ_PASID_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ_FMT(port->id.phys_id),
+		    DLB2_SYS_DIR_CQ_FMT_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ2VF_PF_RO(port->id.phys_id),
+		    DLB2_SYS_DIR_CQ2VF_PF_RO_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_DIR_TOT_SCH_CNTL(port->id.phys_id),
+		    DLB2_LSP_CQ_DIR_TOT_SCH_CNTL_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_DIR_TOT_SCH_CNTH(port->id.phys_id),
+		    DLB2_LSP_CQ_DIR_TOT_SCH_CNTH_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_PP2VAS(port->id.phys_id),
+		    DLB2_SYS_DIR_PP2VAS_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ2VAS(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ2VAS_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_PP2VDEV(port->id.phys_id),
+		    DLB2_SYS_DIR_PP2VDEV_RST);
+
+	if (port->id.vdev_owned) {
+		unsigned int offs;
+		u32 virt_id;
+
+		/*
+		 * DLB uses producer port address bits 17:12 to determine the
+		 * producer port ID. In Scalable IOV mode, PP accesses come
+		 * through the PF MMIO window for the physical producer port,
+		 * so for translation purposes the virtual and physical port
+		 * IDs are equal.
+		 */
+		if (hw->virt_mode == DLB2_VIRT_SRIOV)
+			virt_id = port->id.virt_id;
+		else
+			virt_id = port->id.phys_id;
+
+		offs = port->id.vdev_id * DLB2_MAX_NUM_DIR_PORTS + virt_id;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_VF_DIR_VPP2PP(offs),
+			    DLB2_SYS_VF_DIR_VPP2PP_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_VF_DIR_VPP_V(offs),
+			    DLB2_SYS_VF_DIR_VPP_V_RST);
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_PP_V(port->id.phys_id),
+		    DLB2_SYS_DIR_PP_V_RST);
+}
+
+static void dlb2_domain_reset_dir_port_registers(struct dlb2_hw *hw,
+						 struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *port;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port)
+		__dlb2_domain_reset_dir_port_registers(hw, port);
+}
+
+static void dlb2_domain_reset_ldb_queue_registers(struct dlb2_hw *hw,
+						  struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_queue *queue;
+
+	DLB2_DOM_LIST_FOR(domain->used_ldb_queues, queue) {
+		unsigned int queue_id = queue->id.phys_id;
+		int i;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_NALDB_TOT_ENQ_CNTL(queue_id),
+			    DLB2_LSP_QID_NALDB_TOT_ENQ_CNTL_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_NALDB_TOT_ENQ_CNTH(queue_id),
+			    DLB2_LSP_QID_NALDB_TOT_ENQ_CNTH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_ATM_TOT_ENQ_CNTL(queue_id),
+			    DLB2_LSP_QID_ATM_TOT_ENQ_CNTL_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_ATM_TOT_ENQ_CNTH(queue_id),
+			    DLB2_LSP_QID_ATM_TOT_ENQ_CNTH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_NALDB_MAX_DEPTH(queue_id),
+			    DLB2_LSP_QID_NALDB_MAX_DEPTH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_LDB_INFL_LIM(queue_id),
+			    DLB2_LSP_QID_LDB_INFL_LIM_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_AQED_ACTIVE_LIM(queue_id),
+			    DLB2_LSP_QID_AQED_ACTIVE_LIM_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_ATM_DEPTH_THRSH(queue_id),
+			    DLB2_LSP_QID_ATM_DEPTH_THRSH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_NALDB_DEPTH_THRSH(queue_id),
+			    DLB2_LSP_QID_NALDB_DEPTH_THRSH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_QID_ITS(queue_id),
+			    DLB2_SYS_LDB_QID_ITS_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_CHP_ORD_QID_SN(queue_id),
+			    DLB2_CHP_ORD_QID_SN_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_CHP_ORD_QID_SN_MAP(queue_id),
+			    DLB2_CHP_ORD_QID_SN_MAP_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_QID_V(queue_id),
+			    DLB2_SYS_LDB_QID_V_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_QID_CFG_V(queue_id),
+			    DLB2_SYS_LDB_QID_CFG_V_RST);
+
+		if (queue->sn_cfg_valid) {
+			u32 offs[2];
+
+			offs[0] = DLB2_RO_PIPE_GRP_0_SLT_SHFT(queue->sn_slot);
+			offs[1] = DLB2_RO_PIPE_GRP_1_SLT_SHFT(queue->sn_slot);
+
+			DLB2_CSR_WR(hw,
+				    offs[queue->sn_group],
+				    DLB2_RO_PIPE_GRP_0_SLT_SHFT_RST);
+		}
+
+		for (i = 0; i < DLB2_LSP_QID2CQIDIX_NUM; i++) {
+			DLB2_CSR_WR(hw,
+				    DLB2_LSP_QID2CQIDIX(queue_id, i),
+				    DLB2_LSP_QID2CQIDIX_00_RST);
+
+			DLB2_CSR_WR(hw,
+				    DLB2_LSP_QID2CQIDIX2(queue_id, i),
+				    DLB2_LSP_QID2CQIDIX2_00_RST);
+
+			DLB2_CSR_WR(hw,
+				    DLB2_ATM_QID2CQIDIX(queue_id, i),
+				    DLB2_ATM_QID2CQIDIX_00_RST);
+		}
+	}
+}
+
+static void dlb2_domain_reset_dir_queue_registers(struct dlb2_hw *hw,
+						  struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *queue;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, queue) {
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_DIR_MAX_DEPTH(queue->id.phys_id),
+			    DLB2_LSP_QID_DIR_MAX_DEPTH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_DIR_TOT_ENQ_CNTL(queue->id.phys_id),
+			    DLB2_LSP_QID_DIR_TOT_ENQ_CNTL_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_DIR_TOT_ENQ_CNTH(queue->id.phys_id),
+			    DLB2_LSP_QID_DIR_TOT_ENQ_CNTH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_QID_DIR_DEPTH_THRSH(queue->id.phys_id),
+			    DLB2_LSP_QID_DIR_DEPTH_THRSH_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_QID_ITS(queue->id.phys_id),
+			    DLB2_SYS_DIR_QID_ITS_RST);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_QID_V(queue->id.phys_id),
+			    DLB2_SYS_DIR_QID_V_RST);
+	}
+}
+
+static u32 dlb2_dir_cq_token_count(struct dlb2_hw *hw,
+				   struct dlb2_dir_pq_pair *port)
+{
+	union dlb2_lsp_cq_dir_tkn_cnt r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ_DIR_TKN_CNT(port->id.phys_id));
+
+	/*
+	 * Account for the initial token count, which is used in order to
+	 * provide a CQ with depth less than 8.
+	 */
+
+	return r0.field.count - port->init_tkn_cnt;
+}
+
+static int dlb2_domain_verify_reset_success(struct dlb2_hw *hw,
+					    struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *dir_port;
+	struct dlb2_ldb_port *ldb_port;
+	struct dlb2_ldb_queue *queue;
+	int i;
+
+	/*
+	 * Confirm that all the domain's queue's inflight counts and AQED
+	 * active counts are 0.
+	 */
+	DLB2_DOM_LIST_FOR(domain->used_ldb_queues, queue) {
+		if (!dlb2_ldb_queue_is_empty(hw, queue)) {
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: failed to empty ldb queue %d\n",
+				    __func__, queue->id.phys_id);
+			return -EFAULT;
+		}
+	}
+
+	/* Confirm that all the domain's CQs inflight and token counts are 0. */
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], ldb_port) {
+			if (dlb2_ldb_cq_inflight_count(hw, ldb_port) ||
+			    dlb2_ldb_cq_token_count(hw, ldb_port)) {
+				DLB2_HW_ERR(hw,
+					    "[%s()] Internal error: failed to empty ldb port %d\n",
+					    __func__, ldb_port->id.phys_id);
+				return -EFAULT;
+			}
+		}
+	}
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, dir_port) {
+		if (!dlb2_dir_queue_is_empty(hw, dir_port)) {
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: failed to empty dir queue %d\n",
+				    __func__, dir_port->id.phys_id);
+			return -EFAULT;
+		}
+
+		if (dlb2_dir_cq_token_count(hw, dir_port)) {
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: failed to empty dir port %d\n",
+				    __func__, dir_port->id.phys_id);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static void dlb2_domain_reset_registers(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain)
+{
+	dlb2_domain_reset_ldb_port_registers(hw, domain);
+
+	dlb2_domain_reset_dir_port_registers(hw, domain);
+
+	dlb2_domain_reset_ldb_queue_registers(hw, domain);
+
+	dlb2_domain_reset_dir_queue_registers(hw, domain);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_CFG_LDB_VAS_CRD(domain->id.phys_id),
+		    DLB2_CHP_CFG_LDB_VAS_CRD_RST);
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_CFG_DIR_VAS_CRD(domain->id.phys_id),
+		    DLB2_CHP_CFG_DIR_VAS_CRD_RST);
+}
+
+static int dlb2_domain_drain_ldb_cqs(struct dlb2_hw *hw,
+				     struct dlb2_hw_domain *domain,
+				     bool toggle_port)
+{
+	struct dlb2_ldb_port *port;
+	int ret, i;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			if (toggle_port)
+				dlb2_ldb_port_cq_disable(hw, port);
+
+			ret = dlb2_drain_ldb_cq(hw, port);
+			if (ret < 0)
+				return ret;
+
+			if (toggle_port)
+				dlb2_ldb_port_cq_enable(hw, port);
+		}
+	}
+
+	return 0;
+}
+
+static bool dlb2_domain_mapped_queues_empty(struct dlb2_hw *hw,
+					    struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_queue *queue;
+
+	DLB2_DOM_LIST_FOR(domain->used_ldb_queues, queue) {
+		if (queue->num_mappings == 0)
+			continue;
+
+		if (!dlb2_ldb_queue_is_empty(hw, queue))
+			return false;
+	}
+
+	return true;
+}
+
+static int dlb2_domain_drain_mapped_queues(struct dlb2_hw *hw,
+					   struct dlb2_hw_domain *domain)
+{
+	int i, ret;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return 0;
+
+	if (domain->num_pending_removals > 0) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: failed to unmap domain queues\n",
+			    __func__);
+		return -EFAULT;
+	}
+
+	for (i = 0; i < DLB2_MAX_QID_EMPTY_CHECK_LOOPS; i++) {
+		ret = dlb2_domain_drain_ldb_cqs(hw, domain, true);
+		if (ret < 0)
+			return ret;
+
+		if (dlb2_domain_mapped_queues_empty(hw, domain))
+			break;
+	}
+
+	if (i == DLB2_MAX_QID_EMPTY_CHECK_LOOPS) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: failed to empty queues\n",
+			    __func__);
+		return -EFAULT;
+	}
+
+	/*
+	 * Drain the CQs one more time. For the queues to go empty, they would
+	 * have scheduled one or more QEs.
+	 */
+	ret = dlb2_domain_drain_ldb_cqs(hw, domain, true);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int dlb2_domain_drain_unmapped_queue(struct dlb2_hw *hw,
+					    struct dlb2_hw_domain *domain,
+					    struct dlb2_ldb_queue *queue)
+{
+	struct dlb2_ldb_port *port;
+	int ret, i;
+
+	/* If a domain has LDB queues, it must have LDB ports */
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		if (!list_empty(&domain->used_ldb_ports[i]))
+			break;
+	}
+
+	if (i == DLB2_NUM_COS_DOMAINS) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: No configured LDB ports\n",
+			    __func__);
+		return -EFAULT;
+	}
+
+	port = DLB2_DOM_LIST_HEAD(domain->used_ldb_ports[i], typeof(*port));
+
+	/* If necessary, free up a QID slot in this CQ */
+	if (port->num_mappings == DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+		struct dlb2_ldb_queue *mapped_queue;
+
+		mapped_queue = &hw->rsrcs.ldb_queues[port->qid_map[0].qid];
+
+		ret = dlb2_ldb_port_unmap_qid(hw, port, mapped_queue);
+		if (ret)
+			return ret;
+	}
+
+	ret = dlb2_ldb_port_map_qid_dynamic(hw, port, queue, 0);
+	if (ret)
+		return ret;
+
+	return dlb2_domain_drain_mapped_queues(hw, domain);
+}
+
+static int dlb2_domain_drain_unmapped_queues(struct dlb2_hw *hw,
+					     struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_queue *queue;
+	int ret;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return 0;
+
+	/*
+	 * Pre-condition: the unattached queue must not have any outstanding
+	 * completions. This is ensured by calling dlb2_domain_drain_ldb_cqs()
+	 * prior to this in dlb2_domain_drain_mapped_queues().
+	 */
+	DLB2_DOM_LIST_FOR(domain->used_ldb_queues, queue) {
+		if (queue->num_mappings != 0 ||
+		    dlb2_ldb_queue_is_empty(hw, queue))
+			continue;
+
+		ret = dlb2_domain_drain_unmapped_queue(hw, domain, queue);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int dlb2_drain_dir_cq(struct dlb2_hw *hw,
+			     struct dlb2_dir_pq_pair *port)
+{
+	unsigned int port_id = port->id.phys_id;
+	u32 cnt;
+
+	/* Return any outstanding tokens */
+	cnt = dlb2_dir_cq_token_count(hw, port);
+
+	if (cnt != 0) {
+		struct dlb2_hcw hcw_mem[8], *hcw;
+		void __iomem *pp_addr;
+
+		pp_addr = dlb2_producer_port_addr(hw, port_id, false);
+
+		/* Point hcw to a 64B-aligned location */
+		hcw = (struct dlb2_hcw *)((uintptr_t)&hcw_mem[4] & ~0x3F);
+
+		/*
+		 * Program the first HCW for a batch token return and
+		 * the rest as NOOPS
+		 */
+		memset(hcw, 0, 4 * sizeof(*hcw));
+		hcw->cq_token = 1;
+		hcw->lock_id = cnt - 1;
+
+		iosubmit_cmds512(pp_addr, hcw, 1);
+
+		dlb2_fence_hcw(pp_addr);
+	}
+
+	return 0;
+}
+
+static int dlb2_domain_drain_dir_cqs(struct dlb2_hw *hw,
+				     struct dlb2_hw_domain *domain,
+				     bool toggle_port)
+{
+	struct dlb2_dir_pq_pair *port;
+	int ret;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port) {
+		/*
+		 * Can't drain a port if it's not configured, and there's
+		 * nothing to drain if its queue is unconfigured.
+		 */
+		if (!port->port_configured || !port->queue_configured)
+			continue;
+
+		if (toggle_port)
+			dlb2_dir_port_cq_disable(hw, port);
+
+		ret = dlb2_drain_dir_cq(hw, port);
+		if (ret < 0)
+			return ret;
+
+		if (toggle_port)
+			dlb2_dir_port_cq_enable(hw, port);
+	}
+
+	return 0;
+}
+
+static bool dlb2_domain_dir_queues_empty(struct dlb2_hw *hw,
+					 struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *queue;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, queue) {
+		if (!dlb2_dir_queue_is_empty(hw, queue))
+			return false;
+	}
+
+	return true;
+}
+
+static int dlb2_domain_drain_dir_queues(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain)
+{
+	int i, ret;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return 0;
+
+	for (i = 0; i < DLB2_MAX_QID_EMPTY_CHECK_LOOPS; i++) {
+		ret = dlb2_domain_drain_dir_cqs(hw, domain, true);
+		if (ret < 0)
+			return ret;
+
+		if (dlb2_domain_dir_queues_empty(hw, domain))
+			break;
+	}
+
+	if (i == DLB2_MAX_QID_EMPTY_CHECK_LOOPS) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: failed to empty queues\n",
+			    __func__);
+		return -EFAULT;
+	}
+
+	/*
+	 * Drain the CQs one more time. For the queues to go empty, they would
+	 * have scheduled one or more QEs.
+	 */
+	ret = dlb2_domain_drain_dir_cqs(hw, domain, true);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void
+dlb2_domain_disable_dir_producer_ports(struct dlb2_hw *hw,
+				       struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *port;
+	union dlb2_sys_dir_pp_v r1;
+
+	r1.field.pp_v = 0;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port)
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_PP_V(port->id.phys_id),
+			    r1.val);
+}
+
+static void
+dlb2_domain_disable_ldb_producer_ports(struct dlb2_hw *hw,
+				       struct dlb2_hw_domain *domain)
+{
+	union dlb2_sys_ldb_pp_v r1;
+	struct dlb2_ldb_port *port;
+	int i;
+
+	r1.field.pp_v = 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port)
+			DLB2_CSR_WR(hw,
+				    DLB2_SYS_LDB_PP_V(port->id.phys_id),
+				    r1.val);
+	}
+}
+
+static void dlb2_domain_disable_dir_vpps(struct dlb2_hw *hw,
+					 struct dlb2_hw_domain *domain,
+					 unsigned int vdev_id)
+{
+	union dlb2_sys_vf_dir_vpp_v r1;
+	struct dlb2_dir_pq_pair *port;
+
+	r1.field.vpp_v = 0;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port) {
+		unsigned int offs;
+		u32 virt_id;
+
+		if (hw->virt_mode == DLB2_VIRT_SRIOV)
+			virt_id = port->id.virt_id;
+		else
+			virt_id = port->id.phys_id;
+
+		offs = vdev_id * DLB2_MAX_NUM_DIR_PORTS + virt_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_DIR_VPP_V(offs), r1.val);
+	}
+}
+
+static void dlb2_domain_disable_ldb_vpps(struct dlb2_hw *hw,
+					 struct dlb2_hw_domain *domain,
+					 unsigned int vdev_id)
+{
+	union dlb2_sys_vf_ldb_vpp_v r1;
+	struct dlb2_ldb_port *port;
+	int i;
+
+	r1.field.vpp_v = 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			unsigned int offs;
+			u32 virt_id;
+
+			if (hw->virt_mode == DLB2_VIRT_SRIOV)
+				virt_id = port->id.virt_id;
+			else
+				virt_id = port->id.phys_id;
+
+			offs = vdev_id * DLB2_MAX_NUM_LDB_PORTS + virt_id;
+
+			DLB2_CSR_WR(hw, DLB2_SYS_VF_LDB_VPP_V(offs), r1.val);
+		}
+	}
+}
+
+static void dlb2_domain_disable_ldb_seq_checks(struct dlb2_hw *hw,
+					       struct dlb2_hw_domain *domain)
+{
+	union dlb2_chp_sn_chk_enbl r1;
+	struct dlb2_ldb_port *port;
+	int i;
+
+	r1.field.en = 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port)
+			DLB2_CSR_WR(hw,
+				    DLB2_CHP_SN_CHK_ENBL(port->id.phys_id),
+				    r1.val);
+	}
+}
+
+static void
+dlb2_domain_disable_ldb_port_interrupts(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain)
+{
+	union dlb2_chp_ldb_cq_int_enb r0 = { {0} };
+	union dlb2_chp_ldb_cq_wd_enb r1 = { {0} };
+	struct dlb2_ldb_port *port;
+	int i;
+
+	r0.field.en_tim = 0;
+	r0.field.en_depth = 0;
+
+	r1.field.wd_enable = 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			DLB2_CSR_WR(hw,
+				    DLB2_CHP_LDB_CQ_INT_ENB(port->id.phys_id),
+				    r0.val);
+
+			DLB2_CSR_WR(hw,
+				    DLB2_CHP_LDB_CQ_WD_ENB(port->id.phys_id),
+				    r1.val);
+		}
+	}
+}
+
+static void
+dlb2_domain_disable_dir_port_interrupts(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain)
+{
+	union dlb2_chp_dir_cq_int_enb r0 = { {0} };
+	union dlb2_chp_dir_cq_wd_enb r1 = { {0} };
+	struct dlb2_dir_pq_pair *port;
+
+	r0.field.en_tim = 0;
+	r0.field.en_depth = 0;
+
+	r1.field.wd_enable = 0;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port) {
+		DLB2_CSR_WR(hw,
+			    DLB2_CHP_DIR_CQ_INT_ENB(port->id.phys_id),
+			    r0.val);
+
+		DLB2_CSR_WR(hw,
+			    DLB2_CHP_DIR_CQ_WD_ENB(port->id.phys_id),
+			    r1.val);
+	}
+}
+
+static void
+dlb2_domain_disable_ldb_queue_write_perms(struct dlb2_hw *hw,
+					  struct dlb2_hw_domain *domain)
+{
+	int domain_offset = domain->id.phys_id * DLB2_MAX_NUM_LDB_QUEUES;
+	struct dlb2_ldb_queue *queue;
+
+	DLB2_DOM_LIST_FOR(domain->used_ldb_queues, queue) {
+		union dlb2_sys_ldb_vasqid_v r0 = { {0} };
+		union dlb2_sys_ldb_qid2vqid r1 = { {0} };
+		union dlb2_sys_vf_ldb_vqid_v r2 = { {0} };
+		union dlb2_sys_vf_ldb_vqid2qid r3 = { {0} };
+		int idx;
+
+		idx = domain_offset + queue->id.phys_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_LDB_VASQID_V(idx), r0.val);
+
+		if (queue->id.vdev_owned) {
+			DLB2_CSR_WR(hw,
+				    DLB2_SYS_LDB_QID2VQID(queue->id.phys_id),
+				    r1.val);
+
+			idx = queue->id.vdev_id * DLB2_MAX_NUM_LDB_QUEUES +
+				queue->id.virt_id;
+
+			DLB2_CSR_WR(hw,
+				    DLB2_SYS_VF_LDB_VQID_V(idx),
+				    r2.val);
+
+			DLB2_CSR_WR(hw,
+				    DLB2_SYS_VF_LDB_VQID2QID(idx),
+				    r3.val);
+		}
+	}
+}
+
+static void
+dlb2_domain_disable_dir_queue_write_perms(struct dlb2_hw *hw,
+					  struct dlb2_hw_domain *domain)
+{
+	int domain_offset = domain->id.phys_id * DLB2_MAX_NUM_DIR_PORTS;
+	struct dlb2_dir_pq_pair *queue;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, queue) {
+		union dlb2_sys_dir_vasqid_v r0 = { {0} };
+		union dlb2_sys_vf_dir_vqid_v r1 = { {0} };
+		union dlb2_sys_vf_dir_vqid2qid r2 = { {0} };
+		int idx;
+
+		idx = domain_offset + queue->id.phys_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_DIR_VASQID_V(idx), r0.val);
+
+		if (queue->id.vdev_owned) {
+			idx = queue->id.vdev_id * DLB2_MAX_NUM_DIR_PORTS +
+				queue->id.virt_id;
+
+			DLB2_CSR_WR(hw,
+				    DLB2_SYS_VF_DIR_VQID_V(idx),
+				    r1.val);
+
+			DLB2_CSR_WR(hw,
+				    DLB2_SYS_VF_DIR_VQID2QID(idx),
+				    r2.val);
+		}
+	}
+}
+
+static void dlb2_domain_disable_dir_cqs(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain)
+{
+	struct dlb2_dir_pq_pair *port;
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port) {
+		port->enabled = false;
+
+		dlb2_dir_port_cq_disable(hw, port);
+	}
+}
+
+static void dlb2_domain_disable_ldb_cqs(struct dlb2_hw *hw,
+					struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_port *port;
+	int i;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			port->enabled = false;
+
+			dlb2_ldb_port_cq_disable(hw, port);
+		}
+	}
+}
+
+static void dlb2_domain_enable_ldb_cqs(struct dlb2_hw *hw,
+				       struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_port *port;
+	int i;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port) {
+			port->enabled = true;
+
+			dlb2_ldb_port_cq_enable(hw, port);
+		}
+	}
+}
+
+static void dlb2_log_reset_domain(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 reset domain:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+}
+
+/**
+ * dlb2_reset_domain() - Reset a DLB scheduling domain and its associated
+ *	hardware resources.
+ * @hw:	Contains the current state of the DLB2 hardware.
+ * @domain_id: Domain ID
+ * @vdev_req: Request came from a virtual device.
+ * @vdev_id: If vdev_req is true, this contains the virtual device's ID.
+ *
+ * Note: User software *must* stop sending to this domain's producer ports
+ * before invoking this function, otherwise undefined behavior will result.
+ *
+ * Return: returns < 0 on error, 0 otherwise.
+ */
+int dlb2_reset_domain(struct dlb2_hw *hw,
+		      u32 domain_id,
+		      bool vdev_req,
+		      unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	int ret;
+
+	dlb2_log_reset_domain(hw, domain_id, vdev_req, vdev_id);
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain || !domain->configured)
+		return -EINVAL;
+
+	/* Disable VPPs */
+	if (vdev_req) {
+		dlb2_domain_disable_dir_vpps(hw, domain, vdev_id);
+
+		dlb2_domain_disable_ldb_vpps(hw, domain, vdev_id);
+	}
+
+	/* Disable CQ interrupts */
+	dlb2_domain_disable_dir_port_interrupts(hw, domain);
+
+	dlb2_domain_disable_ldb_port_interrupts(hw, domain);
+
+	/*
+	 * For each queue owned by this domain, disable its write permissions to
+	 * cause any traffic sent to it to be dropped. Well-behaved software
+	 * should not be sending QEs at this point.
+	 */
+	dlb2_domain_disable_dir_queue_write_perms(hw, domain);
+
+	dlb2_domain_disable_ldb_queue_write_perms(hw, domain);
+
+	/* Turn off completion tracking on all the domain's PPs. */
+	dlb2_domain_disable_ldb_seq_checks(hw, domain);
+
+	/*
+	 * Disable the LDB CQs and drain them in order to complete the map and
+	 * unmap procedures, which require zero CQ inflights and zero QID
+	 * inflights respectively.
+	 */
+	dlb2_domain_disable_ldb_cqs(hw, domain);
+
+	ret = dlb2_domain_drain_ldb_cqs(hw, domain, false);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_domain_wait_for_ldb_cqs_to_empty(hw, domain);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_domain_finish_unmap_qid_procedures(hw, domain);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_domain_finish_map_qid_procedures(hw, domain);
+	if (ret < 0)
+		return ret;
+
+	/* Re-enable the CQs in order to drain the mapped queues. */
+	dlb2_domain_enable_ldb_cqs(hw, domain);
+
+	ret = dlb2_domain_drain_mapped_queues(hw, domain);
+	if (ret < 0)
+		return ret;
+
+	ret = dlb2_domain_drain_unmapped_queues(hw, domain);
+	if (ret < 0)
+		return ret;
+
+	/* Done draining LDB QEs, so disable the CQs. */
+	dlb2_domain_disable_ldb_cqs(hw, domain);
+
+	dlb2_domain_drain_dir_queues(hw, domain);
+
+	/* Done draining DIR QEs, so disable the CQs. */
+	dlb2_domain_disable_dir_cqs(hw, domain);
+
+	/* Disable PPs */
+	dlb2_domain_disable_dir_producer_ports(hw, domain);
+
+	dlb2_domain_disable_ldb_producer_ports(hw, domain);
+
+	ret = dlb2_domain_verify_reset_success(hw, domain);
+	if (ret)
+		return ret;
+
+	/* Reset the QID and port state. */
+	dlb2_domain_reset_registers(hw, domain);
+
+	/* Hardware reset complete. Reset the domain's software state */
+	ret = dlb2_domain_reset_software_state(hw, domain);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 int dlb2_hw_get_num_resources(struct dlb2_hw *hw,
 			      struct dlb2_get_num_resources_args *arg,
 			      bool vdev_req,
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index b23676df22a6..7dc50865681b 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -7,6 +7,8 @@
 
 #include <linux/types.h>
 
+#include <uapi/linux/dlb2_user.h>
+
 #include "dlb2_hw_types.h"
 
 /**
@@ -35,6 +37,69 @@ int dlb2_resource_init(struct dlb2_hw *hw);
 void dlb2_resource_free(struct dlb2_hw *hw);
 
 /**
+ * dlb2_hw_create_sched_domain() - create a scheduling domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @args: scheduling domain creation arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function creates a scheduling domain containing the resources specified
+ * in args. The individual resources (queues, ports, credits) can be configured
+ * after creating a scheduling domain.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the domain ID.
+ *
+ * resp->id contains a virtual ID if vdev_request is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, or the requested domain name
+ *	    is already in use.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_create_sched_domain(struct dlb2_hw *hw,
+				struct dlb2_create_sched_domain_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vdev_request,
+				unsigned int vdev_id);
+
+/**
+ * dlb2_reset_domain() - reset a scheduling domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function resets and frees a DLB 2.0 scheduling domain and its associated
+ * resources.
+ *
+ * Pre-condition: the driver must ensure software has stopped sending QEs
+ * through this domain's producer ports before invoking this function, or
+ * undefined behavior will result.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, -1 otherwise.
+ *
+ * EINVAL - Invalid domain ID, or the domain is not configured.
+ * EFAULT - Internal error. (Possibly caused if software is the pre-condition
+ *	    is not met.)
+ * ETIMEDOUT - Hardware component didn't reset in the expected time.
+ */
+int dlb2_reset_domain(struct dlb2_hw *hw,
+		      u32 domain_id,
+		      bool vdev_request,
+		      unsigned int vdev_id);
+
+/**
  * dlb2_hw_get_num_resources() - query the PCI function's available resources
  * @hw: dlb2_hw handle for a particular device.
  * @arg: pointer to resource counts.
@@ -65,4 +130,13 @@ int dlb2_hw_get_num_resources(struct dlb2_hw *hw,
  */
 void dlb2_clr_pmcsr_disable(struct dlb2_hw *hw);
 
+enum dlb2_virt_mode {
+	DLB2_VIRT_NONE,
+	DLB2_VIRT_SRIOV,
+	DLB2_VIRT_SIOV,
+
+	/* NUM_DLB2_VIRT_MODES must be last */
+	NUM_DLB2_VIRT_MODES,
+};
+
 #endif /* __DLB2_RESOURCE_H */
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 49a8a39f79a2..02d380b51c2c 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -7,6 +7,92 @@
 
 #include <linux/types.h>
 
+enum dlb2_error {
+	DLB2_ST_SUCCESS = 0,
+	DLB2_ST_NAME_EXISTS,
+	DLB2_ST_DOMAIN_UNAVAILABLE,
+	DLB2_ST_LDB_PORTS_UNAVAILABLE,
+	DLB2_ST_DIR_PORTS_UNAVAILABLE,
+	DLB2_ST_LDB_QUEUES_UNAVAILABLE,
+	DLB2_ST_LDB_CREDITS_UNAVAILABLE,
+	DLB2_ST_DIR_CREDITS_UNAVAILABLE,
+	DLB2_ST_SEQUENCE_NUMBERS_UNAVAILABLE,
+	DLB2_ST_INVALID_DOMAIN_ID,
+	DLB2_ST_INVALID_QID_INFLIGHT_ALLOCATION,
+	DLB2_ST_ATOMIC_INFLIGHTS_UNAVAILABLE,
+	DLB2_ST_HIST_LIST_ENTRIES_UNAVAILABLE,
+	DLB2_ST_INVALID_LDB_QUEUE_ID,
+	DLB2_ST_INVALID_CQ_DEPTH,
+	DLB2_ST_INVALID_CQ_VIRT_ADDR,
+	DLB2_ST_INVALID_PORT_ID,
+	DLB2_ST_INVALID_QID,
+	DLB2_ST_INVALID_PRIORITY,
+	DLB2_ST_NO_QID_SLOTS_AVAILABLE,
+	DLB2_ST_INVALID_DIR_QUEUE_ID,
+	DLB2_ST_DIR_QUEUES_UNAVAILABLE,
+	DLB2_ST_DOMAIN_NOT_CONFIGURED,
+	DLB2_ST_INTERNAL_ERROR,
+	DLB2_ST_DOMAIN_IN_USE,
+	DLB2_ST_DOMAIN_NOT_FOUND,
+	DLB2_ST_QUEUE_NOT_FOUND,
+	DLB2_ST_DOMAIN_STARTED,
+	DLB2_ST_DOMAIN_NOT_STARTED,
+	DLB2_ST_LDB_PORT_REQUIRED_FOR_LDB_QUEUES,
+	DLB2_ST_DOMAIN_RESET_FAILED,
+	DLB2_ST_MBOX_ERROR,
+	DLB2_ST_INVALID_HIST_LIST_DEPTH,
+	DLB2_ST_NO_MEMORY,
+	DLB2_ST_INVALID_LOCK_ID_COMP_LEVEL,
+	DLB2_ST_INVALID_COS_ID,
+	DLB2_ST_INVALID_SMON_ID,
+	DLB2_ST_INVALID_SMON_MODE,
+	DLB2_ST_INVALID_SMON_COMP_MODE,
+	DLB2_ST_INVALID_SMON_CAP_MODE,
+};
+
+static const char dlb2_error_strings[][128] = {
+	"DLB2_ST_SUCCESS",
+	"DLB2_ST_NAME_EXISTS",
+	"DLB2_ST_DOMAIN_UNAVAILABLE",
+	"DLB2_ST_LDB_PORTS_UNAVAILABLE",
+	"DLB2_ST_DIR_PORTS_UNAVAILABLE",
+	"DLB2_ST_LDB_QUEUES_UNAVAILABLE",
+	"DLB2_ST_LDB_CREDITS_UNAVAILABLE",
+	"DLB2_ST_DIR_CREDITS_UNAVAILABLE",
+	"DLB2_ST_SEQUENCE_NUMBERS_UNAVAILABLE",
+	"DLB2_ST_INVALID_DOMAIN_ID",
+	"DLB2_ST_INVALID_QID_INFLIGHT_ALLOCATION",
+	"DLB2_ST_ATOMIC_INFLIGHTS_UNAVAILABLE",
+	"DLB2_ST_HIST_LIST_ENTRIES_UNAVAILABLE",
+	"DLB2_ST_INVALID_LDB_QUEUE_ID",
+	"DLB2_ST_INVALID_CQ_DEPTH",
+	"DLB2_ST_INVALID_CQ_VIRT_ADDR",
+	"DLB2_ST_INVALID_PORT_ID",
+	"DLB2_ST_INVALID_QID",
+	"DLB2_ST_INVALID_PRIORITY",
+	"DLB2_ST_NO_QID_SLOTS_AVAILABLE",
+	"DLB2_ST_INVALID_DIR_QUEUE_ID",
+	"DLB2_ST_DIR_QUEUES_UNAVAILABLE",
+	"DLB2_ST_DOMAIN_NOT_CONFIGURED",
+	"DLB2_ST_INTERNAL_ERROR",
+	"DLB2_ST_DOMAIN_IN_USE",
+	"DLB2_ST_DOMAIN_NOT_FOUND",
+	"DLB2_ST_QUEUE_NOT_FOUND",
+	"DLB2_ST_DOMAIN_STARTED",
+	"DLB2_ST_DOMAIN_NOT_STARTED",
+	"DLB2_ST_LDB_PORT_REQUIRED_FOR_LDB_QUEUES",
+	"DLB2_ST_DOMAIN_RESET_FAILED",
+	"DLB2_ST_MBOX_ERROR",
+	"DLB2_ST_INVALID_HIST_LIST_DEPTH",
+	"DLB2_ST_NO_MEMORY",
+	"DLB2_ST_INVALID_LOCK_ID_COMP_LEVEL",
+	"DLB2_ST_INVALID_COS_ID",
+	"DLB2_ST_INVALID_SMON_ID",
+	"DLB2_ST_INVALID_SMON_MODE",
+	"DLB2_ST_INVALID_SMON_COMP_MODE",
+	"DLB2_ST_INVALID_SMON_CAP_MODE",
+};
+
 struct dlb2_cmd_response {
 	__u32 status; /* Interpret using enum dlb2_error */
 	__u32 id;
-- 
2.13.6

