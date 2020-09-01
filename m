Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1CEC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528FB207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbgIATXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:23:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:53437 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730049AbgIATVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:41 -0400
IronPort-SDR: J4z3gZ4QJys8Ej0m/I/802n6YHq9MLHApsuHWOKyVb75c5xbfzCrGGGejHr/wN6TBvnZDYvGxy
 k0qqz5TifGUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807333"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:32 -0700
IronPort-SDR: Wca0AL+y/ASP4igX1mhP0XWm/k+tiBunGM+CPbQDyJET1oFFImJGbGoAynz0NRcIz7z4Ze3r17
 plmNfaEivxEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480485"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:32 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 11/19] dlb2: add queue map and unmap ioctls
Date:   Tue,  1 Sep 2020 14:15:40 -0500
Message-Id: <20200901191548.31646-12-gage.eads@intel.com>
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

Load-balanced queues can be "mapped" to any number of load-balanced ports.
Once mapped, the port becomes a candidate to which the device can schedule
queue entries from the queue. If a port is unmapped from a queue, it is no
longer a candidate for scheduling from that queue.

The process for map and unmap is different depending on whether or not the
domain is started, because the process requires updating hardware
structures that are dynamically modified by the device when it's in use.
If the domain is not started, its ports and queues are guaranteed not to be
in active use.

If the domain is started, the map process must (temporarily) disable the
queue and wait for it to quiesce. Similarly, the unmap process must
(temporarily) disable the port and wait for it to quiesce. 'Quiesce' here
means the user processes any in-flight QEs.

It's possible that the thread that requires the map/unmap is the same one
which is responsible for doing the processing that would quiesce the
queue/port, thus the driver may have to complete the operation
asynchronously. To that end, the driver uses a workqueue that periodically
checks whether any outstanding operations can be completed. This workqueue
function is only scheduled when there is at least one outstanding map/unmap
operation.

To support this asynchronous operation while also providing a reasonably
usable user-interface, the driver maintains two views of the queue map
state:
- The hardware view: the actual queue map state in the device
- The user/software view: the queue map state as though the operations were
  synchronous.

While a map/unmap operation is inflight, these two views are out-of-sync.
When the user requests a new map/unmap operation, the driver verifies the
request against the software view, so the errors are synchronous from the
user’s perspective, then adds the request to the queue of in-progress
operations. When possible -- for example if the user requests to map a
queue and then immediately requests to unmap it -- the driver will coalesce
or cancel outstanding operations.

This commit also adds a pending-port-unmaps ioctl, that user-space can call
to query how many pending/outstanding unmap operations exist for a given
port.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    |   9 +
 drivers/misc/dlb2/dlb2_main.h     |  14 +
 drivers/misc/dlb2/dlb2_pf_ops.c   |  30 ++
 drivers/misc/dlb2/dlb2_resource.c | 789 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h | 111 ++++++
 include/uapi/linux/dlb2_user.h    |  79 ++++
 6 files changed, 1032 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 5b6d3b4c3297..0ab4a95fb34a 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -52,6 +52,9 @@ DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(start_domain)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(map_qid)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(unmap_qid)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(pending_port_unmaps)
 
 /*
  * Port creation ioctls don't use the callback template macro because they have
@@ -346,6 +349,12 @@ long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_domain_ioctl_get_dir_port_cq_fd(dev, dom, arg);
 	case DLB2_IOC_START_DOMAIN:
 		return dlb2_domain_ioctl_start_domain(dev, dom, arg);
+	case DLB2_IOC_MAP_QID:
+		return dlb2_domain_ioctl_map_qid(dev, dom, arg);
+	case DLB2_IOC_UNMAP_QID:
+		return dlb2_domain_ioctl_unmap_qid(dev, dom, arg);
+	case DLB2_IOC_PENDING_PORT_UNMAPS:
+		return dlb2_domain_ioctl_pending_port_unmaps(dev, dom, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index abe9808b4638..626a3311eb18 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -82,6 +82,18 @@ struct dlb2_device_ops {
 			    u32 domain_id,
 			    struct dlb2_start_domain_args *args,
 			    struct dlb2_cmd_response *resp);
+	int (*map_qid)(struct dlb2_hw *hw,
+		       u32 domain_id,
+		       struct dlb2_map_qid_args *args,
+		       struct dlb2_cmd_response *resp);
+	int (*unmap_qid)(struct dlb2_hw *hw,
+			 u32 domain_id,
+			 struct dlb2_unmap_qid_args *args,
+			 struct dlb2_cmd_response *resp);
+	int (*pending_port_unmaps)(struct dlb2_hw *hw,
+				   u32 domain_id,
+				   struct dlb2_pending_port_unmaps_args *args,
+				   struct dlb2_cmd_response *resp);
 	int (*get_num_resources)(struct dlb2_hw *hw,
 				 struct dlb2_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb2_hw *hw, u32 domain_id);
@@ -144,10 +156,12 @@ struct dlb2_dev {
 	 * hardware registers.
 	 */
 	struct mutex resource_mutex;
+	struct work_struct work;
 	enum dlb2_device_type type;
 	int id;
 	dev_t dev_number;
 	u8 domain_reset_failed;
+	u8 worker_launched;
 };
 
 int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id);
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 4ab4d9fe3f61..b531448d1a25 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -272,6 +272,33 @@ dlb2_pf_start_domain(struct dlb2_hw *hw,
 }
 
 static int
+dlb2_pf_map_qid(struct dlb2_hw *hw,
+		u32 id,
+		struct dlb2_map_qid_args *args,
+		struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_map_qid(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb2_pf_unmap_qid(struct dlb2_hw *hw,
+		  u32 id,
+		  struct dlb2_unmap_qid_args *args,
+		  struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_unmap_qid(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb2_pf_pending_port_unmaps(struct dlb2_hw *hw,
+			    u32 id,
+			    struct dlb2_pending_port_unmaps_args *args,
+			    struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_pending_port_unmaps(hw, id, args, resp, false, 0);
+}
+
+static int
 dlb2_pf_get_num_resources(struct dlb2_hw *hw,
 			  struct dlb2_get_num_resources_args *args)
 {
@@ -359,6 +386,9 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.create_ldb_port = dlb2_pf_create_ldb_port,
 	.create_dir_port = dlb2_pf_create_dir_port,
 	.start_domain = dlb2_pf_start_domain,
+	.map_qid = dlb2_pf_map_qid,
+	.unmap_qid = dlb2_pf_unmap_qid,
+	.pending_port_unmaps = dlb2_pf_pending_port_unmaps,
 	.get_num_resources = dlb2_pf_get_num_resources,
 	.reset_domain = dlb2_pf_reset_domain,
 	.ldb_port_owned_by_domain = dlb2_pf_ldb_port_owned_by_domain,
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 4d8b56a4b437..6afac8c99c06 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -238,6 +238,32 @@ static struct dlb2_hw_domain *dlb2_get_domain_from_id(struct dlb2_hw *hw,
 }
 
 static struct dlb2_ldb_port *
+dlb2_get_domain_used_ldb_port(u32 id,
+			      bool vdev_req,
+			      struct dlb2_hw_domain *domain)
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
+static struct dlb2_ldb_port *
 dlb2_get_domain_ldb_port(u32 id,
 			 bool vdev_req,
 			 struct dlb2_hw_domain *domain)
@@ -1331,6 +1357,64 @@ static int dlb2_verify_start_domain_args(struct dlb2_hw *hw,
 	return 0;
 }
 
+static int dlb2_verify_map_qid_args(struct dlb2_hw *hw,
+				    u32 domain_id,
+				    struct dlb2_map_qid_args *args,
+				    struct dlb2_cmd_response *resp,
+				    bool vdev_req,
+				    unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	struct dlb2_ldb_queue *queue;
+	int id;
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
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_ldb_port(id, vdev_req, domain);
+
+	if (!port || !port->configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	if (args->priority >= DLB2_QID_PRIORITIES) {
+		resp->status = DLB2_ST_INVALID_PRIORITY;
+		return -EINVAL;
+	}
+
+	queue = dlb2_get_domain_ldb_queue(args->qid, vdev_req, domain);
+
+	if (!queue || !queue->configured) {
+		resp->status = DLB2_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	if (queue->domain_id.phys_id != domain->id.phys_id) {
+		resp->status = DLB2_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	if (port->domain_id.phys_id != domain->id.phys_id) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool dlb2_port_find_slot(struct dlb2_ldb_port *port,
 				enum dlb2_qid_map_state state,
 				int *slot)
@@ -1365,6 +1449,26 @@ static bool dlb2_port_find_slot_queue(struct dlb2_ldb_port *port,
 	return (i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ);
 }
 
+static bool
+dlb2_port_find_slot_with_pending_map_queue(struct dlb2_ldb_port *port,
+					   struct dlb2_ldb_queue *queue,
+					   int *slot)
+{
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		struct dlb2_ldb_port_qid_map *map = &port->qid_map[i];
+
+		if (map->state == DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP &&
+		    map->pending_qid == queue->id.phys_id)
+			break;
+	}
+
+	*slot = i;
+
+	return (i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ);
+}
+
 static int dlb2_port_slot_state_transition(struct dlb2_hw *hw,
 					   struct dlb2_ldb_port *port,
 					   struct dlb2_ldb_queue *queue,
@@ -1492,6 +1596,117 @@ static int dlb2_port_slot_state_transition(struct dlb2_hw *hw,
 	return -EFAULT;
 }
 
+static int dlb2_verify_map_qid_slot_available(struct dlb2_ldb_port *port,
+					      struct dlb2_ldb_queue *queue,
+					      struct dlb2_cmd_response *resp)
+{
+	enum dlb2_qid_map_state state;
+	int i;
+
+	/* Unused slot available? */
+	if (port->num_mappings < DLB2_MAX_NUM_QIDS_PER_LDB_CQ)
+		return 0;
+
+	/*
+	 * If the queue is already mapped (from the application's perspective),
+	 * this is simply a priority update.
+	 */
+	state = DLB2_QUEUE_MAPPED;
+	if (dlb2_port_find_slot_queue(port, state, queue, &i))
+		return 0;
+
+	state = DLB2_QUEUE_MAP_IN_PROG;
+	if (dlb2_port_find_slot_queue(port, state, queue, &i))
+		return 0;
+
+	if (dlb2_port_find_slot_with_pending_map_queue(port, queue, &i))
+		return 0;
+
+	/*
+	 * If the slot contains an unmap in progress, it's considered
+	 * available.
+	 */
+	state = DLB2_QUEUE_UNMAP_IN_PROG;
+	if (dlb2_port_find_slot(port, state, &i))
+		return 0;
+
+	state = DLB2_QUEUE_UNMAPPED;
+	if (dlb2_port_find_slot(port, state, &i))
+		return 0;
+
+	resp->status = DLB2_ST_NO_QID_SLOTS_AVAILABLE;
+	return -EINVAL;
+}
+
+static int dlb2_verify_unmap_qid_args(struct dlb2_hw *hw,
+				      u32 domain_id,
+				      struct dlb2_unmap_qid_args *args,
+				      struct dlb2_cmd_response *resp,
+				      bool vdev_req,
+				      unsigned int vdev_id)
+{
+	enum dlb2_qid_map_state state;
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_queue *queue;
+	struct dlb2_ldb_port *port;
+	int slot;
+	int id;
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
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_ldb_port(id, vdev_req, domain);
+
+	if (!port || !port->configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	if (port->domain_id.phys_id != domain->id.phys_id) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	queue = dlb2_get_domain_ldb_queue(args->qid, vdev_req, domain);
+
+	if (!queue || !queue->configured) {
+		DLB2_HW_ERR(hw, "[%s()] Can't unmap unconfigured queue %d\n",
+			    __func__, args->qid);
+		resp->status = DLB2_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	/*
+	 * Verify that the port has the queue mapped. From the application's
+	 * perspective a queue is mapped if it is actually mapped, the map is
+	 * in progress, or the map is blocked pending an unmap.
+	 */
+	state = DLB2_QUEUE_MAPPED;
+	if (dlb2_port_find_slot_queue(port, state, queue, &slot))
+		return 0;
+
+	state = DLB2_QUEUE_MAP_IN_PROG;
+	if (dlb2_port_find_slot_queue(port, state, queue, &slot))
+		return 0;
+
+	if (dlb2_port_find_slot_with_pending_map_queue(port, queue, &slot))
+		return 0;
+
+	resp->status = DLB2_ST_INVALID_QID;
+	return -EINVAL;
+}
+
 static void dlb2_configure_domain_credits(struct dlb2_hw *hw,
 					  struct dlb2_hw_domain *domain)
 {
@@ -2304,6 +2519,26 @@ static int dlb2_ldb_port_map_qid_static(struct dlb2_hw *hw,
 	return dlb2_port_slot_state_transition(hw, p, q, i, state);
 }
 
+static void dlb2_ldb_port_change_qid_priority(struct dlb2_hw *hw,
+					      struct dlb2_ldb_port *port,
+					      int slot,
+					      struct dlb2_map_qid_args *args)
+{
+	union dlb2_lsp_cq2priov r0;
+
+	/* Read-modify-write the priority and valid bit register */
+	r0.val = DLB2_CSR_RD(hw, DLB2_LSP_CQ2PRIOV(port->id.phys_id));
+
+	r0.field.v |= 1 << slot;
+	r0.field.prio |= (args->priority & 0x7) << slot * 3;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ2PRIOV(port->id.phys_id), r0.val);
+
+	dlb2_flush_csr(hw);
+
+	port->qid_map[slot].priority = args->priority;
+}
+
 static int dlb2_ldb_port_set_has_work_bits(struct dlb2_hw *hw,
 					   struct dlb2_ldb_port *port,
 					   struct dlb2_ldb_queue *queue,
@@ -2543,6 +2778,62 @@ static int dlb2_ldb_port_finish_map_qid_dynamic(struct dlb2_hw *hw,
 	return 0;
 }
 
+static unsigned int dlb2_finish_unmap_qid_procedures(struct dlb2_hw *hw);
+static unsigned int dlb2_finish_map_qid_procedures(struct dlb2_hw *hw);
+
+/*
+ * The workqueue callback runs until it completes all outstanding QID->CQ
+ * map and unmap requests. To prevent deadlock, this function gives other
+ * threads a chance to grab the resource mutex and configure hardware.
+ */
+static void dlb2_complete_queue_map_unmap(struct work_struct *work)
+{
+	struct dlb2_dev *dlb2_dev;
+	int ret;
+
+	dlb2_dev = container_of(work, struct dlb2_dev, work);
+
+	mutex_lock(&dlb2_dev->resource_mutex);
+
+	ret = dlb2_finish_unmap_qid_procedures(&dlb2_dev->hw);
+	ret += dlb2_finish_map_qid_procedures(&dlb2_dev->hw);
+
+	if (ret != 0)
+		/*
+		 * Relinquish the CPU so the application can process its CQs,
+		 * so this function doesn't deadlock.
+		 */
+		schedule_work(&dlb2_dev->work);
+	else
+		dlb2_dev->worker_launched = false;
+
+	mutex_unlock(&dlb2_dev->resource_mutex);
+}
+
+/**
+ * dlb2_schedule_work() - launch a thread to process pending map and unmap work
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function launches a kernel thread that will run until all pending
+ * map and unmap procedures are complete.
+ */
+static void dlb2_schedule_work(struct dlb2_hw *hw)
+{
+	struct dlb2_dev *dlb2_dev;
+
+	dlb2_dev = container_of(hw, struct dlb2_dev, hw);
+
+	/* Nothing to do if the worker is already running */
+	if (dlb2_dev->worker_launched)
+		return;
+
+	INIT_WORK(&dlb2_dev->work, dlb2_complete_queue_map_unmap);
+
+	schedule_work(&dlb2_dev->work);
+
+	dlb2_dev->worker_launched = true;
+}
+
 /**
  * dlb2_ldb_port_map_qid_dynamic() - perform a "dynamic" QID->CQ mapping
  * @hw: dlb2_hw handle for a particular device.
@@ -2600,6 +2891,20 @@ static int dlb2_ldb_port_map_qid_dynamic(struct dlb2_hw *hw,
 	if (ret)
 		return ret;
 
+	r0.val = DLB2_CSR_RD(hw,
+			     DLB2_LSP_QID_LDB_INFL_CNT(queue->id.phys_id));
+
+	if (r0.field.count) {
+		/*
+		 * The queue is owed completions so it's not safe to map it
+		 * yet. Schedule a kernel thread to complete the mapping later,
+		 * once software has completed all the queue's inflight events.
+		 */
+		dlb2_schedule_work(hw);
+
+		return 1;
+	}
+
 	/*
 	 * Disable the affected CQ, and the CQs already mapped to the QID,
 	 * before reading the QID's inflight count a second time. There is an
@@ -2622,6 +2927,13 @@ static int dlb2_ldb_port_map_qid_dynamic(struct dlb2_hw *hw,
 
 		dlb2_ldb_queue_enable_mapped_cqs(hw, domain, queue);
 
+		/*
+		 * The queue is owed completions so it's not safe to map it
+		 * yet. Schedule a kernel thread to complete the mapping later,
+		 * once software has completed all the queue's inflight events.
+		 */
+		dlb2_schedule_work(hw);
+
 		return 1;
 	}
 
@@ -3480,6 +3792,20 @@ dlb2_domain_finish_unmap_qid_procedures(struct dlb2_hw *hw,
 	return domain->num_pending_removals;
 }
 
+static unsigned int dlb2_finish_unmap_qid_procedures(struct dlb2_hw *hw)
+{
+	int i, num = 0;
+
+	/* Finish queue unmap jobs for any domain that needs it */
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++) {
+		struct dlb2_hw_domain *domain = &hw->domains[i];
+
+		num += dlb2_domain_finish_unmap_qid_procedures(hw, domain);
+	}
+
+	return num;
+}
+
 static void dlb2_domain_finish_map_port(struct dlb2_hw *hw,
 					struct dlb2_hw_domain *domain,
 					struct dlb2_ldb_port *port)
@@ -3556,6 +3882,427 @@ dlb2_domain_finish_map_qid_procedures(struct dlb2_hw *hw,
 	return domain->num_pending_additions;
 }
 
+static unsigned int dlb2_finish_map_qid_procedures(struct dlb2_hw *hw)
+{
+	int i, num = 0;
+
+	/* Finish queue map jobs for any domain that needs it */
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++) {
+		struct dlb2_hw_domain *domain = &hw->domains[i];
+
+		num += dlb2_domain_finish_map_qid_procedures(hw, domain);
+	}
+
+	return num;
+}
+
+static void dlb2_log_map_qid(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_map_qid_args *args,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 map QID arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tPort ID:   %d\n",
+		    args->port_id);
+	DLB2_HW_DBG(hw, "\tQueue ID:  %d\n",
+		    args->qid);
+	DLB2_HW_DBG(hw, "\tPriority:  %d\n",
+		    args->priority);
+}
+
+int dlb2_hw_map_qid(struct dlb2_hw *hw,
+		    u32 domain_id,
+		    struct dlb2_map_qid_args *args,
+		    struct dlb2_cmd_response *resp,
+		    bool vdev_req,
+		    unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_queue *queue;
+	enum dlb2_qid_map_state st;
+	struct dlb2_ldb_port *port;
+	int ret, i, id;
+	u8 prio;
+
+	dlb2_log_map_qid(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_map_qid_args(hw,
+				       domain_id,
+				       args,
+				       resp,
+				       vdev_req,
+				       vdev_id);
+	if (ret)
+		return ret;
+
+	prio = args->priority;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+	if (!domain) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: domain not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_ldb_port(id, vdev_req, domain);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	queue = dlb2_get_domain_ldb_queue(args->qid, vdev_req, domain);
+	if (!queue) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: queue not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/*
+	 * If there are any outstanding detach operations for this port,
+	 * attempt to complete them. This may be necessary to free up a QID
+	 * slot for this requested mapping.
+	 */
+	if (port->num_pending_removals)
+		dlb2_domain_finish_unmap_port(hw, domain, port);
+
+	ret = dlb2_verify_map_qid_slot_available(port, queue, resp);
+	if (ret)
+		return ret;
+
+	/* Hardware requires disabling the CQ before mapping QIDs. */
+	if (port->enabled)
+		dlb2_ldb_port_cq_disable(hw, port);
+
+	/*
+	 * If this is only a priority change, don't perform the full QID->CQ
+	 * mapping procedure
+	 */
+	st = DLB2_QUEUE_MAPPED;
+	if (dlb2_port_find_slot_queue(port, st, queue, &i)) {
+		if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+			DLB2_HW_ERR(hw,
+				    "[%s():%d] Internal error: port slot tracking failed\n",
+				    __func__, __LINE__);
+			return -EFAULT;
+		}
+
+		if (prio != port->qid_map[i].priority) {
+			dlb2_ldb_port_change_qid_priority(hw, port, i, args);
+			DLB2_HW_DBG(hw, "DLB2 map: priority change\n");
+		}
+
+		st = DLB2_QUEUE_MAPPED;
+		ret = dlb2_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto map_qid_done;
+	}
+
+	st = DLB2_QUEUE_UNMAP_IN_PROG;
+	if (dlb2_port_find_slot_queue(port, st, queue, &i)) {
+		if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+			DLB2_HW_ERR(hw,
+				    "[%s():%d] Internal error: port slot tracking failed\n",
+				    __func__, __LINE__);
+			return -EFAULT;
+		}
+
+		if (prio != port->qid_map[i].priority) {
+			dlb2_ldb_port_change_qid_priority(hw, port, i, args);
+			DLB2_HW_DBG(hw, "DLB2 map: priority change\n");
+		}
+
+		st = DLB2_QUEUE_MAPPED;
+		ret = dlb2_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto map_qid_done;
+	}
+
+	/*
+	 * If this is a priority change on an in-progress mapping, don't
+	 * perform the full QID->CQ mapping procedure.
+	 */
+	st = DLB2_QUEUE_MAP_IN_PROG;
+	if (dlb2_port_find_slot_queue(port, st, queue, &i)) {
+		if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+			DLB2_HW_ERR(hw,
+				    "[%s():%d] Internal error: port slot tracking failed\n",
+				    __func__, __LINE__);
+			return -EFAULT;
+		}
+
+		port->qid_map[i].priority = prio;
+
+		DLB2_HW_DBG(hw, "DLB2 map: priority change only\n");
+
+		goto map_qid_done;
+	}
+
+	/*
+	 * If this is a priority change on a pending mapping, update the
+	 * pending priority
+	 */
+	if (dlb2_port_find_slot_with_pending_map_queue(port, queue, &i)) {
+		if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+			DLB2_HW_ERR(hw,
+				    "[%s():%d] Internal error: port slot tracking failed\n",
+				    __func__, __LINE__);
+			return -EFAULT;
+		}
+
+		port->qid_map[i].pending_priority = prio;
+
+		DLB2_HW_DBG(hw, "DLB2 map: priority change only\n");
+
+		goto map_qid_done;
+	}
+
+	/*
+	 * If all the CQ's slots are in use, then there's an unmap in progress
+	 * (guaranteed by dlb2_verify_map_qid_slot_available()), so add this
+	 * mapping to pending_map and return. When the removal is completed for
+	 * the slot's current occupant, this mapping will be performed.
+	 */
+	if (!dlb2_port_find_slot(port, DLB2_QUEUE_UNMAPPED, &i)) {
+		if (dlb2_port_find_slot(port, DLB2_QUEUE_UNMAP_IN_PROG, &i)) {
+			enum dlb2_qid_map_state st;
+
+			if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+				DLB2_HW_ERR(hw,
+					    "[%s():%d] Internal error: port slot tracking failed\n",
+					    __func__, __LINE__);
+				return -EFAULT;
+			}
+
+			port->qid_map[i].pending_qid = queue->id.phys_id;
+			port->qid_map[i].pending_priority = prio;
+
+			st = DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP;
+
+			ret = dlb2_port_slot_state_transition(hw, port, queue,
+							      i, st);
+			if (ret)
+				return ret;
+
+			DLB2_HW_DBG(hw, "DLB2 map: map pending removal\n");
+
+			goto map_qid_done;
+		}
+	}
+
+	/*
+	 * If the domain has started, a special "dynamic" CQ->queue mapping
+	 * procedure is required in order to safely update the CQ<->QID tables.
+	 * The "static" procedure cannot be used when traffic is flowing,
+	 * because the CQ<->QID tables cannot be updated atomically and the
+	 * scheduler won't see the new mapping unless the queue's if_status
+	 * changes, which isn't guaranteed.
+	 */
+	ret = dlb2_ldb_port_map_qid(hw, domain, port, queue, prio);
+
+	/* If ret is less than zero, it's due to an internal error */
+	if (ret < 0)
+		return ret;
+
+map_qid_done:
+	if (port->enabled)
+		dlb2_ldb_port_cq_enable(hw, port);
+
+	resp->status = 0;
+
+	return 0;
+}
+
+static void dlb2_log_unmap_qid(struct dlb2_hw *hw,
+			       u32 domain_id,
+			       struct dlb2_unmap_qid_args *args,
+			       bool vdev_req,
+			       unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 unmap QID arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tPort ID:   %d\n",
+		    args->port_id);
+	DLB2_HW_DBG(hw, "\tQueue ID:  %d\n",
+		    args->qid);
+	if (args->qid < DLB2_MAX_NUM_LDB_QUEUES)
+		DLB2_HW_DBG(hw, "\tQueue's num mappings:  %d\n",
+			    hw->rsrcs.ldb_queues[args->qid].num_mappings);
+}
+
+int dlb2_hw_unmap_qid(struct dlb2_hw *hw,
+		      u32 domain_id,
+		      struct dlb2_unmap_qid_args *args,
+		      struct dlb2_cmd_response *resp,
+		      bool vdev_req,
+		      unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_queue *queue;
+	enum dlb2_qid_map_state st;
+	struct dlb2_ldb_port *port;
+	bool unmap_complete;
+	int i, ret, id;
+
+	dlb2_log_unmap_qid(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_unmap_qid_args(hw,
+					 domain_id,
+					 args,
+					 resp,
+					 vdev_req,
+					 vdev_id);
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
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_ldb_port(id, vdev_req, domain);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	queue = dlb2_get_domain_ldb_queue(args->qid, vdev_req, domain);
+	if (!queue) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: queue not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/*
+	 * If the queue hasn't been mapped yet, we need to update the slot's
+	 * state and re-enable the queue's inflights.
+	 */
+	st = DLB2_QUEUE_MAP_IN_PROG;
+	if (dlb2_port_find_slot_queue(port, st, queue, &i)) {
+		if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+			DLB2_HW_ERR(hw,
+				    "[%s():%d] Internal error: port slot tracking failed\n",
+				    __func__, __LINE__);
+			return -EFAULT;
+		}
+
+		/*
+		 * Since the in-progress map was aborted, re-enable the QID's
+		 * inflights.
+		 */
+		if (queue->num_pending_additions == 0)
+			dlb2_ldb_queue_set_inflight_limit(hw, queue);
+
+		st = DLB2_QUEUE_UNMAPPED;
+		ret = dlb2_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto unmap_qid_done;
+	}
+
+	/*
+	 * If the queue mapping is on hold pending an unmap, we simply need to
+	 * update the slot's state.
+	 */
+	if (dlb2_port_find_slot_with_pending_map_queue(port, queue, &i)) {
+		if (i >= DLB2_MAX_NUM_QIDS_PER_LDB_CQ) {
+			DLB2_HW_ERR(hw,
+				    "[%s():%d] Internal error: port slot tracking failed\n",
+				    __func__, __LINE__);
+			return -EFAULT;
+		}
+
+		st = DLB2_QUEUE_UNMAP_IN_PROG;
+		ret = dlb2_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto unmap_qid_done;
+	}
+
+	st = DLB2_QUEUE_MAPPED;
+	if (!dlb2_port_find_slot_queue(port, st, queue, &i)) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: no available CQ slots\n",
+			    __func__);
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
+	/*
+	 * QID->CQ mapping removal is an asychronous procedure. It requires
+	 * stopping the DLB2 from scheduling this CQ, draining all inflights
+	 * from the CQ, then unmapping the queue from the CQ. This function
+	 * simply marks the port as needing the queue unmapped, and (if
+	 * necessary) starts the unmapping worker thread.
+	 */
+	dlb2_ldb_port_cq_disable(hw, port);
+
+	st = DLB2_QUEUE_UNMAP_IN_PROG;
+	ret = dlb2_port_slot_state_transition(hw, port, queue, i, st);
+	if (ret)
+		return ret;
+
+	/*
+	 * Attempt to finish the unmapping now, in case the port has no
+	 * outstanding inflights. If that's not the case, this will fail and
+	 * the unmapping will be completed at a later time.
+	 */
+	unmap_complete = dlb2_domain_finish_unmap_port(hw, domain, port);
+
+	/*
+	 * If the unmapping couldn't complete immediately, launch the worker
+	 * thread (if it isn't already launched) to finish it later.
+	 */
+	if (!unmap_complete)
+		dlb2_schedule_work(hw);
+
+unmap_qid_done:
+	resp->status = 0;
+
+	return 0;
+}
+
 static u32 dlb2_ldb_cq_inflight_count(struct dlb2_hw *hw,
 				      struct dlb2_ldb_port *port)
 {
@@ -3890,6 +4637,48 @@ int dlb2_hw_get_dir_queue_depth(struct dlb2_hw *hw,
 	return 0;
 }
 
+static void
+dlb2_log_pending_port_unmaps_args(struct dlb2_hw *hw,
+				  struct dlb2_pending_port_unmaps_args *args,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB unmaps in progress arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from VF %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tPort ID: %d\n", args->port_id);
+}
+
+int dlb2_hw_pending_port_unmaps(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_pending_port_unmaps_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vdev_req,
+				unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+
+	dlb2_log_pending_port_unmaps_args(hw, args, vdev_req, vdev_id);
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	port = dlb2_get_domain_used_ldb_port(args->port_id, vdev_req, domain);
+	if (!port || !port->configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	resp->id = port->num_pending_removals;
+
+	return 0;
+}
+
 static u32 dlb2_ldb_queue_depth(struct dlb2_hw *hw,
 				struct dlb2_ldb_queue *queue)
 {
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index d5b554b701f5..4843da49935f 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -239,6 +239,92 @@ int dlb2_hw_start_domain(struct dlb2_hw *hw,
 			 unsigned int vdev_id);
 
 /**
+ * dlb2_hw_map_qid() - map a load-balanced queue to a load-balanced port
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: map QID arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs from the specified queue
+ * to the specified port. Each load-balanced port can be mapped to up to 8
+ * queues; each load-balanced queue can potentially map to all the
+ * load-balanced ports.
+ *
+ * A successful return does not necessarily mean the mapping was configured. If
+ * this function is unable to immediately map the queue to the port, it will
+ * add the requested operation to a per-port list of pending map/unmap
+ * operations, and (if it's not already running) launch a kernel thread that
+ * periodically attempts to process all pending operations. In a sense, this is
+ * an asynchronous function.
+ *
+ * This asynchronicity creates two views of the state of hardware: the actual
+ * hardware state and the requested state (as if every request completed
+ * immediately). If there are any pending map/unmap operations, the requested
+ * state will differ from the actual state. All validation is performed with
+ * respect to the pending state; for instance, if there are 8 pending map
+ * operations for port X, a request for a 9th will fail because a load-balanced
+ * port can only map up to 8 queues.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, invalid port or queue ID, or
+ *	    the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_map_qid(struct dlb2_hw *hw,
+		    u32 domain_id,
+		    struct dlb2_map_qid_args *args,
+		    struct dlb2_cmd_response *resp,
+		    bool vdev_request,
+		    unsigned int vdev_id);
+
+/**
+ * dlb2_hw_unmap_qid() - Unmap a load-balanced queue from a load-balanced port
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: unmap QID arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs from the specified
+ * queue to the specified port.
+ *
+ * A successful return does not necessarily mean the mapping was removed. If
+ * this function is unable to immediately unmap the queue from the port, it
+ * will add the requested operation to a per-port list of pending map/unmap
+ * operations, and (if it's not already running) launch a kernel thread that
+ * periodically attempts to process all pending operations. See
+ * dlb2_hw_map_qid() for more details.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, invalid port or queue ID, or
+ *	    the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_unmap_qid(struct dlb2_hw *hw,
+		      u32 domain_id,
+		      struct dlb2_unmap_qid_args *args,
+		      struct dlb2_cmd_response *resp,
+		      bool vdev_request,
+		      unsigned int vdev_id);
+
+/**
  * dlb2_reset_domain() - reset a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @domain_id: domain ID.
@@ -417,6 +503,31 @@ enum dlb2_virt_mode {
 };
 
 /**
+ * dlb2_hw_pending_port_unmaps() - returns the number of unmap operations in
+ *	progress.
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: number of unmaps in progress args
+ * @resp: response structure.
+ * @vf_request: indicates whether this request came from a VF.
+ * @vf_id: If vf_request is true, this contains the VF's ID.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the number of unmaps in progress.
+ *
+ * Errors:
+ * EINVAL - Invalid port ID.
+ */
+int dlb2_hw_pending_port_unmaps(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_pending_port_unmaps_args *args,
+				struct dlb2_cmd_response *resp,
+				bool vf_request,
+				unsigned int vf_id);
+
+/**
  * dlb2_hw_enable_sparse_ldb_cq_mode() - enable sparse mode for load-balanced
  *	ports.
  * @hw: dlb2_hw handle for a particular device.
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 0eb9e14de11d..1fdc7627c393 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -473,6 +473,70 @@ struct dlb2_start_domain_args {
 	struct dlb2_cmd_response response;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_MAP_QID: Map a load-balanced queue to a load-balanced port.
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - qid: Load-balanced queue ID.
+ * - priority: Queue->port service priority.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_map_qid_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 qid;
+	__u32 priority;
+	__u32 padding0;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_UNMAP_QID: Unmap a load-balanced queue to a load-balanced
+ *	port.
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - qid: Load-balanced queue ID.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_unmap_qid_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 qid;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_PENDING_PORT_UNMAPS: Get number of queue unmap operations in
+ *	progress for a load-balanced port.
+ *
+ *	Note: This is a snapshot; the number of unmap operations in progress
+ *	is subject to change at any time.
+ *
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: number of unmaps in progress.
+ */
+struct dlb2_pending_port_unmaps_args {
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
@@ -485,6 +549,9 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_GET_DIR_PORT_PP_FD,
 	DLB2_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,
 	DLB2_DOMAIN_CMD_START_DOMAIN,
+	DLB2_DOMAIN_CMD_MAP_QID,
+	DLB2_DOMAIN_CMD_UNMAP_QID,
+	DLB2_DOMAIN_CMD_PENDING_PORT_UNMAPS,
 
 	/* NUM_DLB2_DOMAIN_CMD must be last */
 	NUM_DLB2_DOMAIN_CMD,
@@ -563,5 +630,17 @@ enum dlb2_domain_user_interface_commands {
 		_IOR(DLB2_IOC_MAGIC,				\
 		     DLB2_DOMAIN_CMD_START_DOMAIN,		\
 		     struct dlb2_start_domain_args)
+#define DLB2_IOC_MAP_QID					\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_MAP_QID,			\
+		      struct dlb2_map_qid_args)
+#define DLB2_IOC_UNMAP_QID					\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_UNMAP_QID,		\
+		      struct dlb2_unmap_qid_args)
+#define DLB2_IOC_PENDING_PORT_UNMAPS				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_PENDING_PORT_UNMAPS,	\
+		      struct dlb2_pending_port_unmaps_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

