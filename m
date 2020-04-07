Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6764FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2611D206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JXKVFRYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgDGLNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:13:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgDGLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cWMWN/XgPNFQvfUsKATnnJdhiBs9QqNEX+OYocITT5E=; b=JXKVFRYKmmNwnZAY34R78DkLRK
        qrMy7+tXdtRAuBxPfYpIKp2nqERnHosvxDZXizWuKvc8qG9KfFCas/T1S7uQnlf3Fp7GP3Ors6az4
        cm6Ab8QkBHQdlA4tgYm6h0my0OecMgIEib2MrlfkOgD8vaaIoHCVcfUOq2X6yhxHDl5CkqLqh//Wj
        H4uaPbEOo/xNtDw0AFqtE+os2mp6dyMEfrCtvMT6XP/I4ItYXOCdW2EkVctq4wVwR4PkD9xeUZb+U
        +RnbmnpPpXVipD/K5jq3hKWSErTGTNsQ5D6PkHXckHJi83hdXX7K5gdrBED+9XpaG9PiaUUl0L/g7
        9O1Cgqig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLm9m-0007DQ-Ou; Tue, 07 Apr 2020 11:12:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F1F33060FC;
        Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2036E2999410F; Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Message-Id: <20200407111007.276421550@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 07 Apr 2020 13:02:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, peterz@infradead.org, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: [PATCH 2/4] module: Convert module_finalize() to load_info
References: <20200407110236.930134290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide load_info to module_finalize(), such that architectures might,
for example, use get_modinfo() in their implementation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/kernel/module.c        |    4 ++--
 arch/arm/kernel/module.c        |    5 +++--
 arch/arm64/kernel/module.c      |    6 +++---
 arch/ia64/kernel/module.c       |    3 +--
 arch/m68k/kernel/module.c       |    4 +---
 arch/microblaze/kernel/module.c |    3 +--
 arch/mips/kernel/module.c       |    6 +++---
 arch/nds32/kernel/module.c      |    4 +---
 arch/nios2/kernel/module.c      |    3 +--
 arch/parisc/kernel/module.c     |    6 +++---
 arch/powerpc/kernel/module.c    |    5 +++--
 arch/s390/kernel/module.c       |    6 +++---
 arch/sh/kernel/module.c         |    6 +++---
 arch/sparc/kernel/module.c      |    7 ++++---
 arch/x86/kernel/module.c        |    6 +++---
 include/linux/moduleloader.h    |    4 +---
 kernel/module.c                 |    6 ++----
 17 files changed, 38 insertions(+), 46 deletions(-)

--- a/arch/arc/kernel/module.c
+++ b/arch/arc/kernel/module.c
@@ -129,10 +129,10 @@ int apply_relocate_add(Elf32_Shdr *sechd
  * This couldn't be done in module_frob_arch_sections() because
  * relocations had not been applied by then
  */
-int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
-		    struct module *mod)
+int module_finalize(const struct load_info *info, struct module *mod)
 {
 #ifdef CONFIG_ARC_DW2_UNWIND
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	void *unw;
 	int unwsec = mod->arch.unw_sec_idx;
 
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -340,9 +340,10 @@ static const Elf_Shdr *find_mod_section(
 extern void fixup_pv_table(const void *, unsigned long);
 extern void fixup_smp(const void *, unsigned long);
 
-int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
-		    struct module *mod)
+int module_finalize(const struct load_info *info, struct module *mod)
 {
+	const Elf32_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	const Elf_Shdr *s = NULL;
 #ifdef CONFIG_ARM_UNWIND
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -515,10 +515,10 @@ static int module_init_ftrace_plt(const
 	return 0;
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	const Elf_Shdr *s;
 	s = find_section(hdr, sechdrs, ".altinstructions");
 	if (s)
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -902,8 +902,7 @@ register_unwind_table (struct module *mo
 	}
 }
 
-int
-module_finalize (const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mod)
+int module_finalize(const struct load_info *info, struct module *mod)
 {
 	DEBUGP("%s: init: entry=%p\n", __func__, mod->init);
 	if (mod->arch.unwind)
--- a/arch/m68k/kernel/module.c
+++ b/arch/m68k/kernel/module.c
@@ -99,9 +99,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	return 0;
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *mod)
+int module_finalize(const struct load_info *info, struct module *mod)
 {
 	module_fixup(mod, mod->arch.fixup_start, mod->arch.fixup_end);
 	return 0;
--- a/arch/microblaze/kernel/module.c
+++ b/arch/microblaze/kernel/module.c
@@ -114,8 +114,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	return 0;
 }
 
-int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
-		struct module *module)
+int module_finalize(const struct load_info *info, struct module *module)
 {
 	flush_dcache();
 	return 0;
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -427,10 +427,10 @@ const struct exception_table_entry *sear
 }
 
 /* Put in dbe list if necessary. */
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	const Elf_Shdr *s;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
--- a/arch/nds32/kernel/module.c
+++ b/arch/nds32/kernel/module.c
@@ -266,9 +266,7 @@ apply_relocate_add(Elf32_Shdr * sechdrs,
 	return 0;
 }
 
-int
-module_finalize(const Elf32_Ehdr * hdr, const Elf_Shdr * sechdrs,
-		struct module *module)
+int module_finalize(const struct load_info *info, struct module *module)
 {
 	return 0;
 }
--- a/arch/nios2/kernel/module.c
+++ b/arch/nios2/kernel/module.c
@@ -130,8 +130,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	return 0;
 }
 
-int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
-			struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
 	flush_cache_all();
 	return 0;
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -854,10 +854,10 @@ deregister_unwind_table(struct module *m
 		unwind_table_remove(me->arch.unwind);
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	int i;
 	unsigned long nsyms;
 	const char *strtab = NULL;
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -31,9 +31,10 @@ static const Elf_Shdr *find_section(cons
 	return NULL;
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		const Elf_Shdr *sechdrs, struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	const Elf_Shdr *sect;
 	int rc;
 
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -437,10 +437,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs
 	return 0;
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	const Elf_Shdr *s;
 	char *secstrings, *secname;
 	void *aseg;
--- a/arch/sh/kernel/module.c
+++ b/arch/sh/kernel/module.c
@@ -96,10 +96,10 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	return 0;
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	int ret = 0;
 
 	ret |= module_dwarf_finalize(hdr, sechdrs, me);
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -204,10 +204,11 @@ static void do_patch_sections(const Elf_
 	}
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
+
 	/* make jump label nops */
 	jump_label_apply_nops(me);
 
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -217,10 +217,10 @@ int apply_relocate_add(Elf64_Shdr *sechd
 }
 #endif
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const struct load_info *info, struct module *me)
 {
+	const Elf_Ehdr *hdr = info->hdr;
+	const Elf_Shdr *sechdrs = info->sechdrs;
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -101,9 +101,7 @@ static inline int apply_relocate_add(Elf
 #endif
 
 /* Any final processing of module before access.  Return -error or 0. */
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *mod);
+int module_finalize(const struct load_info *info, struct module *mod);
 
 /* Any cleanup needed when module leaves. */
 void module_arch_cleanup(struct module *mod);
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3425,9 +3425,7 @@ static void module_deallocate(struct mod
 	module_memfree(mod->core_layout.base);
 }
 
-int __weak module_finalize(const Elf_Ehdr *hdr,
-			   const Elf_Shdr *sechdrs,
-			   struct module *me)
+int __weak module_finalize(const struct load_info *info, struct module *me)
 {
 	return 0;
 }
@@ -3445,7 +3443,7 @@ static int post_relocation(struct module
 	add_kallsyms(mod, info);
 
 	/* Arch-specific module finalizing. */
-	return module_finalize(info->hdr, info->sechdrs, mod);
+	return module_finalize(info, mod);
 }
 
 /* Is this module of this name done loading?  No locks held. */


