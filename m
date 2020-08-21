Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CECC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D749F207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpNpmZpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHUMQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHUMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:15:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E9C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gNQNeuldwYvEhnUT6Vp7qqu5Oil3zBmb4qHQ9rXDFhw=; b=lpNpmZprIeU4nhvrwOcKmT9zs8
        EE8My6voyxOQqqqb7aSC76GEnlE+5mFufbMQHWJdx6voaZVfp+s/lTN8ytZLhPemMhxkAdmkn7exw
        wI1ozo3W0k/TKQ27+Y4TidWIXhXiEVAaYs5oAG2VjjQ+jPYeUA0RobFmzui+NJdPRnQL/FmlY7ohU
        +0yJtToOatwzeDwi6snOCnmemus3gtK59rWV1cNH6tZXZtCT37a+/ZMNiTYIBgE1Eo1C7XdEREjni
        SwZN6b+3vU9fIlSUKzJpFa3vS2Zt+S4pHEW2gjWgI5yGNSB63lwdFtbXNZdZ8Ip5IfzHIh0GypWth
        Chz9f26A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k95x9-0000gT-3t; Fri, 21 Aug 2020 12:15:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC509301179;
        Fri, 21 Aug 2020 14:15:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 987C12B649914; Fri, 21 Aug 2020 14:15:25 +0200 (CEST)
Date:   Fri, 21 Aug 2020 14:15:25 +0200
From:   peterz@infradead.org
To:     Will Deacon <will@kernel.org>
Cc:     qiang.zhang@windriver.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Subject: Re: [PATCH] locking/percpu-rwsem: Remove WQ_FLAG_EXCLUSIVE flags
Message-ID: <20200821121525.GL1362448@hirez.programming.kicks-ass.net>
References: <20200701055720.38092-1-qiang.zhang@windriver.com>
 <20200821111343.GC20455@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821111343.GC20455@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:13:44PM +0100, Will Deacon wrote:
> On Wed, Jul 01, 2020 at 01:57:20PM +0800, qiang.zhang@windriver.com wrote:
> > From: Zqiang <qiang.zhang@windriver.com>
> > 
> > Remove WQ_FLAG_EXCLUSIVE from "wq_entry.flags", using function
> > __add_wait_queue_entry_tail_exclusive substitution.
> > 
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > ---
> >  kernel/locking/percpu-rwsem.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> > index 8bbafe3e5203..48e1c55c2e59 100644
> > --- a/kernel/locking/percpu-rwsem.c
> > +++ b/kernel/locking/percpu-rwsem.c
> > @@ -148,8 +148,8 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
> >  	 */
> >  	wait = !__percpu_rwsem_trylock(sem, reader);
> >  	if (wait) {
> > -		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
> > -		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
> > +		wq_entry.flags |= reader * WQ_FLAG_CUSTOM;
> > +		__add_wait_queue_entry_tail_exclusive(&sem->waiters, &wq_entry);
> >  	}
> >  	spin_unlock_irq(&sem->waiters.lock);
> 
> Seems straightforward enough:

Yeah, but I wonder why. Qiang, what made you write this patch?

afaict, there is only a single __add_wait_queue_entry_tail_exclusive()
user in the entire tree (two after this patch). I'm thinking it would be
much better to kill of that one user and remove the entire function.

something like the completely untested thing below, please double check.

---
diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 538e839590ef..b24e62e30822 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -80,17 +80,10 @@ static void put(struct slot_map *m, int slot)
 
 static int wait_for_free(struct slot_map *m)
 {
-	long left = slot_timeout_secs * HZ;
-	DEFINE_WAIT(wait);
+	long ret, left = slot_timeout_secs * HZ;
 
 	do {
-		long n = left, t;
-		if (likely(list_empty(&wait.entry)))
-			__add_wait_queue_entry_tail_exclusive(&m->q, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (m->c > 0)
-			break;
+		long n = left;
 
 		if (m->c < 0) {
 			/* we are waiting for map to be installed */
@@ -98,27 +91,31 @@ static int wait_for_free(struct slot_map *m)
 			if (n > ORANGEFS_BUFMAP_WAIT_TIMEOUT_SECS * HZ)
 				n = ORANGEFS_BUFMAP_WAIT_TIMEOUT_SECS * HZ;
 		}
-		spin_unlock(&m->q.lock);
-		t = schedule_timeout(n);
-		spin_lock(&m->q.lock);
-		if (unlikely(!t) && n != left && m->c < 0)
-			left = t;
-		else
-			left = t + (left - n);
-		if (signal_pending(current))
-			left = -EINTR;
-	} while (left > 0);
 
-	if (!list_empty(&wait.entry))
-		list_del(&wait.entry);
-	else if (left <= 0 && waitqueue_active(&m->q))
-		__wake_up_locked_key(&m->q, TASK_INTERRUPTIBLE, NULL);
-	__set_current_state(TASK_RUNNING);
+		ret = ___wait_event(m->q, m->c > 0, TASK_INTERRUPTIBLE, 1, n,
+
+				    spin_unlock(&m->lock);
+				    __ret = schedule_timeout(__ret);
+				    spin_lock(&m->lock);
+
+				   );
 
-	if (likely(left > 0))
+		if (ret) /* @cond := true || -ERESTARTSYS */
+			break;
+
+		left -= n;
+	} while (left > 0);
+
+	if (!ret)
 		return 0;
 
-	return left < 0 ? -EINTR : -ETIMEDOUT;
+	if (ret < 0) {
+		if (waitqueue_active(&w->q))
+			__wake_up_locked_key(&m->q, TASK_INTERRUPTIBLE, NULL);
+		return -EINTR;
+	}
+
+	return -ETIMEDOUT;
 }
 
 static int get(struct slot_map *m)
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 898c890fc153..841ef9ef15d9 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -185,13 +185,6 @@ static inline void __add_wait_queue_entry_tail(struct wait_queue_head *wq_head,
 	list_add_tail(&wq_entry->entry, &wq_head->head);
 }
 
-static inline void
-__add_wait_queue_entry_tail_exclusive(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry)
-{
-	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue_entry_tail(wq_head, wq_entry);
-}
-
 static inline void
 __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry)
 {
