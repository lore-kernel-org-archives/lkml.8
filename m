Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C49C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B92067C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580550352;
	bh=FMh94LbQzK+HxdL5yO5WzFN9MTHMpLcaUlJAhD1w+ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CQnXRQwQuq6D3wuwiXkl6uUo2MsSCPcDcnGgK3hVC8u4F9lR+dakDmbF2PSJo6xtu
	 cHJvhGS+OwGajY6gUU57YP22BtHZIhZtYHIpg6d+Tv9WRRe7CJk0KY53Rs3H9GqP42
	 QHfK+YPO7R49ul80Tyqg/11F/SWRZhviUbzXSjUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBAJpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 04:45:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53937 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgBAJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 04:45:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so10628912wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BHOLRHuFHWBUOnscStz5RjS5lpTP4iFp7XCF9MeHbM8=;
        b=dSIvKqHM+kVRiaJsDnLEVgu659sNBZRNMYEUgMRpEjs65zuaaYGCAkVInEs8xEWtys
         94153ksLIOP1a93hddTOV7yfc/9JAoX3k67ai74VoTlLfKgOUACUKcqI+EBscwEijl2+
         SQJJtIF5iWE/w5LOGGDFIE9G1oTX49oQE8q6kUJq9OLn6gczWEJ7m3YXwz0tSLJguilF
         Smyakd+nUdQjSWDyiAQz0nGuod8zaZJeFQApupKopv+ymNBrfYZBJk4lE6QIOWgyvlnJ
         9kGSvRFuCwIiBiWNByz1U1obgSpGDH7UqUc1N0q2xcneNj5q8FI86XQdTR8TTu48/pN0
         k1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BHOLRHuFHWBUOnscStz5RjS5lpTP4iFp7XCF9MeHbM8=;
        b=tjC5illu1WnV5d+QatlJwFac/rFzK7nQZHcvLgJ8xseJbAZUb7McEnHd9ZM+hzkCvY
         cl/vuekllQaqTAqSyuhdV2awqTD47D7liUqm8n4Ai40jY0hPlb4oHdLtNyUtn/UAWn+a
         qg5f2WgUG4AmX1Xxvbk3uHKCZEBy18kG/K5Er7zHnV8oH+dpFwIPomfEJcHzoW6BPVUK
         SH5tLTwd2uuKrbYjhY+HJiMUNHws0++lzOZFUc/wnqkF7Sa4CfvPkq079WsK+TeP+x1X
         JmM/0ZFEAoOMSYKSkJLy3RWS10ixC2LM3P57EJCBdRSngjVP2SKoAFq+InLjbdtw1Mfi
         1I7A==
X-Gm-Message-State: APjAAAVIbugoNcBvGA1x/sEp3xJ4eW2DM+QBfrBaDcQIBlUg9yQ1Derq
        HFD5fLg7pynxpiBdijV/Ye0=
X-Google-Smtp-Source: APXvYqxHI/mw/lscCKHpKchxWJqn/FKy1aGRclGH+63vUP7QuPI7OX2nut8ZfZgmnGvSnzN7g723aA==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr17536719wmm.98.1580550347550;
        Sat, 01 Feb 2020 01:45:47 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s15sm15788201wrp.4.2020.02.01.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 01:45:47 -0800 (PST)
Date:   Sat, 1 Feb 2020 10:45:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: [TEST PATCH RFC] Revert the EFI leak fixes for now (was: Re: EFI
 boot crash regression (was: Re: 5.6-### doesn't boot))
Message-ID: <20200201094545.GC71555@gmail.com>
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com>
 <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200131183658.GA71555@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Jörg Otte wrote:

> It's bisected.
> The first bad commit is :
> 1db91035d01aa8bfa2350c00ccb63d629b4041ad
> efi: Add tracking for dynamically allocated memmaps

> Unfortunately I can not revert because of compile errors!
>
> In file included from /media/jojo/deftoshiba/kernel/linux/init/main.c:48:
> /media/jojo/deftoshiba/kernel/linux/include/linux/efi.h:975:1: error:
> version control conflict marker in file
> <<<<<<< HEAD

So 1db91035d0 doesn't revert cleanly, because 484a418d0754 depends on it, 
plus there a third commit (f0ef6523475f) that has a semantic dependency 
on 1db91035d01a.

But you can revert them all, if done in reverse chronological order:

  git revert f0ef6523475f # ("efi: Fix efi_memmap_alloc() leaks")
  git revert 484a418d0754 # ("efi: Fix handling of multiple efi_fake_mem= entries")
  git revert 1db91035d01a # ("efi: Add tracking for dynamically allocated memmaps")

You can paste those three lines into a shell as-is, or you can apply the 
patch below which is a combination of these three reverts.

Jörg, can you confirm that doing these reverts fixes booting on your 
system? If it does then a full dmesg from that kernel would be useful.

FWIW I reviewed the bisected commit and didn't find the bug but I also 
couldn't convince myself it's a 1:1 identity transformation and cleanup 
of the existing logic.

The size arithmethics transformation looks correct at first sight, but 
the data->flags handling in particular looks rather interwoven.

Thanks,

	Ingo

============================>

 arch/x86/platform/efi/efi.c     | 10 ++----
 arch/x86/platform/efi/quirks.c  | 23 +++++++------
 drivers/firmware/efi/fake_mem.c | 43 ++++++++++++------------
 drivers/firmware/efi/memmap.c   | 72 ++++++++++++-----------------------------
 include/linux/efi.h             | 13 +++-----
 5 files changed, 63 insertions(+), 98 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 59f7f6d60cf6..4e46d2d24352 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -304,16 +304,10 @@ static void __init efi_clean_memmap(void)
 	}
 
 	if (n_removal > 0) {
-		struct efi_memory_map_data data = {
-			.phys_map = efi.memmap.phys_map,
-			.desc_version = efi.memmap.desc_version,
-			.desc_size = efi.memmap.desc_size,
-			.size = data.desc_size * (efi.memmap.nr_map - n_removal),
-			.flags = 0,
-		};
+		u64 size = efi.memmap.nr_map - n_removal;
 
 		pr_warn("Removing %d invalid memory map entries.\n", n_removal);
-		efi_memmap_install(&data);
+		efi_memmap_install(efi.memmap.phys_map, size);
 	}
 }
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 88d32c06cffa..86b44289ac55 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -244,7 +244,7 @@ EXPORT_SYMBOL_GPL(efi_query_variable_store);
  */
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 {
-	struct efi_memory_map_data data = { 0 };
+	phys_addr_t new_phys, new_size;
 	struct efi_mem_range mr;
 	efi_memory_desc_t md;
 	int num_entries;
@@ -272,21 +272,24 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	num_entries = efi_memmap_split_count(&md, &mr.range);
 	num_entries += efi.memmap.nr_map;
 
-	if (efi_memmap_alloc(num_entries, &data) != 0) {
+	new_size = efi.memmap.desc_size * num_entries;
+
+	new_phys = efi_memmap_alloc(num_entries);
+	if (!new_phys) {
 		pr_err("Could not allocate boot services memmap\n");
 		return;
 	}
 
-	new = early_memremap(data.phys_map, data.size);
+	new = early_memremap(new_phys, new_size);
 	if (!new) {
 		pr_err("Failed to map new boot services memmap\n");
 		return;
 	}
 
 	efi_memmap_insert(&efi.memmap, new, &mr);
-	early_memunmap(new, data.size);
+	early_memunmap(new, new_size);
 
-	efi_memmap_install(&data);
+	efi_memmap_install(new_phys, num_entries);
 	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
 	e820__update_table(e820_table);
 }
@@ -405,7 +408,7 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 
 void __init efi_free_boot_services(void)
 {
-	struct efi_memory_map_data data = { 0 };
+	phys_addr_t new_phys, new_size;
 	efi_memory_desc_t *md;
 	int num_entries = 0;
 	void *new, *new_md;
@@ -460,12 +463,14 @@ void __init efi_free_boot_services(void)
 	if (!num_entries)
 		return;
 
-	if (efi_memmap_alloc(num_entries, &data) != 0) {
+	new_size = efi.memmap.desc_size * num_entries;
+	new_phys = efi_memmap_alloc(num_entries);
+	if (!new_phys) {
 		pr_err("Failed to allocate new EFI memmap\n");
 		return;
 	}
 
-	new = memremap(data.phys_map, data.size, MEMREMAP_WB);
+	new = memremap(new_phys, new_size, MEMREMAP_WB);
 	if (!new) {
 		pr_err("Failed to map new EFI memmap\n");
 		return;
@@ -489,7 +494,7 @@ void __init efi_free_boot_services(void)
 
 	memunmap(new);
 
-	if (efi_memmap_install(&data) != 0) {
+	if (efi_memmap_install(new_phys, num_entries)) {
 		pr_err("Could not install new EFI memmap\n");
 		return;
 	}
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 6e0f34a38171..bb9fc70d0cfa 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -34,45 +34,46 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
 	return 0;
 }
 
-static void __init efi_fake_range(struct efi_mem_range *efi_range)
+void __init efi_fake_memmap(void)
 {
-	struct efi_memory_map_data data = { 0 };
 	int new_nr_map = efi.memmap.nr_map;
 	efi_memory_desc_t *md;
+	phys_addr_t new_memmap_phy;
 	void *new_memmap;
+	int i;
+
+	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
+		return;
 
 	/* count up the number of EFI memory descriptor */
-	for_each_efi_memory_desc(md)
-		new_nr_map += efi_memmap_split_count(md, &efi_range->range);
+	for (i = 0; i < nr_fake_mem; i++) {
+		for_each_efi_memory_desc(md) {
+			struct range *r = &efi_fake_mems[i].range;
+
+			new_nr_map += efi_memmap_split_count(md, r);
+		}
+	}
 
 	/* allocate memory for new EFI memmap */
-	if (efi_memmap_alloc(new_nr_map, &data) != 0)
+	new_memmap_phy = efi_memmap_alloc(new_nr_map);
+	if (!new_memmap_phy)
 		return;
 
 	/* create new EFI memmap */
-	new_memmap = early_memremap(data.phys_map, data.size);
+	new_memmap = early_memremap(new_memmap_phy,
+				    efi.memmap.desc_size * new_nr_map);
 	if (!new_memmap) {
-		__efi_memmap_free(data.phys_map, data.size, data.flags);
+		memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
 		return;
 	}
 
-	efi_memmap_insert(&efi.memmap, new_memmap, efi_range);
+	for (i = 0; i < nr_fake_mem; i++)
+		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
 
 	/* swap into new EFI memmap */
-	early_memunmap(new_memmap, data.size);
-
-	efi_memmap_install(&data);
-}
-
-void __init efi_fake_memmap(void)
-{
-	int i;
+	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
 
-	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
-		return;
-
-	for (i = 0; i < nr_fake_mem; i++)
-		efi_fake_range(&efi_fake_mems[i]);
+	efi_memmap_install(new_memmap_phy, new_nr_map);
 
 	/* print new EFI memmap */
 	efi_print_memmap();
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2ff1883dc788..4f98eb12c172 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -29,32 +29,9 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }
 
-void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
-{
-	if (flags & EFI_MEMMAP_MEMBLOCK) {
-		if (slab_is_available())
-			memblock_free_late(phys, size);
-		else
-			memblock_free(phys, size);
-	} else if (flags & EFI_MEMMAP_SLAB) {
-		struct page *p = pfn_to_page(PHYS_PFN(phys));
-		unsigned int order = get_order(size);
-
-		free_pages((unsigned long) page_address(p), order);
-	}
-}
-
-static void __init efi_memmap_free(void)
-{
-	__efi_memmap_free(efi.memmap.phys_map,
-			efi.memmap.desc_size * efi.memmap.nr_map,
-			efi.memmap.flags);
-}
-
 /**
  * efi_memmap_alloc - Allocate memory for the EFI memory map
  * @num_entries: Number of entries in the allocated map.
- * @data: efi memmap installation parameters
  *
  * Depending on whether mm_init() has already been invoked or not,
  * either memblock or "normal" page allocation is used.
@@ -62,29 +39,14 @@ static void __init efi_memmap_free(void)
  * Returns the physical address of the allocated memory map on
  * success, zero on failure.
  */
-int __init efi_memmap_alloc(unsigned int num_entries,
-		struct efi_memory_map_data *data)
+phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
 {
-	/* Expect allocation parameters are zero initialized */
-	WARN_ON(data->phys_map || data->size);
-
-	data->size = num_entries * efi.memmap.desc_size;
-	data->desc_version = efi.memmap.desc_version;
-	data->desc_size = efi.memmap.desc_size;
-	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
-	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
-
-	if (slab_is_available()) {
-		data->flags |= EFI_MEMMAP_SLAB;
-		data->phys_map = __efi_memmap_alloc_late(data->size);
-	} else {
-		data->flags |= EFI_MEMMAP_MEMBLOCK;
-		data->phys_map = __efi_memmap_alloc_early(data->size);
-	}
+	unsigned long size = num_entries * efi.memmap.desc_size;
 
-	if (!data->phys_map)
-		return -ENOMEM;
-	return 0;
+	if (slab_is_available())
+		return __efi_memmap_alloc_late(size);
+
+	return __efi_memmap_alloc_early(size);
 }
 
 /**
@@ -102,7 +64,8 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init __efi_memmap_init(struct efi_memory_map_data *data)
+static int __init
+__efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
@@ -122,9 +85,6 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
-	/* NOP if data->flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB) == 0 */
-	efi_memmap_free();
-
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
@@ -224,7 +184,8 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 
 /**
  * efi_memmap_install - Install a new EFI memory map in efi.memmap
- * @ctx: map allocation parameters (address, size, flags)
+ * @addr: Physical address of the memory map
+ * @nr_map: Number of entries in the memory map
  *
  * Unlike efi_memmap_init_*(), this function does not allow the caller
  * to switch from early to late mappings. It simply uses the existing
@@ -232,11 +193,20 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
  *
  * Returns zero on success, a negative error code on failure.
  */
-int __init efi_memmap_install(struct efi_memory_map_data *data)
+int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
 {
+	struct efi_memory_map_data data;
+	unsigned long flags;
+
 	efi_memmap_unmap();
 
-	return __efi_memmap_init(data);
+	data.phys_map = addr;
+	data.size = efi.memmap.desc_size * nr_map;
+	data.desc_version = efi.memmap.desc_version;
+	data.desc_size = efi.memmap.desc_size;
+	data.flags = efi.memmap.flags & EFI_MEMMAP_LATE;
+
+	return __efi_memmap_init(&data);
 }
 
 /**
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd7072cca5..f117d68c314e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -759,8 +759,8 @@ typedef union {
 
 /*
  * Architecture independent structure for describing a memory map for the
- * benefit of efi_memmap_init_early(), and for passing context between
- * efi_memmap_alloc() and efi_memmap_install().
+ * benefit of efi_memmap_init_early(), saving us the need to pass four
+ * parameters.
  */
 struct efi_memory_map_data {
 	phys_addr_t phys_map;
@@ -778,8 +778,6 @@ struct efi_memory_map {
 	unsigned long desc_version;
 	unsigned long desc_size;
 #define EFI_MEMMAP_LATE (1UL << 0)
-#define EFI_MEMMAP_MEMBLOCK (1UL << 1)
-#define EFI_MEMMAP_SLAB (1UL << 2)
 	unsigned long flags;
 };
 
@@ -974,14 +972,11 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
-extern int __init efi_memmap_alloc(unsigned int num_entries,
-				   struct efi_memory_map_data *data);
-extern void __efi_memmap_free(u64 phys, unsigned long size,
-			      unsigned long flags);
+extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-extern int __init efi_memmap_install(struct efi_memory_map_data *data);
+extern int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 					 struct range *range);
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
