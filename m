Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25E3C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FFD20674
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgGLNwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:52:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:8919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgGLNwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:52:18 -0400
IronPort-SDR: ORpR2gEM3ORc2B77/GmZfolgsMco46jnq1VjL8SgsDVfSzFPWZjKYKcoEwZYXB7wATBoKNKfqN
 AXpWQRQ8NeFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540909"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540909"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:50 -0700
IronPort-SDR: rwtV23Dh+yddr4cy2LJ4TOTaJCfgxjJyo1gfN8niVJ7chN/+3izG8akwSQWa8THxxzJHVmK4mC
 73Df+02ihmyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148633"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:49 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 13/20] dlb2: add port enable/disable ioctls
Date:   Sun, 12 Jul 2020 08:43:24 -0500
Message-Id: <20200712134331.8169-14-gage.eads@intel.com>
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

The ioctls can be used to dynamically enable or disable scheduling to a
port. (By default, ports start with their scheduling enabled.) Doing so
allows software to, for example, quickly add/remove cores to/from a worker
pool.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c    | 152 +++++++++++++++
 drivers/misc/dlb2/dlb2_main.h     |  16 ++
 drivers/misc/dlb2/dlb2_pf_ops.c   |  40 ++++
 drivers/misc/dlb2/dlb2_resource.c | 382 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h | 120 ++++++++++++
 include/uapi/linux/dlb2_user.h    |  96 ++++++++++
 6 files changed, 806 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 65d7ab82161c..ff1037ffee3f 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -101,6 +101,154 @@ DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
 DLB2_DOMAIN_IOCTL_CALLBACK_TEMPLATE(pending_port_unmaps)
 
 /*
+ * Port enable/disable ioctls don't use the callback template macro because
+ * they have additional CQ interrupt management logic.
+ */
+static int dlb2_domain_ioctl_enable_ldb_port(struct dlb2_dev *dev,
+					     struct dlb2_domain *domain,
+					     unsigned long user_arg,
+					     u16 size)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_enable_ldb_port_args arg;
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
+	ret = dev->ops->enable_ldb_port(&dev->hw, domain->id, &arg, &response);
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
+static int dlb2_domain_ioctl_enable_dir_port(struct dlb2_dev *dev,
+					     struct dlb2_domain *domain,
+					     unsigned long user_arg,
+					     u16 size)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_enable_dir_port_args arg;
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
+	ret = dev->ops->enable_dir_port(&dev->hw, domain->id, &arg, &response);
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
+static int dlb2_domain_ioctl_disable_ldb_port(struct dlb2_dev *dev,
+					      struct dlb2_domain *domain,
+					      unsigned long user_arg,
+					      u16 size)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_disable_ldb_port_args arg;
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
+	ret = dev->ops->disable_ldb_port(&dev->hw, domain->id, &arg, &response);
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
+static int dlb2_domain_ioctl_disable_dir_port(struct dlb2_dev *dev,
+					      struct dlb2_domain *domain,
+					      unsigned long user_arg,
+					      u16 size)
+{
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_disable_dir_port_args arg;
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
+	ret = dev->ops->disable_dir_port(&dev->hw, domain->id, &arg, &response);
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
+/*
  * Port creation ioctls don't use the callback template macro because they have
  * a number of OS-dependent memory operations.
  */
@@ -472,6 +620,10 @@ dlb2_domain_ioctl_callback_fns[NUM_DLB2_DOMAIN_CMD] = {
 	dlb2_domain_ioctl_start_domain,
 	dlb2_domain_ioctl_map_qid,
 	dlb2_domain_ioctl_unmap_qid,
+	dlb2_domain_ioctl_enable_ldb_port,
+	dlb2_domain_ioctl_enable_dir_port,
+	dlb2_domain_ioctl_disable_ldb_port,
+	dlb2_domain_ioctl_disable_dir_port,
 	dlb2_domain_ioctl_get_ldb_queue_depth,
 	dlb2_domain_ioctl_get_dir_queue_depth,
 	dlb2_domain_ioctl_pending_port_unmaps,
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index bca24e3a4f84..edd5d9703ebb 100644
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
index 51562978ee1a..b5b1b14bcb7e 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -318,6 +318,42 @@ dlb2_pf_pending_port_unmaps(struct dlb2_hw *hw,
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
@@ -408,6 +444,10 @@ struct dlb2_device_ops dlb2_pf_ops = {
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
index bc1c16ebadde..a7e28088458e 100644
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
index 80bebeee7bb6..bc02d01e2a5e 100644
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
index bc692eb73bc8..763ae7eb7a23 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -533,6 +533,82 @@ struct dlb2_unmap_qid_args {
 };
 
 /*
+ * DLB2_DOMAIN_CMD_ENABLE_LDB_PORT: Enable scheduling to a load-balanced port.
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ */
+struct dlb2_enable_ldb_port_args {
+	/* Output parameters */
+	__u64 response;
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
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ */
+struct dlb2_enable_dir_port_args {
+	/* Output parameters */
+	__u64 response;
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
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ */
+struct dlb2_disable_ldb_port_args {
+	/* Output parameters */
+	__u64 response;
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
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ */
+struct dlb2_disable_dir_port_args {
+	/* Output parameters */
+	__u64 response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 padding0;
+};
+
+/*
  * DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH: Get a load-balanced queue's depth.
  * Input parameters:
  * - queue_id: The load-balanced queue ID.
@@ -639,6 +715,10 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_START_DOMAIN,
 	DLB2_DOMAIN_CMD_MAP_QID,
 	DLB2_DOMAIN_CMD_UNMAP_QID,
+	DLB2_DOMAIN_CMD_ENABLE_LDB_PORT,
+	DLB2_DOMAIN_CMD_ENABLE_DIR_PORT,
+	DLB2_DOMAIN_CMD_DISABLE_LDB_PORT,
+	DLB2_DOMAIN_CMD_DISABLE_DIR_PORT,
 	DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,
 	DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
 	DLB2_DOMAIN_CMD_PENDING_PORT_UNMAPS,
@@ -716,6 +796,22 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_UNMAP_QID,		\
 		      struct dlb2_unmap_qid_args)
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
 #define DLB2_IOC_GET_LDB_QUEUE_DEPTH				\
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,	\
-- 
2.13.6

