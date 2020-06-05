Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B30C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B2F206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NR2p23lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgFEPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgFEPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:25:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E7C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 08:25:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f3so5032832pfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TICGsSDFeAQRfi9mfXDkz3sCl/QfHpv30Btf6TeiWPU=;
        b=NR2p23lfHjw0UHC+u+60srGErtkhWXjJQMO5fDD06aQvVDLQ8F9wcbCaYuqyphpMC4
         pbbnXRP8jndwyoNe2SQGL9LKFsNR9rmZmxksKHwsHKg3pfZXl5wQ4lr0HfHh32E+8BUI
         6qyoYtSJmBrFsU1ttmOKV5Q/CXDtbWQx1rTcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TICGsSDFeAQRfi9mfXDkz3sCl/QfHpv30Btf6TeiWPU=;
        b=SPKXS+OMKrbLNgoV8ia9CmM0XaSDdCuAUykfk2JkB7OsLZ5SxuRpzPuP8CFUZuZHbw
         iJGqKwryK0BxQwwRt6Z/dVYBtrLjoa4wqu4FvOHXYtXpRhTc4fNykb7zW/bnGc1sWE98
         g4jhDQqmrmV6e36GwoTdz/+RAaDzqmOntEDnTghx15ni5wcFPJWNutAZK1CZA/D3aCl0
         xxhL1Kqy0n+Xn2A9+7L6TUxtDlxt8hnKpqfj/Pz/Thq3mlTjuzypomE8HHtPZQUJmkr8
         FOdGR5x31p3enDBG4i6aFt4906jRcDyGVvdWKCApdJQNDj1DFTxn8rfRZeg61nVieGO9
         //QQ==
X-Gm-Message-State: AOAM5334va0D0Rmmp+UsPPtikVZvk6UEk1SFJSzrqpU+HYyVPLahQurE
        /7am++qZBPC/LBiAGdKFJYF+uyCq0Gbi9w==
X-Google-Smtp-Source: ABdhPJwar7kOb+c7X2Rqo5yx6uR3PqMYn2dMvWi+tkIg3gcFpVMk1mSlqt5sPNUWokMAYSqVpfyuxg==
X-Received: by 2002:a63:1615:: with SMTP id w21mr9613848pgl.217.1591370700604;
        Fri, 05 Jun 2020 08:25:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm6905186pgn.47.2020.06.05.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 08:24:59 -0700 (PDT)
Date:   Fri, 5 Jun 2020 08:24:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, sfr@canb.auug.org.au,
        linux@roeck-us.net
Subject: Re: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on
 call_single_queue
Message-ID: <202006050813.6734DACD@keescook>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.011635912@infradead.org>
 <20200528234031.GB551@lenoir>
 <20200529133641.GM706495@hirez.programming.kicks-ass.net>
 <20200605093704.GB2948@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605093704.GB2948@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:37:04AM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 03:36:41PM +0200, Peter Zijlstra wrote:
> > Maybe I can anonymous-union my way around it, dunno. I'll think about
> > it. I'm certainly not proud of this. But at least the BUILD_BUG_ON()s
> > should catch the more blatant breakage here.
> 
> How's this then? Differently ugly, but at least it compiles with that
> horrible struct randomization junk enabled.
> 
> ---
>  include/linux/irq_work.h  |   28 ++++++-------------
>  include/linux/sched.h     |    4 +-
>  include/linux/smp.h       |   25 ++++++-----------
>  include/linux/smp_types.h |   66 ++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c       |    6 ++--
>  kernel/smp.c              |   18 ------------
>  6 files changed, 89 insertions(+), 58 deletions(-)
> 
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_IRQ_WORK_H
>  #define _LINUX_IRQ_WORK_H
>  
> -#include <linux/llist.h>
> +#include <linux/smp_types.h>
>  
>  /*
>   * An entry can be in one of four states:
> @@ -13,26 +13,16 @@
>   * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
>   */
>  
> -/* flags share CSD_FLAG_ space */
> -
> -#define IRQ_WORK_PENDING	BIT(0)
> -#define IRQ_WORK_BUSY		BIT(1)
> -
> -/* Doesn't want IPI, wait for tick: */
> -#define IRQ_WORK_LAZY		BIT(2)
> -/* Run hard IRQ context, even on RT */
> -#define IRQ_WORK_HARD_IRQ	BIT(3)
> -
> -#define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
> -
> -/*
> - * structure shares layout with single_call_data_t.
> - */
>  struct irq_work {
> -	struct llist_node llnode;
> -	atomic_t flags;
> +	union {
> +		struct __call_single_node node;
> +		struct {
> +			struct llist_node llnode;
> +			atomic_t flags;
> +		};
> +	};
>  	void (*func)(struct irq_work *);
> -};
> +} __no_randomize_layout;

The "__no_randomize_layout" isn't needed here. The only automatically
randomized structs are those entirely consisting of function pointers.

>  static inline
>  void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -32,6 +32,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/rseq.h>
>  #include <linux/kcsan.h>
> +#include <linux/smp_types.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
> @@ -654,9 +655,8 @@ struct task_struct {
>  	unsigned int			ptrace;
>  
>  #ifdef CONFIG_SMP
> -	struct llist_node		wake_entry;
> -	unsigned int			wake_entry_type;
>  	int				on_cpu;
> +	struct __call_single_node	wake_entry;
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */
>  	unsigned int			cpu;
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -12,32 +12,25 @@
>  #include <linux/list.h>
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
> -#include <linux/llist.h>
> +#include <linux/smp_types.h>
>  
>  typedef void (*smp_call_func_t)(void *info);
>  typedef bool (*smp_cond_func_t)(int cpu, void *info);
>  
> -enum {
> -	CSD_FLAG_LOCK		= 0x01,
> -
> -	/* IRQ_WORK_flags */
> -
> -	CSD_TYPE_ASYNC		= 0x00,
> -	CSD_TYPE_SYNC		= 0x10,
> -	CSD_TYPE_IRQ_WORK	= 0x20,
> -	CSD_TYPE_TTWU		= 0x30,
> -	CSD_FLAG_TYPE_MASK	= 0xF0,
> -};
> -
>  /*
>   * structure shares (partial) layout with struct irq_work
>   */
>  struct __call_single_data {
> -	struct llist_node llist;
> -	unsigned int flags;
> +	union {
> +		struct __call_single_node node;
> +		struct {
> +			struct llist_node llist;
> +			unsigned int flags;
> +		};
> +	};
>  	smp_call_func_t func;
>  	void *info;
> -};
> +} __no_randomize_layout;

Same here.

>  
>  /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
>  typedef struct __call_single_data call_single_data_t
> --- /dev/null
> +++ b/include/linux/smp_types.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SMP_TYPES_H
> +#define __LINUX_SMP_TYPES_H
> +
> +#include <linux/llist.h>
> +
> +enum {
> +	CSD_FLAG_LOCK		= 0x01,
> +
> +	IRQ_WORK_PENDING	= 0x01,
> +	IRQ_WORK_BUSY		= 0x02,
> +	IRQ_WORK_LAZY		= 0x04, /* No IPI, wait for tick */
> +	IRQ_WORK_HARD_IRQ	= 0x08, /* IRQ context on PREEMPT_RT */
> +
> +	IRQ_WORK_CLAIMED	= (IRQ_WORK_PENDING | IRQ_WORK_BUSY),
> +
> +	CSD_TYPE_ASYNC		= 0x00,
> +	CSD_TYPE_SYNC		= 0x10,
> +	CSD_TYPE_IRQ_WORK	= 0x20,
> +	CSD_TYPE_TTWU		= 0x30,
> +
> +	CSD_FLAG_TYPE_MASK	= 0xF0,
> +};
> +
> +/*
> + * struct __call_single_node is the primary type on
> + * smp.c:call_single_queue.
> + *
> + * flush_smp_call_function_queue() only reads the type from
> + * __call_single_node::u_flags as a regular load, the above
> + * (anonymous) enum defines all the bits of this word.
> + *
> + * Other bits are not modified until the type is known.
> + *
> + * CSD_TYPE_SYNC/ASYNC:
> + *	struct {
> + *		struct llist_node node;
> + *		unsigned int flags;
> + *		smp_call_func_t func;
> + *		void *info;
> + *	};
> + *
> + * CSD_TYPE_IRQ_WORK:
> + *	struct {
> + *		struct llist_node node;
> + *		atomic_t flags;
> + *		void (*func)(struct irq_work *);
> + *	};
> + *
> + * CSD_TYPE_TTWU:
> + *	struct {
> + *		struct llist_node node;
> + *		unsigned int flags;
> + *	};
> + *
> + */
> +
> +struct __call_single_node {
> +	struct llist_node	llist;
> +	union {
> +		unsigned int	u_flags;
> +		atomic_t	a_flags;
> +	};
> +} __no_randomize_layout;

Same.

> +
> +#endif /* __LINUX_SMP_TYPES_H */
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2293,7 +2293,7 @@ void sched_ttwu_pending(void *arg)
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
>  
> -	llist_for_each_entry_safe(p, t, llist, wake_entry)
> +	llist_for_each_entry_safe(p, t, llist, wake_entry.llist)
>  		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
>  
>  	rq_unlock_irqrestore(rq, &rf);
> @@ -2322,7 +2322,7 @@ static void __ttwu_queue_wakelist(struct
>  	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
>  
>  	WRITE_ONCE(rq->ttwu_pending, 1);
> -	__smp_call_single_queue(cpu, &p->wake_entry);
> +	__smp_call_single_queue(cpu, &p->wake_entry.llist);
>  }
>  
>  void wake_up_if_idle(int cpu)
> @@ -2763,7 +2763,7 @@ static void __sched_fork(unsigned long c
>  #endif
>  	init_numa_balancing(clone_flags, p);
>  #ifdef CONFIG_SMP
> -	p->wake_entry_type = CSD_TYPE_TTWU;
> +	p->wake_entry.u_flags = CSD_TYPE_TTWU;
>  #endif
>  }
>  
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -669,24 +669,6 @@ void __init smp_init(void)
>  {
>  	int num_nodes, num_cpus;
>  
> -	/*
> -	 * Ensure struct irq_work layout matches so that
> -	 * flush_smp_call_function_queue() can do horrible things.
> -	 */
> -	BUILD_BUG_ON(offsetof(struct irq_work, llnode) !=
> -		     offsetof(struct __call_single_data, llist));
> -	BUILD_BUG_ON(offsetof(struct irq_work, func) !=
> -		     offsetof(struct __call_single_data, func));
> -	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
> -		     offsetof(struct __call_single_data, flags));
> -
> -	/*
> -	 * Assert the CSD_TYPE_TTWU layout is similar enough
> -	 * for task_struct to be on the @call_single_queue.
> -	 */
> -	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> -		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> -

Do you want to validate that the individual members of the union struct
still have their fields lining up with __call_single_node's members?
Or better yet, I have the same question as Frederic about the need for
the union. Why not just switch callers from "flags" to "node.u_flags"
and "node.a_flags"? (Or could that be cleaned up in a later patch to
avoid putting too much churn in one patch?)

-- 
Kees Cook
