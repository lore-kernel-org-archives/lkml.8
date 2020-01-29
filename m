Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE6C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3763D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgA2LdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgA2LdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlac-0007lh-7b; Wed, 29 Jan 2020 12:32:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D462A1C1C18;
        Wed, 29 Jan 2020 12:32:57 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:57 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86, sched: Add support for frequency invariance on
 ATOM_GOLDMONT*
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200122151617.531-5-ggherdovich@suse.cz>
References: <20200122151617.531-5-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <158029757767.396.11378452463371953828.tip-bot2@tip-bot2>
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

Commit-ID:     eacf0474aec8bdccdc7f19386319127c67be3588
Gitweb:        https://git.kernel.org/tip/eacf0474aec8bdccdc7f19386319127c67be3588
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Wed, 22 Jan 2020 16:16:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:37:04 +01:00

x86, sched: Add support for frequency invariance on ATOM_GOLDMONT*

The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
accounting. On GOLDMONT (aka Apollo Lake), GOLDMONT_D (aka Denverton) and
GOLDMONT_PLUS CPUs (aka Gemini Lake) set freq_max to the highest frequency
reported by the CPU.

The encoding of turbo ratios for GOLDMONT* is identical to the one for
SKYLAKE_X, but we treat the Atom case apart because we want to set freq_max to
a higher value, thus the ratio freq_curr/freq_max to be lower, leading to more
conservative frequency selections (favoring power efficiency).

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200122151617.531-5-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8cb3113..3e32d62 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1795,6 +1795,10 @@ void native_play_dead(void)
  * which would ignore the entire turbo range (a conspicuous part, making
  * freq_curr/freq_max always maxed out).
  *
+ * An exception to the heuristic above is the Atom uarch, where we choose the
+ * highest turbo level for freq_max since Atom's are generally oriented towards
+ * power efficiency.
+ *
  * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
  * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
  */
@@ -1937,18 +1941,18 @@ static bool intel_set_max_freq_ratio(void)
 	/*
 	 * TODO: add support for:
 	 *
-	 * - Atom Goldmont
 	 * - Atom Silvermont
 	 */
 
 	u64 base_freq = 1, turbo_freq = 1;
 
-	if (x86_match_cpu(has_glm_turbo_ratio_limits))
-		return false;
-
 	if (turbo_disabled())
 		goto out;
 
+	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
+	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+		goto out;
+
 	if (knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
