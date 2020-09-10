Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4653CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E392321556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="so72j/GB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9t7v9lt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgIJJgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38970 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbgIJJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:29 -0400
Date:   Thu, 10 Sep 2020 09:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gx0QGEvHxisXvWcUkCNlHibymu2ehyqZiypSVAGsVG8=;
        b=so72j/GBM5YVXYt7WsCTULtxrmVgtfEemu2sredLhDSHSG7E07VDNOIdBPXWdhswz72qWK
        el/uY8Nw3psyFoGJudgsg3C+JcVNMi0on4G22gdTk+Ldu6p7K0pCkn5cZ+2BCFAJiM8FBf
        WONlV1BB1OHv+fPeMdKyz8FhDXEiOEe8uKuN8kNIz1IEf30TjvfeDQaD5cHIvP8xlcTKKb
        NMJh4p01JeJwdYrifR+PcZ+WVoEFCHgPx894Dp2oKP0ny4/c0G1ckXCM7+DmydUnAQLibd
        BNVkvHqfmnD/kyR+LOvOtXhhz+yHucmW9JXmkLCG8JP6bcv3jAKiWqOe/CQlBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gx0QGEvHxisXvWcUkCNlHibymu2ehyqZiypSVAGsVG8=;
        b=9t7v9lt5CUQjC/cFmKgAUHpFnP8sNdsxnNZPH4hBg47Tb2vN8YEFnW6oGDrS0dgiZBf+B1
        GBYACd33XZGphSAw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Add set_page_en/decrypted() helpers
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-23-joro@8bytes.org>
References: <20200907131613.12703-23-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974350.20229.4361067927128131337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     c81d60029a1393183d2125fcb4b64831629b8864
Gitweb:        https://git.kernel.org/tip/c81d60029a1393183d2125fcb4b64831629b8864
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Add set_page_en/decrypted() helpers

The functions are needed to map the GHCB for SEV-ES guests. The GHCB
is used for communication with the hypervisor, so its content must not
be encrypted. After the GHCB is not needed anymore it must be mapped
encrypted again so that the running kernel image can safely re-use the
memory.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-23-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c | 133 +++++++++++++++++++++++-
 arch/x86/boot/compressed/misc.h         |   2 +-
 2 files changed, 135 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index aa91beb..05742f6 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -24,6 +24,7 @@
 
 /* These actually do the work of building the kernel identity maps. */
 #include <linux/pgtable.h>
+#include <asm/cmpxchg.h>
 #include <asm/trap_pf.h>
 #include <asm/trapnr.h>
 #include <asm/init.h>
@@ -165,6 +166,138 @@ void finalize_identity_maps(void)
 	write_cr3(top_level_pgt);
 }
 
+static pte_t *split_large_pmd(struct x86_mapping_info *info,
+			      pmd_t *pmdp, unsigned long __address)
+{
+	unsigned long page_flags;
+	unsigned long address;
+	pte_t *pte;
+	pmd_t pmd;
+	int i;
+
+	pte = (pte_t *)info->alloc_pgt_page(info->context);
+	if (!pte)
+		return NULL;
+
+	address     = __address & PMD_MASK;
+	/* No large page - clear PSE flag */
+	page_flags  = info->page_flag & ~_PAGE_PSE;
+
+	/* Populate the PTEs */
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		set_pte(&pte[i], __pte(address | page_flags));
+		address += PAGE_SIZE;
+	}
+
+	/*
+	 * Ideally we need to clear the large PMD first and do a TLB
+	 * flush before we write the new PMD. But the 2M range of the
+	 * PMD might contain the code we execute and/or the stack
+	 * we are on, so we can't do that. But that should be safe here
+	 * because we are going from large to small mappings and we are
+	 * also the only user of the page-table, so there is no chance
+	 * of a TLB multihit.
+	 */
+	pmd = __pmd((unsigned long)pte | info->kernpg_flag);
+	set_pmd(pmdp, pmd);
+	/* Flush TLB to establish the new PMD */
+	write_cr3(top_level_pgt);
+
+	return pte + pte_index(__address);
+}
+
+static void clflush_page(unsigned long address)
+{
+	unsigned int flush_size;
+	char *cl, *start, *end;
+
+	/*
+	 * Hardcode cl-size to 64 - CPUID can't be used here because that might
+	 * cause another #VC exception and the GHCB is not ready to use yet.
+	 */
+	flush_size = 64;
+	start      = (char *)(address & PAGE_MASK);
+	end        = start + PAGE_SIZE;
+
+	/*
+	 * First make sure there are no pending writes on the cache-lines to
+	 * flush.
+	 */
+	asm volatile("mfence" : : : "memory");
+
+	for (cl = start; cl != end; cl += flush_size)
+		clflush(cl);
+}
+
+static int set_clr_page_flags(struct x86_mapping_info *info,
+			      unsigned long address,
+			      pteval_t set, pteval_t clr)
+{
+	pgd_t *pgdp = (pgd_t *)top_level_pgt;
+	p4d_t *p4dp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep, pte;
+
+	/*
+	 * First make sure there is a PMD mapping for 'address'.
+	 * It should already exist, but keep things generic.
+	 *
+	 * To map the page just read from it and fault it in if there is no
+	 * mapping yet. add_identity_map() can't be called here because that
+	 * would unconditionally map the address on PMD level, destroying any
+	 * PTE-level mappings that might already exist. Use assembly here so
+	 * the access won't be optimized away.
+	 */
+	asm volatile("mov %[address], %%r9"
+		     :: [address] "g" (*(unsigned long *)address)
+		     : "r9", "memory");
+
+	/*
+	 * The page is mapped at least with PMD size - so skip checks and walk
+	 * directly to the PMD.
+	 */
+	p4dp = p4d_offset(pgdp, address);
+	pudp = pud_offset(p4dp, address);
+	pmdp = pmd_offset(pudp, address);
+
+	if (pmd_large(*pmdp))
+		ptep = split_large_pmd(info, pmdp, address);
+	else
+		ptep = pte_offset_kernel(pmdp, address);
+
+	if (!ptep)
+		return -ENOMEM;
+
+	/*
+	 * Changing encryption attributes of a page requires to flush it from
+	 * the caches.
+	 */
+	if ((set | clr) & _PAGE_ENC)
+		clflush_page(address);
+
+	/* Update PTE */
+	pte = *ptep;
+	pte = pte_set_flags(pte, set);
+	pte = pte_clear_flags(pte, clr);
+	set_pte(ptep, pte);
+
+	/* Flush TLB after changing encryption attribute */
+	write_cr3(top_level_pgt);
+
+	return 0;
+}
+
+int set_page_decrypted(unsigned long address)
+{
+	return set_clr_page_flags(&mapping_info, address, 0, _PAGE_ENC);
+}
+
+int set_page_encrypted(unsigned long address)
+{
+	return set_clr_page_flags(&mapping_info, address, _PAGE_ENC, 0);
+}
+
 static void do_pf_error(const char *msg, unsigned long error_code,
 			unsigned long address, unsigned long ip)
 {
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index eaa8b45..01c0fb3 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -98,6 +98,8 @@ static inline void choose_random_location(unsigned long input,
 #endif
 
 #ifdef CONFIG_X86_64
+extern int set_page_decrypted(unsigned long address);
+extern int set_page_encrypted(unsigned long address);
 extern unsigned char _pgtable[];
 #endif
 
