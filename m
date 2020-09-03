Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83196C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418F7208B3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgICNw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:52:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:15104 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgICMpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:45:39 -0400
IronPort-SDR: Rx+/UWDoKPHeY0TAu0Aeo4rhQAtVAzofImcABsK9f+j7aF166LyI5ponkizYnF3KMD1/KoOddS
 f+qc+Kk1aPgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="158549420"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="158549420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:43:04 -0700
IronPort-SDR: ZfzNtVEx4tsdoP10yNbBE9nGFOWZqICt0zGWVCoD3GiDxlp930hc4jVaYQjO0bmxyy2Y9paPdj
 3HVR3pASlQ+g==
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="341787050"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:42:58 -0700
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
Subject: [PATCH v2 08/17] virt: acrn: Introduce EPT mapping management
Date:   Thu,  3 Sep 2020 20:41:52 +0800
Message-Id: <20200903124201.17275-9-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903124201.17275-1-shuo.a.liu@intel.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

The HSM provides hypervisor services to the ACRN userspace. While
launching a User VM, ACRN userspace needs to allocate memory and request
the ACRN Hypervisor to set up the EPT mapping for the VM.

A mapping cache is introduced for accelerating the translation between
the Service VM kernel virtual address and User VM physical address.

From the perspective of the hypervisor, the types of GPA of User VM can be
listed as following:
   1) RAM region, which is used by User VM as system ram.
   2) MMIO region, which is recognized by User VM as MMIO. MMIO region is
      used to be utilized for devices emulation.

Generally, User VM RAM regions mapping is set up before VM started and
is released in the User VM destruction. MMIO regions mapping may be set
and unset dynamically during User VM running.

To achieve this, ioctls ACRN_IOCTL_SET_MEMSEG and ACRN_IOCTL_UNSET_MEMSEG
are introduced in HSM.

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
 drivers/virt/acrn/acrn_drv.h  | 102 ++++++++++--
 drivers/virt/acrn/hsm.c       |  15 ++
 drivers/virt/acrn/hypercall.h |  14 ++
 drivers/virt/acrn/mm.c        | 303 ++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c        |   4 +
 include/uapi/linux/acrn.h     |  51 ++++++
 7 files changed, 479 insertions(+), 12 deletions(-)
 create mode 100644 drivers/virt/acrn/mm.c

diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
index cf8b4ed5e74e..38bc44b6edcd 100644
--- a/drivers/virt/acrn/Makefile
+++ b/drivers/virt/acrn/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
-acrn-y := hsm.o vm.o
+acrn-y := hsm.o vm.o mm.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 043ae6840995..134914261e71 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -9,6 +9,71 @@
 
 #include "hypercall.h"
 
+#define ACRN_MEM_MAPPING_MAX	256
+
+#define ACRN_MEM_REGION_ADD	0
+#define ACRN_MEM_REGION_DEL	2
+/**
+ * struct vm_memory_region_op - Hypervisor memory operation
+ * @type:		Operation type (ACRN_MEM_REGION_*)
+ * @attr:		Memory attribute (ACRN_MEM_TYPE_* | ACRN_MEM_ACCESS_*)
+ * @user_vm_pa:		Physical address of User VM to be mapped.
+ * @service_vm_pa:	Physical address of Service VM to be mapped.
+ * @size:		Size of this region.
+ *
+ * Structure containing needed information that is provided to ACRN Hypervisor
+ * to manage the EPT mappings of a single memory region of the User VM. Several
+ * &struct vm_memory_region_op can be batched to ACRN Hypervisor, see &struct
+ * vm_memory_region_batch.
+ */
+struct vm_memory_region_op {
+	u32	type;
+	u32	attr;
+	u64	user_vm_pa;
+	u64	service_vm_pa;
+	u64	size;
+};
+
+/**
+ * struct vm_memory_region_batch - A batch of vm_memory_region_op.
+ * @vmid:		A User VM ID.
+ * @reserved:		Reserved.
+ * @regions_num:	The number of vm_memory_region_op.
+ * @reserved1:		Reserved.
+ * @regions_gpa:	Physical address of a vm_memory_region_op array.
+ *
+ * HC_VM_SET_MEMORY_REGIONS uses this structure to manage EPT mappings of
+ * multiple memory regions of a User VM. A &struct vm_memory_region_batch
+ * contains multiple &struct vm_memory_region_op for batch processing in the
+ * ACRN Hypervisor.
+ */
+struct vm_memory_region_batch {
+	u16	vmid;
+	u16	reserved[3];
+	u32	regions_num;
+	u32	reserved1;
+	u64	regions_gpa;
+};
+
+/**
+ * struct vm_memory_mapping - Memory map between a User VM and the Service VM
+ * @pages:		Pages in Service VM kernel.
+ * @npages:		Number of pages.
+ * @service_vm_va:	Virtual address in Service VM kernel.
+ * @user_vm_pa:		Physical address in User VM.
+ * @size:		Size of this memory region.
+ *
+ * HSM maintains memory mappings between a User VM GPA and the Service VM
+ * kernel VA for accelerating the User VM GPA translation.
+ */
+struct vm_memory_mapping {
+	struct page	**pages;
+	int		npages;
+	void		*service_vm_va;
+	u64		user_vm_pa;
+	size_t		size;
+};
+
 #define ACRN_INVALID_VMID (0xffffU)
 
 #define ACRN_VM_FLAG_DESTROYED		0U
@@ -16,23 +81,38 @@ extern struct list_head acrn_vm_list;
 extern rwlock_t acrn_vm_list_lock;
 /**
  * struct acrn_vm - Properties of ACRN User VM.
- * @dev:	The struct device this VM belongs to
- * @list:	Entry within global list of all VMs
- * @vmid:	User VM ID
- * @vcpu_num:	Number of virtual CPUs in the VM
- * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
- *		in HSM which is different from the &acrn_vm_creation.vm_flag.
+ * @dev:			The struct device this VM belongs to
+ * @list:			Entry within global list of all VMs.
+ * @vmid:			User VM ID.
+ * @vcpu_num:			Number of virtual CPUs in the VM.
+ * @flags:			Flags (ACRN_VM_FLAG_*) of the VM. This is VM
+ *				flag management in HSM which is different
+ *				from the &acrn_vm_creation.vm_flag.
+ * @regions_mapping_lock:	Lock to protect &acrn_vm.regions_mapping and
+ *				&acrn_vm.regions_mapping_count.
+ * @regions_mapping:		Memory mappings of this VM.
+ * @regions_mapping_count:	Number of memory mapping of this VM.
  */
 struct acrn_vm {
-	struct device		*dev;
-	struct list_head	list;
-	u16			vmid;
-	int			vcpu_num;
-	unsigned long		flags;
+	struct device			*dev;
+	struct list_head		list;
+	u16				vmid;
+	int				vcpu_num;
+	unsigned long			flags;
+	struct mutex			regions_mapping_lock;
+	struct vm_memory_mapping	regions_mapping[ACRN_MEM_MAPPING_MAX];
+	int				regions_mapping_count;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
 			       struct acrn_vm_creation *vm_param);
 int acrn_vm_destroy(struct acrn_vm *vm);
+int acrn_mm_region_add(struct acrn_vm *vm, u64 user_gpa, u64 service_gpa,
+		       u64 size, u32 mem_type, u32 mem_access_right);
+int acrn_mm_region_del(struct acrn_vm *vm, u64 user_gpa, u64 size);
+int acrn_vm_memseg_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap);
+int acrn_vm_memseg_unmap(struct acrn_vm *vm, struct acrn_vm_memmap *memmap);
+int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap);
+void acrn_vm_all_ram_unmap(struct acrn_vm *vm);
 
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 13df76d0206e..3a1cac02ad9f 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -51,6 +51,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vm *vm = filp->private_data;
 	struct acrn_vm_creation *vm_param;
 	struct acrn_vcpu_regs *cpu_regs;
+	struct acrn_vm_memmap memmap;
 	int ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
@@ -110,6 +111,20 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 				vm->vmid);
 		kfree(cpu_regs);
 		break;
+	case ACRN_IOCTL_SET_MEMSEG:
+		if (copy_from_user(&memmap, (void __user *)ioctl_param,
+				   sizeof(memmap)))
+			return -EFAULT;
+
+		ret = acrn_vm_memseg_map(vm, &memmap);
+		break;
+	case ACRN_IOCTL_UNSET_MEMSEG:
+		if (copy_from_user(&memmap, (void __user *)ioctl_param,
+				   sizeof(memmap)))
+			return -EFAULT;
+
+		ret = acrn_vm_memseg_unmap(vm, &memmap);
+		break;
 	default:
 		dev_warn(dev, "Unknown IOCTL 0x%x!\n", cmd);
 		ret = -ENOTTY;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index f29cfae08862..a1a70a071713 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -21,6 +21,9 @@
 #define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
 #define HC_SET_VCPU_REGS		_HC_ID(HC_ID, HC_ID_VM_BASE + 0x06)
 
+#define HC_ID_MEM_BASE			0x40UL
+#define HC_VM_SET_MEMORY_REGIONS	_HC_ID(HC_ID, HC_ID_MEM_BASE + 0x02)
+
 /**
  * hcall_create_vm() - Create a User VM
  * @vminfo:	Service VM GPA of info of User VM creation
@@ -88,4 +91,15 @@ static inline long hcall_set_vcpu_regs(u64 vmid, u64 regs_state)
 	return acrn_hypercall2(HC_SET_VCPU_REGS, vmid, regs_state);
 }
 
+/**
+ * hcall_set_memory_regions() - Inform the hypervisor to set up EPT mappings
+ * @regions_pa:	Service VM GPA of &struct vm_memory_region_batch
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_memory_regions(u64 regions_pa)
+{
+	return acrn_hypercall1(HC_VM_SET_MEMORY_REGIONS, regions_pa);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
new file mode 100644
index 000000000000..c248ca554860
--- /dev/null
+++ b/drivers/virt/acrn/mm.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN: Memory mapping management
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Fei Li <lei1.li@intel.com>
+ *	Shuo Liu <shuo.a.liu@intel.com>
+ */
+
+#define pr_fmt(fmt) "acrn: " fmt
+#define dev_fmt(fmt) "acrn: " fmt
+
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include "acrn_drv.h"
+
+static int modify_region(struct acrn_vm *vm, struct vm_memory_region_op *region)
+{
+	struct vm_memory_region_batch *regions;
+	int ret;
+
+	regions = kzalloc(sizeof(*regions), GFP_KERNEL);
+	if (!regions)
+		return -ENOMEM;
+
+	regions->vmid = vm->vmid;
+	regions->regions_num = 1;
+	regions->regions_gpa = virt_to_phys(region);
+
+	ret = hcall_set_memory_regions(virt_to_phys(regions));
+	if (ret < 0)
+		dev_err(vm->dev, "Failed to set memory region for VM[%u]!\n",
+			vm->vmid);
+
+	kfree(regions);
+	return ret;
+}
+
+/**
+ * acrn_mm_region_add() - Set up the EPT mapping of a memory region.
+ * @vm:			User VM.
+ * @user_gpa:		A GPA of User VM.
+ * @service_gpa:	A GPA of Service VM.
+ * @size:		Size of the region.
+ * @mem_type:		Combination of ACRN_MEM_TYPE_*.
+ * @mem_access_right:	Combination of ACRN_MEM_ACCESS_*.
+ *
+ * Return: 0 on success, <0 on error.
+ */
+int acrn_mm_region_add(struct acrn_vm *vm, u64 user_gpa, u64 service_gpa,
+		       u64 size, u32 mem_type, u32 mem_access_right)
+{
+	struct vm_memory_region_op *region;
+	int ret = 0;
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->type = ACRN_MEM_REGION_ADD;
+	region->user_vm_pa = user_gpa;
+	region->service_vm_pa = service_gpa;
+	region->size = size;
+	region->attr = ((mem_type & ACRN_MEM_TYPE_MASK) |
+			(mem_access_right & ACRN_MEM_ACCESS_RIGHT_MASK));
+	ret = modify_region(vm, region);
+
+	dev_dbg(vm->dev, "%s: user-GPA[%pK] service-GPA[%pK] size[0x%llx].\n",
+		__func__, (void *)user_gpa, (void *)service_gpa, size);
+	kfree(region);
+	return ret;
+}
+
+/**
+ * acrn_mm_region_del() - Del the EPT mapping of a memory region.
+ * @vm:		User VM.
+ * @user_gpa:	A GPA of the User VM.
+ * @size:	Size of the region.
+ *
+ * Return: 0 on success, <0 for error.
+ */
+int acrn_mm_region_del(struct acrn_vm *vm, u64 user_gpa, u64 size)
+{
+	struct vm_memory_region_op *region;
+	int ret = 0;
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->type = ACRN_MEM_REGION_DEL;
+	region->user_vm_pa = user_gpa;
+	region->service_vm_pa = 0UL;
+	region->size = size;
+	region->attr = 0U;
+
+	ret = modify_region(vm, region);
+
+	dev_dbg(vm->dev, "%s: user-GPA[%pK] size[0x%llx].\n",
+		__func__, (void *)user_gpa, size);
+	kfree(region);
+	return ret;
+}
+
+int acrn_vm_memseg_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
+{
+	int ret;
+
+	if (memmap->type == ACRN_MEMMAP_RAM)
+		return acrn_vm_ram_map(vm, memmap);
+
+	if (memmap->type != ACRN_MEMMAP_MMIO) {
+		dev_err(vm->dev, "Invalid memmap type: %u\n", memmap->type);
+		return -EINVAL;
+	}
+
+	ret = acrn_mm_region_add(vm, memmap->user_vm_pa,
+				 memmap->service_vm_pa, memmap->len,
+				 ACRN_MEM_TYPE_UC, memmap->attr);
+	if (ret < 0)
+		dev_err(vm->dev, "Add memory region failed, VM[%u]!\n",
+			vm->vmid);
+
+	return ret;
+}
+
+int acrn_vm_memseg_unmap(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
+{
+	int ret;
+
+	if (memmap->type != ACRN_MEMMAP_MMIO) {
+		dev_err(vm->dev, "Invalid memmap type: %u\n", memmap->type);
+		return -EINVAL;
+	}
+
+	ret = acrn_mm_region_del(vm, memmap->user_vm_pa, memmap->len);
+	if (ret < 0)
+		dev_err(vm->dev, "Del memory region failed, VM[%u]!\n",
+			vm->vmid);
+
+	return ret;
+}
+
+/**
+ * acrn_vm_ram_map() - Create a RAM EPT mapping of User VM.
+ * @vm:		The User VM pointer
+ * @memmap:	Info of the EPT mapping
+ *
+ * Return: 0 on success, <0 for error.
+ */
+int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
+{
+	struct vm_memory_region_batch *regions_info;
+	int nr_pages, i = 0, order, nr_regions = 0;
+	struct vm_memory_mapping *region_mapping;
+	struct vm_memory_region_op *vm_region;
+	struct page **pages = NULL, *page;
+	void *remap_vaddr;
+	int ret, pinned;
+	u64 user_vm_pa;
+
+	if (!vm || !memmap)
+		return -EINVAL;
+
+	/* Get the page number of the map region */
+	nr_pages = memmap->len >> PAGE_SHIFT;
+	pages = vzalloc(nr_pages * sizeof(struct page *));
+	if (!pages)
+		return -ENOMEM;
+
+	/* Lock the pages of user memory map region */
+	pinned = get_user_pages_fast(memmap->vma_base,
+				     nr_pages, FOLL_WRITE, pages);
+	if (pinned < 0) {
+		ret = pinned;
+		goto free_pages;
+	} else if (pinned != nr_pages) {
+		ret = -EFAULT;
+		goto put_pages;
+	}
+
+	/* Create a kernel map for the map region */
+	remap_vaddr = vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (!remap_vaddr) {
+		ret = -ENOMEM;
+		goto put_pages;
+	}
+
+	/* Record Service VM va <-> User VM pa mapping */
+	mutex_lock(&vm->regions_mapping_lock);
+	region_mapping = &vm->regions_mapping[vm->regions_mapping_count];
+	if (vm->regions_mapping_count < ACRN_MEM_MAPPING_MAX) {
+		region_mapping->pages = pages;
+		region_mapping->npages = nr_pages;
+		region_mapping->size = memmap->len;
+		region_mapping->service_vm_va = remap_vaddr;
+		region_mapping->user_vm_pa = memmap->user_vm_pa;
+		vm->regions_mapping_count++;
+	} else {
+		dev_warn(vm->dev, "Run out of memory mapping slots!\n");
+		ret = -EFAULT;
+		mutex_unlock(&vm->regions_mapping_lock);
+		goto unmap_no_count;
+	}
+	mutex_unlock(&vm->regions_mapping_lock);
+
+	/* Calculate count of vm_memory_region_op */
+	while (i < nr_pages) {
+		page = pages[i];
+		VM_BUG_ON_PAGE(PageTail(page), page);
+		order = compound_order(page);
+		nr_regions++;
+		i += 1 << order;
+	}
+
+	/* Prepare the vm_memory_region_batch */
+	regions_info = kzalloc(sizeof(*regions_info) +
+			       sizeof(*vm_region) * nr_regions,
+			       GFP_KERNEL);
+	if (!regions_info) {
+		ret = -ENOMEM;
+		goto unmap_kernel_map;
+	}
+
+	/* Fill each vm_memory_region_op */
+	vm_region = (struct vm_memory_region_op *)(regions_info + 1);
+	regions_info->vmid = vm->vmid;
+	regions_info->regions_num = nr_regions;
+	regions_info->regions_gpa = virt_to_phys(vm_region);
+	user_vm_pa = memmap->user_vm_pa;
+	i = 0;
+	while (i < nr_pages) {
+		u32 region_size;
+
+		page = pages[i];
+		VM_BUG_ON_PAGE(PageTail(page), page);
+		order = compound_order(page);
+		region_size = PAGE_SIZE << order;
+		vm_region->type = ACRN_MEM_REGION_ADD;
+		vm_region->user_vm_pa = user_vm_pa;
+		vm_region->service_vm_pa = page_to_phys(page);
+		vm_region->size = region_size;
+		vm_region->attr = (ACRN_MEM_TYPE_WB & ACRN_MEM_TYPE_MASK) |
+				  (memmap->attr & ACRN_MEM_ACCESS_RIGHT_MASK);
+
+		vm_region++;
+		user_vm_pa += region_size;
+		i += 1 << order;
+	}
+
+	/* Inform the ACRN Hypervisor to set up EPT mappings */
+	ret = hcall_set_memory_regions(virt_to_phys(regions_info));
+	if (ret < 0) {
+		dev_err(vm->dev, "Failed to set regions, VM[%u]!\n", vm->vmid);
+		goto unset_region;
+	}
+	kfree(regions_info);
+
+	dev_dbg(vm->dev,
+		"%s: VM[%u] service-GVA[%pK] user-GPA[%pK] size[0x%llx]\n",
+		__func__, vm->vmid,
+		remap_vaddr, (void *)memmap->user_vm_pa, memmap->len);
+	return ret;
+
+unset_region:
+	kfree(regions_info);
+unmap_kernel_map:
+	mutex_lock(&vm->regions_mapping_lock);
+	vm->regions_mapping_count--;
+	mutex_unlock(&vm->regions_mapping_lock);
+unmap_no_count:
+	vunmap(remap_vaddr);
+put_pages:
+	for (i = 0; i < pinned; i++)
+		put_page(pages[i]);
+free_pages:
+	vfree(pages);
+	return ret;
+}
+
+/**
+ * acrn_vm_all_ram_unmap() - Destroy a RAM EPT mapping of User VM.
+ * @vm:	The User VM
+ */
+void acrn_vm_all_ram_unmap(struct acrn_vm *vm)
+{
+	struct vm_memory_mapping *region_mapping;
+	int i, j;
+
+	mutex_lock(&vm->regions_mapping_lock);
+	for (i = 0; i < vm->regions_mapping_count; i++) {
+		region_mapping = &vm->regions_mapping[i];
+		vunmap(region_mapping->service_vm_va);
+		for (j = 0; j < region_mapping->npages; j++)
+			put_page(region_mapping->pages[j]);
+		vfree(region_mapping->pages);
+	}
+	mutex_unlock(&vm->regions_mapping_lock);
+}
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 770322904fcc..089627bcc8b4 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -31,6 +31,7 @@ struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
 		return NULL;
 	}
 
+	mutex_init(&vm->regions_mapping_lock);
 	vm->vmid = vm_param->vmid;
 	vm->vcpu_num = vm_param->vcpu_num;
 
@@ -61,6 +62,9 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
 		return ret;
 	}
+
+	acrn_vm_all_ram_unmap(vm);
+
 	dev_dbg(vm->dev, "VM %u destroyed.\n", vm->vmid);
 	vm->vmid = ACRN_INVALID_VMID;
 	return 0;
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 1d5b82e154fb..33bbdd6d3956 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -105,6 +105,52 @@ struct acrn_vcpu_regs {
 	struct acrn_regs	vcpu_regs;
 } __attribute__((aligned(8)));
 
+#define	ACRN_MEM_ACCESS_RIGHT_MASK	0x00000007U
+#define	ACRN_MEM_ACCESS_READ		0x00000001U
+#define	ACRN_MEM_ACCESS_WRITE		0x00000002U
+#define	ACRN_MEM_ACCESS_EXEC		0x00000004U
+#define	ACRN_MEM_ACCESS_RWX		(ACRN_MEM_ACCESS_READ  | \
+					 ACRN_MEM_ACCESS_WRITE | \
+					 ACRN_MEM_ACCESS_EXEC)
+
+#define	ACRN_MEM_TYPE_MASK		0x000007C0U
+#define	ACRN_MEM_TYPE_WB		0x00000040U
+#define	ACRN_MEM_TYPE_WT		0x00000080U
+#define	ACRN_MEM_TYPE_UC		0x00000100U
+#define	ACRN_MEM_TYPE_WC		0x00000200U
+#define	ACRN_MEM_TYPE_WP		0x00000400U
+
+/* Memory mapping types */
+#define	ACRN_MEMMAP_RAM			0
+#define	ACRN_MEMMAP_MMIO		1
+
+/**
+ * struct acrn_vm_memmap - A EPT memory mapping info for a User VM.
+ * @type:		Type of the memory mapping (ACRM_MEMMAP_*).
+ *			Pass to hypervisor directly.
+ * @reserved:		Reserved.
+ * @user_vm_pa:		Physical address of User VM.
+ *			Pass to hypervisor directly.
+ * @service_vm_pa:	Physical address of Service VM.
+ *			Pass to hypervisor directly.
+ * @vma_base:		VMA address of Service VM. Pass to hypervisor directly.
+ * @len:		Length of the memory mapping.
+ *			Pass to hypervisor directly.
+ * @attr:		Attribute of the memory mapping.
+ *			Pass to hypervisor directly.
+ */
+struct acrn_vm_memmap {
+	__u32	type;
+	__u32	reserved;
+	__u64	user_vm_pa;
+	union {
+		__u64	service_vm_pa;
+		__u64	vma_base;
+	};
+	__u64	len;
+	__u32	attr;
+} __attribute__((aligned(8)));
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -124,4 +170,9 @@ struct acrn_vcpu_regs {
 #define ACRN_IOCTL_SET_VCPU_REGS	\
 	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
+#define ACRN_IOCTL_SET_MEMSEG		\
+	_IOW(ACRN_IOCTL_TYPE, 0x41, struct acrn_vm_memmap)
+#define ACRN_IOCTL_UNSET_MEMSEG		\
+	_IOW(ACRN_IOCTL_TYPE, 0x42, struct acrn_vm_memmap)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

