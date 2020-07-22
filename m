Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4B7C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BEB20714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zzNRzUJ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNDvYpFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgGVHnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgGVHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:43:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6DC0619DC;
        Wed, 22 Jul 2020 00:43:19 -0700 (PDT)
Date:   Wed, 22 Jul 2020 07:43:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595403798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Db1wdKYPIimmtf1l3hw9m3QkqqfJBaJhG6EdP4Vlb7s=;
        b=zzNRzUJ6IxTIhgE4iTWPQ2F6WgxPw3pPAQ48o9V9rIdadRy2sg4oPqgVnbEwGGABhj6lTb
        JXPiPx/3lLUWro2SqlxfAbdUxvxvWTvy3LpjI5SQfZQnB5TfbgYebg2fNnY2OgM+ZUPWwW
        PitXyKMikXhEdV9rDXrqoRp8gB7vUZq1sFUIIAwuu+zvm5sECMVwCjOz4B1q+PxaXrfwE4
        zxvxLcCLU2eJTqxBAQ3h8kHa3qT0gaW1nBmBWNhzC2L3e/zelWi1luzPc0wRAKa3CZrVwP
        O2Nyt0Y+4VYD4+1pbn7/9m43BAWJoboJDxLsBeVBu5HUqeuh2j5jFCcMJ7ML0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595403798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Db1wdKYPIimmtf1l3hw9m3QkqqfJBaJhG6EdP4Vlb7s=;
        b=JNDvYpFHKL8ZKomlaz4+Lz2rcjPtbMVTUEtYiBGi33ptlzofqwOQVcM0WuzOCq8hif1Hj5
        6QD3VFLrZhy/bLDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86, vmlinux.lds: Page-align end of ..page_aligned sections
Cc:     Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200721093448.10417-1-joro@8bytes.org>
References: <20200721093448.10417-1-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159540379715.4006.10183205907724642540.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     de2b41be8fcccb2f5b6c480d35df590476344201
Gitweb:        https://git.kernel.org/tip/de2b41be8fcccb2f5b6c480d35df590476344201
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 21 Jul 2020 11:34:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jul 2020 09:38:37 +02:00

x86, vmlinux.lds: Page-align end of ..page_aligned sections

On x86-32 the idt_table with 256 entries needs only 2048 bytes. It is
page-aligned, but the end of the .bss..page_aligned section is not
guaranteed to be page-aligned.

As a result, objects from other .bss sections may end up on the same 4k
page as the idt_table, and will accidentially get mapped read-only during
boot, causing unexpected page-faults when the kernel writes to them.

This could be worked around by making the objects in the page aligned
sections page sized, but that's wrong.

Explicit sections which store only page aligned objects have an implicit
guarantee that the object is alone in the page in which it is placed. That
works for all objects except the last one. That's inconsistent.

Enforcing page sized objects for these sections would wreckage memory
sanitizers, because the object becomes artificially larger than it should
be and out of bound access becomes legit.

Align the end of the .bss..page_aligned and .data..page_aligned section on
page-size so all objects places in these sections are guaranteed to have
their own page.

[ tglx: Amended changelog ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200721093448.10417-1-joro@8bytes.org
---
 arch/x86/kernel/vmlinux.lds.S     | 1 +
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd..9a03e5b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -358,6 +358,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
+		. = ALIGN(PAGE_SIZE);
 		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef..052e0f0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -341,7 +341,8 @@
 
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
-	*(.data..page_aligned)
+	*(.data..page_aligned)						\
+	. = ALIGN(page_align);
 
 #define READ_MOSTLY_DATA(align)						\
 	. = ALIGN(align);						\
@@ -737,7 +738,9 @@
 	. = ALIGN(bss_align);						\
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
 		BSS_FIRST_SECTIONS					\
+		. = ALIGN(PAGE_SIZE);					\
 		*(.bss..page_aligned)					\
+		. = ALIGN(PAGE_SIZE);					\
 		*(.dynbss)						\
 		*(BSS_MAIN)						\
 		*(COMMON)						\
