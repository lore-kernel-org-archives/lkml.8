Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C2BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080C1207E8
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgF0WMS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 18:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgF0WMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 18:12:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3040520706;
        Sat, 27 Jun 2020 22:12:16 +0000 (UTC)
Date:   Sat, 27 Jun 2020 18:12:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sched: fix build with GCC_PLUGIN_RANDSTRUCT
Message-ID: <20200627181214.3a4d4a42@oasis.local.home>
In-Reply-To: <20200620104136.12195-1-rppt@kernel.org>
References: <20200620104136.12195-1-rppt@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 13:41:36 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Since the commit a148866489fb ("sched: Replace rq::wake_list")
> task_struct and CSD_TYPE_TTWU objects can be on the same queue and this
> requires that have "layout similar enough".
> 
> This assumption is broken when CONFIG_GCC_PLUGIN_RANDSTRUCT is enabled:

You forgot to Cc Kees, who's the one that is probably the most
concerned about randomizing structures!



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

Seems the dependency is that the offsets between wake_entry and
wake_entry_type doesn't change.

> 
> Move 'wake_entry' and 'wake_entry_type' fiels of task_struct out of
> the randomized fields to keep their layout intact.
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
> +	 * The layout of these fields must match the layout
> CSD_TYPE_TTWU
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

What about instead just create an anonymous structure of the two. That
way they can still be randomized within the task struct and not be a
target of attacks?

	struct {
		struct llist_node	wake_entry;
		unsigned int		wake_entry_type;
	};

Would that work?

-- Steve


>  	int				on_cpu;
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */

