Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB29C76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAC220857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvH6S0Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBPHqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:46:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36502 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgBPHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 02:46:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so5496080plm.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 23:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oByV9jS19XUdDiBoEYoJppft+pgA1ruNja8UqbGBYtw=;
        b=mvH6S0Wn+R4DBaa/bm+lPKodAlaFM5RWw9xX1GJsVLJChd63V0Yg2fT4xjtIObmqzg
         Z2yLhoSff0JDX21k+YzsszOSoqEx3Zfrw/QqyiOBZio4zm3Cj4k0KybtuiHsntg6IGgI
         qxLkp8SmzJ7ZC5Uvbgz7wW9oisVrdVI/qxdcwgeMde+PGmaW4znevq8G/ksDcd9RxxYb
         gqfZFBZgUhT5gnrYkyQmbaNQIj7s2ZFtrXKuYE7hfQuZTw2jFPGqI/HUXWUQS6q5MFmw
         JwLDUXVJXcarpyCEbqV0/6lPkeNyE0LIbD902ABYYZdqXx9SCYcCXMT6Aw+HSHVgJUHT
         U+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oByV9jS19XUdDiBoEYoJppft+pgA1ruNja8UqbGBYtw=;
        b=iZI6FRIzlHvcFvMgU9K6huP8mifiEqrIdYnSoVt+hqB4b49tm50dk9XkPxZYvqyWDW
         W2k8NZcBu0ze+dIR8qyCzmCK4gZTYqimZGbaqSVZtw6ufjRDzOzmkuPpktbEf8nCNsRj
         wrWZEAxWIx4LNtYguWlTA+Y6dbbkp/3J0GVZSW6IcPa3hbjW73uEZdFwij+YFnfPtWD4
         +/eKTq8AcjlHMvOQI3m4Nnb451gDVxYRPEwIBPJymoV2jkrivDQwnQorXO5Q30pSnOrN
         qCUws/lw0ljR2umGCaX9PjfHVvTEN1O+PHRCkoJooBGWDfTBNxF5+gbMJX6cjEeEATYo
         8eeA==
X-Gm-Message-State: APjAAAV6mB2To4FVRQ1F3lq8Snl1Hm1FkCW3AQKLpyMm6wVqGLp69EQT
        N+28TNv/l0MbGZOD93mZQ9c=
X-Google-Smtp-Source: APXvYqygKDR9NF8DXC4hNRUsBfv4iNeh3Fz8wOFoFRmjAKsRiVGzsTON6q2g3lZ79NfFKDth+vbx9A==
X-Received: by 2002:a17:90b:4382:: with SMTP id in2mr13521617pjb.29.1581839202177;
        Sat, 15 Feb 2020 23:46:42 -0800 (PST)
Received: from workstation-portable ([103.211.17.250])
        by smtp.gmail.com with ESMTPSA id l18sm12272667pfe.96.2020.02.15.23.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 23:46:41 -0800 (PST)
Date:   Sun, 16 Feb 2020 13:16:36 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH RESEND] lockdep: Pass lockdep expression to RCU lists
Message-ID: <20200216074636.GB14025@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data is traversed using hlist_for_each_entry_rcu outside an
RCU read-side critical section but under the protection
of either lockdep_lock or with irqs disabled.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists. Also add macro for
corresponding lockdep expression.

Two things to note:
- RCU traversals protected under both, irqs disabled and
graph lock, have both the checks in the lockdep expression.
- RCU traversals under the protection of just disabled irqs
don't have a corresponding lockdep expression as it is implicitly
checked for.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/locking/lockdep.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7112d3..696ad5d4daed 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -85,6 +85,8 @@ module_param(lock_stat, int, 0644);
  * code to recurse back into the lockdep code...
  */
 static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+#define graph_lock_held() \
+	arch_spin_is_locked(&lockdep_lock)
 static struct task_struct *lockdep_selftest_task_struct;
 
 static int graph_lock(void)
@@ -1009,7 +1011,7 @@ static bool __check_data_structures(void)
 	/* Check the chain_key of all lock chains. */
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
-		hlist_for_each_entry_rcu(chain, head, entry) {
+		hlist_for_each_entry_rcu(chain, head, entry, graph_lock_held()) {
 			if (!check_lock_chain_key(chain))
 				return false;
 		}
@@ -1124,7 +1126,8 @@ void lockdep_register_key(struct lock_class_key *key)
 	raw_local_irq_save(flags);
 	if (!graph_lock())
 		goto restore_irqs;
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry,
+				 irqs_disabled() && graph_lock_held()) {
 		if (WARN_ON_ONCE(k == key))
 			goto out_unlock;
 	}
@@ -1203,7 +1206,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	 * We have to do the hash-walk again, to avoid races
 	 * with another CPU:
 	 */
-	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu(class, hash_head, hash_entry,
+				 irqs_disabled() && graph_lock_held()) {
 		if (class->key == key)
 			goto out_unlock_set;
 	}
@@ -2858,7 +2862,7 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 
-	hlist_for_each_entry_rcu(chain, hash_head, entry) {
+	hlist_for_each_entry_rcu(chain, hash_head, entry, graph_lock_held()) {
 		if (READ_ONCE(chain->chain_key) == chain_key) {
 			debug_atomic_inc(chain_lookup_hits);
 			return chain;
@@ -4833,7 +4837,7 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
-		hlist_for_each_entry_rcu(chain, head, entry) {
+		hlist_for_each_entry_rcu(chain, head, entry, graph_lock_held()) {
 			remove_class_from_lock_chain(pf, chain, class);
 		}
 	}
@@ -4993,7 +4997,7 @@ static void __lockdep_free_key_range(struct pending_free *pf, void *start,
 	/* Unhash all classes that were created by a module. */
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
+		hlist_for_each_entry_rcu(class, head, hash_entry, graph_lock_held()) {
 			if (!within(class->key, start, size) &&
 			    !within(class->name, start, size))
 				continue;
@@ -5076,7 +5080,7 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
+		hlist_for_each_entry_rcu(class, head, hash_entry, graph_lock_held()) {
 			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
 				if (lock->class_cache[j] == class)
 					return true;
@@ -5181,7 +5185,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		goto out_irq;
 
 	pf = get_pending_free();
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry,
+				 irqs_disabled() && graph_lock_held()) {
 		if (k == key) {
 			hlist_del_rcu(&k->hash_entry);
 			found = true;
-- 
2.24.1

