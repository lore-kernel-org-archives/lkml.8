Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15236C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70AA207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbgIATWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:53436 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgIATVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:39 -0400
IronPort-SDR: 27ad20Qi73CMdag9zkpT1SBCSB6U7PRuqaYg6nG/64IR4nbqxQOOj24omrPkFM4YgmIahVH1Pz
 fNTuESbRkdrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807319"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807319"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:31 -0700
IronPort-SDR: 8+7Qb9Yh7fmLnbRgL4J/O8VM4eW8Jxw68vKv3cWt4dkHh4f90BX9IUSDR1fLFGGRz4yk3ENWSu
 AFZW1IiboFKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480466"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:30 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 07/19] dlb2: add queue create and queue-depth-get ioctls
Date:   Tue,  1 Sep 2020 14:15:36 -0500
Message-Id: <20200901191548.31646-8-gage.eads@intel.com>
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

When a CPU enqueues a queue entry (QE) to DLB 2.0, the QE entry is sent to
a DLB 2.0 queue. These queues hold queue entries (QEs) that have not yet
been scheduled to a destination port. The queue's depth is the number of
QEs residing in a queue.

Each queue supports multiple priority levels, and while a directed queue
has a 1:1 mapping with a directed port, load-balanced queues can be
configured with a set of load-balanced ports that software desires the
queue's QEs to be scheduled to.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    |  61 ++++
 drivers/misc/dlb2/dlb2_ioctl.h    |   2 +
 drivers/misc/dlb2/dlb2_main.c     |   2 +
 drivers/misc/dlb2/dlb2_main.h     |  16 +
 drivers/misc/dlb2/dlb2_pf_ops.c   |  40 +++
 drivers/misc/dlb2/dlb2_resource.c | 732 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h | 125 +++++++
 include/uapi/linux/dlb2_user.h    | 138 +++++++
 8 files changed, 1116 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 56ebd9387e31..f787fd19689f 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -9,6 +9,67 @@
 #include "dlb2_ioctl.h"
 #include "dlb2_main.h"
 
+/*
+ * The DLB domain ioctl callback template minimizes replication of boilerplate
+ * code to copy arguments, acquire and release the resource lock, and execute
+ * the command.  The arguments and response structure name should have the
+ * format dlb2_<lower_name>_args.
+ */
+#define DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(lower_name)			   \
+static int dlb2_domain_ioctl_##lower_name(struct dlb2_dev *dev,		   \
+					  struct dlb2_domain *domain,	   \
+					  unsigned long user_arg)	   \
+{									   \
+	struct dlb2_cmd_response response = {0};			   \
+	struct dlb2_##lower_name##_args arg;				   \
+	int ret;							   \
+									   \
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))	   \
+		return -EFAULT;						   \
+									   \
+	mutex_lock(&dev->resource_mutex);				   \
+									   \
+	ret = dev->ops->lower_name(&dev->hw,				   \
+				   domain->id,				   \
+				   &arg,				   \
+				   &response);				   \
+									   \
+	mutex_unlock(&dev->resource_mutex);				   \
+									   \
+	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);		   \
+									   \
+	if (copy_to_user((void __user *)user_arg,			   \
+			 &response,					   \
+			 sizeof(response)))				   \
+		return -EFAULT;						   \
+									   \
+	return ret;							   \
+}
+
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_ldb_queue)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
+
+long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct dlb2_domain *dom = f->private_data;
+	struct dlb2_dev *dev = dom->dlb2_dev;
+
+	switch (cmd) {
+	case DLB2_IOC_CREATE_LDB_QUEUE:
+		return dlb2_domain_ioctl_create_ldb_queue(dev, dom, arg);
+	case DLB2_IOC_CREATE_DIR_QUEUE:
+		return dlb2_domain_ioctl_create_dir_queue(dev, dom, arg);
+	case DLB2_IOC_GET_LDB_QUEUE_DEPTH:
+		return dlb2_domain_ioctl_get_ldb_queue_depth(dev, dom, arg);
+	case DLB2_IOC_GET_DIR_QUEUE_DEPTH:
+		return dlb2_domain_ioctl_get_dir_queue_depth(dev, dom, arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 /* [7:0]: device revision, [15:8]: device version */
 #define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
 
diff --git a/drivers/misc/dlb2/dlb2_ioctl.h b/drivers/misc/dlb2/dlb2_ioctl.h
index 367c93b98414..548cff477cf5 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.h
+++ b/drivers/misc/dlb2/dlb2_ioctl.h
@@ -9,4 +9,6 @@
 
 long dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg);
 
+long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg);
+
 #endif /* __DLB2_IOCTL_H */
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index 17a26e6856d1..b331e096d206 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -154,6 +154,8 @@ static int dlb2_domain_close(struct inode *i, struct file *f)
 const struct file_operations dlb2_domain_fops = {
 	.owner   = THIS_MODULE,
 	.release = dlb2_domain_close,
+	.unlocked_ioctl = dlb2_domain_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 /**********************************/
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 86344f223649..41a3254a78ac 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -60,9 +60,25 @@ struct dlb2_device_ops {
 	int (*create_sched_domain)(struct dlb2_hw *hw,
 				   struct dlb2_create_sched_domain_args *args,
 				   struct dlb2_cmd_response *resp);
+	int (*create_ldb_queue)(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_create_ldb_queue_args *args,
+				struct dlb2_cmd_response *resp);
+	int (*create_dir_queue)(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_create_dir_queue_args *args,
+				struct dlb2_cmd_response *resp);
 	int (*get_num_resources)(struct dlb2_hw *hw,
 				 struct dlb2_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb2_hw *hw, u32 domain_id);
+	int (*get_ldb_queue_depth)(struct dlb2_hw *hw,
+				   u32 domain_id,
+				   struct dlb2_get_ldb_queue_depth_args *args,
+				   struct dlb2_cmd_response *resp);
+	int (*get_dir_queue_depth)(struct dlb2_hw *hw,
+				   u32 domain_id,
+				   struct dlb2_get_dir_queue_depth_args *args,
+				   struct dlb2_cmd_response *resp);
 	void (*init_hardware)(struct dlb2_dev *dev);
 };
 
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 6ca06406b0f2..89c0e66b3c6b 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -216,6 +216,24 @@ dlb2_pf_create_sched_domain(struct dlb2_hw *hw,
 }
 
 static int
+dlb2_pf_create_ldb_queue(struct dlb2_hw *hw,
+			 u32 id,
+			 struct dlb2_create_ldb_queue_args *args,
+			 struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_create_ldb_queue(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb2_pf_create_dir_queue(struct dlb2_hw *hw,
+			 u32 id,
+			 struct dlb2_create_dir_queue_args *args,
+			 struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_create_dir_queue(hw, id, args, resp, false, 0);
+}
+
+static int
 dlb2_pf_get_num_resources(struct dlb2_hw *hw,
 			  struct dlb2_get_num_resources_args *args)
 {
@@ -228,6 +246,24 @@ dlb2_pf_reset_domain(struct dlb2_hw *hw, u32 id)
 	return dlb2_reset_domain(hw, id, false, 0);
 }
 
+static int
+dlb2_pf_get_ldb_queue_depth(struct dlb2_hw *hw,
+			    u32 id,
+			    struct dlb2_get_ldb_queue_depth_args *args,
+			    struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_get_ldb_queue_depth(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb2_pf_get_dir_queue_depth(struct dlb2_hw *hw,
+			    u32 id,
+			    struct dlb2_get_dir_queue_depth_args *args,
+			    struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_get_dir_queue_depth(hw, id, args, resp, false, 0);
+}
+
 /********************************/
 /****** DLB2 PF Device Ops ******/
 /********************************/
@@ -246,7 +282,11 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.enable_pm = dlb2_pf_enable_pm,
 	.wait_for_device_ready = dlb2_pf_wait_for_device_ready,
 	.create_sched_domain = dlb2_pf_create_sched_domain,
+	.create_ldb_queue = dlb2_pf_create_ldb_queue,
+	.create_dir_queue = dlb2_pf_create_dir_queue,
 	.get_num_resources = dlb2_pf_get_num_resources,
 	.reset_domain = dlb2_pf_reset_domain,
+	.get_ldb_queue_depth = dlb2_pf_get_ldb_queue_depth,
+	.get_dir_queue_depth = dlb2_pf_get_dir_queue_depth,
 	.init_hardware = dlb2_pf_init_hardware,
 };
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 2cc744cea2d5..2531c6508994 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -237,6 +237,24 @@ static struct dlb2_hw_domain *dlb2_get_domain_from_id(struct dlb2_hw *hw,
 	return NULL;
 }
 
+static struct dlb2_dir_pq_pair *
+dlb2_get_domain_used_dir_pq(u32 id,
+			    bool vdev_req,
+			    struct dlb2_hw_domain *domain)
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
+	return NULL;
+}
+
 static struct dlb2_ldb_queue *
 dlb2_get_ldb_queue_from_id(struct dlb2_hw *hw,
 			   u32 id,
@@ -268,6 +286,24 @@ dlb2_get_ldb_queue_from_id(struct dlb2_hw *hw,
 	return NULL;
 }
 
+static struct dlb2_ldb_queue *
+dlb2_get_domain_ldb_queue(u32 id,
+			  bool vdev_req,
+			  struct dlb2_hw_domain *domain)
+{
+	struct dlb2_ldb_queue *queue;
+
+	if (id >= DLB2_MAX_NUM_LDB_QUEUES)
+		return NULL;
+
+	DLB2_DOM_LIST_FOR(domain->used_ldb_queues, queue)
+		if ((!vdev_req && queue->id.phys_id == id) ||
+		    (vdev_req && queue->id.virt_id == id))
+			return queue;
+
+	return NULL;
+}
+
 static int dlb2_attach_ldb_queues(struct dlb2_hw *hw,
 				  struct dlb2_function_resources *rsrcs,
 				  struct dlb2_hw_domain *domain,
@@ -707,6 +743,352 @@ dlb2_verify_create_sched_dom_args(struct dlb2_function_resources *rsrcs,
 	return 0;
 }
 
+static int
+dlb2_verify_create_ldb_queue_args(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  struct dlb2_create_ldb_queue_args *args,
+				  struct dlb2_cmd_response *resp,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	int i;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB2_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	if (domain->started) {
+		resp->status = DLB2_ST_DOMAIN_STARTED;
+		return -EINVAL;
+	}
+
+	if (list_empty(&domain->avail_ldb_queues)) {
+		resp->status = DLB2_ST_LDB_QUEUES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (args->num_sequence_numbers) {
+		for (i = 0; i < DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS; i++) {
+			struct dlb2_sn_group *group = &hw->rsrcs.sn_groups[i];
+
+			if (group->sequence_numbers_per_queue ==
+			    args->num_sequence_numbers &&
+			    !dlb2_sn_group_full(group))
+				break;
+		}
+
+		if (i == DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS) {
+			resp->status = DLB2_ST_SEQUENCE_NUMBERS_UNAVAILABLE;
+			return -EINVAL;
+		}
+	}
+
+	if (args->num_qid_inflights > 4096) {
+		resp->status = DLB2_ST_INVALID_QID_INFLIGHT_ALLOCATION;
+		return -EINVAL;
+	}
+
+	/* Inflights must be <= number of sequence numbers if ordered */
+	if (args->num_sequence_numbers != 0 &&
+	    args->num_qid_inflights > args->num_sequence_numbers) {
+		resp->status = DLB2_ST_INVALID_QID_INFLIGHT_ALLOCATION;
+		return -EINVAL;
+	}
+
+	if (domain->num_avail_aqed_entries < args->num_atomic_inflights) {
+		resp->status = DLB2_ST_ATOMIC_INFLIGHTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (args->num_atomic_inflights &&
+	    args->lock_id_comp_level != 0 &&
+	    args->lock_id_comp_level != 64 &&
+	    args->lock_id_comp_level != 128 &&
+	    args->lock_id_comp_level != 256 &&
+	    args->lock_id_comp_level != 512 &&
+	    args->lock_id_comp_level != 1024 &&
+	    args->lock_id_comp_level != 2048 &&
+	    args->lock_id_comp_level != 4096 &&
+	    args->lock_id_comp_level != 65536) {
+		resp->status = DLB2_ST_INVALID_LOCK_ID_COMP_LEVEL;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dlb2_verify_create_dir_queue_args(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  struct dlb2_create_dir_queue_args *args,
+				  struct dlb2_cmd_response *resp,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB2_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	if (domain->started) {
+		resp->status = DLB2_ST_DOMAIN_STARTED;
+		return -EINVAL;
+	}
+
+	/*
+	 * If the user claims the port is already configured, validate the port
+	 * ID, its domain, and whether the port is configured.
+	 */
+	if (args->port_id != -1) {
+		struct dlb2_dir_pq_pair *port;
+
+		port = dlb2_get_domain_used_dir_pq(args->port_id,
+						   vdev_req,
+						   domain);
+
+		if (!port || port->domain_id.phys_id != domain->id.phys_id ||
+		    !port->port_configured) {
+			resp->status = DLB2_ST_INVALID_PORT_ID;
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * If the queue's port is not configured, validate that a free
+	 * port-queue pair is available.
+	 */
+	if (args->port_id == -1 && list_empty(&domain->avail_dir_pq_pairs)) {
+		resp->status = DLB2_ST_DIR_QUEUES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void dlb2_configure_ldb_queue(struct dlb2_hw *hw,
+				     struct dlb2_hw_domain *domain,
+				     struct dlb2_ldb_queue *queue,
+				     struct dlb2_create_ldb_queue_args *args,
+				     bool vdev_req,
+				     unsigned int vdev_id)
+{
+	union dlb2_sys_vf_ldb_vqid_v r0 = { {0} };
+	union dlb2_sys_vf_ldb_vqid2qid r1 = { {0} };
+	union dlb2_sys_ldb_qid2vqid r2 = { {0} };
+	union dlb2_sys_ldb_vasqid_v r3 = { {0} };
+	union dlb2_lsp_qid_ldb_infl_lim r4 = { {0} };
+	union dlb2_lsp_qid_aqed_active_lim r5 = { {0} };
+	union dlb2_aqed_pipe_qid_hid_width r6 = { {0} };
+	union dlb2_sys_ldb_qid_its r7 = { {0} };
+	union dlb2_lsp_qid_atm_depth_thrsh r8 = { {0} };
+	union dlb2_lsp_qid_naldb_depth_thrsh r9 = { {0} };
+	union dlb2_aqed_pipe_qid_fid_lim r10 = { {0} };
+	union dlb2_chp_ord_qid_sn_map r11 = { {0} };
+	union dlb2_sys_ldb_qid_cfg_v r12 = { {0} };
+	union dlb2_sys_ldb_qid_v r13 = { {0} };
+
+	struct dlb2_sn_group *sn_group;
+	unsigned int offs;
+
+	/* QID write permissions are turned on when the domain is started */
+	r3.field.vasqid_v = 0;
+
+	offs = domain->id.phys_id * DLB2_MAX_NUM_LDB_QUEUES +
+		queue->id.phys_id;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_VASQID_V(offs), r3.val);
+
+	/*
+	 * Unordered QIDs get 4K inflights, ordered get as many as the number
+	 * of sequence numbers.
+	 */
+	r4.field.limit = args->num_qid_inflights;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_QID_LDB_INFL_LIM(queue->id.phys_id), r4.val);
+
+	r5.field.limit = queue->aqed_limit;
+
+	if (r5.field.limit > DLB2_MAX_NUM_AQED_ENTRIES)
+		r5.field.limit = DLB2_MAX_NUM_AQED_ENTRIES;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID_AQED_ACTIVE_LIM(queue->id.phys_id),
+		    r5.val);
+
+	switch (args->lock_id_comp_level) {
+	case 64:
+		r6.field.compress_code = 1;
+		break;
+	case 128:
+		r6.field.compress_code = 2;
+		break;
+	case 256:
+		r6.field.compress_code = 3;
+		break;
+	case 512:
+		r6.field.compress_code = 4;
+		break;
+	case 1024:
+		r6.field.compress_code = 5;
+		break;
+	case 2048:
+		r6.field.compress_code = 6;
+		break;
+	case 4096:
+		r6.field.compress_code = 7;
+		break;
+	case 0:
+	case 65536:
+		r6.field.compress_code = 0;
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_AQED_PIPE_QID_HID_WIDTH(queue->id.phys_id),
+		    r6.val);
+
+	/* Don't timestamp QEs that pass through this queue */
+	r7.field.qid_its = 0;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_QID_ITS(queue->id.phys_id),
+		    r7.val);
+
+	r8.field.thresh = args->depth_threshold;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID_ATM_DEPTH_THRSH(queue->id.phys_id),
+		    r8.val);
+
+	r9.field.thresh = args->depth_threshold;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID_NALDB_DEPTH_THRSH(queue->id.phys_id),
+		    r9.val);
+
+	/*
+	 * This register limits the number of inflight flows a queue can have
+	 * at one time.  It has an upper bound of 2048, but can be
+	 * over-subscribed. 512 is chosen so that a single queue doesn't use
+	 * the entire atomic storage, but can use a substantial portion if
+	 * needed.
+	 */
+	r10.field.qid_fid_limit = 512;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_AQED_PIPE_QID_FID_LIM(queue->id.phys_id),
+		    r10.val);
+
+	/* Configure SNs */
+	sn_group = &hw->rsrcs.sn_groups[queue->sn_group];
+	r11.field.mode = sn_group->mode;
+	r11.field.slot = queue->sn_slot;
+	r11.field.grp  = sn_group->id;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_ORD_QID_SN_MAP(queue->id.phys_id), r11.val);
+
+	r12.field.sn_cfg_v = (args->num_sequence_numbers != 0);
+	r12.field.fid_cfg_v = (args->num_atomic_inflights != 0);
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_QID_CFG_V(queue->id.phys_id), r12.val);
+
+	if (vdev_req) {
+		offs = vdev_id * DLB2_MAX_NUM_LDB_QUEUES + queue->id.virt_id;
+
+		r0.field.vqid_v = 1;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_LDB_VQID_V(offs), r0.val);
+
+		r1.field.qid = queue->id.phys_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_LDB_VQID2QID(offs), r1.val);
+
+		r2.field.vqid = queue->id.virt_id;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_QID2VQID(queue->id.phys_id),
+			    r2.val);
+	}
+
+	r13.field.qid_v = 1;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_QID_V(queue->id.phys_id), r13.val);
+}
+
+static void dlb2_configure_dir_queue(struct dlb2_hw *hw,
+				     struct dlb2_hw_domain *domain,
+				     struct dlb2_dir_pq_pair *queue,
+				     struct dlb2_create_dir_queue_args *args,
+				     bool vdev_req,
+				     unsigned int vdev_id)
+{
+	union dlb2_sys_dir_vasqid_v r0 = { {0} };
+	union dlb2_sys_dir_qid_its r1 = { {0} };
+	union dlb2_lsp_qid_dir_depth_thrsh r2 = { {0} };
+	union dlb2_sys_dir_qid_v r5 = { {0} };
+
+	unsigned int offs;
+
+	/* QID write permissions are turned on when the domain is started */
+	r0.field.vasqid_v = 0;
+
+	offs = domain->id.phys_id * DLB2_MAX_NUM_DIR_QUEUES +
+		queue->id.phys_id;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_VASQID_V(offs), r0.val);
+
+	/* Don't timestamp QEs that pass through this queue */
+	r1.field.qid_its = 0;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_QID_ITS(queue->id.phys_id),
+		    r1.val);
+
+	r2.field.thresh = args->depth_threshold;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_QID_DIR_DEPTH_THRSH(queue->id.phys_id),
+		    r2.val);
+
+	if (vdev_req) {
+		union dlb2_sys_vf_dir_vqid_v r3 = { {0} };
+		union dlb2_sys_vf_dir_vqid2qid r4 = { {0} };
+
+		offs = vdev_id * DLB2_MAX_NUM_DIR_QUEUES + queue->id.virt_id;
+
+		r3.field.vqid_v = 1;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_DIR_VQID_V(offs), r3.val);
+
+		r4.field.qid = queue->id.phys_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_DIR_VQID2QID(offs), r4.val);
+	}
+
+	r5.field.qid_v = 1;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_QID_V(queue->id.phys_id), r5.val);
+
+	queue->queue_configured = true;
+}
+
 static bool dlb2_port_find_slot(struct dlb2_ldb_port *port,
 				enum dlb2_qid_map_state state,
 				int *slot)
@@ -955,6 +1337,68 @@ dlb2_domain_attach_resources(struct dlb2_hw *hw,
 	return 0;
 }
 
+static int
+dlb2_ldb_queue_attach_to_sn_group(struct dlb2_hw *hw,
+				  struct dlb2_ldb_queue *queue,
+				  struct dlb2_create_ldb_queue_args *args)
+{
+	int slot = -1;
+	int i;
+
+	queue->sn_cfg_valid = false;
+
+	if (args->num_sequence_numbers == 0)
+		return 0;
+
+	for (i = 0; i < DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS; i++) {
+		struct dlb2_sn_group *group = &hw->rsrcs.sn_groups[i];
+
+		if (group->sequence_numbers_per_queue ==
+		    args->num_sequence_numbers &&
+		    !dlb2_sn_group_full(group)) {
+			slot = dlb2_sn_group_alloc_slot(group);
+			if (slot >= 0)
+				break;
+		}
+	}
+
+	if (slot == -1) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: no sequence number slots available\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	queue->sn_cfg_valid = true;
+	queue->sn_group = i;
+	queue->sn_slot = slot;
+	return 0;
+}
+
+static int
+dlb2_ldb_queue_attach_resources(struct dlb2_hw *hw,
+				struct dlb2_hw_domain *domain,
+				struct dlb2_ldb_queue *queue,
+				struct dlb2_create_ldb_queue_args *args)
+{
+	int ret;
+
+	ret = dlb2_ldb_queue_attach_to_sn_group(hw, queue, args);
+	if (ret)
+		return ret;
+
+	/* Attach QID inflights */
+	queue->num_qid_inflights = args->num_qid_inflights;
+
+	/* Attach atomic inflights */
+	queue->aqed_limit = args->num_atomic_inflights;
+
+	domain->num_avail_aqed_entries -= args->num_atomic_inflights;
+	domain->num_used_aqed_entries += args->num_atomic_inflights;
+
+	return 0;
+}
+
 static void dlb2_ldb_port_cq_enable(struct dlb2_hw *hw,
 				    struct dlb2_ldb_port *port)
 {
@@ -1670,6 +2114,203 @@ int dlb2_hw_create_sched_domain(struct dlb2_hw *hw,
 }
 
 static void
+dlb2_log_create_ldb_queue_args(struct dlb2_hw *hw,
+			       u32 domain_id,
+			       struct dlb2_create_ldb_queue_args *args,
+			       bool vdev_req,
+			       unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 create load-balanced queue arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID:                  %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tNumber of sequence numbers: %d\n",
+		    args->num_sequence_numbers);
+	DLB2_HW_DBG(hw, "\tNumber of QID inflights:    %d\n",
+		    args->num_qid_inflights);
+	DLB2_HW_DBG(hw, "\tNumber of ATM inflights:    %d\n",
+		    args->num_atomic_inflights);
+}
+
+/**
+ * dlb2_hw_create_ldb_queue() - Allocate and initialize a DLB LDB queue.
+ * @hw:	Contains the current state of the DLB2 hardware.
+ * @domain_id: Domain ID
+ * @args: User-provided arguments.
+ * @resp: Response to user.
+ * @vdev_req: Request came from a virtual device.
+ * @vdev_id: If vdev_req is true, this contains the virtual device's ID.
+ *
+ * Return: returns < 0 on error, 0 otherwise. If the driver is unable to
+ * satisfy a request, resp->status will be set accordingly.
+ */
+int dlb2_hw_create_ldb_queue(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_create_ldb_queue_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_queue *queue;
+	int ret;
+
+	dlb2_log_create_ldb_queue_args(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_create_ldb_queue_args(hw,
+						domain_id,
+						args,
+						resp,
+						vdev_req,
+						vdev_id);
+	if (ret)
+		return ret;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+	if (!domain) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: domain not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	queue = DLB2_DOM_LIST_HEAD(domain->avail_ldb_queues, typeof(*queue));
+
+	if (!queue) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: no available ldb queues\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	ret = dlb2_ldb_queue_attach_resources(hw, domain, queue, args);
+	if (ret < 0) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: failed to attach the ldb queue resources\n",
+			    __func__, __LINE__);
+		return ret;
+	}
+
+	dlb2_configure_ldb_queue(hw, domain, queue, args, vdev_req, vdev_id);
+
+	queue->num_mappings = 0;
+
+	queue->configured = true;
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list.
+	 */
+	list_del(&queue->domain_list);
+
+	list_add(&queue->domain_list, &domain->used_ldb_queues);
+
+	resp->status = 0;
+	resp->id = (vdev_req) ? queue->id.virt_id : queue->id.phys_id;
+
+	return 0;
+}
+
+static void
+dlb2_log_create_dir_queue_args(struct dlb2_hw *hw,
+			       u32 domain_id,
+			       struct dlb2_create_dir_queue_args *args,
+			       bool vdev_req,
+			       unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 create directed queue arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+	DLB2_HW_DBG(hw, "\tPort ID:   %d\n", args->port_id);
+}
+
+/**
+ * dlb2_hw_create_dir_queue() - Allocate and initialize a DLB DIR queue.
+ * @hw:	Contains the current state of the DLB2 hardware.
+ * @domain_id: Domain ID
+ * @args: User-provided arguments.
+ * @resp: Response to user.
+ * @vdev_req: Request came from a virtual device.
+ * @vdev_id: If vdev_req is true, this contains the virtual device's ID.
+ *
+ * Return: returns < 0 on error, 0 otherwise. If the driver is unable to
+ * satisfy a request, resp->status will be set accordingly.
+ */
+int dlb2_hw_create_dir_queue(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_create_dir_queue_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *queue;
+	struct dlb2_hw_domain *domain;
+	int ret;
+
+	dlb2_log_create_dir_queue_args(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_create_dir_queue_args(hw,
+						domain_id,
+						args,
+						resp,
+						vdev_req,
+						vdev_id);
+	if (ret)
+		return ret;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+	if (!domain) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: domain not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	if (args->port_id != -1)
+		queue = dlb2_get_domain_used_dir_pq(args->port_id,
+						    vdev_req,
+						    domain);
+	else
+		queue = DLB2_DOM_LIST_HEAD(domain->avail_dir_pq_pairs,
+					   typeof(*queue));
+
+	if (!queue) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: no available dir queues\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	dlb2_configure_dir_queue(hw, domain, queue, args, vdev_req, vdev_id);
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list (if it's not already there).
+	 */
+	if (args->port_id == -1) {
+		list_del(&queue->domain_list);
+
+		list_add(&queue->domain_list, &domain->used_dir_pq_pairs);
+	}
+
+	resp->status = 0;
+
+	resp->id = (vdev_req) ? queue->id.virt_id : queue->id.phys_id;
+
+	return 0;
+}
+
+static void
 dlb2_domain_finish_unmap_port_slot(struct dlb2_hw *hw,
 				   struct dlb2_hw_domain *domain,
 				   struct dlb2_ldb_port *port,
@@ -2132,6 +2773,54 @@ static bool dlb2_dir_queue_is_empty(struct dlb2_hw *hw,
 	return dlb2_dir_queue_depth(hw, queue) == 0;
 }
 
+static void dlb2_log_get_dir_queue_depth(struct dlb2_hw *hw,
+					 u32 domain_id,
+					 u32 queue_id,
+					 bool vdev_req,
+					 unsigned int vf_id)
+{
+	DLB2_HW_DBG(hw, "DLB get directed queue depth:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from VF %d)\n", vf_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+	DLB2_HW_DBG(hw, "\tQueue ID: %d\n", queue_id);
+}
+
+int dlb2_hw_get_dir_queue_depth(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_get_dir_queue_depth_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vdev_req,
+				unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *queue;
+	struct dlb2_hw_domain *domain;
+	int id;
+
+	id = domain_id;
+
+	dlb2_log_get_dir_queue_depth(hw, domain_id, args->queue_id,
+				     vdev_req, vdev_id);
+
+	domain = dlb2_get_domain_from_id(hw, id, vdev_req, vdev_id);
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	id = args->queue_id;
+
+	queue = dlb2_get_domain_used_dir_pq(id, vdev_req, domain);
+	if (!queue) {
+		resp->status = DLB2_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	resp->id = dlb2_dir_queue_depth(hw, queue);
+
+	return 0;
+}
+
 static u32 dlb2_ldb_queue_depth(struct dlb2_hw *hw,
 				struct dlb2_ldb_queue *queue)
 {
@@ -2156,6 +2845,49 @@ static bool dlb2_ldb_queue_is_empty(struct dlb2_hw *hw,
 	return dlb2_ldb_queue_depth(hw, queue) == 0;
 }
 
+static void dlb2_log_get_ldb_queue_depth(struct dlb2_hw *hw,
+					 u32 domain_id,
+					 u32 queue_id,
+					 bool vdev_req,
+					 unsigned int vf_id)
+{
+	DLB2_HW_DBG(hw, "DLB get load-balanced queue depth:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from VF %d)\n", vf_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+	DLB2_HW_DBG(hw, "\tQueue ID: %d\n", queue_id);
+}
+
+int dlb2_hw_get_ldb_queue_depth(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_get_ldb_queue_depth_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vdev_req,
+				unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_queue *queue;
+
+	dlb2_log_get_ldb_queue_depth(hw, domain_id, args->queue_id,
+				     vdev_req, vdev_id);
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	queue = dlb2_get_domain_ldb_queue(args->queue_id, vdev_req, domain);
+	if (!queue) {
+		resp->status = DLB2_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	resp->id = dlb2_ldb_queue_depth(hw, queue);
+
+	return 0;
+}
+
 static void __dlb2_domain_reset_ldb_port_registers(struct dlb2_hw *hw,
 						   struct dlb2_ldb_port *port)
 {
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index 7dc50865681b..dfb42e0e13de 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -70,6 +70,73 @@ int dlb2_hw_create_sched_domain(struct dlb2_hw *hw,
 				unsigned int vdev_id);
 
 /**
+ * dlb2_hw_create_ldb_queue() - create a load-balanced queue
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue creation arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function creates a load-balanced queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the queue ID.
+ *
+ * resp->id contains a virtual ID if vdev_request is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, the domain is not configured,
+ *	    the domain has already been started, or the requested queue name is
+ *	    already in use.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_create_ldb_queue(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_create_ldb_queue_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_request,
+			     unsigned int vdev_id);
+
+/**
+ * dlb2_hw_create_dir_queue() - create a directed queue
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue creation arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function creates a directed queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the queue ID.
+ *
+ * resp->id contains a virtual ID if vdev_request is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, the domain is not configured,
+ *	    or the domain has already been started.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_create_dir_queue(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_create_dir_queue_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_request,
+			     unsigned int vdev_id);
+
+/**
  * dlb2_reset_domain() - reset a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @domain_id: domain ID.
@@ -130,6 +197,64 @@ int dlb2_hw_get_num_resources(struct dlb2_hw *hw,
  */
 void dlb2_clr_pmcsr_disable(struct dlb2_hw *hw);
 
+/**
+ * dlb2_hw_get_ldb_queue_depth() - returns the depth of a load-balanced queue
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue depth args
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function returns the depth of a load-balanced queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the depth.
+ *
+ * Errors:
+ * EINVAL - Invalid domain ID or queue ID.
+ */
+int dlb2_hw_get_ldb_queue_depth(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_get_ldb_queue_depth_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vdev_request,
+				unsigned int vdev_id);
+
+/**
+ * dlb2_hw_get_dir_queue_depth() - returns the depth of a directed queue
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue depth args
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function returns the depth of a directed queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the depth.
+ *
+ * Errors:
+ * EINVAL - Invalid domain ID or queue ID.
+ */
+int dlb2_hw_get_dir_queue_depth(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_get_dir_queue_depth_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vdev_request,
+				unsigned int vdev_id);
+
 enum dlb2_virt_mode {
 	DLB2_VIRT_NONE,
 	DLB2_VIRT_SRIOV,
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 02d380b51c2c..ee8f5a970065 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -227,6 +227,128 @@ enum dlb2_user_interface_commands {
 	NUM_DLB2_CMD,
 };
 
+/*********************************/
+/* 'domain' device file commands */
+/*********************************/
+
+/*
+ * DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE: Configure a load-balanced queue.
+ * Input parameters:
+ * - num_atomic_inflights: This specifies the amount of temporary atomic QE
+ *	storage for this queue. If zero, the queue will not support atomic
+ *	scheduling.
+ * - num_sequence_numbers: This specifies the number of sequence numbers used
+ *	by this queue. If zero, the queue will not support ordered scheduling.
+ *	If non-zero, the queue will not support unordered scheduling.
+ * - num_qid_inflights: The maximum number of QEs that can be inflight
+ *	(scheduled to a CQ but not completed) at any time. If
+ *	num_sequence_numbers is non-zero, num_qid_inflights must be set equal
+ *	to num_sequence_numbers.
+ * - lock_id_comp_level: Lock ID compression level. Specifies the number of
+ *	unique lock IDs the queue should compress down to. Valid compression
+ *	levels: 0, 64, 128, 256, 512, 1k, 2k, 4k, 64k. If lock_id_comp_level is
+ *	0, the queue won't compress its lock IDs.
+ * - depth_threshold: DLB sets two bits in the received QE to indicate the
+ *	depth of the queue relative to the threshold before scheduling the
+ *	QE to a CQ:
+ *	- 2’b11: depth > threshold
+ *	- 2’b10: threshold >= depth > 0.75 * threshold
+ *	- 2’b01: 0.75 * threshold >= depth > 0.5 * threshold
+ *	- 2’b00: depth <= 0.5 * threshold
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Queue ID.
+ */
+struct dlb2_create_ldb_queue_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 num_sequence_numbers;
+	__u32 num_qid_inflights;
+	__u32 num_atomic_inflights;
+	__u32 lock_id_comp_level;
+	__u32 depth_threshold;
+	__u32 padding0;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE: Configure a directed queue.
+ * Input parameters:
+ * - port_id: Port ID. If the corresponding directed port is already created,
+ *	specify its ID here. Else this argument must be 0xFFFFFFFF to indicate
+ *	that the queue is being created before the port.
+ * - depth_threshold: DLB sets two bits in the received QE to indicate the
+ *	depth of the queue relative to the threshold before scheduling the
+ *	QE to a CQ:
+ *	- 2’b11: depth > threshold
+ *	- 2’b10: threshold >= depth > 0.75 * threshold
+ *	- 2’b01: 0.75 * threshold >= depth > 0.5 * threshold
+ *	- 2’b00: depth <= 0.5 * threshold
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Queue ID.
+ */
+struct dlb2_create_dir_queue_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__s32 port_id;
+	__u32 depth_threshold;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH: Get a load-balanced queue's depth.
+ * Input parameters:
+ * - queue_id: The load-balanced queue ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: queue depth.
+ */
+struct dlb2_get_ldb_queue_depth_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 queue_id;
+	__u32 padding0;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_DIR_QUEUE_DEPTH: Get a directed queue's depth.
+ * Input parameters:
+ * - queue_id: The directed queue ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: queue depth.
+ */
+struct dlb2_get_dir_queue_depth_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 queue_id;
+	__u32 padding0;
+};
+
+enum dlb2_domain_user_interface_commands {
+	DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,
+	DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
+	DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,
+	DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
+
+	/* NUM_DLB2_DOMAIN_CMD must be last */
+	NUM_DLB2_DOMAIN_CMD,
+};
+
 /********************/
 /* dlb2 ioctl codes */
 /********************/
@@ -245,5 +367,21 @@ enum dlb2_user_interface_commands {
 		_IOR(DLB2_IOC_MAGIC,				\
 		     DLB2_CMD_GET_NUM_RESOURCES,		\
 		     struct dlb2_get_num_resources_args)
+#define DLB2_IOC_CREATE_LDB_QUEUE				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,		\
+		      struct dlb2_create_ldb_queue_args)
+#define DLB2_IOC_CREATE_DIR_QUEUE				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,		\
+		      struct dlb2_create_dir_queue_args)
+#define DLB2_IOC_GET_LDB_QUEUE_DEPTH				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,	\
+		      struct dlb2_get_ldb_queue_depth_args)
+#define DLB2_IOC_GET_DIR_QUEUE_DEPTH				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,	\
+		      struct dlb2_get_dir_queue_depth_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

