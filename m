Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB9AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224852077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFAJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgFAJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2123C061A0E;
        Mon,  1 Jun 2020 02:52:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7R-0003ix-JO; Mon, 01 Jun 2020 11:52:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3AB481C0481;
        Mon,  1 Jun 2020 11:52:33 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:33 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] radix-tree: Use local_lock for protection
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527201119.1692513-3-bigeasy@linutronix.de>
References: <20200527201119.1692513-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <159100515309.17951.15189262586666021175.tip-bot2@tip-bot2>
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

Commit-ID:     cfa6705d89b6562f79c40c249f8d94073c4276e4
Gitweb:        https://git.kernel.org/tip/cfa6705d89b6562f79c40c249f8d94073c4276e4
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 27 May 2020 22:11:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:31:09 +02:00

radix-tree: Use local_lock for protection

The radix-tree and idr preload mechanisms use preempt_disable() to protect
the complete operation between xxx_preload() and xxx_preload_end().

As the code inside the preempt disabled section acquires regular spinlocks,
which are converted to 'sleeping' spinlocks on a PREEMPT_RT kernel and
eventually calls into a memory allocator, this conflicts with the RT
semantics.

Convert it to a local_lock which allows RT kernels to substitute them with
a real per CPU lock. On non RT kernels this maps to preempt_disable() as
before, but provides also lockdep coverage of the critical region.
No functional change.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200527201119.1692513-3-bigeasy@linutronix.de
---
 include/linux/idr.h        |  2 +-
 include/linux/radix-tree.h | 11 ++++++++++-
 lib/radix-tree.c           | 20 +++++++++-----------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index ac6e946..3ade03e 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -171,7 +171,7 @@ static inline bool idr_is_empty(const struct idr *idr)
  */
 static inline void idr_preload_end(void)
 {
-	preempt_enable();
+	local_unlock(&radix_tree_preloads.lock);
 }
 
 /**
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 63e6237..c2a9f7c 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -16,11 +16,20 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <linux/local_lock.h>
 
 /* Keep unconverted code working */
 #define radix_tree_root		xarray
 #define radix_tree_node		xa_node
 
+struct radix_tree_preload {
+	local_lock_t lock;
+	unsigned nr;
+	/* nodes->parent points to next preallocated node */
+	struct radix_tree_node *nodes;
+};
+DECLARE_PER_CPU(struct radix_tree_preload, radix_tree_preloads);
+
 /*
  * The bottom two bits of the slot determine how the remaining bits in the
  * slot are interpreted:
@@ -245,7 +254,7 @@ int radix_tree_tagged(const struct radix_tree_root *, unsigned int tag);
 
 static inline void radix_tree_preload_end(void)
 {
-	preempt_enable();
+	local_unlock(&radix_tree_preloads.lock);
 }
 
 void __rcu **idr_get_free(struct radix_tree_root *root,
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 2ee6ae3..34e406f 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
 #include <linux/percpu.h>
+#include <linux/local_lock.h>
 #include <linux/preempt.h>		/* in_interrupt() */
 #include <linux/radix-tree.h>
 #include <linux/rcupdate.h>
@@ -27,7 +28,6 @@
 #include <linux/string.h>
 #include <linux/xarray.h>
 
-
 /*
  * Radix tree node cache.
  */
@@ -58,12 +58,10 @@ struct kmem_cache *radix_tree_node_cachep;
 /*
  * Per-cpu pool of preloaded nodes
  */
-struct radix_tree_preload {
-	unsigned nr;
-	/* nodes->parent points to next preallocated node */
-	struct radix_tree_node *nodes;
+DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = {
+	.lock = INIT_LOCAL_LOCK(lock),
 };
-static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
+EXPORT_PER_CPU_SYMBOL_GPL(radix_tree_preloads);
 
 static inline struct radix_tree_node *entry_to_node(void *ptr)
 {
@@ -332,14 +330,14 @@ static __must_check int __radix_tree_preload(gfp_t gfp_mask, unsigned nr)
 	 */
 	gfp_mask &= ~__GFP_ACCOUNT;
 
-	preempt_disable();
+	local_lock(&radix_tree_preloads.lock);
 	rtp = this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < nr) {
-		preempt_enable();
+		local_unlock(&radix_tree_preloads.lock);
 		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
 		if (node == NULL)
 			goto out;
-		preempt_disable();
+		local_lock(&radix_tree_preloads.lock);
 		rtp = this_cpu_ptr(&radix_tree_preloads);
 		if (rtp->nr < nr) {
 			node->parent = rtp->nodes;
@@ -381,7 +379,7 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
 	if (gfpflags_allow_blocking(gfp_mask))
 		return __radix_tree_preload(gfp_mask, RADIX_TREE_PRELOAD_SIZE);
 	/* Preloading doesn't help anything with this gfp mask, skip it */
-	preempt_disable();
+	local_lock(&radix_tree_preloads.lock);
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_maybe_preload);
@@ -1470,7 +1468,7 @@ EXPORT_SYMBOL(radix_tree_tagged);
 void idr_preload(gfp_t gfp_mask)
 {
 	if (__radix_tree_preload(gfp_mask, IDR_PRELOAD_SIZE))
-		preempt_disable();
+		local_lock(&radix_tree_preloads.lock);
 }
 EXPORT_SYMBOL(idr_preload);
 
