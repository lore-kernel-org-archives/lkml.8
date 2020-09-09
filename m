Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0C0221EA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgIIJLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:11:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:52525 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIIJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:11:16 -0400
IronPort-SDR: 8R/xu7ObDbpb9/C6uZcmzaooZj9fJc2EOsHm0iBF3cu3uzh1EmguNvbQyBjjCgHQ/NdqIZMA8h
 kZ+oGNb8Fz1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219854705"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="219854705"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:11:15 -0700
IronPort-SDR: aEIKCrWiYewNGz6DZYPccSW6H5zHPk3ejJG3ysdB7Nsu2fnjV79uujUIGu4vr2dI6B5RFWYA3B
 9ypSuQMztIag==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="505391258"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:11:10 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v3 15/17] virt: acrn: Introduce ioeventfd
Date:   Wed,  9 Sep 2020 17:08:34 +0800
Message-Id: <20200909090836.46762-16-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909090836.46762-1-shuo.a.liu@intel.com>
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

ioeventfd is a mechanism to register PIO/MMIO regions to trigger an
eventfd signal when written to by a User VM. ACRN userspace can register
any arbitrary I/O address with a corresponding eventfd and then pass the
eventfd to a specific end-point of interest for handling.

Vhost is a kernel-level virtio server which uses eventfd for signalling.
To support vhost on ACRN, ioeventfd is introduced in HSM.

A new I/O client dedicated to ioeventfd is associated with a User VM
during VM creation. HSM provides ioctls to associate an I/O region with
a eventfd. The I/O client signals a eventfd once its corresponding I/O
region is matched with an I/O request.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/Kconfig     |   1 +
 drivers/virt/acrn/Makefile    |   2 +-
 drivers/virt/acrn/acrn_drv.h  |  10 ++
 drivers/virt/acrn/hsm.c       |   8 +
 drivers/virt/acrn/ioeventfd.c | 273 ++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c        |   2 +
 include/uapi/linux/acrn.h     |  29 ++++
 7 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/acrn/ioeventfd.c

diff --git a/drivers/virt/acrn/Kconfig b/drivers/virt/acrn/Kconfig
index 36c80378c30c..3e1a61c9d8d8 100644
--- a/drivers/virt/acrn/Kconfig
+++ b/drivers/virt/acrn/Kconfig
@@ -2,6 +2,7 @@
 config ACRN_HSM
 	tristate "ACRN Hypervisor Service Module"
 	depends on ACRN_GUEST
+	select EVENTFD
 	help
 	  ACRN Hypervisor Service Module (HSM) is a kernel module which
 	  communicates with ACRN userspace through ioctls and talks to
diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
index 21721cbf6a80..755b583b32ca 100644
--- a/drivers/virt/acrn/Makefile
+++ b/drivers/virt/acrn/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
-acrn-y := hsm.o vm.o mm.o ioreq.o
+acrn-y := hsm.o vm.o mm.o ioreq.o ioeventfd.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index cde12eaa492e..4cb8a61d4ccd 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -156,6 +156,9 @@ extern rwlock_t acrn_vm_list_lock;
  * @ioreq_page:			The page of the I/O request shared buffer
  * @pci_conf_addr:		Address of a PCI configuration access emulation
  * @monitor_page:		Page of interrupt statistics of User VM
+ * @ioeventfds_lock:		Lock to protect ioeventfds list
+ * @ioeventfds:			List to link all hsm_ioeventfd
+ * @ioeventfd_client:		I/O client for ioeventfds of the VM
  */
 struct acrn_vm {
 	struct device			*dev;
@@ -173,6 +176,9 @@ struct acrn_vm {
 	struct page			*ioreq_page;
 	u32				pci_conf_addr;
 	struct page			*monitor_page;
+	struct mutex			ioeventfds_lock;
+	struct list_head		ioeventfds;
+	struct acrn_ioreq_client	*ioeventfd_client;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
@@ -205,4 +211,8 @@ void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
 
 int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data);
 
+int acrn_ioeventfd_init(struct acrn_vm *vm);
+int acrn_ioeventfd_config(struct acrn_vm *vm, struct acrn_ioeventfd *args);
+void acrn_ioeventfd_deinit(struct acrn_vm *vm);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 7c0e410cf32d..d8325f3ef6c0 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -111,6 +111,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vcpu_regs *cpu_regs;
 	struct acrn_ioreq_notify notify;
 	struct acrn_ptdev_irq *irq_info;
+	struct acrn_ioeventfd ioeventfd;
 	struct acrn_vm_memmap memmap;
 	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
@@ -296,6 +297,13 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 
 		ret = pmcmd_ioctl(cstate_cmd, (void __user *)ioctl_param);
 		break;
+	case ACRN_IOCTL_IOEVENTFD:
+		if (copy_from_user(&ioeventfd, (void __user *)ioctl_param,
+				   sizeof(ioeventfd)))
+			return -EFAULT;
+
+		ret = acrn_ioeventfd_config(vm, &ioeventfd);
+		break;
 	default:
 		dev_warn(vm->dev, "Unknown IOCTL 0x%x!\n", cmd);
 		ret = -ENOTTY;
diff --git a/drivers/virt/acrn/ioeventfd.c b/drivers/virt/acrn/ioeventfd.c
new file mode 100644
index 000000000000..2fc639ca4108
--- /dev/null
+++ b/drivers/virt/acrn/ioeventfd.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN HSM eventfd - use eventfd objects to signal expected I/O requests
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Shuo Liu <shuo.a.liu@intel.com>
+ *	Yakui Zhao <yakui.zhao@intel.com>
+ */
+
+#include <linux/eventfd.h>
+#include <linux/slab.h>
+
+#include "acrn_drv.h"
+
+/**
+ * struct hsm_ioeventfd - Properties of HSM ioeventfd
+ * @list:	Entry within &acrn_vm.ioeventfds of ioeventfds of a VM
+ * @eventfd:	Eventfd of the HSM ioeventfd
+ * @addr:	Address of I/O range
+ * @data:	Data for matching
+ * @length:	Length of I/O range
+ * @type:	Type of I/O range (ACRN_IOREQ_TYPE_MMIO/ACRN_IOREQ_TYPE_PORTIO)
+ * @wildcard:	Data matching or not
+ */
+struct hsm_ioeventfd {
+	struct list_head	list;
+	struct eventfd_ctx	*eventfd;
+	u64			addr;
+	u64			data;
+	int			length;
+	int			type;
+	bool			wildcard;
+};
+
+static inline int ioreq_type_from_flags(int flags)
+{
+	return flags & ACRN_IOEVENTFD_FLAG_PIO ?
+		       ACRN_IOREQ_TYPE_PORTIO : ACRN_IOREQ_TYPE_MMIO;
+}
+
+static void acrn_ioeventfd_shutdown(struct acrn_vm *vm, struct hsm_ioeventfd *p)
+{
+	lockdep_assert_held(&vm->ioeventfds_lock);
+
+	eventfd_ctx_put(p->eventfd);
+	list_del(&p->list);
+	kfree(p);
+}
+
+static bool hsm_ioeventfd_is_conflict(struct acrn_vm *vm,
+				      struct hsm_ioeventfd *ioeventfd)
+{
+	struct hsm_ioeventfd *p;
+
+	lockdep_assert_held(&vm->ioeventfds_lock);
+
+	/* Either one is wildcard, the data matching will be skipped. */
+	list_for_each_entry(p, &vm->ioeventfds, list)
+		if (p->eventfd == ioeventfd->eventfd &&
+		    p->addr == ioeventfd->addr &&
+		    p->type == ioeventfd->type &&
+		    (p->wildcard || ioeventfd->wildcard ||
+			p->data == ioeventfd->data))
+			return true;
+
+	return false;
+}
+
+/*
+ * Assign an eventfd to a VM and create a HSM ioeventfd associated with the
+ * eventfd. The properties of the HSM ioeventfd are built from a &struct
+ * acrn_ioeventfd.
+ */
+static int acrn_ioeventfd_assign(struct acrn_vm *vm,
+				 struct acrn_ioeventfd *args)
+{
+	struct eventfd_ctx *eventfd;
+	struct hsm_ioeventfd *p;
+	int ret;
+
+	/* Check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return -EINVAL;
+
+	/*
+	 * Currently, acrn_ioeventfd is used to support vhost. 1,2,4,8 width
+	 * accesses can cover vhost's requirements.
+	 */
+	if (!(args->len == 1 || args->len == 2 ||
+	      args->len == 4 || args->len == 8))
+		return -EINVAL;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	INIT_LIST_HEAD(&p->list);
+	p->addr = args->addr;
+	p->length = args->len;
+	p->eventfd = eventfd;
+	p->type = ioreq_type_from_flags(args->flags);
+
+	/*
+	 * ACRN_IOEVENTFD_FLAG_DATAMATCH flag is set in virtio 1.0 support, the
+	 * writing of notification register of each virtqueue may trigger the
+	 * notification. There is no data matching requirement.
+	 */
+	if (args->flags & ACRN_IOEVENTFD_FLAG_DATAMATCH)
+		p->data = args->data;
+	else
+		p->wildcard = true;
+
+	mutex_lock(&vm->ioeventfds_lock);
+
+	if (hsm_ioeventfd_is_conflict(vm, p)) {
+		ret = -EEXIST;
+		goto unlock_fail;
+	}
+
+	/* register the I/O range into ioreq client */
+	ret = acrn_ioreq_range_add(vm->ioeventfd_client, p->type,
+				   p->addr, p->addr + p->length - 1);
+	if (ret < 0)
+		goto unlock_fail;
+
+	list_add_tail(&p->list, &vm->ioeventfds);
+	mutex_unlock(&vm->ioeventfds_lock);
+
+	return 0;
+
+unlock_fail:
+	mutex_unlock(&vm->ioeventfds_lock);
+	kfree(p);
+fail:
+	eventfd_ctx_put(eventfd);
+	return ret;
+}
+
+static int acrn_ioeventfd_deassign(struct acrn_vm *vm,
+				   struct acrn_ioeventfd *args)
+{
+	struct hsm_ioeventfd *p;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	mutex_lock(&vm->ioeventfds_lock);
+	list_for_each_entry(p, &vm->ioeventfds, list) {
+		if (p->eventfd != eventfd)
+			continue;
+
+		acrn_ioreq_range_del(vm->ioeventfd_client, p->type,
+				     p->addr, p->addr + p->length - 1);
+		acrn_ioeventfd_shutdown(vm, p);
+		break;
+	}
+	mutex_unlock(&vm->ioeventfds_lock);
+
+	eventfd_ctx_put(eventfd);
+	return 0;
+}
+
+static struct hsm_ioeventfd *hsm_ioeventfd_match(struct acrn_vm *vm, u64 addr,
+						 u64 data, int len, int type)
+{
+	struct hsm_ioeventfd *p = NULL;
+
+	lockdep_assert_held(&vm->ioeventfds_lock);
+
+	list_for_each_entry(p, &vm->ioeventfds, list) {
+		if (p->type == type && p->addr == addr && p->length >= len &&
+		    (p->wildcard || p->data == data))
+			return p;
+	}
+
+	return NULL;
+}
+
+static int acrn_ioeventfd_handler(struct acrn_ioreq_client *client,
+				  struct acrn_io_request *req)
+{
+	struct hsm_ioeventfd *p;
+	u64 addr, val;
+	int size;
+
+	if (req->type == ACRN_IOREQ_TYPE_MMIO) {
+		/*
+		 * I/O requests are dispatched by range check only, so a
+		 * acrn_ioreq_client need process both READ and WRITE accesses
+		 * of same range. READ accesses are safe to be ignored here
+		 * because virtio PCI devices write the notify registers for
+		 * notification.
+		 */
+		if (req->reqs.mmio_request.direction == ACRN_IOREQ_DIR_READ) {
+			/* reading does nothing and return 0 */
+			req->reqs.mmio_request.value = 0;
+			return 0;
+		}
+		addr = req->reqs.mmio_request.address;
+		size = req->reqs.mmio_request.size;
+		val = req->reqs.mmio_request.value;
+	} else {
+		if (req->reqs.pio_request.direction == ACRN_IOREQ_DIR_READ) {
+			/* reading does nothing and return 0 */
+			req->reqs.pio_request.value = 0;
+			return 0;
+		}
+		addr = req->reqs.pio_request.address;
+		size = req->reqs.pio_request.size;
+		val = req->reqs.pio_request.value;
+	}
+
+	mutex_lock(&client->vm->ioeventfds_lock);
+	p = hsm_ioeventfd_match(client->vm, addr, val, size, req->type);
+	if (p)
+		eventfd_signal(p->eventfd, 1);
+	mutex_unlock(&client->vm->ioeventfds_lock);
+
+	return 0;
+}
+
+int acrn_ioeventfd_config(struct acrn_vm *vm, struct acrn_ioeventfd *args)
+{
+	int ret;
+
+	if (args->flags & ACRN_IOEVENTFD_FLAG_DEASSIGN)
+		ret = acrn_ioeventfd_deassign(vm, args);
+	else
+		ret = acrn_ioeventfd_assign(vm, args);
+
+	return ret;
+}
+
+int acrn_ioeventfd_init(struct acrn_vm *vm)
+{
+	char name[ACRN_NAME_LEN];
+
+	mutex_init(&vm->ioeventfds_lock);
+	INIT_LIST_HEAD(&vm->ioeventfds);
+	snprintf(name, sizeof(name), "ioeventfd-%u", vm->vmid);
+	vm->ioeventfd_client = acrn_ioreq_client_create(vm,
+							acrn_ioeventfd_handler,
+							NULL, false, name);
+	if (!vm->ioeventfd_client) {
+		dev_err(vm->dev, "Failed to create ioeventfd ioreq client!\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(vm->dev, "VM %u ioeventfd init.\n", vm->vmid);
+	return 0;
+}
+
+void acrn_ioeventfd_deinit(struct acrn_vm *vm)
+{
+	struct hsm_ioeventfd *p, *next;
+
+	dev_dbg(vm->dev, "VM %u ioeventfd deinit.\n", vm->vmid);
+	acrn_ioreq_client_destroy(vm->ioeventfd_client);
+	mutex_lock(&vm->ioeventfds_lock);
+	list_for_each_entry_safe(p, next, &vm->ioeventfds, list)
+		acrn_ioeventfd_shutdown(vm, p);
+	mutex_unlock(&vm->ioeventfds_lock);
+}
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index c1fefd92e571..6ca7270114a6 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -49,6 +49,7 @@ struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
 	list_add(&vm->list, &acrn_vm_list);
 	write_unlock_bh(&acrn_vm_list_lock);
 
+	acrn_ioeventfd_init(vm);
 	dev_dbg(vm->dev, "VM %u created.\n", vm->vmid);
 	return vm;
 }
@@ -66,6 +67,7 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	list_del_init(&vm->list);
 	write_unlock_bh(&acrn_vm_list_lock);
 
+	acrn_ioeventfd_deinit(vm);
 	acrn_ioreq_deinit(vm);
 	if (vm->monitor_page) {
 		put_page(vm->monitor_page);
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 9fed7209a8ef..7a99124c7d4d 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -385,6 +385,32 @@ enum acrn_pm_cmd_type {
 	ACRN_PMCMD_GET_CX_DATA,
 };
 
+#define ACRN_IOEVENTFD_FLAG_PIO		0x01
+#define ACRN_IOEVENTFD_FLAG_DATAMATCH	0x02
+#define ACRN_IOEVENTFD_FLAG_DEASSIGN	0x04
+/**
+ * struct acrn_ioeventfd - Data to operate a &struct hsm_ioeventfd
+ * @fd:		The fd of eventfd associated with a hsm_ioeventfd
+ * @flags:	Logical-OR of ACRN_IOEVENTFD_FLAG_*
+ * @addr:	The start address of IO range of ioeventfd
+ * @len:	The length of IO range of ioeventfd
+ * @reserved:	Reserved
+ * @data:	Data for data matching
+ *
+ * Without flag ACRN_IOEVENTFD_FLAG_DEASSIGN, ioctl ACRN_IOCTL_IOEVENTFD
+ * creates a &struct hsm_ioeventfd with properties originated from &struct
+ * acrn_ioeventfd. With flag ACRN_IOEVENTFD_FLAG_DEASSIGN, ioctl
+ * ACRN_IOCTL_IOEVENTFD destroys the &struct hsm_ioeventfd matching the fd.
+ */
+struct acrn_ioeventfd {
+	__u32	fd;
+	__u32	flags;
+	__u64	addr;
+	__u32	len;
+	__u32	reserved;
+	__u64	data;
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -439,4 +465,7 @@ enum acrn_pm_cmd_type {
 #define ACRN_IOCTL_PM_GET_CPU_STATE	\
 	_IOWR(ACRN_IOCTL_TYPE, 0x60, __u64)
 
+#define ACRN_IOCTL_IOEVENTFD		\
+	_IOW(ACRN_IOCTL_TYPE, 0x70, struct acrn_ioeventfd)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

