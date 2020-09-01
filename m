Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1270C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74264207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbgIATXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:23:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:53436 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgIATVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:41 -0400
IronPort-SDR: x65/M0T0eT9BXTW1ZirHC6UEmeYlC80OWaHMnwU0H7YPaubUK5ykWQKSXCKA21oszX2MbBocuq
 izPNHIU7jz7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807335"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:33 -0700
IronPort-SDR: v2fxN9+dBaFA3ExRh7LsY99//CIK3FguZhzmVMcry7fObpRH+w48mRpMHxN0fg1auWPx3PY0j7
 wolZrfrb7r6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480490"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:32 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 12/19] dlb2: add port enable/disable ioctls
Date:   Tue,  1 Sep 2020 14:15:41 -0500
Message-Id: <20200901191548.31646-13-gage.eads@intel.com>
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

The ioctls can be used to dynamically enable or disable scheduling to a
port. (By default, ports start with their scheduling enabled.) Doing so
allows software to, for example, quickly add/remove cores to/from a worker
pool.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    | 112 +++++++++++
 drivers/misc/dlb2/dlb2_main.h     |  16 ++
 drivers/misc/dlb2/dlb2_pf_ops.c   |  40 ++++
 drivers/misc/dlb2/dlb2_resource.c | 382 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h | 120 ++++++++++++
 include/uapi/linux/dlb2_user.h    |  92 +++++++++
 6 files changed, 762 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 0ab4a95fb34a..490c380670cc 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -57,6 +57,110 @@ DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(unmap_qid)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(pending_port_unmaps)
 
 /*
+ * Port enable/disable ioctls don't use the callback template macro because
+ * they have additional CQ interrupt management logic.
+ */
+static int dlb2_domain_ioctl_enable_ldb_port(struct dlb2_dev *dev,
+					     struct dlb2_domain *domain,
+					     unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_enable_ldb_port_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->enable_ldb_port(&dev->hw, domain->id, &arg, &response);
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
+static int dlb2_domain_ioctl_enable_dir_port(struct dlb2_dev *dev,
+					     struct dlb2_domain *domain,
+					     unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_enable_dir_port_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->enable_dir_port(&dev->hw, domain->id, &arg, &response);
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
+static int dlb2_domain_ioctl_disable_ldb_port(struct dlb2_dev *dev,
+					      struct dlb2_domain *domain,
+					      unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_disable_ldb_port_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->disable_ldb_port(&dev->hw, domain->id, &arg, &response);
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
+static int dlb2_domain_ioctl_disable_dir_port(struct dlb2_dev *dev,
+					      struct dlb2_domain *domain,
+					      unsigned long user_arg)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_disable_dir_port_args arg;
+	int ret;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	mutex_lock(&dev->resource_mutex);
+
+	ret = dev->ops->disable_dir_port(&dev->hw, domain->id, &arg, &response);
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
+/*
  * Port creation ioctls don't use the callback template macro because they have
  * a number of OS-dependent memory operations.
  */
@@ -355,6 +459,14 @@ long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_domain_ioctl_unmap_qid(dev, dom, arg);
 	case DLB2_IOC_PENDING_PORT_UNMAPS:
 		return dlb2_domain_ioctl_pending_port_unmaps(dev, dom, arg);
+	case DLB2_IOC_ENABLE_LDB_PORT:
+		return dlb2_domain_ioctl_enable_ldb_port(dev, dom, arg);
+	case DLB2_IOC_ENABLE_DIR_PORT:
+		return dlb2_domain_ioctl_enable_dir_port(dev, dom, arg);
+	case DLB2_IOC_DISABLE_LDB_PORT:
+		return dlb2_domain_ioctl_disable_ldb_port(dev, dom, arg);
+	case DLB2_IOC_DISABLE_DIR_PORT:
+		return dlb2_domain_ioctl_disable_dir_port(dev, dom, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 626a3311eb18..92e182603445 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -94,6 +94,22 @@ struct dlb2_device_ops {
 				   u32 domain_id,
 				   struct dlb2_pending_port_unmaps_args *args,
 				   struct dlb2_cmd_response *resp);
+	int (*enable_ldb_port)(struct dlb2_hw *hw,
+			       u32 domain_id,
+			       struct dlb2_enable_ldb_port_args *args,
+			       struct dlb2_cmd_response *resp);
+	int (*disable_ldb_port)(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_disable_ldb_port_args *args,
+				struct dlb2_cmd_response *resp);
+	int (*enable_dir_port)(struct dlb2_hw *hw,
+			       u32 domain_id,
+			       struct dlb2_enable_dir_port_args *args,
+			       struct dlb2_cmd_response *resp);
+	int (*disable_dir_port)(struct dlb2_hw *hw,
+				u32 domain_id,
+				struct dlb2_disable_dir_port_args *args,
+				struct dlb2_cmd_response *resp);
 	int (*get_num_resources)(struct dlb2_hw *hw,
 				 struct dlb2_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb2_hw *hw, u32 domain_id);
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index b531448d1a25..8b1aac196073 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -299,6 +299,42 @@ dlb2_pf_pending_port_unmaps(struct dlb2_hw *hw,
 }
 
 static int
+dlb2_pf_enable_ldb_port(struct dlb2_hw *hw,
+			u32 id,
+			struct dlb2_enable_ldb_port_args *args,
+			struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_enable_ldb_port(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb2_pf_disable_ldb_port(struct dlb2_hw *hw,
+			 u32 id,
+			 struct dlb2_disable_ldb_port_args *args,
+			 struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_disable_ldb_port(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb2_pf_enable_dir_port(struct dlb2_hw *hw,
+			u32 id,
+			struct dlb2_enable_dir_port_args *args,
+			struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_enable_dir_port(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb2_pf_disable_dir_port(struct dlb2_hw *hw,
+			 u32 id,
+			 struct dlb2_disable_dir_port_args *args,
+			 struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_disable_dir_port(hw, id, args, resp, false, 0);
+}
+
+static int
 dlb2_pf_get_num_resources(struct dlb2_hw *hw,
 			  struct dlb2_get_num_resources_args *args)
 {
@@ -389,6 +425,10 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.map_qid = dlb2_pf_map_qid,
 	.unmap_qid = dlb2_pf_unmap_qid,
 	.pending_port_unmaps = dlb2_pf_pending_port_unmaps,
+	.enable_ldb_port = dlb2_pf_enable_ldb_port,
+	.enable_dir_port = dlb2_pf_enable_dir_port,
+	.disable_ldb_port = dlb2_pf_disable_ldb_port,
+	.disable_dir_port = dlb2_pf_disable_dir_port,
 	.get_num_resources = dlb2_pf_get_num_resources,
 	.reset_domain = dlb2_pf_reset_domain,
 	.ldb_port_owned_by_domain = dlb2_pf_ldb_port_owned_by_domain,
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 6afac8c99c06..665841ca7919 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -1707,6 +1707,150 @@ static int dlb2_verify_unmap_qid_args(struct dlb2_hw *hw,
 	return -EINVAL;
 }
 
+static int
+dlb2_verify_enable_ldb_port_args(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 struct dlb2_enable_ldb_port_args *args,
+				 struct dlb2_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
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
+	return 0;
+}
+
+static int
+dlb2_verify_enable_dir_port_args(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 struct dlb2_enable_dir_port_args *args,
+				 struct dlb2_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_dir_pq_pair *port;
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
+	port = dlb2_get_domain_used_dir_pq(id, vdev_req, domain);
+
+	if (!port || !port->port_configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dlb2_verify_disable_ldb_port_args(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  struct dlb2_disable_ldb_port_args *args,
+				  struct dlb2_cmd_response *resp,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
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
+	return 0;
+}
+
+static int
+dlb2_verify_disable_dir_port_args(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  struct dlb2_disable_dir_port_args *args,
+				  struct dlb2_cmd_response *resp,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_dir_pq_pair *port;
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
+	port = dlb2_get_domain_used_dir_pq(id, vdev_req, domain);
+
+	if (!port || !port->port_configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void dlb2_configure_domain_credits(struct dlb2_hw *hw,
 					  struct dlb2_hw_domain *domain)
 {
@@ -4303,6 +4447,244 @@ int dlb2_hw_unmap_qid(struct dlb2_hw *hw,
 	return 0;
 }
 
+static void dlb2_log_enable_port(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 u32 port_id,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 enable port arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tPort ID:   %d\n",
+		    port_id);
+}
+
+int dlb2_hw_enable_ldb_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_ldb_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int ret, id;
+
+	dlb2_log_enable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_enable_ldb_port_args(hw,
+					       domain_id,
+					       args,
+					       resp,
+					       vdev_req,
+					       vdev_id);
+	if (ret)
+		return ret;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_ldb_port(id, vdev_req, domain);
+
+	/* Hardware requires disabling the CQ before unmapping QIDs. */
+	if (!port->enabled) {
+		dlb2_ldb_port_cq_enable(hw, port);
+		port->enabled = true;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
+static void dlb2_log_disable_port(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  u32 port_id,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 disable port arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tPort ID:   %d\n",
+		    port_id);
+}
+
+int dlb2_hw_disable_ldb_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_ldb_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int ret, id;
+
+	dlb2_log_disable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_disable_ldb_port_args(hw,
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
+	/* Hardware requires disabling the CQ before unmapping QIDs. */
+	if (port->enabled) {
+		dlb2_ldb_port_cq_disable(hw, port);
+		port->enabled = false;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
+int dlb2_hw_enable_dir_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_dir_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *port;
+	struct dlb2_hw_domain *domain;
+	int ret, id;
+
+	dlb2_log_enable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_enable_dir_port_args(hw,
+					       domain_id,
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
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_dir_pq(id, vdev_req, domain);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/* Hardware requires disabling the CQ before unmapping QIDs. */
+	if (!port->enabled) {
+		dlb2_dir_port_cq_enable(hw, port);
+		port->enabled = true;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
+int dlb2_hw_disable_dir_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_dir_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *port;
+	struct dlb2_hw_domain *domain;
+	int ret, id;
+
+	dlb2_log_disable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_disable_dir_port_args(hw,
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
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_dir_pq(id, vdev_req, domain);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port not found\n",
+			    __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/* Hardware requires disabling the CQ before unmapping QIDs. */
+	if (port->enabled) {
+		dlb2_dir_port_cq_disable(hw, port);
+		port->enabled = false;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
 static u32 dlb2_ldb_cq_inflight_count(struct dlb2_hw *hw,
 				      struct dlb2_ldb_port *port)
 {
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index 4843da49935f..a78a8664eabc 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -325,6 +325,126 @@ int dlb2_hw_unmap_qid(struct dlb2_hw *hw,
 		      unsigned int vdev_id);
 
 /**
+ * dlb2_hw_enable_ldb_port() - enable a load-balanced port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port enable arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs to a load-balanced port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_enable_ldb_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_ldb_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_request,
+			    unsigned int vdev_id);
+
+/**
+ * dlb2_hw_disable_ldb_port() - disable a load-balanced port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port disable arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs to a load-balanced
+ * port. Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_disable_ldb_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_ldb_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_request,
+			     unsigned int vdev_id);
+
+/**
+ * dlb2_hw_enable_dir_port() - enable a directed port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port enable arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs to a directed port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_enable_dir_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_dir_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_request,
+			    unsigned int vdev_id);
+
+/**
+ * dlb2_hw_disable_dir_port() - disable a directed port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port disable arguments.
+ * @resp: response structure.
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs to a directed port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_disable_dir_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_dir_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_request,
+			     unsigned int vdev_id);
+
+/**
  * dlb2_reset_domain() - reset a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @domain_id: domain ID.
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 1fdc7627c393..00e9833bae1b 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -537,6 +537,78 @@ struct dlb2_pending_port_unmaps_args {
 	__u32 padding0;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_ENABLE_LDB_PORT: Enable scheduling to a load-balanced port.
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_enable_ldb_port_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 padding0;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_ENABLE_DIR_PORT: Enable scheduling to a directed port.
+ * Input parameters:
+ * - port_id: Directed port ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_enable_dir_port_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_DISABLE_LDB_PORT: Disable scheduling to a load-balanced
+ *	port.
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_disable_ldb_port_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 padding0;
+};
+
+/*
+ * DLB2_DOMAIN_CMD_DISABLE_DIR_PORT: Disable scheduling to a directed port.
+ * Input parameters:
+ * - port_id: Directed port ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_disable_dir_port_args {
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
@@ -552,6 +624,10 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_MAP_QID,
 	DLB2_DOMAIN_CMD_UNMAP_QID,
 	DLB2_DOMAIN_CMD_PENDING_PORT_UNMAPS,
+	DLB2_DOMAIN_CMD_ENABLE_LDB_PORT,
+	DLB2_DOMAIN_CMD_ENABLE_DIR_PORT,
+	DLB2_DOMAIN_CMD_DISABLE_LDB_PORT,
+	DLB2_DOMAIN_CMD_DISABLE_DIR_PORT,
 
 	/* NUM_DLB2_DOMAIN_CMD must be last */
 	NUM_DLB2_DOMAIN_CMD,
@@ -642,5 +718,21 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_PENDING_PORT_UNMAPS,	\
 		      struct dlb2_pending_port_unmaps_args)
+#define DLB2_IOC_ENABLE_LDB_PORT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_ENABLE_LDB_PORT,		\
+		      struct dlb2_enable_ldb_port_args)
+#define DLB2_IOC_ENABLE_DIR_PORT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_ENABLE_DIR_PORT,		\
+		      struct dlb2_enable_dir_port_args)
+#define DLB2_IOC_DISABLE_LDB_PORT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_DISABLE_LDB_PORT,		\
+		      struct dlb2_disable_ldb_port_args)
+#define DLB2_IOC_DISABLE_DIR_PORT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_DISABLE_DIR_PORT,		\
+		      struct dlb2_disable_dir_port_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

