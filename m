Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F18BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650A520767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbgIATWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:53436 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbgIATVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:49 -0400
IronPort-SDR: HRwERtlTtnLagblBgrdA2hz1ykMwH8Yh43IzLAcJMhcoyhJLKWQjjpT6/rpwbHd5qfaN3kMwzf
 Yw8TfELJIbmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807344"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807344"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:34 -0700
IronPort-SDR: +/G4ESrmjDAFApF7jQcuF7shghX1tiaVVfUJ2wh/UBj9OshujLbwuT2B2vv3dWhZfIq+PY08Dr
 +dBRbIEGgu+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480502"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:33 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 14/19] dlb2: add domain alert support
Date:   Tue,  1 Sep 2020 14:15:43 -0500
Message-Id: <20200901191548.31646-15-gage.eads@intel.com>
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

Domain alerts are a mechanism for the driver to asynchronously notify
user-space applications of device reset or hardware alarms (both to be
added in later commits). This mechanism also allows the application to
enqueue an alert to its domain, as a form of (limited) IPC in a
multi-process scenario.

An application can read its domain alerts through the domain device file's
read callback. Applications are expected to spawn a thread that performs a
blocking read, and rarely (if ever) wakes and returns to user-space.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/dlb2_ioctl.c |  17 ++++++
 drivers/misc/dlb2/dlb2_main.c  | 130 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h  |  16 +++++
 include/uapi/linux/dlb2_user.h | 134 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 297 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 010e67941cf9..2350d8ff823e 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -493,6 +493,21 @@ static int dlb2_domain_ioctl_get_dir_port_cq_fd(struct dlb2_dev *dev,
 				       "dlb2_dir_cq:", &dlb2_cq_fops, false);
 }
 
+static int dlb2_domain_ioctl_enqueue_domain_alert(struct dlb2_dev *dev,
+						  struct dlb2_domain *domain,
+						  unsigned long user_arg)
+{
+	struct dlb2_enqueue_domain_alert_args arg;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	return dlb2_write_domain_alert(dev,
+				       domain,
+				       DLB2_DOMAIN_ALERT_USER,
+				       arg.aux_alert_data);
+}
+
 long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct dlb2_domain *dom = f->private_data;
@@ -537,6 +552,8 @@ long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_domain_ioctl_disable_dir_port(dev, dom, arg);
 	case DLB2_IOC_BLOCK_ON_CQ_INTERRUPT:
 		return dlb2_domain_ioctl_block_on_cq_interrupt(dev, dom, arg);
+	case DLB2_IOC_ENQUEUE_DOMAIN_ALERT:
+		return dlb2_domain_ioctl_enqueue_domain_alert(dev, dom, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index b542c2c081a5..b457bda7be44 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -101,6 +101,9 @@ int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id)
 	kref_init(&domain->refcnt);
 	domain->dlb2_dev = dlb2_dev;
 
+	spin_lock_init(&domain->alert_lock);
+	init_waitqueue_head(&domain->wq_head);
+
 	dlb2_dev->sched_domains[domain_id] = domain;
 
 	dlb2_dev->ops->inc_pm_refcnt(dlb2_dev->pdev, true);
@@ -227,9 +230,136 @@ static int dlb2_domain_close(struct inode *i, struct file *f)
 	return ret;
 }
 
+int dlb2_write_domain_alert(struct dlb2_dev *dev,
+			    struct dlb2_domain *domain,
+			    u64 alert_id,
+			    u64 aux_alert_data)
+{
+	struct dlb2_domain_alert alert;
+	int idx;
+
+	if (!domain)
+		return -EINVAL;
+
+	/* Grab the alert lock to access the read and write indexes */
+	spin_lock(&domain->alert_lock);
+
+	/* If there's no space for this notification, return */
+	if ((domain->alert_wr_idx - domain->alert_rd_idx) ==
+	    (DLB2_DOMAIN_ALERT_RING_SIZE - 1)) {
+		spin_unlock(&domain->alert_lock);
+		return 0;
+	}
+
+	alert.alert_id = alert_id;
+	alert.aux_alert_data = aux_alert_data;
+
+	idx = domain->alert_wr_idx % DLB2_DOMAIN_ALERT_RING_SIZE;
+
+	domain->alerts[idx] = alert;
+
+	domain->alert_wr_idx++;
+
+	spin_unlock(&domain->alert_lock);
+
+	/* Wake any blocked readers */
+	wake_up_interruptible(&domain->wq_head);
+
+	return 0;
+}
+
+static bool dlb2_alerts_avail(struct dlb2_domain *domain)
+{
+	bool ret;
+
+	spin_lock(&domain->alert_lock);
+
+	ret = domain->alert_rd_idx != domain->alert_wr_idx;
+
+	spin_unlock(&domain->alert_lock);
+
+	return ret;
+}
+
+static int dlb2_read_domain_alert(struct dlb2_dev *dev,
+				  struct dlb2_domain *domain,
+				  struct dlb2_domain_alert *alert,
+				  bool nonblock)
+{
+	int idx;
+
+	/* Grab the alert lock to access the read and write indexes */
+	spin_lock(&domain->alert_lock);
+
+	while (domain->alert_rd_idx == domain->alert_wr_idx) {
+		/*
+		 * Release the alert lock before putting the thread on the wait
+		 * queue.
+		 */
+		spin_unlock(&domain->alert_lock);
+
+		if (nonblock)
+			return -EWOULDBLOCK;
+
+		dev_dbg(dev->dlb2_device,
+			"Thread %d is blocking waiting for an alert in domain %d\n",
+			current->pid, domain->id);
+
+		if (wait_event_interruptible(domain->wq_head,
+					     dlb2_alerts_avail(domain)))
+			return -ERESTARTSYS;
+
+		spin_lock(&domain->alert_lock);
+	}
+
+	/* The alert indexes are not equal, so there is an alert available. */
+	idx = domain->alert_rd_idx % DLB2_DOMAIN_ALERT_RING_SIZE;
+
+	memcpy(alert, &domain->alerts[idx], sizeof(*alert));
+
+	domain->alert_rd_idx++;
+
+	spin_unlock(&domain->alert_lock);
+
+	return 0;
+}
+
+static ssize_t dlb2_domain_read(struct file *f,
+				char __user *buf,
+				size_t len,
+				loff_t *offset)
+{
+	struct dlb2_domain *domain = f->private_data;
+	struct dlb2_dev *dev = domain->dlb2_dev;
+	struct dlb2_domain_alert alert;
+	int ret;
+
+	if (len != sizeof(alert))
+		return -EINVAL;
+
+	/* See dlb2_user.h for details on domain alert notifications */
+
+	ret = dlb2_read_domain_alert(dev,
+				     domain,
+				     &alert,
+				     f->f_flags & O_NONBLOCK);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(buf, &alert, sizeof(alert)))
+		return -EFAULT;
+
+	dev_dbg(dev->dlb2_device,
+		"Thread %d received alert 0x%llx, with aux data 0x%llx\n",
+		current->pid, ((u64 *)&alert)[0], ((u64 *)&alert)[1]);
+
+	return sizeof(alert);
+}
+
 const struct file_operations dlb2_domain_fops = {
 	.owner   = THIS_MODULE,
 	.release = dlb2_domain_close,
+	.read    = dlb2_domain_read,
 	.unlocked_ioctl = dlb2_domain_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 };
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index db462209fa6a..c1ae4267ff19 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <uapi/linux/dlb2_user.h>
@@ -161,9 +162,20 @@ struct dlb2_port {
 	u8 valid;
 };
 
+#define DLB2_DOMAIN_ALERT_RING_SIZE 256
+
 struct dlb2_domain {
 	struct dlb2_dev *dlb2_dev;
+	struct dlb2_domain_alert alerts[DLB2_DOMAIN_ALERT_RING_SIZE];
+	wait_queue_head_t wq_head;
+	/*
+	 * The alert lock protects access to the alert ring and its read and
+	 * write indexes.
+	 */
+	spinlock_t alert_lock;
 	struct kref refcnt;
+	u8 alert_rd_idx;
+	u8 alert_wr_idx;
 	u8 id;
 };
 
@@ -225,6 +237,10 @@ struct dlb2_dev {
 
 int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id);
 void dlb2_free_domain(struct kref *kref);
+int dlb2_write_domain_alert(struct dlb2_dev *dev,
+			    struct dlb2_domain *domain,
+			    u64 alert_id,
+			    u64 aux_alert_data);
 
 #define DLB2_HW_ERR(dlb2, ...) do {		       \
 	struct dlb2_dev *dev;			       \
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 9edeff826e15..48783a8e91c2 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -249,6 +249,117 @@ enum dlb2_user_interface_commands {
 	NUM_DLB2_CMD,
 };
 
+/*******************************/
+/* 'domain' device file alerts */
+/*******************************/
+
+/*
+ * Scheduling domain device files can be read to receive domain-specific
+ * notifications, for alerts such as hardware errors or device reset.
+ *
+ * Each alert is encoded in a 16B message. The first 8B contains the alert ID,
+ * and the second 8B is optional and contains additional information.
+ * Applications should cast read data to a struct dlb2_domain_alert, and
+ * interpret the struct's alert_id according to dlb2_domain_alert_id. The read
+ * length must be 16B, or the function will return -EINVAL.
+ *
+ * Reads are destructive, and in the case of multiple file descriptors for the
+ * same domain device file, an alert will be read by only one of the file
+ * descriptors.
+ *
+ * The driver stores alerts in a fixed-size alert ring until they are read. If
+ * the alert ring fills completely, subsequent alerts will be dropped. It is
+ * recommended that DLB2 applications dedicate a thread to perform blocking
+ * reads on the device file.
+ */
+enum dlb2_domain_alert_id {
+	/*
+	 * Software issued an illegal enqueue for a port in this domain. An
+	 * illegal enqueue could be:
+	 * - Illegal (excess) completion
+	 * - Illegal fragment
+	 * - Insufficient credits
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ,
+	/*
+	 * Software issued excess CQ token pops for a port in this domain.
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS,
+	/*
+	 * A enqueue contained either an invalid command encoding or a REL,
+	 * REL_T, RLS, FWD, FWD_T, FRAG, or FRAG_T from a directed port.
+	 *
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_ILLEGAL_HCW,
+	/*
+	 * The QID must be valid and less than 128.
+	 *
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_ILLEGAL_QID,
+	/*
+	 * An enqueue went to a disabled QID.
+	 *
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_DISABLED_QID,
+	/*
+	 * The device containing this domain was reset. All applications using
+	 * the device need to exit for the driver to complete the reset
+	 * procedure.
+	 *
+	 * aux_alert_data doesn't contain any information for this alert.
+	 */
+	DLB2_DOMAIN_ALERT_DEVICE_RESET,
+	/*
+	 * User-space has enqueued an alert.
+	 *
+	 * aux_alert_data contains user-provided data.
+	 */
+	DLB2_DOMAIN_ALERT_USER,
+	/*
+	 * The watchdog timer fired for the specified port. This occurs if its
+	 * CQ was not serviced for a large amount of time, likely indicating a
+	 * hung thread.
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_CQ_WATCHDOG_TIMEOUT,
+
+	/* Number of DLB2 domain alerts */
+	NUM_DLB2_DOMAIN_ALERTS
+};
+
+static const char dlb2_domain_alert_strings[][128] = {
+	"DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ",
+	"DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS",
+	"DLB2_DOMAIN_ALERT_ILLEGAL_HCW",
+	"DLB2_DOMAIN_ALERT_ILLEGAL_QID",
+	"DLB2_DOMAIN_ALERT_DISABLED_QID",
+	"DLB2_DOMAIN_ALERT_DEVICE_RESET",
+	"DLB2_DOMAIN_ALERT_USER",
+	"DLB2_DOMAIN_ALERT_CQ_WATCHDOG_TIMEOUT",
+};
+
+struct dlb2_domain_alert {
+	__u64 alert_id;
+	__u64 aux_alert_data;
+};
+
 /*********************************/
 /* 'domain' device file commands */
 /*********************************/
@@ -641,6 +752,24 @@ struct dlb2_block_on_cq_interrupt_args {
 	__u64 cq_va;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_ENQUEUE_DOMAIN_ALERT: Enqueue a domain alert that will be
+ *	read by one reader thread.
+ *
+ * Input parameters:
+ * - aux_alert_data: user-defined auxiliary data.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_enqueue_domain_alert_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u64 aux_alert_data;
+};
+
 enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
@@ -661,6 +790,7 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_DISABLE_LDB_PORT,
 	DLB2_DOMAIN_CMD_DISABLE_DIR_PORT,
 	DLB2_DOMAIN_CMD_BLOCK_ON_CQ_INTERRUPT,
+	DLB2_DOMAIN_CMD_ENQUEUE_DOMAIN_ALERT,
 
 	/* NUM_DLB2_DOMAIN_CMD must be last */
 	NUM_DLB2_DOMAIN_CMD,
@@ -771,5 +901,9 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_BLOCK_ON_CQ_INTERRUPT,	\
 		      struct dlb2_block_on_cq_interrupt_args)
+#define DLB2_IOC_ENQUEUE_DOMAIN_ALERT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_ENQUEUE_DOMAIN_ALERT,	\
+		      struct dlb2_enqueue_domain_alert_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

