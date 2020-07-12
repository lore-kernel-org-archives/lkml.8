Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C591C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB4E20674
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgGLN7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:59:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:8919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbgGLN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:59:44 -0400
IronPort-SDR: XRFMrsNE/KcEhu4gIipHnVL/U0s2LYyfjcgG8G+yJImtuvGThdmpk/qo6AAvu3QsyEiwr7yAoZ
 AlRN8onzmHjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540916"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:53 -0700
IronPort-SDR: YfvpKv8OCrP+jn8gb0TibcxOGvaVZWfmCAR7RHucOtLLd4n6U6fXtD42wndP+Tg4Rjvh5Dsj4i
 Fr3JAmQHPxMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148653"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:52 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 18/20] dlb2: add device FLR support
Date:   Sun, 12 Jul 2020 08:43:29 -0500
Message-Id: <20200712134331.8169-19-gage.eads@intel.com>
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

A device FLR can be triggered while applications are actively using the
device, which poses two problems:
- If applications continue to enqueue to the hardware they will cause
  hardware errors, because the FLR will have reset the scheduling domains,
  ports, and queues.
- When the applications end, they must not trigger the driver's domain
  reset logic, which would fail because the device's registers will have
  been reset by the FLR.

The driver needs to stop applications from using the device before the FLR
begins, and detect when these applications exit (so they don't trigger the
domain reset that occurs when their last file reference (or memory mapping)
closes). The driver must also disallow applications from configuring the
device while the reset is in progress.

To avoid these problems, the driver handles unexpected resets as follows:
1. Set the reset_active flag. This flag blocks new device files from being
   opened and is used as a wakeup condition in the driver's wait queues.
2. If this is a PF FLR and there are active VFs, send them a pre-reset
   notification, so they can stop any VF applications. (Added in a later
   commit.)
3. Disable all device files (set the per-file valid flag to false, which
   prevents the file from being used after FLR completes) and wake any
   threads blocked on a wait queue.
4. If the device is not in use -- i.e. no open device files or memory
   mappings, and no VFs in use (PF FLR only) -- the FLR can begin.
5. Else, the driver waits (up to a user-specified timeout, default 5s) for
   software to stop using the driver and the device. If the timeout
   elapses, the driver zaps any remaining MMIO mappings so the
   extant applications can no longer use the device.
6. Do not unlock the resource mutex at the end of the reset prepare
   function, to prevent device access during the reset.

The reset timeout is exposed as a module parameter.

After the FLR:
1. Clear the per-domain pointers (the memory is freed elsewhere).
2. Release any remaining allocated port or CQ memory, now that it's
   guaranteed the device is unconfigured and won't write to memory.
3. Reset software and hardware state.
4. Notify VFs that the FLR is complete. (Added in a later commit.)
5. Set reset_active to false.
6. Unlock the resource mutex.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-dlb2 |  22 ++
 drivers/misc/dlb2/dlb2_intr.c               |  13 +-
 drivers/misc/dlb2/dlb2_intr.h               |   1 +
 drivers/misc/dlb2/dlb2_ioctl.c              |  91 ++++++++
 drivers/misc/dlb2/dlb2_main.c               | 327 +++++++++++++++++++++++++++-
 drivers/misc/dlb2/dlb2_main.h               |   4 +
 drivers/misc/dlb2/dlb2_resource.c           |  17 ++
 drivers/misc/dlb2/dlb2_resource.h           |   9 +
 8 files changed, 475 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-dlb2

diff --git a/Documentation/ABI/testing/sysfs-driver-dlb2 b/Documentation/ABI/testing/sysfs-driver-dlb2
new file mode 100644
index 000000000000..38d0d3d92670
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-dlb2
@@ -0,0 +1,22 @@
+What:		/sys/bus/pci/drivers/dlb2/module/parameters/reset_timeout_s
+Date:		June 22, 2020
+KernelVersion:	5.9
+Contact:	gage.eads@intel.com
+Description:	Interface for setting the driver's reset timeout.
+		When a device reset (FLR) is issued, the driver waits for
+		user-space to stop using the device before allowing the FLR to
+		proceed, with a timeout. The device is considered in use if
+		there are any open domain device file descriptors or memory
+		mapped producer ports. (For PF device resets, this includes all
+		VF-owned domains and producer ports.)
+
+		The amount of time the driver waits for userspace to stop using
+		the device is controlled by the module parameter
+		reset_timeout_s, which is in units of seconds and defaults to
+		5. If reset_timeout_s seconds elapse and any user is still
+		using the device, the driver zaps those processes' memory
+		mappings and marks their device file descriptors as invalid.
+		This is necessary because user processes that do not relinquish
+		their device mappings can interfere with processes that use the
+		device after the reset completes. To ensure that user processes
+		have enough time to clean up, reset_timeout_s can be increased.
diff --git a/drivers/misc/dlb2/dlb2_intr.c b/drivers/misc/dlb2/dlb2_intr.c
index 88c936ab7c69..bcda045c6660 100644
--- a/drivers/misc/dlb2/dlb2_intr.c
+++ b/drivers/misc/dlb2/dlb2_intr.c
@@ -30,7 +30,10 @@ static inline bool wake_condition(struct dlb2_cq_intr *intr,
 				  struct dlb2_dev *dev,
 				  struct dlb2_domain *domain)
 {
-	return (READ_ONCE(intr->wake) || READ_ONCE(intr->disabled));
+	return (READ_ONCE(intr->wake) ||
+		READ_ONCE(dev->reset_active) ||
+		!READ_ONCE(domain->valid) ||
+		READ_ONCE(intr->disabled));
 }
 
 struct dlb2_dequeue_qe {
@@ -117,8 +120,12 @@ int dlb2_block_on_cq_interrupt(struct dlb2_dev *dev,
 	ret = wait_event_interruptible(intr->wq_head,
 				       wake_condition(intr, dev, dom));
 
-	if (ret == 0 && READ_ONCE(intr->disabled))
-		ret = -EACCES;
+	if (ret == 0) {
+		if (READ_ONCE(dev->reset_active) || !READ_ONCE(dom->valid))
+			ret = -EINTR;
+		else if (READ_ONCE(intr->disabled))
+			ret = -EACCES;
+	}
 
 	WRITE_ONCE(intr->wake, false);
 
diff --git a/drivers/misc/dlb2/dlb2_intr.h b/drivers/misc/dlb2/dlb2_intr.h
index 613179795d8f..250c391d729e 100644
--- a/drivers/misc/dlb2/dlb2_intr.h
+++ b/drivers/misc/dlb2/dlb2_intr.h
@@ -20,6 +20,7 @@ int dlb2_block_on_cq_interrupt(struct dlb2_dev *dev,
 enum dlb2_wake_reason {
 	WAKE_CQ_INTR,
 	WAKE_PORT_DISABLED,
+	WAKE_DEV_RESET
 };
 
 void dlb2_wake_thread(struct dlb2_dev *dev,
diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index ce80cdd71af8..d0e87118bdc7 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -75,6 +75,14 @@ static int dlb2_domain_ioctl_##lower_name(struct dlb2_dev *dev,		   \
 									   \
 	mutex_lock(&dev->resource_mutex);				   \
 									   \
+	if (!domain->valid) {						   \
+		dev_err(dev->dlb2_device,				   \
+			"[%s()] Domain invalid (device reset)\n",	   \
+			__func__);					   \
+		mutex_unlock(&dev->resource_mutex);			   \
+		return -EINVAL;						   \
+	}								   \
+									   \
 	ret = dev->ops->lower_name(&dev->hw,				   \
 				   domain->id,				   \
 				   &arg,				   \
@@ -127,6 +135,14 @@ static int dlb2_domain_ioctl_enable_ldb_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->enable_ldb_port(&dev->hw, domain->id, &arg, &response);
 
 	/* Allow threads to block on this port's CQ interrupt */
@@ -167,6 +183,14 @@ static int dlb2_domain_ioctl_enable_dir_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->enable_dir_port(&dev->hw, domain->id, &arg, &response);
 
 	/* Allow threads to block on this port's CQ interrupt */
@@ -207,6 +231,14 @@ static int dlb2_domain_ioctl_disable_ldb_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->disable_ldb_port(&dev->hw, domain->id, &arg, &response);
 
 	/*
@@ -252,6 +284,14 @@ static int dlb2_domain_ioctl_disable_dir_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->disable_dir_port(&dev->hw, domain->id, &arg, &response);
 
 	/*
@@ -303,6 +343,14 @@ static int dlb2_domain_ioctl_create_ldb_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	cq_base = dma_alloc_coherent(&dev->pdev->dev,
 				     DLB2_CQ_SIZE,
 				     &cq_dma_base,
@@ -388,6 +436,14 @@ static int dlb2_domain_ioctl_create_dir_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	cq_base = dma_alloc_coherent(&dev->pdev->dev,
 				     DLB2_CQ_SIZE,
 				     &cq_dma_base,
@@ -469,6 +525,17 @@ static int dlb2_domain_ioctl_block_on_cq_interrupt(struct dlb2_dev *dev,
 	if (ret)
 		return ret;
 
+	/*
+	 * Note: dlb2_block_on_cq_interrupt() checks domain->valid again when
+	 * it puts the thread on the waitqueue
+	 */
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		return -EINVAL;
+	}
+
 	ret = dlb2_block_on_cq_interrupt(dev,
 					 domain,
 					 arg.port_id,
@@ -567,6 +634,14 @@ static int dlb2_domain_get_port_fd(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		dev_err(dev->dlb2_device,
+			"[%s()] Domain invalid (device reset)\n",
+			__func__);
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	if ((is_ldb &&
 	     dev->ops->ldb_port_owned_by_domain(&dev->hw,
 						domain->id,
@@ -804,6 +879,14 @@ static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (dev->reset_active) {
+		dev_err(dev->dlb2_device,
+			"[%s()] The DLB is being reset; applications cannot use it during this time.\n",
+			__func__);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	if (dev->domain_reset_failed) {
 		response.status = DLB2_ST_DOMAIN_RESET_FAILED;
 		ret = -EINVAL;
@@ -886,6 +969,14 @@ static int dlb2_ioctl_get_sched_domain_fd(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (dev->reset_active) {
+		dev_err(dev->dlb2_device,
+			"[%s()] The DLB is being reset; applications cannot use it during this time.\n",
+			__func__);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	domain = dev->sched_domains[arg.domain_id];
 
 	if (!domain) {
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index ef964cb044f8..ade71ed2e66b 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 
 #include "dlb2_file.h"
+#include "dlb2_intr.h"
 #include "dlb2_ioctl.h"
 #include "dlb2_main.h"
 #include "dlb2_resource.h"
@@ -32,6 +33,11 @@ MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
 MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer 2.0 Driver");
 MODULE_VERSION(DRV_VERSION);
 
+static unsigned int dlb2_reset_timeout_s = DLB2_DEFAULT_RESET_TIMEOUT_S;
+module_param_named(reset_timeout_s, dlb2_reset_timeout_s, uint, 0644);
+MODULE_PARM_DESC(reset_timeout_s,
+		 "Wait time (in seconds) after reset is requested given for app shutdown until driver zaps VMAs");
+
 /* The driver lock protects data structures that used by multiple devices. */
 static DEFINE_MUTEX(dlb2_driver_lock);
 static struct list_head dlb2_dev_list = LIST_HEAD_INIT(dlb2_dev_list);
@@ -68,6 +74,14 @@ static int dlb2_open(struct inode *i, struct file *f)
 
 	dev_dbg(dev->dlb2_device, "Opening DLB device file\n");
 
+	/* See dlb2_reset_prepare() for more details */
+	if (dev->reset_active) {
+		dev_err(dev->dlb2_device,
+			"[%s()] The DLB is being reset; applications cannot use it during this time.\n",
+			__func__);
+		return -EINVAL;
+	}
+
 	f->private_data = dev;
 
 	dev->ops->inc_pm_refcnt(dev->pdev, true);
@@ -126,6 +140,7 @@ int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id)
 
 	domain->id = domain_id;
 
+	domain->valid = true;
 	kref_init(&domain->refcnt);
 	domain->dlb2_dev = dlb2_dev;
 
@@ -210,6 +225,22 @@ static int __dlb2_free_domain(struct dlb2_dev *dev, struct dlb2_domain *domain)
 {
 	int i, ret = 0;
 
+	/*
+	 * Check if the domain was reset and its memory released during FLR
+	 * handling.
+	 */
+	if (!domain->valid) {
+		/*
+		 * Before clearing the sched_domains[] pointer, confirm the
+		 * slot isn't in use by a newer (valid) domain.
+		 */
+		if (dev->sched_domains[domain->id] == domain)
+			dev->sched_domains[domain->id] = NULL;
+
+		devm_kfree(dev->dlb2_device, domain);
+		return 0;
+	}
+
 	ret = dev->ops->reset_domain(&dev->hw, domain->id);
 
 	/* Unpin and free all memory pages associated with the domain */
@@ -270,7 +301,7 @@ int dlb2_write_domain_alert(struct dlb2_dev *dev,
 	struct dlb2_domain_alert alert;
 	int idx;
 
-	if (!domain) {
+	if (!domain || !domain->valid) {
 		dev_err(dev->dlb2_device,
 			"[%s()] Domain invalid (device reset)\n",
 			__func__);
@@ -342,9 +373,16 @@ static int dlb2_read_domain_alert(struct dlb2_dev *dev,
 			current->pid, domain->id);
 
 		if (wait_event_interruptible(domain->wq_head,
-					     dlb2_alerts_avail(domain)))
+					     dlb2_alerts_avail(domain) ||
+					     !READ_ONCE(domain->valid)))
 			return -ERESTARTSYS;
 
+		/* See dlb2_reset_prepare() for more details */
+		if (!READ_ONCE(domain->valid)) {
+			alert->alert_id = DLB2_DOMAIN_ALERT_DEVICE_RESET;
+			return 0;
+		}
+
 		spin_lock(&domain->alert_lock);
 	}
 
@@ -373,6 +411,11 @@ static ssize_t dlb2_domain_read(struct file *f,
 	if (len != sizeof(alert))
 		return -EINVAL;
 
+	if (!domain->valid) {
+		alert.alert_id = DLB2_DOMAIN_ALERT_DEVICE_RESET;
+		goto copy;
+	}
+
 	/* See dlb2_user.h for details on domain alert notifications */
 
 	ret = dlb2_read_domain_alert(dev,
@@ -382,6 +425,7 @@ static ssize_t dlb2_domain_read(struct file *f,
 	if (ret)
 		return ret;
 
+copy:
 	if (copy_to_user(buf, &alert, sizeof(alert)))
 		return -EFAULT;
 
@@ -429,6 +473,11 @@ static int dlb2_pp_mmap(struct file *f, struct vm_area_struct *vma)
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	if ((vma->vm_end - vma->vm_start) != DLB2_PP_SIZE) {
 		ret = -EINVAL;
 		goto end;
@@ -468,6 +517,11 @@ static int dlb2_cq_mmap(struct file *f, struct vm_area_struct *vma)
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	if ((vma->vm_end - vma->vm_start) != DLB2_CQ_SIZE) {
 		ret = -EINVAL;
 		goto end;
@@ -724,10 +778,10 @@ static void dlb2_remove(struct pci_dev *pdev)
 	devm_kfree(&pdev->dev, dlb2_dev);
 }
 
-#ifdef CONFIG_PM
-static void dlb2_reset_hardware_state(struct dlb2_dev *dev)
+static void dlb2_reset_hardware_state(struct dlb2_dev *dev, bool issue_flr)
 {
-	dlb2_reset_device(dev->pdev);
+	if (issue_flr)
+		dlb2_reset_device(dev->pdev);
 
 	/* Reinitialize interrupt configuration */
 	dev->ops->reinit_interrupts(dev);
@@ -736,6 +790,7 @@ static void dlb2_reset_hardware_state(struct dlb2_dev *dev)
 	dev->ops->init_hardware(dev);
 }
 
+#ifdef CONFIG_PM
 static int dlb2_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
@@ -766,7 +821,7 @@ static int dlb2_runtime_resume(struct device *dev)
 	dev_dbg(dlb2_dev->dlb2_device, "Resuming device operation\n");
 
 	/* Now reinitialize the device state. */
-	dlb2_reset_hardware_state(dlb2_dev);
+	dlb2_reset_hardware_state(dlb2_dev, true);
 
 	return 0;
 }
@@ -778,6 +833,265 @@ static struct pci_device_id dlb2_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, dlb2_id_table);
 
+static unsigned int dlb2_total_device_file_refcnt(struct dlb2_dev *dev)
+{
+	unsigned int cnt = 0;
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++)
+		if (dev->sched_domains[i])
+			cnt += kref_read(&dev->sched_domains[i]->refcnt);
+
+	return cnt;
+}
+
+static bool dlb2_in_use(struct dlb2_dev *dev)
+{
+	return dlb2_total_device_file_refcnt(dev) != 0;
+}
+
+static void dlb2_wait_for_idle(struct dlb2_dev *dlb2_dev)
+{
+	int i;
+
+	for (i = 0; i < dlb2_reset_timeout_s * 10; i++) {
+		bool idle;
+
+		mutex_lock(&dlb2_dev->resource_mutex);
+
+		/*
+		 * Check for any application threads in the driver, extant
+		 * mmaps, or open device files.
+		 */
+		idle = !dlb2_in_use(dlb2_dev);
+
+		mutex_unlock(&dlb2_dev->resource_mutex);
+
+		if (idle)
+			return;
+
+		cond_resched();
+		msleep(100);
+	}
+
+	dev_err(dlb2_dev->dlb2_device,
+		"PF driver timed out waiting for applications to idle\n");
+}
+
+static void dlb2_unmap_all_mappings(struct dlb2_dev *dlb2_dev)
+{
+	dev_dbg(dlb2_dev->dlb2_device, "Zapping memory mappings\n");
+
+	if (dlb2_dev->inode)
+		unmap_mapping_range(dlb2_dev->inode->i_mapping, 0, 0, 1);
+}
+
+static void dlb2_disable_domain_files(struct dlb2_dev *dlb2_dev)
+{
+	int i;
+
+	/*
+	 * Set all domain->valid flags to false to prevent existing device
+	 * files from being used to enter the device driver.
+	 */
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++) {
+		if (dlb2_dev->sched_domains[i])
+			dlb2_dev->sched_domains[i]->valid = false;
+	}
+}
+
+static void dlb2_wake_threads(struct dlb2_dev *dlb2_dev)
+{
+	int i;
+
+	/*
+	 * Wake any blocked device file readers. These threads will return the
+	 * DLB2_DOMAIN_ALERT_DEVICE_RESET alert, and well-behaved applications
+	 * will close their fds and unmap DLB memory as a result.
+	 */
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++) {
+		if (!dlb2_dev->sched_domains[i])
+			continue;
+
+		wake_up_interruptible(&dlb2_dev->sched_domains[i]->wq_head);
+	}
+
+	/* Wake threads blocked on a CQ interrupt */
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++)
+		dlb2_wake_thread(dlb2_dev,
+				 &dlb2_dev->intr.ldb_cq_intr[i],
+				 WAKE_DEV_RESET);
+
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++)
+		dlb2_wake_thread(dlb2_dev,
+				 &dlb2_dev->intr.dir_cq_intr[i],
+				 WAKE_DEV_RESET);
+}
+
+static void dlb2_stop_users(struct dlb2_dev *dlb2_dev)
+{
+	/*
+	 * Disable existing domain files to prevent applications from enter the
+	 * device driver through file operations. (New files can't be opened
+	 * while the resource mutex is held.)
+	 */
+	dlb2_disable_domain_files(dlb2_dev);
+
+	/* Wake any threads blocked in the kernel */
+	dlb2_wake_threads(dlb2_dev);
+}
+
+static void dlb2_reset_prepare(struct pci_dev *pdev)
+{
+	/*
+	 * Unexpected FLR. Applications may be actively using the device at
+	 * the same time, which poses two problems:
+	 * - If applications continue to enqueue to the hardware they will
+	 *   cause hardware errors, because the FLR will have reset the
+	 *   scheduling domains, ports, and queues.
+	 * - When the applications end, they must not trigger the driver's
+	 *   domain reset code. The domain reset procedure would fail because
+	 *   the device's registers will have been reset by the FLR.
+	 *
+	 * To avoid these problems, the driver handles unexpected resets as
+	 * follows:
+	 * 1. Set the reset_active flag. This flag blocks new device files
+	 *    from being opened and is used as a wakeup condition in the
+	 *    driver's wait queues.
+	 * 2. If this is a PF FLR and there are active VFs, send them a
+	 *    pre-reset notification, so they can stop any VF applications.
+	 * 3. Disable all device files (set the per-file valid flag to false,
+	 *    which prevents the file from being used after FLR completes) and
+	 *    wake any threads on a wait queue.
+	 * 4. If the DLB is not in use -- i.e. no open device files or memory
+	 *    mappings, and no VFs in use (PF FLR only) -- the FLR can begin.
+	 * 5. Else, the driver waits (up to a user-specified timeout, default
+	 *    5s) for software to stop using the driver and the device. If the
+	 *    timeout elapses, the driver zaps any remaining MMIO mappings.
+	 *
+	 * After the FLR:
+	 * 1. Clear the per-domain pointers (the memory is freed in either
+	 *    dlb2_close or dlb2_stop_users).
+	 * 2. Release any remaining allocated port or CQ memory, now that it's
+	 *    guaranteed the device is unconfigured and won't write to memory.
+	 * 3. Reset software and hardware state
+	 * 4. Notify VFs that the FLR is complete.
+	 * 5. Set reset_active to false.
+	 */
+
+	struct dlb2_dev *dlb2_dev;
+
+	dlb2_dev = pci_get_drvdata(pdev);
+
+	dev_dbg(dlb2_dev->dlb2_device, "DLB driver reset prepare\n");
+
+	mutex_lock(&dlb2_dev->resource_mutex);
+
+	/* Block any new device files from being opened */
+	dlb2_dev->reset_active = true;
+
+	/*
+	 * If the device has 1+ VFs, even if they're not in use, it will not be
+	 * suspended. To avoid having to handle two cases (reset while device
+	 * suspended and reset while device active), increment the device's PM
+	 * refcnt here, to guarantee that the device is in D0 for the duration
+	 * of the reset.
+	 */
+	dlb2_dev->ops->inc_pm_refcnt(dlb2_dev->pdev, true);
+
+	/*
+	 * Stop existing applications from continuing to use the device by
+	 * blocking kernel driver interfaces and waking any threads on wait
+	 * queues, but don't zap VMA entries yet. If this is a PF FLR, notify
+	 * any VFs of the impending FLR so they can stop their users as well.
+	 */
+	dlb2_stop_users(dlb2_dev);
+
+	/* If no software is using the device, there's nothing to clean up. */
+	if (!dlb2_in_use(dlb2_dev))
+		return;
+
+	dev_dbg(dlb2_dev->dlb2_device, "Waiting for users to stop\n");
+
+	/*
+	 * Release the resource mutex so threads can complete their work and
+	 * exit the driver
+	 */
+	mutex_unlock(&dlb2_dev->resource_mutex);
+
+	/*
+	 * Wait until the device is idle or dlb2_reset_timeout_s seconds
+	 * elapse. If the timeout occurs, zap any remaining VMA entries to
+	 * guarantee applications can't reach the device.
+	 */
+	dlb2_wait_for_idle(dlb2_dev);
+
+	mutex_lock(&dlb2_dev->resource_mutex);
+
+	if (!dlb2_in_use(dlb2_dev))
+		return;
+
+	dlb2_unmap_all_mappings(dlb2_dev);
+
+	/*
+	 * Don't release resource_mutex until after the FLR occurs. This
+	 * prevents applications from accessing the device during reset.
+	 */
+}
+
+static void dlb2_reset_done(struct pci_dev *pdev)
+{
+	struct dlb2_dev *dlb2_dev;
+	int i;
+
+	dlb2_dev = pci_get_drvdata(pdev);
+
+	/*
+	 * Clear all domain pointers, to be filled in by post-FLR applications
+	 * using the device driver.
+	 *
+	 * Note that domain memory isn't leaked -- it is either freed during
+	 * dlb2_stop_users() or in the file close callback.
+	 */
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++)
+		dlb2_dev->sched_domains[i] = NULL;
+
+	/*
+	 * Free allocated CQ memory. These are no longer accessible to
+	 * user-space: either the applications closed, or their mappings were
+	 * zapped in dlb2_reset_prepare().
+	 */
+	dlb2_release_device_memory(dlb2_dev);
+
+	/* Reset interrupt state */
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++)
+		dlb2_dev->intr.ldb_cq_intr[i].configured = false;
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++)
+		dlb2_dev->intr.dir_cq_intr[i].configured = false;
+
+	/* Reset resource allocation state */
+	dlb2_resource_reset(&dlb2_dev->hw);
+
+	/* Reset the hardware state, but don't issue an additional FLR */
+	dlb2_reset_hardware_state(dlb2_dev, false);
+
+	dev_dbg(dlb2_dev->dlb2_device, "DLB driver reset done\n");
+
+	dlb2_dev->domain_reset_failed = false;
+
+	dlb2_dev->reset_active = false;
+
+	/* Undo the PM refcnt increment in dlb2_reset_prepare(). */
+	dlb2_dev->ops->dec_pm_refcnt(dlb2_dev->pdev);
+
+	mutex_unlock(&dlb2_dev->resource_mutex);
+}
+
+static const struct pci_error_handlers dlb2_err_handler = {
+	.reset_prepare = dlb2_reset_prepare,
+	.reset_done    = dlb2_reset_done,
+};
+
 #ifdef CONFIG_PM
 static const struct dev_pm_ops dlb2_pm_ops = {
 	SET_RUNTIME_PM_OPS(dlb2_runtime_suspend, dlb2_runtime_resume, NULL)
@@ -792,6 +1106,7 @@ static struct pci_driver dlb2_pci_driver = {
 #ifdef CONFIG_PM
 	.driver.pm	 = &dlb2_pm_ops,
 #endif
+	.err_handler     = &dlb2_err_handler,
 };
 
 static int __init dlb2_init_module(void)
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 4b7a430ffd86..e804639af0f8 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -31,6 +31,8 @@ static const char dlb2_driver_name[] = KBUILD_MODNAME;
 #define DLB2_NUM_FUNCS_PER_DEVICE (1 + DLB2_MAX_NUM_VDEVS)
 #define DLB2_MAX_NUM_DEVICES (DLB2_MAX_NUM_PFS * DLB2_NUM_FUNCS_PER_DEVICE)
 
+#define DLB2_DEFAULT_RESET_TIMEOUT_S 5
+
 enum dlb2_device_type {
 	DLB2_PF,
 	DLB2_VF,
@@ -182,6 +184,7 @@ struct dlb2_domain {
 	u8 alert_rd_idx;
 	u8 alert_wr_idx;
 	u8 id;
+	u8 valid;
 };
 
 struct dlb2_cq_intr {
@@ -237,6 +240,7 @@ struct dlb2_dev {
 	int id;
 	dev_t dev_number;
 	u8 domain_reset_failed;
+	u8 reset_active;
 	u8 worker_launched;
 };
 
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 2c04c5164223..023409022f39 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -24,6 +24,9 @@
 #define DLB2_DOM_LIST_FOR_SAFE(head, ptr, ptr_tmp) \
 	list_for_each_entry_safe(ptr, ptr_tmp, &(head), domain_list)
 
+#define DLB2_FUNC_LIST_FOR_SAFE(head, ptr, ptr_tmp) \
+	list_for_each_entry_safe(ptr, ptr_tmp, &(head), func_list)
+
 /*
  * The PF driver cannot assume that a register write will affect subsequent HCW
  * writes. To ensure a write completes, the driver must read back a CSR. This
@@ -5327,6 +5330,20 @@ static int dlb2_domain_reset_software_state(struct dlb2_hw *hw,
 	return 0;
 }
 
+void dlb2_resource_reset(struct dlb2_hw *hw)
+{
+	struct dlb2_hw_domain *domain, *next __attribute__((unused));
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_VDEVS; i++) {
+		DLB2_FUNC_LIST_FOR_SAFE(hw->vdev[i].used_domains, domain, next)
+			dlb2_domain_reset_software_state(hw, domain);
+	}
+
+	DLB2_FUNC_LIST_FOR_SAFE(hw->pf.used_domains, domain, next)
+		dlb2_domain_reset_software_state(hw, domain);
+}
+
 static u32 dlb2_dir_queue_depth(struct dlb2_hw *hw,
 				struct dlb2_dir_pq_pair *queue)
 {
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index 430175efcd71..7570e02d37e5 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -37,6 +37,15 @@ int dlb2_resource_init(struct dlb2_hw *hw);
 void dlb2_resource_free(struct dlb2_hw *hw);
 
 /**
+ * dlb2_resource_reset() - reset in-use resources to their initial state
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function resets in-use resources, and makes them available for use.
+ * All resources go back to their owning function, whether a PF or a VF.
+ */
+void dlb2_resource_reset(struct dlb2_hw *hw);
+
+/**
  * dlb2_hw_create_sched_domain() - create a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @args: scheduling domain creation arguments.
-- 
2.13.6

