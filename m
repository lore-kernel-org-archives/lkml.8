Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA446C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8637E24677
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgAJR7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59293 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgAJR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZB-0002A7-5R; Fri, 10 Jan 2020 18:59:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C13951C2D6B;
        Fri, 10 Jan 2020 18:59:19 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:19 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Standardize on memtype_*() prefix for APIs
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867915965.30329.4837113727046976633.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ecdd6ee77b73d11fcf2ca6739e4d1fe590446599
Gitweb:        https://git.kernel.org/tip/ecdd6ee77b73d11fcf2ca6739e4d1fe590446599
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 15:30:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Standardize on memtype_*() prefix for APIs

Half of our memtype APIs are memtype_ prefixed, the other half are _memtype suffixed:

	reserve_memtype()
	free_memtype()
	kernel_map_sync_memtype()
	io_reserve_memtype()
	io_free_memtype()

	memtype_check_insert()
	memtype_erase()
	memtype_lookup()
	memtype_copy_nth_element()

Use prefixes consistently, like most other modern kernel APIs:

	reserve_memtype()		=> memtype_reserve()
	free_memtype()			=> memtype_free()
	kernel_map_sync_memtype()	=> memtype_kernel_map_sync()
	io_reserve_memtype()		=> memtype_reserve_io()
	io_free_memtype()		=> memtype_free_io()

	memtype_check_insert()		=> memtype_check_insert()
	memtype_erase()			=> memtype_erase()
	memtype_lookup()		=> memtype_lookup()
	memtype_copy_nth_element()	=> memtype_copy_nth_element()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pat.h   | 10 ++++----
 arch/x86/mm/iomap_32.c       |  4 +--
 arch/x86/mm/ioremap.c        | 10 ++++----
 arch/x86/mm/pat/memtype.c    | 44 +++++++++++++++++------------------
 arch/x86/mm/pat/set_memory.c | 16 ++++++-------
 5 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/pat.h b/arch/x86/include/asm/pat.h
index 92015c6..4a9a97d 100644
--- a/arch/x86/include/asm/pat.h
+++ b/arch/x86/include/asm/pat.h
@@ -10,17 +10,17 @@ void pat_disable(const char *reason);
 extern void pat_init(void);
 extern void init_cache_modes(void);
 
-extern int reserve_memtype(u64 start, u64 end,
+extern int memtype_reserve(u64 start, u64 end,
 		enum page_cache_mode req_pcm, enum page_cache_mode *ret_pcm);
-extern int free_memtype(u64 start, u64 end);
+extern int memtype_free(u64 start, u64 end);
 
-extern int kernel_map_sync_memtype(u64 base, unsigned long size,
+extern int memtype_kernel_map_sync(u64 base, unsigned long size,
 		enum page_cache_mode pcm);
 
-int io_reserve_memtype(resource_size_t start, resource_size_t end,
+int memtype_reserve_io(resource_size_t start, resource_size_t end,
 			enum page_cache_mode *pcm);
 
-void io_free_memtype(resource_size_t start, resource_size_t end);
+void memtype_free_io(resource_size_t start, resource_size_t end);
 
 bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
 
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index 6748b4c..4a0762e 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -26,7 +26,7 @@ int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot)
 	if (!is_io_mapping_possible(base, size))
 		return -EINVAL;
 
-	ret = io_reserve_memtype(base, base + size, &pcm);
+	ret = memtype_reserve_io(base, base + size, &pcm);
 	if (ret)
 		return ret;
 
@@ -40,7 +40,7 @@ EXPORT_SYMBOL_GPL(iomap_create_wc);
 
 void iomap_free(resource_size_t base, unsigned long size)
 {
-	io_free_memtype(base, base + size);
+	memtype_free_io(base, base + size);
 }
 EXPORT_SYMBOL_GPL(iomap_free);
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index b3a2936..e49de6c 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -196,10 +196,10 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	phys_addr &= PHYSICAL_PAGE_MASK;
 	size = PAGE_ALIGN(last_addr+1) - phys_addr;
 
-	retval = reserve_memtype(phys_addr, (u64)phys_addr + size,
+	retval = memtype_reserve(phys_addr, (u64)phys_addr + size,
 						pcm, &new_pcm);
 	if (retval) {
-		printk(KERN_ERR "ioremap reserve_memtype failed %d\n", retval);
+		printk(KERN_ERR "ioremap memtype_reserve failed %d\n", retval);
 		return NULL;
 	}
 
@@ -255,7 +255,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	area->phys_addr = phys_addr;
 	vaddr = (unsigned long) area->addr;
 
-	if (kernel_map_sync_memtype(phys_addr, size, pcm))
+	if (memtype_kernel_map_sync(phys_addr, size, pcm))
 		goto err_free_area;
 
 	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot))
@@ -275,7 +275,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 err_free_area:
 	free_vm_area(area);
 err_free_memtype:
-	free_memtype(phys_addr, phys_addr + size);
+	memtype_free(phys_addr, phys_addr + size);
 	return NULL;
 }
 
@@ -451,7 +451,7 @@ void iounmap(volatile void __iomem *addr)
 		return;
 	}
 
-	free_memtype(p->phys_addr, p->phys_addr + get_vm_area_size(p));
+	memtype_free(p->phys_addr, p->phys_addr + get_vm_area_size(p));
 
 	/* Finally remove it */
 	o = remove_vm_area((void __force *)addr);
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 76532f0..7ed3735 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -575,7 +575,7 @@ static u64 sanitize_phys(u64 address)
  * available type in new_type in case of no error. In case of any error
  * it will return a negative return value.
  */
-int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
+int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
 		    enum page_cache_mode *new_type)
 {
 	struct memtype *entry_new;
@@ -638,7 +638,7 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 	err = memtype_check_insert(entry_new, new_type);
 	if (err) {
-		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
+		pr_info("x86/PAT: memtype_reserve failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
 			start, end - 1,
 			cattr_name(entry_new->type), cattr_name(req_type));
 		kfree(entry_new);
@@ -649,14 +649,14 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 	spin_unlock(&memtype_lock);
 
-	dprintk("reserve_memtype added [mem %#010Lx-%#010Lx], track %s, req %s, ret %s\n",
+	dprintk("memtype_reserve added [mem %#010Lx-%#010Lx], track %s, req %s, ret %s\n",
 		start, end - 1, cattr_name(entry_new->type), cattr_name(req_type),
 		new_type ? cattr_name(*new_type) : "-");
 
 	return err;
 }
 
-int free_memtype(u64 start, u64 end)
+int memtype_free(u64 start, u64 end)
 {
 	int is_range_ram;
 	struct memtype *entry_old;
@@ -689,7 +689,7 @@ int free_memtype(u64 start, u64 end)
 
 	kfree(entry_old);
 
-	dprintk("free_memtype request [mem %#010Lx-%#010Lx]\n", start, end - 1);
+	dprintk("memtype_free request [mem %#010Lx-%#010Lx]\n", start, end - 1);
 
 	return 0;
 }
@@ -752,7 +752,7 @@ bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
 EXPORT_SYMBOL_GPL(pat_pfn_immune_to_uc_mtrr);
 
 /**
- * io_reserve_memtype - Request a memory type mapping for a region of memory
+ * memtype_reserve_io - Request a memory type mapping for a region of memory
  * @start: start (physical address) of the region
  * @end: end (physical address) of the region
  * @type: A pointer to memtype, with requested type. On success, requested
@@ -761,7 +761,7 @@ EXPORT_SYMBOL_GPL(pat_pfn_immune_to_uc_mtrr);
  * On success, returns 0
  * On failure, returns non-zero
  */
-int io_reserve_memtype(resource_size_t start, resource_size_t end,
+int memtype_reserve_io(resource_size_t start, resource_size_t end,
 			enum page_cache_mode *type)
 {
 	resource_size_t size = end - start;
@@ -771,47 +771,47 @@ int io_reserve_memtype(resource_size_t start, resource_size_t end,
 
 	WARN_ON_ONCE(iomem_map_sanity_check(start, size));
 
-	ret = reserve_memtype(start, end, req_type, &new_type);
+	ret = memtype_reserve(start, end, req_type, &new_type);
 	if (ret)
 		goto out_err;
 
 	if (!is_new_memtype_allowed(start, size, req_type, new_type))
 		goto out_free;
 
-	if (kernel_map_sync_memtype(start, size, new_type) < 0)
+	if (memtype_kernel_map_sync(start, size, new_type) < 0)
 		goto out_free;
 
 	*type = new_type;
 	return 0;
 
 out_free:
-	free_memtype(start, end);
+	memtype_free(start, end);
 	ret = -EBUSY;
 out_err:
 	return ret;
 }
 
 /**
- * io_free_memtype - Release a memory type mapping for a region of memory
+ * memtype_free_io - Release a memory type mapping for a region of memory
  * @start: start (physical address) of the region
  * @end: end (physical address) of the region
  */
-void io_free_memtype(resource_size_t start, resource_size_t end)
+void memtype_free_io(resource_size_t start, resource_size_t end)
 {
-	free_memtype(start, end);
+	memtype_free(start, end);
 }
 
 int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
 {
 	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
 
-	return io_reserve_memtype(start, start + size, &type);
+	return memtype_reserve_io(start, start + size, &type);
 }
 EXPORT_SYMBOL(arch_io_reserve_memtype_wc);
 
 void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
 {
-	io_free_memtype(start, start + size);
+	memtype_free_io(start, start + size);
 }
 EXPORT_SYMBOL(arch_io_free_memtype_wc);
 
@@ -871,7 +871,7 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
  * Change the memory type for the physical address range in kernel identity
  * mapping space if that range is a part of identity map.
  */
-int kernel_map_sync_memtype(u64 base, unsigned long size,
+int memtype_kernel_map_sync(u64 base, unsigned long size,
 			    enum page_cache_mode pcm)
 {
 	unsigned long id_sz;
@@ -901,7 +901,7 @@ int kernel_map_sync_memtype(u64 base, unsigned long size,
 
 /*
  * Internal interface to reserve a range of physical memory with prot.
- * Reserved non RAM regions only and after successful reserve_memtype,
+ * Reserved non RAM regions only and after successful memtype_reserve,
  * this func also keeps identity mapping (if any) in sync with this new prot.
  */
 static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
@@ -938,14 +938,14 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
 		return 0;
 	}
 
-	ret = reserve_memtype(paddr, paddr + size, want_pcm, &pcm);
+	ret = memtype_reserve(paddr, paddr + size, want_pcm, &pcm);
 	if (ret)
 		return ret;
 
 	if (pcm != want_pcm) {
 		if (strict_prot ||
 		    !is_new_memtype_allowed(paddr, size, want_pcm, pcm)) {
-			free_memtype(paddr, paddr + size);
+			memtype_free(paddr, paddr + size);
 			pr_err("x86/PAT: %s:%d map pfn expected mapping type %s for [mem %#010Lx-%#010Lx], got %s\n",
 			       current->comm, current->pid,
 			       cattr_name(want_pcm),
@@ -963,8 +963,8 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
 				     cachemode2protval(pcm));
 	}
 
-	if (kernel_map_sync_memtype(paddr, size, pcm) < 0) {
-		free_memtype(paddr, paddr + size);
+	if (memtype_kernel_map_sync(paddr, size, pcm) < 0) {
+		memtype_free(paddr, paddr + size);
 		return -EINVAL;
 	}
 	return 0;
@@ -980,7 +980,7 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 
 	is_ram = pat_pagerange_is_ram(paddr, paddr + size);
 	if (is_ram == 0)
-		free_memtype(paddr, paddr + size);
+		memtype_free(paddr, paddr + size);
 }
 
 /*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8fbefee..3e5e98b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1801,7 +1801,7 @@ int set_memory_uc(unsigned long addr, int numpages)
 	/*
 	 * for now UC MINUS. see comments in ioremap()
 	 */
-	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
+	ret = memtype_reserve(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
 			      _PAGE_CACHE_MODE_UC_MINUS, NULL);
 	if (ret)
 		goto out_err;
@@ -1813,7 +1813,7 @@ int set_memory_uc(unsigned long addr, int numpages)
 	return 0;
 
 out_free:
-	free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
+	memtype_free(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
 out_err:
 	return ret;
 }
@@ -1839,14 +1839,14 @@ int set_memory_wc(unsigned long addr, int numpages)
 {
 	int ret;
 
-	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
+	ret = memtype_reserve(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
 		_PAGE_CACHE_MODE_WC, NULL);
 	if (ret)
 		return ret;
 
 	ret = _set_memory_wc(addr, numpages);
 	if (ret)
-		free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
+		memtype_free(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
 
 	return ret;
 }
@@ -1873,7 +1873,7 @@ int set_memory_wb(unsigned long addr, int numpages)
 	if (ret)
 		return ret;
 
-	free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
+	memtype_free(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
 	return 0;
 }
 EXPORT_SYMBOL(set_memory_wb);
@@ -2014,7 +2014,7 @@ static int _set_pages_array(struct page **pages, int numpages,
 			continue;
 		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
 		end = start + PAGE_SIZE;
-		if (reserve_memtype(start, end, new_type, NULL))
+		if (memtype_reserve(start, end, new_type, NULL))
 			goto err_out;
 	}
 
@@ -2040,7 +2040,7 @@ err_out:
 			continue;
 		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
 		end = start + PAGE_SIZE;
-		free_memtype(start, end);
+		memtype_free(start, end);
 	}
 	return -EINVAL;
 }
@@ -2089,7 +2089,7 @@ int set_pages_array_wb(struct page **pages, int numpages)
 			continue;
 		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
 		end = start + PAGE_SIZE;
-		free_memtype(start, end);
+		memtype_free(start, end);
 	}
 
 	return 0;
