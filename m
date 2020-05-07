Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC41AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E37D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588841748;
	bh=BYFjIQ2FXPPjn16NFH9FGYAHNpd8UOP5Qgo14rF5m9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RPT4IE8aYExO4UP6GDAfrQ+fJBW4jS/UntGlnTSAO7EpM+ocvLDWVXU2kdVk2eiet
	 Oz/dtGLfnXvPEZrbMVRkhnGvFxiPgnkQlH2AdL3Y1A89Mgsu/AV4eGuxL9tJXh/ykg
	 qsOoQ2mmJc1XSHdQxhGGVJIGNI/c/uefIXDSJjNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgEGIzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgEGIzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:55:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE94E20747;
        Thu,  7 May 2020 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588841746;
        bh=BYFjIQ2FXPPjn16NFH9FGYAHNpd8UOP5Qgo14rF5m9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZJ1Rt9yAObBobdC0tleLtv7rWr/gieWrc4lAnIStR66D/dPXZ0rkgVA1Uo0Bp/95
         Maxjg93InCPAtytBJS7rXbGw1Q+lLCaGKGA5eKPDwev8aZ+dJRYtUGCigu+yyoo/Cn
         LHWwH8Ec5kgMS9iVoeUU682k/GV11wWyiu7Tea90=
Date:   Thu, 7 May 2020 10:55:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v4 3/3] binder: add transaction latency tracer
Message-ID: <20200507085544.GB1097552@kroah.com>
References: <20200430085105.GF2496467@kroah.com>
 <1588839055-26677-1-git-send-email-Frankie.Chang@mediatek.com>
 <1588839055-26677-4-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588839055-26677-4-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:10:55PM +0800, Frankie Chang wrote:
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
> 
> Record start/end timestamp for binder transaction.
> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold (2 sec),
> if yes, printing related information for tracing.

Shouldn't that "printing" go to the trace buffer and not to the kernel
information log?

> 
> /* Implement details */
> - Add latency tracer module to monitor slow transaction.
>   The trace_binder_free_transaction would not be enabled
>   by default. Monitoring which transaction is too slow to
>   cause some of exceptions is important. So we hook the
>   tracepoint to call the monitor function.
> 
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> ---
>  drivers/android/Kconfig                 |    8 +++
>  drivers/android/Makefile                |    1 +
>  drivers/android/binder.c                |    2 +
>  drivers/android/binder_internal.h       |   13 ++++
>  drivers/android/binder_latency_tracer.c |  105 +++++++++++++++++++++++++++++++
>  drivers/android/binder_trace.h          |   26 +++++++-
>  6 files changed, 152 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/android/binder_latency_tracer.c
> 
>  Change from v4:
>    split up into patch series.
> 
>  Change from v3:
>    use tracepoints for binder_update_info and print_binder_transaction_ext,
>    instead of custom registration functions.
> 
>  Change from v2:
>    create transaction latency module to monitor slow transaction.
> 
>  Change from v1:
>    first patchset.
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 6fdf2ab..7ba80eb 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -54,6 +54,14 @@ config ANDROID_BINDER_IPC_SELFTEST
>  	  exhaustively with combinations of various buffer sizes and
>  	  alignments.
>  
> +config BINDER_USER_TRACKING
> +	bool "Android Binder transaction tracking"
> +	help
> +	  Used for track abnormal binder transaction which is over 2 seconds,
> +	  when the transaction is done or be free, this transaction would be
> +	  checked whether it executed overtime.
> +	  If yes, printing out the detail info about it.
> +
>  endif # if ANDROID
>  
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c9..552e8ac 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y += -I$(src)			# needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> +obj-$(CONFIG_BINDER_USER_TRACKING)	+= binder_latency_tracer.o
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 4c3dd98..b89d75a 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2657,6 +2657,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		return_error_line = __LINE__;
>  		goto err_alloc_t_failed;
>  	}
> +	trace_binder_update_info(t, e);
>  	INIT_LIST_HEAD(&t->fd_fixups);
>  	binder_stats_created(BINDER_STAT_TRANSACTION);
>  	spin_lock_init(&t->lock);
> @@ -5145,6 +5146,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>  		   t->to_thread ? t->to_thread->pid : 0,
>  		   t->code, t->flags, t->priority, t->need_reply);
>  	spin_unlock(&t->lock);
> +	trace_print_binder_transaction_ext(m, t);
>  
>  	if (proc != to_proc) {
>  		/*
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index ed61b3e..24d7beb 100644
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
>  	struct binder_node *binder_context_mgr_node;
>  	struct mutex context_mgr_node_lock;
> @@ -131,6 +136,10 @@ struct binder_transaction_log_entry {
>  	uint32_t return_error;
>  	uint32_t return_error_param;
>  	char context_name[BINDERFS_MAX_NAME + 1];
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +	struct timespec timestamp;
> +	struct timeval tv;
> +#endif
>  };
>  
>  struct binder_transaction_log {
> @@ -520,6 +529,10 @@ struct binder_transaction {
>  	 * during thread teardown
>  	 */
>  	spinlock_t lock;
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +	struct timespec timestamp;
> +	struct timeval tv;
> +#endif
>  };
>  
>  /**
> diff --git a/drivers/android/binder_latency_tracer.c b/drivers/android/binder_latency_tracer.c
> new file mode 100644
> index 0000000..45c14fb
> --- /dev/null
> +++ b/drivers/android/binder_latency_tracer.c
> @@ -0,0 +1,105 @@
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
> +	struct rtc_time tm;
> +	struct timespec *startime;
> +	struct timespec cur, sub_t;
> +
> +	ktime_get_ts(&cur);
> +	startime = &t->timestamp;
> +	sub_t = timespec_sub(cur, *startime);
> +
> +	/* if transaction time is over than 2 sec,
> +	 * show timeout warning log.
> +	 */
> +	if (sub_t.tv_sec < 2)
> +		return;

Why is 2 seconds somehow "magic" here?



> +
> +	rtc_time_to_tm(t->tv.tv_sec, &tm);
> +
> +	spin_lock(&t->lock);
> +	pr_info_ratelimited("%d: from %d:%d to %d:%d",
> +			t->debug_id,
> +			t->from ? t->from->proc->pid : 0,
> +			t->from ? t->from->pid : 0,
> +			t->to_proc ? t->to_proc->pid : 0,
> +			t->to_thread ? t->to_thread->pid : 0);
> +	spin_unlock(&t->lock);

Why is the lock ok to give up here and not after the next call?

> +
> +	pr_info_ratelimited(" total %u.%03ld s code %u start %lu.%03ld android %d-%02d-%02d %02d:%02d:%02d.%03lu\n",
> +			(unsigned int)sub_t.tv_sec,
> +			(sub_t.tv_nsec / NSEC_PER_MSEC),
> +			t->code,
> +			(unsigned long)startime->tv_sec,
> +			(startime->tv_nsec / NSEC_PER_MSEC),
> +			(tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday,
> +			tm.tm_hour, tm.tm_min, tm.tm_sec,
> +			(unsigned long)(t->tv.tv_usec / USEC_PER_MSEC));
> +}
> +
> +static void probe_binder_update_info(void *ignore, struct binder_transaction *t,
> +			   struct binder_transaction_log_entry *e)
> +{
> +	ktime_get_ts(&e->timestamp);
> +	do_gettimeofday(&e->tv);
> +	e->tv.tv_sec -= (sys_tz.tz_minuteswest * 60);
> +	memcpy(&t->timestamp, &e->timestamp, sizeof(struct timespec));
> +	memcpy(&t->tv, &e->tv, sizeof(struct timeval));

No locking needed?

