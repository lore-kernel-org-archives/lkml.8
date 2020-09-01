Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560F3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284FE20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgIATWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:53433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgIATVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:36 -0400
IronPort-SDR: BuYiWUNVyVwK8BiScuJRC4ifIShA7YqwHMRJmXgBVz6yg4fDIWtpFspJyPwgxvmtFaI/F1Xysp
 siPPO4bX/HZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807323"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807323"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:31 -0700
IronPort-SDR: 5drdpCQH11pzMAqYaYC77s4WelUuDTLDz3gv/u1ux1YTm4wMUZj2BGkOmdZ8qQDtuisaEoMWTI
 uhO4Ugw6CQhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480471"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:30 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 08/19] dlb2: add ioctl to configure ports, query poll mode
Date:   Tue,  1 Sep 2020 14:15:37 -0500
Message-Id: <20200901191548.31646-9-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port is a core's interface to the DLB, and it consists of an MMIO page
(the "producer port" (PP)) through which the core enqueues a queue entry
and an in-memory queue (the "consumer queue" (CQ)) to which the device
schedules QEs. The driver allocates DMA memory for each port's CQ, and
frees this memory during domain reset or driver removal. A subsequent
commit will add the mmap interface for an application to directly access
the PP and CQ regions.

The device supports two formats ("standard" and "sparse") for CQ entries,
dubbed the "poll mode". This (device-wide) mode is selected by the driver;
to determine the mode at run time, the driver provides an ioctl for
user-space software to query which mode the driver has configured. In this
way, the policy of which mode to use is decoupled from user-space software.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/dlb2_hw_types.h |   1 +
 drivers/misc/dlb2/dlb2_ioctl.c    | 150 +++++++
 drivers/misc/dlb2/dlb2_main.c     |  70 +++
 drivers/misc/dlb2/dlb2_main.h     |  23 +
 drivers/misc/dlb2/dlb2_pf_ops.c   |  46 ++
 drivers/misc/dlb2/dlb2_resource.c | 922 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h |  89 ++++
 include/uapi/linux/dlb2_user.h    |  99 ++++
 8 files changed, 1400 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
index e43860a215ff..7db59157da15 100644
--- a/drivers/misc/dlb2/dlb2_hw_types.h
+++ b/drivers/misc/dlb2/dlb2_hw_types.h
@@ -317,6 +317,7 @@ struct dlb2_hw {
 
 	/* Virtualization */
 	int virt_mode;
+	unsigned int pasid[DLB2_MAX_NUM_VDEVS];
 };
 
 #endif /* __DLB2_HW_TYPES_H */
diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index f787fd19689f..7a3fea60c302 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -51,6 +51,126 @@ DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
 
+/*
+ * Port creation ioctls don't use the callback template macro because they have
+ * a number of OS-dependent memory operations.
+ */
+static int dlb2_domain_ioctl_create_ldb_port(struct dlb2_dev *dev,
+					     struct dlb2_domain *domain,
+					     unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_create_ldb_port_args arg;
+	dma_addr_t cq_dma_base = 0;
+	void *cq_base = NULL;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	cq_base = dma_alloc_coherent(&dev->pdev->dev,
+				     DLB2_CQ_SIZE,
+				     &cq_dma_base,
+				     GFP_KERNEL);
+	if (!cq_base) {
+		response.status = DLB2_ST_NO_MEMORY;
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	ret = dev->ops->create_ldb_port(&dev->hw,
+					domain->id,
+					&arg,
+					(uintptr_t)cq_dma_base,
+					&response);
+	if (ret)
+		goto unlock;
+
+	/* Fill out the per-port data structure */
+	dev->ldb_port[response.id].id = response.id;
+	dev->ldb_port[response.id].is_ldb = true;
+	dev->ldb_port[response.id].domain = domain;
+	dev->ldb_port[response.id].cq_base = cq_base;
+	dev->ldb_port[response.id].cq_dma_base = cq_dma_base;
+	dev->ldb_port[response.id].valid = true;
+
+unlock:
+	if (ret && cq_dma_base)
+		dma_free_coherent(&dev->pdev->dev,
+				  DLB2_CQ_SIZE,
+				  cq_base,
+				  cq_dma_base);
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
+static int dlb2_domain_ioctl_create_dir_port(struct dlb2_dev *dev,
+					     struct dlb2_domain *domain,
+					     unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_create_dir_port_args arg;
+	dma_addr_t cq_dma_base = 0;
+	void *cq_base = NULL;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	cq_base = dma_alloc_coherent(&dev->pdev->dev,
+				     DLB2_CQ_SIZE,
+				     &cq_dma_base,
+				     GFP_KERNEL);
+	if (!cq_base) {
+		response.status = DLB2_ST_NO_MEMORY;
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	ret = dev->ops->create_dir_port(&dev->hw,
+					domain->id,
+					&arg,
+					(uintptr_t)cq_dma_base,
+					&response);
+	if (ret)
+		goto unlock;
+
+	/* Fill out the per-port data structure */
+	dev->dir_port[response.id].id = response.id;
+	dev->dir_port[response.id].is_ldb = false;
+	dev->dir_port[response.id].domain = domain;
+	dev->dir_port[response.id].cq_base = cq_base;
+	dev->dir_port[response.id].cq_dma_base = cq_dma_base;
+	dev->dir_port[response.id].valid = true;
+
+unlock:
+	if (ret && cq_dma_base)
+		dma_free_coherent(&dev->pdev->dev,
+				  DLB2_CQ_SIZE,
+				  cq_base,
+				  cq_dma_base);
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
 long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct dlb2_domain *dom = f->private_data;
@@ -65,6 +185,10 @@ long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_domain_ioctl_get_ldb_queue_depth(dev, dom, arg);
 	case DLB2_IOC_GET_DIR_QUEUE_DEPTH:
 		return dlb2_domain_ioctl_get_dir_queue_depth(dev, dom, arg);
+	case DLB2_IOC_CREATE_LDB_PORT:
+		return dlb2_domain_ioctl_create_ldb_port(dev, dom, arg);
+	case DLB2_IOC_CREATE_DIR_PORT:
+		return dlb2_domain_ioctl_create_dir_port(dev, dom, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -168,6 +292,30 @@ static int dlb2_ioctl_get_num_resources(struct dlb2_dev *dev,
 	return ret;
 }
 
+static int dlb2_ioctl_query_cq_poll_mode(struct dlb2_dev *dev,
+					 unsigned long user_arg)
+{
+	struct dlb2_query_cq_poll_mode_args arg;
+	struct dlb2_cmd_response response = {0};
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->query_cq_poll_mode(dev, &response);
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
@@ -181,6 +329,8 @@ long dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_ioctl_create_sched_domain(dev, arg);
 	case DLB2_IOC_GET_NUM_RESOURCES:
 		return dlb2_ioctl_get_num_resources(dev, arg);
+	case DLB2_IOC_QUERY_CQ_POLL_MODE:
+		return dlb2_ioctl_query_cq_poll_mode(dev, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index b331e096d206..a7512832fc1c 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -107,11 +107,79 @@ int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id)
 	return 0;
 }
 
+static void dlb2_release_domain_memory(struct dlb2_dev *dev, u32 domain_id)
+{
+	struct dlb2_port *port;
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		port = &dev->ldb_port[i];
+
+		if (port->valid && port->domain->id == domain_id) {
+			dma_free_coherent(&dev->pdev->dev,
+					  DLB2_CQ_SIZE,
+					  port->cq_base,
+					  port->cq_dma_base);
+
+			port->valid = false;
+		}
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++) {
+		port = &dev->dir_port[i];
+
+		if (port->valid && port->domain->id == domain_id) {
+			dma_free_coherent(&dev->pdev->dev,
+					  DLB2_CQ_SIZE,
+					  port->cq_base,
+					  port->cq_dma_base);
+
+			port->valid = false;
+		}
+	}
+}
+
+static void dlb2_release_device_memory(struct dlb2_dev *dev)
+{
+	struct dlb2_port *port;
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		port = &dev->ldb_port[i];
+
+		if (port->valid) {
+			dma_free_coherent(&dev->pdev->dev,
+					  DLB2_CQ_SIZE,
+					  port->cq_base,
+					  port->cq_dma_base);
+
+			port->valid = false;
+		}
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++) {
+		port = &dev->dir_port[i];
+
+		if (port->valid) {
+			dma_free_coherent(&dev->pdev->dev,
+					  DLB2_CQ_SIZE,
+					  port->cq_base,
+					  port->cq_dma_base);
+
+			port->valid = false;
+		}
+	}
+}
+
 static int __dlb2_free_domain(struct dlb2_dev *dev, struct dlb2_domain *domain)
 {
 	int ret = 0;
 
 	ret = dev->ops->reset_domain(&dev->hw, domain->id);
+
+	/* Unpin and free all memory pages associated with the domain */
+	dlb2_release_domain_memory(dev, domain->id);
+
 	if (ret) {
 		dev->domain_reset_failed = true;
 		dev_err(dev->dlb2_device,
@@ -329,6 +397,8 @@ static void dlb2_remove(struct pci_dev *pdev)
 
 	dlb2_resource_free(&dlb2_dev->hw);
 
+	dlb2_release_device_memory(dlb2_dev);
+
 	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
 
 	dlb2_dev->ops->cdev_del(dlb2_dev);
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 41a3254a78ac..ceb5512a104c 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -68,6 +68,16 @@ struct dlb2_device_ops {
 				u32 domain_id,
 				struct dlb2_create_dir_queue_args *args,
 				struct dlb2_cmd_response *resp);
+	int (*create_ldb_port)(struct dlb2_hw *hw,
+			       u32 domain_id,
+			       struct dlb2_create_ldb_port_args *args,
+			       uintptr_t cq_dma_base,
+			       struct dlb2_cmd_response *resp);
+	int (*create_dir_port)(struct dlb2_hw *hw,
+			       u32 domain_id,
+			       struct dlb2_create_dir_port_args *args,
+			       uintptr_t cq_dma_base,
+			       struct dlb2_cmd_response *resp);
 	int (*get_num_resources)(struct dlb2_hw *hw,
 				 struct dlb2_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb2_hw *hw, u32 domain_id);
@@ -80,11 +90,22 @@ struct dlb2_device_ops {
 				   struct dlb2_get_dir_queue_depth_args *args,
 				   struct dlb2_cmd_response *resp);
 	void (*init_hardware)(struct dlb2_dev *dev);
+	int (*query_cq_poll_mode)(struct dlb2_dev *dev,
+				  struct dlb2_cmd_response *user_resp);
 };
 
 extern struct dlb2_device_ops dlb2_pf_ops;
 extern const struct file_operations dlb2_domain_fops;
 
+struct dlb2_port {
+	void *cq_base;
+	dma_addr_t cq_dma_base;
+	struct dlb2_domain *domain;
+	int id;
+	u8 is_ldb;
+	u8 valid;
+};
+
 struct dlb2_domain {
 	struct dlb2_dev *dlb2_dev;
 	struct kref refcnt;
@@ -99,6 +120,8 @@ struct dlb2_dev {
 	struct list_head list;
 	struct device *dlb2_device;
 	struct dlb2_domain *sched_domains[DLB2_MAX_NUM_DOMAINS];
+	struct dlb2_port ldb_port[DLB2_MAX_NUM_LDB_PORTS];
+	struct dlb2_port dir_port[DLB2_MAX_NUM_DIR_PORTS];
 	/*
 	 * The resource mutex serializes access to driver data structures and
 	 * hardware registers.
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 89c0e66b3c6b..8556dcdff8c4 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -198,9 +198,16 @@ dlb2_pf_wait_for_device_ready(struct dlb2_dev *dlb2_dev,
 	return 0;
 }
 
+static bool dlb2_sparse_cq_enabled = true;
+
 static void
 dlb2_pf_init_hardware(struct dlb2_dev *dlb2_dev)
 {
+	if (dlb2_sparse_cq_enabled) {
+		dlb2_hw_enable_sparse_ldb_cq_mode(&dlb2_dev->hw);
+
+		dlb2_hw_enable_sparse_dir_cq_mode(&dlb2_dev->hw);
+	}
 }
 
 /*****************************/
@@ -234,6 +241,28 @@ dlb2_pf_create_dir_queue(struct dlb2_hw *hw,
 }
 
 static int
+dlb2_pf_create_ldb_port(struct dlb2_hw *hw,
+			u32 id,
+			struct dlb2_create_ldb_port_args *args,
+			uintptr_t cq_dma_base,
+			struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_create_ldb_port(hw, id, args, cq_dma_base,
+				       resp, false, 0);
+}
+
+static int
+dlb2_pf_create_dir_port(struct dlb2_hw *hw,
+			u32 id,
+			struct dlb2_create_dir_port_args *args,
+			uintptr_t cq_dma_base,
+			struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_create_dir_port(hw, id, args, cq_dma_base,
+				       resp, false, 0);
+}
+
+static int
 dlb2_pf_get_num_resources(struct dlb2_hw *hw,
 			  struct dlb2_get_num_resources_args *args)
 {
@@ -264,6 +293,20 @@ dlb2_pf_get_dir_queue_depth(struct dlb2_hw *hw,
 	return dlb2_hw_get_dir_queue_depth(hw, id, args, resp, false, 0);
 }
 
+static int
+dlb2_pf_query_cq_poll_mode(struct dlb2_dev *dlb2_dev,
+			   struct dlb2_cmd_response *user_resp)
+{
+	user_resp->status = 0;
+
+	if (dlb2_sparse_cq_enabled)
+		user_resp->id = DLB2_CQ_POLL_MODE_SPARSE;
+	else
+		user_resp->id = DLB2_CQ_POLL_MODE_STD;
+
+	return 0;
+}
+
 /********************************/
 /****** DLB2 PF Device Ops ******/
 /********************************/
@@ -284,9 +327,12 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.create_sched_domain = dlb2_pf_create_sched_domain,
 	.create_ldb_queue = dlb2_pf_create_ldb_queue,
 	.create_dir_queue = dlb2_pf_create_dir_queue,
+	.create_ldb_port = dlb2_pf_create_ldb_port,
+	.create_dir_port = dlb2_pf_create_dir_port,
 	.get_num_resources = dlb2_pf_get_num_resources,
 	.reset_domain = dlb2_pf_reset_domain,
 	.get_ldb_queue_depth = dlb2_pf_get_ldb_queue_depth,
 	.get_dir_queue_depth = dlb2_pf_get_dir_queue_depth,
 	.init_hardware = dlb2_pf_init_hardware,
+	.query_cq_poll_mode = dlb2_pf_query_cq_poll_mode,
 };
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 2531c6508994..03824fd48f60 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -1089,6 +1089,171 @@ static void dlb2_configure_dir_queue(struct dlb2_hw *hw,
 	queue->queue_configured = true;
 }
 
+static int
+dlb2_verify_create_ldb_port_args(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 uintptr_t cq_dma_base,
+				 struct dlb2_create_ldb_port_args *args,
+				 struct dlb2_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id)
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
+	if (args->cos_id >= DLB2_NUM_COS_DOMAINS) {
+		resp->status = DLB2_ST_INVALID_COS_ID;
+		return -EINVAL;
+	}
+
+	if (args->cos_strict) {
+		if (list_empty(&domain->avail_ldb_ports[args->cos_id])) {
+			resp->status = DLB2_ST_LDB_PORTS_UNAVAILABLE;
+			return -EINVAL;
+		}
+	} else {
+		for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+			if (!list_empty(&domain->avail_ldb_ports[i]))
+				break;
+		}
+
+		if (i == DLB2_NUM_COS_DOMAINS) {
+			resp->status = DLB2_ST_LDB_PORTS_UNAVAILABLE;
+			return -EINVAL;
+		}
+	}
+
+	/* Check cache-line alignment */
+	if ((cq_dma_base & 0x3F) != 0) {
+		resp->status = DLB2_ST_INVALID_CQ_VIRT_ADDR;
+		return -EINVAL;
+	}
+
+	if (args->cq_depth != 1 &&
+	    args->cq_depth != 2 &&
+	    args->cq_depth != 4 &&
+	    args->cq_depth != 8 &&
+	    args->cq_depth != 16 &&
+	    args->cq_depth != 32 &&
+	    args->cq_depth != 64 &&
+	    args->cq_depth != 128 &&
+	    args->cq_depth != 256 &&
+	    args->cq_depth != 512 &&
+	    args->cq_depth != 1024) {
+		resp->status = DLB2_ST_INVALID_CQ_DEPTH;
+		return -EINVAL;
+	}
+
+	/* The history list size must be >= 1 */
+	if (!args->cq_history_list_size) {
+		resp->status = DLB2_ST_INVALID_HIST_LIST_DEPTH;
+		return -EINVAL;
+	}
+
+	if (args->cq_history_list_size > domain->avail_hist_list_entries) {
+		resp->status = DLB2_ST_HIST_LIST_ENTRIES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dlb2_verify_create_dir_port_args(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 uintptr_t cq_dma_base,
+				 struct dlb2_create_dir_port_args *args,
+				 struct dlb2_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id)
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
+	 * If the user claims the queue is already configured, validate
+	 * the queue ID, its domain, and whether the queue is configured.
+	 */
+	if (args->queue_id != -1) {
+		struct dlb2_dir_pq_pair *queue;
+
+		queue = dlb2_get_domain_used_dir_pq(args->queue_id,
+						    vdev_req,
+						    domain);
+
+		if (!queue || queue->domain_id.phys_id != domain->id.phys_id ||
+		    !queue->queue_configured) {
+			resp->status = DLB2_ST_INVALID_DIR_QUEUE_ID;
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * If the port's queue is not configured, validate that a free
+	 * port-queue pair is available.
+	 */
+	if (args->queue_id == -1 && list_empty(&domain->avail_dir_pq_pairs)) {
+		resp->status = DLB2_ST_DIR_PORTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	/* Check cache-line alignment */
+	if ((cq_dma_base & 0x3F) != 0) {
+		resp->status = DLB2_ST_INVALID_CQ_VIRT_ADDR;
+		return -EINVAL;
+	}
+
+	if (args->cq_depth != 1 &&
+	    args->cq_depth != 2 &&
+	    args->cq_depth != 4 &&
+	    args->cq_depth != 8 &&
+	    args->cq_depth != 16 &&
+	    args->cq_depth != 32 &&
+	    args->cq_depth != 64 &&
+	    args->cq_depth != 128 &&
+	    args->cq_depth != 256 &&
+	    args->cq_depth != 512 &&
+	    args->cq_depth != 1024) {
+		resp->status = DLB2_ST_INVALID_CQ_DEPTH;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool dlb2_port_find_slot(struct dlb2_ldb_port *port,
 				enum dlb2_qid_map_state state,
 				int *slot)
@@ -1455,6 +1620,495 @@ static void dlb2_dir_port_cq_disable(struct dlb2_hw *hw,
 	dlb2_flush_csr(hw);
 }
 
+static void dlb2_ldb_port_configure_pp(struct dlb2_hw *hw,
+				       struct dlb2_hw_domain *domain,
+				       struct dlb2_ldb_port *port,
+				       bool vdev_req,
+				       unsigned int vdev_id)
+{
+	union dlb2_sys_ldb_pp2vas r0 = { {0} };
+	union dlb2_sys_ldb_pp_v r4 = { {0} };
+
+	r0.field.vas = domain->id.phys_id;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_PP2VAS(port->id.phys_id), r0.val);
+
+	if (vdev_req) {
+		union dlb2_sys_vf_ldb_vpp2pp r1 = { {0} };
+		union dlb2_sys_ldb_pp2vdev r2 = { {0} };
+		union dlb2_sys_vf_ldb_vpp_v r3 = { {0} };
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
+		r1.field.pp = port->id.phys_id;
+
+		offs = vdev_id * DLB2_MAX_NUM_LDB_PORTS + virt_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_LDB_VPP2PP(offs), r1.val);
+
+		r2.field.vdev = vdev_id;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_PP2VDEV(port->id.phys_id),
+			    r2.val);
+
+		r3.field.vpp_v = 1;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_LDB_VPP_V(offs), r3.val);
+	}
+
+	r4.field.pp_v = 1;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_PP_V(port->id.phys_id),
+		    r4.val);
+}
+
+static int dlb2_ldb_port_configure_cq(struct dlb2_hw *hw,
+				      struct dlb2_hw_domain *domain,
+				      struct dlb2_ldb_port *port,
+				      uintptr_t cq_dma_base,
+				      struct dlb2_create_ldb_port_args *args,
+				      bool vdev_req,
+				      unsigned int vdev_id)
+{
+	union dlb2_sys_ldb_cq_addr_l r0 = { {0} };
+	union dlb2_sys_ldb_cq_addr_u r1 = { {0} };
+	union dlb2_sys_ldb_cq2vf_pf_ro r2 = { {0} };
+	union dlb2_chp_ldb_cq_tkn_depth_sel r3 = { {0} };
+	union dlb2_lsp_cq_ldb_tkn_depth_sel r4 = { {0} };
+	union dlb2_chp_hist_list_lim r5 = { {0} };
+	union dlb2_chp_hist_list_base r6 = { {0} };
+	union dlb2_lsp_cq_ldb_infl_lim r7 = { {0} };
+	union dlb2_chp_hist_list_push_ptr r8 = { {0} };
+	union dlb2_chp_hist_list_pop_ptr r9 = { {0} };
+	union dlb2_sys_ldb_cq_at r10 = { {0} };
+	union dlb2_sys_ldb_cq_pasid r11 = { {0} };
+	union dlb2_chp_ldb_cq2vas r12 = { {0} };
+	union dlb2_lsp_cq2priov r13 = { {0} };
+
+	/* The CQ address is 64B-aligned, and the DLB only wants bits [63:6] */
+	r0.field.addr_l = cq_dma_base >> 6;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_CQ_ADDR_L(port->id.phys_id), r0.val);
+
+	r1.field.addr_u = cq_dma_base >> 32;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_CQ_ADDR_U(port->id.phys_id), r1.val);
+
+	/*
+	 * 'ro' == relaxed ordering. This setting allows DLB2 to write
+	 * cache lines out-of-order (but QEs within a cache line are always
+	 * updated in-order).
+	 */
+	r2.field.vf = vdev_id;
+	r2.field.is_pf = !vdev_req && (hw->virt_mode != DLB2_VIRT_SIOV);
+	r2.field.ro = 1;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_CQ2VF_PF_RO(port->id.phys_id), r2.val);
+
+	if (args->cq_depth <= 8) {
+		r3.field.token_depth_select = 1;
+	} else if (args->cq_depth == 16) {
+		r3.field.token_depth_select = 2;
+	} else if (args->cq_depth == 32) {
+		r3.field.token_depth_select = 3;
+	} else if (args->cq_depth == 64) {
+		r3.field.token_depth_select = 4;
+	} else if (args->cq_depth == 128) {
+		r3.field.token_depth_select = 5;
+	} else if (args->cq_depth == 256) {
+		r3.field.token_depth_select = 6;
+	} else if (args->cq_depth == 512) {
+		r3.field.token_depth_select = 7;
+	} else if (args->cq_depth == 1024) {
+		r3.field.token_depth_select = 8;
+	} else {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: invalid CQ depth\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_TKN_DEPTH_SEL(port->id.phys_id),
+		    r3.val);
+
+	/*
+	 * To support CQs with depth less than 8, program the token count
+	 * register with a non-zero initial value. Operations such as domain
+	 * reset must take this initial value into account when quiescing the
+	 * CQ.
+	 */
+	port->init_tkn_cnt = 0;
+
+	if (args->cq_depth < 8) {
+		union dlb2_lsp_cq_ldb_tkn_cnt r14 = { {0} };
+
+		port->init_tkn_cnt = 8 - args->cq_depth;
+
+		r14.field.token_count = port->init_tkn_cnt;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_CQ_LDB_TKN_CNT(port->id.phys_id),
+			    r14.val);
+	} else {
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_CQ_LDB_TKN_CNT(port->id.phys_id),
+			    DLB2_LSP_CQ_LDB_TKN_CNT_RST);
+	}
+
+	r4.field.token_depth_select = r3.field.token_depth_select;
+	r4.field.ignore_depth = 0;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_LDB_TKN_DEPTH_SEL(port->id.phys_id),
+		    r4.val);
+
+	/* Reset the CQ write pointer */
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_WPTR(port->id.phys_id),
+		    DLB2_CHP_LDB_CQ_WPTR_RST);
+
+	r5.field.limit = port->hist_list_entry_limit - 1;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_HIST_LIST_LIM(port->id.phys_id), r5.val);
+
+	r6.field.base = port->hist_list_entry_base;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_HIST_LIST_BASE(port->id.phys_id), r6.val);
+
+	/*
+	 * The inflight limit sets a cap on the number of QEs for which this CQ
+	 * can owe completions at one time.
+	 */
+	r7.field.limit = args->cq_history_list_size;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ_LDB_INFL_LIM(port->id.phys_id), r7.val);
+
+	r8.field.push_ptr = r6.field.base;
+	r8.field.generation = 0;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_HIST_LIST_PUSH_PTR(port->id.phys_id),
+		    r8.val);
+
+	r9.field.pop_ptr = r6.field.base;
+	r9.field.generation = 0;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_HIST_LIST_POP_PTR(port->id.phys_id), r9.val);
+
+	/*
+	 * Address translation (AT) settings: 0: untranslated, 2: translated
+	 * (see ATS spec regarding Address Type field for more details)
+	 */
+	r10.field.cq_at = 0;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_CQ_AT(port->id.phys_id), r10.val);
+
+	if (vdev_req && hw->virt_mode == DLB2_VIRT_SIOV) {
+		r11.field.pasid = hw->pasid[vdev_id];
+		r11.field.fmt2 = 1;
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_LDB_CQ_PASID(port->id.phys_id),
+		    r11.val);
+
+	r12.field.cq2vas = domain->id.phys_id;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_LDB_CQ2VAS(port->id.phys_id), r12.val);
+
+	/* Disable the port's QID mappings */
+	r13.field.v = 0;
+
+	DLB2_CSR_WR(hw, DLB2_LSP_CQ2PRIOV(port->id.phys_id), r13.val);
+
+	return 0;
+}
+
+static int dlb2_configure_ldb_port(struct dlb2_hw *hw,
+				   struct dlb2_hw_domain *domain,
+				   struct dlb2_ldb_port *port,
+				   uintptr_t cq_dma_base,
+				   struct dlb2_create_ldb_port_args *args,
+				   bool vdev_req,
+				   unsigned int vdev_id)
+{
+	int ret, i;
+
+	port->hist_list_entry_base = domain->hist_list_entry_base +
+				     domain->hist_list_entry_offset;
+	port->hist_list_entry_limit = port->hist_list_entry_base +
+				      args->cq_history_list_size;
+
+	domain->hist_list_entry_offset += args->cq_history_list_size;
+	domain->avail_hist_list_entries -= args->cq_history_list_size;
+
+	ret = dlb2_ldb_port_configure_cq(hw,
+					 domain,
+					 port,
+					 cq_dma_base,
+					 args,
+					 vdev_req,
+					 vdev_id);
+	if (ret < 0)
+		return ret;
+
+	dlb2_ldb_port_configure_pp(hw,
+				   domain,
+				   port,
+				   vdev_req,
+				   vdev_id);
+
+	dlb2_ldb_port_cq_enable(hw, port);
+
+	for (i = 0; i < DLB2_MAX_NUM_QIDS_PER_LDB_CQ; i++)
+		port->qid_map[i].state = DLB2_QUEUE_UNMAPPED;
+	port->num_mappings = 0;
+
+	port->enabled = true;
+
+	port->configured = true;
+
+	return 0;
+}
+
+static void dlb2_dir_port_configure_pp(struct dlb2_hw *hw,
+				       struct dlb2_hw_domain *domain,
+				       struct dlb2_dir_pq_pair *port,
+				       bool vdev_req,
+				       unsigned int vdev_id)
+{
+	union dlb2_sys_dir_pp2vas r0 = { {0} };
+	union dlb2_sys_dir_pp_v r4 = { {0} };
+
+	r0.field.vas = domain->id.phys_id;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_PP2VAS(port->id.phys_id), r0.val);
+
+	if (vdev_req) {
+		union dlb2_sys_vf_dir_vpp2pp r1 = { {0} };
+		union dlb2_sys_dir_pp2vdev r2 = { {0} };
+		union dlb2_sys_vf_dir_vpp_v r3 = { {0} };
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
+		r1.field.pp = port->id.phys_id;
+
+		offs = vdev_id * DLB2_MAX_NUM_DIR_PORTS + virt_id;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_DIR_VPP2PP(offs), r1.val);
+
+		r2.field.vdev = vdev_id;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_PP2VDEV(port->id.phys_id),
+			    r2.val);
+
+		r3.field.vpp_v = 1;
+
+		DLB2_CSR_WR(hw, DLB2_SYS_VF_DIR_VPP_V(offs), r3.val);
+	}
+
+	r4.field.pp_v = 1;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_PP_V(port->id.phys_id),
+		    r4.val);
+}
+
+static int dlb2_dir_port_configure_cq(struct dlb2_hw *hw,
+				      struct dlb2_hw_domain *domain,
+				      struct dlb2_dir_pq_pair *port,
+				      uintptr_t cq_dma_base,
+				      struct dlb2_create_dir_port_args *args,
+				      bool vdev_req,
+				      unsigned int vdev_id)
+{
+	union dlb2_sys_dir_cq_addr_l r0 = { {0} };
+	union dlb2_sys_dir_cq_addr_u r1 = { {0} };
+	union dlb2_sys_dir_cq2vf_pf_ro r2 = { {0} };
+	union dlb2_chp_dir_cq_tkn_depth_sel r3 = { {0} };
+	union dlb2_lsp_cq_dir_tkn_depth_sel_dsi r4 = { {0} };
+	union dlb2_sys_dir_cq_fmt r9 = { {0} };
+	union dlb2_sys_dir_cq_at r10 = { {0} };
+	union dlb2_sys_dir_cq_pasid r11 = { {0} };
+	union dlb2_chp_dir_cq2vas r12 = { {0} };
+
+	/* The CQ address is 64B-aligned, and the DLB only wants bits [63:6] */
+	r0.field.addr_l = cq_dma_base >> 6;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ_ADDR_L(port->id.phys_id), r0.val);
+
+	r1.field.addr_u = cq_dma_base >> 32;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ_ADDR_U(port->id.phys_id), r1.val);
+
+	/*
+	 * 'ro' == relaxed ordering. This setting allows DLB2 to write
+	 * cache lines out-of-order (but QEs within a cache line are always
+	 * updated in-order).
+	 */
+	r2.field.vf = vdev_id;
+	r2.field.is_pf = !vdev_req && (hw->virt_mode != DLB2_VIRT_SIOV);
+	r2.field.ro = 1;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ2VF_PF_RO(port->id.phys_id), r2.val);
+
+	if (args->cq_depth <= 8) {
+		r3.field.token_depth_select = 1;
+	} else if (args->cq_depth == 16) {
+		r3.field.token_depth_select = 2;
+	} else if (args->cq_depth == 32) {
+		r3.field.token_depth_select = 3;
+	} else if (args->cq_depth == 64) {
+		r3.field.token_depth_select = 4;
+	} else if (args->cq_depth == 128) {
+		r3.field.token_depth_select = 5;
+	} else if (args->cq_depth == 256) {
+		r3.field.token_depth_select = 6;
+	} else if (args->cq_depth == 512) {
+		r3.field.token_depth_select = 7;
+	} else if (args->cq_depth == 1024) {
+		r3.field.token_depth_select = 8;
+	} else {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: invalid CQ depth\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_TKN_DEPTH_SEL(port->id.phys_id),
+		    r3.val);
+
+	/*
+	 * To support CQs with depth less than 8, program the token count
+	 * register with a non-zero initial value. Operations such as domain
+	 * reset must take this initial value into account when quiescing the
+	 * CQ.
+	 */
+	port->init_tkn_cnt = 0;
+
+	if (args->cq_depth < 8) {
+		union dlb2_lsp_cq_dir_tkn_cnt r13 = { {0} };
+
+		port->init_tkn_cnt = 8 - args->cq_depth;
+
+		r13.field.count = port->init_tkn_cnt;
+
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_CQ_DIR_TKN_CNT(port->id.phys_id),
+			    r13.val);
+	} else {
+		DLB2_CSR_WR(hw,
+			    DLB2_LSP_CQ_DIR_TKN_CNT(port->id.phys_id),
+			    DLB2_LSP_CQ_DIR_TKN_CNT_RST);
+	}
+
+	r4.field.token_depth_select = r3.field.token_depth_select;
+	r4.field.disable_wb_opt = 0;
+	r4.field.ignore_depth = 0;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_LSP_CQ_DIR_TKN_DEPTH_SEL_DSI(port->id.phys_id),
+		    r4.val);
+
+	/* Reset the CQ write pointer */
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_WPTR(port->id.phys_id),
+		    DLB2_CHP_DIR_CQ_WPTR_RST);
+
+	/* Virtualize the PPID */
+	r9.field.keep_pf_ppid = 0;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ_FMT(port->id.phys_id), r9.val);
+
+	/*
+	 * Address translation (AT) settings: 0: untranslated, 2: translated
+	 * (see ATS spec regarding Address Type field for more details)
+	 */
+	r10.field.cq_at = 0;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ_AT(port->id.phys_id), r10.val);
+
+	if (vdev_req && hw->virt_mode == DLB2_VIRT_SIOV) {
+		r11.field.pasid = hw->pasid[vdev_id];
+		r11.field.fmt2 = 1;
+	}
+
+	DLB2_CSR_WR(hw,
+		    DLB2_SYS_DIR_CQ_PASID(port->id.phys_id),
+		    r11.val);
+
+	r12.field.cq2vas = domain->id.phys_id;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_DIR_CQ2VAS(port->id.phys_id), r12.val);
+
+	return 0;
+}
+
+static int dlb2_configure_dir_port(struct dlb2_hw *hw,
+				   struct dlb2_hw_domain *domain,
+				   struct dlb2_dir_pq_pair *port,
+				   uintptr_t cq_dma_base,
+				   struct dlb2_create_dir_port_args *args,
+				   bool vdev_req,
+				   unsigned int vdev_id)
+{
+	int ret;
+
+	ret = dlb2_dir_port_configure_cq(hw,
+					 domain,
+					 port,
+					 cq_dma_base,
+					 args,
+					 vdev_req,
+					 vdev_id);
+
+	if (ret < 0)
+		return ret;
+
+	dlb2_dir_port_configure_pp(hw,
+				   domain,
+				   port,
+				   vdev_req,
+				   vdev_id);
+
+	dlb2_dir_port_cq_enable(hw, port);
+
+	port->enabled = true;
+
+	port->port_configured = true;
+
+	return 0;
+}
+
 static int dlb2_ldb_port_map_qid_static(struct dlb2_hw *hw,
 					struct dlb2_ldb_port *p,
 					struct dlb2_ldb_queue *q,
@@ -2311,6 +2965,252 @@ int dlb2_hw_create_dir_queue(struct dlb2_hw *hw,
 }
 
 static void
+dlb2_log_create_ldb_port_args(struct dlb2_hw *hw,
+			      u32 domain_id,
+			      uintptr_t cq_dma_base,
+			      struct dlb2_create_ldb_port_args *args,
+			      bool vdev_req,
+			      unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 create load-balanced port arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID:                 %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tCQ depth:                  %d\n",
+		    args->cq_depth);
+	DLB2_HW_DBG(hw, "\tCQ hist list size:         %d\n",
+		    args->cq_history_list_size);
+	DLB2_HW_DBG(hw, "\tCQ base address:           0x%lx\n",
+		    cq_dma_base);
+	DLB2_HW_DBG(hw, "\tCoS ID:                    %u\n", args->cos_id);
+	DLB2_HW_DBG(hw, "\tStrict CoS allocation:     %u\n",
+		    args->cos_strict);
+}
+
+/**
+ * dlb2_hw_create_ldb_port() - Allocate and initialize a load-balanced port and
+ *	its resources.
+ * @hw:	Contains the current state of the DLB2 hardware.
+ * @domain_id: Domain ID
+ * @args: User-provided arguments.
+ * @cq_dma_base: Base DMA address for consumer queue memory
+ * @resp: Response to user.
+ * @vdev_req: Request came from a virtual device.
+ * @vdev_id: If vdev_req is true, this contains the virtual device's ID.
+ *
+ * Return: returns < 0 on error, 0 otherwise. If the driver is unable to
+ * satisfy a request, resp->status will be set accordingly.
+ */
+int dlb2_hw_create_ldb_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_create_ldb_port_args *args,
+			    uintptr_t cq_dma_base,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int ret, cos_id, i;
+
+	dlb2_log_create_ldb_port_args(hw,
+				      domain_id,
+				      cq_dma_base,
+				      args,
+				      vdev_req,
+				      vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_create_ldb_port_args(hw,
+					       domain_id,
+					       cq_dma_base,
+					       args,
+					       resp,
+					       vdev_req,
+					       vdev_id);
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
+	if (args->cos_strict) {
+		cos_id = args->cos_id;
+
+		port = DLB2_DOM_LIST_HEAD(domain->avail_ldb_ports[cos_id],
+					  typeof(*port));
+	} else {
+		int idx;
+
+		for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+			idx = (args->cos_id + i) % DLB2_NUM_COS_DOMAINS;
+
+			port = DLB2_DOM_LIST_HEAD(domain->avail_ldb_ports[idx],
+						  typeof(*port));
+			if (port)
+				break;
+		}
+
+		cos_id = idx;
+	}
+
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: no available ldb ports\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	if (port->configured) {
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: avail_ldb_ports contains configured ports.\n",
+			    __func__);
+		return -EFAULT;
+	}
+
+	ret = dlb2_configure_ldb_port(hw,
+				      domain,
+				      port,
+				      cq_dma_base,
+				      args,
+				      vdev_req,
+				      vdev_id);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list.
+	 */
+	list_del(&port->domain_list);
+
+	list_add(&port->domain_list, &domain->used_ldb_ports[cos_id]);
+
+	resp->status = 0;
+	resp->id = (vdev_req) ? port->id.virt_id : port->id.phys_id;
+
+	return 0;
+}
+
+static void
+dlb2_log_create_dir_port_args(struct dlb2_hw *hw,
+			      u32 domain_id,
+			      uintptr_t cq_dma_base,
+			      struct dlb2_create_dir_port_args *args,
+			      bool vdev_req,
+			      unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 create directed port arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID:                 %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tCQ depth:                  %d\n",
+		    args->cq_depth);
+	DLB2_HW_DBG(hw, "\tCQ base address:           0x%lx\n",
+		    cq_dma_base);
+}
+
+/**
+ * dlb2_hw_create_dir_port() - Allocate and initialize a DLB directed port
+ *	and queue. The port/queue pair have the same ID and name.
+ * @hw:	Contains the current state of the DLB2 hardware.
+ * @domain_id: Domain ID
+ * @args: User-provided arguments.
+ * @cq_dma_base: Base DMA address for consumer queue memory
+ * @resp: Response to user.
+ * @vdev_req: Request came from a virtual device.
+ * @vdev_id: If vdev_req is true, this contains the virtual device's ID.
+ *
+ * Return: returns < 0 on error, 0 otherwise. If the driver is unable to
+ * satisfy a request, resp->status will be set accordingly.
+ */
+int dlb2_hw_create_dir_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_create_dir_port_args *args,
+			    uintptr_t cq_dma_base,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *port;
+	struct dlb2_hw_domain *domain;
+	int ret;
+
+	dlb2_log_create_dir_port_args(hw,
+				      domain_id,
+				      cq_dma_base,
+				      args,
+				      vdev_req,
+				      vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_create_dir_port_args(hw,
+					       domain_id,
+					       cq_dma_base,
+					       args,
+					       resp,
+					       vdev_req,
+					       vdev_id);
+	if (ret)
+		return ret;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (args->queue_id != -1)
+		port = dlb2_get_domain_used_dir_pq(args->queue_id,
+						   vdev_req,
+						   domain);
+	else
+		port = DLB2_DOM_LIST_HEAD(domain->avail_dir_pq_pairs,
+					  typeof(*port));
+
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: no available dir ports\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	ret = dlb2_configure_dir_port(hw,
+				      domain,
+				      port,
+				      cq_dma_base,
+				      args,
+				      vdev_req,
+				      vdev_id);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list (if it's not already there).
+	 */
+	if (args->queue_id == -1) {
+		list_del(&port->domain_list);
+
+		list_add(&port->domain_list, &domain->used_dir_pq_pairs);
+	}
+
+	resp->status = 0;
+	resp->id = (vdev_req) ? port->id.virt_id : port->id.phys_id;
+
+	return 0;
+}
+
+static void
 dlb2_domain_finish_unmap_port_slot(struct dlb2_hw *hw,
 				   struct dlb2_hw_domain *domain,
 				   struct dlb2_ldb_port *port,
@@ -4105,3 +5005,25 @@ void dlb2_clr_pmcsr_disable(struct dlb2_hw *hw)
 
 	DLB2_CSR_WR(hw, DLB2_CFG_MSTR_CFG_PM_PMCSR_DISABLE, r0.val);
 }
+
+void dlb2_hw_enable_sparse_ldb_cq_mode(struct dlb2_hw *hw)
+{
+	union dlb2_chp_cfg_chp_csr_ctrl r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_CHP_CFG_CHP_CSR_CTRL);
+
+	r0.field.cfg_64bytes_qe_ldb_cq_mode = 1;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_CHP_CSR_CTRL, r0.val);
+}
+
+void dlb2_hw_enable_sparse_dir_cq_mode(struct dlb2_hw *hw)
+{
+	union dlb2_chp_cfg_chp_csr_ctrl r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_CHP_CFG_CHP_CSR_CTRL);
+
+	r0.field.cfg_64bytes_qe_dir_cq_mode = 1;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_CHP_CSR_CTRL, r0.val);
+}
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index dfb42e0e13de..d355bc1a8f08 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -137,6 +137,78 @@ int dlb2_hw_create_dir_queue(struct dlb2_hw *hw,
 			     unsigned int vdev_id);
 
 /**
+ * dlb2_hw_create_dir_port() - create a directed port
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port creation arguments.
+ * @cq_dma_base: base address of the CQ memory. This can be a PA or an IOVA.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function creates a directed port.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the port ID.
+ *
+ * resp->id contains a virtual ID if vdev_request is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, a credit setting is invalid, a
+ *	    pointer address is not properly aligned, the domain is not
+ *	    configured, or the domain has already been started.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_create_dir_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_create_dir_port_args *args,
+			    uintptr_t cq_dma_base,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_request,
+			    unsigned int vdev_id);
+
+/**
+ * dlb2_hw_create_ldb_port() - create a load-balanced port
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port creation arguments.
+ * @cq_dma_base: base address of the CQ memory. This can be a PA or an IOVA.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function creates a load-balanced port.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the port ID.
+ *
+ * resp->id contains a virtual ID if vdev_request is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, a credit setting is invalid, a
+ *	    pointer address is not properly aligned, the domain is not
+ *	    configured, or the domain has already been started.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_create_ldb_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_create_ldb_port_args *args,
+			    uintptr_t cq_dma_base,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_request,
+			    unsigned int vdev_id);
+
+/**
  * dlb2_reset_domain() - reset a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @domain_id: domain ID.
@@ -264,4 +336,21 @@ enum dlb2_virt_mode {
 	NUM_DLB2_VIRT_MODES,
 };
 
+/**
+ * dlb2_hw_enable_sparse_ldb_cq_mode() - enable sparse mode for load-balanced
+ *	ports.
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function must be called prior to configuring scheduling domains.
+ */
+void dlb2_hw_enable_sparse_ldb_cq_mode(struct dlb2_hw *hw);
+
+/**
+ * dlb2_hw_enable_sparse_dir_cq_mode() - enable sparse mode for directed ports.
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function must be called prior to configuring scheduling domains.
+ */
+void dlb2_hw_enable_sparse_dir_cq_mode(struct dlb2_hw *hw);
+
 #endif /* __DLB2_RESOURCE_H */
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index ee8f5a970065..df7bb72096cd 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -218,10 +218,32 @@ struct dlb2_get_num_resources_args {
 	__u32 num_dir_credits;
 };
 
+enum dlb2_cq_poll_modes {
+	DLB2_CQ_POLL_MODE_STD,
+	DLB2_CQ_POLL_MODE_SPARSE,
+
+	/* NUM_DLB2_CQ_POLL_MODE must be last */
+	NUM_DLB2_CQ_POLL_MODE,
+};
+
+/*
+ * DLB2_CMD_QUERY_CQ_POLL_MODE: Query the CQ poll mode setting
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: CQ poll mode (see enum dlb2_cq_poll_modes).
+ */
+struct dlb2_query_cq_poll_mode_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+};
+
 enum dlb2_user_interface_commands {
 	DLB2_CMD_GET_DEVICE_VERSION,
 	DLB2_CMD_CREATE_SCHED_DOMAIN,
 	DLB2_CMD_GET_NUM_RESOURCES,
+	DLB2_CMD_QUERY_CQ_POLL_MODE,
 
 	/* NUM_DLB2_CMD must be last */
 	NUM_DLB2_CMD,
@@ -339,16 +361,81 @@ struct dlb2_get_dir_queue_depth_args {
 	__u32 padding0;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_CREATE_LDB_PORT: Configure a load-balanced port.
+ * Input parameters:
+ * - cq_depth: Depth of the port's CQ. Must be a power-of-two between 8 and
+ *	1024, inclusive.
+ * - cq_depth_threshold: CQ depth interrupt threshold. A value of N means that
+ *	the CQ interrupt won't fire until there are N or more outstanding CQ
+ *	tokens.
+ * - num_hist_list_entries: Number of history list entries. This must be
+ *	greater than or equal cq_depth.
+ * - cos_id: class-of-service to allocate this port from. Must be between 0 and
+ *	3, inclusive.
+ * - cos_strict: If set, return an error if there are no available ports in the
+ *	requested class-of-service. Else, allocate the port from a different
+ *	class-of-service if the requested class has no available ports.
+ *
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: port ID.
+ */
+
+struct dlb2_create_ldb_port_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u16 cq_depth;
+	__u16 cq_depth_threshold;
+	__u16 cq_history_list_size;
+	__u8 cos_id;
+	__u8 cos_strict;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_CREATE_DIR_PORT: Configure a directed port.
+ * Input parameters:
+ * - cq_depth: Depth of the port's CQ. Must be a power-of-two between 8 and
+ *	1024, inclusive.
+ * - cq_depth_threshold: CQ depth interrupt threshold. A value of N means that
+ *	the CQ interrupt won't fire until there are N or more outstanding CQ
+ *	tokens.
+ * - qid: Queue ID. If the corresponding directed queue is already created,
+ *	specify its ID here. Else this argument must be 0xFFFFFFFF to indicate
+ *	that the port is being created before the queue.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Port ID.
+ */
+struct dlb2_create_dir_port_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u16 cq_depth;
+	__u16 cq_depth_threshold;
+	__s32 queue_id;
+};
+
 enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
 	DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,
 	DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
+	DLB2_DOMAIN_CMD_CREATE_LDB_PORT,
+	DLB2_DOMAIN_CMD_CREATE_DIR_PORT,
 
 	/* NUM_DLB2_DOMAIN_CMD must be last */
 	NUM_DLB2_DOMAIN_CMD,
 };
 
+#define DLB2_CQ_SIZE 65536
+
 /********************/
 /* dlb2 ioctl codes */
 /********************/
@@ -367,6 +454,10 @@ enum dlb2_domain_user_interface_commands {
 		_IOR(DLB2_IOC_MAGIC,				\
 		     DLB2_CMD_GET_NUM_RESOURCES,		\
 		     struct dlb2_get_num_resources_args)
+#define DLB2_IOC_QUERY_CQ_POLL_MODE				\
+		_IOR(DLB2_IOC_MAGIC,				\
+		     DLB2_CMD_QUERY_CQ_POLL_MODE,		\
+		     struct dlb2_query_cq_poll_mode_args)
 #define DLB2_IOC_CREATE_LDB_QUEUE				\
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,		\
@@ -383,5 +474,13 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,	\
 		      struct dlb2_get_dir_queue_depth_args)
+#define DLB2_IOC_CREATE_LDB_PORT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_CREATE_LDB_PORT,		\
+		      struct dlb2_create_ldb_port_args)
+#define DLB2_IOC_CREATE_DIR_PORT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_CREATE_DIR_PORT,		\
+		      struct dlb2_create_dir_port_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

