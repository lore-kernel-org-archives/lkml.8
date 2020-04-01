Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCDAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B2C2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+CFGHM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbgDAWcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:32:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAWcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=xfRE8Cokkm/9MARhHJALzLNHzyKSNityBpX4QZba2Yk=; b=D+CFGHM626Flxo/sUEr5hK8i9O
        lAcbBu5Hna70JFB9pMxpvMB+esNL/l3al8MBHudHQaXkmDeNdSJApbm73mPeGhlJSAl/zyk/q4no3
        X3ApxCicSXIaIKXPK+YHBZGPqJg4zxrDMti3DbgDeA8wTpoa2hQDGYSoZcskiGCLvp6Ap5FCKedzS
        OdeI/6uzamFsvSejQPNfVc+37xvmxxYFXZScN3i1jwH2+iuEqYs9a8wjD5yS0ldXzLik6FFJaQ21P
        hUSwpLbVIXF9ILFg90Ghtob6CYGsI1rDJ9GgYco+baLssrWDT4TjBZtifyhneANiKrH7ttD6S1JgR
        LygiLeRw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJlue-0007M7-Il; Wed, 01 Apr 2020 22:32:44 +0000
Subject: Re: [patch 3/4] isolcpus: affine kernel threads to housekeeping cpus
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
References: <20200401121018.104226700@redhat.com>
 <20200401121342.979811840@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a5e70c3b-2927-6ee3-fe75-8b9ece0df94f@infradead.org>
Date:   Wed, 1 Apr 2020 15:32:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401121342.979811840@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 5:10 AM, Marcelo Tosatti wrote:
> This is a kernel enhancement that configures the cpu affinity of kernel
> threads via kernel boot option nohz_full=.
> 
> When this option is specified, the cpumask is immediately applied upon
> thread launch. This does not affect kernel threads that specify cpu
> and node.
> 
> This allows CPU isolation (that is not allowing certain threads
> to execute on certain CPUs) without using the isolcpus=domain parameter,
> making it possible to enable load balancing on such CPUs
> during runtime (see kernel-parameters.txt).
> 
> Note-1: this is based off on Wind River's patch at
> https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> 
> Difference being that this patch is limited to modifying
> kernel thread cpumask: Behaviour of other threads can
> be controlled via cgroups or sched_setaffinity.
> 
> Note-2: Wind River's patch was based off Christoph Lameter's patch at
> https://lwn.net/Articles/565932/ with the only difference being
> the kernel parameter changed from kthread to kthread_cpus.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 

Hi Marcelo,

> ---
>  Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++

Patch is missing those Docum bits.

>  include/linux/sched/isolation.h                 |    1 +
>  kernel/kthread.c                                |    6 ++++--
>  kernel/sched/isolation.c                        |    6 ++++++
>  4 files changed, 19 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/include/linux/sched/isolation.h
> ===================================================================
> --- linux-2.6.orig/include/linux/sched/isolation.h
> +++ linux-2.6/include/linux/sched/isolation.h
> @@ -14,6 +14,7 @@ enum hk_flags {
>  	HK_FLAG_DOMAIN		= (1 << 5),
>  	HK_FLAG_WQ		= (1 << 6),
>  	HK_FLAG_MANAGED_IRQ	= (1 << 7),
> +	HK_FLAG_KTHREAD		= (1 << 8),
>  };
>  
>  #ifdef CONFIG_CPU_ISOLATION
> Index: linux-2.6/kernel/kthread.c
> ===================================================================
> --- linux-2.6.orig/kernel/kthread.c
> +++ linux-2.6/kernel/kthread.c
> @@ -23,6 +23,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/uaccess.h>
>  #include <linux/numa.h>
> +#include <linux/sched/isolation.h>
>  #include <trace/events/sched.h>
>  
>  static DEFINE_SPINLOCK(kthread_create_lock);
> @@ -347,7 +348,8 @@ struct task_struct *__kthread_create_on_
>  		 * The kernel thread should not inherit these properties.
>  		 */
>  		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> -		set_cpus_allowed_ptr(task, cpu_possible_mask);
> +		set_cpus_allowed_ptr(task,
> +				     housekeeping_cpumask(HK_FLAG_KTHREAD));
>  	}
>  	kfree(create);
>  	return task;
> @@ -572,7 +574,7 @@ int kthreadd(void *unused)
>  	/* Setup a clean context for our children to inherit. */
>  	set_task_comm(tsk, "kthreadd");
>  	ignore_signals(tsk);
> -	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
> +	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_FLAG_KTHREAD));
>  	set_mems_allowed(node_states[N_MEMORY]);
>  
>  	current->flags |= PF_NOFREEZE;
> Index: linux-2.6/kernel/sched/isolation.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/isolation.c
> +++ linux-2.6/kernel/sched/isolation.c
> @@ -141,7 +141,7 @@ static int __init housekeeping_nohz_full
>  	unsigned int flags;
>  
>  	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> -		HK_FLAG_MISC | HK_FLAG_SCHED;
> +		HK_FLAG_MISC | HK_FLAG_SCHED | HK_FLAG_KTHREAD;
>  
>  	return housekeeping_setup(str, flags);
>  }
> 
> 

thanks.
-- 
~Randy

