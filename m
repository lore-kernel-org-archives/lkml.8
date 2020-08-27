Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3984C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C62B22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhVGsxwD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FvmLDC8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgH0H6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:58:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgH0HyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:23 -0400
Date:   Thu, 27 Aug 2020 07:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrSJKgCTc/cpHbBMG/JOHhIMog43Ktrf0IjBZFESam0=;
        b=NhVGsxwDYdHp1DYzLUXsiMgqFDwcsKvvZoYJb4LejrdGMVayQ09toNRrKVt5sLNdcdMDNp
        MVylpVXF3XBG2HU/w39hwdtOofSjefsG78dnL8MjFutJBX30uqvfETpgaW2otBPtMEyyUx
        TNaNqu86+rz32Xt048leIm0g2SAFak8eZqpZ/TXd4YmmrrrYs+c5Vku+Otv/TOQftozJYl
        gi0pSs/7jxV1EM8DjFv2RSAs7iQHZhOBnd+cF0vmoRfnJxH+uGSvIGnS0Vt6i7uVCywojh
        IiV1UP7lo1zY2hYuCpykfklbi37eTalMGWx1IDx8Pr/+KQGRGn5jI5c0rMro6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrSJKgCTc/cpHbBMG/JOHhIMog43Ktrf0IjBZFESam0=;
        b=FvmLDC8QvNG4qUQwMDTXzyF8q2AWpc0+0E2a5BJ+cWolHKE2m8dw0XMK/W5tld+M4qz3XC
        5tUdrdUglds53kBw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Introduce lock_list::dep
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-7-boqun.feng@gmail.com>
References: <20200807074238.1632519-7-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851486016.20229.7794577355389507269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3454a36d6a39186de508dd43df590a6363364176
Gitweb:        https://git.kernel.org/tip/3454a36d6a39186de508dd43df590a6363364176
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:25 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:04 +02:00

lockdep: Introduce lock_list::dep

To add recursive read locks into the dependency graph, we need to store
the types of dependencies for the BFS later. There are four types of
dependencies:

*	Exclusive -> Non-recursive dependencies: EN
	e.g. write_lock(prev) held and try to acquire write_lock(next)
	or non-recursive read_lock(next), which can be represented as
	"prev -(EN)-> next"

*	Shared -> Non-recursive dependencies: SN
	e.g. read_lock(prev) held and try to acquire write_lock(next) or
	non-recursive read_lock(next), which can be represented as
	"prev -(SN)-> next"

*	Exclusive -> Recursive dependencies: ER
	e.g. write_lock(prev) held and try to acquire recursive
	read_lock(next), which can be represented as "prev -(ER)-> next"

*	Shared -> Recursive dependencies: SR
	e.g. read_lock(prev) held and try to acquire recursive
	read_lock(next), which can be represented as "prev -(SR)-> next"

So we use 4 bits for the presence of each type in lock_list::dep. Helper
functions and macros are also introduced to convert a pair of locks into
lock_list::dep bit and maintain the addition of different types of
dependencies.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-7-boqun.feng@gmail.com
---
 include/linux/lockdep.h  |  2 +-
 kernel/locking/lockdep.c | 92 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 2275010..35c8bb0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -55,6 +55,8 @@ struct lock_list {
 	struct lock_class		*links_to;
 	const struct lock_trace		*trace;
 	u16				distance;
+	/* bitmap of different dependencies from head to this */
+	u8				dep;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 668a983..16ad1b7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1320,7 +1320,7 @@ static struct lock_list *alloc_list_entry(void)
  */
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
-			    unsigned long ip, u16 distance,
+			    unsigned long ip, u16 distance, u8 dep,
 			    const struct lock_trace *trace)
 {
 	struct lock_list *entry;
@@ -1334,6 +1334,7 @@ static int add_lock_to_list(struct lock_class *this,
 
 	entry->class = this;
 	entry->links_to = links_to;
+	entry->dep = dep;
 	entry->distance = distance;
 	entry->trace = trace;
 	/*
@@ -1499,6 +1500,57 @@ static inline bool bfs_error(enum bfs_result res)
 }
 
 /*
+ * DEP_*_BIT in lock_list::dep
+ *
+ * For dependency @prev -> @next:
+ *
+ *   SR: @prev is shared reader (->read != 0) and @next is recursive reader
+ *       (->read == 2)
+ *   ER: @prev is exclusive locker (->read == 0) and @next is recursive reader
+ *   SN: @prev is shared reader and @next is non-recursive locker (->read != 2)
+ *   EN: @prev is exclusive locker and @next is non-recursive locker
+ *
+ * Note that we define the value of DEP_*_BITs so that:
+ *   bit0 is prev->read == 0
+ *   bit1 is next->read != 2
+ */
+#define DEP_SR_BIT (0 + (0 << 1)) /* 0 */
+#define DEP_ER_BIT (1 + (0 << 1)) /* 1 */
+#define DEP_SN_BIT (0 + (1 << 1)) /* 2 */
+#define DEP_EN_BIT (1 + (1 << 1)) /* 3 */
+
+#define DEP_SR_MASK (1U << (DEP_SR_BIT))
+#define DEP_ER_MASK (1U << (DEP_ER_BIT))
+#define DEP_SN_MASK (1U << (DEP_SN_BIT))
+#define DEP_EN_MASK (1U << (DEP_EN_BIT))
+
+static inline unsigned int
+__calc_dep_bit(struct held_lock *prev, struct held_lock *next)
+{
+	return (prev->read == 0) + ((next->read != 2) << 1);
+}
+
+static inline u8 calc_dep(struct held_lock *prev, struct held_lock *next)
+{
+	return 1U << __calc_dep_bit(prev, next);
+}
+
+/*
+ * calculate the dep_bit for backwards edges. We care about whether @prev is
+ * shared and whether @next is recursive.
+ */
+static inline unsigned int
+__calc_dep_bitb(struct held_lock *prev, struct held_lock *next)
+{
+	return (next->read != 2) + ((prev->read == 0) << 1);
+}
+
+static inline u8 calc_depb(struct held_lock *prev, struct held_lock *next)
+{
+	return 1U << __calc_dep_bitb(prev, next);
+}
+
+/*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
  */
@@ -2552,7 +2604,35 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		if (entry->class == hlock_class(next)) {
 			if (distance == 1)
 				entry->distance = 1;
-			return 1;
+			entry->dep |= calc_dep(prev, next);
+
+			/*
+			 * Also, update the reverse dependency in @next's
+			 * ->locks_before list.
+			 *
+			 *  Here we reuse @entry as the cursor, which is fine
+			 *  because we won't go to the next iteration of the
+			 *  outer loop:
+			 *
+			 *  For normal cases, we return in the inner loop.
+			 *
+			 *  If we fail to return, we have inconsistency, i.e.
+			 *  <prev>::locks_after contains <next> while
+			 *  <next>::locks_before doesn't contain <prev>. In
+			 *  that case, we return after the inner and indicate
+			 *  something is wrong.
+			 */
+			list_for_each_entry(entry, &hlock_class(next)->locks_before, entry) {
+				if (entry->class == hlock_class(prev)) {
+					if (distance == 1)
+						entry->distance = 1;
+					entry->dep |= calc_depb(prev, next);
+					return 1;
+				}
+			}
+
+			/* <prev> is not found in <next>::locks_before */
+			return 0;
 		}
 	}
 
@@ -2579,14 +2659,18 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, *trace);
+			       next->acquire_ip, distance,
+			       calc_dep(prev, next),
+			       *trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, *trace);
+			       next->acquire_ip, distance,
+			       calc_depb(prev, next),
+			       *trace);
 	if (!ret)
 		return 0;
 
