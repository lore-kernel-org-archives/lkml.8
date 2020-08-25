Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B89FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28704204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHYCvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:37753 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgHYCvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:51:45 -0400
IronPort-SDR: eFGrMyBj2wabSff23NaiQTktoke8qL2Yypo053u2j0CLBCoxFd/QKnbmNJGg5cxbW5LtDhiui5
 JrvKFhMQSLGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690846"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690846"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:51:29 -0700
IronPort-SDR: rocTASCIG9nQ/Y67wCYqQrUv6LYtKk6bHDveTcXs3WNJR2xsWI2lsb+JzF2LTvrenAAUUVvQut
 aqWjPXzJ4YhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409883"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:51:26 -0700
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
Subject: [PATCH 15/17] virt: acrn: Introduce ioeventfd
Date:   Tue, 25 Aug 2020 10:45:15 +0800
Message-Id: <20200825024516.16766-16-shuo.a.liu@intel.com>
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
---
 drivers/virt/acrn/Kconfig     |   1 +
 drivers/virt/acrn/Makefile    |   2 +-
 drivers/virt/acrn/acrn_drv.h  |  10 ++
 drivers/virt/acrn/hsm.c       |   8 +
 drivers/virt/acrn/ioeventfd.c | 275 ++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c        |   2 +
 include/uapi/linux/acrn.h     |  29 ++++
 7 files changed, 326 insertions(+), 1 deletion(-)
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
index 05836dcefbd6..e36e8c94139b 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -154,6 +154,9 @@ extern rwlock_t acrn_vm_list_lock;
  * @ioreq_page:			The page of the I/O request shared buffer
  * @pci_conf_addr:		Address of a PCI configuration access emulation
  * @monitor_page:		Page of interrupt statistics of User VM
+ * @ioeventfds_lock:		Lock to protect ioeventfds list
+ * @ioeventfds:			List to link all hsm_ioeventfd
+ * @ioeventfd_client:		I/O client for ioeventfds of the VM
  */
 struct acrn_vm {
 	struct list_head		list;
@@ -170,6 +173,9 @@ struct acrn_vm {
 	struct page			*ioreq_page;
 	u32				pci_conf_addr;
 	struct page			*monitor_page;
+	struct mutex			ioeventfds_lock;
+	struct list_head		ioeventfds;
+	struct acrn_ioreq_client	*ioeventfd_client;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
@@ -202,4 +208,8 @@ void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
 
 int acrn_msi_inject(u16 vmid, u64 msi_addr, u64 msi_data);
 
+int acrn_ioeventfd_init(struct acrn_vm *vm);
+int acrn_ioeventfd_config(struct acrn_vm *vm, struct acrn_ioeventfd *args);
+void acrn_ioeventfd_deinit(struct acrn_vm *vm);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index c0f33bc505e2..9f990929242c 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -112,6 +112,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vcpu_regs *cpu_regs;
 	struct acrn_ioreq_notify notify;
 	struct acrn_ptdev_irq *irq_info;
+	struct acrn_ioeventfd ioeventfd;
 	struct acrn_vm_memmap memmap;
 	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
@@ -303,6 +304,13 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 
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
 		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
 		ret = -EINVAL;
diff --git a/drivers/virt/acrn/ioeventfd.c b/drivers/virt/acrn/ioeventfd.c
new file mode 100644
index 000000000000..3c575173c47c
--- /dev/null
+++ b/drivers/virt/acrn/ioeventfd.c
@@ -0,0 +1,275 @@
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
+#define pr_fmt(fmt) "acrn: " fmt
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
+		pr_err("Failed to create ioeventfd ioreq client!\n");
+		return -EINVAL;
+	}
+
+	pr_debug("VM %u ioeventfd init.\n", vm->vmid);
+	return 0;
+}
+
+void acrn_ioeventfd_deinit(struct acrn_vm *vm)
+{
+	struct hsm_ioeventfd *p, *next;
+
+	pr_debug("VM %u ioeventfd deinit.\n", vm->vmid);
+	acrn_ioreq_client_destroy(vm->ioeventfd_client);
+	mutex_lock(&vm->ioeventfds_lock);
+	list_for_each_entry_safe(p, next, &vm->ioeventfds, list)
+		acrn_ioeventfd_shutdown(vm, p);
+	mutex_unlock(&vm->ioeventfds_lock);
+}
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 97c809490758..1a9456794663 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -46,6 +46,7 @@ struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
 	list_add(&vm->list, &acrn_vm_list);
 	write_unlock_bh(&acrn_vm_list_lock);
 
+	acrn_ioeventfd_init(vm);
 	pr_debug("VM %u created.\n", vm->vmid);
 	return vm;
 }
@@ -63,6 +64,7 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	list_del_init(&vm->list);
 	write_unlock_bh(&acrn_vm_list_lock);
 
+	acrn_ioeventfd_deinit(vm);
 	acrn_ioreq_deinit(vm);
 	if (vm->monitor_page) {
 		put_page(vm->monitor_page);
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index d5bd2b7dfd85..e2d5c657f8e2 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -395,6 +395,32 @@ enum acrn_pm_cmd_type {
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
 
@@ -452,4 +478,7 @@ enum acrn_pm_cmd_type {
 #define ACRN_IOCTL_PM_GET_CPU_STATE	\
 	_IOWR(ACRN_IOCTL_TYPE, 0x60, __u64)
 
+#define ACRN_IOCTL_IOEVENTFD		\
+	_IOW(ACRN_IOCTL_TYPE, 0x70, struct acrn_ioeventfd)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

