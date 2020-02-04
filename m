Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509EBC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B9C2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ACiGrEqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgBDJWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:22:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgBDJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9M17iibfv122ur1ks8I+I3t1ou4sPRJVkTsCZX95FVI=; b=ACiGrEqV2DKuGLBrlG3vRt6K52
        pmqg1KMBRD0Sksuzj4Aap9wld4vgPp9QXmAqYDrwECIL4P3oouRx7TjusqLQC0o76WInJU/TW4XqD
        gZsVSlenLs738F4o9c29o9L9WBLIwqMfdk7eHn3EqDswQhcvMubNTwVES7TDHsFgk8unV3BxbztC8
        RzxlXtrkRyQIeLkgXyo2/j0GqQiSIXayWNf3f1QrJe+Bxgg7c48W57GqTK/VrItlkLJ2QqkZW81AU
        xBALJxq96Xubg1ZjDZOrsUy+A5u0OsoRa2FeoK3fONW09clHdIRkFNT0tDiXcZRn/KuDpRJQDpUHo
        WXkAK5Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyuPe-0008Mr-RQ; Tue, 04 Feb 2020 09:22:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 624BA300E0C;
        Tue,  4 Feb 2020 10:20:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF68A203A89B2; Tue,  4 Feb 2020 10:22:28 +0100 (CET)
Date:   Tue, 4 Feb 2020 10:22:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH] locking/rwsem: Remove RWSEM_OWNER_UNKNOWN
Message-ID: <20200204092228.GP14946@hirez.programming.kicks-ass.net>
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
 <20200203142050.GA28595@infradead.org>
 <20200203150933.GJ14914@hirez.programming.kicks-ass.net>
 <20200203174831.GA9834@infradead.org>
 <20200204085049.GN14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204085049.GN14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 09:50:49AM +0100, Peter Zijlstra wrote:

> Anyway, I'll go split, since you seem to care so deeply.

---

Subject: locking/rwsem: Remove RWSEM_OWNER_UNKNOWN
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Feb  4 09:34:37 CET 2020

Remove the now unused RWSEM_OWNER_UNKNOWN hack. This hack breaks
PREEMPT_RT and getting rid of it was the entire motivation for
re-writing the percpu rwsem.

The biggest problem is that it is fundamentally incompatible with any
form of Priority Inheritance, any exclusively held lock must have a
distinct owner.

Requested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rwsem.h  |    6 ------
 kernel/locking/rwsem.c |    2 --
 2 files changed, 8 deletions(-)

--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -53,12 +53,6 @@ struct rw_semaphore {
 #endif
 };
 
-/*
- * Setting all bits of the owner field except bit 0 will indicate
- * that the rwsem is writer-owned with an unknown owner.
- */
-#define RWSEM_OWNER_UNKNOWN	(-2L)
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -659,8 +659,6 @@ static inline bool rwsem_can_spin_on_own
 	unsigned long flags;
 	bool ret = true;
 
-	BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & RWSEM_NONSPINNABLE));
-
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
 		return false;
