Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D6C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524822073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgBLSyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:54:22 -0500
Received: from foss.arm.com ([217.140.110.172]:36504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgBLSyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:54:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E826F30E;
        Wed, 12 Feb 2020 10:54:12 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A1D3F68E;
        Wed, 12 Feb 2020 10:54:11 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH] x86/resctrl: Preserve CDP enable over cpuhp
Date:   Wed, 12 Feb 2020 18:53:59 +0000
Message-Id: <20200212185359.163111-1-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resctrl assumes that all cpus are online when the filesystem is
mounted, and that cpus remember their CDP-enabled state over cpu
hotplug.

This goes wrong when resctrl's CDP-enabled state changes while all
the cpus in a domain are offline.

When a domain comes online, enable (or disable!) CDP to match resctrl's
current setting.

Fixes: 5ff193fbde20 ("x86/intel_rdt: Add basic resctrl filesystem support")
Signed-off-by: James Morse <james.morse@arm.com>

---

Seen on a 'Intel(R) Xeon(R) Gold 5120T CPU @ 2.20GHz' from lenovo, taking
all the cores in one package offline, umount/mount to toggle CDP then
bringing them back: the first core to come online still has the old
CDP state.

This will get called more often than is desirable (worst:3/domain)
but this is better than on every cpu in the domain. Unless someone
can spot a better place to hook it in?
---
 arch/x86/kernel/cpu/resctrl/core.c     | 21 +++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 +++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 89049b343c7a..1210cb65e6d3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -541,6 +541,25 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+/* resctrl's use of CDP may have changed while this domain slept */
+static void domain_reconfigure_cdp(void)
+{
+	bool cdp_enable;
+	struct rdt_resource *r;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	r = &rdt_resources_all[RDT_RESOURCE_L2];
+	cdp_enable = !r->alloc_enabled;
+	if (r->alloc_capable)
+		l2_qos_cfg_update(&cdp_enable);
+
+	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	cdp_enable = !r->alloc_enabled;
+	if (r->alloc_capable)
+		l3_qos_cfg_update(&cdp_enable);
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -578,6 +597,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
+	domain_reconfigure_cdp();
+
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
 		kfree(d);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 181c992f448c..29c92d3e93f5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -602,4 +602,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
 bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
 
+void l3_qos_cfg_update(void *arg);
+void l2_qos_cfg_update(void *arg);
+
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 064e9ef44cd6..e11356011a4a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1804,14 +1804,14 @@ mongroup_create_dir(struct kernfs_node *parent_kn, struct rdtgroup *prgrp,
 	return ret;
 }
 
-static void l3_qos_cfg_update(void *arg)
+void l3_qos_cfg_update(void *arg)
 {
 	bool *enable = arg;
 
 	wrmsrl(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
 }
 
-static void l2_qos_cfg_update(void *arg)
+void l2_qos_cfg_update(void *arg)
 {
 	bool *enable = arg;
 
@@ -1831,6 +1831,9 @@ static int set_cache_qos_cfg(int level, bool enable)
 	struct rdt_domain *d;
 	int cpu;
 
+	/* CDP state is restored during cpuhp, which takes this lock */
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	if (level == RDT_RESOURCE_L3)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
-- 
2.24.1

