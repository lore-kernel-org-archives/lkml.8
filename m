Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC169C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B4722B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQp/Ckp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgGTS4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgGTS4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:56:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:56:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b15so13573749edy.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIdXm6p1PfumxCuesOuPpgIXKejAEnHE4gkCzcVS5rE=;
        b=oQp/Ckp1Qzy3I8T1Jwnkrh8MBCMM7cYnzwk6izGPQPm+omxP8ZjOGLrUu5yVsQOQ4h
         WAKdQtXodGvQ15zPq/rnR7WNg3qn64wX3AnnqZkZHvs8ERzG4G27x61Xb2bWZvQFv5w3
         Dm7SvQ+hISAQtEyOlXVCIadPcRtJCdARMDvf6twThNlUdJx+rPHPwuGaHHrRVop5iwo0
         ph3N4H07RCXDxypKBM5KfAfBHCNgh4umTWm9r0m4tbYxwKyQPY1a287+Ar5kebe919Uh
         v0Cldm192Z/pL5rzPRxFhJsFHuKOrgJdN8kcSN2FqX44waJd67IUIQmHqGEvTK1ICOLT
         HjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIdXm6p1PfumxCuesOuPpgIXKejAEnHE4gkCzcVS5rE=;
        b=Rj45s61yXp0kozJCyJRE66eXahgTqQIrvsXe/LFBXvfcn1e37ZSGZnmqBtt4SckcTM
         IUTg/2aqVZdJt1uSDZ0dY/Z8f/VdErJz2xMBK3mhOSIiIxV/eJQddukgb0re01AjfKE0
         x3MDK4TC7S6DNBs4Ky/M5PFeFomNfvhRPBOqBSjHIHAN3yNFvV3gMOCSoHv2mwy5qAyU
         iDuy4L+v3y0pwjmwQQ4ITBqp1pUwwPUkczrNfGiA7gAmm/2WnJ+cCKz6MPbCS1ke8mE3
         T48PHeKoYFxkIIrvTSOIRh4/o4XH2HG2J9x5+YnSmbBAkZE4l8MAJNXxcpC7nlSQHZZW
         /5wg==
X-Gm-Message-State: AOAM531BgNp5au+4SjuaVERkdA/6P5b3vh8/LsnuFVZr6gNBP9i8QG0Y
        wGLxt+QKfkfHCGvqiTeVJ+jZ5CBkRPvkwvKat2PxIA==
X-Google-Smtp-Source: ABdhPJyMFpCkDUlR4Xbw+8PLVHG03vAhP2feoblMQOwMbJE6jsDOamYLT+sdEKXKrGH+9om/9vMWGjCDObGVHUZ4h+g=
X-Received: by 2002:a50:d7c1:: with SMTP id m1mr23155075edj.217.1595271397747;
 Mon, 20 Jul 2020 11:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200507085544.GB1097552@kroah.com> <1591791827-23871-1-git-send-email-Frankie.Chang@mediatek.com>
 <1591791827-23871-4-git-send-email-Frankie.Chang@mediatek.com>
In-Reply-To: <1591791827-23871-4-git-send-email-Frankie.Chang@mediatek.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 20 Jul 2020 11:56:25 -0700
Message-ID: <CAHRSSExO8uiwNELR+DjKYGEXO-Lr-0i8BBQDH5PwkxBVXiCtNw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] binder: add transaction latency tracer
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
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

On Wed, Jun 10, 2020 at 5:34 AM Frankie Chang
<Frankie.Chang@mediatek.com> wrote:
>
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
>
> Record start/end timestamp for binder transaction.
> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold (2 sec),
> if yes, printing related information for tracing.
>
> /* Implement details */
> - Add latency tracer module to monitor transaction
>   by attaching to new tracepoints introduced
>   when transactions are allocated and freed.
>   The trace_binder_txn_latency_free would not be enabled
>   by default. Monitoring which transaction is too slow to
>   cause some of exceptions is important. So we hook the
>   tracepoint to call the monitor function.
>
> - Since some of modules would trigger timeout NE
>   if their binder transaction don't finish in time,
>   such as audio timeout (5 sec), even BT command
>   timeout (2 sec), etc.
>   Therefore, setting the timeout threshold as 2 seconds
>   could be helpful to debug.

Could there be cases that 500ms is too long so 1s should be the
threshold? Hard coded 2 seconds makes this less useful. How about
making it configurable with a default of 2 sec?

>
> - The reason why printing the related information to
>   kernel information log but not trace buffer is that
>   some abnormal transactions may be pending for a long
>   time ago, they could not be recorded due to buffer
>   limited.
>
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> ---
>  drivers/android/Kconfig                 |    8 +++
>  drivers/android/Makefile                |    1 +
>  drivers/android/binder.c                |    2 +
>  drivers/android/binder_internal.h       |   13 ++++
>  drivers/android/binder_latency_tracer.c |  107 +++++++++++++++++++++++++++++++
>  drivers/android/binder_trace.h          |   28 +++++++-
>  6 files changed, 156 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/android/binder_latency_tracer.c
>
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 6fdf2ab..39d47be 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -54,6 +54,14 @@ config ANDROID_BINDER_IPC_SELFTEST
>           exhaustively with combinations of various buffer sizes and
>           alignments.
>
> +config BINDER_TRANSACTION_LATENCY_TRACKING
> +       bool "Android Binder transaction tracking"

Any reason this can't be tristate?

> +       help
> +         Used for track abnormal binder transaction which is over 2 seconds,
> +         when the transaction is done or be free, this transaction would be
> +         checked whether it executed overtime.
> +         If yes, printing out the detailed info.
> +
>  endif # if ANDROID
>
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c9..c2ffdb6 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y += -I$(src)                   # needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)         += binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)       += binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> +obj-$(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)      += binder_latency_tracer.o
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 5ec9af8..846d69b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2657,6 +2657,7 @@ static void binder_transaction(struct binder_proc *proc,
>                 return_error_line = __LINE__;
>                 goto err_alloc_t_failed;
>         }
> +       trace_binder_txn_latency_alloc(t, e);
>         INIT_LIST_HEAD(&t->fd_fixups);
>         binder_stats_created(BINDER_STAT_TRANSACTION);
>         spin_lock_init(&t->lock);
> @@ -5144,6 +5145,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>                    to_proc ? to_proc->pid : 0,
>                    t->to_thread ? t->to_thread->pid : 0,
>                    t->code, t->flags, t->priority, t->need_reply);
> +       trace_binder_txn_latency_info(m, t);
>         spin_unlock(&t->lock);
>
>         if (proc != to_proc) {
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index ed61b3e..bebc185 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -12,6 +12,11 @@
>  #include <linux/types.h>
>  #include <linux/uidgid.h>
>
> +#ifdef CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING
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
> +#ifdef CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING

If you make binder_latency_tracer a module, then we could include
these fields unconditionally. Please add comments or give them better
names so it is obvious what they are for.

> +       struct timespec timestamp;
> +       struct timeval tv;
> +#endif
>  };
>
>  struct binder_transaction_log {
> @@ -520,6 +529,10 @@ struct binder_transaction {
>          * during thread teardown
>          */
>         spinlock_t lock;
> +#ifdef CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING

If you make binder_latency_tracer a module, then we could include
these fields unconditionally. Please add comments or give them better
names so it is obvious what they are for.

> +       struct timespec timestamp;
> +       struct timeval tv;
> +#endif
>  };
>
>  /**
> diff --git a/drivers/android/binder_latency_tracer.c b/drivers/android/binder_latency_tracer.c
> new file mode 100644
> index 0000000..1b89634
> --- /dev/null
> +++ b/drivers/android/binder_latency_tracer.c
> @@ -0,0 +1,107 @@
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
> + * probe_binder_txn_latency_free - Output info of a delay transaction
> + * @t:          pointer to the over-time transaction
> + */
> +void probe_binder_txn_latency_free(void *ignore, struct binder_transaction *t)
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

I still don't get why 2sec is magical. Should this threshold be configurable?

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
> +       spin_unlock(&t->lock);
> +}
> +
> +static void probe_binder_txn_latency_alloc(void *ignore,
> +                                       struct binder_transaction *t,
> +                                       struct binder_transaction_log_entry *e)
> +{
> +       ktime_get_ts(&e->timestamp);
> +       do_gettimeofday(&e->tv);
> +       e->tv.tv_sec -= (sys_tz.tz_minuteswest * 60);
> +       spin_lock(&t->lock);
> +       memcpy(&t->timestamp, &e->timestamp, sizeof(struct timespec));
> +       memcpy(&t->tv, &e->tv, sizeof(struct timeval));
> +       spin_unlock(&t->lock);

Why is the lock needed here?

> +}
> +
> +static void probe_binder_txn_latency_info(void *ignore, struct seq_file *m,
> +                                       struct binder_transaction *t)
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
> +}
> +
> +static int __init init_binder_latency_tracer(void)
> +{
> +       register_trace_binder_txn_latency_free(
> +                       probe_binder_txn_latency_free, NULL);
> +       register_trace_binder_txn_latency_alloc(
> +                       probe_binder_txn_latency_alloc, NULL);
> +       register_trace_binder_txn_latency_info(
> +                       probe_binder_txn_latency_info, NULL);
> +
> +       return 0;
> +}
> +
> +static void exit_binder_latency_tracer(void)
> +{
> +       unregister_trace_binder_txn_latency_free(
> +                       probe_binder_txn_latency_free, NULL);
> +       unregister_trace_binder_txn_latency_alloc(
> +                       probe_binder_txn_latency_alloc, NULL);
> +       unregister_trace_binder_txn_latency_info(
> +                       probe_binder_txn_latency_info, NULL);
> +}
> +
> +module_init(init_binder_latency_tracer);
> +module_exit(exit_binder_latency_tracer);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> index 8ac87d1..ca41c7d 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -18,6 +18,7 @@
>  struct binder_ref_data;
>  struct binder_thread;
>  struct binder_transaction;
> +struct binder_transaction_log_entry;
>
>  TRACE_EVENT(binder_ioctl,
>         TP_PROTO(unsigned int cmd, unsigned long arg),
> @@ -95,6 +96,18 @@
>                   __entry->thread_todo)
>  );
>
> +DECLARE_TRACE(binder_txn_latency_alloc,
> +       TP_PROTO(struct binder_transaction *t,
> +                struct binder_transaction_log_entry *e),
> +       TP_ARGS(t, e)
> +);
> +
> +DECLARE_TRACE(binder_txn_latency_info,
> +       TP_PROTO(struct seq_file *m,
> +                struct binder_transaction *t),
> +       TP_ARGS(m, t)
> +);
> +
>  TRACE_EVENT(binder_txn_latency_free,
>         TP_PROTO(struct binder_transaction *t),
>         TP_ARGS(t),
> @@ -106,6 +119,8 @@
>                 __field(int, to_thread)
>                 __field(unsigned int, code)
>                 __field(unsigned int, flags)
> +               __field(unsigned long, start_sec)
> +               __field(unsigned long, start_nsec)
>         ),
>         TP_fast_assign(
>                 __entry->debug_id = t->debug_id;
> @@ -115,11 +130,18 @@
>                 __entry->to_thread = t->to_thread ? t->to_thread->pid : 0;
>                 __entry->code = t->code;
>                 __entry->flags = t->flags;
> -       ),
> -       TP_printk("transaction=%d from %d:%d to %d:%d flags=0x%x code=0x%x",
> +#ifdef CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING
> +               __entry->start_sec = t->timestamp.tv_sec;
> +               __entry->start_nsec = t->timestamp.tv_nsec / NSEC_PER_MSEC;
> +#else
> +               __entry->start_sec = 0;
> +               __entry->start_nsec = 0;
> +#endif
> +       ),
> +       TP_printk("transaction=%d from %d:%d to %d:%d flags=0x%x code=0x%x start %lu.%03ld",
>                   __entry->debug_id, __entry->from_proc, __entry->from_thread,
>                   __entry->to_proc, __entry->to_thread, __entry->code,
> -                 __entry->flags)
> +                 __entry->flags, __entry->start_sec, __entry->start_nsec)
>  );
>
>  TRACE_EVENT(binder_transaction,
> --
> 1.7.9.5
