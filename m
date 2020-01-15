Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7DCC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB8622522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbcsMRnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgAOVnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:43:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgAOVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579124616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=8FMSdmNI02UJe5G/CRhEBPW79yJpej6yWEShxcGB8ik=;
        b=FbcsMRnzb+PeP3Odk5OQAugQXEcPHv3+SVs1lZAbkG87Um+v+m67Ubzsb5Up77/vpTrd8y
        he6jQ+wVYsXpxRCT9hyi/9KrsX/CimBPSySrdprCK/v6XdYLYIJoaAjEy0xCXghssSGANn
        OkfmrKBX20mwmVQ3Q/xQfaXbn2/lLMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-zNZZaQtuOyGp3TwZv8kkFg-1; Wed, 15 Jan 2020 16:43:33 -0500
X-MC-Unique: zNZZaQtuOyGp3TwZv8kkFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAEE2107ACC4;
        Wed, 15 Jan 2020 21:43:31 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 230175C553;
        Wed, 15 Jan 2020 21:43:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 1/8] locking/lockdep: Decrement irq context counters when removing lock chain
Date:   Wed, 15 Jan 2020 16:43:06 -0500
Message-Id: <20200115214313.13253-2-longman@redhat.com>
In-Reply-To: <20200115214313.13253-1-longman@redhat.com>
References: <20200115214313.13253-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently three counters to track the irq context of a lock
chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
They are incremented when a new lock chain is added, but they are
not decremented when a lock chain is removed. That causes some of the
statistic counts reported by /proc/lockdep_stats to be incorrect.

Fix that by decrementing the right counter when a lock chain is removed.

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 36 +++++++++++++++++++++---------
 kernel/locking/lockdep_internals.h |  6 +++++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7112d3..b20fa6236b2a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2299,16 +2299,24 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	return 0;
 }
 
-static void inc_chains(void)
+static void inc_chains(int irq_context)
 {
-	if (current->hardirq_context)
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
 		nr_hardirq_chains++;
-	else {
-		if (current->softirq_context)
-			nr_softirq_chains++;
-		else
-			nr_process_chains++;
-	}
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains++;
+	else
+		nr_process_chains++;
+}
+
+static void dec_chains(int irq_context)
+{
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains--;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains--;
+	else
+		nr_process_chains--;
 }
 
 #else
@@ -2324,6 +2332,10 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
+static void dec_chains(int irq_context)
+{
+	nr_process_chains--;
+}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void
@@ -2844,7 +2856,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
-	inc_chains();
+	inc_chains(chain->irq_context);
 
 	return 1;
 }
@@ -3597,7 +3609,8 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return 2 * !!task->hardirq_context + !!task->softirq_context;
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
+	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
 static int separate_irq_context(struct task_struct *curr,
@@ -4799,6 +4812,8 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 		return;
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, chain_key);
+	dec_chains(chain->irq_context);
+
 	/*
 	 * Note: calling hlist_del_rcu() from inside a
 	 * hlist_for_each_entry_rcu() loop is safe.
@@ -4820,6 +4835,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	}
 	*new_chain = *chain;
 	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
+	inc_chains(new_chain->irq_context);
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 18d85aebbb57..53500a1dac58 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -98,6 +98,12 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 
 #define MAX_LOCKDEP_CHAINS_BITS	16
 
+/*
+ * Bit definitions for lock_chain.irq_context
+ */
+#define LOCK_CHAIN_SOFTIRQ_CONTEXT	(1 << 0)
+#define LOCK_CHAIN_HARDIRQ_CONTEXT	(1 << 1)
+
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
-- 
2.18.1

