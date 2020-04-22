Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B294C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415B420787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgDVVU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDVVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:20:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456FBC03C1A9;
        Wed, 22 Apr 2020 14:20:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRMnZ-0000O6-0s; Wed, 22 Apr 2020 23:20:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8CD4F1C0450;
        Wed, 22 Apr 2020 23:20:48 +0200 (CEST)
Date:   Wed, 22 Apr 2020 21:20:48 -0000
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86, sched: Don't enable static key when starting
 secondary CPUs
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416054745.740-4-ggherdovich@suse.cz>
References: <20200416054745.740-4-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <158759044814.28353.10087364439077051099.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b56e7d45e80796ca963ac10902245b244d823caf
Gitweb:        https://git.kernel.org/tip/b56e7d45e80796ca963ac10902245b244d823caf
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Thu, 16 Apr 2020 07:47:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:13 +02:00

x86, sched: Don't enable static key when starting secondary CPUs

The static key arch_scale_freq_key only needs to be enabled once (at
boot). This change fixes a bug by which the key was enabled every time cpu0
is started, even as a secondary CPU during cpu hotplug. Secondary CPUs are
started from the idle thread: setting a static key from there means
acquiring a lock and may result in sleeping in the idle task, causing CPU
lockup.

Another consequence of this change is that init_counter_refs() is now
called on each CPU correctly; previously the function on_each_cpu() was
used, but it was called at boot when the only online cpu is cpu0.

[ggherdovich@suse.cz: Tested and wrote changelog]
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200416054745.740-4-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5d346b7..dd8e15f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -147,7 +147,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(void);
+static void init_freq_invariance(bool secondary);
 
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
@@ -185,7 +185,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance();
+	init_freq_invariance(true);
 
 	/*
 	 * Get our bogomips.
@@ -1341,7 +1341,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-	init_freq_invariance();
+	init_freq_invariance(false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -2005,7 +2005,7 @@ out:
 	return true;
 }
 
-static void init_counter_refs(void *arg)
+static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
 
@@ -2016,18 +2016,25 @@ static void init_counter_refs(void *arg)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
-static void init_freq_invariance(void)
+static void init_freq_invariance(bool secondary)
 {
 	bool ret = false;
 
-	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (secondary) {
+		if (static_branch_likely(&arch_scale_freq_key)) {
+			init_counter_refs();
+		}
+		return;
+	}
+
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
 
 	if (ret) {
-		on_each_cpu(init_counter_refs, NULL, 1);
+		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
