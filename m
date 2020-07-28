Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2599C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CF3206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PERDkGdP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7ZiMkie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgG1M3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgG1M3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA54EC061794;
        Tue, 28 Jul 2020 05:29:15 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:29:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595939354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dh6iT19Y5aJMygPkf4BsvdwSUV4vIq90eS9R5b13Ccc=;
        b=PERDkGdPJmUKrYpTlBc1wg6dDvy2nUJ6n5VMELSQe1VC9BEY+vuJ37yUeHClwUnl41COIX
        7mZZPV2a/HCEbvrOZs6UOPIiOArngxkzeTua7jr483yMLRML4oeXu5yng6TSKEK7KjTRNo
        zV4KHr/rYxUYDdjnAUQSShvihuDclXxemNjNBS2nqTh6smlvH5LHtKoqy3TUz2LzqsJpza
        UzY0THdp+vWZvWh29FzjrC0sdm5wdMZxcZQGHY1w2K/1wR4PDS9O3u2XK9azVTuveZzkEW
        HOkHBR1i6713dEHpxPQoAwcN1g+6AhMBooANpxyTO/vElIG5y3Njk8Ls5EGWzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595939354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dh6iT19Y5aJMygPkf4BsvdwSUV4vIq90eS9R5b13Ccc=;
        b=M7ZiMkieGpketOvEJHHHyuyrGA4z77SCwAkpG5hltma0S0kqsO4N4lhlH5+3NyBJfrzDr5
        oCJYN6MJjBA76oAw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Initialize mem_limit to the real maximum address
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727230801.3468620-5-nivedita@alum.mit.edu>
References: <20200727230801.3468620-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159593935381.4006.15286062458507437060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     7f104ea54e69ec45cbc4948cdb7d7f74d46def6d
Gitweb:        https://git.kernel.org/tip/7f104ea54e69ec45cbc4948cdb7d7f74d46def6d
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 27 Jul 2020 19:07:57 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jul 2020 12:54:43 +02:00

x86/kaslr: Initialize mem_limit to the real maximum address

On 64-bit, the kernel must be placed below MAXMEM (64TiB with 4-level
paging or 4PiB with 5-level paging). This is currently not enforced by
KASLR, which thus implicitly relies on physical memory being limited to
less than 64TiB.

On 32-bit, the limit is KERNEL_IMAGE_SIZE (512MiB). This is enforced by
special checks in __process_mem_region().

Initialize mem_limit to the maximum (depending on architecture), instead
of ULLONG_MAX, and make sure the command-line arguments can only
decrease it. This makes the enforcement explicit on 64-bit, and
eliminates the 32-bit specific checks to keep the kernel below 512M.

Check upfront to make sure the minimum address is below the limit before
doing any work.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200727230801.3468620-5-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 41 ++++++++++++++++---------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 207fcb7..758d784 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -94,8 +94,11 @@ static unsigned long get_boot_seed(void)
 static bool memmap_too_large;
 
 
-/* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
-static unsigned long long mem_limit = ULLONG_MAX;
+/*
+ * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
+ * It may be reduced by "mem=nn[KMG]" or "memmap=nn[KMG]" command line options.
+ */
+static unsigned long long mem_limit;
 
 /* Number of immovable memory regions */
 static int num_immovable_mem;
@@ -221,7 +224,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 
 		if (start == 0) {
 			/* Store the specified memory limit if size > 0 */
-			if (size > 0)
+			if (size > 0 && size < mem_limit)
 				mem_limit = size;
 
 			continue;
@@ -311,7 +314,8 @@ static void handle_mem_options(void)
 			if (mem_size == 0)
 				break;
 
-			mem_limit = mem_size;
+			if (mem_size < mem_limit)
+				mem_limit = mem_size;
 		} else if (!strcmp(param, "efi_fake_mem")) {
 			mem_avoid_memmap(PARSE_EFI, val);
 		}
@@ -322,7 +326,9 @@ static void handle_mem_options(void)
 }
 
 /*
- * In theory, KASLR can put the kernel anywhere in the range of [16M, 64T).
+ * In theory, KASLR can put the kernel anywhere in the range of [16M, MAXMEM)
+ * on 64-bit, and [16M, KERNEL_IMAGE_SIZE) on 32-bit.
+ *
  * The mem_avoid array is used to store the ranges that need to be avoided
  * when KASLR searches for an appropriate random address. We must avoid any
  * regions that are unsafe to overlap with during decompression, and other
@@ -619,10 +625,6 @@ static void __process_mem_region(struct mem_vector *entry,
 	unsigned long start_orig, end;
 	struct mem_vector cur_entry;
 
-	/* On 32-bit, ignore entries entirely above our maximum. */
-	if (IS_ENABLED(CONFIG_X86_32) && entry->start >= KERNEL_IMAGE_SIZE)
-		return;
-
 	/* Ignore entries entirely below our minimum. */
 	if (entry->start + entry->size < minimum)
 		return;
@@ -655,11 +657,6 @@ static void __process_mem_region(struct mem_vector *entry,
 		/* Reduce size by any delta from the original address. */
 		region.size -= region.start - start_orig;
 
-		/* On 32-bit, reduce region size to fit within max size. */
-		if (IS_ENABLED(CONFIG_X86_32) &&
-		    region.start + region.size > KERNEL_IMAGE_SIZE)
-			region.size = KERNEL_IMAGE_SIZE - region.start;
-
 		/* Return if region can't contain decompressed kernel */
 		if (region.size < image_size)
 			return;
@@ -844,15 +841,16 @@ static void process_e820_entries(unsigned long minimum,
 static unsigned long find_random_phys_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
+	/* Bail out early if it's impossible to succeed. */
+	if (minimum + image_size > mem_limit)
+		return 0;
+
 	/* Check if we had too many memmaps. */
 	if (memmap_too_large) {
 		debug_putstr("Aborted memory entries scan (more than 4 memmap= args)!\n");
 		return 0;
 	}
 
-	/* Make sure minimum is aligned. */
-	minimum = ALIGN(minimum, CONFIG_PHYSICAL_ALIGN);
-
 	if (process_efi_entries(minimum, image_size))
 		return slots_fetch_random();
 
@@ -865,8 +863,6 @@ static unsigned long find_random_virt_addr(unsigned long minimum,
 {
 	unsigned long slots, random_addr;
 
-	/* Make sure minimum is aligned. */
-	minimum = ALIGN(minimum, CONFIG_PHYSICAL_ALIGN);
 	/* Align image_size for easy slot calculations. */
 	image_size = ALIGN(image_size, CONFIG_PHYSICAL_ALIGN);
 
@@ -913,6 +909,11 @@ void choose_random_location(unsigned long input,
 	/* Prepare to add new identity pagetables on demand. */
 	initialize_identity_maps();
 
+	if (IS_ENABLED(CONFIG_X86_32))
+		mem_limit = KERNEL_IMAGE_SIZE;
+	else
+		mem_limit = MAXMEM;
+
 	/* Record the various known unsafe memory ranges. */
 	mem_avoid_init(input, input_size, *output);
 
@@ -922,6 +923,8 @@ void choose_random_location(unsigned long input,
 	 * location:
 	 */
 	min_addr = min(*output, 512UL << 20);
+	/* Make sure minimum is aligned. */
+	min_addr = ALIGN(min_addr, CONFIG_PHYSICAL_ALIGN);
 
 	/* Walk available memory entries to find a random address. */
 	random_addr = find_random_phys_addr(min_addr, output_size);
