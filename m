Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D44C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B6F2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgC0Oyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:54:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53620 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Oyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:54:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHqNS-0008W3-9s; Fri, 27 Mar 2020 15:54:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 98A4F1C03AB;
        Fri, 27 Mar 2020 15:54:29 +0100 (CET)
Date:   Fri, 27 Mar 2020 14:54:29 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm/set_memory: Fix -Wmissing-prototypes warnings
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320145028.6013-1-b.thiel@posteo.de>
References: <20200320145028.6013-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158532086917.28353.12594836247959241572.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     5bacdc0982f2b343afa5adbb80517d3392a7e357
Gitweb:        https://git.kernel.org/tip/5bacdc0982f2b343afa5adbb80517d3392a7e357
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Fri, 27 Mar 2020 11:26:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 27 Mar 2020 11:26:06 +01:00

x86/mm/set_memory: Fix -Wmissing-prototypes warnings

Add missing includes and move prototypes into the header set_memory.h in
order to fix -Wmissing-prototypes warnings.

 [ bp: Add ifdeffery around arch_invalidate_pmem() ]

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200320145028.6013-1-b.thiel@posteo.de
---
 arch/x86/include/asm/set_memory.h | 2 ++
 arch/x86/mm/pat/set_memory.c      | 3 +++
 arch/x86/mm/pti.c                 | 8 +-------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 64c3dce..950532c 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -46,6 +46,8 @@ int set_memory_4k(unsigned long addr, int numpages);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
+int set_memory_nonglobal(unsigned long addr, int numpages);
+int set_memory_global(unsigned long addr, int numpages);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c4aedd0..6d54240 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -15,6 +15,7 @@
 #include <linux/gfp.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <linux/libnvdimm.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -304,11 +305,13 @@ void clflush_cache_range(void *vaddr, unsigned int size)
 }
 EXPORT_SYMBOL_GPL(clflush_cache_range);
 
+#ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_invalidate_pmem(void *addr, size_t size)
 {
 	clflush_cache_range(addr, size);
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
+#endif
 
 static void __cpa_flush_all(void *arg)
 {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 44a9f06..843aa10 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -39,6 +39,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/sections.h>
+#include <asm/set_memory.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
@@ -555,13 +556,6 @@ static inline bool pti_kernel_image_global_ok(void)
 }
 
 /*
- * This is the only user for these and it is not arch-generic
- * like the other set_memory.h functions.  Just extern them.
- */
-extern int set_memory_nonglobal(unsigned long addr, int numpages);
-extern int set_memory_global(unsigned long addr, int numpages);
-
-/*
  * For some configurations, map all of kernel text into the user page
  * tables.  This reduces TLB misses, especially on non-PCID systems.
  */
