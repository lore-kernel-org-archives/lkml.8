Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9447DC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7696C20809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgG0XIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:08:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38435 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgG0XIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:08:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id e13so16990271qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkR3OCxoCbxG3vF6cRMTnE0zZTwV830b9tfRaVWZTTE=;
        b=OeQZwpSRli1eFMy0Pyezv/GOJuXSZRFypsFysvQSo7BBZpZM3oUveaEwqW5g/qGDWD
         0zlSQ+A2cmQ5M5b3mogyTBDyv/FexStpG/I7nK/wJ7Qaz1xcRRlyl4NWKQS23vDloR1o
         w+trXzT/qmw8oEKUAoLZyMI0Sq1qbGCPVHqAG0JvC1LApDykS0BECIFYMfQx3B7m8Gf1
         fkZKwFXw9jleDOCA9sg8pSbVLZyGtZdRGDXhxL0zLQ58lEZMqgBj9Zo8WgsBG/PlDBm4
         POWS6KOxCaxU+gf1Zg0GdKtaRqjNgizdSDV0armiYeLiyBSX/GjcZYIATWImY6LYZevE
         a9uQ==
X-Gm-Message-State: AOAM5323n5fHBS/t7P+yfj74RlXrjvURsl6JADYRlbXEMt0fG6yctMMf
        WtFejveOiA0fXEah4cThIno=
X-Google-Smtp-Source: ABdhPJx9nehytSJtgwS3+bxIDMx/94uD9yQEK8lTrn1lNZs3i1T86yFXj+/uQWtFqWMXvqnNmuqD0A==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr25967516qke.85.1595891290483;
        Mon, 27 Jul 2020 16:08:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j61sm8216984qtd.52.2020.07.27.16.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:08:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] x86/kaslr: Don't use 64-bit mem_vector for 32-bit kernel
Date:   Mon, 27 Jul 2020 19:08:01 -0400
Message-Id: <20200727230801.3468620-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
  f28442497b5c ("x86/boot: Fix KASLR and memmap= collision")
converted mem_vector type to use 64-bit on the 32-bit kernel as well,
based on Thomas's review [0]. However:
- the code still doesn't consistently use 64-bit types. For instance,
  mem_avoid_overlap uses 32-bit types when checking for overlaps.  This
  is actually okay, as the passed in memory range will have been clipped
  to below 4G, but it is difficult to reason about the safety of the
  code.
- KASLR on 32-bit can't use memory above 4G anyway, so it's pointless
  to keep track of ranges above 4G.

Switch the type back to unsigned long, and use a helper function to clip
regions to 4G on 32-bit, when storing mem_avoid, immovable_mem, EFI,
E820 and command-line memory regions.

[0] https://lore.kernel.org/linux-nvdimm/alpine.DEB.2.20.1701111246400.3579@nanos/

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/acpi.c  |  7 +++----
 arch/x86/boot/compressed/kaslr.c | 25 ++++++++++---------------
 arch/x86/boot/compressed/misc.h  | 19 +++++++++++++++++--
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee54aa1..d09e0ec5637e 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -106,7 +106,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	}
 
 	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
+	systab = (efi_system_table_64_t *) (ei->efi_systab | ((u64)ei->efi_systab_hi << 32));
 	if (!systab)
 		error("EFI system table not found in kexec boot_params.");
 
@@ -139,7 +139,7 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 
 	/* Get systab from boot params. */
 #ifdef CONFIG_X86_64
-	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+	systab = ei->efi_systab | ((u64)ei->efi_systab_hi << 32);
 #else
 	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
 		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
@@ -404,8 +404,7 @@ int count_immovable_mem_regions(void)
 
 			ma = (struct acpi_srat_mem_affinity *)sub_table;
 			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
-				immovable_mem[num].start = ma->base_address;
-				immovable_mem[num].size = ma->length;
+				immovable_mem[num] = mem_vector_ctor(ma->base_address, ma->length);
 				num++;
 			}
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index eca2acc65e2a..8c44041ae9cb 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -98,7 +98,7 @@ static bool memmap_too_large;
  * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
  * It may be reduced by "mem=nn[KMG]" or "memmap=nn[KMG]" command line options.
  */
-static unsigned long long mem_limit;
+static unsigned long mem_limit;
 
 /* Number of immovable memory regions */
 static int num_immovable_mem;
@@ -141,8 +141,7 @@ enum parse_mode {
 };
 
 static int
-parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
-		enum parse_mode mode)
+parse_memmap(char *p, u64 *start, u64 *size, enum parse_mode mode)
 {
 	char *oldp;
 
@@ -172,7 +171,7 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
 			 */
 			*size = 0;
 		} else {
-			unsigned long long flags;
+			u64 flags;
 
 			/*
 			 * efi_fake_mem=nn@ss:attr the attr specifies
@@ -211,7 +210,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 
 	while (str && (i < MAX_MEMMAP_REGIONS)) {
 		int rc;
-		unsigned long long start, size;
+		u64 start, size;
 		char *k = strchr(str, ',');
 
 		if (k)
@@ -230,8 +229,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 			continue;
 		}
 
-		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].start = start;
-		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size = size;
+		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i] = mem_vector_ctor(start, size);
 		i++;
 	}
 
@@ -422,8 +420,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	initrd_start |= boot_params->hdr.ramdisk_image;
 	initrd_size  = (u64)boot_params->ext_ramdisk_size << 32;
 	initrd_size |= boot_params->hdr.ramdisk_size;
-	mem_avoid[MEM_AVOID_INITRD].start = initrd_start;
-	mem_avoid[MEM_AVOID_INITRD].size = initrd_size;
+	mem_avoid[MEM_AVOID_INITRD] = mem_vector_ctor(initrd_start, initrd_size);
 	/* No need to set mapping for initrd, it will be handled in VO. */
 
 	/* Avoid kernel command line. */
@@ -673,7 +670,7 @@ static bool process_mem_region(struct mem_vector *region,
 	 * immovable memory and @region.
 	 */
 	for (i = 0; i < num_immovable_mem; i++) {
-		unsigned long long start, end, entry_end, region_end;
+		unsigned long start, end, entry_end, region_end;
 		struct mem_vector entry;
 
 		if (!mem_overlaps(region, &immovable_mem[i]))
@@ -728,7 +725,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 	}
 	pmap =  e->efi_memmap;
 #else
-	pmap = (e->efi_memmap | ((__u64)e->efi_memmap_hi << 32));
+	pmap = (e->efi_memmap | ((u64)e->efi_memmap_hi << 32));
 #endif
 
 	nr_desc = e->efi_memmap_size / e->efi_memdesc_size;
@@ -765,8 +762,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
 			continue;
 
-		region.start = md->phys_addr;
-		region.size = md->num_pages << EFI_PAGE_SHIFT;
+		region = mem_vector_ctor(md->phys_addr, md->num_pages << EFI_PAGE_SHIFT);
 		if (process_mem_region(&region, minimum, image_size))
 			break;
 	}
@@ -793,8 +789,7 @@ static void process_e820_entries(unsigned long minimum,
 		/* Skip non-RAM entries. */
 		if (entry->type != E820_TYPE_RAM)
 			continue;
-		region.start = entry->addr;
-		region.size = entry->size;
+		region = mem_vector_ctor(entry->addr, entry->size);
 		if (process_mem_region(&region, minimum, image_size))
 			break;
 	}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264410ff..fd7c49ab0f02 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -70,10 +70,25 @@ int cmdline_find_option(const char *option, char *buffer, int bufsize);
 int cmdline_find_option_bool(const char *option);
 
 struct mem_vector {
-	unsigned long long start;
-	unsigned long long size;
+	unsigned long start;
+	unsigned long size;
 };
 
+static inline
+struct mem_vector mem_vector_ctor(u64 start, u64 size)
+{
+	u64 end = start + size;
+	struct mem_vector ret;
+
+	start = min_t(u64, start, ULONG_MAX);
+	end   = min_t(u64, end,   ULONG_MAX);
+
+	ret.start = (unsigned long)start;
+	ret.size  = (unsigned long)(end - start);
+
+	return ret;
+}
+
 #if CONFIG_RANDOMIZE_BASE
 /* kaslr.c */
 void choose_random_location(unsigned long input,
-- 
2.26.2

