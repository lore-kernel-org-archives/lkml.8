Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C1C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20EE206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgGLNrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:47:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:8461 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbgGLNrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:47:17 -0400
IronPort-SDR: xXWYgoEIGb4UyyGEM0IcAYjZ8kyFuAqofNR0V+gVYFgWAUuExkkThyJBWM7+YDNNei6UZbx9DE
 ZYytBaq/kz5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540895"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:46 -0700
IronPort-SDR: wzg9uA78Opovfv5Et3mFuYBkKgu5RH9DjqJGlCoOBPMgXD5s/mZIhRbZhKj98LnvDWwdsxjf7n
 1M7wybvYQNmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148609"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:45 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 06/20] dlb2: add ioctl to get sched domain fd
Date:   Sun, 12 Jul 2020 08:43:17 -0500
Message-Id: <20200712134331.8169-7-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200712134331.8169-1-gage.eads@intel.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To create the file and install it in the current process's file table, the
driver uses anon_inode_getfd(). The calling process can then use this fd
to issue ioctls for configuration of the scheduilng domain's resources (to
be added in an upcoming commit).

This design means that any application with sufficient permissions to
access the /dev/dlb<N> file can request the fd of any scheduling domain --
potentially one that was created by another process. One way to ensure that
dlb applications cannot access each other's scheduling domains is to use
virtualization; that is, create multiple virtual functions -- and thus
multiple /dev/dlb<N> nodes -- each using unique file permissions.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/dlb2_user.h | 30 +++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 8ad3391b63d4..eef9b824b276 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -147,6 +147,73 @@ static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
 	return ret;
 }
 
+static int dlb2_ioctl_get_sched_domain_fd(struct dlb2_dev *dev,
+					  unsigned long user_arg,
+					  u16 size)
+{
+	struct dlb2_get_sched_domain_fd_args arg;
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_domain *domain;
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
+	if (arg.domain_id >= DLB2_MAX_NUM_DOMAINS) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Invalid domain id %u\n",
+			__func__, arg.domain_id);
+		response.status = DLB2_ST_INVALID_DOMAIN_ID;
+		ret = -EINVAL;
+		goto copy;
+	}
+
+	mutex_lock(&dev->resource_mutex);
+
+	domain = dev->sched_domains[arg.domain_id];
+
+	if (!domain) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain %u not configured\n",
+			__func__, arg.domain_id);
+		response.status = DLB2_ST_DOMAIN_UNAVAILABLE;
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	ret = anon_inode_getfd("[dlb2domain]", &dlb2_domain_fops,
+			       domain, O_RDWR);
+
+	response.id = ret;
+
+	if (ret >= 0) {
+		kref_get(&domain->refcnt);
+
+		ret = 0;
+	}
+
+unlock:
+	mutex_unlock(&dev->resource_mutex);
+
+copy:
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
 static int dlb2_ioctl_get_num_resources(struct dlb2_dev *dev,
 					unsigned long user_arg,
 					u16 size)
@@ -205,6 +272,7 @@ typedef int (*dlb2_ioctl_callback_fn_t)(struct dlb2_dev *dev,
 static dlb2_ioctl_callback_fn_t dlb2_ioctl_callback_fns[NUM_DLB2_CMD] = {
 	dlb2_ioctl_get_device_version,
 	dlb2_ioctl_create_sched_domain,
+	dlb2_ioctl_get_sched_domain_fd,
 	dlb2_ioctl_get_num_resources,
 	dlb2_ioctl_get_driver_version,
 };
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 37b0a7b98a86..95e0d2672abf 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -239,6 +239,31 @@ struct dlb2_create_sched_domain_args {
 };
 
 /*
+ * DLB2_CMD_GET_SCHED_DOMAIN_FD: Get an anonymous scheduling domain fd.
+ *
+ *	The domain must have been previously created with the ioctl
+ *	DLB2_CMD_CREATE_SCHED_DOMAIN. The domain is reset when all
+ *	its open files and memory mappings are closed.
+ *
+ * Input parameters:
+ * - domain_id: Domain ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response: pointer to a struct dlb2_cmd_response.
+ *	response.status: Detailed error code. In certain cases, such as if the
+ *		response pointer is invalid, the driver won't set status.
+ *	response.id: domain fd.
+ */
+struct dlb2_get_sched_domain_fd_args {
+	/* Output parameters */
+	__u64 response;
+	/* Input parameters */
+	__u32 domain_id;
+	__u32 padding0;
+};
+
+/*
  * DLB2_CMD_GET_NUM_RESOURCES: Return the number of available resources
  *	(queues, ports, etc.) that this device owns.
  *
@@ -275,6 +300,7 @@ struct dlb2_get_num_resources_args {
 enum dlb2_user_interface_commands {
 	DLB2_CMD_GET_DEVICE_VERSION,
 	DLB2_CMD_CREATE_SCHED_DOMAIN,
+	DLB2_CMD_GET_SCHED_DOMAIN_FD,
 	DLB2_CMD_GET_NUM_RESOURCES,
 	DLB2_CMD_GET_DRIVER_VERSION,
 
@@ -296,6 +322,10 @@ enum dlb2_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_CMD_CREATE_SCHED_DOMAIN,		\
 		      struct dlb2_create_sched_domain_args)
+#define DLB2_IOC_GET_SCHED_DOMAIN_FD				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_CMD_GET_SCHED_DOMAIN_FD,		\
+		      struct dlb2_get_sched_domain_fd_args)
 #define DLB2_IOC_GET_NUM_RESOURCES				\
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_CMD_GET_NUM_RESOURCES,		\
-- 
2.13.6

