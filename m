Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802BC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E564120775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586941426;
	bh=7S68ZLjL4l6EW+nGfsNJ/dF9Dy5JeViAujCBux5QS7U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iYTzCs95JeRAa5h99fZwVt/conLk8sfRXommqgyAokcvO9a9U0s8aHWO2+WPoxdFX
	 SvW44dDy5B6o9l+1yRqbaZdhgUEIk7F3WOpO0aYZSGmdgb0qpp4l+8Dz64o9ZrUOOq
	 mR1DrZPC2LmRBN/prN2mzDbp0dQJpn0NzrcPqKpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393816AbgDOJDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390601AbgDOJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:03:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:03:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a25so18175111wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kde6RKqnAPzPw3YUEEsHxdtQh/py9mEAbvaRrHMWSA4=;
        b=Y5XwWoqDbhnZQZsSXHGogsWpH2SUedQLreZVR7+po0S7U/ZKWdDypmakwkDYbw/fu0
         rAe2nvKx/Ea4+RY5+p8QarzkCfF0U9AyHHTJRvlhfWDgM5ekF5YKfZnqueh5XfGH5PJa
         ZCfENr6m9IbYTikp3ZdrjES5UqOY5GvMLbMSyJeaV1WXvwh4d8gRK6t0U9pT1Kj+16qq
         U6EiudNl4KVQASvJD+b6tqB0JsoNH9T4T4pdqAy7xro08pat7ewUV66bTmMEu5/cAU1O
         KQaiTed9h6gNqmG3wTQ9yF27im3e0g38rrSX7DDqOyP5tWcacDngM5OZDl/Fi340AdNE
         fqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=kde6RKqnAPzPw3YUEEsHxdtQh/py9mEAbvaRrHMWSA4=;
        b=YzDCyzA4nTwzlvrAAmIdG3ZClgsznz1+7PurJvUvKuNaN7L9oc/MMpppIIe7XI7PRC
         iLyf0/WBHc+flqkda5d1sbfT+iAHz2DiCUqN0VKDXqaio/CaC4ZDt1SlyNByOASSwc18
         wT6uL+kffAS8vUpOLcWawQ6yg8WVq9RXfCgZYX4WSGEItcBh3bpPa9MzhR78/4efHRMK
         6TdIEfXC30DwhT0z5mrMnuX5ojTo82j/9d27h6gjuSi+aZSlWmFNCl0Yt34VBdLT7Sgi
         doIJp4yWh4XydhI33tsLKDEe3J9J6csXMDhteDgP2dUBW8QqGUxu+KvNqtcJAcs/cG51
         7LSw==
X-Gm-Message-State: AGi0PuYk2Orl2Enu136BWgIOp5v5ViniiwPcKboiRXizNrmA8xoNo4Hm
        s2FqqaNBibVyspNwX0NQqCM=
X-Google-Smtp-Source: APiQypLz0a6PW/0Wj0gSoUo0v1PPRVdBUhBxQJYT7X3psFAd/72JKRJhP6T94r9dKkccrV/QUdYXLQ==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr13950990wrx.239.1586941409858;
        Wed, 15 Apr 2020 02:03:29 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j13sm23500182wro.51.2020.04.15.02.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:03:29 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:03:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fixes
Message-ID: <20200415090327.GA35892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-04-15

   # HEAD: a088b858f16af85e3db359b6c6aaa92dd3bc0921 efi/x86: Revert struct layout change to fix kexec boot regression

Misc EFI fixes, including the boot failure regression caused by the BSS 
section not being cleared.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (5):
      efi/arm: Deal with ADR going out of range in efi_enter_kernel()
      Documentation/x86, efi/x86: Clarify EFI handover protocol and its requirements
      efi/libstub/file: Merge file name buffers to reduce stack usage
      efi/x86: Don't remap text<->rodata gap read-only for mixed mode
      efi/x86: Revert struct layout change to fix kexec boot regression

Arvind Sankar (2):
      efi/x86: Move efi stub globals from .bss to .data
      efi/x86: Always relocate the kernel for EFI handover entry

Colin Ian King (1):
      efi/libstub/x86: Remove redundant assignment to pointer hdr

Gary Lin (1):
      efi/x86: Fix the deletion of variables in mixed mode

Takashi Iwai (1):
      efi/cper: Use scnprintf() for avoiding potential buffer overflow


 Documentation/x86/boot.rst              | 21 ++++++++++++++++++---
 arch/arm/boot/compressed/head.S         |  3 ++-
 arch/x86/include/asm/efi.h              |  2 ++
 arch/x86/platform/efi/efi_64.c          | 16 ++++++++++++----
 drivers/firmware/efi/cper.c             |  2 +-
 drivers/firmware/efi/libstub/efistub.h  |  2 +-
 drivers/firmware/efi/libstub/file.c     | 27 ++++++++++++++-------------
 drivers/firmware/efi/libstub/x86-stub.c | 18 +++++++++++-------
 8 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index fa7ddc0428c8..5325c71ca877 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1399,8 +1399,8 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
 must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
 address of the struct boot_params.
 
-EFI Handover Protocol
-=====================
+EFI Handover Protocol (deprecated)
+==================================
 
 This protocol allows boot loaders to defer initialisation to the EFI
 boot stub. The boot loader is required to load the kernel/initrd(s)
@@ -1408,6 +1408,12 @@ from the boot media and jump to the EFI handover protocol entry point
 which is hdr->handover_offset bytes from the beginning of
 startup_{32,64}.
 
+The boot loader MUST respect the kernel's PE/COFF metadata when it comes
+to section alignment, the memory footprint of the executable image beyond
+the size of the file itself, and any other aspect of the PE/COFF header
+that may affect correct operation of the image as a PE/COFF binary in the
+execution context provided by the EFI firmware.
+
 The function prototype for the handover entry point looks like this::
 
     efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
@@ -1419,9 +1425,18 @@ UEFI specification. 'bp' is the boot loader-allocated boot params.
 
 The boot loader *must* fill out the following fields in bp::
 
-  - hdr.code32_start
   - hdr.cmd_line_ptr
   - hdr.ramdisk_image (if applicable)
   - hdr.ramdisk_size  (if applicable)
 
 All other fields should be zero.
+
+NOTE: The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+      entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
+      loading protocol (refer to [0] for an example of the bootloader side of
+      this), which removes the need for any knowledge on the part of the EFI
+      bootloader regarding the internal representation of boot_params or any
+      requirements/limitations regarding the placement of the command line
+      and ramdisk in memory, or the placement of the kernel image itself.
+
+[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index cabdd8f4a248..e8e1c866e413 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1450,7 +1450,8 @@ ENTRY(efi_enter_kernel)
 		@ running beyond the PoU, and so calling cache_off below from
 		@ inside the PE/COFF loader allocated region is unsafe unless
 		@ we explicitly clean it to the PoC.
-		adr	r0, call_cache_fn		@ region of code we will
+ ARM(		adrl	r0, call_cache_fn	)
+ THUMB(		adr	r0, call_cache_fn	)	@ region of code we will
 		adr	r1, 0f				@ run with MMU off
 		bl	cache_clean_flush
 		bl	cache_off
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cdcf48d52a12..8391c115c0ec 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -178,8 +178,10 @@ extern void efi_free_boot_services(void);
 extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
 extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
 
+/* kexec external ABI */
 struct efi_setup_data {
 	u64 fw_vendor;
+	u64 __unused;
 	u64 tables;
 	u64 smbios;
 	u64 reserved[8];
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 211bb9358b73..c5e393f8bb3f 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -202,7 +202,7 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
 
 int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 {
-	unsigned long pfn, text, pf;
+	unsigned long pfn, text, pf, rodata;
 	struct page *page;
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
@@ -256,7 +256,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 
 	efi_scratch.phys_stack = page_to_phys(page + 1); /* stack grows down */
 
-	npages = (__end_rodata_aligned - _text) >> PAGE_SHIFT;
+	npages = (_etext - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
 	pfn = text >> PAGE_SHIFT;
 
@@ -266,6 +266,14 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 		return 1;
 	}
 
+	npages = (__end_rodata - __start_rodata) >> PAGE_SHIFT;
+	rodata = __pa(__start_rodata);
+	pfn = rodata >> PAGE_SHIFT;
+	if (kernel_map_pages_in_pgd(pgd, pfn, rodata, npages, pf)) {
+		pr_err("Failed to map kernel rodata 1:1\n");
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -638,7 +646,7 @@ efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,
@@ -669,7 +677,7 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b1af0de2e100..9d2512913d25 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -101,7 +101,7 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		if (!len)
 			len = snprintf(buf, sizeof(buf), "%s%s", pfx, str);
 		else
-			len += snprintf(buf+len, sizeof(buf)-len, ", %s", str);
+			len += scnprintf(buf+len, sizeof(buf)-len, ", %s", str);
 	}
 	if (len)
 		printk("%s\n", buf);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cc90a748bcf0..67d26949fd26 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,7 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_X86)
 #define __efistub_global	__section(.data)
 #else
 #define __efistub_global
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index d4c7e5f59d2c..ea66b1f16a79 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -29,30 +29,31 @@
  */
 #define EFI_READ_CHUNK_SIZE	SZ_1M
 
+struct finfo {
+	efi_file_info_t info;
+	efi_char16_t	filename[MAX_FILENAME_SIZE];
+};
+
 static efi_status_t efi_open_file(efi_file_protocol_t *volume,
-				  efi_char16_t *filename_16,
+				  struct finfo *fi,
 				  efi_file_protocol_t **handle,
 				  unsigned long *file_size)
 {
-	struct {
-		efi_file_info_t info;
-		efi_char16_t	filename[MAX_FILENAME_SIZE];
-	} finfo;
 	efi_guid_t info_guid = EFI_FILE_INFO_ID;
 	efi_file_protocol_t *fh;
 	unsigned long info_sz;
 	efi_status_t status;
 
-	status = volume->open(volume, &fh, filename_16, EFI_FILE_MODE_READ, 0);
+	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to open file: ");
-		efi_char16_printk(filename_16);
+		efi_char16_printk(fi->filename);
 		efi_printk("\n");
 		return status;
 	}
 
-	info_sz = sizeof(finfo);
-	status = fh->get_info(fh, &info_guid, &info_sz, &finfo);
+	info_sz = sizeof(struct finfo);
+	status = fh->get_info(fh, &info_guid, &info_sz, fi);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to get file info\n");
 		fh->close(fh);
@@ -60,7 +61,7 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 	}
 
 	*handle = fh;
-	*file_size = finfo.info.file_size;
+	*file_size = fi->info.file_size;
 	return EFI_SUCCESS;
 }
 
@@ -146,13 +147,13 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 
 	alloc_addr = alloc_size = 0;
 	do {
-		efi_char16_t filename[MAX_FILENAME_SIZE];
+		struct finfo fi;
 		unsigned long size;
 		void *addr;
 
 		offset = find_file_option(cmdline, cmdline_len,
 					  optstr, optstr_size,
-					  filename, ARRAY_SIZE(filename));
+					  fi.filename, ARRAY_SIZE(fi.filename));
 
 		if (!offset)
 			break;
@@ -166,7 +167,7 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				return status;
 		}
 
-		status = efi_open_file(volume, filename, &file, &size);
+		status = efi_open_file(volume, &fi, &file, &size);
 		if (status != EFI_SUCCESS)
 			goto err_close_volume;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8d3a707789de..05ccb229fb45 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -20,7 +20,7 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-static efi_system_table_t *sys_table;
+static efi_system_table_t *sys_table __efistub_global;
 extern const bool efi_is64;
 extern u32 image_offset;
 
@@ -392,8 +392,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_base = efi_table_attr(image, image_base);
 	image_offset = (void *)startup_32 - image_base;
 
-	hdr = &((struct boot_params *)image_base)->hdr;
-
 	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
@@ -742,8 +740,15 @@ unsigned long efi_main(efi_handle_t handle,
 	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
 	 * KASLR uses.
 	 *
-	 * Also relocate it if image_offset is zero, i.e. we weren't loaded by
-	 * LoadImage, but we are not aligned correctly.
+	 * Also relocate it if image_offset is zero, i.e. the kernel wasn't
+	 * loaded by LoadImage, but rather by a bootloader that called the
+	 * handover entry. The reason we must always relocate in this case is
+	 * to handle the case of systemd-boot booting a unified kernel image,
+	 * which is a PE executable that contains the bzImage and an initrd as
+	 * COFF sections. The initrd section is placed after the bzImage
+	 * without ensuring that there are at least init_size bytes available
+	 * for the bzImage, and thus the compressed kernel's startup code may
+	 * overwrite the initrd unless it is moved out of the way.
 	 */
 
 	buffer_start = ALIGN(bzimage_addr - image_offset,
@@ -753,8 +758,7 @@ unsigned long efi_main(efi_handle_t handle,
 	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
 	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
 	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
-	    (image_offset == 0 && !IS_ALIGNED(bzimage_addr,
-					      hdr->kernel_alignment))) {
+	    (image_offset == 0)) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
