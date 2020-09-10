Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA3C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9376721D79
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nw/5syFj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bkaxo52r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgIJJ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbgIJJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D00C0617BC;
        Thu, 10 Sep 2020 02:22:27 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdIzARFw3GA/TJ+BgwAX61yKblvq1LRO9bOgtIxvWnQ=;
        b=nw/5syFjULea55SJ/TFtKfQWMdtcdZgQZ+CtdibNK9zUKFAz/vR0qJ/xZvajRFux6HPAB5
        XV0gy3erKJ/p6aHzb5BXf9+PW6BDRhtImKX9mmbyoiVT5jK4HRYjjbXT5sIctKQ4r2rlDh
        Ar+i2AZdkvMP35CenfGuS8wwsoKoNNvUrHeXTCVudp5khnVrYH9A/0v1YttDYh51jJZNIZ
        to0boG3QFB1ewDL9InV3g2FhhRXt2XoZAlsXNefQGRUkSTrHou/T14jJkuyrI4L2D660Ng
        Yn+nXvdDFGemZtWFCh2XDv6ArFAex4w6Wqh9m8fjjt7UaX8QeU6XcBrXEV0PVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdIzARFw3GA/TJ+BgwAX61yKblvq1LRO9bOgtIxvWnQ=;
        b=bkaxo52rjYdFSNZVCx99WAfSVnSQgRRXWO2bqJmqOnz3Eoti1rbs4MkL++vuXCk6UUfscF
        N2PLsvIlbLzjYYDA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Unmap GHCB page before
 booting the kernel
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-25-joro@8bytes.org>
References: <20200907131613.12703-25-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974262.20229.6139985453558606156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     69add17a7c1992593a7cf775a66e0256ad4b3ef8
Gitweb:        https://git.kernel.org/tip/69add17a7c1992593a7cf775a66e0256ad4b3ef8
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:25 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:26 +02:00

x86/boot/compressed/64: Unmap GHCB page before booting the kernel

Force a page-fault on any further accesses to the GHCB page when they
shouldn't happen anymore. This will catch any bugs where a #VC exception
is raised even though none is expected anymore.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-25-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c | 17 +++++++++++++++--
 arch/x86/boot/compressed/misc.h         |  6 ++++++
 arch/x86/boot/compressed/sev-es.c       | 14 ++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 05742f6..063a60e 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -298,6 +298,11 @@ int set_page_encrypted(unsigned long address)
 	return set_clr_page_flags(&mapping_info, address, _PAGE_ENC, 0);
 }
 
+int set_page_non_present(unsigned long address)
+{
+	return set_clr_page_flags(&mapping_info, address, 0, _PAGE_PRESENT);
+}
+
 static void do_pf_error(const char *msg, unsigned long error_code,
 			unsigned long address, unsigned long ip)
 {
@@ -316,8 +321,14 @@ static void do_pf_error(const char *msg, unsigned long error_code,
 
 void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
-	unsigned long address = native_read_cr2() & PMD_MASK;
-	unsigned long end = address + PMD_SIZE;
+	unsigned long address = native_read_cr2();
+	unsigned long end;
+	bool ghcb_fault;
+
+	ghcb_fault = sev_es_check_ghcb_fault(address);
+
+	address   &= PMD_MASK;
+	end        = address + PMD_SIZE;
 
 	/*
 	 * Check for unexpected error codes. Unexpected are:
@@ -327,6 +338,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
 		do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
+	else if (ghcb_fault)
+		do_pf_error("Page-fault on GHCB page:", error_code, address, regs->ip);
 
 	/*
 	 * Error code is sane - now identity map the 2M region around
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9995c70..c0e0ffe 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -100,6 +100,7 @@ static inline void choose_random_location(unsigned long input,
 #ifdef CONFIG_X86_64
 extern int set_page_decrypted(unsigned long address);
 extern int set_page_encrypted(unsigned long address);
+extern int set_page_non_present(unsigned long address);
 extern unsigned char _pgtable[];
 #endif
 
@@ -117,8 +118,13 @@ void set_sev_encryption_mask(void);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_es_shutdown_ghcb(void);
+extern bool sev_es_check_ghcb_fault(unsigned long address);
 #else
 static inline void sev_es_shutdown_ghcb(void) { }
+static inline bool sev_es_check_ghcb_fault(unsigned long address)
+{
+	return false;
+}
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index fa62af7..1e1fab5 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -121,6 +121,20 @@ void sev_es_shutdown_ghcb(void)
 	 */
 	if (set_page_encrypted((unsigned long)&boot_ghcb_page))
 		error("Can't map GHCB page encrypted");
+
+	/*
+	 * GHCB page is mapped encrypted again and flushed from the cache.
+	 * Mark it non-present now to catch bugs when #VC exceptions trigger
+	 * after this point.
+	 */
+	if (set_page_non_present((unsigned long)&boot_ghcb_page))
+		error("Can't unmap GHCB page");
+}
+
+bool sev_es_check_ghcb_fault(unsigned long address)
+{
+	/* Check whether the fault was on the GHCB page */
+	return ((address & PAGE_MASK) == (unsigned long)&boot_ghcb_page);
 }
 
 void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
