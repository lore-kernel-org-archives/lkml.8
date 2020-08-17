Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B5DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E11B2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgHQImI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:42:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbgHQIl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:41:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63C58374DE456567A6C9;
        Mon, 17 Aug 2020 16:41:22 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.22) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 16:41:14 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [RFC PATCH 4/5] clocksource: arm_arch_timer: Add pvtime LPT initialization
Date:   Mon, 17 Aug 2020 16:41:09 +0800
Message-ID: <20200817084110.2672-5-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20200817084110.2672-1-zhukeqian1@huawei.com>
References: <20200817084110.2672-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable paravirtualized time to be used in a KVM guest if the host
supports it. This allows the guest to derive a counter which is clocked
at a persistent rate even when the guest is migrated.

If we discover that the system supports SMCCC v1.1 then we probe to
determine whether the hypervisor supports paravirtualized features and
finally whether it supports "Live Physical Time" reporting. If so a
shared structure is made available to the guest containing coefficients
to calculate the derived clock.

Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6c3e841..eb2e57a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -26,6 +26,7 @@
 #include <linux/acpi.h>
 
 #include <asm/arch_timer.h>
+#include <asm/pvclock-abi.h>
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -84,6 +85,66 @@ static int __init early_evtstrm_cfg(char *buf)
 }
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
 
+/* PV-time LPT */
+#ifdef CONFIG_ARM64
+struct pvclock_vm_lpt_time *lpt_info;
+EXPORT_SYMBOL_GPL(lpt_info);
+DEFINE_STATIC_KEY_FALSE(pvclock_lpt_key_enabled);
+EXPORT_SYMBOL_GPL(pvclock_lpt_key_enabled);
+
+static bool has_pv_lpt_clock(void)
+{
+	struct arm_smccc_res res;
+
+	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
+		return false;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			   ARM_SMCCC_HV_PV_TIME_FEATURES, &res);
+	if (res.a0 != SMCCC_RET_SUCCESS)
+		return false;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_HV_PV_TIME_FEATURES,
+			     ARM_SMCCC_HV_PV_TIME_LPT, &res);
+	return res.a0 == SMCCC_RET_SUCCESS;
+}
+
+static int pvclock_lpt_init(void)
+{
+	struct arm_smccc_res res;
+
+	if (!has_pv_lpt_clock())
+		return 0;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_HV_PV_TIME_LPT, 0, &res);
+	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
+		return 0;
+
+	lpt_info = memremap(res.a0, sizeof(*lpt_info), MEMREMAP_WB);
+	if (!lpt_info) {
+		pr_warn("Failed to map pvclock LPT data structure\n");
+		return -EFAULT;
+	}
+
+	if (le32_to_cpu(lpt_info->revision) != 0 ||
+	    le32_to_cpu(lpt_info->attributes) != 0) {
+		pr_warn_once("Unexpected revision or attributes "
+			     "in pvclock LPT data structure\n");
+		return -EFAULT;
+	}
+
+	static_branch_enable(&pvclock_lpt_key_enabled);
+	pr_info("Using pvclock LPT\n");
+	return 0;
+}
+#else /* CONFIG_ARM64 */
+static int pvclock_lpt_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_ARM64 */
+
+
 /*
  * Architected system timer support.
  */
@@ -1285,6 +1346,10 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	arch_timer_populate_kvm_info();
 
+	ret = pvclock_lpt_init();
+	if (ret)
+		return ret;
+
 	rate = arch_timer_get_cntfrq();
 	arch_timer_of_configure_rate(rate, np);
 
@@ -1613,6 +1678,10 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	arch_timer_populate_kvm_info();
 
+	ret = pvclock_lpt_init();
+	if (ret)
+		return ret;
+
 	/*
 	 * When probing via ACPI, we have no mechanism to override the sysreg
 	 * CNTFRQ value. This *must* be correct.
-- 
1.8.3.1

