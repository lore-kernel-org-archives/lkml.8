Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4EEC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE8D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgA2LdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51112 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgA2LdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlab-0007lV-UJ; Wed, 29 Jan 2020 12:32:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 938A01C1C19;
        Wed, 29 Jan 2020 12:32:57 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:57 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86, sched: Add support for frequency invariance on ATOM
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200122151617.531-6-ggherdovich@suse.cz>
References: <20200122151617.531-6-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <158029757740.396.7740416876846086556.tip-bot2@tip-bot2>
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

Commit-ID:     298c6f99bf30ef735e79f7f6d086bdfae505d380
Gitweb:        https://git.kernel.org/tip/298c6f99bf30ef735e79f7f6d086bdfae505d380
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Wed, 22 Jan 2020 16:16:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:37:05 +01:00

x86, sched: Add support for frequency invariance on ATOM

The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
accounting. On all ATOM CPUs prior to Goldmont, set freq_max to the 1-core
turbo ratio.

We intended to perform tests validating that this patch doesn't regress in
terms of energy efficiency, given that this is the primary concern on Atom
processors. Alas, we found out that turbostat doesn't support reading RAPL
interfaces on our test machine (Airmont), and we don't have external equipment
to measure power consumption; all we have is the performance results of the
benchmarks we ran.

Test machine:

Platform    : Dell Wyse 3040 Thin Client[1]
CPU Model   : Intel Atom x5-Z8350 (aka Cherry Trail, aka Airmont)
Fam/Mod/Ste : 6:76:4
Topology    : 1 socket, 4 cores / 4 threads
Memory      : 2G
Storage     : onboard flash, XFS filesystem

[1] https://www.dell.com/en-us/work/shop/wyse-endpoints-and-software/wyse-3040-thin-client/spd/wyse-3040-thin-client

Base frequency and available turbo levels (MHz):

    Min Operating Freq   266 |***
    Low Freq Mode        800 |********
    Base Freq           2400 |************************
    4 Cores             2800 |****************************
    3 Cores             2800 |****************************
    2 Cores             3200 |********************************
    1 Core              3200 |********************************

Tested kernels:

Baseline      : v5.4-rc1,              intel_pstate passive,  schedutil
Comparison #1 : v5.4-rc1,              intel_pstate active ,  powersave
Comparison #2 : v5.4-rc1, this patch,  intel_pstate passive,  schedutil

tbench, hackbench and kernbench performed the same under all three kernels;
dbench ran faster with intel_pstate/powersave and the git unit tests were a
lot faster with intel_pstate/powersave and invariant schedutil wrt the
baseline. Not that any of this is terrbily interesting anyway, one doesn't buy
an Atom system to go fast. Power consumption regressions aren't expected but
we lack the equipment to make that measurement. Turbostat seems to think that
reading RAPL on this machine isn't a good idea and we're trusting that
decision.

comparison ratio of performance with baseline; 1.00 means neutral,
lower is better:

                      I_PSTATE      FREQ-INV
    ----------------------------------------
    dbench                0.90             ~
    kernbench             0.98          0.97
    gitsource             0.63          0.43

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200122151617.531-6-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3e32d62..5f04bf8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1821,6 +1821,24 @@ static bool turbo_disabled(void)
 	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
 
+static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
+{
+	int err;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
+	*turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
+
+	return true;
+}
+
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
@@ -1938,17 +1956,14 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 
 static bool intel_set_max_freq_ratio(void)
 {
-	/*
-	 * TODO: add support for:
-	 *
-	 * - Atom Silvermont
-	 */
-
 	u64 base_freq = 1, turbo_freq = 1;
 
 	if (turbo_disabled())
 		goto out;
 
+	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
+		goto out;
+
 	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
 	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
