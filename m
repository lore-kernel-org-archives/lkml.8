Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C405C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F331820767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbgIATWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:53436 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731910AbgIATV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:57 -0400
IronPort-SDR: AkFCRavzgXGuUDrZZQLkiiy2X65fdTdpv1Bwp+PAdKS0B6K9WoPUMsESTFhT8qlXPzDOV7GNJX
 xwhCu6BB6KLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807349"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807349"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:35 -0700
IronPort-SDR: TPW17h+QifWpXUSYc5MnRer15/QmzWNufsP/w1+To7v5d7qDMCuKspq1ZD3a8eJeAoGNoQZv89
 NAOOwMapgd+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480512"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:34 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 16/19] dlb2: add cos bandwidth get/set ioctls
Date:   Tue,  1 Sep 2020 14:15:45 -0500
Message-Id: <20200901191548.31646-17-gage.eads@intel.com>
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

The DLB 2.0 supports four load-balanced port classes of service (CoS). Each
CoS receives a guaranteed percentage of the load-balanced scheduler's
bandwidth, and any unreserved bandwidth is divided among the four CoS.

These two ioctls allow applications to query CoS allocations and adjust
them as needed. These allocations are controlled by the PF driver; virtual
devices, when support for them is added, will not be able to adjust them.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    | 54 +++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h     |  2 ++
 drivers/misc/dlb2/dlb2_pf_ops.c   | 14 ++++++++++
 drivers/misc/dlb2/dlb2_resource.c | 59 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h | 28 +++++++++++++++++++
 include/uapi/linux/dlb2_user.h    | 52 ++++++++++++++++++++++++++++++++++
 6 files changed, 209 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 3e5ca65f9feb..3e4fb19dd726 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -761,6 +761,56 @@ static int dlb2_ioctl_get_sn_occupancy(struct dlb2_dev *dev,
 	return ret;
 }
 
+static int dlb2_ioctl_set_cos_bw(struct dlb2_dev *dev, unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_set_cos_bw_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->set_cos_bw(&dev->hw, arg.cos_id, arg.bandwidth);
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
+static int dlb2_ioctl_get_cos_bw(struct dlb2_dev *dev, unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_get_cos_bw_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->get_cos_bw(&dev->hw, arg.cos_id);
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
@@ -782,6 +832,10 @@ long dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_ioctl_get_sn_allocation(dev, arg);
 	case DLB2_IOC_GET_SN_OCCUPANCY:
 		return dlb2_ioctl_get_sn_occupancy(dev, arg);
+	case DLB2_IOC_SET_COS_BW:
+		return dlb2_ioctl_set_cos_bw(dev, arg);
+	case DLB2_IOC_GET_COS_BW:
+		return dlb2_ioctl_get_cos_bw(dev, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index a7be9399255f..e3d7c9362257 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -146,6 +146,8 @@ struct dlb2_device_ops {
 				   u32 domain_id,
 				   struct dlb2_get_dir_queue_depth_args *args,
 				   struct dlb2_cmd_response *resp);
+	int (*set_cos_bw)(struct dlb2_hw *hw, u32 cos_id, u8 bandwidth);
+	int (*get_cos_bw)(struct dlb2_hw *hw, u32 cos_id);
 	void (*init_hardware)(struct dlb2_dev *dev);
 	int (*query_cq_poll_mode)(struct dlb2_dev *dev,
 				  struct dlb2_cmd_response *user_resp);
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 337cc8a72a5c..771fd793870b 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -617,6 +617,18 @@ dlb2_pf_set_sn_allocation(struct dlb2_hw *hw, u32 group_id, u32 num)
 }
 
 static int
+dlb2_pf_set_cos_bw(struct dlb2_hw *hw, u32 cos_id, u8 bandwidth)
+{
+	return dlb2_hw_set_cos_bandwidth(hw, cos_id, bandwidth);
+}
+
+static int
+dlb2_pf_get_cos_bw(struct dlb2_hw *hw, u32 cos_id)
+{
+	return dlb2_hw_get_cos_bandwidth(hw, cos_id);
+}
+
+static int
 dlb2_pf_get_sn_occupancy(struct dlb2_hw *hw, u32 group_id)
 {
 	return dlb2_get_group_sequence_number_occupancy(hw, group_id);
@@ -667,6 +679,8 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.get_sn_occupancy = dlb2_pf_get_sn_occupancy,
 	.get_ldb_queue_depth = dlb2_pf_get_ldb_queue_depth,
 	.get_dir_queue_depth = dlb2_pf_get_dir_queue_depth,
+	.set_cos_bw = dlb2_pf_set_cos_bw,
+	.get_cos_bw = dlb2_pf_get_cos_bw,
 	.init_hardware = dlb2_pf_init_hardware,
 	.query_cq_poll_mode = dlb2_pf_query_cq_poll_mode,
 };
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 646f52a06842..f2f650bc979e 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -6769,6 +6769,65 @@ void dlb2_clr_pmcsr_disable(struct dlb2_hw *hw)
 	DLB2_CSR_WR(hw, DLB2_CFG_MSTR_CFG_PM_PMCSR_DISABLE, r0.val);
 }
 
+int dlb2_hw_get_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id)
+{
+	if (cos_id >= DLB2_NUM_COS_DOMAINS)
+		return -EINVAL;
+
+	return hw->cos_reservation[cos_id];
+}
+
+static void dlb2_log_set_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id, u8 bw)
+{
+	DLB2_HW_DBG(hw, "DLB2 set port CoS bandwidth:\n");
+	DLB2_HW_DBG(hw, "\tCoS ID:    %u\n", cos_id);
+	DLB2_HW_DBG(hw, "\tBandwidth: %u\n", bw);
+}
+
+int dlb2_hw_set_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id, u8 bandwidth)
+{
+	union dlb2_lsp_cfg_shdw_range_cos r0 = { {0} };
+	union dlb2_lsp_cfg_shdw_ctrl r1 = { {0} };
+	unsigned int i;
+	u8 total;
+
+	if (cos_id >= DLB2_NUM_COS_DOMAINS)
+		return -EINVAL;
+
+	if (bandwidth > 100)
+		return -EINVAL;
+
+	total = 0;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		total += (i == cos_id) ? bandwidth : hw->cos_reservation[i];
+
+	if (total > 100)
+		return -EINVAL;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CFG_SHDW_RANGE_COS(cos_id));
+
+	/*
+	 * Normalize the bandwidth to a value in the range 0-255. Integer
+	 * division may leave unreserved scheduling slots; these will be
+	 * divided among the 4 classes of service.
+	 */
+	r0.field.bw_range = (bandwidth * 256) / 100;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CFG_SHDW_RANGE_COS(cos_id), r0.val);
+
+	r1.field.transfer = 1;
+
+	/* Atomically transfer the newly configured service weight */
+	DLB2_CSR_WR(hw, DLB2_LSP_CFG_SHDW_CTRL, r1.val);
+
+	dlb2_log_set_cos_bandwidth(hw, cos_id, bandwidth);
+
+	hw->cos_reservation[cos_id] = bandwidth;
+
+	return 0;
+}
+
 void dlb2_hw_enable_sparse_ldb_cq_mode(struct dlb2_hw *hw)
 {
 	union dlb2_chp_cfg_chp_csr_ctrl r0;
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index c1e1d677b2ae..e325c584cb3f 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -823,6 +823,34 @@ int dlb2_hw_pending_port_unmaps(struct dlb2_hw *hw,
 				unsigned int vf_id);
 
 /**
+ * dlb2_hw_get_cos_bandwidth() - returns the percent of bandwidth allocated
+ *	to a port class-of-service.
+ * @hw: dlb2_hw handle for a particular device.
+ * @cos_id: class-of-service ID.
+ *
+ * Return:
+ * Returns -EINVAL if cos_id is invalid, else the class' bandwidth allocation.
+ */
+int dlb2_hw_get_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id);
+
+/**
+ * dlb2_hw_set_cos_bandwidth() - set a bandwidth allocation percentage for a
+ *	port class-of-service.
+ * @hw: dlb2_hw handle for a particular device.
+ * @cos_id: class-of-service ID.
+ * @bandwidth: class-of-service bandwidth.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - Invalid cos ID, bandwidth is greater than 100, or bandwidth would
+ *	    cause the total bandwidth across all classes of service to exceed
+ *	    100%.
+ */
+int dlb2_hw_set_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id, u8 bandwidth);
+
+/**
  * dlb2_hw_enable_sparse_ldb_cq_mode() - enable sparse mode for load-balanced
  *	ports.
  * @hw: dlb2_hw handle for a particular device.
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index a117ca71dbbc..946e01fae63d 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -308,6 +308,48 @@ struct dlb2_get_sn_occupancy_args {
 	__u32 padding0;
 };
 
+/*
+ * DLB2_CMD_SET_COS_BW: Set a bandwidth allocation percentage for a
+ *	load-balanced port class-of-service (PF only).
+ *
+ * Input parameters:
+ * - cos_id: class-of-service ID, between 0 and 3 (inclusive).
+ * - bandwidth: class-of-service bandwidth percentage. Total bandwidth
+ *		percentages across all 4 classes cannot exceed 100%.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_set_cos_bw_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 cos_id;
+	__u32 bandwidth;
+};
+
+/*
+ * DLB2_CMD_GET_COS_BW: Get the bandwidth allocation percentage for a
+ *	load-balanced port class-of-service.
+ *
+ * Input parameters:
+ * - cos_id: class-of-service ID, between 0 and 3 (inclusive).
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Specified class's bandwidth percentage.
+ */
+struct dlb2_get_cos_bw_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 cos_id;
+	__u32 padding0;
+};
+
 enum dlb2_user_interface_commands {
 	DLB2_CMD_GET_DEVICE_VERSION,
 	DLB2_CMD_CREATE_SCHED_DOMAIN,
@@ -316,6 +358,8 @@ enum dlb2_user_interface_commands {
 	DLB2_CMD_SET_SN_ALLOCATION,
 	DLB2_CMD_GET_SN_ALLOCATION,
 	DLB2_CMD_GET_SN_OCCUPANCY,
+	DLB2_CMD_SET_COS_BW,
+	DLB2_CMD_GET_COS_BW,
 
 	/* NUM_DLB2_CMD must be last */
 	NUM_DLB2_CMD,
@@ -909,6 +953,14 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_CMD_GET_SN_OCCUPANCY,		\
 		      struct dlb2_get_sn_occupancy_args)
+#define DLB2_IOC_SET_COS_BW					\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_SET_COS_BW,			\
+		      struct dlb2_set_cos_bw_args)
+#define DLB2_IOC_GET_COS_BW					\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_GET_COS_BW,			\
+		      struct dlb2_get_cos_bw_args)
 #define DLB2_IOC_CREATE_LDB_QUEUE				\
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,		\
-- 
2.13.6

