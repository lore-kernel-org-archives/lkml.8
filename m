Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38195C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047692053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597528255;
	bh=5Vkn53/6yyG7kvnLHSGm/YtciG8V8xRXOSWn7IPwmow=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TEmnVCRB3X2k90TxtJPq0kpHpyKYRkQlcFnLW9bnLMVW9qJT7l/W9FCYeFS9a8cm8
	 qeCYWglRj1UQzBbQRHBgT5M/r5DjGbkYnYbOQHB7QoCCUx5vp3LKruflKXBfa+1W71
	 VMpoErUh9prNahR00SEbpuU/fTAwC6OZH0XkVWFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHOVux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgHOVun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:43 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCFFC02B8DB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:21:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so12593761ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sDeBJPFntet2GdvIWFJfTtM2LxyJq+enixp6zRLv3D8=;
        b=SzHfMiqJ4e8oHqgddiQFTmGtd2EpuF+aa7GEfqFszn2hLAHaq76gZ71LT/f1wUMWAf
         geELpQBfPMv3SDCKOp1e+YQmeYGBKSuihXYaInLJAH1VZxrzCWjpHUx2AGX3uH+7rC2Q
         og3gGlGMoNKIla6ELV14vZjseQHNjpp9iEXgoriaCPvAR7jX631si4zDkr5BjjmUxvVj
         7eqJnkIXOqkT0kjg3I6GQw7b/p5piobKEC7ec2TwzdOG7jPC/kyKvwUGX0eQMDoTsG9w
         PQoM+6+8o5g6pdvhy/SL2LnQTFKBb9Xkzi04JrO/Hp3BIJPF0soVLJCn0jJzPF0uZ/0g
         KSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=sDeBJPFntet2GdvIWFJfTtM2LxyJq+enixp6zRLv3D8=;
        b=Ens9dtheYRoy0P9P6vMt/5VlRfHHZHbhtSxSZrWGWc06luhm9M9UMyINRFdMaC2/Ru
         cvYYXvDVzi3buQZ7j1ZyXsCZVsvjHZMrOTXLc+29+JhexOscIyq4LpY7lJTKIko83jhQ
         XXs5gtcg5la6zCUHfGdxJLrFH5CqJXZ4accP3i26Ug3acxxgv7Ayzq+8a2a0bc+CR8Fo
         bTzsqki+tzPoo2WtPlIidLVAnUIBetn1dlaPxfpr989rNUUc+LkNqloN3no7SeF9hg0g
         0DM4OJbm7Z8P9mSaR6voLBIFkhklycRmzQApqIkrSk1qH6Tj3xSiSX2sBodRF4iS5VIl
         QDpA==
X-Gm-Message-State: AOAM532fJ/V5Ms9JNMuuy/icK8mt58x82tuUhwsF3b5y5YZQy9rOXdQK
        zCJraIaOGPahmX8t6r4Fw1xfr+CpvCk=
X-Google-Smtp-Source: ABdhPJxMNUK5V7CHtrSeGRZbyi5SUZ1vZNMTmRaBdU30cl91DE8DDo+WbQwMoUfHsQBquvC8vChd0A==
X-Received: by 2002:a17:906:27db:: with SMTP id k27mr6505079ejc.433.1597490495671;
        Sat, 15 Aug 2020 04:21:35 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k24sm8978527ejz.102.2020.08.15.04.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:21:35 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:21:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20200815112133.GA2582267@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-08-15

   # HEAD: bcfd218b66790243ef303c1b35ce59f786ded225 perf/x86/rapl: Add support for Intel SPR platform

Misc fixes, an expansion of perf syscall access to CAP_PERFMON privileged tools,
plus a RAPL HW-enablement for Intel SPR platforms.

 Thanks,

	Ingo

------------------>
Alexey Budankov (1):
      perf/core: Take over CAP_SYS_PTRACE creds to CAP_PERFMON capability

Bhupesh Sharma (1):
      hw_breakpoint: Remove unused __register_perf_hw_breakpoint() declaration

Masami Hiramatsu (1):
      kprobes: Remove show_registers() function prototype

Zhang Rui (3):
      perf/x86/rapl: Fix missing psys sysfs attributes
      perf/x86/rapl: Support multiple RAPL unit quirks
      perf/x86/rapl: Add support for Intel SPR platform


 arch/x86/events/rapl.c        | 46 +++++++++++++++++++++++++++++++++----------
 include/linux/hw_breakpoint.h |  3 ---
 include/linux/kprobes.h       |  1 -
 kernel/events/core.c          |  4 ++--
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 68b38820b10e..67b411f7e8c4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -130,11 +130,17 @@ struct rapl_pmus {
 	struct rapl_pmu		*pmus[];
 };
 
+enum rapl_unit_quirk {
+	RAPL_UNIT_QUIRK_NONE,
+	RAPL_UNIT_QUIRK_INTEL_HSW,
+	RAPL_UNIT_QUIRK_INTEL_SPR,
+};
+
 struct rapl_model {
 	struct perf_msr *rapl_msrs;
 	unsigned long	events;
 	unsigned int	msr_power_unit;
-	bool		apply_quirk;
+	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
@@ -612,14 +618,28 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	switch (rm->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
 	 * "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, V2
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
-	if (rm->apply_quirk)
+	case RAPL_UNIT_QUIRK_INTEL_HSW:
+		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		break;
+	/*
+	 * SPR shares the same DRAM domain energy unit as HSW, plus it
+	 * also has a fixed energy unit for Psys domain.
+	 */
+	case RAPL_UNIT_QUIRK_INTEL_SPR:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
+		break;
+	default:
+		break;
+	}
+
 
 	/*
 	 * Calculate the timer rate:
@@ -665,7 +685,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
 	&rapl_events_gpu_group,
-	&rapl_events_gpu_group,
+	&rapl_events_psys_group,
 	NULL,
 };
 
@@ -698,7 +718,6 @@ static struct rapl_model model_snb = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -707,7 +726,6 @@ static struct rapl_model model_snbep = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -717,7 +735,6 @@ static struct rapl_model model_hsw = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -726,7 +743,7 @@ static struct rapl_model model_hsx = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -734,7 +751,7 @@ static struct rapl_model model_hsx = {
 static struct rapl_model model_knl = {
 	.events		= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -745,14 +762,22 @@ static struct rapl_model model_skl = {
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
-	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
+};
+
+static struct rapl_model model_spr = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM) |
+			  BIT(PERF_RAPL_PSYS),
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_amd_fam17h = {
 	.events		= BIT(PERF_RAPL_PKG),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
@@ -787,6 +812,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
 	{},
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index d7d4250cd1e4..78dd7035d1e5 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -72,7 +72,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context);
 
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
-extern int __register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
 
@@ -119,8 +118,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context)		{ return NULL; }
 static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
-static inline int
-__register_perf_hw_breakpoint(struct perf_event *bp) 	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
 unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)	{ }
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 45b8cdc9fad7..9be1bff4f586 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -227,7 +227,6 @@ extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
 extern int arch_init_kprobes(void);
-extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 extern int arch_populate_kprobe_blacklist(void);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78e69e10482a..41e0cefb429b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11689,7 +11689,7 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_task;
 
 		/*
-		 * Reuse ptrace permission checks for now.
+		 * Preserve ptrace permission check for backwards compatibility.
 		 *
 		 * We must hold exec_update_mutex across this and any potential
 		 * perf_install_in_context() call for this new event to
@@ -11697,7 +11697,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
 			goto err_cred;
 	}
 
