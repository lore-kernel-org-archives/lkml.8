Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D2C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E34207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbgIATWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:53433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbgIATVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:44 -0400
IronPort-SDR: DRcEI7iam1LSd42BLElBjE8yRWuH6yQy3QxPRFwS1M1VE+gimIs5aXwhG6eRW0q6d4oC9GZXlf
 dJ/RAWIS2DxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807331"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807331"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:32 -0700
IronPort-SDR: +/amIk7g1CUI0r5MCOg6CByiPmU0HBNmWeuTG4xNZyO0eJjcN9raMPU3Yt/KWmgQL9wk2nN52j
 pquawZaEgwXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480480"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:31 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 10/19] dlb2: add start domain ioctl
Date:   Tue,  1 Sep 2020 14:15:39 -0500
Message-Id: <20200901191548.31646-11-gage.eads@intel.com>
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

Once a scheduling domain and its resources have been configured, the start
domain ioctl is called to enable its ports to begin enqueueing to the
device. Once started, the domain's resources cannot be configured again
until after the domain is reset.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    |   3 +
 drivers/misc/dlb2/dlb2_main.h     |   4 ++
 drivers/misc/dlb2/dlb2_pf_ops.c   |  10 ++++
 drivers/misc/dlb2/dlb2_resource.c | 120 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h |  30 ++++++++++
 include/uapi/linux/dlb2_user.h    |  22 +++++++
 6 files changed, 189 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 68db45842e34..5b6d3b4c3297 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -51,6 +51,7 @@ DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_ldb_queue)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
+DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(start_domain)
 
 /*
  * Port creation ioctls don't use the callback template macro because they have
@@ -343,6 +344,8 @@ long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_domain_ioctl_get_dir_port_pp_fd(dev, dom, arg);
 	case DLB2_IOC_GET_DIR_PORT_CQ_FD:
 		return dlb2_domain_ioctl_get_dir_port_cq_fd(dev, dom, arg);
+	case DLB2_IOC_START_DOMAIN:
+		return dlb2_domain_ioctl_start_domain(dev, dom, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 06b9130643cb..abe9808b4638 100644
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
index 1e2e89d6945e..4ab4d9fe3f61 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -263,6 +263,15 @@ dlb2_pf_create_dir_port(struct dlb2_hw *hw,
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
@@ -349,6 +358,7 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.create_dir_queue = dlb2_pf_create_dir_queue,
 	.create_ldb_port = dlb2_pf_create_ldb_port,
 	.create_dir_port = dlb2_pf_create_dir_port,
+	.start_domain = dlb2_pf_start_domain,
 	.get_num_resources = dlb2_pf_get_num_resources,
 	.reset_domain = dlb2_pf_reset_domain,
 	.ldb_port_owned_by_domain = dlb2_pf_ldb_port_owned_by_domain,
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 454a1aacfaf2..4d8b56a4b437 100644
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
index ffdc35ebbc1e..d5b554b701f5 100644
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
index 898ff4df3462..0eb9e14de11d 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -456,6 +456,23 @@ struct dlb2_get_port_fd_args {
 	__u32 padding0;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_START_DOMAIN: Mark the end of the domain configuration. This
+ *	must be called before passing QEs into the device, and no configuration
+ *	ioctls can be issued once the domain has started. Sending QEs into the
+ *	device before calling this ioctl will result in undefined behavior.
+ * Input parameters:
+ * - (None)
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_start_domain_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+};
+
 enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
@@ -467,6 +484,7 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_GET_LDB_PORT_CQ_FD,
 	DLB2_DOMAIN_CMD_GET_DIR_PORT_PP_FD,
 	DLB2_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,
+	DLB2_DOMAIN_CMD_START_DOMAIN,
 
 	/* NUM_DLB2_DOMAIN_CMD must be last */
 	NUM_DLB2_DOMAIN_CMD,
@@ -541,5 +559,9 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,	\
 		      struct dlb2_get_port_fd_args)
+#define DLB2_IOC_START_DOMAIN					\
+		_IOR(DLB2_IOC_MAGIC,				\
+		     DLB2_DOMAIN_CMD_START_DOMAIN,		\
+		     struct dlb2_start_domain_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

