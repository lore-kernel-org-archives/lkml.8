Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4035C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B452086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJwPUyB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgHDP3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgHDP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:29:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 08:28:59 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a14so13227557edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qz0uyd2oTFho9/GrSW3hgOzK1cOa8xkZyPezxVTDkA8=;
        b=vJwPUyB6NTKWhSPbZO0F9/xBYgpcoi1DspWPgIXL1ODwuja/QeoOb793IgX+2ADWd4
         RPG/y4+BtO8jT7/s+/eoXrZjqWqso10kcs3Fkpi8FPLq2gR6/wDLpesqmdRzVxfOUET/
         jHRDhxBqVb/PQEfzQhpQ97+tE0t66OcCOP+Yg33N/SbBgeiB8S5M6tLDLWlCu9WR5omu
         s2VjE8YWoZ1M7hIvG6oteih5jpu/eRLBeEI72GPE0pjjuEfRmDusA5iHDjsyT+6Mhqap
         tCD3aZjbQ/KhUbW7IC0BdSa8GxyKBvkDeZtJ8PQlCKUXbuPh68fj2I4QqmGPnTrOZxfP
         gasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qz0uyd2oTFho9/GrSW3hgOzK1cOa8xkZyPezxVTDkA8=;
        b=HssFyLNjdLoCiQu8W5UMQWFJFcPoegY7fFdMwUH5ktOmtqSVtW/QmuzcLGviACnL15
         i1m6dmPgWtMRtimpuixvVlmWdcoSOSGBb08cCUGInPVd1d4u8pWcpGzsK7ttHWBWIy8h
         ygimrkByRKeALwehb9GVPKdi2e5RPNELGmta53LGEEwOhjuUc95FovQ6RNsFZz/pW/nn
         nBQ6+NK+dal9HOaRxPxkkK1BRc99Q+qBjdJ2K47wumIFQ0Ea7ZD6TOF9nXR2Nk5SKsZg
         T9RX1ee7P5VT/0jwYjROvyEyol4/jJrddsxdkfid+NSZ9ISpifNlyDJAUPpkorPRXiyb
         TQlQ==
X-Gm-Message-State: AOAM532sQqYHpBzcZFr2Rx5u/qkcCx2E6c9WL5JRNgWmrIUZXSdVDFzN
        ibXxnACdX/argaXn+ArfysMnlE0ZdtG4U8k2W4wr5A==
X-Google-Smtp-Source: ABdhPJxmG6yqhpXzX30yLHrzwgrDpySmv1MdIB61dxD/UV2pHTTowOScOBXnQzZeWMxe23x5oxrcEKpASCMy+YAEc3c=
X-Received: by 2002:a50:fc02:: with SMTP id i2mr21408148edr.121.1596554937967;
 Tue, 04 Aug 2020 08:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <1596509145.5207.21.camel@mtkswgap22> <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
 <1596549552-5466-4-git-send-email-Frankie.Chang@mediatek.com>
In-Reply-To: <1596549552-5466-4-git-send-email-Frankie.Chang@mediatek.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 4 Aug 2020 08:28:45 -0700
Message-ID: <CAHRSSEw4mVg7hXp+bdK+E0z19EaszZ_-XVDHETj8wEd9RhOnxw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] binder: add transaction latency tracer
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

On Tue, Aug 4, 2020 at 6:59 AM Frankie Chang <Frankie.Chang@mediatek.com> wrote:
>
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
>
> Record start/end timestamp for binder transaction.
> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold
> (default 2 sec), if yes, printing related information for tracing.
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
>   Therefore, setting the timeout threshold as default
>   2 seconds could be helpful to debug.
>   But this timeout threshold is configurable, to let
>   all users determine the more suitable threshold.
>
> - The reason why printing the related information to
>   kernel information log but not trace buffer is that
>   some abnormal transactions may be pending for a long
>   time ago, they could not be recorded due to buffer
>   limited.
>
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/Kconfig                 |    8 +++
>  drivers/android/Makefile                |    1 +
>  drivers/android/binder.c                |    2 +
>  drivers/android/binder_internal.h       |   13 ++++
>  drivers/android/binder_latency_tracer.c |  112 +++++++++++++++++++++++++++++++
>  drivers/android/binder_trace.h          |   26 ++++++-
>  6 files changed, 159 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/android/binder_latency_tracer.c
>
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 6fdf2ab..91fff1e 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -54,6 +54,14 @@ config ANDROID_BINDER_IPC_SELFTEST
>           exhaustively with combinations of various buffer sizes and
>           alignments.
>
> +config BINDER_TRANSACTION_LATENCY_TRACKING
> +       tristate "Android Binder transaction tracking"
> +       help
> +         Used for track abnormal binder transaction which is over threshold,
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
> index 1bfadc2..22f7cc6 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2671,6 +2671,7 @@ static void binder_transaction(struct binder_proc *proc,
>                 return_error_line = __LINE__;
>                 goto err_alloc_t_failed;
>         }
> +       trace_binder_txn_latency_alloc(t);
>         INIT_LIST_HEAD(&t->fd_fixups);
>         binder_stats_created(BINDER_STAT_TRANSACTION);
>         spin_lock_init(&t->lock);
> @@ -5159,6 +5160,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>                    to_proc ? to_proc->pid : 0,
>                    t->to_thread ? t->to_thread->pid : 0,
>                    t->code, t->flags, t->priority, t->need_reply);
> +       trace_binder_txn_latency_info(m, t);
>         spin_unlock(&t->lock);
>
>         if (proc != to_proc) {
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 5b65413..596db00 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -13,6 +13,11 @@
>  #include <linux/uidgid.h>
>  #include "binder_alloc.h"
>
> +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> +#include <linux/rtc.h>
> +#include <linux/time.h>
> +#endif
> +
>  struct binder_context {
>         struct binder_node *binder_context_mgr_node;
>         struct mutex context_mgr_node_lock;
> @@ -521,6 +526,14 @@ struct binder_transaction {
>          * during thread teardown
>          */
>         spinlock_t lock;
> +       /**
> +        * @timestamp and @tv are used to record the time
> +        * that the binder transaction startup
> +        */
> +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> +       struct timespec64 timestamp;
> +       struct timeval tv;
> +#endif
>  };
>
>  /**
> diff --git a/drivers/android/binder_latency_tracer.c b/drivers/android/binder_latency_tracer.c
> new file mode 100644
> index 0000000..61ae75f
> --- /dev/null
> +++ b/drivers/android/binder_latency_tracer.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <uapi/linux/android/binder.h>
> +#include "binder_internal.h"
> +#include "binder_trace.h"
> +
> +/**
> + * The reason setting the binder_txn_latency_threshold to 2 sec
> + * is that most of timeout abort is greater or equal to 2 sec.
> + * Making it configurable to let all users determine which
> + * threshold is more suitable.
> + */
> +static uint32_t binder_txn_latency_threshold = 2;
> +module_param_named(threshold, binder_txn_latency_threshold,
> +                       uint, 0644);
> +
> +/*
> + * probe_binder_txn_latency_free - Output info of a delay transaction
> + * @t:          pointer to the over-time transaction
> + */
> +void probe_binder_txn_latency_free(void *ignore, struct binder_transaction *t,
> +                                       int from_proc, int from_thread,
> +                                       int to_proc, int to_thread)
> +{
> +       struct rtc_time tm;
> +       struct timespec64 *startime;
> +       struct timespec64 cur, sub_t;
> +
> +       ktime_get_ts64(&cur);
> +       startime = &t->timestamp;
> +       sub_t = timespec64_sub(cur, *startime);
> +
> +       /* if transaction time is over than binder_txn_latency_threshold (sec),
> +        * show timeout warning log.
> +        */
> +       if (sub_t.tv_sec < binder_txn_latency_threshold)
> +               return;
> +
> +       rtc_time_to_tm(t->tv.tv_sec, &tm);
> +
> +       pr_info_ratelimited("%d: from %d:%d to %d:%d",
> +                       t->debug_id, from_proc, from_thread,
> +                       to_proc, to_thread);
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
> +static void probe_binder_txn_latency_alloc(void *ignore,
> +                                       struct binder_transaction *t)
> +{
> +       struct timespec64 now;
> +
> +       ktime_get_ts64(&t->timestamp);
> +       ktime_get_real_ts64(&now);
> +       t->tv.tv_sec = now.tv_sec;
> +       t->tv.tv_sec -= (sys_tz.tz_minuteswest * 60);
> +       t->tv.tv_usec = now.tv_nsec/1000;
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
> index eb2c53c..be4fe4c 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -95,6 +95,17 @@
>                   __entry->thread_todo)
>  );
>
> +DECLARE_TRACE(binder_txn_latency_alloc,
> +       TP_PROTO(struct binder_transaction *t),
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
>         TP_PROTO(struct binder_transaction *t
>                  int from_proc, int from_thread
> @@ -108,6 +119,8 @@
>                 __field(int, to_thread)
>                 __field(unsigned int, code)
>                 __field(unsigned int, flags)
> +               __field(unsigned long, start_sec)
> +               __field(unsigned long, start_nsec)
>         ),
>         TP_fast_assign(
>                 __entry->debug_id = t->debug_id;
> @@ -117,11 +130,18 @@
>                 __entry->to_thread = to_thread;
>                 __entry->code = t->code;
>                 __entry->flags = t->flags;
> -       ),
> -       TP_printk("transaction=%d from %d:%d to %d:%d flags=0x%x code=0x%x",
> +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
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
