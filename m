Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3899C21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgIIJKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:10:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:39827 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgIIJJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:09:57 -0400
IronPort-SDR: 9KIgYO1YZUL9V/3Dnw/WI/8BsEPxQQSjd0UrCmyZ1k18kYDTYyATeMiymsOX0pNX2msrwbddiv
 0swGftFEI7xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155773882"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155773882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:09:57 -0700
IronPort-SDR: AIKQceBR2EhJepIfUFI7LfYUW7cJuWqkQ1ds5vZz9CKkdowgX+Ztilz22ILbkPsGdPHngaJ7hs
 OdnPSckiYPmQ==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="505390989"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:09:52 -0700
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
Subject: [PATCH v3 06/17] virt: acrn: Introduce VM management interfaces
Date:   Wed,  9 Sep 2020 17:08:25 +0800
Message-Id: <20200909090836.46762-7-shuo.a.liu@intel.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 MAINTAINERS                                   |  1 +
 drivers/virt/acrn/Makefile                    |  2 +-
 drivers/virt/acrn/acrn_drv.h                  | 22 +++++-
 drivers/virt/acrn/hsm.c                       | 66 ++++++++++++++++
 drivers/virt/acrn/hypercall.h                 | 78 +++++++++++++++++++
 drivers/virt/acrn/vm.c                        | 69 ++++++++++++++++
 include/uapi/linux/acrn.h                     | 56 +++++++++++++
 8 files changed, 293 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/acrn/hypercall.h
 create mode 100644 drivers/virt/acrn/vm.c
 create mode 100644 include/uapi/linux/acrn.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2a198838fca9..ac60efedb104 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -319,6 +319,7 @@ Code  Seq#    Include File                                           Comments
 0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
                                                                      <mailto:kenji@bitgate.com>
 0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
+0xA2  all    uapi/linux/acrn.h                                       ACRN hypervisor
 0xA3  80-8F                                                          Port ACL  in development:
                                                                      <mailto:tlewis@mindspring.com>
 0xA3  90-9F  linux/dtlk.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 3030d0e93d02..d4c1ef303c2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -443,6 +443,7 @@ S:	Supported
 W:	https://projectacrn.org
 F:	Documentation/virt/acrn/
 F:	drivers/virt/acrn/
+F:	include/uapi/linux/acrn.h
 
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
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
index 29eedd696327..043ae6840995 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -3,16 +3,36 @@
 #ifndef __ACRN_HSM_DRV_H
 #define __ACRN_HSM_DRV_H
 
+#include <linux/acrn.h>
+#include <linux/dev_printk.h>
 #include <linux/types.h>
 
+#include "hypercall.h"
+
 #define ACRN_INVALID_VMID (0xffffU)
 
+#define ACRN_VM_FLAG_DESTROYED		0U
+extern struct list_head acrn_vm_list;
+extern rwlock_t acrn_vm_list_lock;
 /**
  * struct acrn_vm - Properties of ACRN User VM.
+ * @dev:	The struct device this VM belongs to
+ * @list:	Entry within global list of all VMs
  * @vmid:	User VM ID
+ * @vcpu_num:	Number of virtual CPUs in the VM
+ * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
+ *		in HSM which is different from the &acrn_vm_creation.vm_flag.
  */
 struct acrn_vm {
-	u16	vmid;
+	struct device		*dev;
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
index 28a3052ffa55..bc85a3c14f87 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -19,6 +19,8 @@
 
 #include "acrn_drv.h"
 
+static struct miscdevice acrn_dev;
+
 /*
  * When /dev/acrn_hsm is opened, a 'struct acrn_vm' object is created to
  * represent a VM instance and continues to be associated with the opened file
@@ -34,14 +36,77 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
 		return -ENOMEM;
 
 	vm->vmid = ACRN_INVALID_VMID;
+	vm->dev = get_device(acrn_dev.this_device);
 	filp->private_data = vm;
 	return 0;
 }
 
+static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long ioctl_param)
+{
+	struct acrn_vm *vm = filp->private_data;
+	struct acrn_vm_creation *vm_param;
+	int ret = 0;
+
+	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
+		dev_err(vm->dev, "ioctl 0x%x: Invalid VM state!\n", cmd);
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
+			dev_err(vm->dev, "Failed to start VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_PAUSE_VM:
+		ret = hcall_pause_vm(vm->vmid);
+		if (ret < 0)
+			dev_err(vm->dev, "Failed to pause VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_RESET_VM:
+		ret = hcall_reset_vm(vm->vmid);
+		if (ret < 0)
+			dev_err(vm->dev, "Failed to restart VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_DESTROY_VM:
+		ret = acrn_vm_destroy(vm);
+		break;
+	default:
+		dev_warn(vm->dev, "Unknown IOCTL 0x%x!\n", cmd);
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
 static int acrn_dev_release(struct inode *inode, struct file *filp)
 {
 	struct acrn_vm *vm = filp->private_data;
 
+	acrn_vm_destroy(vm);
+	put_device(vm->dev);
 	kfree(vm);
 	return 0;
 }
@@ -50,6 +115,7 @@ static const struct file_operations acrn_fops = {
 	.owner		= THIS_MODULE,
 	.open		= acrn_dev_open,
 	.release	= acrn_dev_release,
+	.unlocked_ioctl = acrn_dev_ioctl,
 };
 
 static struct miscdevice acrn_dev = {
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
new file mode 100644
index 000000000000..426b66cadb1f
--- /dev/null
+++ b/drivers/virt/acrn/hypercall.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ACRN HSM: hypercalls of ACRN Hypervisor
+ */
+#ifndef __ACRN_HSM_HYPERCALL_H
+#define __ACRN_HSM_HYPERCALL_H
+#include <asm/acrn.h>
+
+/*
+ * Hypercall IDs of the ACRN Hypervisor
+ */
+#define _HC_ID(x, y) (((x) << 24) | (y))
+
+#define HC_ID 0x80UL
+
+#define HC_ID_VM_BASE			0x10UL
+#define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
+#define HC_DESTROY_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x01)
+#define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
+#define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
+#define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
+
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
+#endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
new file mode 100644
index 000000000000..851a9481a78e
--- /dev/null
+++ b/drivers/virt/acrn/vm.c
@@ -0,0 +1,69 @@
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
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include "acrn_drv.h"
+
+/* List of VMs */
+LIST_HEAD(acrn_vm_list);
+/*
+ * acrn_vm_list is read in a tasklet which dispatch I/O requests and is wrote
+ * in VM creation ioctl. Use the rwlock mechanism to protect it.
+ */
+DEFINE_RWLOCK(acrn_vm_list_lock);
+
+struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
+			       struct acrn_vm_creation *vm_param)
+{
+	int ret;
+
+	ret = hcall_create_vm(virt_to_phys(vm_param));
+	if (ret < 0 || vm_param->vmid == ACRN_INVALID_VMID) {
+		dev_err(vm->dev, "Failed to create VM! Error: %d\n", ret);
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
+	dev_dbg(vm->dev, "VM %u created.\n", vm->vmid);
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
+		dev_err(vm->dev, "Failed to destroy VM %u\n", vm->vmid);
+		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
+		return ret;
+	}
+	dev_dbg(vm->dev, "VM %u destroyed.\n", vm->vmid);
+	vm->vmid = ACRN_INVALID_VMID;
+	return 0;
+}
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
new file mode 100644
index 000000000000..364b1a783074
--- /dev/null
+++ b/include/uapi/linux/acrn.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
+ *
+ * This file can be used by applications that need to communicate with the HSM
+ * via the ioctl interface.
+ */
+
+#ifndef _UAPI_ACRN_H
+#define _UAPI_ACRN_H
+
+#include <linux/types.h>
+
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
+/* The ioctl type, documented in ioctl-number.rst */
+#define ACRN_IOCTL_TYPE			0xA2
+
+/*
+ * Common IOCTL IDs definition for ACRN userspace
+ */
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
+#endif /* _UAPI_ACRN_H */
-- 
2.28.0

