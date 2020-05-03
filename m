Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02331C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6BF5206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgECSvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 14:51:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:60642 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgECSvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 14:51:03 -0400
IronPort-SDR: uUy8WiHCbH6gfBfgiOHXC7KrGJgPPEUgwb6Bn4bor5dvGoBvTdNxJeqiF606KOB2JevvqIjW15
 TqJZ/OS+QLYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 11:51:02 -0700
IronPort-SDR: yUEPE+sO+9eC2heVlrZzzKNdqArjm0qemmMu8e5R4SvkxMNw+OEvBGqJIw0TdEYcG7cBK4+krK
 fwIeh+AZgLxA==
X-IronPort-AV: E=Sophos;i="5.73,349,1583222400"; 
   d="scan'208";a="259128052"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.112.30]) ([10.254.112.30])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 11:51:02 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM counter
 width
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
 <20200429181149.GE16407@zn.tnic>
 <6fb58472-88f2-925b-3a4e-4692957a9582@intel.com>
 <20200430095913.GA3996@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4288b11f-d4da-d311-7112-fa05887f50b4@intel.com>
Date:   Sun, 3 May 2020 11:51:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430095913.GA3996@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 4/30/2020 2:59 AM, Borislav Petkov wrote:
> On Wed, Apr 29, 2020 at 11:42:03AM -0700, Reinette Chatre wrote:
>> This would essentially be resubmitting [1] though. Do you expect that
>> this change would receive a different reception at this time?
> 
> Right, Thomas and I talked it over a bit last night. So the proper
> thing to do is to read all that information *once* and put it in
> boot_cpu_data. Because that information is replicated the same over
> CPUID on each core. If there's per-CPU stuff, then it should remain
> per-CPU but looking at how the RDT code uses boot_cpu_data, I'd say this
> is global info.
> 
> So, it should be parsed once on the BSP during boot and put into
> boot_cpu_data. And then silly stuff like x86_init_cache_qos() should go
> away too.

You are correct. I looked through the hardware errata and confirmed with
a few people very knowledgeable about the history and technical details
of CMT that x86_init_cache_qos() is not necessary. There exists no
platform where the CPUs on a platform that support CMT either does not
report a RMID or report different RMID.

Also, for the existing implementation moving init_cqm() to
early_identify_cpu() makes sense for all the reasons you mention.

I am struggling with what should follow ...

> 
> If this info is needed on Intel only, then it should be parsed in
> cpu/intel.c, in a ->c_bsp_init helper and if it is needed on AMD too,
> then a function which does this should be called by the respective
> c_bsp_init helper.

Using c_bsp_init may be needed to obtain the Intel-only property that
the patch that started this originally attempted to do. AMD and Intel
support the same CPUID leaf and two sub-leaves ... only differing in the
one new register that is defined for Intel but undefined for AMD.

I am concerned with how I am interpreting your suggestion here since my
interpretation does end up with duplicate code between the two
c_bsp_init helpers. Below is this snippet - is this how you envisioned
this change? (Please note that in this snippet you would find init_cqm()
moved from early_identify_cpu(), this change is thus done with the
assumption that your earlier suggestions have all been applied already.)

diff --git a/arch/x86/include/asm/processor.h
b/arch/x86/include/asm/processor.h
index 3bcf27caf6c9..76f86fdb02af 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -116,6 +116,7 @@ struct cpuinfo_x86 {
 	/* Cache QoS architectural values: */
 	int			x86_cache_max_rmid;	/* max index */
 	int			x86_cache_occ_scale;	/* scale to bytes */
+	int			x86_cache_mbm_width_offset;
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 547ad7bbf0e0..2e6c718ba793 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -512,6 +512,38 @@ static void early_init_amd_mc(struct cpuinfo_x86 *c)
 #endif
 }

+/*
+ * Significant overlap with the Intel initialization found in
+ * init_llc_monitoring_intel() since CPUID leaf 0xF subleaf 0x1
+ * differ in all but one register (used to initialize
+ * x86_cache_mbm_width_offset) that is undefined on AMD.
+ */
+static void init_llc_monitoring_amd(struct cpuinfo_x86 *c)
+{
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+		c->x86_cache_max_rmid  = -1;
+		c->x86_cache_occ_scale = -1;
+		c->x86_cache_mbm_width_offset = -1;
+		return;
+	}
+
+	/* will be overridden if occupancy monitoring exists */
+	c->x86_cache_max_rmid = cpuid_ebx(0xf);
+
+	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
+		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
+
+		c->x86_cache_max_rmid  = ecx;
+		c->x86_cache_occ_scale = ebx;
+		c->x86_cache_mbm_width_offset = -1;
+	}
+}
+
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {

@@ -597,6 +629,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
 		}
 	}
+
+	init_llc_monitoring_amd(c);
 }

 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3151a366b0a8..d07809286b95 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -854,30 +854,6 @@ static void init_speculation_control(struct
cpuinfo_x86 *c)
 	}
 }

-static void init_cqm(struct cpuinfo_x86 *c)
-{
-	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
-		c->x86_cache_max_rmid  = -1;
-		c->x86_cache_occ_scale = -1;
-		return;
-	}
-
-	/* will be overridden if occupancy monitoring exists */
-	c->x86_cache_max_rmid = cpuid_ebx(0xf);
-
-	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
-	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
-	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
-		u32 eax, ebx, ecx, edx;
-
-		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
-		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
-
-		c->x86_cache_max_rmid  = ecx;
-		c->x86_cache_occ_scale = ebx;
-	}
-}
-
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -1212,7 +1188,6 @@ static void __init early_identify_cpu(struct
cpuinfo_x86 *c)

 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
-		init_cqm(c);

 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index bf08d4508ecb..0775090bd5e2 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -322,6 +322,46 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		detect_ht_early(c);
 }

+/*
+ * Significant overlap with the AMD initialization found in
+ * init_llc_monitoring_amd() since CPUID leaf 0xF subleaf 0x1
+ * differ in all but one register (used to initialize
+ * x86_cache_mbm_width_offset) that is undefined on AMD.
+ */
+static void init_llc_monitoring_intel(struct cpuinfo_x86 *c)
+{
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+		c->x86_cache_max_rmid  = -1;
+		c->x86_cache_occ_scale = -1;
+		c->x86_cache_mbm_width_offset = -1;
+		return;
+	}
+
+	/* will be overridden if occupancy monitoring exists */
+	c->x86_cache_max_rmid = cpuid_ebx(0xf);
+
+	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
+		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
+
+		c->x86_cache_max_rmid  = ecx;
+		c->x86_cache_occ_scale = ebx;
+		c->x86_cache_mbm_width_offset = eax & 0xff;
+	}
+}
+
+/*
+ * Initialization work to be done only once during boot.
+ */
+static void bsp_init_intel(struct cpuinfo_x86 *c)
+{
+	init_llc_monitoring_intel(c);
+}
+
 #ifdef CONFIG_X86_32
 /*
  *	Early probe support logic for ppro memory erratum #50
@@ -961,6 +1001,7 @@ static const struct cpu_dev intel_cpu_dev = {
 #endif
 	.c_detect_tlb	= intel_detect_tlb,
 	.c_early_init   = early_init_intel,
+	.c_bsp_init	= bsp_init_intel,
 	.c_init		= init_intel,
 	.c_x86_vendor	= X86_VENDOR_INTEL,
 };

> 
> Then all its users can continue reading it out of boot_cpu_data and
> future RDT hw info can be added there.

Understood.

Thank you very much

Reinette
