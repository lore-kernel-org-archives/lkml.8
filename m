Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945CDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B40207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7CJem3E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w8caVlwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgIJJfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:35:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbgIJJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:58 -0400
Date:   Thu, 10 Sep 2020 09:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJjYcqsckT6+vW42p3bICGLzydehGxynGVCYwIg/Azc=;
        b=g7CJem3EqVKibzvVj90nVO6VZZFlKOkKTK+lpZ8y/GOfk21630hLPmF48YmeeF6mc2d7CM
        PQcC328IA54oofBjayKVvbcByxzdxrl0qnPxs8LesvUVdL2BZOBxiOKBXq4fLHffkSeU8G
        YyvJoWq0/xFqRsTWszG1rIbpcjXox8D42kDdNVO4PX2ykESTYac9OlCyvlvhwSg8mMmuDf
        YpJmE9nVPps8fbYv+G6bKjk/Z/NfAucdZ6MaptmI131+Q52mqg4T3GAo7quge0UmWnlhBp
        sIcmnt6MQqNPElqOMs9CEYJQxeKNlAJIj1vGi3YFXDXA/ffhEqVYUL4ds427DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJjYcqsckT6+vW42p3bICGLzydehGxynGVCYwIg/Azc=;
        b=w8caVlwo53Qrr7zmie/e9ll095pQzpt8doY6XZ8F2fzb2xsf31LVdVUGnSGRYbijcZzA58
        x8GAqxUEmbgZ8aDA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Don't pre-map memory in KASLR code
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-18-joro@8bytes.org>
References: <20200907131613.12703-18-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974561.20229.17749457811513210209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     8570978ea030757839747aa9944ea576708be3d4
Gitweb:        https://git.kernel.org/tip/8570978ea030757839747aa9944ea576708be3d4
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Don't pre-map memory in KASLR code

With the page-fault handler in place, he identity mapping can be built
on-demand. So remove the code which manually creates the mappings and
unexport/remove the functions used for it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-18-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c |  6 ++----
 arch/x86/boot/compressed/kaslr.c        | 24 +-----------------------
 arch/x86/boot/compressed/misc.h         | 10 +----------
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index ecf9353..c63257b 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -87,11 +87,9 @@ phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 static struct x86_mapping_info mapping_info;
 
 /*
- * Adds the specified range to what will become the new identity mappings.
- * Once all ranges have been added, the new mapping is activated by calling
- * finalize_identity_maps() below.
+ * Adds the specified range to the identity mappings.
  */
-void add_identity_map(unsigned long start, unsigned long size)
+static void add_identity_map(unsigned long start, unsigned long size)
 {
 	unsigned long end = start + size;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8266286..b59547c 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -397,8 +397,6 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	 */
 	mem_avoid[MEM_AVOID_ZO_RANGE].start = input;
 	mem_avoid[MEM_AVOID_ZO_RANGE].size = (output + init_size) - input;
-	add_identity_map(mem_avoid[MEM_AVOID_ZO_RANGE].start,
-			 mem_avoid[MEM_AVOID_ZO_RANGE].size);
 
 	/* Avoid initrd. */
 	initrd_start  = (u64)boot_params->ext_ramdisk_image << 32;
@@ -416,15 +414,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 		cmd_line_size = strnlen((char *)cmd_line, COMMAND_LINE_SIZE-1) + 1;
 		mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
 		mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
-		add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
-				 mem_avoid[MEM_AVOID_CMDLINE].size);
 	}
 
 	/* Avoid boot parameters. */
 	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
 	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params);
-	add_identity_map(mem_avoid[MEM_AVOID_BOOTPARAMS].start,
-			 mem_avoid[MEM_AVOID_BOOTPARAMS].size);
 
 	/* We don't need to set a mapping for setup_data. */
 
@@ -433,11 +427,6 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 
 	/* Enumerate the immovable memory regions */
 	num_immovable_mem = count_immovable_mem_regions();
-
-#ifdef CONFIG_X86_VERBOSE_BOOTUP
-	/* Make sure video RAM can be used. */
-	add_identity_map(0, PMD_SIZE);
-#endif
 }
 
 /*
@@ -884,19 +873,8 @@ void choose_random_location(unsigned long input,
 		warn("Physical KASLR disabled: no suitable memory region!");
 	} else {
 		/* Update the new physical address location. */
-		if (*output != random_addr) {
-			add_identity_map(random_addr, output_size);
+		if (*output != random_addr)
 			*output = random_addr;
-		}
-
-		/*
-		 * This loads the identity mapping page table.
-		 * This should only be done if a new physical address
-		 * is found for the kernel, otherwise we should keep
-		 * the old page table to make it be like the "nokaslr"
-		 * case.
-		 */
-		finalize_identity_maps();
 	}
 
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index f0e1991..9840c82 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -98,17 +98,7 @@ static inline void choose_random_location(unsigned long input,
 #endif
 
 #ifdef CONFIG_X86_64
-void initialize_identity_maps(void);
-void add_identity_map(unsigned long start, unsigned long size);
-void finalize_identity_maps(void);
 extern unsigned char _pgtable[];
-#else
-static inline void initialize_identity_maps(void)
-{ }
-static inline void add_identity_map(unsigned long start, unsigned long size)
-{ }
-static inline void finalize_identity_maps(void)
-{ }
 #endif
 
 #ifdef CONFIG_EARLY_PRINTK
