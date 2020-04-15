Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC55DC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A4420737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gUpoSEeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393897AbgDOKlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408536AbgDOKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:24:20 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05838C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D67l6ZrBlbjgqm81fdLUU6QzODyFsUdr+ktwMeHypO4=; b=gUpoSEebGSj3l7vjKUnUekc+RV
        0l5beNce78Gpg6mslD2nRFNhy0MTORuiFP9mnrQ0GIeALgKaazntpCPBLrF78SB0FOdD+lx90FWFc
        PbgfCdLmH05zIm/8qvAmOXpTvEHDukwh6rruhMm9lC7w1u8FPHTt5xW9bzXMvW92XPXGKbwFrJXcQ
        sbw9Xptahk90YIG8aAIjBo3EebbQyRe3HfNY3DRcoCNkh2j8lhwDzpPigNbPs1Cw47ovTB7WtiB2O
        yzMXR6tPlHZvFBl/5PUqkF7Ws2V0Lzu0hMuBJzWFvOh9ooKFTP0fhMuyW4lt5K/Y3qKyfNPq3sQuY
        Ahwjwttg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOfCp-0007KT-GR; Wed, 15 Apr 2020 10:23:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73A223006E0;
        Wed, 15 Apr 2020 12:23:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DB3B2BC6F2DD; Wed, 15 Apr 2020 12:23:40 +0200 (CEST)
Date:   Wed, 15 Apr 2020 12:23:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     CodyYao-oc <CodyYao-oc@zhaoxin.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        cooperyan@zhaoxin.com, codyyao@zhaoxin.com
Subject: Re: [PATCH] x86/perf: Add hardware performance events support for
 Zhaoxin CPU.
Message-ID: <20200415102340.GB20730@hirez.programming.kicks-ass.net>
References: <1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 11:14:29AM +0800, CodyYao-oc wrote:
> Zhaoxin CPU has provided facilities for monitoring performance
> via PMU(Performance Monitor Unit), but the functionality is unused so far.
> Therefore, add support for zhaoxin pmu to make performance related
> hardware events available.
> 
> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> Reported-by: kbuild test robot <lkp@intel.com>

What's that reported-by thing? Did the robot complain you didn't have a
PMU implementation?

Anyway, I've made the below changes to the patch.

---
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -618,6 +618,7 @@ struct x86_pmu {
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
+			enabled_ack		:1,
 			counter_freezing	:1;
 	/*
 	 * sysfs attrs
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -357,10 +357,9 @@ static int zhaoxin_pmu_handle_irq(struct
 {
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
-	int bit;
-	u64 status;
-	bool is_zxc = false;
 	int handled = 0;
+	u64 status;
+	int bit;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
@@ -369,14 +368,8 @@ static int zhaoxin_pmu_handle_irq(struct
 	if (!status)
 		goto done;
 
-	if (boot_cpu_data.x86 == 0x06 &&
-		(boot_cpu_data.x86_model == 0x0f ||
-			boot_cpu_data.x86_model == 0x19))
-		is_zxc = true;
 again:
-
-	/*Clearing status works only if the global control is enable on zxc.*/
-	if (is_zxc)
+	if (x86_pmu.enabled_ack)
 		zxc_pmu_ack_status(status);
 	else
 		zhaoxin_pmu_ack_status(status);
@@ -504,12 +497,10 @@ static __init void zhaoxin_arch_events_q
 	int bit;
 
 	/* disable event that reported as not presend by cpuid */
-	for_each_set_bit(bit, x86_pmu.events_mask,
-			ARRAY_SIZE(zx_arch_events_map)) {
-
+	for_each_set_bit(bit, x86_pmu.events_mask, ARRAY_SIZE(zx_arch_events_map)) {
 		zx_pmon_event_map[zx_arch_events_map[bit].id] = 0;
 		pr_warn("CPUID marked event: \'%s\' unavailable\n",
-				zx_arch_events_map[bit].name);
+			zx_arch_events_map[bit].name);
 	}
 }
 
@@ -534,12 +525,12 @@ __init int zhaoxin_pmu_init(void)
 		return -ENODEV;
 
 	version = eax.split.version_id;
-	if (version == 2) {
-		x86_pmu = zhaoxin_pmu;
-		pr_info("Version check pass!\n");
-	} else
+	if (version != 2)
 		return -ENODEV;
 
+	x86_pmu = zhaoxin_pmu;
+	pr_info("Version check pass!\n");
+
 	x86_pmu.version			= version;
 	x86_pmu.num_counters		= eax.split.num_counters;
 	x86_pmu.cntval_bits		= eax.split.bit_width;
@@ -552,11 +543,13 @@ __init int zhaoxin_pmu_init(void)
 
 	switch (boot_cpu_data.x86) {
 	case 0x06:
-		if (boot_cpu_data.x86_model == 0x0f ||
-			boot_cpu_data.x86_model == 0x19) {
+		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
 
 			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
 
+			/* Clearing status works only if the global control is enable on zxc. */
+			x86_pmu.enabled_ack = 1;
+
 			x86_pmu.event_constraints = zxc_event_constraints;
 			zx_pmon_event_map[PERF_COUNT_HW_INSTRUCTIONS] = 0;
 			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES] = 0;
@@ -564,40 +557,37 @@ __init int zhaoxin_pmu_init(void)
 			zx_pmon_event_map[PERF_COUNT_HW_BUS_CYCLES] = 0;
 
 			pr_cont("ZXC events, ");
-		} else
-			return -ENODEV;
-		break;
+			break;
+		}
+		return -ENODEV;
+
 	case 0x07:
 		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
-		X86_CONFIG(.event = 0x01, .umask = 0x01, .inv = 0x01, .cmask = 0x01);
+			X86_CONFIG(.event = 0x01, .umask = 0x01, .inv = 0x01, .cmask = 0x01);
 
 		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
-		X86_CONFIG(.event = 0x0f, .umask = 0x04, .inv = 0, .cmask = 0);
+			X86_CONFIG(.event = 0x0f, .umask = 0x04, .inv = 0, .cmask = 0);
 
 		switch (boot_cpu_data.x86_model) {
 		case 0x1b:
 			memcpy(hw_cache_event_ids, zxd_hw_cache_event_ids,
-				sizeof(hw_cache_event_ids));
+			       sizeof(hw_cache_event_ids));
 
 			x86_pmu.event_constraints = zxd_event_constraints;
 
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]
-				= 0x0700;
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES]
-				= 0x0709;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0700;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0709;
 
 			pr_cont("ZXD events, ");
 			break;
 		case 0x3b:
 			memcpy(hw_cache_event_ids, zxe_hw_cache_event_ids,
-				sizeof(hw_cache_event_ids));
+			       sizeof(hw_cache_event_ids));
 
 			x86_pmu.event_constraints = zxd_event_constraints;
 
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]
-				= 0x0028;
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES]
-				= 0x0029;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0028;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0029;
 
 			pr_cont("ZXE events, ");
 			break;
@@ -605,13 +595,13 @@ __init int zhaoxin_pmu_init(void)
 			return -ENODEV;
 		}
 		break;
+
 	default:
 		return -ENODEV;
 	}
 
 	x86_pmu.intel_ctrl = (1 << (x86_pmu.num_counters)) - 1;
-	x86_pmu.intel_ctrl |=
-		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+	x86_pmu.intel_ctrl |= ((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
 
 	if (x86_pmu.event_constraints) {
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -63,6 +63,7 @@ static inline unsigned int nmi_perfctr_m
 		case 15:
 			return msr - MSR_P4_BPU_PERFCTR0;
 		}
+		fallthrough;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_PERFCTR0;
@@ -95,6 +96,7 @@ static inline unsigned int nmi_evntsel_m
 		case 15:
 			return msr - MSR_P4_BSU_ESCR0;
 		}
+		fallthrough;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
