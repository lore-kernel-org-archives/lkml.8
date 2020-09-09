Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB59C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D5821D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgIIJLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:11:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:52501 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgIIJK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:10:58 -0400
IronPort-SDR: n89V4Qg88hMEMxnwrmDAsTfRdf2/g/UVCGfsfJym64RJPalsJ3MBpikdWyl6rHNXbzbmczBPEs
 pokO2Y8tGShA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219854589"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="219854589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:10:57 -0700
IronPort-SDR: jg/kX+ddp/zRBbujJwn1fScaxYEAlvFGBOQ6jtVL/jRLb7zCWH0PKt1NkBAGHmWC3Upgcz6lPH
 Hx6D44p2zZFQ==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="377804876"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:10:53 -0700
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
Subject: [PATCH v3 12/17] virt: acrn: Introduce interrupt injection interfaces
Date:   Wed,  9 Sep 2020 17:08:31 +0800
Message-Id: <20200909090836.46762-13-shuo.a.liu@intel.com>
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

ACRN userspace need to inject virtual interrupts into a User VM in
devices emulation.

HSM needs provide interfaces to do so.

Introduce following interrupt injection interfaces:

ioctl ACRN_IOCTL_SET_IRQLINE:
  Pass data from userspace to the hypervisor, and inform the hypervisor
  to inject a virtual IOAPIC GSI interrupt to a User VM.

ioctl ACRN_IOCTL_INJECT_MSI:
  Pass data struct acrn_msi_entry from userspace to the hypervisor, and
  inform the hypervisor to inject a virtual MSI to a User VM.

ioctl ACRN_IOCTL_VM_INTR_MONITOR:
  Set a 4-Kbyte aligned shared page for statistics information of
  interrupts of a User VM.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/acrn_drv.h  |  4 ++++
 drivers/virt/acrn/hsm.c       | 35 ++++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 41 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c        | 35 ++++++++++++++++++++++++++++++
 include/uapi/linux/acrn.h     | 17 +++++++++++++++
 5 files changed, 132 insertions(+)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 4f86feaa5e1b..84d9a8f80101 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -155,6 +155,7 @@ extern rwlock_t acrn_vm_list_lock;
  * @ioreq_buf:			I/O request shared buffer
  * @ioreq_page:			The page of the I/O request shared buffer
  * @pci_conf_addr:		Address of a PCI configuration access emulation
+ * @monitor_page:		Page of interrupt statistics of User VM
  */
 struct acrn_vm {
 	struct device			*dev;
@@ -171,6 +172,7 @@ struct acrn_vm {
 	struct acrn_io_request_buffer	*ioreq_buf;
 	struct page			*ioreq_page;
 	u32				pci_conf_addr;
+	struct page			*monitor_page;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
@@ -197,4 +199,6 @@ struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
 						   const char *name);
 void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client);
 
+int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 6fb8032b007c..d6e1f60126a8 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -51,7 +51,9 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_ioreq_notify notify;
 	struct acrn_ptdev_irq *irq_info;
 	struct acrn_vm_memmap memmap;
+	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
+	struct page *page;
 	int ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
@@ -169,6 +171,39 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 			dev_err(vm->dev, "Failed to reset intr for ptdev!\n");
 		kfree(irq_info);
 		break;
+	case ACRN_IOCTL_SET_IRQLINE:
+		ret = hcall_set_irqline(vm->vmid, ioctl_param);
+		if (ret < 0)
+			dev_err(vm->dev, "Failed to set interrupt line!\n");
+		break;
+	case ACRN_IOCTL_INJECT_MSI:
+		msi = memdup_user((void __user *)ioctl_param,
+				  sizeof(struct acrn_msi_entry));
+		if (IS_ERR(msi))
+			return PTR_ERR(msi);
+
+		ret = hcall_inject_msi(vm->vmid, virt_to_phys(msi));
+		if (ret < 0)
+			dev_err(vm->dev, "Failed to inject MSI!\n");
+		kfree(msi);
+		break;
+	case ACRN_IOCTL_VM_INTR_MONITOR:
+		ret = get_user_pages_fast(ioctl_param, 1, FOLL_WRITE, &page);
+		if (unlikely(ret != 1)) {
+			dev_err(vm->dev, "Failed to pin intr hdr buffer!\n");
+			return -ENOMEM;
+		}
+
+		ret = hcall_vm_intr_monitor(vm->vmid, page_to_phys(page));
+		if (ret < 0) {
+			put_page(page);
+			dev_err(vm->dev, "Failed to monitor intr data!\n");
+			return ret;
+		}
+		if (vm->monitor_page)
+			put_page(vm->monitor_page);
+		vm->monitor_page = page;
+		break;
 	case ACRN_IOCTL_CREATE_IOREQ_CLIENT:
 		if (vm->default_client)
 			return -EEXIST;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index f448301832cf..a8813397a3fe 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -21,6 +21,11 @@
 #define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
 #define HC_SET_VCPU_REGS		_HC_ID(HC_ID, HC_ID_VM_BASE + 0x06)
 
+#define HC_ID_IRQ_BASE			0x20UL
+#define HC_INJECT_MSI			_HC_ID(HC_ID, HC_ID_IRQ_BASE + 0x03)
+#define HC_VM_INTR_MONITOR		_HC_ID(HC_ID, HC_ID_IRQ_BASE + 0x04)
+#define HC_SET_IRQLINE			_HC_ID(HC_ID, HC_ID_IRQ_BASE + 0x05)
+
 #define HC_ID_IOREQ_BASE		0x30UL
 #define HC_SET_IOREQ_BUFFER		_HC_ID(HC_ID, HC_ID_IOREQ_BASE + 0x00)
 #define HC_NOTIFY_REQUEST_FINISH	_HC_ID(HC_ID, HC_ID_IOREQ_BASE + 0x01)
@@ -101,6 +106,42 @@ static inline long hcall_set_vcpu_regs(u64 vmid, u64 regs_state)
 	return acrn_hypercall2(HC_SET_VCPU_REGS, vmid, regs_state);
 }
 
+/**
+ * hcall_inject_msi() - Deliver a MSI interrupt to a User VM
+ * @vmid:	User VM ID
+ * @msi:	Service VM GPA of MSI message
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_inject_msi(u64 vmid, u64 msi)
+{
+	return acrn_hypercall2(HC_INJECT_MSI, vmid, msi);
+}
+
+/**
+ * hcall_vm_intr_monitor() - Set a shared page for User VM interrupt statistics
+ * @vmid:	User VM ID
+ * @addr:	Service VM GPA of the shared page
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_vm_intr_monitor(u64 vmid, u64 addr)
+{
+	return acrn_hypercall2(HC_VM_INTR_MONITOR, vmid, addr);
+}
+
+/**
+ * hcall_set_irqline() - Set or clear an interrupt line
+ * @vmid:	User VM ID
+ * @op:		Service VM GPA of interrupt line operations
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_irqline(u64 vmid, u64 op)
+{
+	return acrn_hypercall2(HC_SET_IRQLINE, vmid, op);
+}
+
 /**
  * hcall_set_ioreq_buffer() - Set up the shared buffer for I/O Requests.
  * @vmid:	User VM ID
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 12bd5de0a676..c1fefd92e571 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -67,6 +67,10 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	write_unlock_bh(&acrn_vm_list_lock);
 
 	acrn_ioreq_deinit(vm);
+	if (vm->monitor_page) {
+		put_page(vm->monitor_page);
+		vm->monitor_page = NULL;
+	}
 
 	ret = hcall_destroy_vm(vm->vmid);
 	if (ret < 0) {
@@ -81,3 +85,34 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	vm->vmid = ACRN_INVALID_VMID;
 	return 0;
 }
+
+/**
+ * acrn_inject_msi() - Inject a MSI interrupt into a User VM
+ * @vm:		User VM
+ * @msi_addr:	The MSI address
+ * @msi_data:	The MSI data
+ *
+ * Return: 0 on success, <0 on error
+ */
+int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data)
+{
+	struct acrn_msi_entry *msi;
+	int ret;
+
+	/* might be used in interrupt context, so use GFP_ATOMIC */
+	msi = kzalloc(sizeof(*msi), GFP_ATOMIC);
+	if (!msi)
+		return -ENOMEM;
+
+	/*
+	 * msi_addr: addr[19:12] with dest vcpu id
+	 * msi_data: data[7:0] with vector
+	 */
+	msi->msi_addr = msi_addr;
+	msi->msi_data = msi_data;
+	ret = hcall_inject_msi(vm->vmid, virt_to_phys(msi));
+	if (ret < 0)
+		dev_err(vm->dev, "Failed to inject MSI to VM %u!\n", vm->vmid);
+	kfree(msi);
+	return ret;
+}
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 893389babbcb..7764459e130c 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -343,6 +343,16 @@ struct acrn_pcidev {
 	__u32	reserved[6];
 } __attribute__((aligned(8)));
 
+/**
+ * struct acrn_msi_entry - Info for injecting a MSI interrupt to a VM
+ * @msi_addr:	MSI addr[19:12] with dest vCPU ID
+ * @msi_data:	MSI data[7:0] with vector
+ */
+struct acrn_msi_entry {
+	__u64	msi_addr;
+	__u64	msi_data;
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -362,6 +372,13 @@ struct acrn_pcidev {
 #define ACRN_IOCTL_SET_VCPU_REGS	\
 	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
+#define ACRN_IOCTL_INJECT_MSI		\
+	_IOW(ACRN_IOCTL_TYPE, 0x23, struct acrn_msi_entry)
+#define ACRN_IOCTL_VM_INTR_MONITOR	\
+	_IOW(ACRN_IOCTL_TYPE, 0x24, unsigned long)
+#define ACRN_IOCTL_SET_IRQLINE		\
+	_IOW(ACRN_IOCTL_TYPE, 0x25, __u64)
+
 #define ACRN_IOCTL_NOTIFY_REQUEST_FINISH \
 	_IOW(ACRN_IOCTL_TYPE, 0x31, struct acrn_ioreq_notify)
 #define ACRN_IOCTL_CREATE_IOREQ_CLIENT	\
-- 
2.28.0

