Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C844BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E512080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAJR70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgAJR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ6-0002Al-O9; Fri, 10 Jan 2020 18:59:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4F9761C2D6A;
        Fri, 10 Jan 2020 18:59:20 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:20 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Clean up PAT initialization flags
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867916017.30329.6367738814205384697.tip-bot2@tip-bot2>
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

Commit-ID:     d891b9219d2a73640d2f2a216ecb6fb29d832013
Gitweb:        https://git.kernel.org/tip/d891b9219d2a73640d2f2a216ecb6fb29d832013
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 19 Nov 2019 11:46:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Clean up PAT initialization flags

Right now we have these variables that impact the PAT initialization sequence:

  pat_disabled
  boot_cpu_done
  pat_initialized
  init_cm_done

Some have a pat_ prefix, some not, and the naming is random,
which makes their purpose rather opaque.

Name them consistently and according to their role:

  pat_disabled
  pat_bp_initialized
  pat_bp_enabled
  pat_cm_initialized

Also rename pat_bsp_init() => pat_bp_init(), to use the canonical
abbreviation.

Also add a warning for double calls of init_cache_modes(), the call chains
leading to this are complex and I couldn't convince myself that we never
call this function twice - so utilize the flag for a debug check.

No change in functionality intended.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index 4a18049..f1677fa 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -61,10 +61,10 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "" fmt
 
-static bool __read_mostly boot_cpu_done;
+static bool __read_mostly pat_bp_initialized;
 static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
-static bool __read_mostly pat_initialized;
-static bool __read_mostly init_cm_done;
+static bool __read_mostly pat_bp_enabled;
+static bool __read_mostly pat_cm_initialized;
 
 /*
  * PAT support is enabled by default, but can be disabled for
@@ -75,7 +75,7 @@ void pat_disable(const char *msg_reason)
 	if (pat_disabled)
 		return;
 
-	if (boot_cpu_done) {
+	if (pat_bp_initialized) {
 		WARN_ONCE(1, "x86/PAT: PAT cannot be disabled after initialization\n");
 		return;
 	}
@@ -93,7 +93,7 @@ early_param("nopat", nopat);
 
 bool pat_enabled(void)
 {
-	return pat_initialized;
+	return pat_bp_enabled;
 }
 EXPORT_SYMBOL_GPL(pat_enabled);
 
@@ -224,6 +224,8 @@ static void __init_cache_modes(u64 pat)
 	char pat_msg[33];
 	int i;
 
+	WARN_ON_ONCE(pat_cm_initialized);
+
 	pat_msg[32] = 0;
 	for (i = 7; i >= 0; i--) {
 		cache = pat_get_cache_mode((pat >> (i * 8)) & 7,
@@ -232,12 +234,12 @@ static void __init_cache_modes(u64 pat)
 	}
 	pr_info("x86/PAT: Configuration [0-7]: %s\n", pat_msg);
 
-	init_cm_done = true;
+	pat_cm_initialized = true;
 }
 
 #define PAT(x, y)	((u64)PAT_ ## y << ((x)*8))
 
-static void pat_bsp_init(u64 pat)
+static void pat_bp_init(u64 pat)
 {
 	u64 tmp_pat;
 
@@ -253,7 +255,7 @@ static void pat_bsp_init(u64 pat)
 	}
 
 	wrmsrl(MSR_IA32_CR_PAT, pat);
-	pat_initialized = true;
+	pat_bp_enabled = true;
 
 	__init_cache_modes(pat);
 }
@@ -275,7 +277,7 @@ void init_cache_modes(void)
 {
 	u64 pat = 0;
 
-	if (init_cm_done)
+	if (pat_cm_initialized)
 		return;
 
 	if (boot_cpu_has(X86_FEATURE_PAT)) {
@@ -395,9 +397,9 @@ void pat_init(void)
 		      PAT(4, WB) | PAT(5, WP) | PAT(6, UC_MINUS) | PAT(7, WT);
 	}
 
-	if (!boot_cpu_done) {
-		pat_bsp_init(pat);
-		boot_cpu_done = true;
+	if (!pat_bp_initialized) {
+		pat_bp_init(pat);
+		pat_bp_initialized = true;
 	} else {
 		pat_ap_init(pat);
 	}
