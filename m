Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4977DC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1523B2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hIwsMwj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgCUKMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:12:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56534 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgCUKMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:12:01 -0400
Received: from zn.tnic (p200300EC2F1D5B005CBA888EC129B071.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:5b00:5cba:888e:c129:b071])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55CDB1EC0C31;
        Sat, 21 Mar 2020 11:12:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584785520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=2FPX2XTQuKo82PfMfTa9JBXtRMvjQP/y/7zYom18bGQ=;
        b=hIwsMwj6APG3BfJPE2lFDLYSYx9djHGAWf3u/D0EF8uO2Dp65taHCYfSZko1/ZTKdlR/mc
        qGXjuGgvedcm2p51OMcUh5t119VriI+JBOhnbrr0PuNz2UFrvu5lZoFY0tRJe7vLufsjre
        Fqm4nSr1+ONqedRoPwD+Dq9GCW7eLRU=
Date:   Sat, 21 Mar 2020 11:12:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86-ml <x86@kernel.org>, Benjamin Thiel <b.thiel@posteo.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mm/set_memory: Fix -Wmissing-prototypes warnings
Message-ID: <20200321101013.GB17494@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

so Benni has been working on fixing all those -Wmissing-prototypes
warnings so that we can enable it by default on x86 but this one below
got kinda hairy so lemme take over.

@Dave, what did you mean with set_memory_{non,}global() being not
arch-generic? They're toggling the global bit so kinda in-line with the
other set_memory* helpers. So we can just es well hoist those prototypes
to the set_memory.h header.

Or am I missing something?

Thx.

---
From: Benjamin Thiel <b.thiel@posteo.de>

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
index 64c3dce374e5..950532ccbc4a 100644
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
index c4aedd00c1ba..6d5424069e2b 100644
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
index 44a9f068eee0..843aa10a4cb6 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -39,6 +39,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/sections.h>
+#include <asm/set_memory.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
@@ -554,13 +555,6 @@ static inline bool pti_kernel_image_global_ok(void)
 	return true;
 }
 
-/*
- * This is the only user for these and it is not arch-generic
- * like the other set_memory.h functions.  Just extern them.
- */
-extern int set_memory_nonglobal(unsigned long addr, int numpages);
-extern int set_memory_global(unsigned long addr, int numpages);
-
 /*
  * For some configurations, map all of kernel text into the user page
  * tables.  This reduces TLB misses, especially on non-PCID systems.
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
