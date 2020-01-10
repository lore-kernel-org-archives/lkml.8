Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21999C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE44124677
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAJR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgAJR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZB-0002Bl-2L; Fri, 10 Jan 2020 18:59:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8210F1C2D70;
        Fri, 10 Jan 2020 18:59:21 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:21 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Update the comments in pat.c and
 pat_interval.c and refresh the code a bit
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867916138.30329.7054053731188690598.tip-bot2@tip-bot2>
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

Commit-ID:     aee7f91369a80d2cb9bba198331479cc9bfc0ade
Gitweb:        https://git.kernel.org/tip/aee7f91369a80d2cb9bba198331479cc9bfc0ade
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 10 Dec 2019 10:05:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Update the comments in pat.c and pat_interval.c and refresh the code a bit

Tidy up the code:

 - add comments explaining the PAT code, the role of the functions and the logic

 - fix various typos and grammar while at it

 - simplify the file-scope memtype_interval_*() namespace to interval_*()

 - simplify stylistic complications such as unnecessary linebreaks
   or convoluted control flow

 - use the simpler '#ifdef CONFIG_*' pattern instead of '#if defined(CONFIG_*)' pattern

 - remove the non-idiomatic newline between late_initcall() and its function definition

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c          | 53 +++++++++++++++++++++++++++---------
 arch/x86/mm/pat_interval.c | 54 +++++++++++++++++++++----------------
 2 files changed, 72 insertions(+), 35 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index 2d758e1..560ac51 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -1,11 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Handle caching attributes in page tables (PAT)
+ * Page Attribute Table (PAT) support: handle memory caching attributes in page tables.
  *
  * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
  *          Suresh B Siddha <suresh.b.siddha@intel.com>
  *
  * Loosely based on earlier PAT patchset from Eric Biederman and Andi Kleen.
+ *
+ * Basic principles:
+ *
+ * PAT is a CPU feature supported by all modern x86 CPUs, to allow the firmware and
+ * the kernel to set one of a handful of 'caching type' attributes for physical
+ * memory ranges: uncached, write-combining, write-through, write-protected,
+ * and the most commonly used and default attribute: write-back caching.
+ *
+ * PAT support supercedes and augments MTRR support in a compatible fashion: MTRR is
+ * a hardware interface to enumerate a limited number of physical memory ranges
+ * and set their caching attributes explicitly, programmed into the CPU via MSRs.
+ * Even modern CPUs have MTRRs enabled - but these are typically not touched
+ * by the kernel or by user-space (such as the X server), we rely on PAT for any
+ * additional cache attribute logic.
+ *
+ * PAT doesn't work via explicit memory ranges, but uses page table entries to add
+ * cache attribute information to the mapped memory range: there's 3 bits used,
+ * (_PAGE_PWT, _PAGE_PCD, _PAGE_PAT), with the 8 possible values mapped by the
+ * CPU to actual cache attributes via an MSR loaded into the CPU (MSR_IA32_CR_PAT).
+ *
+ * ( There's a metric ton of finer details, such as compatibility with CPU quirks
+ *   that only support 4 types of PAT entries, and interaction with MTRRs, see
+ *   below for details. )
  */
 
 #include <linux/seq_file.h>
@@ -839,7 +862,7 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 }
 
 /*
- * Change the memory type for the physial address range in kernel identity
+ * Change the memory type for the physical address range in kernel identity
  * mapping space if that range is a part of identity map.
  */
 int kernel_map_sync_memtype(u64 base, unsigned long size,
@@ -851,15 +874,14 @@ int kernel_map_sync_memtype(u64 base, unsigned long size,
 		return 0;
 
 	/*
-	 * some areas in the middle of the kernel identity range
-	 * are not mapped, like the PCI space.
+	 * Some areas in the middle of the kernel identity range
+	 * are not mapped, for example the PCI space.
 	 */
 	if (!page_is_ram(base >> PAGE_SHIFT))
 		return 0;
 
 	id_sz = (__pa(high_memory-1) <= base + size) ?
-				__pa(high_memory) - base :
-				size;
+				__pa(high_memory) - base : size;
 
 	if (ioremap_change_attr((unsigned long)__va(base), id_sz, pcm) < 0) {
 		pr_info("x86/PAT: %s:%d ioremap_change_attr failed %s for [mem %#010Lx-%#010Lx]\n",
@@ -1099,6 +1121,10 @@ EXPORT_SYMBOL_GPL(pgprot_writethrough);
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_X86_PAT)
 
+/*
+ * We are allocating a temporary printout-entry to be passed
+ * between seq_start()/next() and seq_show():
+ */
 static struct memtype *memtype_get_idx(loff_t pos)
 {
 	struct memtype *print_entry;
@@ -1112,12 +1138,13 @@ static struct memtype *memtype_get_idx(loff_t pos)
 	ret = memtype_copy_nth_element(print_entry, pos);
 	spin_unlock(&memtype_lock);
 
-	if (!ret) {
-		return print_entry;
-	} else {
+	/* Free it on error: */
+	if (ret) {
 		kfree(print_entry);
 		return NULL;
 	}
+
+	return print_entry;
 }
 
 static void *memtype_seq_start(struct seq_file *seq, loff_t *pos)
@@ -1144,8 +1171,11 @@ static int memtype_seq_show(struct seq_file *seq, void *v)
 {
 	struct memtype *print_entry = (struct memtype *)v;
 
-	seq_printf(seq, "%s @ 0x%Lx-0x%Lx\n", cattr_name(print_entry->type),
-			print_entry->start, print_entry->end);
+	seq_printf(seq, "%s @ 0x%Lx-0x%Lx\n",
+			cattr_name(print_entry->type),
+			print_entry->start,
+			print_entry->end);
+
 	kfree(print_entry);
 
 	return 0;
@@ -1178,7 +1208,6 @@ static int __init pat_memtype_list_init(void)
 	}
 	return 0;
 }
-
 late_initcall(pat_memtype_list_init);
 
 #endif /* CONFIG_DEBUG_FS && CONFIG_X86_PAT */
diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
index 6855362..2abc475 100644
--- a/arch/x86/mm/pat_interval.c
+++ b/arch/x86/mm/pat_interval.c
@@ -25,25 +25,27 @@
  * physical memory areas. Without proper tracking, conflicting memory
  * types in different mappings can cause CPU cache corruption.
  *
- * The tree is an interval tree (augmented rbtree) with tree ordered
- * on starting address. Tree can contain multiple entries for
+ * The tree is an interval tree (augmented rbtree) which tree is ordered
+ * by the starting address. The tree can contain multiple entries for
  * different regions which overlap. All the aliases have the same
- * cache attributes of course.
+ * cache attributes of course, as enforced by the PAT logic.
  *
  * memtype_lock protects the rbtree.
  */
-static inline u64 memtype_interval_start(struct memtype *memtype)
+
+static inline u64 interval_start(struct memtype *memtype)
 {
 	return memtype->start;
 }
 
-static inline u64 memtype_interval_end(struct memtype *memtype)
+static inline u64 interval_end(struct memtype *memtype)
 {
 	return memtype->end - 1;
 }
+
 INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
-		     memtype_interval_start, memtype_interval_end,
-		     static, memtype_interval)
+		     interval_start, interval_end,
+		     static, interval)
 
 static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
 
@@ -56,7 +58,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
+	match = interval_iter_first(&memtype_rbroot, start, end-1);
 	while (match != NULL && match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
@@ -66,7 +68,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 		    (match->start < start) && (match->end == end))
 			return match;
 
-		match = memtype_interval_iter_next(match, start, end-1);
+		match = interval_iter_next(match, start, end-1);
 	}
 
 	return NULL; /* Returns NULL if there is no match */
@@ -79,7 +81,7 @@ static int memtype_check_conflict(u64 start, u64 end,
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
+	match = interval_iter_first(&memtype_rbroot, start, end-1);
 	if (match == NULL)
 		goto success;
 
@@ -89,12 +91,12 @@ static int memtype_check_conflict(u64 start, u64 end,
 	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
 	found_type = match->type;
 
-	match = memtype_interval_iter_next(match, start, end-1);
+	match = interval_iter_next(match, start, end-1);
 	while (match) {
 		if (match->type != found_type)
 			goto failure;
 
-		match = memtype_interval_iter_next(match, start, end-1);
+		match = interval_iter_next(match, start, end-1);
 	}
 success:
 	if (newtype)
@@ -106,11 +108,11 @@ failure:
 	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
 		current->comm, current->pid, start, end,
 		cattr_name(found_type), cattr_name(match->type));
+
 	return -EBUSY;
 }
 
-int memtype_check_insert(struct memtype *new,
-			 enum page_cache_mode *ret_type)
+int memtype_check_insert(struct memtype *new, enum page_cache_mode *ret_type)
 {
 	int err = 0;
 
@@ -121,7 +123,7 @@ int memtype_check_insert(struct memtype *new,
 	if (ret_type)
 		new->type = *ret_type;
 
-	memtype_interval_insert(new, &memtype_rbroot);
+	interval_insert(new, &memtype_rbroot);
 	return 0;
 }
 
@@ -145,12 +147,13 @@ struct memtype *memtype_erase(u64 start, u64 end)
 
 	if (data->start == start) {
 		/* munmap: erase this node */
-		memtype_interval_remove(data, &memtype_rbroot);
+		interval_remove(data, &memtype_rbroot);
 	} else {
 		/* mremap: update the end value of this node */
-		memtype_interval_remove(data, &memtype_rbroot);
+		interval_remove(data, &memtype_rbroot);
 		data->end = start;
-		memtype_interval_insert(data, &memtype_rbroot);
+		interval_insert(data, &memtype_rbroot);
+
 		return NULL;
 	}
 
@@ -159,19 +162,24 @@ struct memtype *memtype_erase(u64 start, u64 end)
 
 struct memtype *memtype_lookup(u64 addr)
 {
-	return memtype_interval_iter_first(&memtype_rbroot, addr,
-					   addr + PAGE_SIZE-1);
+	return interval_iter_first(&memtype_rbroot, addr, addr + PAGE_SIZE-1);
 }
 
-#if defined(CONFIG_DEBUG_FS)
+/*
+ * Debugging helper, copy the Nth entry of the tree into a
+ * a copy for printout. This allows us to print out the tree
+ * via debugfs, without holding the memtype_lock too long:
+ */
+#ifdef CONFIG_DEBUG_FS
 int memtype_copy_nth_element(struct memtype *out, loff_t pos)
 {
 	struct memtype *match;
 	int i = 1;
 
-	match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+	match = interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+
 	while (match && pos != i) {
-		match = memtype_interval_iter_next(match, 0, ULONG_MAX);
+		match = interval_iter_next(match, 0, ULONG_MAX);
 		i++;
 	}
 
