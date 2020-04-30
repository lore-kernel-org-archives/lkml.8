Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCEC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB122073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="roT+p3ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgD3I1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726543AbgD3I1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:27:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B8AC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/DD4SwkH4dIKud6UgQC7/3WcU8JrYSfWRgnUCQdVtY=; b=roT+p3ewK+JSVtLy4iBWyzQ9zA
        VWIpvFAOMCg8lGWrw9jw/agjv34+Z2ZL36EAfiVCYAcPHhImLhl7IcwtiDSHXLQ6Y9XRMC9z9vEO6
        dL9acsSjpkXK5AIfYtXI9wrgeAUN5xpNUEZ8h36l2Sbn8oHWgOh/1xK/pGeeTb/qABuk3Wzlp/GKi
        geRvFKk9DO95HJeNzGTMsVikVEh/5spoEYMPqMala5Q0hOdweVfDRew1LK20xlNCInP4BOadpZZdU
        oe9WpeekexrNvAE2/0S0OcYSBt8kzqWnyl/hEgA4RqiIwuGCyVfBfnZwS1BIS32jDBOfHGEvi871t
        SAmH3u9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jU4Xa-0007cs-0d; Thu, 30 Apr 2020 08:27:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A44F8301224;
        Thu, 30 Apr 2020 10:27:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F7C9213923B9; Thu, 30 Apr 2020 10:27:27 +0200 (CEST)
Date:   Thu, 30 Apr 2020 10:27:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, irogers@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
Message-ID: <20200430082727.GP13592@hirez.programming.kicks-ass.net>
References: <20200429153258.563269446@infradead.org>
 <20200429153549.006661686@infradead.org>
 <20200430072847.GA68379@localhost.localdomain>
 <CANN689FBczsBm=bYPfs1saUEeUq+oxLWnr8xfwtOstQkvJmwOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689FBczsBm=bYPfs1saUEeUq+oxLWnr8xfwtOstQkvJmwOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:51:02AM -0700, Michel Lespinasse wrote:
> On Thu, Apr 30, 2020 at 12:28 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> > > --- a/include/linux/rbtree.h
> > > +++ b/include/linux/rbtree.h
> > > @@ -141,12 +141,18 @@ static inline void rb_insert_color_cache
> > >       rb_insert_color(node, &root->rb_root);
> > >  }
> > >
> > > -static inline void rb_erase_cached(struct rb_node *node,
> > > +static inline bool rb_erase_cached(struct rb_node *node,
> > >                                  struct rb_root_cached *root)
> > >  {
> > > -     if (root->rb_leftmost == node)
> > > +     bool leftmost = false;
> > > +
> > > +     if (root->rb_leftmost == node) {
> > >               root->rb_leftmost = rb_next(node);
> >
> > Think we need
> >
> >  if (root->rb_leftmost)
> >
> > > +             leftmost = true;
> >
> > DEADLINE crashes w/o that.

Clearly boot testing doesn't cover that..

> I think Peter's code is correct; after removing the only node in an
> rbtree rb_leftmost should be NULL.
> 
> The issue appears to be in dequeue_pushable_dl_task unconditionally
> dereferencing the pointer returned by rb_first_cached(), which may be
> NULL.

Oh right.. silly me.

So yes, those rb_add_cached() / rb_erase_cached() return values are
(currently) only used by deadline. Deadline keeps a leftmost based value
cache and 'needs' this signal to update it; I can imagine there being
others, I didn't look at the many (~70) other users of
rb_erase_cached().

I briefly considered having rb_erase_cached() return the 'struct rb_node
*' of the new leftmost; that would naturally return NULL for the empty
tree. Maybe I should still do that -- see below.

Another thing I noticed is that I'm inconsistend with argument order;
rb_erase_cached(node, tree) vs rb_add_cached(tree, node). I'll go make
the new stuff use the 'wrong' order stuff too.


---
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -141,8 +141,8 @@ static inline void rb_insert_color_cache
 	rb_insert_color(node, &root->rb_root);
 }
 
-static inline bool rb_erase_cached(struct rb_node *node,
-				   struct rb_root_cached *root)
+static inline struct rb_node *
+rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
 {
 	bool leftmost = false;
 
@@ -152,7 +152,7 @@ static inline bool rb_erase_cached(struc
 	}
 	rb_erase(node, &root->rb_root);
 
-	return leftmost;
+	return leftmost ? root->rb_leftmost : NULL;
 }
 
 static inline void rb_replace_node_cached(struct rb_node *victim,
@@ -164,8 +164,9 @@ static inline void rb_replace_node_cache
 	rb_replace_node(victim, new, &root->rb_root);
 }
 
-static inline bool rb_add_cached(struct rb_root_cached *tree, struct rb_node *node,
-				 bool (*less)(struct rb_node *, const struct rb_node *))
+static inline struct rb_node *
+rb_add_cached(struct rb_root_cached *tree, struct rb_node *node, bool
+	      (*less)(struct rb_node *, const struct rb_node *))
 {
 	struct rb_node **link = &tree->rb_root.rb_node;
 	struct rb_node *parent = NULL;
@@ -184,7 +185,7 @@ static inline bool rb_add_cached(struct
 	rb_link_node(node, parent, link);
 	rb_insert_color_cached(node, tree, leftmost);
 
-	return leftmost;
+	return leftmost ? node : NULL;
 }
 
 static inline void rb_add(struct rb_root *tree, struct rb_node *node,
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -454,10 +454,14 @@ static inline bool __pushable_less(struc
  */
 static void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
+	struct rb_node *leftmost;
+
 	BUG_ON(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
 
-	if (rb_add_cached(&rq->dl.pushable_dl_tasks_root, &p->pushable_dl_tasks,
-			  __pushable_less))
+	leftmost = rb_add_cached(&rq->dl.pushable_dl_tasks_root,
+				 &p->pushable_dl_tasks,
+				 __pushable_less);
+	if (leftmost)
 		rq->dl.earliest_dl.next = p->dl.deadline;
 }
 
@@ -465,12 +469,14 @@ static void dequeue_pushable_dl_task(str
 {
 	struct dl_rq *dl_rq = &rq->dl;
 	struct rb_root_cached *root = &dl_rq->pushable_dl_tasks_root;
+	struct rb_node *leftmost;
 
 	if (RB_EMPTY_NODE(&p->pushable_dl_tasks))
 		return;
 
-	if (rb_erase_cached(&p->pushable_dl_tasks, root))
-		dl_rq->earliest_dl.next = __node_2_pdl(rb_first_cached(root))->dl.deadline;
+	leftmost = rb_erase_cached(&p->pushable_dl_tasks, root);
+	if (leftmost)
+		dl_rq->earliest_dl.next = __node_2_pdl(leftmost)->dl.deadline;
 
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 }
