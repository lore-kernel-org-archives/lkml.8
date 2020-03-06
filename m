Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1980C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7D720848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCFKjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCFKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAANk-0000CW-Pj; Fri, 06 Mar 2020 11:39:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7663B1C0081;
        Fri,  6 Mar 2020 11:39:04 +0100 (CET)
Date:   Fri, 06 Mar 2020 10:39:04 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Fix inode life-time issue
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158349114423.28353.5298611624163991585.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8019ad13ef7f64be44d4f892af9c840179009254
Gitweb:        https://git.kernel.org/tip/8019ad13ef7f64be44d4f892af9c840179009254
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 04 Mar 2020 11:28:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Mar 2020 11:06:15 +01:00

futex: Fix inode life-time issue

As reported by Jann, ihold() does not in fact guarantee inode
persistence. And instead of making it so, replace the usage of inode
pointers with a per boot, machine wide, unique inode identifier.

This sequence number is global, but shared (file backed) futexes are
rare enough that this should not become a performance issue.

Reported-by: Jann Horn <jannh@google.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/inode.c            |  1 +-
 include/linux/fs.h    |  1 +-
 include/linux/futex.h | 17 ++++----
 kernel/futex.c        | 89 +++++++++++++++++++++++++-----------------
 4 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 7d57068..93d9252 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -138,6 +138,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_sb = sb;
 	inode->i_blkbits = sb->s_blocksize_bits;
 	inode->i_flags = 0;
+	atomic64_set(&inode->i_sequence, 0);
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6..abedbff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -698,6 +698,7 @@ struct inode {
 		struct rcu_head		i_rcu;
 	};
 	atomic64_t		i_version;
+	atomic64_t		i_sequence; /* see futex */
 	atomic_t		i_count;
 	atomic_t		i_dio_count;
 	atomic_t		i_writecount;
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 5cc3fed..b70df27 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -31,23 +31,26 @@ struct task_struct;
 
 union futex_key {
 	struct {
+		u64 i_seq;
 		unsigned long pgoff;
-		struct inode *inode;
-		int offset;
+		unsigned int offset;
 	} shared;
 	struct {
+		union {
+			struct mm_struct *mm;
+			u64 __tmp;
+		};
 		unsigned long address;
-		struct mm_struct *mm;
-		int offset;
+		unsigned int offset;
 	} private;
 	struct {
+		u64 ptr;
 		unsigned long word;
-		void *ptr;
-		int offset;
+		unsigned int offset;
 	} both;
 };
 
-#define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = NULL } }
+#define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = 0ULL } }
 
 #ifdef CONFIG_FUTEX
 enum {
diff --git a/kernel/futex.c b/kernel/futex.c
index 0cf84c8..e14f7cd 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -429,7 +429,7 @@ static void get_futex_key_refs(union futex_key *key)
 
 	switch (key->both.offset & (FUT_OFF_INODE|FUT_OFF_MMSHARED)) {
 	case FUT_OFF_INODE:
-		ihold(key->shared.inode); /* implies smp_mb(); (B) */
+		smp_mb();		/* explicit smp_mb(); (B) */
 		break;
 	case FUT_OFF_MMSHARED:
 		futex_get_mm(key); /* implies smp_mb(); (B) */
@@ -463,7 +463,6 @@ static void drop_futex_key_refs(union futex_key *key)
 
 	switch (key->both.offset & (FUT_OFF_INODE|FUT_OFF_MMSHARED)) {
 	case FUT_OFF_INODE:
-		iput(key->shared.inode);
 		break;
 	case FUT_OFF_MMSHARED:
 		mmdrop(key->private.mm);
@@ -505,6 +504,46 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 	return timeout;
 }
 
+/*
+ * Generate a machine wide unique identifier for this inode.
+ *
+ * This relies on u64 not wrapping in the life-time of the machine; which with
+ * 1ns resolution means almost 585 years.
+ *
+ * This further relies on the fact that a well formed program will not unmap
+ * the file while it has a (shared) futex waiting on it. This mapping will have
+ * a file reference which pins the mount and inode.
+ *
+ * If for some reason an inode gets evicted and read back in again, it will get
+ * a new sequence number and will _NOT_ match, even though it is the exact same
+ * file.
+ *
+ * It is important that match_futex() will never have a false-positive, esp.
+ * for PI futexes that can mess up the state. The above argues that false-negatives
+ * are only possible for malformed programs.
+ */
+static u64 get_inode_sequence_number(struct inode *inode)
+{
+	static atomic64_t i_seq;
+	u64 old;
+
+	/* Does the inode already have a sequence number? */
+	old = atomic64_read(&inode->i_sequence);
+	if (likely(old))
+		return old;
+
+	for (;;) {
+		u64 new = atomic64_add_return(1, &i_seq);
+		if (WARN_ON_ONCE(!new))
+			continue;
+
+		old = atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
+		if (old)
+			return old;
+		return new;
+	}
+}
+
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
@@ -517,9 +556,15 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
  *
  * The key words are stored in @key on success.
  *
- * For shared mappings, it's (page->index, file_inode(vma->vm_file),
- * offset_within_page).  For private mappings, it's (uaddr, current->mm).
- * We can usually work out the index without swapping in the page.
+ * For shared mappings (when @fshared), the key is:
+ *   ( inode->i_sequence, page->index, offset_within_page )
+ * [ also see get_inode_sequence_number() ]
+ *
+ * For private mappings (or when !@fshared), the key is:
+ *   ( current->mm, address, 0 )
+ *
+ * This allows (cross process, where applicable) identification of the futex
+ * without keeping the page pinned for the duration of the FUTEX_WAIT.
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
@@ -659,8 +704,6 @@ again:
 		key->private.mm = mm;
 		key->private.address = address;
 
-		get_futex_key_refs(key); /* implies smp_mb(); (B) */
-
 	} else {
 		struct inode *inode;
 
@@ -692,40 +735,14 @@ again:
 			goto again;
 		}
 
-		/*
-		 * Take a reference unless it is about to be freed. Previously
-		 * this reference was taken by ihold under the page lock
-		 * pinning the inode in place so i_lock was unnecessary. The
-		 * only way for this check to fail is if the inode was
-		 * truncated in parallel which is almost certainly an
-		 * application bug. In such a case, just retry.
-		 *
-		 * We are not calling into get_futex_key_refs() in file-backed
-		 * cases, therefore a successful atomic_inc return below will
-		 * guarantee that get_futex_key() will still imply smp_mb(); (B).
-		 */
-		if (!atomic_inc_not_zero(&inode->i_count)) {
-			rcu_read_unlock();
-			put_page(page);
-
-			goto again;
-		}
-
-		/* Should be impossible but lets be paranoid for now */
-		if (WARN_ON_ONCE(inode->i_mapping != mapping)) {
-			err = -EFAULT;
-			rcu_read_unlock();
-			iput(inode);
-
-			goto out;
-		}
-
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
-		key->shared.inode = inode;
+		key->shared.i_seq = get_inode_sequence_number(inode);
 		key->shared.pgoff = basepage_index(tail);
 		rcu_read_unlock();
 	}
 
+	get_futex_key_refs(key); /* implies smp_mb(); (B) */
+
 out:
 	put_page(page);
 	return err;
