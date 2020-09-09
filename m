Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA86C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48502145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgIIJKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:10:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:28799 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIIJKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:10:04 -0400
IronPort-SDR: jxLtzq+F1fi9lQ3jz02mTKsofPck9fyvYIMlOVX9pgAK2NwqAmVaREq8jW/KbT9492JW9MCdCy
 xd7SN5cC7byw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="243111461"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="243111461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:10:01 -0700
IronPort-SDR: rZpk5Z4odKGLtLzltwGuhgScQp4Dp92VrSL4e68D5TH4P2Q/gxdovziIHfE34vMww7rcvuivKY
 lhKHsAG05jJg==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="343831390"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:09:59 -0700
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
Subject: [PATCH v3 07/17] virt: acrn: Introduce an ioctl to set vCPU registers state
Date:   Wed,  9 Sep 2020 17:08:26 +0800
Message-Id: <20200909090836.46762-8-shuo.a.liu@intel.com>
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

A virtual CPU of User VM has different context due to the different
registers state. ACRN userspace needs to set the virtual CPU
registers state (e.g. giving a initial registers state to a virtual
BSP of a User VM).

HSM provides an ioctl ACRN_IOCTL_SET_VCPU_REGS to do the virtual CPU
registers state setting. The ioctl passes the registers state from ACRN
userspace to the hypervisor directly.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/hsm.c       | 14 +++++++
 drivers/virt/acrn/hypercall.h | 13 +++++++
 include/uapi/linux/acrn.h     | 71 +++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index bc85a3c14f87..aa6e9999d147 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -9,6 +9,7 @@
  *	Yakui Zhao <yakui.zhao@intel.com>
  */
 
+#include <linux/io.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -46,6 +47,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 {
 	struct acrn_vm *vm = filp->private_data;
 	struct acrn_vm_creation *vm_param;
+	struct acrn_vcpu_regs *cpu_regs;
 	int ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
@@ -93,6 +95,18 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	case ACRN_IOCTL_DESTROY_VM:
 		ret = acrn_vm_destroy(vm);
 		break;
+	case ACRN_IOCTL_SET_VCPU_REGS:
+		cpu_regs = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_vcpu_regs));
+		if (IS_ERR(cpu_regs))
+			return PTR_ERR(cpu_regs);
+
+		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
+		if (ret < 0)
+			dev_err(vm->dev, "Failed to set regs state of VM%u!\n",
+				vm->vmid);
+		kfree(cpu_regs);
+		break;
 	default:
 		dev_warn(vm->dev, "Unknown IOCTL 0x%x!\n", cmd);
 		ret = -ENOTTY;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index 426b66cadb1f..f29cfae08862 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -19,6 +19,7 @@
 #define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
 #define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
 #define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
+#define HC_SET_VCPU_REGS		_HC_ID(HC_ID, HC_ID_VM_BASE + 0x06)
 
 /**
  * hcall_create_vm() - Create a User VM
@@ -75,4 +76,16 @@ static inline long hcall_reset_vm(u64 vmid)
 	return acrn_hypercall1(HC_RESET_VM, vmid);
 }
 
+/**
+ * hcall_set_vcpu_regs() - Set up registers of virtual CPU of a User VM
+ * @vmid:	User VM ID
+ * @regs_state:	Service VM GPA of registers state
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_vcpu_regs(u64 vmid, u64 regs_state)
+{
+	return acrn_hypercall2(HC_SET_VCPU_REGS, vmid, regs_state);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 364b1a783074..1d5b82e154fb 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -36,6 +36,75 @@ struct acrn_vm_creation {
 	__u8	reserved2[8];
 } __attribute__((aligned(8)));
 
+struct acrn_gp_regs {
+	__u64	rax;
+	__u64	rcx;
+	__u64	rdx;
+	__u64	rbx;
+	__u64	rsp;
+	__u64	rbp;
+	__u64	rsi;
+	__u64	rdi;
+	__u64	r8;
+	__u64	r9;
+	__u64	r10;
+	__u64	r11;
+	__u64	r12;
+	__u64	r13;
+	__u64	r14;
+	__u64	r15;
+};
+
+struct acrn_descriptor_ptr {
+	__u16	limit;
+	__u64	base;
+	__u16	reserved[3];
+} __attribute__ ((__packed__));
+
+struct acrn_regs {
+	struct acrn_gp_regs		gprs;
+	struct acrn_descriptor_ptr	gdt;
+	struct acrn_descriptor_ptr	idt;
+
+	__u64				rip;
+	__u64				cs_base;
+	__u64				cr0;
+	__u64				cr4;
+	__u64				cr3;
+	__u64				ia32_efer;
+	__u64				rflags;
+	__u64				reserved_64[4];
+
+	__u32				cs_ar;
+	__u32				cs_limit;
+	__u32				reserved_32[3];
+
+	__u16				cs_sel;
+	__u16				ss_sel;
+	__u16				ds_sel;
+	__u16				es_sel;
+	__u16				fs_sel;
+	__u16				gs_sel;
+	__u16				ldt_sel;
+	__u16				tr_sel;
+
+	__u16				reserved_16[4];
+};
+
+/**
+ * struct acrn_vcpu_regs - Info of vCPU registers state
+ * @vcpu_id:	vCPU ID
+ * @reserved0:	Reserved
+ * @vcpu_regs:	vCPU registers state
+ *
+ * This structure will be passed to hypervisor directly.
+ */
+struct acrn_vcpu_regs {
+	__u16			vcpu_id;
+	__u16			reserved0[3];
+	struct acrn_regs	vcpu_regs;
+} __attribute__((aligned(8)));
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -52,5 +121,7 @@ struct acrn_vm_creation {
 	_IO(ACRN_IOCTL_TYPE, 0x13)
 #define ACRN_IOCTL_RESET_VM		\
 	_IO(ACRN_IOCTL_TYPE, 0x15)
+#define ACRN_IOCTL_SET_VCPU_REGS	\
+	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

