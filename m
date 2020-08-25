Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E858C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFE7204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgHYCv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:37741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgHYCvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:51:23 -0400
IronPort-SDR: aNNy+fTas+FfhelcOkhKa8/pauwNQWILD5v5v8c+Q6D8RDGGWRVamZ5Wh+iP3spisuVRXUOuYa
 iRczT4P79e3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690836"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:51:22 -0700
IronPort-SDR: Hbsc/DNgUbWexPZ4WZm8kTgoqvObw+oSaAC7YhC3NmWvkyjkJuTf226MmSvl5jrnamSEmoTTRQ
 otTZf6Dm/VLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409865"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:51:19 -0700
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
Subject: [PATCH 13/17] virt: acrn: Introduce interfaces to query C-states and P-states allowed by hypervisor
Date:   Tue, 25 Aug 2020 10:45:13 +0800
Message-Id: <20200825024516.16766-14-shuo.a.liu@intel.com>
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

The C-states and P-states data are used to support CPU power management.
The hypervisor controls C-states and P-states for a User VM.

ACRN userspace need to query the data from the hypervisor to build ACPI
tables for a User VM.

HSM provides ioctls for ACRN userspace to query C-states and P-states
data obtained from the hypervisor.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
CC: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/virt/acrn/hsm.c       | 69 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 12 ++++++
 include/uapi/linux/acrn.h     | 35 ++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 11369fb2d1c5..c0f33bc505e2 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -43,6 +43,67 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int pmcmd_ioctl(u64 cmd, void __user *uptr)
+{
+	struct acrn_pstate_data *px_data;
+	struct acrn_cstate_data *cx_data;
+	u64 *pm_info;
+	int ret = 0;
+
+	switch (cmd & PMCMD_TYPE_MASK) {
+	case ACRN_PMCMD_GET_PX_CNT:
+	case ACRN_PMCMD_GET_CX_CNT:
+		pm_info = kmalloc(sizeof(u64), GFP_KERNEL);
+		if (!pm_info)
+			return -ENOMEM;
+
+		ret = hcall_get_cpu_state(cmd, virt_to_phys(pm_info));
+		if (ret < 0) {
+			kfree(pm_info);
+			break;
+		}
+
+		if (copy_to_user(uptr, pm_info, sizeof(u64)))
+			ret = -EFAULT;
+		kfree(pm_info);
+		break;
+	case ACRN_PMCMD_GET_PX_DATA:
+		px_data = kmalloc(sizeof(*px_data), GFP_KERNEL);
+		if (!px_data)
+			return -ENOMEM;
+
+		ret = hcall_get_cpu_state(cmd, virt_to_phys(px_data));
+		if (ret < 0) {
+			kfree(px_data);
+			break;
+		}
+
+		if (copy_to_user(uptr, px_data, sizeof(*px_data)))
+			ret = -EFAULT;
+		kfree(px_data);
+		break;
+	case ACRN_PMCMD_GET_CX_DATA:
+		cx_data = kmalloc(sizeof(*cx_data), GFP_KERNEL);
+		if (!cx_data)
+			return -ENOMEM;
+
+		ret = hcall_get_cpu_state(cmd, virt_to_phys(cx_data));
+		if (ret < 0) {
+			kfree(cx_data);
+			break;
+		}
+
+		if (copy_to_user(uptr, cx_data, sizeof(*cx_data)))
+			ret = -EFAULT;
+		kfree(cx_data);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 			   unsigned long ioctl_param)
 {
@@ -55,6 +116,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
 	struct page *page;
+	u64 cstate_cmd;
 	int ret = 0;
 
 	if (cmd == ACRN_IOCTL_GET_API_VERSION) {
@@ -234,6 +296,13 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	case ACRN_IOCTL_CLEAR_VM_IOREQ:
 		acrn_ioreq_request_clear(vm);
 		break;
+	case ACRN_IOCTL_PM_GET_CPU_STATE:
+		if (copy_from_user(&cstate_cmd, (void *)ioctl_param,
+				   sizeof(cstate_cmd)))
+			return -EFAULT;
+
+		ret = pmcmd_ioctl(cstate_cmd, (void __user *)ioctl_param);
+		break;
 	default:
 		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
 		ret = -EINVAL;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index f220358633ab..ce8fdca76394 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -42,6 +42,9 @@
 #define HC_ASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x05)
 #define HC_DEASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
 
+#define HC_ID_PM_BASE			0x80UL
+#define HC_PM_GET_CPU_STATE		_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
+
 /**
  * hcall_get_api_version() - Get API version from hypervisor
  * @api_version:	Service VM GPA of version info
@@ -239,4 +242,13 @@ static inline long hcall_reset_ptdev_intr(u64 vmid, u64 irq)
 	return acrn_hypercall2(HC_RESET_PTDEV_INTR, vmid, irq);
 }
 
+/*
+ * hcall_get_cpu_state() - Get P-states and C-states info from the hypervisor
+ * @state:	Service VM GPA of buffer of P-states and C-states
+ */
+static inline long hcall_get_cpu_state(u64 cmd, u64 state)
+{
+	return acrn_hypercall2(HC_PM_GET_CPU_STATE, cmd, state);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index a20bee88cf9a..d5bd2b7dfd85 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -363,6 +363,38 @@ struct acrn_msi_entry {
 	__u64	msi_data;
 };
 
+struct acrn_acpi_generic_address {
+	__u8	space_id;
+	__u8	bit_width;
+	__u8	bit_offset;
+	__u8	access_size;
+	__u64	address;
+} __attribute__ ((__packed__));
+
+struct acrn_cstate_data {
+	struct acrn_acpi_generic_address	cx_reg;
+	__u8					type;
+	__u32					latency;
+	__u64					power;
+} __attribute__((aligned(8)));
+
+struct acrn_pstate_data {
+	__u64	core_frequency;
+	__u64	power;
+	__u64	transition_latency;
+	__u64	bus_master_latency;
+	__u64	control;
+	__u64	status;
+} __attribute__((aligned(8)));
+
+#define PMCMD_TYPE_MASK		0x000000ff
+enum acrn_pm_cmd_type {
+	ACRN_PMCMD_GET_PX_CNT,
+	ACRN_PMCMD_GET_PX_DATA,
+	ACRN_PMCMD_GET_CX_CNT,
+	ACRN_PMCMD_GET_CX_DATA,
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -417,4 +449,7 @@ struct acrn_msi_entry {
 #define ACRN_IOCTL_DEASSIGN_PCIDEV	\
 	_IOW(ACRN_IOCTL_TYPE, 0x56, struct acrn_pcidev)
 
+#define ACRN_IOCTL_PM_GET_CPU_STATE	\
+	_IOWR(ACRN_IOCTL_TYPE, 0x60, __u64)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

