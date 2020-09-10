Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD8FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E9921556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0Nqn/2v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zij2tl8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIJJZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:25:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgIJJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:02 -0400
Date:   Thu, 10 Sep 2020 09:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQ0Tk6JFDhByUS2I4wk0e5+b83Z8mgW9cbFGKBMDNDE=;
        b=n0Nqn/2vael0F/smWdUrqK9G0e4sYALFHcR+hsrvsDwkInXU/yrEiBttdXBBn9AQ/+ey8w
        g9/wqjYIdCF7YK10GIdCBM4Z9We3iIXl3Hx63C1s5UB+c7MyLp8cgfi0Fe8s381FvHPKWa
        66hXEINX7GnrbwE6puNfxtyrEuIPM+kf+gm8b9U/LRDSKuJ0rpng7vy7YVI1WdT+zd4POj
        29WHCqv12iYc9M6/x4eGE92Ya9xUrpaT1+8ucZg5/edmmb4e5YrSlviUidSsL0tkCsD0x7
        JT/KoGl6gMJBmbMsbm2JLg7SIPjAs2as0tVwHYLSrH62LXHlmqkH1USTntnfNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQ0Tk6JFDhByUS2I4wk0e5+b83Z8mgW9cbFGKBMDNDE=;
        b=zij2tl8Zlfrv+m5Y/X8u/ly58eRwALUJE0UywjcFYVHz/LbzT9MF+ar83tNZRFBmoOAZoN
        jd3migAIVmidrwAQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Always switch to own page table
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-17-joro@8bytes.org>
References: <20200907131613.12703-17-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974601.20229.17646875106304573031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     ca0e22d4f011a56e974fa3a712d76e86a791559d
Gitweb:        https://git.kernel.org/tip/ca0e22d4f011a56e974fa3a712d76e86a791559d
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:17 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Always switch to own page table

When booted through startup_64(), the kernel keeps running on the EFI
page table until the KASLR code sets up its own page table. Without
KASLR, the pre-decompression boot code never switches off the EFI page
table. Change that by unconditionally switching to a kernel-controlled
page table after relocation.

This makes sure the kernel can make changes to the mapping when
necessary, for example map pages unencrypted in SEV and SEV-ES guests.

Also, remove the debug_putstr() calls in initialize_identity_maps()
because the function now runs before console_init() is called.

 [ bp: Massage commit message. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-17-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S      |  3 +-
 arch/x86/boot/compressed/ident_map_64.c | 51 ++++++++++++++----------
 arch/x86/boot/compressed/kaslr.c        |  3 +-
 3 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c634ed8..fb6c039 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -543,10 +543,11 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	rep	stosq
 
 /*
- * Load stage2 IDT
+ * Load stage2 IDT and switch to our own page-table
  */
 	pushq	%rsi
 	call	load_stage2_idt
+	call	initialize_identity_maps
 	popq	%rsi
 
 /*
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index e3d980a..ecf9353 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -86,9 +86,31 @@ phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
  */
 static struct x86_mapping_info mapping_info;
 
+/*
+ * Adds the specified range to what will become the new identity mappings.
+ * Once all ranges have been added, the new mapping is activated by calling
+ * finalize_identity_maps() below.
+ */
+void add_identity_map(unsigned long start, unsigned long size)
+{
+	unsigned long end = start + size;
+
+	/* Align boundary to 2M. */
+	start = round_down(start, PMD_SIZE);
+	end = round_up(end, PMD_SIZE);
+	if (start >= end)
+		return;
+
+	/* Build the mapping. */
+	kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt,
+				  start, end);
+}
+
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
+	unsigned long start, size;
+
 	/* If running as an SEV guest, the encryption mask is required. */
 	set_sev_encryption_mask();
 
@@ -121,37 +143,24 @@ void initialize_identity_maps(void)
 	 */
 	top_level_pgt = read_cr3_pa();
 	if (p4d_offset((pgd_t *)top_level_pgt, 0) == (p4d_t *)_pgtable) {
-		debug_putstr("booted via startup_32()\n");
 		pgt_data.pgt_buf = _pgtable + BOOT_INIT_PGT_SIZE;
 		pgt_data.pgt_buf_size = BOOT_PGT_SIZE - BOOT_INIT_PGT_SIZE;
 		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
 	} else {
-		debug_putstr("booted via startup_64()\n");
 		pgt_data.pgt_buf = _pgtable;
 		pgt_data.pgt_buf_size = BOOT_PGT_SIZE;
 		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
 		top_level_pgt = (unsigned long)alloc_pgt_page(&pgt_data);
 	}
-}
 
-/*
- * Adds the specified range to what will become the new identity mappings.
- * Once all ranges have been added, the new mapping is activated by calling
- * finalize_identity_maps() below.
- */
-void add_identity_map(unsigned long start, unsigned long size)
-{
-	unsigned long end = start + size;
-
-	/* Align boundary to 2M. */
-	start = round_down(start, PMD_SIZE);
-	end = round_up(end, PMD_SIZE);
-	if (start >= end)
-		return;
-
-	/* Build the mapping. */
-	kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt,
-				  start, end);
+	/*
+	 * New page-table is set up - map the kernel image and load it
+	 * into cr3.
+	 */
+	start = (unsigned long)_head;
+	size  = _end - _head;
+	add_identity_map(start, size);
+	write_cr3(top_level_pgt);
 }
 
 /*
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e27de98..8266286 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -861,9 +861,6 @@ void choose_random_location(unsigned long input,
 
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
-	/* Prepare to add new identity pagetables on demand. */
-	initialize_identity_maps();
-
 	if (IS_ENABLED(CONFIG_X86_32))
 		mem_limit = KERNEL_IMAGE_SIZE;
 	else
