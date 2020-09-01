Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8C6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F6320767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbgIATWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:53433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731790AbgIATVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:52 -0400
IronPort-SDR: ZOdMzMW9XJHyFJJaY9GsD9bpKa+Ea47OyVoiliG+z929kS68dbxAFllDdGjmWNRZUP1tT5s95I
 ws0pmzmzxrFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807345"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807345"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:34 -0700
IronPort-SDR: nDwA71q3EH8Zodolv1+xszHXjT5dv9lEOnvnLaRbq5KOCrtJZRc8+/SR0r+GvXvpjn6Aa8Ah5V
 dJvJt5qmBniw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480505"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:34 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 15/19] dlb2: add sequence-number management ioctls
Date:   Tue,  1 Sep 2020 14:15:44 -0500
Message-Id: <20200901191548.31646-16-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for a load-balanced DLB 2.0 queue to support ordered scheduling,
it must be configured with an allocation of sequence numbers (SNs) -- a
hardware resource used to re-order QEs.

The device evenly partitions its SNs across two groups. A queue is
allocated SNs by taking a 'slot' in one of these two groups, and the
number of slots is variable. A group can support as many as 16 slots (64
SNs per slot) and as few as 1 slot (1024 SNs per slot).

This commit adds ioctls to get and set a sequence number group's slot
configuration, as well as query the group's slot occupancy.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    | 86 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h     |  3 ++
 drivers/misc/dlb2/dlb2_pf_ops.c   | 21 ++++++++++
 drivers/misc/dlb2/dlb2_resource.c | 67 ++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h | 47 +++++++++++++++++++++
 include/uapi/linux/dlb2_user.h    | 84 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 308 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 2350d8ff823e..3e5ca65f9feb 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -681,6 +681,86 @@ static int dlb2_ioctl_query_cq_poll_mode(struct dlb2_dev *dev,
 	return ret;
 }
 
+static int dlb2_ioctl_set_sn_allocation(struct dlb2_dev *dev,
+					unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_set_sn_allocation_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->set_sn_allocation(&dev->hw, arg.group, arg.num);
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
+static int dlb2_ioctl_get_sn_allocation(struct dlb2_dev *dev,
+					unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_get_sn_allocation_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->get_sn_allocation(&dev->hw, arg.group);
+
+	response.id = ret;
+
+	ret = (ret > 0) ? 0 : ret;
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
+static int dlb2_ioctl_get_sn_occupancy(struct dlb2_dev *dev,
+				       unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_get_sn_occupancy_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->get_sn_occupancy(&dev->hw, arg.group);
+
+	response.id = ret;
+
+	ret = (ret > 0) ? 0 : ret;
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
 long dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct dlb2_dev *dev;
@@ -696,6 +776,12 @@ long dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_ioctl_get_num_resources(dev, arg);
 	case DLB2_IOC_QUERY_CQ_POLL_MODE:
 		return dlb2_ioctl_query_cq_poll_mode(dev, arg);
+	case DLB2_IOC_SET_SN_ALLOCATION:
+		return dlb2_ioctl_set_sn_allocation(dev, arg);
+	case DLB2_IOC_GET_SN_ALLOCATION:
+		return dlb2_ioctl_get_sn_allocation(dev, arg);
+	case DLB2_IOC_GET_SN_OCCUPANCY:
+		return dlb2_ioctl_get_sn_occupancy(dev, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index c1ae4267ff19..a7be9399255f 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -135,6 +135,9 @@ struct dlb2_device_ops {
 	int (*dir_port_owned_by_domain)(struct dlb2_hw *hw,
 					u32 domain_id,
 					u32 port_id);
+	int (*get_sn_allocation)(struct dlb2_hw *hw, u32 group_id);
+	int (*set_sn_allocation)(struct dlb2_hw *hw, u32 group_id, u32 num);
+	int (*get_sn_occupancy)(struct dlb2_hw *hw, u32 group_id);
 	int (*get_ldb_queue_depth)(struct dlb2_hw *hw,
 				   u32 domain_id,
 				   struct dlb2_get_ldb_queue_depth_args *args,
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 23a1e9ba0226..337cc8a72a5c 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -604,6 +604,24 @@ dlb2_pf_dir_port_owned_by_domain(struct dlb2_hw *hw,
 	return dlb2_dir_port_owned_by_domain(hw, domain_id, port_id, false, 0);
 }
 
+static int
+dlb2_pf_get_sn_allocation(struct dlb2_hw *hw, u32 group_id)
+{
+	return dlb2_get_group_sequence_numbers(hw, group_id);
+}
+
+static int
+dlb2_pf_set_sn_allocation(struct dlb2_hw *hw, u32 group_id, u32 num)
+{
+	return dlb2_set_group_sequence_numbers(hw, group_id, num);
+}
+
+static int
+dlb2_pf_get_sn_occupancy(struct dlb2_hw *hw, u32 group_id)
+{
+	return dlb2_get_group_sequence_number_occupancy(hw, group_id);
+}
+
 /********************************/
 /****** DLB2 PF Device Ops ******/
 /********************************/
@@ -644,6 +662,9 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.reset_domain = dlb2_pf_reset_domain,
 	.ldb_port_owned_by_domain = dlb2_pf_ldb_port_owned_by_domain,
 	.dir_port_owned_by_domain = dlb2_pf_dir_port_owned_by_domain,
+	.get_sn_allocation = dlb2_pf_get_sn_allocation,
+	.set_sn_allocation = dlb2_pf_set_sn_allocation,
+	.get_sn_occupancy = dlb2_pf_get_sn_occupancy,
 	.get_ldb_queue_depth = dlb2_pf_get_ldb_queue_depth,
 	.get_dir_queue_depth = dlb2_pf_get_dir_queue_depth,
 	.init_hardware = dlb2_pf_init_hardware,
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index bfe20864515d..646f52a06842 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -4991,6 +4991,73 @@ void dlb2_ack_compressed_cq_intr(struct dlb2_hw *hw,
 	dlb2_ack_msix_interrupt(hw, DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID);
 }
 
+int dlb2_get_group_sequence_numbers(struct dlb2_hw *hw, unsigned int group_id)
+{
+	if (group_id >= DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS)
+		return -EINVAL;
+
+	return hw->rsrcs.sn_groups[group_id].sequence_numbers_per_queue;
+}
+
+int dlb2_get_group_sequence_number_occupancy(struct dlb2_hw *hw,
+					     unsigned int group_id)
+{
+	if (group_id >= DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS)
+		return -EINVAL;
+
+	return dlb2_sn_group_used_slots(&hw->rsrcs.sn_groups[group_id]);
+}
+
+static void dlb2_log_set_group_sequence_numbers(struct dlb2_hw *hw,
+						unsigned int group_id,
+						unsigned long val)
+{
+	DLB2_HW_DBG(hw, "DLB2 set group sequence numbers:\n");
+	DLB2_HW_DBG(hw, "\tGroup ID: %u\n", group_id);
+	DLB2_HW_DBG(hw, "\tValue:    %lu\n", val);
+}
+
+int dlb2_set_group_sequence_numbers(struct dlb2_hw *hw,
+				    unsigned int group_id,
+				    unsigned long val)
+{
+	u32 valid_allocations[] = {64, 128, 256, 512, 1024};
+	union dlb2_ro_pipe_grp_sn_mode r0 = { {0} };
+	struct dlb2_sn_group *group;
+	int mode;
+
+	if (group_id >= DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS)
+		return -EINVAL;
+
+	group = &hw->rsrcs.sn_groups[group_id];
+
+	/*
+	 * Once the first load-balanced queue using an SN group is configured,
+	 * the group cannot be changed.
+	 */
+	if (group->slot_use_bitmap != 0)
+		return -EPERM;
+
+	for (mode = 0; mode < DLB2_MAX_NUM_SEQUENCE_NUMBER_MODES; mode++)
+		if (val == valid_allocations[mode])
+			break;
+
+	if (mode == DLB2_MAX_NUM_SEQUENCE_NUMBER_MODES)
+		return -EINVAL;
+
+	group->mode = mode;
+	group->sequence_numbers_per_queue = val;
+
+	r0.field.sn_mode_0 = hw->rsrcs.sn_groups[0].mode;
+	r0.field.sn_mode_1 = hw->rsrcs.sn_groups[1].mode;
+
+	DLB2_CSR_WR(hw, DLB2_RO_PIPE_GRP_SN_MODE, r0.val);
+
+	dlb2_log_set_group_sequence_numbers(hw, group_id, val);
+
+	return 0;
+}
+
 static u32 dlb2_ldb_cq_inflight_count(struct dlb2_hw *hw,
 				      struct dlb2_ldb_port *port)
 {
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index 5fd7a30a1c1b..c1e1d677b2ae 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -573,6 +573,53 @@ void dlb2_ack_compressed_cq_intr(struct dlb2_hw *hw,
 				 u32 *dir_interrupts);
 
 /**
+ * dlb2_get_group_sequence_numbers() - return a group's number of SNs per queue
+ * @hw: dlb2_hw handle for a particular device.
+ * @group_id: sequence number group ID.
+ *
+ * This function returns the configured number of sequence numbers per queue
+ * for the specified group.
+ *
+ * Return:
+ * Returns -EINVAL if group_id is invalid, else the group's SNs per queue.
+ */
+int dlb2_get_group_sequence_numbers(struct dlb2_hw *hw,
+				    unsigned int group_id);
+
+/**
+ * dlb2_get_group_sequence_number_occupancy() - return a group's in-use slots
+ * @hw: dlb2_hw handle for a particular device.
+ * @group_id: sequence number group ID.
+ *
+ * This function returns the group's number of in-use slots (i.e. load-balanced
+ * queues using the specified group).
+ *
+ * Return:
+ * Returns -EINVAL if group_id is invalid, else the group's SNs per queue.
+ */
+int dlb2_get_group_sequence_number_occupancy(struct dlb2_hw *hw,
+					     unsigned int group_id);
+
+/**
+ * dlb2_set_group_sequence_numbers() - assign a group's number of SNs per queue
+ * @hw: dlb2_hw handle for a particular device.
+ * @group_id: sequence number group ID.
+ * @val: requested amount of sequence numbers per queue.
+ *
+ * This function configures the group's number of sequence numbers per queue.
+ * val can be a power-of-two between 32 and 1024, inclusive. This setting can
+ * be configured until the first ordered load-balanced queue is configured, at
+ * which point the configuration is locked.
+ *
+ * Return:
+ * Returns 0 upon success; -EINVAL if group_id or val is invalid, -EPERM if an
+ * ordered queue is configured.
+ */
+int dlb2_set_group_sequence_numbers(struct dlb2_hw *hw,
+				    unsigned int group_id,
+				    unsigned long val);
+
+/**
  * dlb2_reset_domain() - reset a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @domain_id: domain ID.
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 48783a8e91c2..a117ca71dbbc 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -239,11 +239,83 @@ struct dlb2_query_cq_poll_mode_args {
 	struct dlb2_cmd_response response;
 };
 
+/*
+ * DLB2_CMD_SET_SN_ALLOCATION: Configure a sequence number group (PF only)
+ *
+ * Input parameters:
+ * - group: Sequence number group ID.
+ * - num: Number of sequence numbers per queue.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_set_sn_allocation_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 group;
+	__u32 num;
+};
+
+/*
+ * DLB2_CMD_GET_SN_ALLOCATION: Get a sequence number group's configuration
+ *
+ * Input parameters:
+ * - group: Sequence number group ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Specified group's number of sequence numbers per queue.
+ */
+struct dlb2_get_sn_allocation_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 group;
+	__u32 padding0;
+};
+
+/*
+ * DLB2_CMD_GET_SN_OCCUPANCY: Get a sequence number group's occupancy
+ *
+ * Each sequence number group has one or more slots, depending on its
+ * configuration. I.e.:
+ * - If configured for 1024 sequence numbers per queue, the group has 1 slot
+ * - If configured for 512 sequence numbers per queue, the group has 2 slots
+ *   ...
+ * - If configured for 32 sequence numbers per queue, the group has 32 slots
+ *
+ * This ioctl returns the group's number of in-use slots. If its occupancy is
+ * 0, the group's sequence number allocation can be reconfigured.
+ *
+ * Input parameters:
+ * - group: Sequence number group ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Specified group's number of used slots.
+ */
+struct dlb2_get_sn_occupancy_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 group;
+	__u32 padding0;
+};
+
 enum dlb2_user_interface_commands {
 	DLB2_CMD_GET_DEVICE_VERSION,
 	DLB2_CMD_CREATE_SCHED_DOMAIN,
 	DLB2_CMD_GET_NUM_RESOURCES,
 	DLB2_CMD_QUERY_CQ_POLL_MODE,
+	DLB2_CMD_SET_SN_ALLOCATION,
+	DLB2_CMD_GET_SN_ALLOCATION,
+	DLB2_CMD_GET_SN_OCCUPANCY,
 
 	/* NUM_DLB2_CMD must be last */
 	NUM_DLB2_CMD,
@@ -825,6 +897,18 @@ enum dlb2_domain_user_interface_commands {
 		_IOR(DLB2_IOC_MAGIC,				\
 		     DLB2_CMD_QUERY_CQ_POLL_MODE,		\
 		     struct dlb2_query_cq_poll_mode_args)
+#define DLB2_IOC_SET_SN_ALLOCATION				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_SET_SN_ALLOCATION,		\
+		      struct dlb2_set_sn_allocation_args)
+#define DLB2_IOC_GET_SN_ALLOCATION				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_GET_SN_ALLOCATION,		\
+		      struct dlb2_get_sn_allocation_args)
+#define DLB2_IOC_GET_SN_OCCUPANCY				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_GET_SN_OCCUPANCY,		\
+		      struct dlb2_get_sn_occupancy_args)
 #define DLB2_IOC_CREATE_LDB_QUEUE				\
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,		\
-- 
2.13.6

