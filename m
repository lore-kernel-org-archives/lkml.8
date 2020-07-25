Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F458206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuCaR7FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGYPR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 11:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 11:17:56 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28CC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 08:17:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id l27so2047124oti.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltOnyPTnPyHESFo1zHjbKU6HFj1ufxds9tDCUi8zQHY=;
        b=iuCaR7FLbvbnazxWMnHzm2AEJNsQ5xNqhTnmUZhKxIG+ioDjLWk5nLQ/Eej2qMVnHt
         dGcaztqvZxqe9+USxE+2LewfUyRwa2PdfKAElrheS6Zu1YFpAR3b5IiwK0E0TFw1YOsY
         ecQhOKZJujhX7jvOCR2lWJwNbyOXcr9RqAuE4XyX55ZGWifeGWf9ckGq8y9rkmB4/Fvy
         FWTvOiZcj1iqtJTCUJFjE0tdV3sW/LfRNOasIjT842Fp43pg1rAyZdt65SEF3YljOR89
         i/Ik40vsp3mxiM0u8hKFTuFcAGhS6W5mhUsQ14vUXxlNZrUpfTQVP1Snx9pG2mrGg/yw
         9/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltOnyPTnPyHESFo1zHjbKU6HFj1ufxds9tDCUi8zQHY=;
        b=Wo/MpdChRtzeVgCIcquf3L7wGG/9CKmyocjQ6uJuCzGXcy8s1xTok1WhdvHnxdJ1Vy
         GVk8el653e3QFQ7qWzRPYzKA855xW8eKUL3R0fNi9oNb45DrWOPeSNGT6KjFT1oUO3RU
         7q9PNQFEtCgb8nF6ACQB0DNjE5xE/Ed4PWGGrEXqrQi1xkA/805lao1me0SfpaCzOD0h
         Hd54EwANI2dd92set+45Jw4//pkMN2tVU4qIdgjLvipr4wifSgZ0p/kAp7qHkI968j/D
         WJrU7IMxCeOMry59eVeei9KQ7ALI+65SjkECOX4WVi6rI6caNIORbnTw01p0hRrrlpAW
         8Mog==
X-Gm-Message-State: AOAM531zHNMXj1uXR+8UAOZapxVJ9Z2NflBmGctMfbU1MyN7+AnqyZTn
        U7mF7WfuwbjX3fYHikPO0m+VtrCzcIkm08fu7gu+Yg==
X-Google-Smtp-Source: ABdhPJw6jDQBM+jdnY9VEZlalEJuf+lfgwJa+JTJa7gk4YDwdfWs+xzxpeKXgDQFAAHKBOSB+kZrRAvCcZngMSlFfkM=
X-Received: by 2002:a9d:4b01:: with SMTP id q1mr14243995otf.17.1595690275384;
 Sat, 25 Jul 2020 08:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200220141551.166537-1-elver@google.com> <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com> <20200725145623.GZ9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200725145623.GZ9247@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Sat, 25 Jul 2020 17:17:43 +0200
Message-ID: <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Peter]

On Sat, 25 Jul 2020 at 16:56, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Feb 20, 2020 at 10:33:17PM +0100, Marco Elver wrote:
> > On Thu, 20 Feb 2020, Paul E. McKenney wrote:
>
> I am clearly not keeping up...  :-/

Not to worry, I think the local_t idea was discarded based on Peter's
feedback anyway at one point.

> > > On Thu, Feb 20, 2020 at 03:15:51PM +0100, Marco Elver wrote:
> > > > Add option to allow interrupts while a watchpoint is set up. This can be
> > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > > parameter 'kcsan.interrupt_watcher=1'.
[...]
> > > > As an example, the first data race that this found:
> > > >
> > > > write to 0xffff88806b3324b8 of 4 bytes by interrupt on cpu 0:
> > > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]
> > > >  __rcu_read_lock+0x3c/0x50 kernel/rcu/tree_plugin.h:373
[...]
> > > > read to 0xffff88806b3324b8 of 4 bytes by task 6131 on cpu 0:       |
> > > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  ----+
[...]
> > > >
> > > > The writer is doing 'current->rcu_read_lock_nesting++'. The read is as
> > > > vulnerable to compiler optimizations and would therefore conclude this
> > > > is a valid data race.
> > >
> > > Heh!  That one is a fun one!  It is on a very hot fastpath.  READ_ONCE()
> > > and WRITE_ONCE() are likely to be measurable at the system level.
> > >
> > > Thoughts on other options?
> >
> > Would this be a use-case for local_t? Don't think this_cpu ops work
> > here.
> >
> > See below idea. This would avoid the data race (KCSAN stopped
> > complaining) and seems to generate reasonable code.
> >
> > Version before:
> >
> >  <__rcu_read_lock>:
> >      130      mov    %gs:0x0,%rax
> >      137
> >      139      addl   $0x1,0x370(%rax)
> >      140      retq
> >      141      data16 nopw %cs:0x0(%rax,%rax,1)
> >      148
> >      14c      nopl   0x0(%rax)
> >
> > Version after:
> >
> >  <__rcu_read_lock>:
> >      130      mov    %gs:0x0,%rax
> >      137
> >      139      incq   0x370(%rax)
> >      140      retq
> >      141      data16 nopw %cs:0x0(%rax,%rax,1)
> >      148
> >      14c      nopl   0x0(%rax)
> >
> > I haven't checked the other places where it is used, though.
> > (Can send it as a patch if you think this might work.)
> >
> > Thanks,
> > -- Marco
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 2678a37c31696..3d8586ee7ae64 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -50,7 +50,7 @@ void __rcu_read_unlock(void);
> >   * nesting depth, but makes sense only if CONFIG_PREEMPT_RCU -- in other
> >   * types of kernel builds, the rcu_read_lock() nesting depth is unknowable.
> >   */
> > -#define rcu_preempt_depth() (current->rcu_read_lock_nesting)
> > +#define rcu_preempt_depth() local_read(&current->rcu_read_lock_nesting)
> >
> >  #else /* #ifdef CONFIG_PREEMPT_RCU */
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 0918904c939d2..70d7e3257feed 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -10,6 +10,7 @@
> >  #include <uapi/linux/sched.h>
> >
> >  #include <asm/current.h>
> > +#include <asm/local.h>
> >
> >  #include <linux/pid.h>
> >  #include <linux/sem.h>
> > @@ -708,7 +709,7 @@ struct task_struct {
> >       cpumask_t                       cpus_mask;
> >
> >  #ifdef CONFIG_PREEMPT_RCU
> > -     int                             rcu_read_lock_nesting;
> > +     local_t                         rcu_read_lock_nesting;
> >       union rcu_special               rcu_read_unlock_special;
> >       struct list_head                rcu_node_entry;
> >       struct rcu_node                 *rcu_blocked_node;
> > diff --git a/init/init_task.c b/init/init_task.c
> > index 096191d177d5c..941777fce11e5 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -130,7 +130,7 @@ struct task_struct init_task
> >       .perf_event_list = LIST_HEAD_INIT(init_task.perf_event_list),
> >  #endif
> >  #ifdef CONFIG_PREEMPT_RCU
> > -     .rcu_read_lock_nesting = 0,
> > +     .rcu_read_lock_nesting = LOCAL_INIT(0),
> >       .rcu_read_unlock_special.s = 0,
> >       .rcu_node_entry = LIST_HEAD_INIT(init_task.rcu_node_entry),
> >       .rcu_blocked_node = NULL,
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 60a1295f43843..43af326081b06 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1669,7 +1669,7 @@ init_task_pid(struct task_struct *task, enum pid_type type, struct pid *pid)
> >  static inline void rcu_copy_process(struct task_struct *p)
> >  {
> >  #ifdef CONFIG_PREEMPT_RCU
> > -     p->rcu_read_lock_nesting = 0;
> > +     local_set(&p->rcu_read_lock_nesting, 0);
> >       p->rcu_read_unlock_special.s = 0;
> >       p->rcu_blocked_node = NULL;
> >       INIT_LIST_HEAD(&p->rcu_node_entry);
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index c6ea81cd41890..e0595abd50c0f 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -350,17 +350,17 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
> >
> >  static void rcu_preempt_read_enter(void)
> >  {
> > -     current->rcu_read_lock_nesting++;
> > +     local_inc(&current->rcu_read_lock_nesting);
> >  }
> >
> >  static void rcu_preempt_read_exit(void)
> >  {
> > -     current->rcu_read_lock_nesting--;
> > +     local_dec(&current->rcu_read_lock_nesting);
> >  }
> >
> >  static void rcu_preempt_depth_set(int val)
> >  {
> > -     current->rcu_read_lock_nesting = val;
> > +     local_set(&current->rcu_read_lock_nesting, val);

> I agree that this removes the data races, and that the code for x86 is
> quite nice, but aren't rcu_read_lock() and rcu_read_unlock() going to
> have heavyweight atomic operations on many CPUs?
>
> Maybe I am stuck with arch-specific code in rcu_read_lock() and
> rcu_preempt_read_exit().  I suppose worse things could happen.

Peter also mentioned to me that while local_t on x86 generates
reasonable code, on other architectures it's terrible. So I think
something else is needed, and feel free to discard the above idea.
With sufficient enough reasoning, how bad would a 'data_race(..)' be?

Thanks,
-- Marco
