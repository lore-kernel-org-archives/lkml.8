Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A2AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD11212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgFPMXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgFPMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC51C08C5C2;
        Tue, 16 Jun 2020 05:22:15 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbQ-0004kG-N2; Tue, 16 Jun 2020 14:22:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 433B01C084B;
        Tue, 16 Jun 2020 14:21:55 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:55 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86, sched: check for counters overflow in
 frequency invariant accounting
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200531182453.15254-2-ggherdovich@suse.cz>
References: <20200531182453.15254-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <159231011503.16989.15104341794896787549.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e2b0d619b400ae326f954a018a1d65d736c237c5
Gitweb:        https://git.kernel.org/tip/e2b0d619b400ae326f954a018a1d65d736c237c5
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Sun, 31 May 2020 20:24:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:02 +02:00

x86, sched: check for counters overflow in frequency invariant accounting

The product mcnt * arch_max_freq_ratio can overflows u64.

For context, a large value for arch_max_freq_ratio would be 5000,
corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
1500-2000). A large increment frequency for the MPERF counter would be 5GHz
(the base clock of all CPUs on the market today is less than that). With
these figures, a CPU would need to go without a scheduler tick for around 8
days for the u64 overflow to happen. It is unlikely, but the check is
warranted.

Under similar conditions, the difference acnt of two consecutive APERF
readings can overflow as well.

In these circumstances is appropriate to disable frequency invariant
accounting: the feature relies on measures of the clock frequency done at
every scheduler tick, which need to be "fresh" to be at all meaningful.

A note on i386: prior to version 5.1, the GCC compiler didn't have the
builtin function __builtin_mul_overflow. In these GCC versions the macro
check_mul_overflow needs __udivdi3() to do (u64)a/b, which the kernel
doesn't provide. For this reason this change fails to build on i386 if
GCC<5.1, and we protect the entire frequency invariant code behind
CONFIG_X86_64 (special thanks to "kbuild test robot" <lkp@intel.com>).

Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200531182453.15254-2-ggherdovich@suse.cz
---
 arch/x86/include/asm/topology.h |  2 +-
 arch/x86/kernel/smpboot.c       | 33 +++++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 79d8d54..f423457 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -193,7 +193,7 @@ static inline void sched_clear_itmt_support(void)
 }
 #endif /* CONFIG_SCHED_MC_PRIO */
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
 #include <asm/cpufeature.h>
 
 DECLARE_STATIC_KEY_FALSE(arch_scale_freq_key);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ffbd9a3..18d292f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -56,6 +56,7 @@
 #include <linux/cpuidle.h>
 #include <linux/numa.h>
 #include <linux/pgtable.h>
+#include <linux/overflow.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1777,6 +1778,7 @@ void native_play_dead(void)
 
 #endif
 
+#ifdef CONFIG_X86_64
 /*
  * APERF/MPERF frequency ratio computation.
  *
@@ -2048,11 +2050,19 @@ static void init_freq_invariance(bool secondary)
 	}
 }
 
+static void disable_freq_invariance_workfn(struct work_struct *work)
+{
+	static_branch_disable(&arch_scale_freq_key);
+}
+
+static DECLARE_WORK(disable_freq_invariance_work,
+		    disable_freq_invariance_workfn);
+
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
 void arch_scale_freq_tick(void)
 {
-	u64 freq_scale;
+	u64 freq_scale = SCHED_CAPACITY_SCALE;
 	u64 aperf, mperf;
 	u64 acnt, mcnt;
 
@@ -2064,19 +2074,32 @@ void arch_scale_freq_tick(void)
 
 	acnt = aperf - this_cpu_read(arch_prev_aperf);
 	mcnt = mperf - this_cpu_read(arch_prev_mperf);
-	if (!mcnt)
-		return;
 
 	this_cpu_write(arch_prev_aperf, aperf);
 	this_cpu_write(arch_prev_mperf, mperf);
 
-	acnt <<= 2*SCHED_CAPACITY_SHIFT;
-	mcnt *= arch_max_freq_ratio;
+	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
+		goto error;
+
+	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
+		goto error;
 
 	freq_scale = div64_u64(acnt, mcnt);
+	if (!freq_scale)
+		goto error;
 
 	if (freq_scale > SCHED_CAPACITY_SCALE)
 		freq_scale = SCHED_CAPACITY_SCALE;
 
 	this_cpu_write(arch_freq_scale, freq_scale);
+	return;
+
+error:
+	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
+	schedule_work(&disable_freq_invariance_work);
+}
+#else
+static inline void init_freq_invariance(bool secondary)
+{
 }
+#endif /* CONFIG_X86_64 */
