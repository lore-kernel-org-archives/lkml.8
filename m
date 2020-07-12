Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB004C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B8F20674
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgGLNwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:52:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:8919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbgGLNwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:52:40 -0400
IronPort-SDR: 3vIJdMEg1gaEgfPoT7YCu0uSgqmIvyJujAERUE7ovsD/4Xud5wSih81GAuAzWO04exGK2XF52e
 m4s8ljo7pFNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540912"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:52 -0700
IronPort-SDR: aCwvxFGnKCU3SdyoLP1UYOjtnDXDNKSHHbItASA4GLNE7ieHaztj3gLOScTJ1TP3BfWQPDEMy+
 6oK/CCRez0AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148646"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:51 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 16/20] dlb2: add sequence-number management ioctls
Date:   Sun, 12 Jul 2020 08:43:27 -0500
Message-Id: <20200712134331.8169-17-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200712134331.8169-1-gage.eads@intel.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
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
 drivers/misc/dlb2/dlb2_ioctl.c    | 116 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h     |   3 +
 drivers/misc/dlb2/dlb2_pf_ops.c   |  21 +++++++
 drivers/misc/dlb2/dlb2_resource.c |  67 ++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h |  47 +++++++++++++++
 include/uapi/linux/dlb2_user.h    |  87 ++++++++++++++++++++++++++++
 6 files changed, 341 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index dbbf39d0b019..8701643fc1f1 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -975,6 +975,119 @@ static int dlb2_ioctl_get_driver_version(struct dlb2_dev *dev,
 	return 0;
 }
 
+static int dlb2_ioctl_set_sn_allocation(struct dlb2_dev *dev,
+					unsigned long user_arg,
+					u16 size)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_set_sn_allocation_args arg;
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
+	ret = dev->ops->set_sn_allocation(&dev->hw, arg.group, arg.num);
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
+static int dlb2_ioctl_get_sn_allocation(struct dlb2_dev *dev,
+					unsigned long user_arg,
+					u16 size)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_get_sn_allocation_args arg;
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
+	ret = dev->ops->get_sn_allocation(&dev->hw, arg.group);
+
+	response.id = ret;
+
+	ret = (ret > 0) ? 0 : ret;
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
+static int dlb2_ioctl_get_sn_occupancy(struct dlb2_dev *dev,
+				       unsigned long user_arg,
+				       u16 size)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_get_sn_occupancy_args arg;
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
+	ret = dev->ops->get_sn_occupancy(&dev->hw, arg.group);
+
+	response.id = ret;
+
+	ret = (ret > 0) ? 0 : ret;
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
 static int dlb2_ioctl_query_cq_poll_mode(struct dlb2_dev *dev,
 					 unsigned long user_arg,
 					 u16 size)
@@ -1016,6 +1129,9 @@ static dlb2_ioctl_callback_fn_t dlb2_ioctl_callback_fns[NUM_DLB2_CMD] = {
 	dlb2_ioctl_get_sched_domain_fd,
 	dlb2_ioctl_get_num_resources,
 	dlb2_ioctl_get_driver_version,
+	dlb2_ioctl_set_sn_allocation,
+	dlb2_ioctl_get_sn_allocation,
+	dlb2_ioctl_get_sn_occupancy,
 	dlb2_ioctl_query_cq_poll_mode,
 };
 
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 6e387b394c84..aa73dad1ce77 100644
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
index 5b212624517a..8bdeb86a1e87 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -631,6 +631,24 @@ dlb2_pf_dir_port_owned_by_domain(struct dlb2_hw *hw,
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
@@ -671,6 +689,9 @@ struct dlb2_device_ops dlb2_pf_ops = {
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
index 436629cf02a2..f686b3045a2b 100644
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
index a5921fb3273d..246d4e303ecf 100644
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
index cbc4b5b37687..d86e5a748f16 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -297,6 +297,78 @@ struct dlb2_get_num_resources_args {
 	__u32 num_dir_credits;
 };
 
+/*
+ * DLB2_CMD_SET_SN_ALLOCATION: Configure a sequence number group (PF only)
+ *
+ * Input parameters:
+ * - group: Sequence number group ID.
+ * - num: Number of sequence numbers per queue.
+ *
+ * Output parameters:
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ */
+struct dlb2_set_sn_allocation_args {
+	/* Output parameters */
+	__u64 response;
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
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ *	response.id: Specified group's number of sequence numbers per queue.
+ */
+struct dlb2_get_sn_allocation_args {
+	/* Output parameters */
+	__u64 response;
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
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ *	response.id: Specified group's number of used slots.
+ */
+struct dlb2_get_sn_occupancy_args {
+	/* Output parameters */
+	__u64 response;
+	/* Input parameters */
+	__u32 group;
+	__u32 padding0;
+};
+
 enum dlb2_cq_poll_modes {
 	DLB2_CQ_POLL_MODE_STD,
 	DLB2_CQ_POLL_MODE_SPARSE,
@@ -325,6 +397,9 @@ enum dlb2_user_interface_commands {
 	DLB2_CMD_GET_SCHED_DOMAIN_FD,
 	DLB2_CMD_GET_NUM_RESOURCES,
 	DLB2_CMD_GET_DRIVER_VERSION,
+	DLB2_CMD_SET_SN_ALLOCATION,
+	DLB2_CMD_GET_SN_ALLOCATION,
+	DLB2_CMD_GET_SN_OCCUPANCY,
 	DLB2_CMD_QUERY_CQ_POLL_MODE,
 
 	/* NUM_DLB2_CMD must be last */
@@ -929,6 +1004,18 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_CMD_GET_DRIVER_VERSION,		\
 		      struct dlb2_get_driver_version_args)
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
 #define DLB2_IOC_QUERY_CQ_POLL_MODE				\
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_CMD_QUERY_CQ_POLL_MODE,		\
-- 
2.13.6

