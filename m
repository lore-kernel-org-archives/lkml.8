Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B21204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgHYCvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:37715 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHYCu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:50:57 -0400
IronPort-SDR: MUrsUnphiXkkaubGoTNnkTWFtYNvqBSyAuxW7GWgditoxFBQHbTAcMO2fztYwjllTn47rKHBnF
 H4nKV9HhkduQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690768"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:50:55 -0700
IronPort-SDR: KZ36llnBC89UVprDZVRQY5dGq44j350x5PZcUbD6nSZ8YHGrNY3WzfjOZ8NgYV+wjsBjQ4F5Em
 bA9f2S0o0eZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409758"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:50:51 -0700
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
        Dave Hansen <dave.hansen@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 05/17] virt: acrn: Introduce ACRN HSM basic driver
Date:   Tue, 25 Aug 2020 10:45:05 +0800
Message-Id: <20200825024516.16766-6-shuo.a.liu@intel.com>
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

ACRN Hypervisor Service Module (HSM) is a kernel module in Service VM
which communicates with ACRN userspace through ioctls and talks to ACRN
Hypervisor through hypercalls.

Add a basic HSM driver which allows Service VM userspace to communicate
with ACRN. The following patches will add more ioctls, guest VM memory
mapping caching, I/O request processing, ioeventfd and irqfd into this
module. HSM exports a char device interface (/dev/acrn_hsm) to userspace.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   2 +
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/acrn/Kconfig                     |  14 +++
 drivers/virt/acrn/Makefile                    |   3 +
 drivers/virt/acrn/acrn_drv.h                  |  21 ++++
 drivers/virt/acrn/hsm.c                       | 115 ++++++++++++++++++
 drivers/virt/acrn/hypercall.h                 |  30 +++++
 include/uapi/linux/acrn.h                     |  33 +++++
 10 files changed, 222 insertions(+)
 create mode 100644 drivers/virt/acrn/Kconfig
 create mode 100644 drivers/virt/acrn/Makefile
 create mode 100644 drivers/virt/acrn/acrn_drv.h
 create mode 100644 drivers/virt/acrn/hsm.c
 create mode 100644 drivers/virt/acrn/hypercall.h
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
index e0fea5e464b4..d4c1ef303c2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -442,6 +442,8 @@ L:	acrn-dev@lists.projectacrn.org
 S:	Supported
 W:	https://projectacrn.org
 F:	Documentation/virt/acrn/
+F:	drivers/virt/acrn/
+F:	include/uapi/linux/acrn.h
 
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index cbc1f25c79ab..d9484a2e9b46 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -32,4 +32,6 @@ config FSL_HV_MANAGER
 	     partition shuts down.
 
 source "drivers/virt/vboxguest/Kconfig"
+
+source "drivers/virt/acrn/Kconfig"
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index fd331247c27a..f0491bbf0d4d 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-y				+= vboxguest/
+obj-$(CONFIG_ACRN_HSM)		+= acrn/
diff --git a/drivers/virt/acrn/Kconfig b/drivers/virt/acrn/Kconfig
new file mode 100644
index 000000000000..36c80378c30c
--- /dev/null
+++ b/drivers/virt/acrn/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+config ACRN_HSM
+	tristate "ACRN Hypervisor Service Module"
+	depends on ACRN_GUEST
+	help
+	  ACRN Hypervisor Service Module (HSM) is a kernel module which
+	  communicates with ACRN userspace through ioctls and talks to
+	  the ACRN Hypervisor through hypercalls. HSM will only run in
+	  a privileged management VM, called Service VM, to manage User
+	  VMs and do I/O emulation. Not required for simply running
+	  under ACRN as a User VM.
+
+	  To compile as a module, choose M, the module will be called
+	  acrn. If unsure, say N.
diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
new file mode 100644
index 000000000000..6920ed798aaf
--- /dev/null
+++ b/drivers/virt/acrn/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ACRN_HSM)	:= acrn.o
+acrn-y := hsm.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
new file mode 100644
index 000000000000..36f43d8d43d0
--- /dev/null
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ACRN_HSM_DRV_H
+#define __ACRN_HSM_DRV_H
+
+#include <linux/acrn.h>
+#include <linux/types.h>
+
+#include "hypercall.h"
+
+#define ACRN_INVALID_VMID (0xffffU)
+
+/**
+ * struct acrn_vm - Properties of ACRN User VM.
+ * @vmid:	User VM ID
+ */
+struct acrn_vm {
+	u16	vmid;
+};
+
+#endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
new file mode 100644
index 000000000000..a08169f35c96
--- /dev/null
+++ b/drivers/virt/acrn/hsm.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN Hypervisor Service Module (HSM)
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Fengwei Yin <fengwei.yin@intel.com>
+ *	Yakui Zhao <yakui.zhao@intel.com>
+ */
+
+#define pr_fmt(fmt) "acrn: " fmt
+
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <asm/acrn.h>
+#include <asm/hypervisor.h>
+
+#include "acrn_drv.h"
+
+static struct acrn_api_version api_version;
+
+/*
+ * When /dev/acrn_hsm is opened, a 'struct acrn_vm' object is created to
+ * represent a VM instance and continues to be associated with the opened file
+ * descriptor. All ioctl operations on this file descriptor will be targeted to
+ * the VM instance. Release of this file descriptor will destroy the object.
+ */
+static int acrn_dev_open(struct inode *inode, struct file *filp)
+{
+	struct acrn_vm *vm;
+
+	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
+	if (!vm)
+		return -ENOMEM;
+
+	vm->vmid = ACRN_INVALID_VMID;
+	filp->private_data = vm;
+	return 0;
+}
+
+static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long ioctl_param)
+{
+	if (cmd == ACRN_IOCTL_GET_API_VERSION) {
+		if (copy_to_user((void __user *)ioctl_param,
+				 &api_version, sizeof(api_version)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int acrn_dev_release(struct inode *inode, struct file *filp)
+{
+	struct acrn_vm *vm = filp->private_data;
+
+	kfree(vm);
+	return 0;
+}
+
+static const struct file_operations acrn_fops = {
+	.owner		= THIS_MODULE,
+	.open		= acrn_dev_open,
+	.release	= acrn_dev_release,
+	.unlocked_ioctl	= acrn_dev_ioctl,
+};
+
+static struct miscdevice acrn_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "acrn_hsm",
+	.fops	= &acrn_fops,
+};
+
+static int __init hsm_init(void)
+{
+	int ret;
+
+	if (x86_hyper_type != X86_HYPER_ACRN)
+		return -ENODEV;
+
+	if (!acrn_is_privileged_vm())
+		return -EPERM;
+
+	ret = hcall_get_api_version(slow_virt_to_phys(&api_version));
+	if (ret < 0) {
+		pr_err("Failed to get API version from hypervisor!\n");
+		return ret;
+	}
+
+	pr_info("API version is %u.%u\n",
+		api_version.major_version, api_version.minor_version);
+
+	ret = misc_register(&acrn_dev);
+	if (ret) {
+		pr_err("Create misc dev failed!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit hsm_exit(void)
+{
+	misc_deregister(&acrn_dev);
+}
+module_init(hsm_init);
+module_exit(hsm_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ACRN Hypervisor Service Module (HSM)");
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
new file mode 100644
index 000000000000..3ad1b708e162
--- /dev/null
+++ b/drivers/virt/acrn/hypercall.h
@@ -0,0 +1,30 @@
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
+#define HC_ID_GEN_BASE			0x0UL
+#define HC_GET_API_VERSION		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x00)
+
+/**
+ * hcall_get_api_version() - Get API version from hypervisor
+ * @api_version:	Service VM GPA of version info
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_get_api_version(u64 api_version)
+{
+	return acrn_hypercall1(HC_GET_API_VERSION, api_version);
+}
+
+#endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
new file mode 100644
index 000000000000..c59488ad7252
--- /dev/null
+++ b/include/uapi/linux/acrn.h
@@ -0,0 +1,33 @@
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
+ * struct acrn_api_version - ACRN Hypervisor API version.
+ * @major_version:	Major version of ACRN Hypervisor API.
+ * @minor_version:	Minor version of ACRN Hypervisor API.
+ */
+struct acrn_api_version {
+	__u32	major_version;
+	__u32	minor_version;
+} __attribute__((aligned(8)));
+
+/* The ioctl type, documented in ioctl-number.rst */
+#define ACRN_IOCTL_TYPE			0xA2
+
+/*
+ * Common IOCTL IDs definition for ACRN userspace
+ */
+#define ACRN_IOCTL_GET_API_VERSION	\
+	_IOR(ACRN_IOCTL_TYPE, 0, struct acrn_api_version)
+
+#endif /* _UAPI_ACRN_H */
-- 
2.28.0

