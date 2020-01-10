Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B667424677
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgAJR7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59277 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgAJR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ7-0002Am-WA; Fri, 10 Jan 2020 18:59:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94D321C2D6D;
        Fri, 10 Jan 2020 18:59:20 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:20 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Harmonize 'struct memtype *' local variable
 and function parameter use
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867916039.30329.9064495717711706830.tip-bot2@tip-bot2>
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

Commit-ID:     baf65855baac302bbacf0ce17ed99b9c0940b930
Gitweb:        https://git.kernel.org/tip/baf65855baac302bbacf0ce17ed99b9c0940b930
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 10 Dec 2019 10:07:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Harmonize 'struct memtype *' local variable and function parameter use

We have quite a zoo of 'struct memtype' variable nomenclature:

  new
  entry
  print_entry
  data
  match
  out
  memtype

Beyond the randomness, some of these are outright confusing, especially
when used in larger functions.

Standardize them:

  entry
  entry_new
  entry_old
  entry_print
  entry_match
  entry_out

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c          | 51 ++++++++++-----------
 arch/x86/mm/pat_internal.h |  6 +-
 arch/x86/mm/pat_interval.c | 91 ++++++++++++++++++-------------------
 3 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index af04992..4a18049 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -576,7 +576,7 @@ static u64 sanitize_phys(u64 address)
 int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 		    enum page_cache_mode *new_type)
 {
-	struct memtype *new;
+	struct memtype *entry_new;
 	enum page_cache_mode actual_type;
 	int is_range_ram;
 	int err = 0;
@@ -624,22 +624,22 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 		return -EINVAL;
 	}
 
-	new  = kzalloc(sizeof(struct memtype), GFP_KERNEL);
-	if (!new)
+	entry_new = kzalloc(sizeof(struct memtype), GFP_KERNEL);
+	if (!entry_new)
 		return -ENOMEM;
 
-	new->start	= start;
-	new->end	= end;
-	new->type	= actual_type;
+	entry_new->start = start;
+	entry_new->end	 = end;
+	entry_new->type	 = actual_type;
 
 	spin_lock(&memtype_lock);
 
-	err = memtype_check_insert(new, new_type);
+	err = memtype_check_insert(entry_new, new_type);
 	if (err) {
 		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
 			start, end - 1,
-			cattr_name(new->type), cattr_name(req_type));
-		kfree(new);
+			cattr_name(entry_new->type), cattr_name(req_type));
+		kfree(entry_new);
 		spin_unlock(&memtype_lock);
 
 		return err;
@@ -648,7 +648,7 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 	spin_unlock(&memtype_lock);
 
 	dprintk("reserve_memtype added [mem %#010Lx-%#010Lx], track %s, req %s, ret %s\n",
-		start, end - 1, cattr_name(new->type), cattr_name(req_type),
+		start, end - 1, cattr_name(entry_new->type), cattr_name(req_type),
 		new_type ? cattr_name(*new_type) : "-");
 
 	return err;
@@ -657,7 +657,7 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 int free_memtype(u64 start, u64 end)
 {
 	int is_range_ram;
-	struct memtype *entry;
+	struct memtype *entry_old;
 
 	if (!pat_enabled())
 		return 0;
@@ -676,16 +676,16 @@ int free_memtype(u64 start, u64 end)
 		return -EINVAL;
 
 	spin_lock(&memtype_lock);
-	entry = memtype_erase(start, end);
+	entry_old = memtype_erase(start, end);
 	spin_unlock(&memtype_lock);
 
-	if (IS_ERR(entry)) {
+	if (IS_ERR(entry_old)) {
 		pr_info("x86/PAT: %s:%d freeing invalid memtype [mem %#010Lx-%#010Lx]\n",
 			current->comm, current->pid, start, end - 1);
 		return -EINVAL;
 	}
 
-	kfree(entry);
+	kfree(entry_old);
 
 	dprintk("free_memtype request [mem %#010Lx-%#010Lx]\n", start, end - 1);
 
@@ -726,6 +726,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 		rettype = _PAGE_CACHE_MODE_UC_MINUS;
 
 	spin_unlock(&memtype_lock);
+
 	return rettype;
 }
 
@@ -1130,24 +1131,24 @@ EXPORT_SYMBOL_GPL(pgprot_writethrough);
  */
 static struct memtype *memtype_get_idx(loff_t pos)
 {
-	struct memtype *print_entry;
+	struct memtype *entry_print;
 	int ret;
 
-	print_entry  = kzalloc(sizeof(struct memtype), GFP_KERNEL);
-	if (!print_entry)
+	entry_print  = kzalloc(sizeof(struct memtype), GFP_KERNEL);
+	if (!entry_print)
 		return NULL;
 
 	spin_lock(&memtype_lock);
-	ret = memtype_copy_nth_element(print_entry, pos);
+	ret = memtype_copy_nth_element(entry_print, pos);
 	spin_unlock(&memtype_lock);
 
 	/* Free it on error: */
 	if (ret) {
-		kfree(print_entry);
+		kfree(entry_print);
 		return NULL;
 	}
 
-	return print_entry;
+	return entry_print;
 }
 
 static void *memtype_seq_start(struct seq_file *seq, loff_t *pos)
@@ -1172,14 +1173,14 @@ static void memtype_seq_stop(struct seq_file *seq, void *v)
 
 static int memtype_seq_show(struct seq_file *seq, void *v)
 {
-	struct memtype *print_entry = (struct memtype *)v;
+	struct memtype *entry_print = (struct memtype *)v;
 
 	seq_printf(seq, "PAT: [mem 0x%016Lx-0x%016Lx] %s\n",
-			print_entry->start,
-			print_entry->end,
-			cattr_name(print_entry->type));
+			entry_print->start,
+			entry_print->end,
+			cattr_name(entry_print->type));
 
-	kfree(print_entry);
+	kfree(entry_print);
 
 	return 0;
 }
diff --git a/arch/x86/mm/pat_internal.h b/arch/x86/mm/pat_internal.h
index 79a0668..23ce8cd 100644
--- a/arch/x86/mm/pat_internal.h
+++ b/arch/x86/mm/pat_internal.h
@@ -29,13 +29,13 @@ static inline char *cattr_name(enum page_cache_mode pcm)
 }
 
 #ifdef CONFIG_X86_PAT
-extern int memtype_check_insert(struct memtype *new,
+extern int memtype_check_insert(struct memtype *entry_new,
 				enum page_cache_mode *new_type);
 extern struct memtype *memtype_erase(u64 start, u64 end);
 extern struct memtype *memtype_lookup(u64 addr);
-extern int memtype_copy_nth_element(struct memtype *out, loff_t pos);
+extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);
 #else
-static inline int memtype_check_insert(struct memtype *new,
+static inline int memtype_check_insert(struct memtype *entry_new,
 				       enum page_cache_mode *new_type)
 { return 0; }
 static inline struct memtype *memtype_erase(u64 start, u64 end)
diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
index 2abc475..3c983de 100644
--- a/arch/x86/mm/pat_interval.c
+++ b/arch/x86/mm/pat_interval.c
@@ -33,14 +33,14 @@
  * memtype_lock protects the rbtree.
  */
 
-static inline u64 interval_start(struct memtype *memtype)
+static inline u64 interval_start(struct memtype *entry)
 {
-	return memtype->start;
+	return entry->start;
 }
 
-static inline u64 interval_end(struct memtype *memtype)
+static inline u64 interval_end(struct memtype *entry)
 {
-	return memtype->end - 1;
+	return entry->end - 1;
 }
 
 INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
@@ -56,19 +56,20 @@ enum {
 
 static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 {
-	struct memtype *match;
+	struct memtype *entry_match;
 
-	match = interval_iter_first(&memtype_rbroot, start, end-1);
-	while (match != NULL && match->start < end) {
+	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
+
+	while (entry_match != NULL && entry_match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
-		    (match->start == start) && (match->end == end))
-			return match;
+		    (entry_match->start == start) && (entry_match->end == end))
+			return entry_match;
 
 		if ((match_type == MEMTYPE_END_MATCH) &&
-		    (match->start < start) && (match->end == end))
-			return match;
+		    (entry_match->start < start) && (entry_match->end == end))
+			return entry_match;
 
-		match = interval_iter_next(match, start, end-1);
+		entry_match = interval_iter_next(entry_match, start, end-1);
 	}
 
 	return NULL; /* Returns NULL if there is no match */
@@ -78,25 +79,25 @@ static int memtype_check_conflict(u64 start, u64 end,
 				  enum page_cache_mode reqtype,
 				  enum page_cache_mode *newtype)
 {
-	struct memtype *match;
+	struct memtype *entry_match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = interval_iter_first(&memtype_rbroot, start, end-1);
-	if (match == NULL)
+	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
+	if (entry_match == NULL)
 		goto success;
 
-	if (match->type != found_type && newtype == NULL)
+	if (entry_match->type != found_type && newtype == NULL)
 		goto failure;
 
-	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
-	found_type = match->type;
+	dprintk("Overlap at 0x%Lx-0x%Lx\n", entry_match->start, entry_match->end);
+	found_type = entry_match->type;
 
-	match = interval_iter_next(match, start, end-1);
-	while (match) {
-		if (match->type != found_type)
+	entry_match = interval_iter_next(entry_match, start, end-1);
+	while (entry_match) {
+		if (entry_match->type != found_type)
 			goto failure;
 
-		match = interval_iter_next(match, start, end-1);
+		entry_match = interval_iter_next(entry_match, start, end-1);
 	}
 success:
 	if (newtype)
@@ -107,29 +108,29 @@ success:
 failure:
 	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
 		current->comm, current->pid, start, end,
-		cattr_name(found_type), cattr_name(match->type));
+		cattr_name(found_type), cattr_name(entry_match->type));
 
 	return -EBUSY;
 }
 
-int memtype_check_insert(struct memtype *new, enum page_cache_mode *ret_type)
+int memtype_check_insert(struct memtype *entry_new, enum page_cache_mode *ret_type)
 {
 	int err = 0;
 
-	err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
+	err = memtype_check_conflict(entry_new->start, entry_new->end, entry_new->type, ret_type);
 	if (err)
 		return err;
 
 	if (ret_type)
-		new->type = *ret_type;
+		entry_new->type = *ret_type;
 
-	interval_insert(new, &memtype_rbroot);
+	interval_insert(entry_new, &memtype_rbroot);
 	return 0;
 }
 
 struct memtype *memtype_erase(u64 start, u64 end)
 {
-	struct memtype *data;
+	struct memtype *entry_old;
 
 	/*
 	 * Since the memtype_rbroot tree allows overlapping ranges,
@@ -138,26 +139,26 @@ struct memtype *memtype_erase(u64 start, u64 end)
 	 * it then checks with END_MATCH, i.e. shrink the size of a node
 	 * from the end for the mremap case.
 	 */
-	data = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
-	if (!data) {
-		data = memtype_match(start, end, MEMTYPE_END_MATCH);
-		if (!data)
+	entry_old = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
+	if (!entry_old) {
+		entry_old = memtype_match(start, end, MEMTYPE_END_MATCH);
+		if (!entry_old)
 			return ERR_PTR(-EINVAL);
 	}
 
-	if (data->start == start) {
+	if (entry_old->start == start) {
 		/* munmap: erase this node */
-		interval_remove(data, &memtype_rbroot);
+		interval_remove(entry_old, &memtype_rbroot);
 	} else {
 		/* mremap: update the end value of this node */
-		interval_remove(data, &memtype_rbroot);
-		data->end = start;
-		interval_insert(data, &memtype_rbroot);
+		interval_remove(entry_old, &memtype_rbroot);
+		entry_old->end = start;
+		interval_insert(entry_old, &memtype_rbroot);
 
 		return NULL;
 	}
 
-	return data;
+	return entry_old;
 }
 
 struct memtype *memtype_lookup(u64 addr)
@@ -171,20 +172,20 @@ struct memtype *memtype_lookup(u64 addr)
  * via debugfs, without holding the memtype_lock too long:
  */
 #ifdef CONFIG_DEBUG_FS
-int memtype_copy_nth_element(struct memtype *out, loff_t pos)
+int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos)
 {
-	struct memtype *match;
+	struct memtype *entry_match;
 	int i = 1;
 
-	match = interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+	entry_match = interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
 
-	while (match && pos != i) {
-		match = interval_iter_next(match, 0, ULONG_MAX);
+	while (entry_match && pos != i) {
+		entry_match = interval_iter_next(entry_match, 0, ULONG_MAX);
 		i++;
 	}
 
-	if (match) { /* pos == i */
-		*out = *match;
+	if (entry_match) { /* pos == i */
+		*entry_out = *entry_match;
 		return 0;
 	} else {
 		return 1;
