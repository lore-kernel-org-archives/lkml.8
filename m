Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5026AC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313E321744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgAJR7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59284 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgAJR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZA-0002BZ-CC; Fri, 10 Jan 2020 18:59:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4F3CD1C2D6F;
        Fri, 10 Jan 2020 18:59:21 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:21 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Disambiguate PAT-disabled boot messages
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867916118.30329.2988948694507302150.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     5557e831f68878ef202c0e5296235442cff9b41e
Gitweb:        https://git.kernel.org/tip/5557e831f68878ef202c0e5296235442cff9b41e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 19 Nov 2019 09:50:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Disambiguate PAT-disabled boot messages

Right now we have these four types of PAT-disabled boot messages:

  x86/PAT: PAT support disabled.
  x86/PAT: PAT MSR is 0, disabled.
  x86/PAT: MTRRs disabled, skipping PAT initialization too.
  x86/PAT: PAT not supported by CPU.

The first message is ambiguous in that it doesn't signal that PAT is off
due to a boot option.

The second message doesn't really make it clear that this is the MSR value
during early bootup and it's the firmware environment that disabled PAT
support.

The fourth message doesn't really make it clear that we disable PAT support
because CONFIG_MTRR is off in the kernel.

Clarify, harmonize and fix the spelling in these user-visible messages:

  x86/PAT: PAT support disabled via boot option.
  x86/PAT: PAT support disabled by the firmware.
  x86/PAT: PAT support disabled because CONFIG_MTRR is disabled in the kernel.
  x86/PAT: PAT not supported by the CPU.

Also add a fifth message, in case PAT support is disabled at build time:

  x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.

Previously we'd just silently return from pat_init() without giving any indication
that PAT support is off.

Finally, clarify/extend some of the comments related to PAT initialization.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/mtrr.h |  2 +-
 arch/x86/mm/pat.c           | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index dbff145..3337d22 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -86,7 +86,7 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 }
 static inline void mtrr_bp_init(void)
 {
-	pat_disable("MTRRs disabled, skipping PAT initialization too.");
+	pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
 }
 
 #define mtrr_ap_init() do {} while (0)
diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index 560ac51..e26b81c 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -66,7 +66,11 @@ static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
 static bool __read_mostly pat_initialized;
 static bool __read_mostly init_cm_done;
 
-void pat_disable(const char *reason)
+/*
+ * PAT support is enabled by default, but can be disabled for
+ * various user-requested or hardware-forced reasons:
+ */
+void pat_disable(const char *msg_reason)
 {
 	if (pat_disabled)
 		return;
@@ -77,12 +81,12 @@ void pat_disable(const char *reason)
 	}
 
 	pat_disabled = true;
-	pr_info("x86/PAT: %s\n", reason);
+	pr_info("x86/PAT: %s\n", msg_reason);
 }
 
 static int __init nopat(char *str)
 {
-	pat_disable("PAT support disabled.");
+	pat_disable("PAT support disabled via boot option.");
 	return 0;
 }
 early_param("nopat", nopat);
@@ -238,13 +242,13 @@ static void pat_bsp_init(u64 pat)
 	u64 tmp_pat;
 
 	if (!boot_cpu_has(X86_FEATURE_PAT)) {
-		pat_disable("PAT not supported by CPU.");
+		pat_disable("PAT not supported by the CPU.");
 		return;
 	}
 
 	rdmsrl(MSR_IA32_CR_PAT, tmp_pat);
 	if (!tmp_pat) {
-		pat_disable("PAT MSR is 0, disabled.");
+		pat_disable("PAT support disabled by the firmware.");
 		return;
 	}
 
@@ -314,7 +318,7 @@ void init_cache_modes(void)
 }
 
 /**
- * pat_init - Initialize PAT MSR and PAT table
+ * pat_init - Initialize the PAT MSR and PAT table on the current CPU
  *
  * This function initializes PAT MSR and PAT table with an OS-defined value
  * to enable additional cache attributes, WC, WT and WP.
@@ -328,6 +332,10 @@ void pat_init(void)
 	u64 pat;
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
+#ifndef CONFIG_X86_PAT
+	pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
+#endif
+
 	if (pat_disabled)
 		return;
 
