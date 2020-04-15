Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1798DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D274A206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dL5A/Yea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbgDOWZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731478AbgDOWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:25:27 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A12C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:25:27 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id g184so1163973vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVoVqPVWRToxS7xXdO6QXNNoYdDvHyBTplJMFexmH6k=;
        b=dL5A/YeaJiEKfzx6SMtVmHwHn/JRdU5mO9PKafyNfycPUGS5bI6sTJC7OwM6oCdnlf
         tueeYh7iWZlT+DccVZgvNTKTWeC9ie7uXowqAaz7XxmlZdQPZrtxbl21WG6NdtLllXWE
         tBXYkWOHKK203E43zbKntyZthvmADnET/oQ7OqCBaYNfdpeJPzBwlWivFeSLhWNmin4R
         vTPEMmMX+lps5e1+hxvoTRDc7aVGwgnRIh9N7ie+l/jXeC/iNXrsieaJ4no1kKivkhOy
         bj7fuFgH+cAIkSzItQpSvcYZ/Q5lby9ns2URoAAmQqL4tDkMzzB3GDLgJdhaucWwqTPZ
         ZmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVoVqPVWRToxS7xXdO6QXNNoYdDvHyBTplJMFexmH6k=;
        b=BMbmFAR44NbgTQuaQ2jjogzQwsWWBoB//tyU4obY2rleoO9Ly1D7CbmMu5S1xyMVSZ
         V5uuFYh/JQ3nQtWvYVMmxZiyZP6aLmkhK1DL/URJlj4NWX/mJvqwz3Y6JZsZtw0lHoyk
         0JS4sI/Ss3bGcEoxs7TTeIGNqDcUy174+5zrFGNMNBo/ok2t96f3C+Qgm7ZI+uCJvyop
         dPgMkVeuWI9ztroOSIJEbH+vTCd7rJ+deOIbN0OO4mVB8Xb1TL0U5WfRb9Jx4Gj3oJTa
         v9Cf7mldqUgeuQw/AHBLbVZk2cHI/6Sypx9dKC77NT0E7AQq6r49C8hxGYDjeu28cfRX
         XeBg==
X-Gm-Message-State: AGi0Pua7ojpECnU9jtQDcPE1PKXlfkoa44foCQWnsvAMa1oLASqrS4we
        PddbkWL3CKXGHJ+Dy0CdOgM1GMA9l8MI8wZowfnqYw==
X-Google-Smtp-Source: APiQypLVwBXUq2spuWEFnZ4YDa+V5Ip2lrUBEF4ZrFER09cYd4aZMulXuKRlBgncGHki6y7Xh0ut1GxJAKciasmCImg=
X-Received: by 2002:a67:f60b:: with SMTP id k11mr6633078vso.17.1586989525721;
 Wed, 15 Apr 2020 15:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <1586759071.9539.15.camel@mtkswgap22> <1586929044-12708-1-git-send-email-Frankie.Chang@mediatek.com>
 <1586929044-12708-2-git-send-email-Frankie.Chang@mediatek.com>
In-Reply-To: <1586929044-12708-2-git-send-email-Frankie.Chang@mediatek.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 15 Apr 2020 15:25:12 -0700
Message-ID: <CAHRSSExdaLPRfJ-2Yuwy78veRRM+k9wcZnOdMhbvhErBQGAk7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] binder: transaction latency tracking for user build
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:38 PM Frankie Chang
<Frankie.Chang@mediatek.com> wrote:
>
> Record start/end timestamp to binder transaction.

s/timestamp to/timestamps for/

> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold (2 sec),

Is the 2 sec configurable? Why was 2 sec chosen?

> if yes, printing related information for tracing.
>
> /* Implement details */
> - Add tracepoint/trace at free transaction.
>   Since the original trace_binder_transaction_reveived cannot

s/reveived/received/

>   precisely present the real finished time of transaction, adding a
>   trace_binder_free_transaction at the point of free transaction
>   may be more close to it.

Can we just add that trace instead?

>
> - Add latency tracer module to monitor slow transaction.
>   The trace_binder_free_transaction would not be enabled
>   by default. Monitoring which transaction is too slow to
>   cause some of exceptions is important. So we hook the
>   tracepoint to call the monitor function.
>
> - Move some struct from core file to header file.
>   Need some struct defined in core file in latency trace module
>   In addition, moving structs to header file makes module more
>   extendable.
>
> Signed-off-by: Frankie Chang <Frankie.Chang@mediatek.com>
> ---
>  drivers/android/Kconfig                 |    8 ++
>  drivers/android/Makefile                |    1 +
>  drivers/android/binder.c                |  237 ++++---------------------------
>  drivers/android/binder_internal.h       |  227 +++++++++++++++++++++++++++++
>  drivers/android/binder_latency_tracer.c |  100 +++++++++++++
>  drivers/android/binder_trace.h          |   36 +++++
>  6 files changed, 400 insertions(+), 209 deletions(-)
>  create mode 100644 drivers/android/binder_latency_tracer.c
>
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 6fdf2ab..7ba80eb 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -54,6 +54,14 @@ config ANDROID_BINDER_IPC_SELFTEST
>           exhaustively with combinations of various buffer sizes and
>           alignments.
>
> +config BINDER_USER_TRACKING
> +       bool "Android Binder transaction tracking"
> +       help
> +         Used for track abnormal binder transaction which is over 2 seconds,
> +         when the transaction is done or be free, this transaction would be
> +         checked whether it executed overtime.
> +         If yes, printing out the detail info about it.
> +
>  endif # if ANDROID
>
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c9..552e8ac 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y += -I$(src)                   # needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)         += binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)       += binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> +obj-$(CONFIG_BINDER_USER_TRACKING)     += binder_latency_tracer.o
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index a6b2082..380a68b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -160,24 +160,6 @@ static int binder_set_stop_on_user_error(const char *val,
>  #define to_binder_fd_array_object(hdr) \
>         container_of(hdr, struct binder_fd_array_object, hdr)
>
> -enum binder_stat_types {
> -       BINDER_STAT_PROC,
> -       BINDER_STAT_THREAD,
> -       BINDER_STAT_NODE,
> -       BINDER_STAT_REF,
> -       BINDER_STAT_DEATH,
> -       BINDER_STAT_TRANSACTION,
> -       BINDER_STAT_TRANSACTION_COMPLETE,
> -       BINDER_STAT_COUNT
> -};
> -
> -struct binder_stats {
> -       atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
> -       atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
> -       atomic_t obj_created[BINDER_STAT_COUNT];
> -       atomic_t obj_deleted[BINDER_STAT_COUNT];
> -};
> -
>  static struct binder_stats binder_stats;
>
>  static inline void binder_stats_deleted(enum binder_stat_types type)
> @@ -214,32 +196,6 @@ static struct binder_transaction_log_entry *binder_transaction_log_add(
>  }
>
>  /**
> - * struct binder_work - work enqueued on a worklist
> - * @entry:             node enqueued on list
> - * @type:              type of work to be performed
> - *
> - * There are separate work lists for proc, thread, and node (async).
> - */
> -struct binder_work {
> -       struct list_head entry;
> -
> -       enum {
> -               BINDER_WORK_TRANSACTION = 1,
> -               BINDER_WORK_TRANSACTION_COMPLETE,
> -               BINDER_WORK_RETURN_ERROR,
> -               BINDER_WORK_NODE,
> -               BINDER_WORK_DEAD_BINDER,
> -               BINDER_WORK_DEAD_BINDER_AND_CLEAR,
> -               BINDER_WORK_CLEAR_DEATH_NOTIFICATION,
> -       } type;
> -};
> -
> -struct binder_error {
> -       struct binder_work work;
> -       uint32_t cmd;
> -};
> -
> -/**
>   * struct binder_node - binder node bookkeeping
>   * @debug_id:             unique ID for debugging
>   *                        (invariant after initialized)

Please, if we must have a binder_internal.h for the key data
structures, then move them all.
The use of structs by transaction latency stuff shouldn't be the
rationale for what moves and
what stays. binder_proc, binder_node, binder_thread etc should be defined
in the same file.

> @@ -402,89 +358,6 @@ enum binder_deferred_state {
>         BINDER_DEFERRED_RELEASE      = 0x02,
>  };
>
> -/**
> - * struct binder_proc - binder process bookkeeping
> - * @proc_node:            element for binder_procs list
> - * @threads:              rbtree of binder_threads in this proc
> - *                        (protected by @inner_lock)
> - * @nodes:                rbtree of binder nodes associated with
> - *                        this proc ordered by node->ptr
> - *                        (protected by @inner_lock)
> - * @refs_by_desc:         rbtree of refs ordered by ref->desc
> - *                        (protected by @outer_lock)
> - * @refs_by_node:         rbtree of refs ordered by ref->node
> - *                        (protected by @outer_lock)
> - * @waiting_threads:      threads currently waiting for proc work
> - *                        (protected by @inner_lock)
> - * @pid                   PID of group_leader of process
> - *                        (invariant after initialized)
> - * @tsk                   task_struct for group_leader of process
> - *                        (invariant after initialized)
> - * @deferred_work_node:   element for binder_deferred_list
> - *                        (protected by binder_deferred_lock)
> - * @deferred_work:        bitmap of deferred work to perform
> - *                        (protected by binder_deferred_lock)
> - * @is_dead:              process is dead and awaiting free
> - *                        when outstanding transactions are cleaned up
> - *                        (protected by @inner_lock)
> - * @todo:                 list of work for this process
> - *                        (protected by @inner_lock)
> - * @stats:                per-process binder statistics
> - *                        (atomics, no lock needed)
> - * @delivered_death:      list of delivered death notification
> - *                        (protected by @inner_lock)
> - * @max_threads:          cap on number of binder threads
> - *                        (protected by @inner_lock)
> - * @requested_threads:    number of binder threads requested but not
> - *                        yet started. In current implementation, can
> - *                        only be 0 or 1.
> - *                        (protected by @inner_lock)
> - * @requested_threads_started: number binder threads started
> - *                        (protected by @inner_lock)
> - * @tmp_ref:              temporary reference to indicate proc is in use
> - *                        (protected by @inner_lock)
> - * @default_priority:     default scheduler priority
> - *                        (invariant after initialized)
> - * @debugfs_entry:        debugfs node
> - * @alloc:                binder allocator bookkeeping
> - * @context:              binder_context for this proc
> - *                        (invariant after initialized)
> - * @inner_lock:           can nest under outer_lock and/or node lock
> - * @outer_lock:           no nesting under innor or node lock
> - *                        Lock order: 1) outer, 2) node, 3) inner
> - * @binderfs_entry:       process-specific binderfs log file
> - *
> - * Bookkeeping structure for binder processes
> - */
> -struct binder_proc {
> -       struct hlist_node proc_node;
> -       struct rb_root threads;
> -       struct rb_root nodes;
> -       struct rb_root refs_by_desc;
> -       struct rb_root refs_by_node;
> -       struct list_head waiting_threads;
> -       int pid;
> -       struct task_struct *tsk;
> -       struct hlist_node deferred_work_node;
> -       int deferred_work;
> -       bool is_dead;
> -
> -       struct list_head todo;
> -       struct binder_stats stats;
> -       struct list_head delivered_death;
> -       int max_threads;
> -       int requested_threads;
> -       int requested_threads_started;
> -       int tmp_ref;
> -       long default_priority;
> -       struct dentry *debugfs_entry;
> -       struct binder_alloc alloc;
> -       struct binder_context *context;
> -       spinlock_t inner_lock;
> -       spinlock_t outer_lock;
> -       struct dentry *binderfs_entry;
> -};
> -
>  enum {
>         BINDER_LOOPER_STATE_REGISTERED  = 0x01,
>         BINDER_LOOPER_STATE_ENTERED     = 0x02,
> @@ -495,60 +368,6 @@ enum {
>  };
>
>  /**
> - * struct binder_thread - binder thread bookkeeping
> - * @proc:                 binder process for this thread
> - *                        (invariant after initialization)
> - * @rb_node:              element for proc->threads rbtree
> - *                        (protected by @proc->inner_lock)
> - * @waiting_thread_node:  element for @proc->waiting_threads list
> - *                        (protected by @proc->inner_lock)
> - * @pid:                  PID for this thread
> - *                        (invariant after initialization)
> - * @looper:               bitmap of looping state
> - *                        (only accessed by this thread)
> - * @looper_needs_return:  looping thread needs to exit driver
> - *                        (no lock needed)
> - * @transaction_stack:    stack of in-progress transactions for this thread
> - *                        (protected by @proc->inner_lock)
> - * @todo:                 list of work to do for this thread
> - *                        (protected by @proc->inner_lock)
> - * @process_todo:         whether work in @todo should be processed
> - *                        (protected by @proc->inner_lock)
> - * @return_error:         transaction errors reported by this thread
> - *                        (only accessed by this thread)
> - * @reply_error:          transaction errors reported by target thread
> - *                        (protected by @proc->inner_lock)
> - * @wait:                 wait queue for thread work
> - * @stats:                per-thread statistics
> - *                        (atomics, no lock needed)
> - * @tmp_ref:              temporary reference to indicate thread is in use
> - *                        (atomic since @proc->inner_lock cannot
> - *                        always be acquired)
> - * @is_dead:              thread is dead and awaiting free
> - *                        when outstanding transactions are cleaned up
> - *                        (protected by @proc->inner_lock)
> - *
> - * Bookkeeping structure for binder threads.
> - */
> -struct binder_thread {
> -       struct binder_proc *proc;
> -       struct rb_node rb_node;
> -       struct list_head waiting_thread_node;
> -       int pid;
> -       int looper;              /* only modified by this thread */
> -       bool looper_need_return; /* can be written by other thread */
> -       struct binder_transaction *transaction_stack;
> -       struct list_head todo;
> -       bool process_todo;
> -       struct binder_error return_error;
> -       struct binder_error reply_error;
> -       wait_queue_head_t wait;
> -       struct binder_stats stats;
> -       atomic_t tmp_ref;
> -       bool is_dead;
> -};
> -
> -/**
>   * struct binder_txn_fd_fixup - transaction fd fixup list element
>   * @fixup_entry:          list entry
>   * @file:                 struct file to be associated with new fd
> @@ -565,34 +384,6 @@ struct binder_txn_fd_fixup {
>         size_t offset;
>  };
>
>

extra empty line?

> -struct binder_transaction {
> -       int debug_id;
> -       struct binder_work work;
> -       struct binder_thread *from;
> -       struct binder_transaction *from_parent;
> -       struct binder_proc *to_proc;
> -       struct binder_thread *to_thread;
> -       struct binder_transaction *to_parent;
> -       unsigned need_reply:1;
> -       /* unsigned is_dead:1; */       /* not used at the moment */
> -
> -       struct binder_buffer *buffer;
> -       unsigned int    code;
> -       unsigned int    flags;
> -       long    priority;
> -       long    saved_priority;
> -       kuid_t  sender_euid;
> -       struct list_head fd_fixups;
> -       binder_uintptr_t security_ctx;
> -       /**
> -        * @lock:  protects @from, @to_proc, and @to_thread
> -        *
> -        * @from, @to_proc, and @to_thread can be set to NULL
> -        * during thread teardown
> -        */
> -       spinlock_t lock;
> -};
> -
>  /**
>   * struct binder_object - union of flat binder object types
>   * @hdr:   generic object header
> @@ -613,6 +404,26 @@ struct binder_object {
>         };
>  };
>
> +static void (*__binder_update_info_cb)(struct binder_transaction *t,
> +                                       struct binder_transaction_log_entry *e);
> +
> +void set_binder_update_info_cb(void (*fn)(struct binder_transaction *t,
> +                                       struct binder_transaction_log_entry *e))
> +{
> +       __binder_update_info_cb = fn;
> +}
> +EXPORT_SYMBOL_GPL(set_binder_update_info_cb);
> +
> +static void (*__print_transaction_ext_cb)(struct seq_file *m,
> +                                       struct binder_transaction *t);
> +
> +void set_print_transaction_ext_cb(void (*fn)(struct seq_file *m,
> +                                       struct binder_transaction *t))
> +{
> +       __print_transaction_ext_cb = fn;
> +}
> +EXPORT_SYMBOL_GPL(set_print_transaction_ext_cb);

Why can't we use tracepoints (not trace events) for this instead of
custom registration functions? You can attach to the tracepoint with
register_trace_* lets a module register to be called to handle the
tracepoint as Joel pointed out.

> +
>  /**
>   * binder_proc_lock() - Acquire outer lock for given binder_proc
>   * @proc:         struct binder_proc to acquire
> @@ -1927,6 +1738,7 @@ static void binder_free_transaction(struct binder_transaction *t)
>          * If the transaction has no target_proc, then
>          * t->buffer->transaction has already been cleared.
>          */
> +       trace_binder_free_transaction(t);
>         binder_free_txn_fixups(t);
>         kfree(t);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION);
> @@ -2874,6 +2686,7 @@ static void binder_transaction(struct binder_proc *proc,
>         e->offsets_size = tr->offsets_size;
>         strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
>
> +

why 2 empty lines?

>         if (reply) {
>                 binder_inner_proc_lock(proc);
>                 in_reply_to = thread->transaction_stack;
> @@ -3060,6 +2873,9 @@ static void binder_transaction(struct binder_proc *proc,
>                 return_error_line = __LINE__;
>                 goto err_alloc_t_failed;
>         }
> +
> +       if (__binder_update_info_cb)
> +               __binder_update_info_cb(t, e);

This should be a tracepoint that your module can attach to with
register_trace_binder_update_info(...)

>         INIT_LIST_HEAD(&t->fd_fixups);
>         binder_stats_created(BINDER_STAT_TRANSACTION);
>         spin_lock_init(&t->lock);
> @@ -3498,6 +3314,7 @@ static void binder_transaction(struct binder_proc *proc,
>         kfree(tcomplete);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
>  err_alloc_tcomplete_failed:
> +       trace_binder_free_transaction(t);
>         kfree(t);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  err_alloc_t_failed:
> @@ -5547,6 +5364,8 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>                    t->to_thread ? t->to_thread->pid : 0,
>                    t->code, t->flags, t->priority, t->need_reply);
>         spin_unlock(&t->lock);
> +       if (__print_transaction_ext_cb)
> +               __print_transaction_ext_cb(m, t);

same here.

>
>         if (proc != to_proc) {
>                 /*
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index ae99109..86b4960 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -12,6 +12,11 @@
>  #include <linux/types.h>
>  #include <linux/uidgid.h>
>
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +#include <linux/rtc.h>
> +#include <linux/time.h>
> +#endif
> +
>  struct binder_context {
>         struct binder_node *binder_context_mgr_node;
>         struct mutex context_mgr_node_lock;
> @@ -131,6 +136,10 @@ struct binder_transaction_log_entry {
>         uint32_t return_error;
>         uint32_t return_error_param;
>         char context_name[BINDERFS_MAX_NAME + 1];
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +       struct timespec timestamp;
> +       struct timeval tv;
> +#endif
>  };
>
>  struct binder_transaction_log {
> @@ -139,6 +148,224 @@ struct binder_transaction_log {
>         struct binder_transaction_log_entry entry[32];
>  };
>
> +enum binder_stat_types {
> +       BINDER_STAT_PROC,
> +       BINDER_STAT_THREAD,
> +       BINDER_STAT_NODE,
> +       BINDER_STAT_REF,
> +       BINDER_STAT_DEATH,
> +       BINDER_STAT_TRANSACTION,
> +       BINDER_STAT_TRANSACTION_COMPLETE,
> +       BINDER_STAT_COUNT
> +};
> +
> +struct binder_stats {
> +       atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
> +       atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
> +       atomic_t obj_created[BINDER_STAT_COUNT];
> +       atomic_t obj_deleted[BINDER_STAT_COUNT];
> +};
> +
> +/**
> + * struct binder_work - work enqueued on a worklist
> + * @entry:             node enqueued on list
> + * @type:              type of work to be performed
> + *
> + * There are separate work lists for proc, thread, and node (async).
> + */
> +struct binder_work {
> +       struct list_head entry;
> +
> +       enum {
> +               BINDER_WORK_TRANSACTION = 1,
> +               BINDER_WORK_TRANSACTION_COMPLETE,
> +               BINDER_WORK_RETURN_ERROR,
> +               BINDER_WORK_NODE,
> +               BINDER_WORK_DEAD_BINDER,
> +               BINDER_WORK_DEAD_BINDER_AND_CLEAR,
> +               BINDER_WORK_CLEAR_DEATH_NOTIFICATION,
> +       } type;
> +};
> +
> +struct binder_error {
> +       struct binder_work work;
> +       uint32_t cmd;
> +};
> +
> +/**
> + * struct binder_proc - binder process bookkeeping
> + * @proc_node:            element for binder_procs list
> + * @threads:              rbtree of binder_threads in this proc
> + *                        (protected by @inner_lock)
> + * @nodes:                rbtree of binder nodes associated with
> + *                        this proc ordered by node->ptr
> + *                        (protected by @inner_lock)
> + * @refs_by_desc:         rbtree of refs ordered by ref->desc
> + *                        (protected by @outer_lock)
> + * @refs_by_node:         rbtree of refs ordered by ref->node
> + *                        (protected by @outer_lock)
> + * @waiting_threads:      threads currently waiting for proc work
> + *                        (protected by @inner_lock)
> + * @pid                   PID of group_leader of process
> + *                        (invariant after initialized)
> + * @tsk                   task_struct for group_leader of process
> + *                        (invariant after initialized)
> + * @deferred_work_node:   element for binder_deferred_list
> + *                        (protected by binder_deferred_lock)
> + * @deferred_work:        bitmap of deferred work to perform
> + *                        (protected by binder_deferred_lock)
> + * @is_dead:              process is dead and awaiting free
> + *                        when outstanding transactions are cleaned up
> + *                        (protected by @inner_lock)
> + * @todo:                 list of work for this process
> + *                        (protected by @inner_lock)
> + * @stats:                per-process binder statistics
> + *                        (atomics, no lock needed)
> + * @delivered_death:      list of delivered death notification
> + *                        (protected by @inner_lock)
> + * @max_threads:          cap on number of binder threads
> + *                        (protected by @inner_lock)
> + * @requested_threads:    number of binder threads requested but not
> + *                        yet started. In current implementation, can
> + *                        only be 0 or 1.
> + *                        (protected by @inner_lock)
> + * @requested_threads_started: number binder threads started
> + *                        (protected by @inner_lock)
> + * @tmp_ref:              temporary reference to indicate proc is in use
> + *                        (protected by @inner_lock)
> + * @default_priority:     default scheduler priority
> + *                        (invariant after initialized)
> + * @debugfs_entry:        debugfs node
> + * @alloc:                binder allocator bookkeeping
> + * @context:              binder_context for this proc
> + *                        (invariant after initialized)
> + * @inner_lock:           can nest under outer_lock and/or node lock
> + * @outer_lock:           no nesting under innor or node lock
> + *                        Lock order: 1) outer, 2) node, 3) inner
> + * @binderfs_entry:       process-specific binderfs log file
> + *
> + * Bookkeeping structure for binder processes
> + */
> +struct binder_proc {
> +       struct hlist_node proc_node;
> +       struct rb_root threads;
> +       struct rb_root nodes;
> +       struct rb_root refs_by_desc;
> +       struct rb_root refs_by_node;
> +       struct list_head waiting_threads;
> +       int pid;
> +       struct task_struct *tsk;
> +       struct hlist_node deferred_work_node;
> +       int deferred_work;
> +       bool is_dead;
> +
> +       struct list_head todo;
> +       struct binder_stats stats;
> +       struct list_head delivered_death;
> +       int max_threads;
> +       int requested_threads;
> +       int requested_threads_started;
> +       int tmp_ref;
> +       long default_priority;
> +       struct dentry *debugfs_entry;
> +       struct binder_alloc alloc;
> +       struct binder_context *context;
> +       spinlock_t inner_lock;
> +       spinlock_t outer_lock;
> +       struct dentry *binderfs_entry;
> +};
> +
> +/**
> + * struct binder_thread - binder thread bookkeeping
> + * @proc:                 binder process for this thread
> + *                        (invariant after initialization)
> + * @rb_node:              element for proc->threads rbtree
> + *                        (protected by @proc->inner_lock)
> + * @waiting_thread_node:  element for @proc->waiting_threads list
> + *                        (protected by @proc->inner_lock)
> + * @pid:                  PID for this thread
> + *                        (invariant after initialization)
> + * @looper:               bitmap of looping state
> + *                        (only accessed by this thread)
> + * @looper_needs_return:  looping thread needs to exit driver
> + *                        (no lock needed)
> + * @transaction_stack:    stack of in-progress transactions for this thread
> + *                        (protected by @proc->inner_lock)
> + * @todo:                 list of work to do for this thread
> + *                        (protected by @proc->inner_lock)
> + * @process_todo:         whether work in @todo should be processed
> + *                        (protected by @proc->inner_lock)
> + * @return_error:         transaction errors reported by this thread
> + *                        (only accessed by this thread)
> + * @reply_error:          transaction errors reported by target thread
> + *                        (protected by @proc->inner_lock)
> + * @wait:                 wait queue for thread work
> + * @stats:                per-thread statistics
> + *                        (atomics, no lock needed)
> + * @tmp_ref:              temporary reference to indicate thread is in use
> + *                        (atomic since @proc->inner_lock cannot
> + *                        always be acquired)
> + * @is_dead:              thread is dead and awaiting free
> + *                        when outstanding transactions are cleaned up
> + *                        (protected by @proc->inner_lock)
> + *
> + * Bookkeeping structure for binder threads.
> + */
> +struct binder_thread {
> +       struct binder_proc *proc;
> +       struct rb_node rb_node;
> +       struct list_head waiting_thread_node;
> +       int pid;
> +       int looper;              /* only modified by this thread */
> +       bool looper_need_return; /* can be written by other thread */
> +       struct binder_transaction *transaction_stack;
> +       struct list_head todo;
> +       bool process_todo;
> +       struct binder_error return_error;
> +       struct binder_error reply_error;
> +       wait_queue_head_t wait;
> +       struct binder_stats stats;
> +       atomic_t tmp_ref;
> +       bool is_dead;
> +};
> +
> +struct binder_transaction {
> +       int debug_id;
> +       struct binder_work work;
> +       struct binder_thread *from;
> +       struct binder_transaction *from_parent;
> +       struct binder_proc *to_proc;
> +       struct binder_thread *to_thread;
> +       struct binder_transaction *to_parent;
> +       unsigned need_reply:1;
> +       /* unsigned is_dead:1; */       /* not used at the moment */
> +
> +       struct binder_buffer *buffer;
> +       unsigned int    code;
> +       unsigned int    flags;
> +       long    priority;
> +       long    saved_priority;
> +       kuid_t  sender_euid;
> +       struct list_head fd_fixups;
> +       binder_uintptr_t security_ctx;
> +       /**
> +        * @lock:  protects @from, @to_proc, and @to_thread
> +        *
> +        * @from, @to_proc, and @to_thread can be set to NULL
> +        * during thread teardown
> +        */
> +       spinlock_t lock;
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +       struct timespec timestamp;
> +       struct timeval tv;
> +#endif
> +};
> +
>  extern struct binder_transaction_log binder_transaction_log;
>  extern struct binder_transaction_log binder_transaction_log_failed;
> +
> +extern void set_binder_update_info_cb(void (*fn)(struct binder_transaction *t,
> +                               struct binder_transaction_log_entry *e));
> +extern void set_print_transaction_ext_cb(void (*fn)(struct seq_file *m,
> +                                       struct binder_transaction *t));
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binder_latency_tracer.c b/drivers/android/binder_latency_tracer.c
> new file mode 100644
> index 0000000..c9626f5
> --- /dev/null
> +++ b/drivers/android/binder_latency_tracer.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <uapi/linux/android/binder.h>
> +#include "binder_alloc.h"
> +#include "binder_internal.h"
> +#include "binder_trace.h"
> +
> +/*
> + * probe_binder_free_transaction - Output info of a delay transaction
> + * @t:          pointer to the over-time transaction
> + */
> +void probe_binder_free_transaction(void *ignore, struct binder_transaction *t)
> +{
> +       struct rtc_time tm;
> +       struct timespec *startime;
> +       struct timespec cur, sub_t;
> +
> +       ktime_get_ts(&cur);
> +       startime = &t->timestamp;
> +       sub_t = timespec_sub(cur, *startime);
> +
> +       /* if transaction time is over than 2 sec,
> +        * show timeout warning log.
> +        */
> +       if (sub_t.tv_sec < 2)
> +               return;
> +
> +       rtc_time_to_tm(t->tv.tv_sec, &tm);
> +
> +       spin_lock(&t->lock);
> +       pr_info_ratelimited("%d: from %d:%d to %d:%d",
> +                       t->debug_id,
> +                       t->from ? t->from->proc->pid : 0,
> +                       t->from ? t->from->pid : 0,
> +                       t->to_proc ? t->to_proc->pid : 0,
> +                       t->to_thread ? t->to_thread->pid : 0);
> +       spin_unlock(&t->lock);
> +
> +       pr_info_ratelimited(" total %u.%03ld s code %u start %lu.%03ld android %d-%02d-%02d %02d:%02d:%02d.%03lu\n",
> +                       (unsigned int)sub_t.tv_sec,
> +                       (sub_t.tv_nsec / NSEC_PER_MSEC),
> +                       t->code,
> +                       (unsigned long)startime->tv_sec,
> +                       (startime->tv_nsec / NSEC_PER_MSEC),
> +                       (tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday,
> +                       tm.tm_hour, tm.tm_min, tm.tm_sec,
> +                       (unsigned long)(t->tv.tv_usec / USEC_PER_MSEC));
> +}
> +
> +static void binder_update_info_cb(struct binder_transaction *t,
> +                          struct binder_transaction_log_entry *e)
> +{
> +       ktime_get_ts(&e->timestamp);
> +       do_gettimeofday(&e->tv);
> +       e->tv.tv_sec -= (sys_tz.tz_minuteswest * 60);
> +       memcpy(&t->timestamp, &e->timestamp, sizeof(struct timespec));
> +       memcpy(&t->tv, &e->tv, sizeof(struct timeval));
> +}
> +
> +static void print_binder_transaction_ext(struct seq_file *m,
> +                                        struct binder_transaction *t)
> +{
> +       struct rtc_time tm;
> +
> +       rtc_time_to_tm(t->tv.tv_sec, &tm);
> +       seq_printf(m,
> +                  " start %lu.%06lu android %d-%02d-%02d %02d:%02d:%02d.%03lu",
> +                  (unsigned long)t->timestamp.tv_sec,
> +                  (t->timestamp.tv_nsec / NSEC_PER_USEC),
> +                  (tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday,
> +                  tm.tm_hour, tm.tm_min, tm.tm_sec,
> +                  (unsigned long)(t->tv.tv_usec / USEC_PER_MSEC));
> +
> +}
> +
> +static int __init init_binder_latency_tracer(void)
> +{
> +       register_trace_binder_free_transaction(
> +                       probe_binder_free_transaction, NULL);
> +
> +       set_binder_update_info_cb(binder_update_info_cb);
> +       set_print_transaction_ext_cb(print_binder_transaction_ext);
> +       return 0;
> +}
> +
> +static void exit_binder_latency_tracer(void)
> +{
> +       unregister_trace_binder_free_transaction(
> +                       probe_binder_free_transaction, NULL);
> +}
> +
> +module_init(init_binder_latency_tracer);
> +module_exit(exit_binder_latency_tracer);
> +
> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> index 6731c3c..c7c76c1 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -95,6 +95,42 @@
>                   __entry->thread_todo)
>  );
>
> +TRACE_EVENT(binder_free_transaction,
> +       TP_PROTO(struct binder_transaction *t),
> +       TP_ARGS(t),
> +       TP_STRUCT__entry(
> +               __field(int, debug_id)
> +               __field(int, from_proc)
> +               __field(int, from_thread)
> +               __field(int, to_proc)
> +               __field(int, to_thread)
> +               __field(unsigned int, code)
> +               __field(unsigned int, flags)
> +               __field(unsigned long, start_sec)
> +               __field(unsigned long, start_nsec)
> +       ),
> +       TP_fast_assign(
> +               __entry->debug_id = t->debug_id;
> +               __entry->from_proc = t->from ? t->from->proc->pid : 0;
> +               __entry->from_thread = t->from ? t->from->pid : 0;
> +               __entry->to_proc = t->to_proc ? t->to_proc->pid : 0;
> +               __entry->to_thread = t->to_thread ? t->to_thread->pid : 0;
> +               __entry->code = t->code;
> +               __entry->flags = t->flags;
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +               __entry->start_sec = t->timestamp.tv_sec;
> +               __entry->start_nsec = t->timestamp.tv_nsec / NSEC_PER_MSEC;
> +#else
> +               __entry->start_sec = 0;
> +               __entry->start_nsec = 0;
> +#endif
> +       ),
> +       TP_printk("transaction=%d from %d:%d to %d:%d flags=0x%x code=0x%x start %lu.%03ld",
> +                 __entry->debug_id, __entry->from_proc, __entry->from_thread,
> +                 __entry->to_proc, __entry->to_thread, __entry->code,
> +                 __entry->flags, __entry->start_sec, __entry->start_nsec)
> +);
> +
>  TRACE_EVENT(binder_transaction,
>         TP_PROTO(bool reply, struct binder_transaction *t,
>                  struct binder_node *target_node),
> --
> 1.7.9.5
