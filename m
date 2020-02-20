Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B0C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CE224656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582182833;
	bh=rwQm2LHj6O68xe2FxIQGJ5fkX9rcTbc/gyMPReVRkgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ksrJD6tQyiVomnjwISN4mnjbr9vmhN+5kM7cOlFIJ2GLCHHqzvXPs7A3RWcejTojs
	 Acq1L99ot+lEUWKxj870IA93cPj93U+U2jBZxKBcrVXM49/j9pS10N58BwrIp9jQu7
	 m6JiDQh+zGkPFKnpmzpWSfye1QH7nRDfl2mGvLa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBTHNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:13:51 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36597 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTHNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:13:51 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01K7Bl6e011059;
        Thu, 20 Feb 2020 16:11:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01K7Bl6e011059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582182710;
        bh=+g7cH/hWwvcSufuWOvuSo00awgwQs7zryYYrPdVzF2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHidawMYwRIsKTcmfjP8nOvaa/oCcqep+hb2pJYYzwkCDIEp3cz8qNtnOlWEPHm6b
         EWq6MdZyqcn5pNEOn94SnX0hEOlDd4i394y15Zcua7OxtEDfQtLaibMiHJx2IkWF1K
         Kyush1yLBNH6MKAi9cwAUtXXN4MeaUp+N+GALgMt67SCvQAWSTe8UvfXipIpCh8cnT
         n7n0r1FEeggqLQJsmtChYF5BROrQdaUJXbfGuK6tK+kQfZbCCHcjSoUp7dcEwAXPdR
         tkdX/j2kqS5veyaAYkSSEMCcsgfUi/oWGC5H5fs/1AcSFndEvfrqKt08xRWF4oGyDb
         QpHNFTxBiszuA==
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
Subject: [PATCH 2/2] compiler: Remove CONFIG_OPTIMIZE_INLINING entirely
Date:   Thu, 20 Feb 2020 16:11:40 +0900
Message-Id: <20200220071140.14080-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220071140.14080-1-masahiroy@kernel.org>
References: <20200220071140.14080-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") made this always-on option. We released v5.4 and v5.5
including that commit.

Remove the CONFIG option and clean up the code now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

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

