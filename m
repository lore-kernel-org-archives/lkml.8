Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09818204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgHYCvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:37759 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbgHYCvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:51:40 -0400
IronPort-SDR: odmRqMbhhCaec7sSosNRb6kTB4AUWDMPl/gNzYq3CnVILsH/gKPddfni2NwfuLQsoe6/Jy7qH2
 J2rQ1pcdkhDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690854"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:51:32 -0700
IronPort-SDR: omcVUJIA1yEwSpaoXxpqus1mBoiU8+N2mMKBwzq9KgQY3hYB9bP6p4RdD+N1aB37GXzE9JjjxW
 tfmkgI5/WbPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409893"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:51:29 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 16/17] virt: acrn: Introduce irqfd
Date:   Tue, 25 Aug 2020 10:45:16 +0800
Message-Id: <20200825024516.16766-17-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825024516.16766-1-shuo.a.liu@intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

irqfd is a mechanism to inject a specific interrupt to a User VM using a
decoupled eventfd mechanism.

Vhost is a kernel-level virtio server which uses eventfd for interrupt
injection. To support vhost on ACRN, irqfd is introduced in HSM.

HSM provides ioctls to associate a virtual Message Signaled Interrupt
(MSI) with an eventfd. The corresponding virtual MSI will be injected
into a User VM once the eventfd got signal.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/virt/acrn/Makefile   |   2 +-
 drivers/virt/acrn/acrn_drv.h |  10 ++
 drivers/virt/acrn/hsm.c      |   7 ++
 drivers/virt/acrn/irqfd.c    | 236 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c       |   3 +
 include/uapi/linux/acrn.h    |  15 +++
 6 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/acrn/irqfd.c

diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
index 755b583b32ca..08ce641dcfa1 100644
--- a/drivers/virt/acrn/Makefile
+++ b/drivers/virt/acrn/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
-acrn-y := hsm.o vm.o mm.o ioreq.o ioeventfd.o
+acrn-y := hsm.o vm.o mm.o ioreq.o ioeventfd.o irqfd.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index e36e8c94139b..5d8f151cf9ba 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -157,6 +157,9 @@ extern rwlock_t acrn_vm_list_lock;
  * @ioeventfds_lock:		Lock to protect ioeventfds list
  * @ioeventfds:			List to link all hsm_ioeventfd
  * @ioeventfd_client:		I/O client for ioeventfds of the VM
+ * @irqfds_lock:		Lock to protect irqfds list
+ * @irqfds:			List to link all hsm_irqfd
+ * @irqfd_wq:			Workqueue for irqfd async shutdown
  */
 struct acrn_vm {
 	struct list_head		list;
@@ -176,6 +179,9 @@ struct acrn_vm {
 	struct mutex			ioeventfds_lock;
 	struct list_head		ioeventfds;
 	struct acrn_ioreq_client	*ioeventfd_client;
+	struct mutex			irqfds_lock;
+	struct list_head		irqfds;
+	struct workqueue_struct		*irqfd_wq;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
@@ -212,4 +218,8 @@ int acrn_ioeventfd_init(struct acrn_vm *vm);
 int acrn_ioeventfd_config(struct acrn_vm *vm, struct acrn_ioeventfd *args);
 void acrn_ioeventfd_deinit(struct acrn_vm *vm);
 
+int acrn_irqfd_init(struct acrn_vm *vm);
+int acrn_irqfd_config(struct acrn_vm *vm, struct acrn_irqfd *args);
+void acrn_irqfd_deinit(struct acrn_vm *vm);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 9f990929242c..81300ea19dc9 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -116,6 +116,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vm_memmap memmap;
 	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
+	struct acrn_irqfd irqfd;
 	struct page *page;
 	u64 cstate_cmd;
 	int ret = 0;
@@ -311,6 +312,12 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 
 		ret = acrn_ioeventfd_config(vm, &ioeventfd);
 		break;
+	case ACRN_IOCTL_IRQFD:
+		if (copy_from_user(&irqfd, (void __user *)ioctl_param,
+				   sizeof(irqfd)))
+			return -EFAULT;
+		ret = acrn_irqfd_config(vm, &irqfd);
+		break;
 	default:
 		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
 		ret = -EINVAL;
diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
new file mode 100644
index 000000000000..67380c79f167
--- /dev/null
+++ b/drivers/virt/acrn/irqfd.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN HSM irqfd: use eventfd objects to inject virtual interrupts
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Shuo Liu <shuo.a.liu@intel.com>
+ *	Yakui Zhao <yakui.zhao@intel.com>
+ */
+#define pr_fmt(fmt) "acrn: " fmt
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+
+#include "acrn_drv.h"
+
+static LIST_HEAD(acrn_irqfd_clients);
+static DEFINE_MUTEX(acrn_irqfds_mutex);
+
+/**
+ * struct hsm_irqfd - Properties of HSM irqfd
+ * @vm:		Associated VM pointer
+ * @wait:	Entry of wait-queue
+ * @shutdown:	Async shutdown work
+ * @eventfd:	Associated eventfd
+ * @list:	Entry within &acrn_vm.irqfds of irqfds of a VM
+ * @pt:		Structure for select/poll on the associated eventfd
+ * @msi:	MSI data
+ */
+struct hsm_irqfd {
+	struct acrn_vm		*vm;
+	wait_queue_entry_t	wait;
+	struct work_struct	shutdown;
+	struct eventfd_ctx	*eventfd;
+	struct list_head	list;
+	poll_table		pt;
+	struct acrn_msi_entry	msi;
+};
+
+static void acrn_irqfd_inject(struct hsm_irqfd *irqfd)
+{
+	struct acrn_vm *vm = irqfd->vm;
+
+	acrn_msi_inject(vm->vmid, irqfd->msi.msi_addr,
+			irqfd->msi.msi_data);
+}
+
+static void hsm_irqfd_shutdown(struct hsm_irqfd *irqfd)
+{
+	u64 cnt;
+
+	lockdep_assert_held(&irqfd->vm->irqfds_lock);
+
+	/* remove from wait queue */
+	list_del_init(&irqfd->list);
+	eventfd_ctx_remove_wait_queue(irqfd->eventfd, &irqfd->wait, &cnt);
+	eventfd_ctx_put(irqfd->eventfd);
+	kfree(irqfd);
+}
+
+static void hsm_irqfd_shutdown_work(struct work_struct *work)
+{
+	struct hsm_irqfd *irqfd;
+	struct acrn_vm *vm;
+
+	irqfd = container_of(work, struct hsm_irqfd, shutdown);
+	vm = irqfd->vm;
+	mutex_lock(&vm->irqfds_lock);
+	if (!list_empty(&irqfd->list))
+		hsm_irqfd_shutdown(irqfd);
+	mutex_unlock(&vm->irqfds_lock);
+}
+
+/* Called with wqh->lock held and interrupts disabled */
+static int hsm_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
+			    int sync, void *key)
+{
+	unsigned long poll_bits = (unsigned long)key;
+	struct hsm_irqfd *irqfd;
+	struct acrn_vm *vm;
+
+	irqfd = container_of(wait, struct hsm_irqfd, wait);
+	vm = irqfd->vm;
+	if (poll_bits & POLLIN)
+		/* An event has been signaled, inject an interrupt */
+		acrn_irqfd_inject(irqfd);
+
+	if (poll_bits & POLLHUP)
+		/* Do shutdown work in thread to hold wqh->lock */
+		queue_work(vm->irqfd_wq, &irqfd->shutdown);
+
+	return 0;
+}
+
+static void hsm_irqfd_poll_func(struct file *file, wait_queue_head_t *wqh,
+				poll_table *pt)
+{
+	struct hsm_irqfd *irqfd;
+
+	irqfd = container_of(pt, struct hsm_irqfd, pt);
+	add_wait_queue(wqh, &irqfd->wait);
+}
+
+/*
+ * Assign an eventfd to a VM and create a HSM irqfd associated with the
+ * eventfd. The properties of the HSM irqfd are built from a &struct
+ * acrn_irqfd.
+ */
+static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
+{
+	struct eventfd_ctx *eventfd = NULL;
+	struct hsm_irqfd *irqfd, *tmp;
+	unsigned int events;
+	struct fd f;
+	int ret = 0;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->vm = vm;
+	memcpy(&irqfd->msi, &args->msi, sizeof(args->msi));
+	INIT_LIST_HEAD(&irqfd->list);
+	INIT_WORK(&irqfd->shutdown, hsm_irqfd_shutdown_work);
+
+	f = fdget(args->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->eventfd = eventfd;
+
+	/*
+	 * Install custom wake-up handling to be notified whenever underlying
+	 * eventfd is signaled.
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, hsm_irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, hsm_irqfd_poll_func);
+
+	mutex_lock(&vm->irqfds_lock);
+	list_for_each_entry(tmp, &vm->irqfds, list) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+		ret = -EBUSY;
+		mutex_unlock(&vm->irqfds_lock);
+		goto fail;
+	}
+	list_add_tail(&irqfd->list, &vm->irqfds);
+	mutex_unlock(&vm->irqfds_lock);
+
+	/* Check the pending event in this stage */
+	events = f.file->f_op->poll(f.file, &irqfd->pt);
+
+	if (events & POLLIN)
+		acrn_irqfd_inject(irqfd);
+
+	fdput(f);
+	return 0;
+fail:
+	if (eventfd && !IS_ERR(eventfd))
+		eventfd_ctx_put(eventfd);
+
+	fdput(f);
+out:
+	kfree(irqfd);
+	return ret;
+}
+
+static int acrn_irqfd_deassign(struct acrn_vm *vm,
+			       struct acrn_irqfd *args)
+{
+	struct hsm_irqfd *irqfd, *tmp;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	mutex_lock(&vm->irqfds_lock);
+	list_for_each_entry_safe(irqfd, tmp, &vm->irqfds, list) {
+		if (irqfd->eventfd == eventfd) {
+			hsm_irqfd_shutdown(irqfd);
+			break;
+		}
+	}
+	mutex_unlock(&vm->irqfds_lock);
+	eventfd_ctx_put(eventfd);
+
+	return 0;
+}
+
+int acrn_irqfd_config(struct acrn_vm *vm, struct acrn_irqfd *args)
+{
+	int ret;
+
+	if (args->flags & ACRN_IRQFD_FLAG_DEASSIGN)
+		ret = acrn_irqfd_deassign(vm, args);
+	else
+		ret = acrn_irqfd_assign(vm, args);
+
+	return ret;
+}
+
+int acrn_irqfd_init(struct acrn_vm *vm)
+{
+	INIT_LIST_HEAD(&vm->irqfds);
+	mutex_init(&vm->irqfds_lock);
+	vm->irqfd_wq = alloc_workqueue("acrn_irqfd-%u", 0, 0, vm->vmid);
+	if (!vm->irqfd_wq)
+		return -ENOMEM;
+
+	pr_debug("VM %u irqfd init.\n", vm->vmid);
+	return 0;
+}
+
+void acrn_irqfd_deinit(struct acrn_vm *vm)
+{
+	struct hsm_irqfd *irqfd, *next;
+
+	pr_debug("VM %u irqfd deinit.\n", vm->vmid);
+	destroy_workqueue(vm->irqfd_wq);
+	mutex_lock(&vm->irqfds_lock);
+	list_for_each_entry_safe(irqfd, next, &vm->irqfds, list)
+		hsm_irqfd_shutdown(irqfd);
+	mutex_unlock(&vm->irqfds_lock);
+}
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 1a9456794663..f2b80685d82e 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -47,6 +47,7 @@ struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
 	write_unlock_bh(&acrn_vm_list_lock);
 
 	acrn_ioeventfd_init(vm);
+	acrn_irqfd_init(vm);
 	pr_debug("VM %u created.\n", vm->vmid);
 	return vm;
 }
@@ -65,7 +66,9 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	write_unlock_bh(&acrn_vm_list_lock);
 
 	acrn_ioeventfd_deinit(vm);
+	acrn_irqfd_deinit(vm);
 	acrn_ioreq_deinit(vm);
+
 	if (vm->monitor_page) {
 		put_page(vm->monitor_page);
 		vm->monitor_page = NULL;
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index e2d5c657f8e2..322fbcdc25ac 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -421,6 +421,19 @@ struct acrn_ioeventfd {
 	__u64	data;
 };
 
+#define ACRN_IRQFD_FLAG_DEASSIGN	0x01
+/**
+ * struct acrn_irqfd - Data to operate a &struct hsm_irqfd
+ * @fd:		The fd of eventfd associated with a hsm_irqfd
+ * @flags:	Logical-OR of ACRN_IRQFD_FLAG_*
+ * @msi:	Info of MSI associated with the irqfd
+ */
+struct acrn_irqfd {
+	__s32			fd;
+	__u32			flags;
+	struct acrn_msi_entry	msi;
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -480,5 +493,7 @@ struct acrn_ioeventfd {
 
 #define ACRN_IOCTL_IOEVENTFD		\
 	_IOW(ACRN_IOCTL_TYPE, 0x70, struct acrn_ioeventfd)
+#define ACRN_IOCTL_IRQFD		\
+	_IOW(ACRN_IOCTL_TYPE, 0x71, struct acrn_irqfd)
 
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

