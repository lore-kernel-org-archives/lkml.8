Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCE620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580496772;
	bh=Twp0VuTf/yMNO0lE/mZOS9rAZmExW1+ss30q9yUNPLM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=w3wSpG56t3puMEj0dELoz4fD3YEgwlD1BGGDzMuuN12TjyuIJuy9Cpj67YxRbbkdX
	 JSuLFnuHBP/9q84hXTtcP58Y0BH56IlJ7I/m0Xd/XUkBlSdsKYyDm06rJ8bgRNBXIE
	 LGjuH4sDYqH7aM1dTNO/IW7RBKnM0h0oChU1SKec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgAaSwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgAaSwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:52:51 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4827920707;
        Fri, 31 Jan 2020 18:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580496770;
        bh=Twp0VuTf/yMNO0lE/mZOS9rAZmExW1+ss30q9yUNPLM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vo3sVV8/tKC9mGUfFL6hQ0Vr37CcH1bmRwKUhEnXBxoZxT/eTaf0Ork1Fxo92fzBL
         wsoWOwsQ7w+WYLyLjSLSq9QsDi1EzpKPET8StbXNFp1+WyxmNPcyF9HHqovn3T4Dep
         kaVohgpW1e3s37V3W8mS6z8cZVLAMe5ql+QDgBV4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C13E23522722; Fri, 31 Jan 2020 10:52:49 -0800 (PST)
Date:   Fri, 31 Jan 2020 10:52:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131185249.GR2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 8:43 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi folks,
> >
> > I just ran into c54a2744497d ("list: Add hlist_unhashed_lockless()")
> > but I'm a bit confused about what it's trying to achieve. It also seems
> > to have been merged without any callers (even in -next) -- was that
> > intentional?
> >
> > My main source of confusion is the lack of memory barriers. For example,
> > if you look at the following pair of functions:
> >
> >
> > static inline int hlist_unhashed_lockless(const struct hlist_node *h)
> > {
> >         return !READ_ONCE(h->pprev);
> > }
> >
> > static inline void hlist_add_before(struct hlist_node *n,
> >                                     struct hlist_node *next)
> > {
> >         WRITE_ONCE(n->pprev, next->pprev);
> >         WRITE_ONCE(n->next, next);
> >         WRITE_ONCE(next->pprev, &n->next);
> >         WRITE_ONCE(*(n->pprev), n);
> > }
> >
> >
> > Then running these two concurrently on the same node means that
> > hlist_unhashed_lockless() doesn't really tell you anything about whether
> > or not the node is reachable in the list (i.e. there is another node
> > with a next pointer pointing to it). In other words, I think all of
> > these outcomes are permitted:
> >
> >         hlist_unhashed_lockless(n)      n reachable in list
> >         0                               0 (No reordering)
> >         0                               1 (No reordering)
> >         1                               0 (No reordering)
> >         1                               1 (Reorder first and last WRITE_ONCEs)
> >
> > So I must be missing some details about the use-case here. Please could
> > you enlighten me? The RCU implementation permits only the first three
> > outcomes afaict, why not use that and leave non-RCU hlist as it was?
> 
> I guess the following has been lost :

4d3d2ae81afd ("timer: Use hlist_unhashed_lockless() in timer_pending()")
in -rcu, slated for not this merge window but the next one.  And
including the changes in your later email, Eric.  Please see below
and let me know whether you are OK with it.

							Thanx, Paul

------------------------------------------------------------------------

commit 4d3d2ae81afd9d13394f255e3e1b974f5f9bd2e3
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Nov 7 11:37:38 2019 -0800

    timer: Use hlist_unhashed_lockless() in timer_pending()
    
    The timer_pending() function is mostly used in lockless contexts, so
    Without proper annotations, KCSAN might detect a data-race [1].
    
    Using hlist_unhashed_lockless() instead of hand-coding it seems
    appropriate (as suggested by Paul E. McKenney).
    
    [1]
    
    BUG: KCSAN: data-race in del_timer / detach_if_pending
    
    write to 0xffff88808697d870 of 8 bytes by task 10 on cpu 0:
     __hlist_del include/linux/list.h:764 [inline]
     detach_timer kernel/time/timer.c:815 [inline]
     detach_if_pending+0xcd/0x2d0 kernel/time/timer.c:832
     try_to_del_timer_sync+0x60/0xb0 kernel/time/timer.c:1226
     del_timer_sync+0x6b/0xa0 kernel/time/timer.c:1365
     schedule_timeout+0x2d2/0x6e0 kernel/time/timer.c:1896
     rcu_gp_fqs_loop+0x37c/0x580 kernel/rcu/tree.c:1639
     rcu_gp_kthread+0x143/0x230 kernel/rcu/tree.c:1799
     kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
    
    read to 0xffff88808697d870 of 8 bytes by task 12060 on cpu 1:
     del_timer+0x3b/0xb0 kernel/time/timer.c:1198
     sk_stop_timer+0x25/0x60 net/core/sock.c:2845
     inet_csk_clear_xmit_timers+0x69/0xa0 net/ipv4/inet_connection_sock.c:523
     tcp_clear_xmit_timers include/net/tcp.h:606 [inline]
     tcp_v4_destroy_sock+0xa3/0x3f0 net/ipv4/tcp_ipv4.c:2096
     inet_csk_destroy_sock+0xf4/0x250 net/ipv4/inet_connection_sock.c:836
     tcp_close+0x6f3/0x970 net/ipv4/tcp.c:2497
     inet_release+0x86/0x100 net/ipv4/af_inet.c:427
     __sock_release+0x85/0x160 net/socket.c:590
     sock_close+0x24/0x30 net/socket.c:1268
     __fput+0x1e1/0x520 fs/file_table.c:280
     ____fput+0x1f/0x30 fs/file_table.c:313
     task_work_run+0xf6/0x130 kernel/task_work.c:113
     tracehook_notify_resume include/linux/tracehook.h:188 [inline]
     exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:163
    
    Reported by Kernel Concurrency Sanitizer on:
    CPU: 1 PID: 12060 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
    Hardware name: Google Google Compute Engine/Google Compute Engine,
    
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    [ paulmck: Pulled in Eric's later amendments. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650e..0dc19a8 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct timer_list *timer) { }
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->entry.pprev != NULL;
+	return !hlist_unhashed_lockless(&timer->entry);
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823..568564a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -944,6 +944,7 @@ static struct timer_base *lock_timer_base(struct timer_list *timer,
 
 #define MOD_TIMER_PENDING_ONLY		0x01
 #define MOD_TIMER_REDUCE		0x02
+#define MOD_TIMER_NOTPENDING		0x04
 
 static inline int
 __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int options)
@@ -960,7 +961,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	 * the timer is re-modified to have the same timeout or ends up in the
 	 * same array bucket then just return:
 	 */
-	if (timer_pending(timer)) {
+	if (!(options & MOD_TIMER_NOTPENDING) && timer_pending(timer)) {
 		/*
 		 * The downside of this optimization is that it can result in
 		 * larger granularity than you would get from adding a new
@@ -1133,7 +1134,7 @@ EXPORT_SYMBOL(timer_reduce);
 void add_timer(struct timer_list *timer)
 {
 	BUG_ON(timer_pending(timer));
-	mod_timer(timer, timer->expires);
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
 
@@ -1891,7 +1892,7 @@ signed long __sched schedule_timeout(signed long timeout)
 
 	timer.task = current;
 	timer_setup_on_stack(&timer.timer, process_timeout, 0);
-	__mod_timer(&timer.timer, expire, 0);
+	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
 	schedule();
 	del_singleshot_timer_sync(&timer.timer);
 
