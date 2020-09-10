Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E881D207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQBmY9n9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C73i5HmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgIJJet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:34:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgIJJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:58 -0400
Date:   Thu, 10 Sep 2020 09:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuvqqRXJuy4AxNTIjUYc67o70JUO6qIKvX0Urxz1YoA=;
        b=GQBmY9n9payBOhVW8DiUpyxGsICCmbqSqvgcyEhk70MgLvZ4gECBWDGF2pWcb4JM0qgOfd
        c2BLmwIrTpzZ98bwCFsBsPNagjmRJ1CUwoCNp6XaAPVKzhinNXcmo78R+5VSiNmzkxHl0U
        arBnQ7VmUjsjzR5gbo4LJMy8gYoNneahLV2ujgU9Qv5drevtCeh0EWTrfglQ53T8kq0gPv
        Hf12lgzlpOjlSjCkR+vp/9PdaBGzC1xIaeN7ToqYg476owjXC9C+XxTFKnjAlSlbX5KRBV
        CWiodJDx/xdAkqAu/oZ5SxumT3VtJ8GAs05bIzjRUtLhgveEvRXScGO4YfVC3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuvqqRXJuy4AxNTIjUYc67o70JUO6qIKvX0Urxz1YoA=;
        b=C73i5HmPB5nMGozEqKuXft+/GV+JQj++9cAb50zHPSuo+joxPyFHPMgqu8m06QRSqjdKxe
        J5cdxKPKcrV4O4CA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Change add_identity_map() to
 take start and end
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-19-joro@8bytes.org>
References: <20200907131613.12703-19-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974520.20229.11992705813911658779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     21cf2372618ef167d8c4ae04880fb873b55b2daa
Gitweb:        https://git.kernel.org/tip/21cf2372618ef167d8c4ae04880fb873b55b2daa
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:19 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Change add_identity_map() to take start and end

Changing the function to take start and end as parameters instead of
start and size simplifies the callers which don't need to calculate the
size if they already have start and end.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-19-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index c63257b..62e42c1 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -89,10 +89,8 @@ static struct x86_mapping_info mapping_info;
 /*
  * Adds the specified range to the identity mappings.
  */
-static void add_identity_map(unsigned long start, unsigned long size)
+static void add_identity_map(unsigned long start, unsigned long end)
 {
-	unsigned long end = start + size;
-
 	/* Align boundary to 2M. */
 	start = round_down(start, PMD_SIZE);
 	end = round_up(end, PMD_SIZE);
@@ -107,8 +105,6 @@ static void add_identity_map(unsigned long start, unsigned long size)
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
-	unsigned long start, size;
-
 	/* If running as an SEV guest, the encryption mask is required. */
 	set_sev_encryption_mask();
 
@@ -155,9 +151,7 @@ void initialize_identity_maps(void)
 	 * New page-table is set up - map the kernel image and load it
 	 * into cr3.
 	 */
-	start = (unsigned long)_head;
-	size  = _end - _head;
-	add_identity_map(start, size);
+	add_identity_map((unsigned long)_head, (unsigned long)_end);
 	write_cr3(top_level_pgt);
 }
 
@@ -189,7 +183,8 @@ static void do_pf_error(const char *msg, unsigned long error_code,
 
 void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
-	unsigned long address = native_read_cr2();
+	unsigned long address = native_read_cr2() & PMD_MASK;
+	unsigned long end = address + PMD_SIZE;
 
 	/*
 	 * Check for unexpected error codes. Unexpected are:
@@ -204,5 +199,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 * Error code is sane - now identity map the 2M region around
 	 * the faulting address.
 	 */
-	add_identity_map(address & PMD_MASK, PMD_SIZE);
+	add_identity_map(address, end);
 }
