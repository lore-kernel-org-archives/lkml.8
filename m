Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FFB20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YXIQJPQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgAaPSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:18:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgAaPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=30tida9Rd+08SPvLTckNsi5mGIA6RIpiUmpqAkSABQk=; b=YXIQJPQtNdgdY31ldVfZyDD9ps
        lRAdJ4AMX0rZLJHNdefNKHFLuvUMbt3JdJFIO1o8SuLuOrij1yiHx/ODRUoLumuY8m0CqwqjFZTyZ
        mDPELJLbDOWx5OWhUGDguOOhp/FnnTvtzU08X6iOegehVj7hTvkPuTf2Wd0Sl6CeygZ2t3kzs+gmT
        fZE9xyIU2/AtdNWh5G17WcU1EwR31jnqAbGvg+EdgkDk5qC3h4E2H/OJrnJQoE7C1sjvMD0d+8Kcl
        m5kVOXGsqU/M7vhpTo2qthxX5bGMS+wb+4WmEI78Y68STph8dDsy4V8Ushml+6CWpnvmqiNjK3W04
        fFr31pbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixY3W-00045a-Uj; Fri, 31 Jan 2020 15:18:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6911B306368;
        Fri, 31 Jan 2020 16:16:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C50912B64DB7B; Fri, 31 Jan 2020 16:17:58 +0100 (CET)
Message-Id: <20200131151540.212415454@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 16:07:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH -v2 6/7] locking/percpu-rwsem: Fold __percpu_up_read()
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Now that __percpu_up_read() is only ever used from percpu_up_read()
merge them, it's a small function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/percpu-rwsem.h  |   19 +++++++++++++++----
 kernel/exit.c                 |    1 +
 kernel/locking/percpu-rwsem.c |   15 ---------------
 3 files changed, 16 insertions(+), 19 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -43,7 +43,6 @@ is_static struct percpu_rw_semaphore nam
 	__DEFINE_PERCPU_RWSEM(name, static)
 
 extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
-extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 {
@@ -103,10 +102,22 @@ static inline void percpu_up_read(struct
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	if (likely(rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss))) {
 		__this_cpu_dec(*sem->read_count);
-	else
-		__percpu_up_read(sem); /* Unconditional memory barrier */
+	} else {
+		/*
+		 * slowpath; reader will only ever wake a single blocked
+		 * writer.
+		 */
+		smp_mb(); /* B matches C */
+		/*
+		 * In other words, if they see our decrement (presumably to
+		 * aggregate zero, as that is the only time it matters) they
+		 * will also see our critical section.
+		 */
+		__this_cpu_dec(*sem->read_count);
+		rcuwait_wake_up(&sem->writer);
+	}
 	preempt_enable();
 }
 
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -258,6 +258,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 		wake_up_process(task);
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(rcuwait_wake_up);
 
 /*
  * Determine if a process group is "orphaned", according to the POSIX
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -177,21 +177,6 @@ bool __percpu_down_read(struct percpu_rw
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 
-void __percpu_up_read(struct percpu_rw_semaphore *sem)
-{
-	smp_mb(); /* B matches C */
-	/*
-	 * In other words, if they see our decrement (presumably to aggregate
-	 * zero, as that is the only time it matters) they will also see our
-	 * critical section.
-	 */
-	__this_cpu_dec(*sem->read_count);
-
-	/* Prod writer to re-evaluate readers_active_check() */
-	rcuwait_wake_up(&sem->writer);
-}
-EXPORT_SYMBOL_GPL(__percpu_up_read);
-
 #define per_cpu_sum(var)						\
 ({									\
 	typeof(var) __sum = 0;						\


