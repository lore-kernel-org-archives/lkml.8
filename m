Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28774C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED38624677
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAJSAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:00:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59260 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgAJR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ5-00028s-8x; Fri, 10 Jan 2020 18:59:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D01FF1C2D6A;
        Fri, 10 Jan 2020 18:59:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:18 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Tabulate the page table encoding definitions
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867915870.30329.18073165130921919060.tip-bot2@tip-bot2>
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

Commit-ID:     4efb56649132687b5093d90aa62887595e65a09d
Gitweb:        https://git.kernel.org/tip/4efb56649132687b5093d90aa62887595e65a09d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 17:38:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm: Tabulate the page table encoding definitions

I got lost in trying to figure out which bits were enabled
in one of the PTE masks, so let's make it pretty
obvious at the definition site already:

 #define PAGE_NONE            __pg(   0|   0|   0|___A|   0|   0|   0|___G)
 #define PAGE_SHARED          __pg(__PP|__RW|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_SHARED_EXEC     __pg(__PP|__RW|_USR|___A|   0|   0|   0|   0)
 #define PAGE_COPY_NOEXEC     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_COPY_EXEC       __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)
 #define PAGE_COPY            __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_READONLY        __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_READONLY_EXEC   __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)

 #define __PAGE_KERNEL            (__PP|__RW|   0|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_EXEC       (__PP|__RW|   0|___A|   0|___D|   0|___G)
 #define _KERNPG_TABLE_NOENC      (__PP|__RW|   0|___A|   0|___D|   0|   0)
 #define _KERNPG_TABLE            (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
 #define _PAGE_TABLE_NOENC        (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE              (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
 #define __PAGE_KERNEL_RO         (__PP|   0|   0|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_RX         (__PP|   0|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_NOCACHE    (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
 #define __PAGE_KERNEL_VVAR       (__PP|   0|_USR|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_LARGE      (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
 #define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
 #define __PAGE_KERNEL_WP         (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)

Especially security relevant bits like 'NX' or coherence related bits like 'G'
are now super easy to read based on a single grep.

We do the underscore gymnastics to not pollute the kernel's symbol namespace,
and the longest line still fits into 80 columns, so this should be readable
for everyone.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_types.h | 143 +++++++++++++-------------
 1 file changed, 74 insertions(+), 69 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b5e49e6..ea74007 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -110,11 +110,6 @@
 
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
-#define _PAGE_TABLE_NOENC	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |\
-				 _PAGE_ACCESSED | _PAGE_DIRTY)
-#define _KERNPG_TABLE_NOENC	(_PAGE_PRESENT | _PAGE_RW |		\
-				 _PAGE_ACCESSED | _PAGE_DIRTY)
-
 /*
  * Set of bits not changed in pte_modify.  The pte's
  * protection key is treated like _PAGE_RW, for
@@ -136,80 +131,93 @@
  */
 #ifndef __ASSEMBLY__
 enum page_cache_mode {
-	_PAGE_CACHE_MODE_WB = 0,
-	_PAGE_CACHE_MODE_WC = 1,
+	_PAGE_CACHE_MODE_WB       = 0,
+	_PAGE_CACHE_MODE_WC       = 1,
 	_PAGE_CACHE_MODE_UC_MINUS = 2,
-	_PAGE_CACHE_MODE_UC = 3,
-	_PAGE_CACHE_MODE_WT = 4,
-	_PAGE_CACHE_MODE_WP = 5,
-	_PAGE_CACHE_MODE_NUM = 8
+	_PAGE_CACHE_MODE_UC       = 3,
+	_PAGE_CACHE_MODE_WT       = 4,
+	_PAGE_CACHE_MODE_WP       = 5,
+
+	_PAGE_CACHE_MODE_NUM      = 8
 };
 #endif
 
-#define _PAGE_CACHE_MASK	(_PAGE_PAT | _PAGE_PCD | _PAGE_PWT)
-#define _PAGE_NOCACHE		(cachemode2protval(_PAGE_CACHE_MODE_UC))
-#define _PAGE_CACHE_WP		(cachemode2protval(_PAGE_CACHE_MODE_WP))
+#define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
-#define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | \
-				 _PAGE_ACCESSED | _PAGE_NX)
-
-#define PAGE_SHARED_EXEC	__pgprot(_PAGE_PRESENT | _PAGE_RW |	\
-					 _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_COPY_NOEXEC	__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
-					 _PAGE_ACCESSED | _PAGE_NX)
-#define PAGE_COPY_EXEC		__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
-					 _PAGE_ACCESSED)
-#define PAGE_COPY		PAGE_COPY_NOEXEC
-#define PAGE_READONLY		__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
-					 _PAGE_ACCESSED | _PAGE_NX)
-#define PAGE_READONLY_EXEC	__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
-					 _PAGE_ACCESSED)
-
-#define __PAGE_KERNEL_EXEC						\
-	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_GLOBAL)
-#define __PAGE_KERNEL		(__PAGE_KERNEL_EXEC | _PAGE_NX)
-
-#define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
-#define __PAGE_KERNEL_RX		(__PAGE_KERNEL_EXEC & ~_PAGE_RW)
-#define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_NOCACHE)
-#define __PAGE_KERNEL_VVAR		(__PAGE_KERNEL_RO | _PAGE_USER)
-#define __PAGE_KERNEL_LARGE		(__PAGE_KERNEL | _PAGE_PSE)
-#define __PAGE_KERNEL_LARGE_EXEC	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
-#define __PAGE_KERNEL_WP		(__PAGE_KERNEL | _PAGE_CACHE_WP)
-
-#define __PAGE_KERNEL_IO		(__PAGE_KERNEL)
-#define __PAGE_KERNEL_IO_NOCACHE	(__PAGE_KERNEL_NOCACHE)
+#define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
 
-#ifndef __ASSEMBLY__
+#define _PAGE_NOCACHE		(cachemode2protval(_PAGE_CACHE_MODE_UC))
+#define _PAGE_CACHE_WP		(cachemode2protval(_PAGE_CACHE_MODE_WP))
 
-#define _PAGE_ENC	(_AT(pteval_t, sme_me_mask))
+#define __PP _PAGE_PRESENT
+#define __RW _PAGE_RW
+#define _USR _PAGE_USER
+#define ___A _PAGE_ACCESSED
+#define ___D _PAGE_DIRTY
+#define ___G _PAGE_GLOBAL
+#define __NX _PAGE_NX
+
+#define _ENC _PAGE_ENC
+#define __WP _PAGE_CACHE_WP
+#define __NC _PAGE_NOCACHE
+#define _PSE _PAGE_PSE
+
+#define pgprot_val(x)		((x).pgprot)
+#define __pgprot(x)		((pgprot_t) { (x) } )
+#define __pg(x)			__pgprot(x)
+
+#define _PAGE_PAT_LARGE		(_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
+
+#define PAGE_NONE	     __pg(   0|   0|   0|___A|   0|   0|   0|___G)
+#define PAGE_SHARED	     __pg(__PP|__RW|_USR|___A|__NX|   0|   0|   0)
+#define PAGE_SHARED_EXEC     __pg(__PP|__RW|_USR|___A|   0|   0|   0|   0)
+#define PAGE_COPY_NOEXEC     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
+#define PAGE_COPY_EXEC	     __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)
+#define PAGE_COPY	     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
+#define PAGE_READONLY	     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
+#define PAGE_READONLY_EXEC   __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)
+
+#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
+#define _KERNPG_TABLE_NOENC	 (__PP|__RW|   0|___A|   0|___D|   0|   0)
+#define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
+#define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
+#define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
+#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_RX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
+#define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
+#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
+#define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
+#define __PAGE_KERNEL_WP	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)
+
+
+#define __PAGE_KERNEL_IO		__PAGE_KERNEL
+#define __PAGE_KERNEL_IO_NOCACHE	__PAGE_KERNEL_NOCACHE
 
-#define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED |	\
-			 _PAGE_DIRTY | _PAGE_ENC)
-#define _PAGE_TABLE	(_KERNPG_TABLE | _PAGE_USER)
 
-#define __PAGE_KERNEL_ENC	(__PAGE_KERNEL | _PAGE_ENC)
-#define __PAGE_KERNEL_ENC_WP	(__PAGE_KERNEL_WP | _PAGE_ENC)
+#ifndef __ASSEMBLY__
 
-#define __PAGE_KERNEL_NOENC	(__PAGE_KERNEL)
-#define __PAGE_KERNEL_NOENC_WP	(__PAGE_KERNEL_WP)
+#define __PAGE_KERNEL_ENC	(__PAGE_KERNEL    | _ENC)
+#define __PAGE_KERNEL_ENC_WP	(__PAGE_KERNEL_WP | _ENC)
+#define __PAGE_KERNEL_NOENC	(__PAGE_KERNEL    |    0)
+#define __PAGE_KERNEL_NOENC_WP	(__PAGE_KERNEL_WP |    0)
 
-#define default_pgprot(x)	__pgprot((x) & __default_kernel_pte_mask)
+#define __pgprot_mask(x)	__pgprot((x) & __default_kernel_pte_mask)
 
-#define PAGE_KERNEL		default_pgprot(__PAGE_KERNEL | _PAGE_ENC)
-#define PAGE_KERNEL_NOENC	default_pgprot(__PAGE_KERNEL)
-#define PAGE_KERNEL_RO		default_pgprot(__PAGE_KERNEL_RO | _PAGE_ENC)
-#define PAGE_KERNEL_EXEC	default_pgprot(__PAGE_KERNEL_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_EXEC_NOENC	default_pgprot(__PAGE_KERNEL_EXEC)
-#define PAGE_KERNEL_RX		default_pgprot(__PAGE_KERNEL_RX | _PAGE_ENC)
-#define PAGE_KERNEL_NOCACHE	default_pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
-#define PAGE_KERNEL_LARGE	default_pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
-#define PAGE_KERNEL_LARGE_EXEC	default_pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_VVAR	default_pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
+#define PAGE_KERNEL		__pgprot_mask(__PAGE_KERNEL            | _ENC)
+#define PAGE_KERNEL_NOENC	__pgprot_mask(__PAGE_KERNEL            |    0)
+#define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
+#define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
+#define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
+#define PAGE_KERNEL_RX		__pgprot_mask(__PAGE_KERNEL_RX         | _ENC)
+#define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
+#define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
+#define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
+#define PAGE_KERNEL_VVAR	__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
 
-#define PAGE_KERNEL_IO		default_pgprot(__PAGE_KERNEL_IO)
-#define PAGE_KERNEL_IO_NOCACHE	default_pgprot(__PAGE_KERNEL_IO_NOCACHE)
+#define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
+#define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
 
 #endif	/* __ASSEMBLY__ */
 
@@ -449,9 +457,6 @@ static inline pteval_t pte_flags(pte_t pte)
 	return native_pte_val(pte) & PTE_FLAGS_MASK;
 }
 
-#define pgprot_val(x)	((x).pgprot)
-#define __pgprot(x)	((pgprot_t) { (x) } )
-
 extern uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM];
 extern uint8_t __pte2cachemode_tbl[8];
 
