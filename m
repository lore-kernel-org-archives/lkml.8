Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189DDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC36620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580495563;
	bh=aSo9PawRW0VeIAlFXUcKr/vu2eg7cH600lHWwdQZ2lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zUQH2o1ysUEp+BC5YG0jq19/8QoYDLcUFiMNaqRlpTEns9mknIIx86eafCeeiyfdl
	 BYVAX2dU5ttxU9WLDQe1tqlr9zHmym1qc5Yt/+Dcz0BfsFLuTe0Dt+L0KLEhjfjvLq
	 WIUkqL8ZvPL3IMuH4DnnZsgafbKN89kKUHPHqhKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgAaScn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgAaScm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:32:42 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 748AF206F0;
        Fri, 31 Jan 2020 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580495561;
        bh=aSo9PawRW0VeIAlFXUcKr/vu2eg7cH600lHWwdQZ2lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsGaYS3MSHO6IuCIbex/e9imcWyDfmuFfV8T5mtCsLP0UqaDJSsK2xF6CmQ3AJ6eK
         sRxSbZrdYGzJWJMfpccThuoGk4WAv08QsqveX/DlMjJ0tJxaP0QMnsqL6GkVhSjZNb
         QKBbSNOLUU1Rnd2PDXFIHVjwFoKI8YFhLdi4orSE=
Date:   Fri, 31 Jan 2020 18:32:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131183236.GA6159@willie-the-truck>
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131165718.GA5517@willie-the-truck>
 <CANn89iKmSBPKJGw--WaJJhCdu2wz2aq-ve+E8z=gfsYj6Zom_A@mail.gmail.com>
 <20200131172058.GB5517@willie-the-truck>
 <CANn89iJNgPOzCdc-7QoC+dawJVn7tLQxmrx58GL8PT9rDVT2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJNgPOzCdc-7QoC+dawJVn7tLQxmrx58GL8PT9rDVT2hA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:33:55AM -0800, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 9:21 AM Will Deacon <will@kernel.org> wrote:
> > On Fri, Jan 31, 2020 at 09:06:27AM -0800, Eric Dumazet wrote:
> > > Sorry, but timer_pending() requires no serialization.
> >
> > Then we should update the comment!
> 
> Which one ?
> 
> It seems KCSAN does not read the comments :)

Haha, that would be nice wouldn't it?

> > Without serialisation, timer_pending() as currently implemented does
> > not reliably tell you whether the timer is in the hlist. Is that not a
> > problem?
> 
> No it is not a problem.
> 
> However some callers might have incorrect assumptions, I have not
> audited all the code.

Of course not, I'm just interested in what correct callers are allowed
to assume.

>  Using an RCU hlist does not introduce serialisation, but does
> > at least rule out the case where timer_pending() returns false for a
> > timer that /is/ reachable in the list by another CPU.
> >
> > > The only thing we need is a READ_ONCE() so that compiler is not allowed
> > > to optimize out stuff like
> > >
> > > loop() {
> > >    if (timer_pending())
> > >       something;
> >
> > If that was the case, then you wouldn't need to touch hlist_add_before()
> > at all so there's got to be more to it than that or we can revert that
> > part of the patch.
> 
> Sorry, I do not get your point. It would help if you provide a patch
> or something.

Ok, diff below. If I've understood you correctly (big if ;), then I think
it's sufficient. The idea is that you have to explicitly annotate your code
as a data race if you're trying to use the non-RCU list implementation in a
lock-free fashion.

Will

--->8

diff --git a/include/linux/list.h b/include/linux/list.h
index 884216db3246..74c78017332e 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -810,7 +810,7 @@ static inline void __hlist_del(struct hlist_node *n)
 
 	WRITE_ONCE(*pprev, next);
 	if (next)
-		WRITE_ONCE(next->pprev, pprev);
+		next->pprev = pprev;
 }
 
 /**
@@ -852,11 +852,11 @@ static inline void hlist_del_init(struct hlist_node *n)
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
-	WRITE_ONCE(n->next, first);
+	n->next = first;
 	if (first)
-		WRITE_ONCE(first->pprev, &n->next);
+		first->pprev = &n->next;
 	WRITE_ONCE(h->first, n);
-	WRITE_ONCE(n->pprev, &h->first);
+	n->pprev = &h->first;
 }
 
 /**
@@ -867,9 +867,9 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 static inline void hlist_add_before(struct hlist_node *n,
 				    struct hlist_node *next)
 {
-	WRITE_ONCE(n->pprev, next->pprev);
-	WRITE_ONCE(n->next, next);
-	WRITE_ONCE(next->pprev, &n->next);
+	n->pprev = next->pprev;
+	n->next = next;
+	next->pprev = &n->next;
 	WRITE_ONCE(*(n->pprev), n);
 }
 
@@ -881,12 +881,12 @@ static inline void hlist_add_before(struct hlist_node *n,
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
-	WRITE_ONCE(n->next, prev->next);
-	WRITE_ONCE(prev->next, n);
-	WRITE_ONCE(n->pprev, &prev->next);
+	n->next = prev->next;
+	prev->next = n;
+	n->pprev = &prev->next;
 
 	if (n->next)
-		WRITE_ONCE(n->next->pprev, &n->next);
+		n->next->pprev  = &n->next;
 }
 
 /**
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650ed066d..53c3b3bc00f0 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -158,13 +158,14 @@ static inline void destroy_timer_on_stack(struct timer_list *timer) { }
  *
  * timer_pending will tell whether a given timer is currently pending,
  * or not. Callers must ensure serialization wrt. other operations done
- * to this timer, eg. interrupt contexts, or other CPUs on SMP.
+ * to this timer, eg. interrupt contexts, or other CPUs on SMP if they
+ * cannot tolerate spurious results.
  *
  * return value: 1 if the timer is pending, 0 if not.
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->entry.pprev != NULL;
+	return !data_race(hlist_unhashed_lockless(&timer->entry));
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
