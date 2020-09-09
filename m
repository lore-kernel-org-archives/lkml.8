Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0495AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF4320708
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgIIJLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:11:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:23297 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgIIJL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:11:27 -0400
IronPort-SDR: lTAJ6kFvOb9R3HkV5gV31Ved2XWbYZK2uzKPp+te3+V0qWBWUhV8y1LrQySR+OHCDTpa2tWSKS
 WTmREXUtYpjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="146014739"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="146014739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:11:27 -0700
IronPort-SDR: PMp8nss6SKAu9ABX5z4Gsyy5jPcsvZRVmMKKSr+ug7TXCKi8WxsMvQzZRfq/Fr8mPaA1M+x6t4
 qZhleqk/xzOg==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="300090431"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:11:23 -0700
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
Subject: [PATCH v3 17/17] virt: acrn: Introduce an interface for Service VM to control vCPU
Date:   Wed,  9 Sep 2020 17:08:36 +0800
Message-Id: <20200909090836.46762-18-shuo.a.liu@intel.com>
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

ACRN supports partition mode to achieve real-time requirements. In
partition mode, a CPU core can be dedicated to a vCPU of User VM. The
local APIC of the dedicated CPU core can be passthrough to the User VM.
The Service VM controls the assignment of the CPU cores.

Introduce an interface for the Service VM to remove the control of CPU
core from hypervisor perspective so that the CPU core can be a dedicated
CPU core of User VM.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/hsm.c       | 50 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 14 ++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 5594ef8e4947..72144cb7569f 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -9,6 +9,7 @@
  *	Yakui Zhao <yakui.zhao@intel.com>
  */
 
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -342,6 +343,47 @@ static struct miscdevice acrn_dev = {
 	.fops	= &acrn_fops,
 };
 
+static ssize_t remove_cpu_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u64 cpu, lapicid;
+	int ret;
+
+	if (kstrtoull(buf, 0, &cpu) < 0)
+		return -EINVAL;
+
+	if (cpu >= num_possible_cpus() || cpu == 0 || !cpu_is_hotpluggable(cpu))
+		return -EINVAL;
+
+	if (cpu_online(cpu))
+		remove_cpu(cpu);
+
+	lapicid = cpu_data(cpu).apicid;
+	dev_dbg(dev, "Try to remove cpu %lld with lapicid %lld\n", cpu, lapicid);
+	ret = hcall_sos_remove_cpu(lapicid);
+	if (ret < 0) {
+		dev_err(dev, "Failed to remove cpu %lld!\n", cpu);
+		goto fail_remove;
+	}
+
+	return count;
+
+fail_remove:
+	add_cpu(cpu);
+	return ret;
+}
+static DEVICE_ATTR_WO(remove_cpu);
+
+static struct attribute *acrn_attrs[] = {
+	&dev_attr_remove_cpu.attr,
+	NULL
+};
+
+static struct attribute_group acrn_attr_group = {
+	.attrs = acrn_attrs,
+};
+
 static int __init hsm_init(void)
 {
 	int ret;
@@ -358,13 +400,21 @@ static int __init hsm_init(void)
 		return ret;
 	}
 
+	ret = sysfs_create_group(&acrn_dev.this_device->kobj, &acrn_attr_group);
+	if (ret) {
+		dev_warn(acrn_dev.this_device, "sysfs create failed\n");
+		misc_deregister(&acrn_dev);
+		return ret;
+	}
 	acrn_ioreq_intr_setup();
+
 	return 0;
 }
 
 static void __exit hsm_exit(void)
 {
 	acrn_ioreq_intr_remove();
+	sysfs_remove_group(&acrn_dev.this_device->kobj, &acrn_attr_group);
 	misc_deregister(&acrn_dev);
 }
 module_init(hsm_init);
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index e640632366f0..0cfad05bd1a9 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -13,6 +13,9 @@
 
 #define HC_ID 0x80UL
 
+#define HC_ID_GEN_BASE			0x0UL
+#define HC_SOS_REMOVE_CPU		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x01)
+
 #define HC_ID_VM_BASE			0x10UL
 #define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
 #define HC_DESTROY_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x01)
@@ -42,6 +45,17 @@
 #define HC_ID_PM_BASE			0x80UL
 #define HC_PM_GET_CPU_STATE		_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
 
+/**
+ * hcall_sos_remove_cpu() - Remove a vCPU of Service VM
+ * @cpu: The vCPU to be removed
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_sos_remove_cpu(u64 cpu)
+{
+	return acrn_hypercall1(HC_SOS_REMOVE_CPU, cpu);
+}
+
 /**
  * hcall_create_vm() - Create a User VM
  * @vminfo:	Service VM GPA of info of User VM creation
-- 
2.28.0

