Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8522082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCzD2jb3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OX3G1zvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGHJvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgGHJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701BDC08C5DC;
        Wed,  8 Jul 2020 02:51:48 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Or2WgI5iKNml6ubnnqZpi21TQJmEB5y/pH0zEpWOfIU=;
        b=hCzD2jb314SBEOjlciwUs7DtFyn+4W1Se0kepDucnkRLsHrFErQ99ELLt5UCFDMS48AwzU
        qrlAPcAxaAZc3D+hJLrKHLkmvFjLl+/bYnxP8X38pzeoJ9OHjQ+ywgoGRgijE7LPYJjJoY
        Hl2suZTBSHNB0V83zN9tTukxvtJvMesoLR769L9hWGyNF/y8CAy4BPQBsZxSNq14CsCteJ
        AgaHbk5aNn54+caJlFD7EmekUKo5ITKDLbxMu408jwJQ3hER1kPoIGGV/HKoJ47ZFKElWy
        N+ave5VbaXsT1caTlMsPtqq4J+TDYQFZuruJMlQbw7flDYA46C4/YGNFapfjKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Or2WgI5iKNml6ubnnqZpi21TQJmEB5y/pH0zEpWOfIU=;
        b=OX3G1zvD1Sl8V3NYpK1J4W6IgNw7B/QcBFwrHhHXtjK6/oH+8zoQsq+XsYuC/pa6QSr6xO
        2eDig/HDObGZuFBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Create kmem_cache for the LBR
 context data
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-18-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-18-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190646.4006.2446824212113277371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     33cad284497cf40f55ad6029c06011de3538ebed
Gitweb:        https://git.kernel.org/tip/33cad284497cf40f55ad6029c06011de3538ebed
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:23 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:55 +02:00

perf/x86/intel/lbr: Create kmem_cache for the LBR context data

A new kmem_cache method is introduced to allocate the PMU specific data
task_ctx_data, which requires the PMU specific code to create a
kmem_cache.

Currently, the task_ctx_data is only used by the Intel LBR call stack
feature, which is introduced since Haswell. The kmem_cache should be
only created for Haswell and later platforms. There is no alignment
requirement for the existing platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-18-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index e4e249a..e784c1d 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1531,9 +1531,17 @@ void __init intel_pmu_lbr_init_snb(void)
 	 */
 }
 
+static inline struct kmem_cache *
+create_lbr_kmem_cache(size_t size, size_t align)
+{
+	return kmem_cache_create("x86_lbr", size, align, 0, NULL);
+}
+
 /* haswell */
 void intel_pmu_lbr_init_hsw(void)
 {
+	size_t size = sizeof(struct x86_perf_task_context);
+
 	x86_pmu.lbr_nr	 = 16;
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
@@ -1542,6 +1550,8 @@ void intel_pmu_lbr_init_hsw(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+
 	if (lbr_from_signext_quirk_needed())
 		static_branch_enable(&lbr_from_quirk_key);
 }
@@ -1549,6 +1559,8 @@ void intel_pmu_lbr_init_hsw(void)
 /* skylake */
 __init void intel_pmu_lbr_init_skl(void)
 {
+	size_t size = sizeof(struct x86_perf_task_context);
+
 	x86_pmu.lbr_nr	 = 32;
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
@@ -1558,6 +1570,8 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+
 	/*
 	 * SW branch filter usage:
 	 * - support syscall, sysret capture.
@@ -1631,6 +1645,7 @@ void __init intel_pmu_arch_lbr_init(void)
 	union cpuid28_ebx ebx;
 	union cpuid28_ecx ecx;
 	unsigned int unused_edx;
+	size_t size;
 	u64 lbr_nr;
 
 	/* Arch LBR Capabilities */
@@ -1655,8 +1670,10 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
 	x86_pmu.lbr_nr = lbr_nr;
 
-	x86_get_pmu()->task_ctx_size = sizeof(struct x86_perf_task_context_arch_lbr) +
-				       lbr_nr * sizeof(struct lbr_entry);
+	size = sizeof(struct x86_perf_task_context_arch_lbr) +
+	       lbr_nr * sizeof(struct lbr_entry);
+	x86_get_pmu()->task_ctx_size = size;
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
 	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
