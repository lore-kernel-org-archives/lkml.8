Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA19C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E73520842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y1OT88DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgBKPel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:34:41 -0500
Received: from mail.efficios.com ([167.114.26.124]:57738 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgBKPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:34:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D2F8124D39B;
        Tue, 11 Feb 2020 10:34:38 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u37PMzezf1Ti; Tue, 11 Feb 2020 10:34:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 60F1B24D39A;
        Tue, 11 Feb 2020 10:34:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 60F1B24D39A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581435278;
        bh=rr1aKD7kob9ySyEkFIfkdd3vwJ6JRwV1d88PnbfBT94=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Y1OT88DYHp+rktMNy/2jF4xqvUjdjTkEYWmR+GF3Hm1AwkwVppC9S/rzCn1DqmZAE
         UBCIHbLq4JhcKF6fSspaF3ctarzh/18Sx8xOJwQDMOktlTOSPumK4RszEPGLAvywNz
         a22ecpZmC6Mq7lqsOas+5DTzi0ml5sL67+cnAdZVrFoEDbHmmUV7aOWPXs6T/NfF52
         /LjnCkpFwp3E5j4KL5/XtlR0Y6fUtOV26gAtvsWEOzAy3B12B4nJLlGfMmiuRlRESN
         m0SXvbkghvehaVlyAplUtxFI4Ud2eamkR/cLfL0Q2Vs4dZ3sETRqnEcaB6mvzyjXnA
         +f0zZR0CqF40w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YGXEbx900gUT; Tue, 11 Feb 2020 10:34:38 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 47F5E24D501;
        Tue, 11 Feb 2020 10:34:38 -0500 (EST)
Date:   Tue, 11 Feb 2020 10:34:38 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <504801580.617591.1581435278202.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200211095047.58ddf750@gandalf.local.home>
References: <20200211095047.58ddf750@gandalf.local.home>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
Thread-Index: j8/1tXixm2DBCk8J3tUa0zdteip7dQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 11, 2020, at 9:50 AM, rostedt rostedt@goodmis.org wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Commit e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use
> SRCU") removed the calls to rcu_irq_enter/exit_irqson() and replaced it with
> srcu callbacks as that much faster for the rcuidle cases. But this caused an
> issue with perf, because perf only uses rcu to synchronize its trace point
> callback routines.
> 
> The issue was that if perf traced one of the "rcuidle" paths, that path no
> longer enabled RCU if it was not watching, and this caused lockdep to
> complain when the perf code used rcu_read_lock() and RCU was not "watching".
> 
> Commit 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for
> rcuidle tracepoints") added back the rcu_irq_enter/exit_irqson() code, but
> this made the srcu changes no longer applicable.
> 
> As perf is the only callback that needs the heavier weight
> "rcu_irq_enter/exit_irqson()" calls, move it to the perf specific code and
> not bog down those that do not require it.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes since v1:
> 
>  - Moved the rcu_is_watching logic to perf_tp_event() and remove the
>    exporting of rcu_irq_enter/exit_irqson().
> 
> include/linux/tracepoint.h |  8 ++------
> kernel/events/core.c       | 17 ++++++++++++++++-
> 2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 1fb11daa5c53..a83fd076a312 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -179,10 +179,8 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 		 * For rcuidle callers, use srcu since sched-rcu	\
> 		 * doesn't work from the idle path.			\
> 		 */							\
> -		if (rcuidle) {						\
> +		if (rcuidle)						\
> 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> -			rcu_irq_enter_irqson();				\
> -		}							\
> 									\
> 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> 									\
> @@ -194,10 +192,8 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 			} while ((++it_func_ptr)->func);		\
> 		}							\
> 									\
> -		if (rcuidle) {						\
> -			rcu_irq_exit_irqson();				\
> +		if (rcuidle)						\
> 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> -		}							\
> 									\
> 		preempt_enable_notrace();				\
> 	} while (0)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 455451d24b4a..0abbf5e2ee62 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8941,6 +8941,7 @@ void perf_tp_event(u16 event_type, u64 count, void
> *record, int entry_size,
> {
> 	struct perf_sample_data data;
> 	struct perf_event *event;
> +	bool rcu_watching = rcu_is_watching();
> 
> 	struct perf_raw_record raw = {
> 		.frag = {
> @@ -8949,6 +8950,17 @@ void perf_tp_event(u16 event_type, u64 count, void
> *record, int entry_size,
> 		},
> 	};
> 
> +	if (!rcu_watching) {
> +		/*
> +		 * If nmi_enter() is traced, it is possible that
> +		 * RCU may not be watching "yet", and this is called.
> +		 * We can not call rcu_irq_enter_irqson() in this case.
> +		 */
> +		if (unlikely(in_nmi()))
> +			goto out;
> +		rcu_irq_enter_irqson();
> +	}
> +
> 	perf_sample_data_init(&data, 0, 0);
> 	data.raw = &raw;

I'm puzzled by this function. It does:

perf_tp_event(...)
{
     hlist_for_each_entry_rcu(event, head, hlist_entry) {
         ...
     }
     if (task && task != current) {
         rcu_read_lock();
         ... = rcu_dereference();
         list_for_each_entry_rcu(...) {
             ....
         }
         rcu_read_unlock();
     }
}

What is the purpose of the rcu_read_lock/unlock within the if (),
considering that there is already an hlist rcu iteration just before ?
It seems to assume that a RCU read-side of some kind of already
ongoing.

Thanks,

Mathieu


> 
> @@ -8985,8 +8997,11 @@ void perf_tp_event(u16 event_type, u64 count, void
> *record, int entry_size,
> unlock:
> 		rcu_read_unlock();
> 	}
> -
> +	if (!rcu_watching)
> +		rcu_irq_exit_irqson();
> +out:
> 	perf_swevent_put_recursion_context(rctx);
> +
> }
> EXPORT_SYMBOL_GPL(perf_tp_event);
> 
> --
> 2.20.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
