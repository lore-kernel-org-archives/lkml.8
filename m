Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD65920708
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIIJKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:10:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:23245 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbgIIJKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:10:43 -0400
IronPort-SDR: P8deWJWYI5rGnzE5EGG9pUAWlnOmFtT8A+5rLOwZaBCXxapXdmX9/waphnjlBrxdwoY2qfa6KG
 DtggM6N4Wzrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="146014660"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="146014660"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:10:41 -0700
IronPort-SDR: 9qhokcOjYOq6wqWzUPvj4kOCb3TogWkgpV3Kd5eKTqq9eVoppr6EKPhnYfdz29Jn18tXyRoSuJ
 hvKNGnK+xKVw==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="284806315"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:10:12 -0700
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
Subject: [PATCH v3 09/17] virt: acrn: Introduce I/O request management
Date:   Wed,  9 Sep 2020 17:08:28 +0800
Message-Id: <20200909090836.46762-10-shuo.a.liu@intel.com>
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

An I/O request of a User VM, which is constructed by the hypervisor, is
distributed by the ACRN Hypervisor Service Module to an I/O client
corresponding to the address range of the I/O request.

For each User VM, there is a shared 4-KByte memory region used for I/O
requests communication between the hypervisor and Service VM. An I/O
request is a 256-byte structure buffer, which is 'struct
acrn_io_request', that is filled by an I/O handler of the hypervisor
when a trapped I/O access happens in a User VM. ACRN userspace in the
Service VM first allocates a 4-KByte page and passes the GPA (Guest
Physical Address) of the buffer to the hypervisor. The buffer is used as
an array of 16 I/O request slots with each I/O request slot being 256
bytes. This array is indexed by vCPU ID.

An I/O client, which is 'struct acrn_ioreq_client', is responsible for
handling User VM I/O requests whose accessed GPA falls in a certain
range. Multiple I/O clients can be associated with each User VM. There
is a special client associated with each User VM, called the default
client, that handles all I/O requests that do not fit into the range of
any other I/O clients. The ACRN userspace acts as the default client for
each User VM.

The state transitions of a ACRN I/O request are as follows.

   FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...

FREE: this I/O request slot is empty
PENDING: a valid I/O request is pending in this slot
PROCESSING: the I/O request is being processed
COMPLETE: the I/O request has been processed

An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM
and ACRN userspace are in charge of processing the others.

The processing flow of I/O requests are listed as following:

a) The I/O handler of the hypervisor will fill an I/O request with
   PENDING state when a trapped I/O access happens in a User VM.
b) The hypervisor makes an upcall, which is a notification interrupt, to
   the Service VM.
c) The upcall handler schedules a tasklet to dispatch I/O requests.
d) The tasklet looks for the PENDING I/O requests, assigns them to
   different registered clients based on the address of the I/O accesses,
   updates their state to PROCESSING, and notifies the corresponding
   client to handle.
e) The notified client handles the assigned I/O requests.
f) The HSM updates I/O requests states to COMPLETE and notifies the
   hypervisor of the completion via hypercalls.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/Makefile    |   2 +-
 drivers/virt/acrn/acrn_drv.h  |  80 ++++++
 drivers/virt/acrn/hsm.c       |  32 ++-
 drivers/virt/acrn/hypercall.h |  28 ++
 drivers/virt/acrn/ioreq.c     | 506 ++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c        |  10 +
 include/uapi/linux/acrn.h     | 134 +++++++++
 7 files changed, 789 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virt/acrn/ioreq.c

diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
index 38bc44b6edcd..21721cbf6a80 100644
--- a/drivers/virt/acrn/Makefile
+++ b/drivers/virt/acrn/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
-acrn-y := hsm.o vm.o mm.o
+acrn-y := hsm.o vm.o mm.o ioreq.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 134914261e71..9a8e3bb007b1 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -9,10 +9,15 @@
 
 #include "hypercall.h"
 
+#define ACRN_NAME_LEN		16
 #define ACRN_MEM_MAPPING_MAX	256
 
 #define ACRN_MEM_REGION_ADD	0
 #define ACRN_MEM_REGION_DEL	2
+
+struct acrn_vm;
+struct acrn_ioreq_client;
+
 /**
  * struct vm_memory_region_op - Hypervisor memory operation
  * @type:		Operation type (ACRN_MEM_REGION_*)
@@ -74,9 +79,61 @@ struct vm_memory_mapping {
 	size_t		size;
 };
 
+/**
+ * struct acrn_ioreq_buffer - Data for setting the ioreq buffer of User VM
+ * @ioreq_buf:	The GPA of the IO request shared buffer of a VM
+ *
+ * The parameter for the HC_SET_IOREQ_BUFFER hypercall used to set up
+ * the shared I/O request buffer between Service VM and ACRN hypervisor.
+ */
+struct acrn_ioreq_buffer {
+	u64	ioreq_buf;
+};
+
+struct acrn_ioreq_range {
+	struct list_head	list;
+	u32			type;
+	u64			start;
+	u64			end;
+};
+
+#define ACRN_IOREQ_CLIENT_DESTROYING	0U
+typedef	int (*ioreq_handler_t)(struct acrn_ioreq_client *client,
+			       struct acrn_io_request *req);
+/**
+ * struct acrn_ioreq_client - Structure of I/O client.
+ * @name:	Client name
+ * @vm:		The VM that the client belongs to
+ * @list:	List node for this acrn_ioreq_client
+ * @is_default:	If this client is the default one
+ * @flags:	Flags (ACRN_IOREQ_CLIENT_*)
+ * @range_list:	I/O ranges
+ * @range_lock:	Lock to protect range_list
+ * @ioreqs_map:	The pending I/O requests bitmap.
+ * @handler:	I/O requests handler of this client
+ * @thread:	The thread which executes the handler
+ * @wq:		The wait queue for the handler thread parking
+ * @priv:	Data for the thread
+ */
+struct acrn_ioreq_client {
+	char			name[ACRN_NAME_LEN];
+	struct acrn_vm		*vm;
+	struct list_head	list;
+	bool			is_default;
+	unsigned long		flags;
+	struct list_head	range_list;
+	rwlock_t		range_lock;
+	DECLARE_BITMAP(ioreqs_map, ACRN_IO_REQUEST_MAX);
+	ioreq_handler_t		handler;
+	struct task_struct	*thread;
+	wait_queue_head_t	wq;
+	void			*priv;
+};
+
 #define ACRN_INVALID_VMID (0xffffU)
 
 #define ACRN_VM_FLAG_DESTROYED		0U
+#define ACRN_VM_FLAG_CLEARING_IOREQ	1U
 extern struct list_head acrn_vm_list;
 extern rwlock_t acrn_vm_list_lock;
 /**
@@ -92,6 +149,11 @@ extern rwlock_t acrn_vm_list_lock;
  *				&acrn_vm.regions_mapping_count.
  * @regions_mapping:		Memory mappings of this VM.
  * @regions_mapping_count:	Number of memory mapping of this VM.
+ * @ioreq_clients_lock:		Lock to protect ioreq_clients and default_client
+ * @ioreq_clients:		The I/O request clients list of this VM
+ * @default_client:		The default I/O request client
+ * @ioreq_buf:			I/O request shared buffer
+ * @ioreq_page:			The page of the I/O request shared buffer
  */
 struct acrn_vm {
 	struct device			*dev;
@@ -102,6 +164,11 @@ struct acrn_vm {
 	struct mutex			regions_mapping_lock;
 	struct vm_memory_mapping	regions_mapping[ACRN_MEM_MAPPING_MAX];
 	int				regions_mapping_count;
+	spinlock_t			ioreq_clients_lock;
+	struct list_head		ioreq_clients;
+	struct acrn_ioreq_client	*default_client;
+	struct acrn_io_request_buffer	*ioreq_buf;
+	struct page			*ioreq_page;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
@@ -115,4 +182,17 @@ int acrn_vm_memseg_unmap(struct acrn_vm *vm, struct acrn_vm_memmap *memmap);
 int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap);
 void acrn_vm_all_ram_unmap(struct acrn_vm *vm);
 
+int acrn_ioreq_init(struct acrn_vm *vm, u64 buf_vma);
+void acrn_ioreq_deinit(struct acrn_vm *vm);
+void acrn_ioreq_intr_setup(void);
+void acrn_ioreq_intr_remove(void);
+void acrn_ioreq_request_clear(struct acrn_vm *vm);
+int acrn_ioreq_client_wait(struct acrn_ioreq_client *client);
+int acrn_ioreq_request_default_complete(struct acrn_vm *vm, u16 vcpu);
+struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
+						   ioreq_handler_t handler,
+						   void *data, bool is_default,
+						   const char *name);
+void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index a0ddb17ea284..b7cae2025851 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -48,6 +48,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vm *vm = filp->private_data;
 	struct acrn_vm_creation *vm_param;
 	struct acrn_vcpu_regs *cpu_regs;
+	struct acrn_ioreq_notify notify;
 	struct acrn_vm_memmap memmap;
 	int ret = 0;
 
@@ -122,6 +123,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 
 		ret = acrn_vm_memseg_unmap(vm, &memmap);
 		break;
+	case ACRN_IOCTL_CREATE_IOREQ_CLIENT:
+		if (vm->default_client)
+			return -EEXIST;
+		if (!acrn_ioreq_client_create(vm, NULL, NULL, true, "acrndm"))
+			ret = -EFAULT;
+		break;
+	case ACRN_IOCTL_DESTROY_IOREQ_CLIENT:
+		if (vm->default_client)
+			acrn_ioreq_client_destroy(vm->default_client);
+		break;
+	case ACRN_IOCTL_ATTACH_IOREQ_CLIENT:
+		if (vm->default_client)
+			ret = acrn_ioreq_client_wait(vm->default_client);
+		break;
+	case ACRN_IOCTL_NOTIFY_REQUEST_FINISH:
+		if (copy_from_user(&notify, (void __user *)ioctl_param,
+				   sizeof(struct acrn_ioreq_notify)))
+			return -EFAULT;
+		ret = acrn_ioreq_request_default_complete(vm, notify.vcpu);
+		break;
+	case ACRN_IOCTL_CLEAR_VM_IOREQ:
+		acrn_ioreq_request_clear(vm);
+		break;
 	default:
 		dev_warn(vm->dev, "Unknown IOCTL 0x%x!\n", cmd);
 		ret = -ENOTTY;
@@ -164,14 +188,18 @@ static int __init hsm_init(void)
 		return -EPERM;
 
 	ret = misc_register(&acrn_dev);
-	if (ret)
+	if (ret) {
 		pr_err("Create misc dev failed!\n");
+		return ret;
+	}
 
-	return ret;
+	acrn_ioreq_intr_setup();
+	return 0;
 }
 
 static void __exit hsm_exit(void)
 {
+	acrn_ioreq_intr_remove();
 	misc_deregister(&acrn_dev);
 }
 module_init(hsm_init);
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index a1a70a071713..5eba29e3ed38 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -21,6 +21,10 @@
 #define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
 #define HC_SET_VCPU_REGS		_HC_ID(HC_ID, HC_ID_VM_BASE + 0x06)
 
+#define HC_ID_IOREQ_BASE		0x30UL
+#define HC_SET_IOREQ_BUFFER		_HC_ID(HC_ID, HC_ID_IOREQ_BASE + 0x00)
+#define HC_NOTIFY_REQUEST_FINISH	_HC_ID(HC_ID, HC_ID_IOREQ_BASE + 0x01)
+
 #define HC_ID_MEM_BASE			0x40UL
 #define HC_VM_SET_MEMORY_REGIONS	_HC_ID(HC_ID, HC_ID_MEM_BASE + 0x02)
 
@@ -91,6 +95,30 @@ static inline long hcall_set_vcpu_regs(u64 vmid, u64 regs_state)
 	return acrn_hypercall2(HC_SET_VCPU_REGS, vmid, regs_state);
 }
 
+/**
+ * hcall_set_ioreq_buffer() - Set up the shared buffer for I/O Requests.
+ * @vmid:	User VM ID
+ * @buffer:	Service VM GPA of the shared buffer
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_ioreq_buffer(u64 vmid, u64 buffer)
+{
+	return acrn_hypercall2(HC_SET_IOREQ_BUFFER, vmid, buffer);
+}
+
+/**
+ * hcall_notify_req_finish() - Notify ACRN Hypervisor of I/O request completion.
+ * @vmid:	User VM ID
+ * @vcpu:	The vCPU which initiated the I/O request
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_notify_req_finish(u64 vmid, u64 vcpu)
+{
+	return acrn_hypercall2(HC_NOTIFY_REQUEST_FINISH, vmid, vcpu);
+}
+
 /**
  * hcall_set_memory_regions() - Inform the hypervisor to set up EPT mappings
  * @regions_pa:	Service VM GPA of &struct vm_memory_region_batch
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
new file mode 100644
index 000000000000..d1c5664bda89
--- /dev/null
+++ b/drivers/virt/acrn/ioreq.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN_HSM: Handle I/O requests
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Jason Chen CJ <jason.cj.chen@intel.com>
+ *	Fengwei Yin <fengwei.yin@intel.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include <asm/acrn.h>
+
+#include "acrn_drv.h"
+
+static void ioreq_pause(void);
+static void ioreq_resume(void);
+
+static struct tasklet_struct ioreq_tasklet;
+
+static inline bool has_pending_request(struct acrn_ioreq_client *client)
+{
+	return !bitmap_empty(client->ioreqs_map, ACRN_IO_REQUEST_MAX);
+}
+
+static inline bool is_destroying(struct acrn_ioreq_client *client)
+{
+	return test_bit(ACRN_IOREQ_CLIENT_DESTROYING, &client->flags);
+}
+
+static int ioreq_complete_request(struct acrn_vm *vm, u16 vcpu,
+				  struct acrn_io_request *acrn_req)
+{
+	bool polling_mode;
+	int ret = 0;
+
+	polling_mode = acrn_req->completion_polling;
+	/* Add barrier() to make sure the writes are done before completion */
+	smp_store_release(&acrn_req->processed, ACRN_IOREQ_STATE_COMPLETE);
+
+	/*
+	 * To fulfill the requirement of real-time in several industry
+	 * scenarios, like automotive, ACRN can run under the partition mode,
+	 * in which User VMs and Service VM are bound to dedicated CPU cores.
+	 * Polling mode of handling the I/O request is introduced to achieve a
+	 * faster I/O request handling. In polling mode, the hypervisor polls
+	 * I/O request's completion. Once an I/O request is marked as
+	 * ACRN_IOREQ_STATE_COMPLETE, hypervisor resumes from the polling point
+	 * to continue the I/O request flow. Thus, the completion notification
+	 * from HSM of I/O request is not needed.  Please note,
+	 * completion_polling needs to be read before the I/O request being
+	 * marked as ACRN_IOREQ_STATE_COMPLETE to avoid racing with the
+	 * hypervisor.
+	 */
+	if (!polling_mode) {
+		ret = hcall_notify_req_finish(vm->vmid, vcpu);
+		if (ret < 0)
+			dev_err(vm->dev,
+				"Notify I/O request finished failed!\n");
+	}
+
+	return ret;
+}
+
+static int acrn_ioreq_complete_request(struct acrn_ioreq_client *client,
+				       u16 vcpu,
+				       struct acrn_io_request *acrn_req)
+{
+	int ret;
+
+	if (vcpu >= client->vm->vcpu_num)
+		return -EINVAL;
+
+	clear_bit(vcpu, client->ioreqs_map);
+	if (!acrn_req) {
+		acrn_req = (struct acrn_io_request *)client->vm->ioreq_buf;
+		acrn_req += vcpu;
+	}
+
+	ret = ioreq_complete_request(client->vm, vcpu, acrn_req);
+
+	return ret;
+}
+
+int acrn_ioreq_request_default_complete(struct acrn_vm *vm, u16 vcpu)
+{
+	int ret = 0;
+
+	spin_lock_bh(&vm->ioreq_clients_lock);
+	if (vm->default_client)
+		ret = acrn_ioreq_complete_request(vm->default_client,
+						  vcpu, NULL);
+	spin_unlock_bh(&vm->ioreq_clients_lock);
+
+	return ret;
+}
+
+/*
+ * ioreq_task() is the execution entity of handler thread of an I/O client.
+ * The handler callback of the I/O client is called within the handler thread.
+ */
+static int ioreq_task(void *data)
+{
+	struct acrn_ioreq_client *client = data;
+	struct acrn_io_request *req;
+	unsigned long *ioreqs_map;
+	int vcpu, ret;
+
+	/*
+	 * Lockless access to ioreqs_map is safe, because
+	 * 1) set_bit() and clear_bit() are atomic operations.
+	 * 2) I/O requests arrives serialized. The access flow of ioreqs_map is:
+	 *	set_bit() - in tasklet
+	 *	Handler callback handles corresponding I/O request
+	 *	clear_bit() - in handler thread (include ACRN userspace)
+	 *	Mark corresponding I/O request completed
+	 *	Loop again if a new I/O request occurs
+	 */
+	ioreqs_map = client->ioreqs_map;
+	while (!kthread_should_stop()) {
+		acrn_ioreq_client_wait(client);
+		while (has_pending_request(client)) {
+			vcpu = find_first_bit(ioreqs_map, client->vm->vcpu_num);
+			req = client->vm->ioreq_buf->req_slot + vcpu;
+			ret = client->handler(client, req);
+			if (ret < 0) {
+				dev_err(client->vm->dev,
+					"IO handle failure: %d\n", ret);
+				break;
+			}
+			acrn_ioreq_complete_request(client, vcpu, req);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * For the non-default I/O clients, give them chance to complete the current
+ * I/O requests if there are any. For the default I/O client, it is safe to
+ * clear all pending I/O requests because the clearing request is from ACRN
+ * userspace.
+ */
+void acrn_ioreq_request_clear(struct acrn_vm *vm)
+{
+	struct acrn_ioreq_client *client;
+	bool has_pending = false;
+	unsigned long vcpu;
+	int retry = 10;
+
+	/*
+	 * IO requests of this VM will be completed directly in
+	 * acrn_ioreq_dispatch if ACRN_VM_FLAG_CLEARING_IOREQ flag is set.
+	 */
+	set_bit(ACRN_VM_FLAG_CLEARING_IOREQ, &vm->flags);
+
+	/*
+	 * acrn_ioreq_request_clear is only called in VM reset case. Simply
+	 * wait 100ms in total for the IO requests' completion.
+	 */
+	do {
+		spin_lock_bh(&vm->ioreq_clients_lock);
+		list_for_each_entry(client, &vm->ioreq_clients, list) {
+			has_pending = has_pending_request(client);
+			if (has_pending)
+				break;
+		}
+		spin_unlock_bh(&vm->ioreq_clients_lock);
+
+		if (has_pending)
+			schedule_timeout_interruptible(HZ / 100);
+	} while (has_pending && --retry > 0);
+	if (retry == 0)
+		dev_warn(vm->dev, "%s cannot flush pending request!\n",
+			 client->name);
+
+	/* Clear all ioreqs belonging to the default client */
+	spin_lock_bh(&vm->ioreq_clients_lock);
+	client = vm->default_client;
+	if (client) {
+		vcpu = find_next_bit(client->ioreqs_map,
+				     ACRN_IO_REQUEST_MAX, 0);
+		while (vcpu < ACRN_IO_REQUEST_MAX) {
+			acrn_ioreq_complete_request(client, vcpu, NULL);
+			vcpu = find_next_bit(client->ioreqs_map,
+					     ACRN_IO_REQUEST_MAX, vcpu + 1);
+		}
+	}
+	spin_unlock_bh(&vm->ioreq_clients_lock);
+
+	/* Clear ACRN_VM_FLAG_CLEARING_IOREQ flag after the clearing */
+	clear_bit(ACRN_VM_FLAG_CLEARING_IOREQ, &vm->flags);
+}
+
+int acrn_ioreq_client_wait(struct acrn_ioreq_client *client)
+{
+	if (client->is_default) {
+		/*
+		 * In the default client, a user space thread waits on the
+		 * waitqueue. The is_destroying() check is used to notify user
+		 * space the client is going to be destroyed.
+		 */
+		wait_event_interruptible(client->wq,
+					 has_pending_request(client) ||
+					 is_destroying(client));
+		if (is_destroying(client))
+			/* return 1 to indicate the client is being destroyed */
+			return 1;
+	} else {
+		wait_event_interruptible(client->wq,
+					 has_pending_request(client) ||
+					 kthread_should_stop());
+	}
+
+	return 0;
+}
+
+static bool in_range(struct acrn_ioreq_range *range,
+		     struct acrn_io_request *req)
+{
+	bool ret = false;
+
+	if (range->type == req->type) {
+		switch (req->type) {
+		case ACRN_IOREQ_TYPE_MMIO:
+			if (req->reqs.mmio_request.address >= range->start &&
+			    (req->reqs.mmio_request.address +
+			     req->reqs.mmio_request.size - 1) <= range->end)
+				ret = true;
+			break;
+		case ACRN_IOREQ_TYPE_PORTIO:
+			if (req->reqs.pio_request.address >= range->start &&
+			    (req->reqs.pio_request.address +
+			     req->reqs.pio_request.size - 1) <= range->end)
+				ret = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static struct acrn_ioreq_client *find_ioreq_client(struct acrn_vm *vm,
+						   struct acrn_io_request *req)
+{
+	struct acrn_ioreq_client *client, *found = NULL;
+	struct acrn_ioreq_range *range;
+
+	lockdep_assert_held(&vm->ioreq_clients_lock);
+
+	list_for_each_entry(client, &vm->ioreq_clients, list) {
+		read_lock_bh(&client->range_lock);
+		list_for_each_entry(range, &client->range_list, list) {
+			if (in_range(range, req)) {
+				found = client;
+				break;
+			}
+		}
+		read_unlock_bh(&client->range_lock);
+		if (found)
+			break;
+	}
+	return found ? found : vm->default_client;
+}
+
+/**
+ * acrn_ioreq_client_create() - Create an ioreq client
+ * @vm:		The VM that this client belongs to
+ * @handler:	The ioreq_handler of ioreq client acrn_hsm will create a kernel
+ *		thread and call the handler to handle I/O requests.
+ * @priv:	Private data for the handler
+ * @is_default:	If it is the default client
+ * @name:	The name of ioreq client
+ *
+ * Return: acrn_ioreq_client pointer on success, NULL on error
+ */
+struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
+						   ioreq_handler_t handler,
+						   void *priv, bool is_default,
+						   const char *name)
+{
+	struct acrn_ioreq_client *client;
+
+	if (!handler && !is_default) {
+		dev_err(vm->dev,
+			"Cannot create non-default client w/o handler!\n");
+		return NULL;
+	}
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return NULL;
+
+	client->handler = handler;
+	client->vm = vm;
+	client->priv = priv;
+	client->is_default = is_default;
+	if (name)
+		strncpy(client->name, name, sizeof(client->name) - 1);
+	rwlock_init(&client->range_lock);
+	INIT_LIST_HEAD(&client->range_list);
+	init_waitqueue_head(&client->wq);
+
+	if (client->handler) {
+		client->thread = kthread_run(ioreq_task, client, "VM%u-%s",
+					     client->vm->vmid, client->name);
+		if (IS_ERR(client->thread)) {
+			kfree(client);
+			return NULL;
+		}
+	}
+
+	spin_lock_bh(&vm->ioreq_clients_lock);
+	if (is_default)
+		vm->default_client = client;
+	else
+		list_add(&client->list, &vm->ioreq_clients);
+	spin_unlock_bh(&vm->ioreq_clients_lock);
+
+	dev_dbg(vm->dev, "Created ioreq client %s.\n", name);
+	return client;
+}
+
+/**
+ * acrn_ioreq_client_destroy() - Destroy an ioreq client
+ * @client:	The ioreq client
+ */
+void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client)
+{
+	struct acrn_ioreq_range *range, *next;
+	struct acrn_vm *vm = client->vm;
+
+	dev_dbg(vm->dev, "Destroy ioreq client %s.\n", client->name);
+	ioreq_pause();
+	set_bit(ACRN_IOREQ_CLIENT_DESTROYING, &client->flags);
+	if (client->is_default)
+		wake_up_interruptible(&client->wq);
+	else
+		kthread_stop(client->thread);
+
+	spin_lock_bh(&vm->ioreq_clients_lock);
+	if (client->is_default)
+		vm->default_client = NULL;
+	else
+		list_del(&client->list);
+	spin_unlock_bh(&vm->ioreq_clients_lock);
+
+	write_lock_bh(&client->range_lock);
+	list_for_each_entry_safe(range, next, &client->range_list, list) {
+		list_del(&range->list);
+		kfree(range);
+	}
+	write_unlock_bh(&client->range_lock);
+	kfree(client);
+
+	ioreq_resume();
+}
+
+static int acrn_ioreq_dispatch(struct acrn_vm *vm)
+{
+	struct acrn_ioreq_client *client;
+	struct acrn_io_request *req;
+	int i;
+
+	for (i = 0; i < vm->vcpu_num; i++) {
+		req = vm->ioreq_buf->req_slot + i;
+
+		/* barrier the read of processed of acrn_io_request */
+		if (smp_load_acquire(&req->processed) ==
+				     ACRN_IOREQ_STATE_PENDING) {
+			/* Complete the IO request directly in clearing stage */
+			if (test_bit(ACRN_VM_FLAG_CLEARING_IOREQ, &vm->flags)) {
+				ioreq_complete_request(vm, i, req);
+				continue;
+			}
+
+			spin_lock_bh(&vm->ioreq_clients_lock);
+			client = find_ioreq_client(vm, req);
+			if (!client) {
+				dev_err(vm->dev,
+					"Failed to find ioreq client!\n");
+				spin_unlock_bh(&vm->ioreq_clients_lock);
+				return -EINVAL;
+			}
+			if (!client->is_default)
+				req->kernel_handled = 1;
+			else
+				req->kernel_handled = 0;
+			/*
+			 * Add barrier() to make sure the writes are done
+			 * before setting ACRN_IOREQ_STATE_PROCESSING
+			 */
+			smp_store_release(&req->processed,
+					  ACRN_IOREQ_STATE_PROCESSING);
+			set_bit(i, client->ioreqs_map);
+			wake_up_interruptible(&client->wq);
+			spin_unlock_bh(&vm->ioreq_clients_lock);
+		}
+	}
+
+	return 0;
+}
+
+static void ioreq_tasklet_handler(unsigned long data)
+{
+	struct acrn_vm *vm;
+
+	read_lock(&acrn_vm_list_lock);
+	list_for_each_entry(vm, &acrn_vm_list, list) {
+		if (!vm->ioreq_buf)
+			break;
+		acrn_ioreq_dispatch(vm);
+	}
+	read_unlock(&acrn_vm_list_lock);
+}
+
+static void ioreq_pause(void)
+{
+	/* Flush and disable the tasklet to ensure no I/O requests pending */
+	tasklet_disable(&ioreq_tasklet);
+}
+
+static void ioreq_resume(void)
+{
+	/* Schedule once after enabling in case other clients miss a tasklet */
+	tasklet_enable(&ioreq_tasklet);
+	tasklet_schedule(&ioreq_tasklet);
+}
+
+static void ioreq_intr_handler(void)
+{
+	tasklet_schedule(&ioreq_tasklet);
+}
+
+void acrn_ioreq_intr_setup(void)
+{
+	acrn_setup_intr_handler(ioreq_intr_handler);
+	tasklet_init(&ioreq_tasklet, ioreq_tasklet_handler, 0);
+}
+
+void acrn_ioreq_intr_remove(void)
+{
+	acrn_remove_intr_handler();
+}
+
+int acrn_ioreq_init(struct acrn_vm *vm, u64 buf_vma)
+{
+	struct acrn_ioreq_buffer *set_buffer;
+	struct page *page;
+	int ret;
+
+	if (vm->ioreq_buf)
+		return -EEXIST;
+
+	set_buffer = kzalloc(sizeof(*set_buffer), GFP_KERNEL);
+	if (!set_buffer)
+		return -ENOMEM;
+
+	ret = get_user_pages_fast(buf_vma, 1, FOLL_WRITE, &page);
+	if (unlikely(ret != 1) || !page) {
+		dev_err(vm->dev, "Failed to pin ioreq page!\n");
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	vm->ioreq_buf = page_address(page);
+	vm->ioreq_page = page;
+	set_buffer->ioreq_buf = page_to_phys(page);
+	ret = hcall_set_ioreq_buffer(vm->vmid, virt_to_phys(set_buffer));
+	if (ret < 0) {
+		dev_err(vm->dev, "Failed to init ioreq buffer!\n");
+		put_page(page);
+		vm->ioreq_buf = NULL;
+		goto free_buf;
+	}
+
+	dev_dbg(vm->dev, "Init ioreq buffer %pK!\n", vm->ioreq_buf);
+	ret = 0;
+free_buf:
+	kfree(set_buffer);
+	return ret;
+}
+
+void acrn_ioreq_deinit(struct acrn_vm *vm)
+{
+	struct acrn_ioreq_client *client, *next;
+
+	dev_dbg(vm->dev, "Deinit ioreq buffer %pK!\n", vm->ioreq_buf);
+	/* Destroy all clients belonging to this VM */
+	list_for_each_entry_safe(client, next, &vm->ioreq_clients, list)
+		acrn_ioreq_client_destroy(client);
+	if (vm->default_client)
+		acrn_ioreq_client_destroy(vm->default_client);
+
+	if (vm->ioreq_buf && vm->ioreq_page) {
+		put_page(vm->ioreq_page);
+		vm->ioreq_buf = NULL;
+	}
+}
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 044c0615bd87..12bd5de0a676 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -34,9 +34,17 @@ struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
 	}
 
 	mutex_init(&vm->regions_mapping_lock);
+	INIT_LIST_HEAD(&vm->ioreq_clients);
+	spin_lock_init(&vm->ioreq_clients_lock);
 	vm->vmid = vm_param->vmid;
 	vm->vcpu_num = vm_param->vcpu_num;
 
+	if (acrn_ioreq_init(vm, vm_param->ioreq_buf) < 0) {
+		hcall_destroy_vm(vm_param->vmid);
+		vm->vmid = ACRN_INVALID_VMID;
+		return NULL;
+	}
+
 	write_lock_bh(&acrn_vm_list_lock);
 	list_add(&vm->list, &acrn_vm_list);
 	write_unlock_bh(&acrn_vm_list_lock);
@@ -58,6 +66,8 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	list_del_init(&vm->list);
 	write_unlock_bh(&acrn_vm_list_lock);
 
+	acrn_ioreq_deinit(vm);
+
 	ret = hcall_destroy_vm(vm->vmid);
 	if (ret < 0) {
 		dev_err(vm->dev, "Failed to destroy VM %u\n", vm->vmid);
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 33bbdd6d3956..8eb687f1482c 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -11,6 +11,129 @@
 
 #include <linux/types.h>
 
+#define ACRN_IO_REQUEST_MAX		16
+
+#define ACRN_IOREQ_STATE_PENDING	0
+#define ACRN_IOREQ_STATE_COMPLETE	1
+#define ACRN_IOREQ_STATE_PROCESSING	2
+#define ACRN_IOREQ_STATE_FREE		3
+
+#define ACRN_IOREQ_TYPE_PORTIO		0
+#define ACRN_IOREQ_TYPE_MMIO		1
+
+#define ACRN_IOREQ_DIR_READ		0
+#define ACRN_IOREQ_DIR_WRITE		1
+
+struct acrn_mmio_request {
+	__u32	direction;
+	__u32	reserved;
+	__u64	address;
+	__u64	size;
+	__u64	value;
+} __attribute__((aligned(8)));
+
+struct acrn_pio_request {
+	__u32	direction;
+	__u32	reserved;
+	__u64	address;
+	__u64	size;
+	__u32	value;
+} __attribute__((aligned(8)));
+
+/**
+ * struct acrn_io_request - 256-byte ACRN I/O request
+ * @type:		Type of this request (ACRN_IOREQ_TYPE_*).
+ * @completion_polling:	Polling flag. Hypervisor will poll completion of the
+ *			I/O request if this flag set.
+ * @reserved0:		Reserved fields.
+ * @reqs:		Union of different types of request. Byte offset: 64.
+ * @reqs.pio_request:	PIO request data of the I/O request.
+ * @reqs.mmio_request:	MMIO request data of the I/O request.
+ * @reqs.data:		Raw data of the I/O request.
+ * @reserved1:		Reserved fields.
+ * @kernel_handled:	Flag indicates this request need be handled in kernel.
+ * @processed:		The status of this request (ACRN_IOREQ_STATE_*).
+ *
+ * The state transitions of ACRN I/O request:
+ *
+ *    FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...
+ *
+ * An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM and
+ * ACRN userspace are in charge of processing the others.
+ *
+ * On basis of the states illustrated above, a typical lifecycle of ACRN IO
+ * request would look like:
+ *
+ * Flow                 (assume the initial state is FREE)
+ * |
+ * |   Service VM vCPU 0     Service VM vCPU x      User vCPU y
+ * |
+ * |                                             hypervisor:
+ * |                                               fills in type, addr, etc.
+ * |                                               pauses the User VM vCPU y
+ * |                                               sets the state to PENDING (a)
+ * |                                               fires an upcall to Service VM
+ * |
+ * | HSM:
+ * |  scans for PENDING requests
+ * |  sets the states to PROCESSING (b)
+ * |  assigns the requests to clients (c)
+ * V
+ * |                     client:
+ * |                       scans for the assigned requests
+ * |                       handles the requests (d)
+ * |                     HSM:
+ * |                       sets states to COMPLETE
+ * |                       notifies the hypervisor
+ * |
+ * |                     hypervisor:
+ * |                       resumes User VM vCPU y (e)
+ * |
+ * |                                             hypervisor:
+ * |                                               post handling (f)
+ * V                                               sets states to FREE
+ *
+ * Note that the procedures (a) to (f) in the illustration above require to be
+ * strictly processed in the order.  One vCPU cannot trigger another request of
+ * I/O emulation before completing the previous one.
+ *
+ * Atomic and barriers are required when HSM and hypervisor accessing the state
+ * of &struct acrn_io_request.
+ *
+ */
+struct acrn_io_request {
+	__u32	type;
+	__u32	completion_polling;
+	__u32	reserved0[14];
+	union {
+		struct acrn_pio_request		pio_request;
+		struct acrn_mmio_request	mmio_request;
+		__u64				data[8];
+	} reqs;
+	__u32	reserved1;
+	__u32	kernel_handled;
+	__u32	processed;
+} __attribute__((aligned(256)));
+
+struct acrn_io_request_buffer {
+	union {
+		struct acrn_io_request	req_slot[ACRN_IO_REQUEST_MAX];
+		__u8			reserved[4096];
+	};
+};
+
+/**
+ * struct acrn_ioreq_notify - The structure of ioreq completion notification
+ * @vmid:	User VM ID
+ * @reserved:	Reserved
+ * @vcpu:	vCPU ID
+ */
+struct acrn_ioreq_notify {
+	__u16	vmid;
+	__u16	reserved;
+	__u32	vcpu;
+} __attribute__((aligned(8)));
+
 /**
  * struct acrn_vm_creation - Info to create a User VM
  * @vmid:		User VM ID returned from the hypervisor
@@ -170,6 +293,17 @@ struct acrn_vm_memmap {
 #define ACRN_IOCTL_SET_VCPU_REGS	\
 	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
+#define ACRN_IOCTL_NOTIFY_REQUEST_FINISH \
+	_IOW(ACRN_IOCTL_TYPE, 0x31, struct acrn_ioreq_notify)
+#define ACRN_IOCTL_CREATE_IOREQ_CLIENT	\
+	_IO(ACRN_IOCTL_TYPE, 0x32)
+#define ACRN_IOCTL_ATTACH_IOREQ_CLIENT	\
+	_IO(ACRN_IOCTL_TYPE, 0x33)
+#define ACRN_IOCTL_DESTROY_IOREQ_CLIENT	\
+	_IO(ACRN_IOCTL_TYPE, 0x34)
+#define ACRN_IOCTL_CLEAR_VM_IOREQ	\
+	_IO(ACRN_IOCTL_TYPE, 0x35)
+
 #define ACRN_IOCTL_SET_MEMSEG		\
 	_IOW(ACRN_IOCTL_TYPE, 0x41, struct acrn_vm_memmap)
 #define ACRN_IOCTL_UNSET_MEMSEG		\
-- 
2.28.0

