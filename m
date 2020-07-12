Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2788DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F2C206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgGLNv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:51:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:8847 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgGLNv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:51:58 -0400
IronPort-SDR: oxCWCt4GtfzHximlfOEB6jbdcDoWJQZOXnRkFY2e41BtjLcC81OmWO9n0ip8+PC4MI2DJQVl6X
 lQPhrDqqa0QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540904"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:49 -0700
IronPort-SDR: bZ8qMY1Z3cSG6MHwD42GvbIJls+EfJUMx0a6R4dcN4LJIEZQ+1Z+XU8aPdyCG7XY9GGwrYpnz8
 SzvGIBTlURRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148627"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:48 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 11/20] dlb2: add start domain ioctl
Date:   Sun, 12 Jul 2020 08:43:22 -0500
Message-Id: <20200712134331.8169-12-gage.eads@intel.com>
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

Once a scheduling domain and its resources have been configured, the start
domain ioctl is called to enable its ports to begin enqueueing to the
device. Once started, the domain's resources cannot be configured again
until after the domain is reset.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    |   2 +
 drivers/misc/dlb2/dlb2_main.h     |   4 ++
 drivers/misc/dlb2/dlb2_pf_ops.c   |  10 ++++
 drivers/misc/dlb2/dlb2_resource.c | 120 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h |  30 ++++++++++
 include/uapi/linux/dlb2_user.h    |  24 ++++++++
 6 files changed, 190 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index b4d40de9d0dc..6369798fc53e 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -93,6 +93,7 @@ static int dlb2_domain_ioctl_##lower_name(struct dlb2_dev *dev,		   \
 
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_ldb_queue)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(start_domain)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
 
@@ -465,6 +466,7 @@ dlb2_domain_ioctl_callback_fns[NUM_DLB2_DOMAIN_CMD] = {
 	dlb2_domain_ioctl_create_dir_queue,
 	dlb2_domain_ioctl_create_ldb_port,
 	dlb2_domain_ioctl_create_dir_port,
+	dlb2_domain_ioctl_start_domain,
 	dlb2_domain_ioctl_get_ldb_queue_depth,
 	dlb2_domain_ioctl_get_dir_queue_depth,
 	dlb2_domain_ioctl_get_ldb_port_pp_fd,
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 537f849b0597..dabe798f7da9 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -78,6 +78,10 @@ struct dlb2_device_ops {
 			       struct dlb2_create_dir_port_args *args,
 			       uintptr_t cq_dma_base,
 			       struct dlb2_cmd_response *resp);
+	int (*start_domain)(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_start_domain_args *args,
+			    struct dlb2_cmd_response *resp);
 	int (*get_num_resources)(struct dlb2_hw *hw,
 				 struct dlb2_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb2_hw *hw, u32 domain_id);
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index c3044d603263..fb2f914a99a4 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -282,6 +282,15 @@ dlb2_pf_create_dir_port(struct dlb2_hw *hw,
 }
 
 static int
+dlb2_pf_start_domain(struct dlb2_hw *hw,
+		     u32 id,
+		     struct dlb2_start_domain_args *args,
+		     struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_start_domain(hw, id, args, resp, false, 0);
+}
+
+static int
 dlb2_pf_get_num_resources(struct dlb2_hw *hw,
 			  struct dlb2_get_num_resources_args *args)
 {
@@ -368,6 +377,7 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.create_dir_queue = dlb2_pf_create_dir_queue,
 	.create_ldb_port = dlb2_pf_create_ldb_port,
 	.create_dir_port = dlb2_pf_create_dir_port,
+	.start_domain = dlb2_pf_start_domain,
 	.get_num_resources = dlb2_pf_get_num_resources,
 	.reset_domain = dlb2_pf_reset_domain,
 	.ldb_port_owned_by_domain = dlb2_pf_ldb_port_owned_by_domain,
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 1de4ef9ae405..6e98b68972f5 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -1303,6 +1303,34 @@ dlb2_verify_create_dir_port_args(struct dlb2_hw *hw,
 	return 0;
 }
 
+static int dlb2_verify_start_domain_args(struct dlb2_hw *hw,
+					 u32 domain_id,
+					 struct dlb2_cmd_response *resp,
+					 bool vdev_req,
+					 unsigned int vdev_id)
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
+	return 0;
+}
+
 static bool dlb2_port_find_slot(struct dlb2_ldb_port *port,
 				enum dlb2_qid_map_state state,
 				int *slot)
@@ -3259,6 +3287,98 @@ int dlb2_hw_create_dir_port(struct dlb2_hw *hw,
 	return 0;
 }
 
+static void dlb2_log_start_domain(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 start domain arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+}
+
+/**
+ * dlb2_hw_start_domain() - Lock the domain configuration
+ * @hw:	Contains the current state of the DLB2 hardware.
+ * @domain_id: Domain ID
+ * @arg: User-provided arguments (unused, here for ioctl callback template).
+ * @resp: Response to user.
+ * @vdev_req: Request came from a virtual device.
+ * @vdev_id: If vdev_req is true, this contains the virtual device's ID.
+ *
+ * Return: returns < 0 on error, 0 otherwise. If the driver is unable to
+ * satisfy a request, resp->status will be set accordingly.
+ */
+int
+dlb2_hw_start_domain(struct dlb2_hw *hw,
+		     u32 domain_id,
+		     __attribute((unused)) struct dlb2_start_domain_args *arg,
+		     struct dlb2_cmd_response *resp,
+		     bool vdev_req,
+		     unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *dir_queue;
+	struct dlb2_ldb_queue *ldb_queue;
+	struct dlb2_hw_domain *domain;
+	int ret;
+
+	dlb2_log_start_domain(hw, domain_id, vdev_req, vdev_id);
+
+	ret = dlb2_verify_start_domain_args(hw,
+					    domain_id,
+					    resp,
+					    vdev_req,
+					    vdev_id);
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
+	/*
+	 * Enable load-balanced and directed queue write permissions for the
+	 * queues this domain owns. Without this, the DLB2 will drop all
+	 * incoming traffic to those queues.
+	 */
+	DLB2_DOM_LIST_FOR(domain->used_ldb_queues, ldb_queue) {
+		union dlb2_sys_ldb_vasqid_v r0 = { {0} };
+		unsigned int offs;
+
+		r0.field.vasqid_v = 1;
+
+		offs = domain->id.phys_id * DLB2_MAX_NUM_LDB_QUEUES +
+			ldb_queue->id.phys_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_LDB_VASQID_V(offs), r0.val);
+	}
+
+	DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, dir_queue) {
+		union dlb2_sys_dir_vasqid_v r0 = { {0} };
+		unsigned int offs;
+
+		r0.field.vasqid_v = 1;
+
+		offs = domain->id.phys_id * DLB2_MAX_NUM_DIR_PORTS +
+			dir_queue->id.phys_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_DIR_VASQID_V(offs), r0.val);
+	}
+
+	dlb2_flush_csr(hw);
+
+	domain->started = true;
+
+	resp->status = 0;
+
+	return 0;
+}
+
 static void
 dlb2_domain_finish_unmap_port_slot(struct dlb2_hw *hw,
 				   struct dlb2_hw_domain *domain,
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index 47b0d6f785fb..cd865c756c6d 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -209,6 +209,36 @@ int dlb2_hw_create_ldb_port(struct dlb2_hw *hw,
 			    unsigned int vdev_id);
 
 /**
+ * dlb2_hw_start_domain() - start a scheduling domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: start domain arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function starts a scheduling domain, which allows applications to send
+ * traffic through it. Once a domain is started, its resources can no longer be
+ * configured (besides QID remapping and port enable/disable).
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - the domain is not configured, or the domain is already started.
+ */
+int dlb2_hw_start_domain(struct dlb2_hw *hw,
+			 u32 domain_id,
+			 struct dlb2_start_domain_args *args,
+			 struct dlb2_cmd_response *resp,
+			 bool vdev_request,
+			 unsigned int vdev_id);
+
+/**
  * dlb2_reset_domain() - reset a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @domain_id: domain ID.
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index b0aba1ba5e3f..d409586466b1 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -471,6 +471,25 @@ struct dlb2_create_dir_port_args {
 };
 
 /*
+ * DLB2_DOMAIN_CMD_START_DOMAIN: Mark the end of the domain configuration. This
+ *	must be called before passing QEs into the device, and no configuration
+ *	ioctls can be issued once the domain has started. Sending QEs into the
+ *	device before calling this ioctl will result in undefined behavior.
+ * Input parameters:
+ * - (None)
+ *
+ * Output parameters:
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ */
+struct dlb2_start_domain_args {
+	/* Output parameters */
+	__u64 response;
+	/* Input parameters */
+};
+
+/*
  * DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH: Get a load-balanced queue's depth.
  * Input parameters:
  * - queue_id: The load-balanced queue ID.
@@ -550,6 +569,7 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
 	DLB2_DOMAIN_CMD_CREATE_LDB_PORT,
 	DLB2_DOMAIN_CMD_CREATE_DIR_PORT,
+	DLB2_DOMAIN_CMD_START_DOMAIN,
 	DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,
 	DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
 	DLB2_DOMAIN_CMD_GET_LDB_PORT_PP_FD,
@@ -614,6 +634,10 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_CREATE_DIR_PORT,		\
 		      struct dlb2_create_dir_port_args)
+#define DLB2_IOC_START_DOMAIN					\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_START_DOMAIN,		\
+		      struct dlb2_start_domain_args)
 #define DLB2_IOC_GET_LDB_QUEUE_DEPTH				\
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,	\
-- 
2.13.6

