Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2121BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6DA20706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592994070;
	bh=SmSzSFADUlByrapNP5i9N0i0SGuIt1JT2r4whQ30ca8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EOcGUDRzXO2IWehAfyFpFN6o9qf7mlULd7yEK7WdposraI3/hlknTRsqEsu91khNS
	 S/HFf/61ArbqaR4FskbXapkdg6lTsWLufq8cf3Use5cK2gD+H4PNND3xJmrzzSjyJK
	 f55m0eTx3yUwtkU3kq0fWLozOMLfERtCMo9Pwiag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390329AbgFXKUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390254AbgFXKUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:20:34 -0400
Received: from kernel.org (unknown [2.55.149.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5789720706;
        Wed, 24 Jun 2020 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592994026;
        bh=SmSzSFADUlByrapNP5i9N0i0SGuIt1JT2r4whQ30ca8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+DdnCMnzoIKAYZRQZFX9pP8RPU6L8DAUMnU5dHQgELksrEn9/jvB46fNdn9h0b6n
         a2KstOiWrBQxBhPqVe8Yr7+pjzI53m40RHkG0N9NGFkWVL2cBol972m5Fc1E2g7suY
         DsbJY6FouaSaA0NDmXNuOyORUN3MC+7Xy6YC/HN0=
Date:   Wed, 24 Jun 2020 13:20:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] sched: fix build with GCC_PLUGIN_RANDSTRUCT
Message-ID: <20200624102016.GA3133927@kernel.org>
References: <20200620104136.12195-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200620104136.12195-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Sat, Jun 20, 2020 at 01:41:36PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Since the commit a148866489fb ("sched: Replace rq::wake_list")
> task_struct and CSD_TYPE_TTWU objects can be on the same queue and this
> requires that have "layout similar enough".
> 
> This assumption is broken when CONFIG_GCC_PLUGIN_RANDSTRUCT is enabled:
> 
>   CHK     include/generated/compile.h
>   CC      kernel/smp.o
> In file included from arch/x86/include/asm/atomic.h:5,
>                  from include/linux/atomic.h:7,
>                  from include/linux/llist.h:51,
>                  from include/linux/irq_work.h:5,
>                  from kernel/smp.c:10:
> kernel/smp.c: In function ‘smp_init’:
> include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_157’ declared with attribute error: BUILD_BUG_ON failed: offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) != offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist)
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                      ^
> include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>   373 |    prefix ## suffix();    \
>       |    ^~~~~~
> include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>    50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>       |  ^~~~~~~~~~~~~~~~
> kernel/smp.c:687:2: note: in expansion of macro ‘BUILD_BUG_ON’
>   687 |  BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
>       |  ^~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:280: kernel/smp.o] Error 1
> make[1]: *** [Makefile:1764: kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make[1]: Leaving directory '/home/mike/build/kernel'
> make: *** [Makefile:185: __sub-make] Error 2
> 
> Move 'wake_entry' and 'wake_entry_type' fiels of task_struct out of the
> randomized fields to keep their layout intact.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  include/linux/sched.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b62e6aaf28f0..c885573669ac 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -641,6 +641,15 @@ struct task_struct {
>  	/* -1 unrunnable, 0 runnable, >0 stopped: */
>  	volatile long			state;
>  
> +	/*
> +	 * The layout of these fields must match the layout CSD_TYPE_TTWU
> +	 * so they can be on the same the @call_single_queue
> +	 */
> +#ifdef CONFIG_SMP
> +	struct llist_node		wake_entry;
> +	unsigned int			wake_entry_type;
> +#endif
> +
>  	/*
>  	 * This begins the randomizable portion of task_struct. Only
>  	 * scheduling-critical items should be added above here.
> @@ -654,8 +663,6 @@ struct task_struct {
>  	unsigned int			ptrace;
>  
>  #ifdef CONFIG_SMP
> -	struct llist_node		wake_entry;
> -	unsigned int			wake_entry_type;
>  	int				on_cpu;
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */
> -- 
> 2.25.4
> 

-- 
Sincerely yours,
Mike.
