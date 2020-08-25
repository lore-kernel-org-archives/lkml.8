Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E230FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34C3204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHYCvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:37741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgHYCvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:51:17 -0400
IronPort-SDR: /wrYvFq5HJpKV1kueaSDIupd25D0JCEocSk0Il/7Sg/phjkVgk6ZpenBr7G2AauscTHtAj9la2
 eDLXC216usHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690822"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690822"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:51:15 -0700
IronPort-SDR: 7IWqB2Phs74SVmqmpMNXjckljljuWuJZ+/Qs4LSV/YGBdCs+V+P8o7GStwzcBGvkgyGZT1rjVI
 ZqlDiUBFibKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409849"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:51:12 -0700
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
Subject: [PATCH 11/17] virt: acrn: Introduce interfaces for PCI device passthrough
Date:   Tue, 25 Aug 2020 10:45:11 +0800
Message-Id: <20200825024516.16766-12-shuo.a.liu@intel.com>
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

PCI device passthrough enables an OS in a virtual machine to directly
access a PCI device in the host. It promises almost the native
performance, which is required in performance-critical scenarios of
ACRN.

HSM provides the following ioctls:
 - Assign - ACRN_IOCTL_ASSIGN_PCIDEV
   Pass data struct acrn_pcidev from userspace to the hypervisor, and
   inform the hypervisor to assign a PCI device to a User VM.

 - De-assign - ACRN_IOCTL_DEASSIGN_PCIDEV
   Pass data struct acrn_pcidev from userspace to the hypervisor, and
   inform the hypervisor to de-assign a PCI device from a User VM.

 - Set a interrupt of a passthrough device - ACRN_IOCTL_SET_PTDEV_INTR
   Pass data struct acrn_ptdev_irq from userspace to the hypervisor,
   and inform the hypervisor to map a INTx interrupt of passthrough
   device of User VM.

 - Reset passthrough device interrupt - ACRN_IOCTL_RESET_PTDEV_INTR
   Pass data struct acrn_ptdev_irq from userspace to the hypervisor,
   and inform the hypervisor to unmap a INTx interrupt of passthrough
   device of User VM.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/virt/acrn/hsm.c       | 46 +++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 54 ++++++++++++++++++++++++++++++
 include/uapi/linux/acrn.h     | 63 +++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 3c7bea54e476..ab2a052900e8 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -50,7 +50,9 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vm_creation *vm_param;
 	struct acrn_vcpu_regs *cpu_regs;
 	struct acrn_ioreq_notify notify;
+	struct acrn_ptdev_irq *irq_info;
 	struct acrn_vm_memmap memmap;
+	struct acrn_pcidev *pcidev;
 	int ret = 0;
 
 	if (cmd == ACRN_IOCTL_GET_API_VERSION) {
@@ -130,6 +132,50 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 
 		ret = acrn_vm_memseg_unmap(vm, &memmap);
 		break;
+	case ACRN_IOCTL_ASSIGN_PCIDEV:
+		pcidev = memdup_user((void __user *)ioctl_param,
+				     sizeof(struct acrn_pcidev));
+		if (IS_ERR(pcidev))
+			return PTR_ERR(pcidev);
+
+		ret = hcall_assign_pcidev(vm->vmid, virt_to_phys(pcidev));
+		if (ret < 0)
+			pr_err("Failed to assign pci device!\n");
+		kfree(pcidev);
+		break;
+	case ACRN_IOCTL_DEASSIGN_PCIDEV:
+		pcidev = memdup_user((void __user *)ioctl_param,
+				     sizeof(struct acrn_pcidev));
+		if (IS_ERR(pcidev))
+			return PTR_ERR(pcidev);
+
+		ret = hcall_deassign_pcidev(vm->vmid, virt_to_phys(pcidev));
+		if (ret < 0)
+			pr_err("Failed to deassign pci device!\n");
+		kfree(pcidev);
+		break;
+	case ACRN_IOCTL_SET_PTDEV_INTR:
+		irq_info = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_ptdev_irq));
+		if (IS_ERR(irq_info))
+			return PTR_ERR(irq_info);
+
+		ret = hcall_set_ptdev_intr(vm->vmid, virt_to_phys(irq_info));
+		if (ret < 0)
+			pr_err("Failed to configure intr for ptdev!\n");
+		kfree(irq_info);
+		break;
+	case ACRN_IOCTL_RESET_PTDEV_INTR:
+		irq_info = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_ptdev_irq));
+		if (IS_ERR(irq_info))
+			return PTR_ERR(irq_info);
+
+		ret = hcall_reset_ptdev_intr(vm->vmid, virt_to_phys(irq_info));
+		if (ret < 0)
+			pr_err("Failed to reset intr for ptdev!\n");
+		kfree(irq_info);
+		break;
 	case ACRN_IOCTL_CREATE_IOREQ_CLIENT:
 		if (vm->default_client)
 			return -EEXIST;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index d85dbcdb9f00..41409df943a2 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -31,6 +31,12 @@
 #define HC_ID_MEM_BASE			0x40UL
 #define HC_VM_SET_MEMORY_REGIONS	_HC_ID(HC_ID, HC_ID_MEM_BASE + 0x02)
 
+#define HC_ID_PCI_BASE			0x50UL
+#define HC_SET_PTDEV_INTR		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x03)
+#define HC_RESET_PTDEV_INTR		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x04)
+#define HC_ASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x05)
+#define HC_DEASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
+
 /**
  * hcall_get_api_version() - Get API version from hypervisor
  * @api_version:	Service VM GPA of version info
@@ -144,4 +150,52 @@ static inline long hcall_set_memory_regions(u64 regions_pa)
 	return acrn_hypercall1(HC_VM_SET_MEMORY_REGIONS, regions_pa);
 }
 
+/**
+ * hcall_assign_pcidev() - Assign a PCI device to a User VM
+ * @vmid:	User VM ID
+ * @addr:	Service VM GPA of the &struct acrn_pcidev
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_assign_pcidev(u64 vmid, u64 addr)
+{
+	return acrn_hypercall2(HC_ASSIGN_PCIDEV, vmid, addr);
+}
+
+/**
+ * hcall_deassign_pcidev() - De-assign a PCI device from a User VM
+ * @vmid:	User VM ID
+ * @addr:	Service VM GPA of the &struct acrn_pcidev
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_deassign_pcidev(u64 vmid, u64 addr)
+{
+	return acrn_hypercall2(HC_DEASSIGN_PCIDEV, vmid, addr);
+}
+
+/**
+ * hcall_set_ptdev_intr() - Configure an interrupt for an assigned PCI device.
+ * @vmid:	User VM ID
+ * @irq:	Service VM GPA of the &struct acrn_ptdev_irq
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_ptdev_intr(u64 vmid, u64 irq)
+{
+	return acrn_hypercall2(HC_SET_PTDEV_INTR, vmid, irq);
+}
+
+/**
+ * hcall_reset_ptdev_intr() - Reset an interrupt for an assigned PCI device.
+ * @vmid:	User VM ID
+ * @irq:	Service VM GPA of the &struct acrn_ptdev_irq
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_reset_ptdev_intr(u64 vmid, u64 irq)
+{
+	return acrn_hypercall2(HC_RESET_PTDEV_INTR, vmid, irq);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index c8bb71a1cef7..45891da3d8a1 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -299,6 +299,60 @@ struct acrn_vm_memmap {
 	__u32	attr;
 } __attribute__((aligned(8)));
 
+/* Type of interrupt of a passthrough device */
+#define ACRN_PTDEV_IRQ_INTX	0
+#define ACRN_PTDEV_IRQ_MSI	1
+#define ACRN_PTDEV_IRQ_MSIX	2
+/**
+ * struct acrn_ptdev_irq - Interrupt data of a passthrough device.
+ * @type:		Type (ACRN_PTDEV_IRQ_*)
+ * @virt_bdf:		Virtual Bus/Device/Function
+ * @phys_bdf:		Physical Bus/Device/Function
+ * @intx:		Info of interrupt
+ * @intx.virt_pin:	Virtual IOAPIC pin
+ * @intx.phys_pin:	Physical IOAPIC pin
+ * @intx.is_pic_pin:	Is PIC pin or not
+ *
+ * This structure will be passed to hypervisor directly.
+ */
+struct acrn_ptdev_irq {
+	__u32	type;
+	__u16	virt_bdf;
+	__u16	phys_bdf;
+
+	struct {
+		__u32	virt_pin;
+		__u32	phys_pin;
+		__u32	is_pic_pin;
+	} intx;
+} __attribute__((aligned(8)));
+
+/* Type of PCI device assignment */
+#define ACRN_PTDEV_QUIRK_ASSIGN	(1U << 0)
+
+#define ACRN_PCI_NUM_BARS	6
+/**
+ * struct acrn_pcidev - Info for assigning or de-assigning a PCI device
+ * @type:	Type of the assignment
+ * @virt_bdf:	Virtual Bus/Device/Function
+ * @phys_bdf:	Physical Bus/Device/Function
+ * @intr_line:	PCI interrupt line
+ * @intr_pin:	PCI interrupt pin
+ * @bar:	PCI BARs.
+ * @reserved:	Reserved.
+ *
+ * This structure will be passed to hypervisor directly.
+ */
+struct acrn_pcidev {
+	__u32	type;
+	__u16	virt_bdf;
+	__u16	phys_bdf;
+	__u8	intr_line;
+	__u8	intr_pin;
+	__u32	bar[ACRN_PCI_NUM_BARS];
+	__u32	reserved[6];
+} __attribute__((aligned(8)));
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -337,4 +391,13 @@ struct acrn_vm_memmap {
 #define ACRN_IOCTL_UNSET_MEMSEG		\
 	_IOW(ACRN_IOCTL_TYPE, 0x42, struct acrn_vm_memmap)
 
+#define ACRN_IOCTL_SET_PTDEV_INTR	\
+	_IOW(ACRN_IOCTL_TYPE, 0x53, struct acrn_ptdev_irq)
+#define ACRN_IOCTL_RESET_PTDEV_INTR	\
+	_IOW(ACRN_IOCTL_TYPE, 0x54, struct acrn_ptdev_irq)
+#define ACRN_IOCTL_ASSIGN_PCIDEV	\
+	_IOW(ACRN_IOCTL_TYPE, 0x55, struct acrn_pcidev)
+#define ACRN_IOCTL_DEASSIGN_PCIDEV	\
+	_IOW(ACRN_IOCTL_TYPE, 0x56, struct acrn_pcidev)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

