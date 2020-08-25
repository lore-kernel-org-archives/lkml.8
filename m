Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C814C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDDC204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgHYCvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:37715 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgHYCvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:51:00 -0400
IronPort-SDR: GI5vcM439KOnELr3mo9YAm+195yQDfgpRjNCx7IDmVqTVuPnVckXlErcPXBEQ8HV5Ti0LEVOmu
 R1eydwE4KZGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690772"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:50:58 -0700
IronPort-SDR: Ne/yhkWhF9PXyK27uch095JHY1gk9VCwCujOOxxHndUTcOBox1HdR+Mijj1g9jqnJn+gWzv4Bq
 ZMwkG3CRdREw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409768"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:50:55 -0700
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
Subject: [PATCH 06/17] virt: acrn: Introduce VM management interfaces
Date:   Tue, 25 Aug 2020 10:45:06 +0800
Message-Id: <20200825024516.16766-7-shuo.a.liu@intel.com>
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

The VM management interfaces expose several VM operations to ACRN
userspace via ioctls. For example, creating VM, starting VM, destroying
VM and so on.

The ACRN Hypervisor needs to exchange data with the ACRN userspace
during the VM operations. HSM provides VM operation ioctls to the ACRN
userspace and communicates with the ACRN Hypervisor for VM operations
via hypercalls.

HSM maintains a list of User VM. Each User VM will be bound to an
existing file descriptor of /dev/acrn_hsm. The User VM will be
destroyed when the file descriptor is closed.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/virt/acrn/Makefile    |  2 +-
 drivers/virt/acrn/acrn_drv.h  | 16 ++++++++-
 drivers/virt/acrn/hsm.c       | 58 +++++++++++++++++++++++++++++-
 drivers/virt/acrn/hypercall.h | 62 ++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c        | 66 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/acrn.h     | 36 +++++++++++++++++++
 6 files changed, 237 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virt/acrn/vm.c

diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
index 6920ed798aaf..cf8b4ed5e74e 100644
--- a/drivers/virt/acrn/Makefile
+++ b/drivers/virt/acrn/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
-acrn-y := hsm.o
+acrn-y := hsm.o vm.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 36f43d8d43d0..35fcb5cbbff3 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -10,12 +10,26 @@
 
 #define ACRN_INVALID_VMID (0xffffU)
 
+#define ACRN_VM_FLAG_DESTROYED		0U
+extern struct list_head acrn_vm_list;
+extern rwlock_t acrn_vm_list_lock;
 /**
  * struct acrn_vm - Properties of ACRN User VM.
+ * @list:	Entry within global list of all VMs
  * @vmid:	User VM ID
+ * @vcpu_num:	Number of virtual CPUs in the VM
+ * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
+ *		in HSM which is different from the &acrn_vm_creation.vm_flag.
  */
 struct acrn_vm {
-	u16	vmid;
+	struct list_head	list;
+	u16			vmid;
+	int			vcpu_num;
+	unsigned long		flags;
 };
 
+struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
+			       struct acrn_vm_creation *vm_param);
+int acrn_vm_destroy(struct acrn_vm *vm);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index a08169f35c96..ed8921a6c68b 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -45,19 +45,75 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
 static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 			   unsigned long ioctl_param)
 {
+	struct acrn_vm *vm = filp->private_data;
+	struct acrn_vm_creation *vm_param;
+	int ret = 0;
+
 	if (cmd == ACRN_IOCTL_GET_API_VERSION) {
 		if (copy_to_user((void __user *)ioctl_param,
 				 &api_version, sizeof(api_version)))
 			return -EFAULT;
+		return 0;
 	}
 
-	return 0;
+	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
+		pr_err("ioctl 0x%x: Invalid VM state!\n", cmd);
+		return -EFAULT;
+	}
+
+	switch (cmd) {
+	case ACRN_IOCTL_CREATE_VM:
+		vm_param = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_vm_creation));
+		if (IS_ERR(vm_param))
+			return PTR_ERR(vm_param);
+
+		vm = acrn_vm_create(vm, vm_param);
+		if (!vm) {
+			ret = -EFAULT;
+			kfree(vm_param);
+			break;
+		}
+
+		if (copy_to_user((void __user *)ioctl_param, vm_param,
+				 sizeof(struct acrn_vm_creation))) {
+			acrn_vm_destroy(vm);
+			ret = -EFAULT;
+		}
+
+		kfree(vm_param);
+		break;
+	case ACRN_IOCTL_START_VM:
+		ret = hcall_start_vm(vm->vmid);
+		if (ret < 0)
+			pr_err("Failed to start VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_PAUSE_VM:
+		ret = hcall_pause_vm(vm->vmid);
+		if (ret < 0)
+			pr_err("Failed to pause VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_RESET_VM:
+		ret = hcall_reset_vm(vm->vmid);
+		if (ret < 0)
+			pr_err("Failed to restart VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_DESTROY_VM:
+		ret = acrn_vm_destroy(vm);
+		break;
+	default:
+		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
+		ret = -EINVAL;
+	}
+
+	return ret;
 }
 
 static int acrn_dev_release(struct inode *inode, struct file *filp)
 {
 	struct acrn_vm *vm = filp->private_data;
 
+	acrn_vm_destroy(vm);
 	kfree(vm);
 	return 0;
 }
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index 3ad1b708e162..6429e7a06e7e 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -16,6 +16,13 @@
 #define HC_ID_GEN_BASE			0x0UL
 #define HC_GET_API_VERSION		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x00)
 
+#define HC_ID_VM_BASE			0x10UL
+#define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
+#define HC_DESTROY_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x01)
+#define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
+#define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
+#define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
+
 /**
  * hcall_get_api_version() - Get API version from hypervisor
  * @api_version:	Service VM GPA of version info
@@ -27,4 +34,59 @@ static inline long hcall_get_api_version(u64 api_version)
 	return acrn_hypercall1(HC_GET_API_VERSION, api_version);
 }
 
+/**
+ * hcall_create_vm() - Create a User VM
+ * @vminfo:	Service VM GPA of info of User VM creation
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_create_vm(u64 vminfo)
+{
+	return acrn_hypercall1(HC_CREATE_VM, vminfo);
+}
+
+/**
+ * hcall_start_vm() - Start a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_start_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_START_VM, vmid);
+}
+
+/**
+ * hcall_pause_vm() - Pause a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_pause_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_PAUSE_VM, vmid);
+}
+
+/**
+ * hcall_destroy_vm() - Destroy a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_destroy_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_DESTROY_VM, vmid);
+}
+
+/**
+ * hcall_reset_vm() - Reset a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_reset_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_RESET_VM, vmid);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
new file mode 100644
index 000000000000..14e615bc2b8d
--- /dev/null
+++ b/drivers/virt/acrn/vm.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN_HSM: Virtual Machine management
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Jason Chen CJ <jason.cj.chen@intel.com>
+ *	Yakui Zhao <yakui.zhao@intel.com>
+ */
+#define pr_fmt(fmt) "acrn: " fmt
+
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include "acrn_drv.h"
+
+LIST_HEAD(acrn_vm_list);
+DEFINE_RWLOCK(acrn_vm_list_lock);
+
+struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
+			       struct acrn_vm_creation *vm_param)
+{
+	int ret;
+
+	ret = hcall_create_vm(virt_to_phys(vm_param));
+	if (ret < 0 || vm_param->vmid == ACRN_INVALID_VMID) {
+		pr_err("Failed to create VM! Error: %d\n", ret);
+		return NULL;
+	}
+
+	vm->vmid = vm_param->vmid;
+	vm->vcpu_num = vm_param->vcpu_num;
+
+	write_lock_bh(&acrn_vm_list_lock);
+	list_add(&vm->list, &acrn_vm_list);
+	write_unlock_bh(&acrn_vm_list_lock);
+
+	pr_debug("VM %u created.\n", vm->vmid);
+	return vm;
+}
+
+int acrn_vm_destroy(struct acrn_vm *vm)
+{
+	int ret;
+
+	if (vm->vmid == ACRN_INVALID_VMID ||
+	    test_and_set_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags))
+		return 0;
+
+	/* Remove from global VM list */
+	write_lock_bh(&acrn_vm_list_lock);
+	list_del_init(&vm->list);
+	write_unlock_bh(&acrn_vm_list_lock);
+
+	ret = hcall_destroy_vm(vm->vmid);
+	if (ret < 0) {
+		pr_err("Failed to destroy VM %u\n", vm->vmid);
+		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
+		return ret;
+	}
+	pr_debug("VM %u destroyed.\n", vm->vmid);
+	vm->vmid = ACRN_INVALID_VMID;
+	return 0;
+}
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index c59488ad7252..f8f00b18cd46 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -21,6 +21,31 @@ struct acrn_api_version {
 	__u32	minor_version;
 } __attribute__((aligned(8)));
 
+/**
+ * struct acrn_vm_creation - Info to create a User VM
+ * @vmid:		User VM ID returned from the hypervisor
+ * @reserved0:		Reserved
+ * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
+ * @reserved1:		Reserved
+ * @uuid:		UUID of the VM. Pass to hypervisor directly.
+ * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
+ * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
+ *			hypervisor directly.
+ * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
+ * @reserved2:		Reserved
+ */
+struct acrn_vm_creation {
+	__u16	vmid;
+	__u16	reserved0;
+	__u16	vcpu_num;
+	__u16	reserved1;
+	__u8	uuid[16];
+	__u64	vm_flag;
+	__u64	ioreq_buf;
+	__u64	cpu_affinity;
+	__u8	reserved2[8];
+} __attribute__((aligned(8)));
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -30,4 +55,15 @@ struct acrn_api_version {
 #define ACRN_IOCTL_GET_API_VERSION	\
 	_IOR(ACRN_IOCTL_TYPE, 0, struct acrn_api_version)
 
+#define ACRN_IOCTL_CREATE_VM		\
+	_IOWR(ACRN_IOCTL_TYPE, 0x10, struct acrn_vm_creation)
+#define ACRN_IOCTL_DESTROY_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x11)
+#define ACRN_IOCTL_START_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x12)
+#define ACRN_IOCTL_PAUSE_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x13)
+#define ACRN_IOCTL_RESET_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x15)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

