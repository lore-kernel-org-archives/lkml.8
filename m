Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96415C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7535720732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgA2LdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51104 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2LdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlab-0007kn-Lp; Wed, 29 Jan 2020 12:32:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5153A1C0095;
        Wed, 29 Jan 2020 12:32:57 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:57 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/intel_pstate: Handle runtime turbo
 disablement/enablement in frequency invariance
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200122151617.531-7-ggherdovich@suse.cz>
References: <20200122151617.531-7-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <158029757712.396.8991863522896309415.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: 1.5
X-Linutronix-Spam-Level: +
X-Linutronix-Spam-Status: No , 1.5 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_DBL_ABUSE_MALW=2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     918229cdd5abb50d8a2edfcd8dc6b6bc53afd765
Gitweb:        https://git.kernel.org/tip/918229cdd5abb50d8a2edfcd8dc6b6bc53afd765
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Wed, 22 Jan 2020 16:16:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:37:06 +01:00

x86/intel_pstate: Handle runtime turbo disablement/enablement in frequency invariance

On some platforms such as the Dell XPS 13 laptop the firmware disables turbo
when the machine is disconnected from AC, and viceversa it enables it again
when it's reconnected. In these cases a _PPC ACPI notification is issued.

The scheduler needs to know freq_max for frequency-invariant calculations.
To account for turbo availability to come and go, record freq_max at boot as
if turbo was available and store it in a helper variable. Use a setter
function to swap between freq_base and freq_max every time turbo goes off or on.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200122151617.531-7-ggherdovich@suse.cz
---
 arch/x86/include/asm/topology.h |  5 +++++
 arch/x86/kernel/smpboot.c       | 15 ++++++++++-----
 drivers/cpufreq/intel_pstate.c  |  1 +
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2ebf7b7..79d8d54 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -211,6 +211,11 @@ static inline long arch_scale_freq_capacity(int cpu)
 extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
 
+extern void arch_set_max_freq_ratio(bool turbo_disabled);
+#else
+static inline void arch_set_max_freq_ratio(bool turbo_disabled)
+{
+}
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5f04bf8..467191e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1807,8 +1807,15 @@ DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
 
 static DEFINE_PER_CPU(u64, arch_prev_aperf);
 static DEFINE_PER_CPU(u64, arch_prev_mperf);
+static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
 static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
 
+void arch_set_max_freq_ratio(bool turbo_disabled)
+{
+	arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
+					arch_turbo_freq_ratio;
+}
+
 static bool turbo_disabled(void)
 {
 	u64 misc_en;
@@ -1956,10 +1963,7 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 
 static bool intel_set_max_freq_ratio(void)
 {
-	u64 base_freq = 1, turbo_freq = 1;
-
-	if (turbo_disabled())
-		goto out;
+	u64 base_freq, turbo_freq;
 
 	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
@@ -1981,8 +1985,9 @@ static bool intel_set_max_freq_ratio(void)
 	return false;
 
 out:
-	arch_max_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
+	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
 					base_freq);
+	arch_set_max_freq_ratio(turbo_disabled());
 	return true;
 }
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d2fa3e9..abbeeca 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -922,6 +922,7 @@ static void intel_pstate_update_limits(unsigned int cpu)
 	 */
 	if (global.turbo_disabled_mf != global.turbo_disabled) {
 		global.turbo_disabled_mf = global.turbo_disabled;
+		arch_set_max_freq_ratio(global.turbo_disabled);
 		for_each_possible_cpu(cpu)
 			intel_pstate_update_max_freq(cpu);
 	} else {
