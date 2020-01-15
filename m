Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04894C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6AC22522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kj7TJDmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgAOVnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:43:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50813 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729442AbgAOVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579124621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=111sDixQgCB12x0uYOHRfIvRYKFB4G+KwVAxi1oomqw=;
        b=Kj7TJDmgFgS/xvcv/H+3qwnO9w7+jcJu+ItYXYWlq7PgnrUHpCeRYC9ia1lKHi3E7EiTDW
        2yCqb4Tu1mrWJjSBz2GEpOoJbwKzo9p+tQsSY5nHKbGG7lras/7GxAN3+yC1MpLYRP9kOK
        KDP199KOEehJkYfpG76OSY/cYB/xuHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-AVTFlo_kOJ-Bh-4BiAJmjA-1; Wed, 15 Jan 2020 16:43:37 -0500
X-MC-Unique: AVTFlo_kOJ-Bh-4BiAJmjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA49D10054E3;
        Wed, 15 Jan 2020 21:43:36 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23D785C3F8;
        Wed, 15 Jan 2020 21:43:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 7/8] locking/lockdep: Add lockdep_early_init() before any lock is taken
Date:   Wed, 15 Jan 2020 16:43:12 -0500
Message-Id: <20200115214313.13253-8-longman@redhat.com>
In-Reply-To: <20200115214313.13253-1-longman@redhat.com>
References: <20200115214313.13253-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep_init() function is actually called after __lock_acquire()
has been called. So it is not a good place to do chain buckets
initialization. Fortunately, the check for nr_free_chain_hlocks prevents
those chain buckets from being used prematurely.

Add a lockdep_early_init() function that will be called very early in the
boot process and move chain buckets initialization over there to ensure
that the buckets are initialized before __lock_acquire() is called.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h  | 2 ++
 init/main.c              | 1 +
 kernel/locking/lockdep.c | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c50d01ef1414..efb1ec28a2cd 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -279,6 +279,7 @@ struct held_lock {
  * Initialization, self-test and debugging-output methods:
  */
 extern void lockdep_init(void);
+extern void lockdep_early_init(void);
 extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
@@ -432,6 +433,7 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 # define lock_set_class(l, n, k, s, i)		do { } while (0)
 # define lock_set_subclass(l, s, i)		do { } while (0)
 # define lockdep_init()				do { } while (0)
+# define lockdep_early_init()			do { } while (0)
 # define lockdep_init_map(lock, name, key, sub) \
 		do { (void)(name); (void)(key); } while (0)
 # define lockdep_set_class(lock, key)		do { (void)(key); } while (0)
diff --git a/init/main.c b/init/main.c
index 2cd736059416..571b83981276 100644
--- a/init/main.c
+++ b/init/main.c
@@ -580,6 +580,7 @@ asmlinkage __visible void __init start_kernel(void)
 	set_task_stack_end_magic(&init_task);
 	smp_setup_processor_id();
 	debug_objects_early_init();
+	lockdep_early_init();
 
 	cgroup_init_early();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a1d839e522a9..165e2361b25e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5382,10 +5382,13 @@ void lockdep_unregister_key(struct lock_class_key *key)
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
-void __init lockdep_init(void)
+void __init lockdep_early_init(void)
 {
 	init_chain_block_buckets();
+}
 
+void __init lockdep_init(void)
+{
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
 	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
-- 
2.18.1

