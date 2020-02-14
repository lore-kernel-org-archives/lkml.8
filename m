Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD06EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C17A24654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgBNSaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:30:00 -0500
Received: from foss.arm.com ([217.140.110.172]:43480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbgBNSaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:30:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 436F8101E;
        Fri, 14 Feb 2020 10:29:59 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95CAA3F68E;
        Fri, 14 Feb 2020 10:29:57 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [RFC PATCH v2 1/2] x86/resctrl: Split struct rdt_resource
Date:   Fri, 14 Feb 2020 18:29:46 +0000
Message-Id: <20200214182947.39194-2-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214182947.39194-1-james.morse@arm.com>
References: <20200214182947.39194-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl is the defacto Linux ABI for SoC resource partitioning features.
To support it on another architecture, we need to abstract it from
Intel RDT, and move it to /fs/.

Lets start by splitting struct rdt_resource, (the name is kept for now
to keep the noise down), and add some type-trickery to keep the foreach
helpers working.

Move everything that that is particular to resctrl into a new header
file, keeping the x86 msr specific stuff where it is. resctrl code
paths touching a 'hw' struct indicates where an abstraction is needed.

We split rdt_domain up in a similar way in the next patch.
No change in behaviour, this patch just moves types around.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 231 ++++++++++++----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   6 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 117 +++--------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  21 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  48 ++---
 include/linux/resctrl.h                   | 100 ++++++++++
 7 files changed, 299 insertions(+), 228 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f2968fb6fb9a..ce02f3f35b44 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -57,119 +57,133 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 	      struct rdt_resource *r);
 
-#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].domains)
+#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].resctrl.domains)
 
-struct rdt_resource rdt_resources_all[] = {
+struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
 	{
-		.rid			= RDT_RESOURCE_L3,
-		.name			= "L3",
-		.domains		= domain_init(RDT_RESOURCE_L3),
+		.resctrl = {
+			.rid			= RDT_RESOURCE_L3,
+			.name			= "L3",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 1,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 1,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L3DATA] =
 	{
-		.rid			= RDT_RESOURCE_L3DATA,
-		.name			= "L3DATA",
-		.domains		= domain_init(RDT_RESOURCE_L3DATA),
+		.resctrl = {
+			.rid			= RDT_RESOURCE_L3DATA,
+			.name			= "L3DATA",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3DATA),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L3CODE] =
 	{
-		.rid			= RDT_RESOURCE_L3CODE,
-		.name			= "L3CODE",
-		.domains		= domain_init(RDT_RESOURCE_L3CODE),
+		.resctrl = {
+			.rid			= RDT_RESOURCE_L3CODE,
+			.name			= "L3CODE",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 1,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3CODE),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 1,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2] =
 	{
-		.rid			= RDT_RESOURCE_L2,
-		.name			= "L2",
-		.domains		= domain_init(RDT_RESOURCE_L2),
+		.resctrl = {
+			.rid			= RDT_RESOURCE_L2,
+			.name			= "L2",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 1,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 1,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2DATA] =
 	{
-		.rid			= RDT_RESOURCE_L2DATA,
-		.name			= "L2DATA",
-		.domains		= domain_init(RDT_RESOURCE_L2DATA),
+		.resctrl = {
+			.rid			= RDT_RESOURCE_L2DATA,
+			.name			= "L2DATA",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2DATA),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2CODE] =
 	{
-		.rid			= RDT_RESOURCE_L2CODE,
-		.name			= "L2CODE",
-		.domains		= domain_init(RDT_RESOURCE_L2CODE),
+		.resctrl = {
+			.rid			= RDT_RESOURCE_L2CODE,
+			.name			= "L2CODE",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 1,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2CODE),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 1,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_MBA] =
 	{
-		.rid			= RDT_RESOURCE_MBA,
-		.name			= "MB",
-		.domains		= domain_init(RDT_RESOURCE_MBA),
-		.cache_level		= 3,
-		.format_str		= "%d=%*u",
-		.fflags			= RFTYPE_RES_MB,
+		.resctrl = {
+			.rid			= RDT_RESOURCE_MBA,
+			.name			= "MB",
+			.cache_level		= 3,
+			.domains		= domain_init(RDT_RESOURCE_MBA),
+			.format_str		= "%d=%*u",
+			.fflags			= RFTYPE_RES_MB,
+		},
 	},
 };
 
@@ -198,7 +212,7 @@ static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
  */
 static inline void cache_alloc_hsw_probe(void)
 {
-	struct rdt_resource *r  = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_resource *r  = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 	u32 l, h, max_cbm = BIT_MASK(20) - 1;
 
 	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
@@ -224,7 +238,7 @@ static inline void cache_alloc_hsw_probe(void)
 bool is_mba_sc(struct rdt_resource *r)
 {
 	if (!r)
-		return rdt_resources_all[RDT_RESOURCE_MBA].membw.mba_sc;
+		return rdt_resources_all[RDT_RESOURCE_MBA].resctrl.membw.mba_sc;
 
 	return r->membw.mba_sc;
 }
@@ -321,8 +335,8 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 
 static void rdt_get_cdp_config(int level, int type)
 {
-	struct rdt_resource *r_l = &rdt_resources_all[level];
-	struct rdt_resource *r = &rdt_resources_all[type];
+	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
+	struct rdt_resource *r = &rdt_resources_all[type].resctrl;
 
 	r->num_closid = r_l->num_closid / 2;
 	r->cache.cbm_len = r_l->cache.cbm_len;
@@ -353,9 +367,10 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + i, d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, d->ctrl_val[i]);
 }
 
 /*
@@ -377,19 +392,21 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
 		struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
 }
 
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -408,13 +425,14 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 void rdt_ctrl_update(void *arg)
 {
 	struct msr_param *m = arg;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
 	struct rdt_resource *r = m->res;
 	int cpu = smp_processor_id();
 	struct rdt_domain *d;
 
 	d = get_domain_from_cpu(cpu, r);
 	if (d) {
-		r->msr_update(d, m, r);
+		hw_res->msr_update(d, m, r);
 		return;
 	}
 	pr_warn_once("cpu %d not found in any domain for resource %s\n",
@@ -472,6 +490,7 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct msr_param m;
 	u32 *dc, *dm;
 
@@ -491,7 +510,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = r->num_closid;
-	r->msr_update(d, &m, r);
+	hw_res->msr_update(d, &m, r);
 	return 0;
 }
 
@@ -639,7 +658,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3]) {
+	if (r == &rdt_resources_all[RDT_RESOURCE_L3].resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0);
@@ -815,9 +834,9 @@ static __init bool get_mem_config(void)
 		return false;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		return __get_mem_config_intel(&rdt_resources_all[RDT_RESOURCE_MBA]);
+		return __get_mem_config_intel(&rdt_resources_all[RDT_RESOURCE_MBA].resctrl);
 	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		return __rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]);
+		return __rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA].resctrl);
 
 	return false;
 }
@@ -833,14 +852,14 @@ static __init bool get_rdt_alloc_resources(void)
 		return false;
 
 	if (rdt_cpu_has(X86_FEATURE_CAT_L3)) {
-		rdt_get_cache_alloc_cfg(1, &rdt_resources_all[RDT_RESOURCE_L3]);
+		rdt_get_cache_alloc_cfg(1, &rdt_resources_all[RDT_RESOURCE_L3].resctrl);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
 		/* CPUID 0x10.2 fields are same format at 0x10.1 */
-		rdt_get_cache_alloc_cfg(2, &rdt_resources_all[RDT_RESOURCE_L2]);
+		rdt_get_cache_alloc_cfg(2, &rdt_resources_all[RDT_RESOURCE_L2].resctrl);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L2))
 			rdt_get_cdp_l2_config();
 		ret = true;
@@ -864,7 +883,7 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
-	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
+	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3].resctrl);
 }
 
 static __init void __check_quirks_intel(void)
@@ -898,9 +917,14 @@ static __init bool get_rdt_resources(void)
 
 static __init void rdt_init_res_defs_intel(void)
 {
+	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
+	int i;
+
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		hw_res = &rdt_resources_all[i];
+		r = &rdt_resources_all[i].resctrl;
 
-	for_each_rdt_resource(r) {
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L3DATA ||
 		    r->rid == RDT_RESOURCE_L3CODE ||
@@ -909,8 +933,8 @@ static __init void rdt_init_res_defs_intel(void)
 		    r->rid == RDT_RESOURCE_L2CODE)
 			r->cache.arch_has_sparse_bitmaps = false;
 		else if (r->rid == RDT_RESOURCE_MBA) {
-			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
-			r->msr_update = mba_wrmsr_intel;
+			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
+			hw_res->msr_update = mba_wrmsr_intel;
 			r->parse_ctrlval = parse_bw;
 		}
 	}
@@ -918,9 +942,14 @@ static __init void rdt_init_res_defs_intel(void)
 
 static __init void rdt_init_res_defs_amd(void)
 {
+	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
+	int i;
+
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		hw_res = &rdt_resources_all[i];
+		r = &rdt_resources_all[i].resctrl;
 
-	for_each_rdt_resource(r) {
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L3DATA ||
 		    r->rid == RDT_RESOURCE_L3CODE ||
@@ -929,8 +958,8 @@ static __init void rdt_init_res_defs_amd(void)
 		    r->rid == RDT_RESOURCE_L2CODE)
 			r->cache.arch_has_sparse_bitmaps = true;
 		else if (r->rid == RDT_RESOURCE_MBA) {
-			r->msr_base = MSR_IA32_MBA_BW_BASE;
-			r->msr_update = mba_wrmsr_amd;
+			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
+			hw_res->msr_update = mba_wrmsr_amd;
 			r->parse_ctrlval = parse_bw;
 		}
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 38df876feb54..c90aa79d90b9 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -446,6 +446,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
+	struct rdt_hw_resource *hw_res;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -465,7 +466,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	domid = md.u.domid;
 	evtid = md.u.evtid;
 
-	r = &rdt_resources_all[resid];
+	hw_res = &rdt_resources_all[resid];
+	r = &hw_res->resctrl;
 	d = rdt_find_domain(r, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
@@ -479,7 +481,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	else if (rr.val & RMID_VAL_UNAVAIL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val * r->mon_scale);
+		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
 
 out:
 	rdtgroup_kn_unlock(of->kn);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0172a87de814..5e69f709b729 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_INTERNAL_H
 #define _ASM_X86_RESCTRL_INTERNAL_H
 
+#include <linux/resctrl.h>
 #include <linux/sched.h>
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
@@ -340,45 +341,6 @@ struct msr_param {
 	int			high;
 };
 
-/**
- * struct rdt_cache - Cache allocation related data
- * @cbm_len:		Length of the cache bit mask
- * @min_cbm_bits:	Minimum number of consecutive bits to be set
- * @cbm_idx_mult:	Multiplier of CBM index
- * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
- *			closid * cbm_idx_multi + cbm_idx_offset
- *			in a cache bit mask
- * @shareable_bits:	Bitmask of shareable resource with other
- *			executing entities
- * @arch_has_sparse_bitmaps:   True if a bitmap like f00f is valid.
- */
-struct rdt_cache {
-	unsigned int	cbm_len;
-	unsigned int	min_cbm_bits;
-	unsigned int	cbm_idx_mult;
-	unsigned int	cbm_idx_offset;
-	unsigned int	shareable_bits;
-	bool		arch_has_sparse_bitmaps;
-};
-
-/**
- * struct rdt_membw - Memory bandwidth allocation related data
- * @min_bw:		Minimum memory bandwidth percentage user can request
- * @bw_gran:		Granularity at which the memory bandwidth is allocated
- * @arch_needs_linear:  True if we can't configure non-linear resources
- * @delay_linear:	True if memory B/W delay is in linear scale
- * @mba_sc:		True if MBA software controller(mba_sc) is enabled
- * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
- */
-struct rdt_membw {
-	u32		min_bw;
-	u32		bw_gran;
-	u32		delay_linear;
-	bool		arch_needs_linear;
-	bool		mba_sc;
-	u32		*mb_map;
-};
-
 static inline bool is_llc_occupancy_enabled(void)
 {
 	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
@@ -411,55 +373,24 @@ struct rdt_parse_data {
 };
 
 /**
- * struct rdt_resource - attributes of an RDT resource
- * @rid:		The index of the resource
- * @alloc_enabled:	Is allocation enabled on this machine
- * @mon_enabled:	Is monitoring enabled for this feature
- * @alloc_capable:	Is allocation available on this machine
- * @mon_capable:	Is monitor feature available on this machine
- * @name:		Name to use in "schemata" file
- * @num_closid:		Number of CLOSIDs available
- * @cache_level:	Which cache level defines scope of this resource
- * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * struct rdt_hw_resource - hw attributes of an RDT resource
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
- * @data_width:		Character width of data when displaying
- * @domains:		All domains for this resource
- * @cache:		Cache allocation related data
- * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:		List of monitoring events
- * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
- * @fflags:		flags to choose base and info files
  */
-struct rdt_resource {
-	int			rid;
-	bool			alloc_enabled;
-	bool			mon_enabled;
-	bool			alloc_capable;
-	bool			mon_capable;
-	char			*name;
-	int			num_closid;
-	int			cache_level;
-	u32			default_ctrl;
+struct rdt_hw_resource {
+	struct rdt_resource     resctrl;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
-	int			data_width;
-	struct list_head	domains;
-	struct rdt_cache	cache;
-	struct rdt_membw	membw;
-	const char		*format_str;
-	int (*parse_ctrlval)(struct rdt_parse_data *data,
-			     struct rdt_resource *r,
-			     struct rdt_domain *d);
-	struct list_head	evt_list;
-	int			num_rmid;
 	unsigned int		mon_scale;
-	unsigned long		fflags;
 };
 
+static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
+{
+	return container_of(r, struct rdt_hw_resource, resctrl);
+}
+
 int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d);
 int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
@@ -467,7 +398,7 @@ int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
 
 extern struct mutex rdtgroup_mutex;
 
-extern struct rdt_resource rdt_resources_all[];
+extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
@@ -486,33 +417,37 @@ enum {
 	RDT_NUM_RESOURCES,
 };
 
+static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
+
+	hw_res++;
+	return &hw_res->resctrl;
+}
+
 #define for_each_rdt_resource(r)					      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)
+	for (r = &rdt_resources_all[0].resctrl;				      \
+	     r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;		      \
+	     r = resctrl_inc(r))
 
 #define for_each_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->alloc_capable || r->mon_capable)
 
 #define for_each_alloc_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->alloc_capable)
 
 #define for_each_mon_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->mon_capable)
 
 #define for_each_alloc_enabled_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->alloc_enabled)
 
 #define for_each_mon_enabled_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->mon_enabled)
 
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index a02a7f886a0a..cd34a06cec68 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -111,7 +111,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 
 	/*
 	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
@@ -169,7 +169,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	int cpu;
 	u64 val;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 
 	entry->busy = 0;
 	cpu = get_cpu();
@@ -270,7 +270,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
 	u64 tval, cur_bw, chunks;
 
@@ -280,7 +280,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval);
 	m->chunks += chunks;
-	cur_bw = (chunks * r->mon_scale) >> 20;
+	cur_bw = (chunks * hw_res->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
@@ -353,6 +353,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
+	struct rdt_hw_resource *hw_r_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
@@ -362,7 +363,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	if (!is_mbm_local_enabled())
 		return;
 
-	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	hw_r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	r_mba = &hw_r_mba->resctrl;
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
 	pmbm_data = &dom_mbm->mbm_local[rmid];
@@ -411,7 +413,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		return;
 	}
 
-	cur_msr = r_mba->msr_base + closid;
+	cur_msr = hw_r_mba->msr_base + closid;
 	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
 	dom_mba->ctrl_val[closid] = new_msr_val;
 
@@ -475,7 +477,7 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 	d = container_of(work, struct rdt_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
@@ -605,10 +607,11 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
-	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
 
 	/*
@@ -621,7 +624,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
 
 	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	resctrl_cqm_threshold /= r->mon_scale;
+	resctrl_cqm_threshold /= hw_res->mon_scale;
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d7623e1b927d..29ace6b60cda 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -684,8 +684,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 *   resource, the portion of cache used by it should be made
 	 *   unavailable to all future allocations from both resources.
 	 */
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled ||
-	    rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled) {
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled ||
+	    rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled) {
 		rdt_last_cmd_puts("CDP enabled\n");
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c84b1f355a9a..f3106dfc4da6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1021,8 +1021,9 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 				  struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	seq_printf(seq, "%u\n", resctrl_cqm_threshold * r->mon_scale);
+	seq_printf(seq, "%u\n", resctrl_cqm_threshold * hw_res->mon_scale);
 
 	return 0;
 }
@@ -1030,7 +1031,7 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res;
 	unsigned int bytes;
 	int ret;
 
@@ -1041,7 +1042,8 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
 
-	resctrl_cqm_threshold = bytes / r->mon_scale;
+	hw_res = resctrl_to_arch_res(of->kn->parent->priv);
+	resctrl_cqm_threshold = bytes / hw_res->mon_scale;
 
 	return nbytes;
 }
@@ -1099,16 +1101,16 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 
 	switch (r->rid) {
 	case RDT_RESOURCE_L3DATA:
-		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE];
+		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE].resctrl;
 		break;
 	case RDT_RESOURCE_L3CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA];
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl;
 		break;
 	case RDT_RESOURCE_L2DATA:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE];
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE].resctrl;
 		break;
 	case RDT_RESOURCE_L2CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA];
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl;
 		break;
 	default:
 		ret = -ENOENT;
@@ -1830,7 +1832,7 @@ static void l2_qos_cfg_update(void *arg)
 
 static inline bool is_mba_linear(void)
 {
-	return rdt_resources_all[RDT_RESOURCE_MBA].membw.delay_linear;
+	return rdt_resources_all[RDT_RESOURCE_MBA].resctrl.membw.delay_linear;
 }
 
 static int set_cache_qos_cfg(int level, bool enable)
@@ -1851,7 +1853,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	r_l = &rdt_resources_all[level];
+	r_l = &rdt_resources_all[level].resctrl;
 	list_for_each_entry(d, &r_l->domains, list) {
 		/* Pick one CPU from each domain instance to update MSR */
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
@@ -1877,7 +1879,7 @@ static int set_cache_qos_cfg(int level, bool enable)
  */
 static int set_mba_sc(bool mba_sc)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].resctrl;
 	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
@@ -1893,9 +1895,9 @@ static int set_mba_sc(bool mba_sc)
 
 static int cdp_enable(int level, int data_type, int code_type)
 {
-	struct rdt_resource *r_ldata = &rdt_resources_all[data_type];
-	struct rdt_resource *r_lcode = &rdt_resources_all[code_type];
-	struct rdt_resource *r_l = &rdt_resources_all[level];
+	struct rdt_resource *r_ldata = &rdt_resources_all[data_type].resctrl;
+	struct rdt_resource *r_lcode = &rdt_resources_all[code_type].resctrl;
+	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
 	int ret;
 
 	if (!r_l->alloc_capable || !r_ldata->alloc_capable ||
@@ -1925,13 +1927,13 @@ static int cdpl2_enable(void)
 
 static void cdp_disable(int level, int data_type, int code_type)
 {
-	struct rdt_resource *r = &rdt_resources_all[level];
+	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
 
 	r->alloc_enabled = r->alloc_capable;
 
-	if (rdt_resources_all[data_type].alloc_enabled) {
-		rdt_resources_all[data_type].alloc_enabled = false;
-		rdt_resources_all[code_type].alloc_enabled = false;
+	if (rdt_resources_all[data_type].resctrl.alloc_enabled) {
+		rdt_resources_all[data_type].resctrl.alloc_enabled = false;
+		rdt_resources_all[code_type].resctrl.alloc_enabled = false;
 		set_cache_qos_cfg(level, false);
 	}
 }
@@ -1948,9 +1950,9 @@ static void cdpl2_disable(void)
 
 static void cdp_disable_all(void)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
 		cdpl3_disable();
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled)
 		cdpl2_disable();
 }
 
@@ -2101,7 +2103,7 @@ static int rdt_get_tree(struct fs_context *fc)
 		static_branch_enable_cpuslocked(&rdt_enable_key);
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3];
+		r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
@@ -3092,13 +3094,13 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
 		seq_puts(seq, ",cdp");
 
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled)
 		seq_puts(seq, ",cdpl2");
 
-	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA]))
+	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].resctrl))
 		seq_puts(seq, ",mba_MBps");
 
 	return 0;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9b05af9b3e28..a8a499c6644b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,8 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/pid.h>
 
 #ifdef CONFIG_PROC_CPU_RESCTRL
@@ -13,4 +15,102 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+struct rdt_domain;
+
+/**
+ * struct resctrl_cache - Cache allocation related data
+ * @cbm_len:		Length of the cache bit mask
+ * @min_cbm_bits:	Minimum number of consecutive bits to be set
+ * @cbm_idx_mult:	Multiplier of CBM index
+ * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
+ *			closid * cbm_idx_multi + cbm_idx_offset
+ *			in a cache bit mask
+ * @shareable_bits:	Bitmask of shareable resource with other
+ *			executing entities
+ * @arch_has_sparse_bitmaps:   True if a bitmap like f00f is valid.
+ */
+struct resctrl_cache {
+	u32		cbm_len;
+	u32		min_cbm_bits;
+	unsigned int	cbm_idx_mult;
+	unsigned int	cbm_idx_offset;
+	u32		shareable_bits;
+	bool		arch_has_sparse_bitmaps;
+};
+
+/**
+ * struct resctrl_membw - Memory bandwidth allocation related data
+ * @min_bw:		Minimum memory bandwidth percentage user can request
+ * @bw_gran:		Granularity at which the memory bandwidth is allocated
+ * @delay_linear:	True if memory B/W delay is in linear scale
+ * @arch_needs_linear:  True if we can't configure non-linear resources
+ * @mba_sc:		True if MBA software controller(mba_sc) is enabled
+ * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
+ */
+struct resctrl_membw {
+	u32		min_bw;
+	u32		bw_gran;
+	u32		delay_linear;
+	bool		arch_needs_linear;
+	bool		mba_sc;
+	u32		*mb_map;
+};
+
+struct rdt_parse_data;
+
+/**
+ * @rid:		The index of the resource
+ * @alloc_enabled:	Is allocation enabled on this machine
+ * @mon_enabled:	Is monitoring enabled for this feature
+ * @alloc_capable:	Is allocation available on this machine
+ * @mon_capable:	Is monitor feature available on this machine
+ *
+ * @cache_level:	Which cache level defines scope of this resource
+ *
+ * @cache:		If the component has cache controls, their properties.
+ * @membw:		If the component has bandwidth controls, their properties.
+ *
+ * @num_closid:		Number of CLOSIDs available.
+ * @num_rmid:		Number of RMIDs available.
+ *
+ * @domains:		All domains for this resource
+ *
+ * @name:		Name to use in "schemata" file.
+ * @data_width:		Character width of data when displaying.
+ * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * @format_str:		Per resource format string to show domain value
+ * @parse_ctrlval:	Per resource function pointer to parse control values
+ *
+ * @evt_list:		List of monitoring events
+ * @fflags:		flags to choose base and info files
+ */
+struct rdt_resource {
+	int			rid;
+	bool			alloc_enabled;
+	bool			mon_enabled;
+	bool			alloc_capable;
+	bool			mon_capable;
+
+	int			cache_level;
+
+	struct resctrl_cache	cache;
+	struct resctrl_membw	membw;
+
+	int			num_closid;
+	int			num_rmid;
+
+	struct list_head	domains;
+
+	char			*name;
+	int			data_width;
+	u32			default_ctrl;
+	const char		*format_str;
+	int			(*parse_ctrlval)(struct rdt_parse_data *data,
+						 struct rdt_resource *r,
+						 struct rdt_domain *d);
+	struct list_head	evt_list;
+	unsigned long		fflags;
+
+};
+
 #endif /* _RESCTRL_H */
-- 
2.24.1

