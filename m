Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB6C2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUw46eks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgIIQfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbgIIQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:26:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A346C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:26:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so1617066pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=malTI9J5/Kv2ZSnm48hMc/ik7eqFHRvjcHo2TwZ/1kU=;
        b=ZUw46eks2XTN+P/LLAp296TJp3q5iI6HAhVO8lsXYXHjFIceikiE0DI0lPU5bSMYCA
         4KChdC99ZLd1YmAxrUHopJAnwRC+gaHFXwCf6WFp2ul8ZuO0Rbf06IzTWJAj5hHzVIB7
         Uc9rKLFF8YFfqmD53YswRrYUnrylKe6HnWGoksPuoF5y1q+AD/gRMA/wl82fUXVgmDNK
         pn5LuTKz5Ky+vtOrFUT//ys+k8hpgLg1CDTb0jYdL03s3fORb6Qoau+dXLnM79ttX8VG
         R1OFKxF3ryeTybg+l/rOUqfqC/vuZ+Wea/ITlRKknpiuSVtfsXhY/6r0hzHmCJUC3ds9
         rl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=malTI9J5/Kv2ZSnm48hMc/ik7eqFHRvjcHo2TwZ/1kU=;
        b=UQH9AeITSeMsX3ofDtF0Qs3P2iXAS33D6qMTM9FgwwP5eju9OSjteeIaYC21Inggb4
         OoSTKrdpyybpQo5zOQIKagM9WrizsgvL2umcSVUALf0HsyVODGun1g+yXmGWmE/RXhMa
         RHPF3z38uSnMEDRtWmvo+DZd6utAMwyayap3gdw4+TTIlGczOozyn0NHe2JRbF69lg15
         QjRmZM+NdlrwgsSSJPdN5eLD1JoyznVLpac55YSARohYfmsypW6epmuvV05GB1lFTErk
         Ed0aTBGQysCx8QxW9emkHueTgsQ/CsuinCFYozoT45fXt4bLH+5hwmqwBzdtQiHdJExT
         rT9Q==
X-Gm-Message-State: AOAM530jA4A1tBQmZ7N3gaMjdHXPr2R7LbI9iMLaAyPREax3jYqTU3iT
        X5Br5DYPByX4/TBYRw/MCZykTWzr17+CHlL3kWwTHg==
X-Google-Smtp-Source: ABdhPJyXjQRKhoQBkxIKAzxCkn6JlZJ8AqEgWl3ECL6Mtc83iPvOQRgj2cFGrVEheu2onGDEIJYYKubYoCfXhMK2Tq0=
X-Received: by 2002:a17:90a:a583:: with SMTP id b3mr1451894pjq.127.1599668784247;
 Wed, 09 Sep 2020 09:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200618222225.102337-1-axelrasmussen@google.com>
 <20200618222225.102337-2-axelrasmussen@google.com> <CALOAHbA00V8H5jSnaUG_eJ47NptDaz_JLQVOpdGO6yiUf4_fuw@mail.gmail.com>
In-Reply-To: <CALOAHbA00V8H5jSnaUG_eJ47NptDaz_JLQVOpdGO6yiUf4_fuw@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 9 Sep 2020 09:25:47 -0700
Message-ID: <CAJHvVciAsYOq_JSVf3f7oMUM7ZgrqNSotZJ3gmA9kpEBJm2twA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/1] mmap_lock: add tracepoints around mmap_lock acquisition
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Michel Lespinasse <walken@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Adams <jwadams@google.com>,
        David Rientjes <rientjes@google.com>,
        Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yafang,

I've felt a bit stuck on this, as tracepoints alone don't quite
address my use case (performance overhead is too high), but I haven't
been able to come up with a palatable approach which does. I was
planning to conduct an experiment on Google production servers, to
provide real-world evidence of why this would be useful.

However, the tracepoints alone are still useful, and it sounds like
that may be enough for your needs? I'm happy to send a version of this
which only adds tracepoints this week. I think at least that subset is
uncontroversial.

On Tue, Sep 8, 2020 at 4:41 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Fri, Jun 19, 2020 at 6:43 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > The goal is to be able to collect a latency histogram for contended
> > mmap_lock acquisitions. This will be used to diagnose slowness observed
> > in production workloads, as well as to measure the effect of upcoming
> > mmap_lock optimizations like maple trees and range-based locks. The
> > "start_locking" and "lock_released" tracepoints can be used to find out
> > which process / call stack was waiting on / holding the lock.
> >
> > The use of tracepoints with histogram triggers for this purpose was
> > recommended here: https://marc.info/?l=linux-mm&m=159076475528369&w=2
> >
> > A new Kconfig is added, because this change requires uninlining some
> > functions, adding branches, etc., even if the tracepoints aren't enabled
> > at runtime.
> >
> > The semantics of the "acquire_returned" tracepoint are as follows:
> >
> > - We leverage a new "contended hook" rwsem API so "_trylock" variants
> >   are called first, and only in the contended case is the trace event
> >   triggered. This eliminates overhead for the "common" uncontended case.
> >
> > - "acquire_returned" is triggered even if acquisition fails (e.g. in the
> >   case of killable acquires). This is so we can see how long we waited,
> >   even if we didn't get the lock in the end. Whether or not the
> >   acquisition succeeded is an event parameter.
> >
> > - The path of the memcg to which the mm_struct belongs is reported in
> >   the event, so we can have per-memcg historams. But, note that the
> >   stats are *not* hierarchical; if consumers want a histogram for a
> >   memcg *and all of its children*, the consumer will need to add up the
> >   separate per-memcg stats itself. This is to avoid paying the cost of
> >   traversing a series of memcgs *at record time* (more overhead).
> >
> > - Bucketing based upon the duration (bucket_{lower,upper}) is done in
> >   the kernel, as histogram triggers don't have an API to configure such
> >   a thing at runtime.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >
> > Changes since v2:
> > - Switched to TRACE_EVENT hist triggers instead of a new hist library.
> > - Reduced inlining, as it increased code size with no performance gain.
> > - Stopped instrumenting the uncontended case, to reduce overhead. Added
> >   additional rwsem.h API surface in order to be able to do this.
> >
> >  include/linux/lockdep.h          |  47 ++++++
> >  include/linux/mmap_lock.h        |  27 ++-
> >  include/linux/rwsem.h            |  12 ++
> >  include/trace/events/mmap_lock.h |  76 +++++++++
> >  kernel/locking/rwsem.c           |  64 +++++++
> >  mm/Kconfig                       |  19 +++
> >  mm/Makefile                      |   1 +
> >  mm/mmap_lock.c                   | 281 +++++++++++++++++++++++++++++++
> >  8 files changed, 526 insertions(+), 1 deletion(-)
> >  create mode 100644 include/trace/events/mmap_lock.h
> >  create mode 100644 mm/mmap_lock.c
> >
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 8fce5c98a4b0..6de91046437c 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -590,6 +590,17 @@ do {                                                               \
> >         lock_acquired(&(_lock)->dep_map, _RET_IP_);                     \
> >  } while (0)
> >
> > +#define LOCK_CONTENDED_HOOK(_lock, try, lock, pre, post, arg)  \
> > +do {                                                           \
> > +       if (!try(_lock)) {                                      \
> > +               lock_contended(&(_lock)->dep_map, _RET_IP_);    \
> > +               pre(arg);                                       \
> > +               lock(_lock);                                    \
> > +               post(arg);                                      \
> > +       }                                                       \
> > +       lock_acquired(&(_lock)->dep_map, _RET_IP_);             \
> > +} while (0)
> > +
> >  #define LOCK_CONTENDED_RETURN(_lock, try, lock)                        \
> >  ({                                                             \
> >         int ____err = 0;                                        \
> > @@ -602,6 +613,21 @@ do {                                                               \
> >         ____err;                                                \
> >  })
> >
> > +#define LOCK_CONTENDED_HOOK_RETURN(                            \
> > +       _lock, try, lock, pre, post, arg)                       \
> > +({                                                             \
> > +       int ____err = 0;                                        \
> > +       if (!try(_lock)) {                                      \
> > +               lock_contended(&(_lock)->dep_map, _RET_IP_);    \
> > +               pre(arg);                                       \
> > +               ____err = lock(_lock);                          \
> > +               post(arg, ____err);                             \
> > +       }                                                       \
> > +       if (!____err)                                           \
> > +               lock_acquired(&(_lock)->dep_map, _RET_IP_);     \
> > +       ____err;                                                \
> > +})
> > +
> >  #else /* CONFIG_LOCK_STAT */
> >
> >  #define lock_contended(lockdep_map, ip) do {} while (0)
> > @@ -610,9 +636,30 @@ do {                                                               \
> >  #define LOCK_CONTENDED(_lock, try, lock) \
> >         lock(_lock)
> >
> > +#define LOCK_CONTENDED_HOOK(_lock, try, lock, pre, post, arg)  \
> > +do {                                                           \
> > +       if (!try(_lock)) {                                      \
> > +               pre(arg);                                       \
> > +               lock(_lock);                                    \
> > +               post(arg);                                      \
> > +       }                                                       \
> > +} while (0)
> > +
> >  #define LOCK_CONTENDED_RETURN(_lock, try, lock) \
> >         lock(_lock)
> >
> > +#define LOCK_CONTENDED_HOOK_RETURN(                            \
> > +       _lock, try, lock, pre, post, arg)                       \
> > +({                                                             \
> > +       int ____err = 0;                                        \
> > +       if (!try(_lock)) {                                      \
> > +               pre(arg);                                       \
> > +               ____err = lock(_lock);                          \
> > +               post(arg, ____err);                             \
> > +       }                                                       \
> > +       ____err;                                                \
> > +})
> > +
> >  #endif /* CONFIG_LOCK_STAT */
> >
> >  #ifdef CONFIG_LOCKDEP
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 0707671851a8..1f61f1eac319 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -1,11 +1,34 @@
> >  #ifndef _LINUX_MMAP_LOCK_H
> >  #define _LINUX_MMAP_LOCK_H
> >
> > +#include <linux/mm_types.h>
> >  #include <linux/mmdebug.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/types.h>
> >
> >  #define MMAP_LOCK_INITIALIZER(name) \
> >         .mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
> >
> > +#ifdef CONFIG_MMAP_LOCK_TRACEPOINTS
> > +
> > +void mmap_init_lock(struct mm_struct *mm);
> > +void mmap_write_lock(struct mm_struct *mm);
> > +void mmap_write_lock_nested(struct mm_struct *mm, int subclass);
> > +int mmap_write_lock_killable(struct mm_struct *mm);
> > +bool mmap_write_trylock(struct mm_struct *mm);
> > +void mmap_write_unlock(struct mm_struct *mm);
> > +void mmap_write_downgrade(struct mm_struct *mm);
> > +void mmap_read_lock(struct mm_struct *mm);
> > +int mmap_read_lock_killable(struct mm_struct *mm);
> > +bool mmap_read_trylock(struct mm_struct *mm);
> > +void mmap_read_unlock(struct mm_struct *mm);
> > +bool mmap_read_trylock_non_owner(struct mm_struct *mm);
> > +void mmap_read_unlock_non_owner(struct mm_struct *mm);
> > +void mmap_assert_locked(struct mm_struct *mm);
> > +void mmap_assert_write_locked(struct mm_struct *mm);
> > +
> > +#else /* !CONFIG_MMAP_LOCK_TRACEPOINTS */
> > +
> >  static inline void mmap_init_lock(struct mm_struct *mm)
> >  {
> >         init_rwsem(&mm->mmap_lock);
> > @@ -63,7 +86,7 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
> >
> >  static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
> >  {
> > -       if (down_read_trylock(&mm->mmap_lock)) {
> > +       if (mmap_read_trylock(mm)) {
> >                 rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
> >                 return true;
> >         }
> > @@ -87,4 +110,6 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
> >         VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >  }
> >
> > +#endif /* CONFIG_MMAP_LOCK_TRACEPOINTS */
> > +
> >  #endif /* _LINUX_MMAP_LOCK_H */
> > diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> > index 7e5b2a4eb560..3304a35da4c0 100644
> > --- a/include/linux/rwsem.h
> > +++ b/include/linux/rwsem.h
> > @@ -123,7 +123,13 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
> >   * lock for reading
> >   */
> >  extern void down_read(struct rw_semaphore *sem);
> > +extern void down_read_contended_hook(struct rw_semaphore *sem,
> > +                                    void (*pre)(void *), void (*post)(void *),
> > +                                    void *arg);
> >  extern int __must_check down_read_killable(struct rw_semaphore *sem);
> > +extern int __must_check
> > +down_read_killable_contended_hook(struct rw_semaphore *sem, void (*pre)(void *),
> > +                                 void (*post)(void *, int), void *arg);
> >
> >  /*
> >   * trylock for reading -- returns 1 if successful, 0 if contention
> > @@ -134,7 +140,13 @@ extern int down_read_trylock(struct rw_semaphore *sem);
> >   * lock for writing
> >   */
> >  extern void down_write(struct rw_semaphore *sem);
> > +extern void down_write_contended_hook(struct rw_semaphore *sem,
> > +                                     void (*pre)(void *), void (*post)(void *),
> > +                                     void *arg);
> >  extern int __must_check down_write_killable(struct rw_semaphore *sem);
> > +extern int __must_check down_write_killable_contended_hook(
> > +       struct rw_semaphore *sem, void (*pre)(void *),
> > +       void (*post)(void *, int), void *arg);
> >
> >  /*
> >   * trylock for writing -- returns 1 if successful, 0 if contention
> > diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> > new file mode 100644
> > index 000000000000..d1d4c83b848e
> > --- /dev/null
> > +++ b/include/trace/events/mmap_lock.h
> > @@ -0,0 +1,76 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM mmap_lock
> > +
> > +#if !defined(_TRACE_MMAP_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_MMAP_LOCK_H
> > +
> > +#include <linux/tracepoint.h>
> > +#include <linux/types.h>
> > +
> > +struct mm_struct;
> > +
> > +DECLARE_EVENT_CLASS(
> > +       mmap_lock_template,
> > +
> > +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> > +                bool success, u64 bucket_lower, u64 bucket_upper),
> > +
> > +       TP_ARGS(mm, memcg_path, duration, success, bucket_lower, bucket_upper),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(struct mm_struct *, mm)
> > +               __string(memcg_path, memcg_path)
> > +               __field(u64, duration)
> > +               __field(bool, success)
> > +               __field(u64, bucket_lower)
> > +               __field(u64, bucket_upper)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->mm = mm;
> > +               __assign_str(memcg_path, memcg_path);
> > +               __entry->duration = duration;
> > +               __entry->success = success;
> > +               __entry->bucket_lower = bucket_lower;
> > +               __entry->bucket_upper = bucket_upper;
> > +       ),
> > +
> > +       TP_printk(
> > +               "mm=%p memcg_path=%s duration=%llu success=%s bucket=[%llu, %llu]\n",
> > +               __entry->mm,
> > +               __get_str(memcg_path),
> > +               __entry->duration,
> > +               __entry->success ? "true" : "false",
> > +               __entry->bucket_lower,
> > +               __entry->bucket_upper)
> > +       );
> > +
> > +DEFINE_EVENT(mmap_lock_template, mmap_lock_start_locking,
> > +
> > +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> > +                bool success, u64 bucket_lower, u64 bucket_upper),
> > +
> > +       TP_ARGS(mm, memcg_path, duration, success, bucket_lower, bucket_upper)
> > +);
> > +
> > +DEFINE_EVENT(mmap_lock_template, mmap_lock_acquire_returned,
> > +
> > +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> > +                bool success, u64 bucket_lower, u64 bucket_upper),
> > +
> > +       TP_ARGS(mm, memcg_path, duration, success, bucket_lower, bucket_upper)
> > +);
> > +
> > +DEFINE_EVENT(mmap_lock_template, mmap_lock_released,
> > +
> > +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> > +                bool success, u64 bucket_lower, u64 bucket_upper),
> > +
> > +       TP_ARGS(mm, memcg_path, duration, success, bucket_lower, bucket_upper)
> > +);
> > +
> > +#endif /* _TRACE_MMAP_LOCK_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > index f11b9bd3431d..6aabea1cbc5d 100644
> > --- a/kernel/locking/rwsem.c
> > +++ b/kernel/locking/rwsem.c
> > @@ -1495,6 +1495,20 @@ void __sched down_read(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_read);
> >
> > +/*
> > + * lock for reading
> > + */
> > +void __sched down_read_contended_hook(struct rw_semaphore *sem,
> > +                                     void (*pre)(void *),
> > +                                     void (*post)(void *), void *arg)
> > +{
> > +       might_sleep();
> > +       rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > +       LOCK_CONTENDED_HOOK(sem, __down_read_trylock, __down_read, pre, post,
> > +                           arg);
> > +}
> > +EXPORT_SYMBOL(down_read_contended_hook);
> > +
> >  int __sched down_read_killable(struct rw_semaphore *sem)
> >  {
> >         might_sleep();
> > @@ -1509,6 +1523,24 @@ int __sched down_read_killable(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_read_killable);
> >
> > +int __sched down_read_killable_contended_hook(struct rw_semaphore *sem,
> > +                                             void (*pre)(void *),
> > +                                             void (*post)(void *, int),
> > +                                             void *arg)
> > +{
> > +       might_sleep();
> > +       rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > +
> > +       if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_read_trylock,
> > +                                      __down_read_killable, pre, post, arg)) {
> > +               rwsem_release(&sem->dep_map, _RET_IP_);
> > +               return -EINTR;
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(down_read_killable_contended_hook);
> > +
> >  /*
> >   * trylock for reading -- returns 1 if successful, 0 if contention
> >   */
> > @@ -1533,6 +1565,20 @@ void __sched down_write(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_write);
> >
> > +/*
> > + * lock for writing
> > + */
> > +void __sched down_write_contended_hook(struct rw_semaphore *sem,
> > +                                      void (*pre)(void *),
> > +                                      void (*post)(void *), void *arg)
> > +{
> > +       might_sleep();
> > +       rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> > +       LOCK_CONTENDED_HOOK(sem, __down_write_trylock, __down_write, pre, post,
> > +                           arg);
> > +}
> > +EXPORT_SYMBOL(down_write_contended_hook);
> > +
> >  /*
> >   * lock for writing
> >   */
> > @@ -1551,6 +1597,24 @@ int __sched down_write_killable(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_write_killable);
> >
> > +int __sched down_write_killable_contended_hook(struct rw_semaphore *sem,
> > +                                              void (*pre)(void *),
> > +                                              void (*post)(void *, int),
> > +                                              void *arg)
> > +{
> > +       might_sleep();
> > +       rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > +
> > +       if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_write_trylock,
> > +                                      __down_write_killable, pre, post, arg)) {
> > +               rwsem_release(&sem->dep_map, _RET_IP_);
> > +               return -EINTR;
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(down_write_killable_contended_hook);
> > +
> >  /*
> >   * trylock for writing -- returns 1 if successful, 0 if contention
> >   */
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index f2104cc0d35c..a88b44ff46e2 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -822,6 +822,25 @@ config DEVICE_PRIVATE
> >  config FRAME_VECTOR
> >         bool
> >
> > +config MMAP_LOCK_TRACEPOINTS
> > +       bool "mmap_lock tracepoints"
> > +       select HISTOGRAM
> > +       select HIST_TRIGGERS
> > +       default n
> > +
> > +       help
> > +         Enable kernel tracepoints around mmap_lock acquisition. These can be
> > +         enabled / disabled at runtime, although note there is a small amount
> > +         of overhead even before the tracepoints are runtime-enabled. When
> > +         histogram triggers are configured at runtime, less than 1% overhead
> > +         is added to typical workloads.
> > +
> > +         This option selects CONFIG_HIST_TRIGGERS, since one of the main
> > +         purposes of this feature is to allow lock acquisition latency
> > +         histograms to be collected.
> > +
> > +         If unsure, say "N".
> > +
> >  config ARCH_USES_HIGH_VMA_FLAGS
> >         bool
> >  config ARCH_HAS_PKEYS
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 6e9d46b2efc9..14860f7b9984 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -121,3 +121,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
> >  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
> >  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
> >  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> > +obj-$(CONFIG_MMAP_LOCK_TRACEPOINTS) += mmap_lock.o
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > new file mode 100644
> > index 000000000000..d0734d6325ea
> > --- /dev/null
> > +++ b/mm/mmap_lock.c
> > @@ -0,0 +1,281 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/mmap_lock.h>
> > +
> > +#include <linux/cgroup.h>
> > +#include <linux/kernel.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/mmap_lock.h>
> > +#include <linux/percpu.h>
> > +#include <linux/smp.h>
> > +#include <linux/trace_events.h>
> > +#include <linux/sched/clock.h>
> > +
> > +static const u64 mmap_lock_buckets[] = {
> > +       250,            /* 250 ns */
> > +       375,            /* 375 ns */
> > +       500,            /* 500 ns */
> > +       1000,           /* 1 us */
> > +       10000,          /* 10 us */
> > +       100000,         /* 100 us */
> > +       500000,         /* 500 us */
> > +       1000000,        /* 1 ms */
> > +       5000000,        /* 5 ms */
> > +       10000000,       /* 10 ms */
> > +       50000000,       /* 50 ms */
> > +       100000000,      /* 100 ms */
> > +       500000000,      /* 500 ms */
> > +       1000000000,     /* 1 s */
> > +       5000000000UL,   /* 5 s */
> > +       10000000000UL,  /* 10 s */
> > +       ~0              /* > 10s */
> > +};
> > +
> > +static int find_bucket(u64 duration)
> > +{
> > +       int i, lower, upper;
> > +
> > +       lower = 0;
> > +       upper = ARRAY_SIZE(mmap_lock_buckets) - 1;
> > +       while (lower < upper) {
> > +               /* Can't realistically overflow, number of buckets < 2**63. */
> > +               i = (lower + upper) / 2;
> > +               if (duration <= mmap_lock_buckets[i])
> > +                       upper = i;
> > +               else
> > +                       lower = i + 1;
> > +       }
> > +       return upper;
> > +}
> > +
> > +#ifdef CONFIG_MEMCG
> > +
> > +DEFINE_PER_CPU(char[MAX_FILTER_STR_VAL], trace_memcg_path);
> > +
> > +/*
> > + * Write the given mm_struct's memcg path to a percpu buffer, and return a
> > + * pointer to it. If the path cannot be determined, the buffer will contain the
> > + * empty string.
> > + *
> > + * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
> > + * disabled by the caller before calling us, and re-enabled only after the
> > + * caller is done with the pointer.
> > + */
> > +static const char *get_mm_memcg_path(struct mm_struct *mm)
> > +{
> > +       struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
> > +
> > +       if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
> > +               char *buf = this_cpu_ptr(trace_memcg_path);
> > +
> > +               cgroup_path(memcg->css.cgroup, buf, MAX_FILTER_STR_VAL);
> > +               return buf;
> > +       }
> > +       return "";
> > +}
> > +
> > +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> > +       do {                                                                   \
> > +               if (trace_mmap_lock_##type##_enabled()) {                      \
> > +                       get_cpu();                                             \
> > +                       trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),      \
> > +                                              ##__VA_ARGS__);                 \
> > +                       put_cpu();                                             \
> > +               }                                                              \
> > +       } while (0)
> > +
> > +#else /* CONFIG_MEMCG */
> > +
> > +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> > +       trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> > +
> > +#endif /* CONFIG_MEMCG */
> > +
> > +/*
> > + * Trace calls must be in a separate file, as otherwise there's a cirtuclar
> > + * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> > + */
> > +
> > +static void trace_start_locking(struct mm_struct *mm)
> > +{
> > +       TRACE_MMAP_LOCK_EVENT(start_locking, mm, 0, true, 0,
> > +                             mmap_lock_buckets[0]);
> > +}
> > +
> > +static void trace_acquire_returned(struct mm_struct *mm, u64 start_time_ns,
> > +                                  bool success)
> > +{
> > +       u64 duration = sched_clock() - start_time_ns;
> > +       int i = find_bucket(duration);
> > +
> > +       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, duration, success,
> > +                             i > 0 ? mmap_lock_buckets[i - 1] + 1 : 0,
> > +                             mmap_lock_buckets[i]);
> > +}
> > +
> > +static void trace_released(struct mm_struct *mm)
> > +{
> > +       TRACE_MMAP_LOCK_EVENT(released, mm, 0, true, 0, mmap_lock_buckets[0]);
> > +}
> > +
> > +struct trace_context {
> > +       struct mm_struct *mm;
> > +       u64 start_time_ns;
> > +};
> > +
> > +static inline void trace_pre(void *c)
> > +{
> > +       ((struct trace_context *) c)->start_time_ns = sched_clock();
> > +}
> > +
> > +static void trace_post_return(void *c, int ret)
> > +{
> > +       struct trace_context *context = (struct trace_context *)c;
> > +
> > +       trace_acquire_returned(context->mm, context->start_time_ns, ret == 0);
> > +}
> > +
> > +static inline void trace_post(void *c)
> > +{
> > +       trace_post_return(c, 0);
> > +}
> > +
> > +static inline bool trylock_impl(struct mm_struct *mm,
> > +                               int (*trylock)(struct rw_semaphore *))
> > +{
> > +       trace_start_locking(mm);
> > +       return trylock(&mm->mmap_lock) != 0;
> > +}
> > +
> > +static inline void lock_impl(struct mm_struct *mm,
> > +                            void (*lock)(struct rw_semaphore *,
> > +                                         void (*)(void *), void (*)(void *),
> > +                                         void *))
> > +{
> > +       struct trace_context context = { .mm = mm, .start_time_ns = 0 };
> > +
> > +       trace_start_locking(mm);
> > +       lock(&mm->mmap_lock, trace_pre, trace_post, &context);
> > +}
> > +
> > +static inline int lock_return_impl(struct mm_struct *mm,
> > +                                  int (*lock)(struct rw_semaphore *,
> > +                                              void (*)(void *),
> > +                                              void (*)(void *, int), void *))
> > +{
> > +       struct trace_context context = { .mm = mm, .start_time_ns = 0 };
> > +
> > +       trace_start_locking(mm);
> > +       return lock(&mm->mmap_lock, trace_pre, trace_post_return, &context);
> > +}
> > +
> > +void mmap_init_lock(struct mm_struct *mm)
> > +{
> > +       init_rwsem(&mm->mmap_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_init_lock);
> > +
> > +void mmap_write_lock(struct mm_struct *mm)
> > +{
> > +       lock_impl(mm, down_write_contended_hook);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_write_lock);
> > +
> > +void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
> > +{
> > +       /*
> > +        * Unlike other functions, we don't need the contended hook API here.
> > +        * This is because we don't care about breaking out the {un,}contended
> > +        * cases.
> > +        *
> > +        * This function is only called once on fork (nowhere else), so 1)
> > +        * performance isn't as important, and 2) we expect to never experience
> > +        * contention.
> > +        */
> > +       u64 start_time_ns = sched_clock();
> > +
> > +       down_write_nested(&mm->mmap_lock, subclass);
> > +       trace_acquire_returned(mm, start_time_ns, true);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_write_lock_nested);
> > +
> > +int mmap_write_lock_killable(struct mm_struct *mm)
> > +{
> > +       return lock_return_impl(mm, down_write_killable_contended_hook);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_write_lock_killable);
> > +
> > +bool mmap_write_trylock(struct mm_struct *mm)
> > +{
> > +       return trylock_impl(mm, down_write_trylock);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_write_trylock);
> > +
> > +void mmap_write_unlock(struct mm_struct *mm)
> > +{
> > +       up_write(&mm->mmap_lock);
> > +       trace_released(mm);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_write_unlock);
> > +
> > +void mmap_write_downgrade(struct mm_struct *mm)
> > +{
> > +       downgrade_write(&mm->mmap_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_write_downgrade);
> > +
> > +void mmap_read_lock(struct mm_struct *mm)
> > +{
> > +       lock_impl(mm, down_read_contended_hook);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_read_lock);
> > +
> > +int mmap_read_lock_killable(struct mm_struct *mm)
> > +{
> > +       return lock_return_impl(mm, down_read_killable_contended_hook);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_read_lock_killable);
> > +
> > +bool mmap_read_trylock(struct mm_struct *mm)
> > +{
> > +       return trylock_impl(mm, down_read_trylock);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_read_trylock);
> > +
> > +void mmap_read_unlock(struct mm_struct *mm)
> > +{
> > +       up_read(&mm->mmap_lock);
> > +       trace_released(mm);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_read_unlock);
> > +
> > +bool mmap_read_trylock_non_owner(struct mm_struct *mm)
> > +{
> > +       if (trylock_impl(mm, down_read_trylock)) {
> > +               rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
> > +               return true;
> > +       }
> > +       return false;
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_read_trylock_non_owner);
> > +
> > +void mmap_read_unlock_non_owner(struct mm_struct *mm)
> > +{
> > +       up_read_non_owner(&mm->mmap_lock);
> > +       trace_released(mm);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_read_unlock_non_owner);
> > +
> > +void mmap_assert_locked(struct mm_struct *mm)
> > +{
> > +       lockdep_assert_held(&mm->mmap_lock);
> > +       VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_assert_locked);
> > +
> > +void mmap_assert_write_locked(struct mm_struct *mm)
> > +{
> > +       lockdep_assert_held_write(&mm->mmap_lock);
> > +       VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > +}
> > +EXPORT_SYMBOL_GPL(mmap_assert_write_locked);
> > --
> > 2.27.0.111.gc72c7da667-goog
> >
> >
>
> Hi Axel,
>
> Any updates on this patchset ?
>
> I think adding tracepoints to trace the mmap_lock would be helpful to
> us, which can help us identify which one holds the mmap_lock too long
> and why it takes too long.
>
>
> --
> Thanks
> Yafang
