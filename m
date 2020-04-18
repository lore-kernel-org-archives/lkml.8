Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D50C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B39221973
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDRPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDRPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 11:49:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE18C061A0C;
        Sat, 18 Apr 2020 08:49:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPpiz-0002yr-VC; Sat, 18 Apr 2020 17:49:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 647A51C0330;
        Sat, 18 Apr 2020 17:49:45 +0200 (CEST)
Date:   Sat, 18 Apr 2020 15:49:44 -0000
From:   "tip-bot2 for Mark Brown" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Provide a Kconfig symbol for disabling old
 assembly annotations
Cc:     Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@suse.de>,
        Jiri Slaby <jslaby@suse.cz>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416182402.6206-1-broonie@kernel.org>
References: <20200416182402.6206-1-broonie@kernel.org>
MIME-Version: 1.0
Message-ID: <158722498497.28353.17087908645261344925.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     2ce0d7f9766f0e49bb54f149c77bae89464932fb
Gitweb:        https://git.kernel.org/tip/2ce0d7f9766f0e49bb54f149c77bae89464932fb
Author:        Mark Brown <broonie@kernel.org>
AuthorDate:    Thu, 16 Apr 2020 19:24:02 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 18 Apr 2020 17:43:09 +02:00

x86/asm: Provide a Kconfig symbol for disabling old assembly annotations

As x86 was converted to use the modern SYM_ annotations for assembly,
ifdefs were added to remove the generic definitions of the old style
annotations on x86. Rather than collect a list of architectures in the
ifdefs as more architectures are converted over, provide a Kconfig
symbol for this and update x86 to use it.

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lkml.kernel.org/r/20200416182402.6206-1-broonie@kernel.org
---
 arch/x86/Kconfig        | 1 +
 include/linux/linkage.h | 8 ++++----
 lib/Kconfig             | 3 +++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104e..e3d22ed 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -91,6 +91,7 @@ config X86
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 9280209..d796ec2 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -105,7 +105,7 @@
 
 /* === DEPRECATED annotations === */
 
-#ifndef CONFIG_X86
+#ifndef CONFIG_ARCH_USE_SYM_ANNOTATIONS
 #ifndef GLOBAL
 /* deprecated, use SYM_DATA*, SYM_ENTRY, or similar */
 #define GLOBAL(name) \
@@ -118,10 +118,10 @@
 #define ENTRY(name) \
 	SYM_FUNC_START(name)
 #endif
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_ARCH_USE_SYM_ANNOTATIONS */
 #endif /* LINKER_SCRIPT */
 
-#ifndef CONFIG_X86
+#ifndef CONFIG_ARCH_USE_SYM_ANNOTATIONS
 #ifndef WEAK
 /* deprecated, use SYM_FUNC_START_WEAK* */
 #define WEAK(name)	   \
@@ -143,7 +143,7 @@
 #define ENDPROC(name) \
 	SYM_FUNC_END(name)
 #endif
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_ARCH_USE_SYM_ANNOTATIONS */
 
 /* === generic annotations === */
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 5d53f96..e831e1f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -80,6 +80,9 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config ARCH_USE_SYM_ANNOTATIONS
+	bool
+
 config INDIRECT_PIO
 	bool "Access I/O in non-MMIO mode"
 	depends on ARM64
