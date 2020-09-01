Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F7C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE82120767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbgIATWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:53437 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIATWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:22:01 -0400
IronPort-SDR: HR2Tqe2ZduQSizjywjk5+bhUqZ7QMNDCiGCZPI8XL/J3QBalRmHPHLvFvY7AH4UZwzb8ZNyhh3
 WvJFrjXPL2Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807351"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:35 -0700
IronPort-SDR: RlezRxlpak+bYZNTxGqFCRE8CJjpp2KukjFIDCkwDW1z263bXb6urHhT48spRGjzebywujHfeO
 BNg1X2m4yqng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480516"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:35 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 17/19] dlb2: add device FLR support
Date:   Tue,  1 Sep 2020 14:15:46 -0500
Message-Id: <20200901191548.31646-18-gage.eads@intel.com>
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
 drivers/misc/dlb2/dlb2_ioctl.c              |  54 ++++-
 drivers/misc/dlb2/dlb2_main.c               | 315 +++++++++++++++++++++++++++-
 drivers/misc/dlb2/dlb2_main.h               |   4 +
 drivers/misc/dlb2/dlb2_resource.c           |  17 ++
 drivers/misc/dlb2/dlb2_resource.h           |   9 +
 8 files changed, 424 insertions(+), 11 deletions(-)
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
index 0e20197e96fb..ace7df36294e 100644
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
@@ -114,8 +117,12 @@ int dlb2_block_on_cq_interrupt(struct dlb2_dev *dev,
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
index 3e4fb19dd726..3589acceedf8 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -31,6 +31,11 @@ static int dlb2_domain_ioctl_##lower_name(struct dlb2_dev *dev,		   \
 									   \
 	mutex_lock(&dev->resource_mutex);				   \
 									   \
+	if (!domain->valid) {						   \
+		mutex_unlock(&dev->resource_mutex);			   \
+		return -EINVAL;						   \
+	}								   \
+									   \
 	ret = dev->ops->lower_name(&dev->hw,				   \
 				   domain->id,				   \
 				   &arg,				   \
@@ -74,6 +79,11 @@ static int dlb2_domain_ioctl_enable_ldb_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->enable_ldb_port(&dev->hw, domain->id, &arg, &response);
 
 	/* Allow threads to block on this port's CQ interrupt */
@@ -103,6 +113,11 @@ static int dlb2_domain_ioctl_enable_dir_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->enable_dir_port(&dev->hw, domain->id, &arg, &response);
 
 	/* Allow threads to block on this port's CQ interrupt */
@@ -132,6 +147,11 @@ static int dlb2_domain_ioctl_disable_ldb_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->disable_ldb_port(&dev->hw, domain->id, &arg, &response);
 
 	/*
@@ -166,6 +186,11 @@ static int dlb2_domain_ioctl_disable_dir_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	ret = dev->ops->disable_dir_port(&dev->hw, domain->id, &arg, &response);
 
 	/*
@@ -206,6 +231,11 @@ static int dlb2_domain_ioctl_create_ldb_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	cq_base = dma_alloc_coherent(&dev->pdev->dev,
 				     DLB2_CQ_SIZE,
 				     &cq_dma_base,
@@ -271,6 +301,11 @@ static int dlb2_domain_ioctl_create_dir_port(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	cq_base = dma_alloc_coherent(&dev->pdev->dev,
 				     DLB2_CQ_SIZE,
 				     &cq_dma_base,
@@ -332,6 +367,13 @@ static int dlb2_domain_ioctl_block_on_cq_interrupt(struct dlb2_dev *dev,
 	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
 		return -EFAULT;
 
+	/*
+	 * Note: dlb2_block_on_cq_interrupt() checks domain->valid again when
+	 * it puts the thread on the waitqueue
+	 */
+	if (!domain->valid)
+		return -EINVAL;
+
 	ret = dlb2_block_on_cq_interrupt(dev,
 					 domain,
 					 arg.port_id,
@@ -401,6 +443,11 @@ static int dlb2_domain_get_port_fd(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		mutex_unlock(&dev->resource_mutex);
+		return -EINVAL;
+	}
+
 	if ((is_ldb &&
 	     dev->ops->ldb_port_owned_by_domain(&dev->hw,
 						domain->id,
@@ -590,6 +637,11 @@ static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (dev->reset_active) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	if (dev->domain_reset_failed) {
 		response.status = DLB2_ST_DOMAIN_RESET_FAILED;
 		ret = -EINVAL;
@@ -612,8 +664,6 @@ static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
 			      domain, O_RDWR);
 
 	if (fd < 0) {
-		dev_err(dev->dlb2_device,
-			"[%s()] Failed to get anon fd.\n", __func__);
 		kref_put(&domain->refcnt, dlb2_free_domain);
 		ret = fd;
 		goto unlock;
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index b457bda7be44..bc065788061a 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 
 #include "dlb2_file.h"
+#include "dlb2_intr.h"
 #include "dlb2_ioctl.h"
 #include "dlb2_main.h"
 #include "dlb2_resource.h"
@@ -26,6 +27,11 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
 MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer 2.0 Driver");
 
+static unsigned int dlb2_reset_timeout_s = DLB2_DEFAULT_RESET_TIMEOUT_S;
+module_param_named(reset_timeout_s, dlb2_reset_timeout_s, uint, 0644);
+MODULE_PARM_DESC(reset_timeout_s,
+		 "Wait time (in seconds) after reset is requested given for app shutdown until driver zaps VMAs");
+
 /* The driver lock protects data structures that used by multiple devices. */
 static DEFINE_MUTEX(dlb2_driver_lock);
 static struct list_head dlb2_dev_list = LIST_HEAD_INIT(dlb2_dev_list);
@@ -60,6 +66,10 @@ static int dlb2_open(struct inode *i, struct file *f)
 
 	dev = container_of(f->f_inode->i_cdev, struct dlb2_dev, cdev);
 
+	/* See dlb2_reset_prepare() for more details */
+	if (dev->reset_active)
+		return -EINVAL;
+
 	f->private_data = dev;
 
 	dev->ops->inc_pm_refcnt(dev->pdev, true);
@@ -98,6 +108,7 @@ int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id)
 
 	domain->id = domain_id;
 
+	domain->valid = true;
 	kref_init(&domain->refcnt);
 	domain->dlb2_dev = dlb2_dev;
 
@@ -179,6 +190,22 @@ static int __dlb2_free_domain(struct dlb2_dev *dev, struct dlb2_domain *domain)
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
@@ -238,7 +265,7 @@ int dlb2_write_domain_alert(struct dlb2_dev *dev,
 	struct dlb2_domain_alert alert;
 	int idx;
 
-	if (!domain)
+	if (!domain || !domain->valid)
 		return -EINVAL;
 
 	/* Grab the alert lock to access the read and write indexes */
@@ -306,9 +333,16 @@ static int dlb2_read_domain_alert(struct dlb2_dev *dev,
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
 
@@ -337,6 +371,11 @@ static ssize_t dlb2_domain_read(struct file *f,
 	if (len != sizeof(alert))
 		return -EINVAL;
 
+	if (!domain->valid) {
+		alert.alert_id = DLB2_DOMAIN_ALERT_DEVICE_RESET;
+		goto copy;
+	}
+
 	/* See dlb2_user.h for details on domain alert notifications */
 
 	ret = dlb2_read_domain_alert(dev,
@@ -346,6 +385,7 @@ static ssize_t dlb2_domain_read(struct file *f,
 	if (ret)
 		return ret;
 
+copy:
 	if (copy_to_user(buf, &alert, sizeof(alert)))
 		return -EFAULT;
 
@@ -375,6 +415,11 @@ static int dlb2_pp_mmap(struct file *f, struct vm_area_struct *vma)
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	if ((vma->vm_end - vma->vm_start) != DLB2_PP_SIZE) {
 		ret = -EINVAL;
 		goto end;
@@ -411,6 +456,11 @@ static int dlb2_cq_mmap(struct file *f, struct vm_area_struct *vma)
 
 	mutex_lock(&dev->resource_mutex);
 
+	if (!domain->valid) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	if ((vma->vm_end - vma->vm_start) != DLB2_CQ_SIZE) {
 		ret = -EINVAL;
 		goto end;
@@ -661,10 +711,10 @@ static void dlb2_remove(struct pci_dev *pdev)
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
@@ -673,6 +723,7 @@ static void dlb2_reset_hardware_state(struct dlb2_dev *dev)
 	dev->ops->init_hardware(dev);
 }
 
+#ifdef CONFIG_PM
 static int dlb2_runtime_suspend(struct device *dev)
 {
 	/* Return and let the PCI subsystem put the device in D3hot. */
@@ -696,7 +747,7 @@ static int dlb2_runtime_resume(struct device *dev)
 		return ret;
 
 	/* Now reinitialize the device state. */
-	dlb2_reset_hardware_state(dlb2_dev);
+	dlb2_reset_hardware_state(dlb2_dev, true);
 
 	return 0;
 }
@@ -708,6 +759,257 @@ static struct pci_device_id dlb2_id_table[] = {
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
@@ -722,6 +1024,7 @@ static struct pci_driver dlb2_pci_driver = {
 #ifdef CONFIG_PM
 	.driver.pm	 = &dlb2_pm_ops,
 #endif
+	.err_handler     = &dlb2_err_handler,
 };
 
 static int __init dlb2_init_module(void)
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index e3d7c9362257..45050403a4be 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -31,6 +31,8 @@ static const char dlb2_driver_name[] = KBUILD_MODNAME;
 #define DLB2_NUM_FUNCS_PER_DEVICE (1 + DLB2_MAX_NUM_VDEVS)
 #define DLB2_MAX_NUM_DEVICES	  (DLB2_MAX_NUM_PFS * DLB2_NUM_FUNCS_PER_DEVICE)
 
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
index f2f650bc979e..4d751a0ce1db 100644
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
index e325c584cb3f..258ec1c11032 100644
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

