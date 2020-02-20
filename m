Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA60C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FCE24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582197014;
	bh=ZNyBNozyPTZJbX3LL0EtBQ3gKw0evni/rIYgE6B3Hps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kDDwAZTgBk5oKmirry39WbiuEPbr5fUTOFSRnFvpzOKfvtrdnGFq4+5nno7D0RLul
	 7d/IiJziSwtLWBtwm2B/JnKRqi65qoTWT05S7cbSspLUe8Kcf26znPv50SU0YVzpgH
	 empit7AWvHAYtWprNy+BlA0+NITxotty/kBZuVTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBTLKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:10:13 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:60118 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgBTLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:10:13 -0500
X-Greylist: delayed 14182 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 06:10:11 EST
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01KB8BM8031854;
        Thu, 20 Feb 2020 20:08:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01KB8BM8031854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582196897;
        bh=on/7DtPgewgJQ7ODuLQlJl0YcJIgV+9otF/QOdXIumQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XC8q6E5qMLpB1FPaSwGsRBaOWCOTsSRqpyE/pjUarnH6afV1uwa+BzYBV+mnG+mw
         TM6zuyzw7ZC6L9ccNjk9k3uqE07lE+5ZPH7b3lD03qPPrp9X8YWyXMdLYD0rLtAncV
         dimXBHSkHtce5Oyk6Fc/X6mI8NSpFdXVpu1jaPf1WFN975hrBKdbjsM0cygr7mKajg
         Ld+iRCpTw9JfJFLGJpePwEQStXgMLPRT74pwf6A3I8AA8SC6RdK63jqqAEXcCp83kV
         0JQicojWbLN0pPbDyyczvgViUJeUOMzs+w4/39EjaxyN7JNw6W7JFwYc5NesfdxCn3
         SIBnFyQidGIsA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] compiler: Remove CONFIG_OPTIMIZE_INLINING entirely
Date:   Thu, 20 Feb 2020 20:08:07 +0900
Message-Id: <20200220110807.32534-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220110807.32534-1-masahiroy@kernel.org>
References: <20200220110807.32534-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") made this always-on option. We released v5.4 and v5.5
including that commit.

Remove the CONFIG option and clean up the code now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---

Changes in v2:
  - add Reviewed-by

 arch/x86/configs/i386_defconfig   |  1 -
 arch/x86/configs/x86_64_defconfig |  1 -
 include/linux/compiler_types.h    | 11 +----------
 kernel/configs/tiny.config        |  1 -
 lib/Kconfig.debug                 | 12 ------------
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 59ce9ed58430..d961d831c266 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -288,7 +288,6 @@ CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_RODATA_TEST is not set
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_OPTIMIZE_INLINING=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0b9654c7a05c..4826254c6140 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -285,7 +285,6 @@ CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_RODATA_TEST is not set
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_OPTIMIZE_INLINING=y
 CONFIG_UNWINDER_ORC=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c..e970f97a7fcb 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -129,22 +129,13 @@ struct ftrace_likely_data {
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
- * Force always-inline if the user requests it so via the .config.
  * Prefer gnu_inline, so that extern inline functions do not emit an
  * externally visible function. This makes extern inline behave as per gnu89
  * semantics rather than c99. This prevents multiple symbol definition errors
  * of extern inline functions at link time.
  * A lot of inline functions can cause havoc with function tracing.
- * Do not use __always_inline here, since currently it expands to inline again
- * (which would break users of __always_inline).
  */
-#if !defined(CONFIG_OPTIMIZE_INLINING)
-#define inline inline __attribute__((__always_inline__)) __gnu_inline \
-	__inline_maybe_unused notrace
-#else
-#define inline inline                                    __gnu_inline \
-	__inline_maybe_unused notrace
-#endif
+#define inline inline __gnu_inline __inline_maybe_unused notrace
 
 /*
  * gcc provides both __inline__ and __inline as alternate spellings of
diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index 7fa0c4ae6394..8a44b93da0f3 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -6,7 +6,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KERNEL_XZ=y
 # CONFIG_KERNEL_LZO is not set
 # CONFIG_KERNEL_LZ4 is not set
-CONFIG_OPTIMIZE_INLINING=y
 # CONFIG_SLAB is not set
 # CONFIG_SLUB is not set
 CONFIG_SLOB=y
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df00..5abde39c3c69 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -305,18 +305,6 @@ config HEADERS_INSTALL
 	  user-space program samples. It is also needed by some features such
 	  as uapi header sanity checks.
 
-config OPTIMIZE_INLINING
-	def_bool y
-	help
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  enabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc 4.x and above to make the
-	  decision will become the default in the future. Until then this option
-	  is there to test gcc for this.
-
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1

