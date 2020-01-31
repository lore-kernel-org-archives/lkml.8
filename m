Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49335C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E1320663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lbx0o/hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgAaQsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:48:18 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39000 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgAaQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:48:18 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so5317615ywc.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FStIY2/08JbrIY8f3GxrQrXyoMbYm8zv42KLiEUyb2Y=;
        b=Lbx0o/hqZc/f2IRTVwsLyoYKtxswAA0b0C92LXok5bruJBgR7GOWxi2smv2bZCNfs4
         bma668OoSlksLEXxe7CCok46i11OlbNFLPsQYxKxH6TCq/kv4ocmWMBeIUUIq9dQO9Lc
         cYw/DTkYeVyfGXTSur7ZcWP106rBIQNfBsUw2z0n0psn9UKG/fuhyp7kCHqj8oenHszQ
         k0u9Tqb9fndheQazRKi38I9J1Bsm5PxZDexaxlt639LVsTUXPm3QLIteoVDbXn2pHT01
         ACAAQNwfRNYjnFNLKvZXfWWb4RL6RaI25seWZRacbj3n37/Av9FciAmmmx+Nll3JLGIZ
         m6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FStIY2/08JbrIY8f3GxrQrXyoMbYm8zv42KLiEUyb2Y=;
        b=lsl2fYSvD09nfPVGfC5+43aCNrhu6hnWpxXe/vFYj+tOtBvU/q/fJc9IT8ZmH3YZ/0
         P4Y5V0qqmvEhPidQyONEA5nAZRwnn9LIRqX8SIc8qXkMbwVLzohDMNiQMrPo878viKHT
         i0UXzRcW0a55CYIBy8SPN5M+2oVmiJeR2DzntX9zmAOb12ZOStlJep+G20RhgDhLR0Xm
         j9G04XQIwpTUh8Xq6P+XdiD35e0NluIZzPNRk/5GpIeX+tmiMzqaa0OeOkdHCmT8v3ac
         nfBN4WFe9JARmjvw6dzRaDVrx5Y6Rui5emii1bsZkKL8Bb2tfHDMjv550JWM5Kngteya
         XD2Q==
X-Gm-Message-State: APjAAAX4Z3nUhumx4bDUMFSVmGe0PCZKrnrSMOrytAcKhGLSj192hk/O
        xq+Pj1oFly2ysVVja3ZFgdILNaJ66eArUgXeegAOsQ==
X-Google-Smtp-Source: APXvYqyvyGReVEKAbrrNdb/iIM9t8fuP9A0RNHiXB81RLD5bRwcgC9Og5cZSRNQKXK1G3il3Lm6CuvQXrruw0tr53Xo=
X-Received: by 2002:a5b:489:: with SMTP id n9mr8832128ybp.395.1580489296249;
 Fri, 31 Jan 2020 08:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck>
In-Reply-To: <20200131164308.GA5175@willie-the-truck>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 08:48:05 -0800
Message-ID: <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 8:43 AM Will Deacon <will@kernel.org> wrote:
>
> Hi folks,
>
> I just ran into c54a2744497d ("list: Add hlist_unhashed_lockless()")
> but I'm a bit confused about what it's trying to achieve. It also seems
> to have been merged without any callers (even in -next) -- was that
> intentional?
>
> My main source of confusion is the lack of memory barriers. For example,
> if you look at the following pair of functions:
>
>
> static inline int hlist_unhashed_lockless(const struct hlist_node *h)
> {
>         return !READ_ONCE(h->pprev);
> }
>
> static inline void hlist_add_before(struct hlist_node *n,
>                                     struct hlist_node *next)
> {
>         WRITE_ONCE(n->pprev, next->pprev);
>         WRITE_ONCE(n->next, next);
>         WRITE_ONCE(next->pprev, &n->next);
>         WRITE_ONCE(*(n->pprev), n);
> }
>
>
> Then running these two concurrently on the same node means that
> hlist_unhashed_lockless() doesn't really tell you anything about whether
> or not the node is reachable in the list (i.e. there is another node
> with a next pointer pointing to it). In other words, I think all of
> these outcomes are permitted:
>
>         hlist_unhashed_lockless(n)      n reachable in list
>         0                               0 (No reordering)
>         0                               1 (No reordering)
>         1                               0 (No reordering)
>         1                               1 (Reorder first and last WRITE_ONCEs)
>
> So I must be missing some details about the use-case here. Please could
> you enlighten me? The RCU implementation permits only the first three
> outcomes afaict, why not use that and leave non-RCU hlist as it was?
>

I guess the following has been lost :

Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Nov 7 11:23:14 2019 -0800

    timer: use hlist_unhashed_lockless() in timer_pending()

    timer_pending() is mostly used in lockless contexts.

    Without proper annotations, KCSAN might detect a data-race [1]

    Using hlist_unhashed_lockless() instead of hand-coding it
    seems appropriate (as suggested by Paul E. McKenney).

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
    Cc: "Paul E. McKenney" <paulmck@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650ed066d5d28251b0bd385fc37ef94c96532..0dc19a8c39c9e49a7cde3d34bfa4be8871cbc1c2
100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct
timer_list *timer) { }
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
- return timer->entry.pprev != NULL;
+ return !hlist_unhashed_lockless(&timer->entry);
 }
