Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C90C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2595208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RB3TPVf8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pUeJ1MNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgIJTy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:54:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIJTwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:52:36 -0400
Date:   Thu, 10 Sep 2020 19:52:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599767554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhBA5DB3uM3jz6b3+VK8IjWpmv4Aa40MZCnMXEBoZuw=;
        b=RB3TPVf8PntijWABrEv+XIuvVRnI6OB5ZNqbYq8qqZNyuFRXgW2NSQUuVfxVtxkEGyUHNr
        cfvQ4DVHCJli45Mo5pO6xlUpNHbpJgR6nAXL14FYaz1k8jWO+Ok8cucpNQ3k8AcKPwsnF0
        vf+bg6nKeMvlnY/B8pqRWDrZIobpZ+wbsG7tvSUcBznjANZvZC370fQ6lXMXUO1PHAEC4W
        BMmNVG4byBvN1NEN67cK+TdIgAIR1SxRb+d2Mz5OrnFwXMHDSVmIUuX+bc63EgCOysmqCV
        DmM1k1e4DViMZEflni4VcEjY45MKv4SUyWCQcOI6oJ+GyW0g+arKkSoLe/KEvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599767554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhBA5DB3uM3jz6b3+VK8IjWpmv4Aa40MZCnMXEBoZuw=;
        b=pUeJ1MNSBlgV9thU2wkOhXbfk2ehvKBNMupfRnCQShy4VLiuuG4V7gvLaAjr30d8scxT1v
        tLOxKV23Y52emQCQ==
From:   "tip-bot2 for Martin Radev" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Check required CPU features for SEV-ES
Cc:     Martin Radev <martin.b.radev@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-73-joro@8bytes.org>
References: <20200907131613.12703-73-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159976755355.20229.4941386595177142074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     f5ed777586e08e09c4b6f1e87161a145ee1431cf
Gitweb:        https://git.kernel.org/tip/f5ed777586e08e09c4b6f1e87161a145ee1431cf
Author:        Martin Radev <martin.b.radev@gmail.com>
AuthorDate:    Mon, 07 Sep 2020 15:16:13 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Sep 2020 21:49:25 +02:00

x86/sev-es: Check required CPU features for SEV-ES

Make sure the machine supports RDRAND, otherwise there is no trusted
source of randomness in the system.

To also check this in the pre-decompression stage, make has_cpuflag()
not depend on CONFIG_RANDOMIZE_BASE anymore.

Signed-off-by: Martin Radev <martin.b.radev@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-73-joro@8bytes.org
---
 arch/x86/boot/compressed/cpuflags.c |  4 ----
 arch/x86/boot/compressed/misc.h     |  5 +++--
 arch/x86/boot/compressed/sev-es.c   |  3 +++
 arch/x86/kernel/sev-es-shared.c     | 15 +++++++++++++++
 arch/x86/kernel/sev-es.c            |  3 +++
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/cpuflags.c b/arch/x86/boot/compressed/cpuflags.c
index 6448a81..0cc1323 100644
--- a/arch/x86/boot/compressed/cpuflags.c
+++ b/arch/x86/boot/compressed/cpuflags.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#ifdef CONFIG_RANDOMIZE_BASE
-
 #include "../cpuflags.c"
 
 bool has_cpuflag(int flag)
@@ -9,5 +7,3 @@ bool has_cpuflag(int flag)
 
 	return test_bit(flag, cpu.flags);
 }
-
-#endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index c0e0ffe..6d31f1b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -85,8 +85,6 @@ void choose_random_location(unsigned long input,
 			    unsigned long *output,
 			    unsigned long output_size,
 			    unsigned long *virt_addr);
-/* cpuflags.c */
-bool has_cpuflag(int flag);
 #else
 static inline void choose_random_location(unsigned long input,
 					  unsigned long input_size,
@@ -97,6 +95,9 @@ static inline void choose_random_location(unsigned long input,
 }
 #endif
 
+/* cpuflags.c */
+bool has_cpuflag(int flag);
+
 #ifdef CONFIG_X86_64
 extern int set_page_decrypted(unsigned long address);
 extern int set_page_encrypted(unsigned long address);
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 2a6c7c3..954cb27 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -145,6 +145,9 @@ void sev_es_shutdown_ghcb(void)
 	if (!boot_ghcb)
 		return;
 
+	if (!sev_es_check_cpu_features())
+		error("SEV-ES CPU Features missing.");
+
 	/*
 	 * GHCB Page must be flushed from the cache and mapped encrypted again.
 	 * Otherwise the running kernel will see strange cache effects when
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 4be8af2..5f83cca 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -9,6 +9,21 @@
  * and is included directly into both code-bases.
  */
 
+#ifndef __BOOT_COMPRESSED
+#define error(v)	pr_err(v)
+#define has_cpuflag(f)	boot_cpu_has(f)
+#endif
+
+static bool __init sev_es_check_cpu_features(void)
+{
+	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
+		error("RDRAND instruction not supported - no trusted source of randomness available\n");
+		return false;
+	}
+
+	return true;
+}
+
 static void sev_es_terminate(unsigned int reason)
 {
 	u64 val = GHCB_SEV_TERMINATE;
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 8cac9f8..6fcfdd3 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -665,6 +665,9 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_active())
 		return;
 
+	if (!sev_es_check_cpu_features())
+		panic("SEV-ES CPU Features missing");
+
 	/* Enable SEV-ES special handling */
 	static_branch_enable(&sev_es_enable_key);
 
