Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4C5C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F28920661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GIcRbrUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgAaPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:18:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgAaPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W74jZS6NHWwWXmbIhIvEE6wcbSBoEXWBaSK4lLa9J88=; b=GIcRbrUd48ds2nQD0dR7D+/cnh
        iVWv0CEXI9sNMMHuDtm6D86GidmWl33ZQpxbA3PfidF3j7V8hUu/8ehqtCFlcT30QJxnPbuP+woOl
        CjWeUoyS74B4UKDPqm66eMycQ2GC6rHJ0sKLTkX8DSJmvVxMUSBxz0EX3y6+Jhx2hqiV/pHt5emzY
        epuSnXZMFWDhbZ14QmF92Dh7f3/+vPGZvtbmmQ9SWCk4k3f9AKdVzV/sUBCsSgesIUMZIETI4hNEy
        gwdh2OhC7L94h6DlqLuZCYumiNQxP/muFvtN6yydSQWhYqLrqwlyPkoxaD5jW6dZih/3SNl4O6hJj
        4tjyPTlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixY3V-00045R-7d; Fri, 31 Jan 2020 15:18:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00608305D3F;
        Fri, 31 Jan 2020 16:16:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B6BD02B4C4263; Fri, 31 Jan 2020 16:17:58 +0100 (CET)
Message-Id: <20200131151539.984626569@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 16:07:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH -v2 2/7] locking/percpu-rwsem: Convert to bool
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bool where possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/percpu-rwsem.h  |    6 +++---
 kernel/locking/percpu-rwsem.c |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -41,7 +41,7 @@ is_static struct percpu_rw_semaphore nam
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
-extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
+extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
 extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
@@ -69,9 +69,9 @@ static inline void percpu_down_read(stru
 	preempt_enable();
 }
 
-static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
+static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	int ret = 1;
+	bool ret = true;
 
 	preempt_disable();
 	/*
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ void percpu_free_rwsem(struct percpu_rw_
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	/*
 	 * Due to having preemption disabled the decrement happens on
@@ -69,7 +69,7 @@ int __percpu_down_read(struct percpu_rw_
 	 * release in percpu_up_write().
 	 */
 	if (likely(!smp_load_acquire(&sem->readers_block)))
-		return 1;
+		return true;
 
 	/*
 	 * Per the above comment; we still have preemption disabled and
@@ -78,7 +78,7 @@ int __percpu_down_read(struct percpu_rw_
 	__percpu_up_read(sem);
 
 	if (try)
-		return 0;
+		return false;
 
 	/*
 	 * We either call schedule() in the wait, or we'll fall through
@@ -94,7 +94,7 @@ int __percpu_down_read(struct percpu_rw_
 	__up_read(&sem->rw_sem);
 
 	preempt_disable();
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 


