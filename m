Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA75C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09EE22BEB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgG0Vu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:50:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45112 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgG0Vuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id u64so16776056qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vdg4R9IlBMQJFLxxONzxLbpEtNY8LPO+TfSqUxrfSQ=;
        b=A6s8dgGdxELJGiubpu//6Hz4rfQGOl/+oeydgtuNKh50ZnyHapfNPfa5KXVCx6SyTQ
         MlG3uLSqDZyAvlq3cSEbCmFtiuaQ46hUFZDDqjGlAipfXYBpXDva5qjGrjVQMr58G0z9
         Luvo+8p7kYg36Xt3hF21ouimcuZ1D6tAc72s9ZgOF/+NlqXck+vvZrhExZH9QfAMrudn
         O5TGEIuTXfUXXgZxIW3+T7h4u1JwPIhVPWfVPgO+SMFybxDqpA5VIybdHaLLEbhleKhA
         YgQhkunHGVte65/v+DZfH3dELs3e1p36xMOXWjrucR+6IjqsaBcs1WD2PaXwq0kFtYib
         LReg==
X-Gm-Message-State: AOAM531OcIHrpEKtJ2M23YdfIAAr0Jr7UXvEPFnTD8sp05HF+ko7jwn5
        ntnNh8ULsO+Tm2Rj/LeM2jg=
X-Google-Smtp-Source: ABdhPJz9Bn5d17pOCHcEZ4Y1hfus5s356KhGFTO+MkQY8KzkHU7ghVNNqoKckCWGvP0wYBQ/IkVPoA==
X-Received: by 2002:a37:a30b:: with SMTP id m11mr25195301qke.12.1595886653251;
        Mon, 27 Jul 2020 14:50:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] x86/kaslr: Initialize mem_limit to the real maximum address
Date:   Mon, 27 Jul 2020 17:50:43 -0400
Message-Id: <20200727215047.3341098-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit, the kernel must be placed below MAXMEM (64TiB with 4-level
paging or 4PiB with 5-level paging). This is currently not enforced by
KASLR, which thus implicitly relies on physical memory being limited to
less than 64TiB.

On 32-bit, the limit is KERNEL_IMAGE_SIZE (512MiB). This is enforced by
special checks in __process_mem_region.

Initialize mem_limit to the maximum (depending on architecture), instead
of ULLONG_MAX, and make sure the command-line arguments can only
decrease it. This makes the enforcement explicit on 64-bit, and
eliminates the 32-bit specific checks to keep the kernel below 512M.

Check upfront to make sure the minimum address is below the limit before
doing any work.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 41 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 207fcb7e7b71..758d78433f94 100644
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
-- 
2.26.2

