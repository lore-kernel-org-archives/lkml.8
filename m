Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D528DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20472223C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587061760;
	bh=AFalZ+CgyD9YZw+oiQCl5YzZdsCuqrngnJ72g2zUVpE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oaoagAAz6HHOAt5kKyQpAL5J60woJOletT/LNR0+C2v4YIuIHGXWf71zJZbf+OV8V
	 0KgsyaCjluO5Ds5VeuGf0cxf5YGt1fp8LWBeRpiOMvKOlYtICfmYfL7ktTitKQA2mh
	 bcM1R0SfjzoANs8xKbgZC+005uTSpFulKt9iX+AE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391444AbgDPS3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDPS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:29:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267C620786;
        Thu, 16 Apr 2020 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587061756;
        bh=AFalZ+CgyD9YZw+oiQCl5YzZdsCuqrngnJ72g2zUVpE=;
        h=From:To:Cc:Subject:Date:From;
        b=kb9Mk28uMtyC6lFuzBdsTtHlHiZc0+XcM6mp0m3NWk+qQoIB2ovFzecImwdZgp/W3
         o4XNPiVCme2PNBxNQik8NOsxx+eJ6AKAKEtlvEdhZjRPHtEqwTqDj7DECoYwy+YUUE
         YzCZJWVWWZlzc+ctMWlTTooi5z0dCg4OvrWKSne0=
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] x86/asm: Provide a Kconfig symbol for disabling old assembly annotations
Date:   Thu, 16 Apr 2020 19:24:02 +0100
Message-Id: <20200416182402.6206-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As x86 was converted to use the modern SYM_ annotations for assembly ifdefs
were added to remove the generic definitions of the old style annotations
on x86. Rather than collect a list of architectures in the ifdefs as more
architectures are converted over provide a Kconfig symbol for this and
update x86 to use it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

arm64 will all being well be able to use this shortly.

 arch/x86/Kconfig        | 1 +
 include/linux/linkage.h | 8 ++++----
 lib/Kconfig             | 3 +++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5706d0c8377f..1c6f88cefc88 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,6 +92,7 @@ config X86
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 9280209d1f62..d796ec20d114 100644
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
index 5d53f9609c25..e831e1f01767 100644
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
-- 
2.20.1

