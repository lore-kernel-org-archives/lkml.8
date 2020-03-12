Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D2C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7E8206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCLW3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgCLW3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:29:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4920120637;
        Thu, 12 Mar 2020 22:29:37 +0000 (UTC)
Date:   Thu, 12 Mar 2020 18:29:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
Message-ID: <20200312182935.70ed6516@gandalf.local.home>
In-Reply-To: <7e0d2bbf-71c2-395c-9a42-d3d6d3ee4fa4@i-love.sakura.ne.jp>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
        <20200308065258.GE3983392@kroah.com>
        <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com>
        <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
        <20200311101115.53139149@gandalf.local.home>
        <CACT4Y+Z5co4HyQBj6-uUdqT2Vk=6jgT-aQXuPtjx3qV4C_pZ7g@mail.gmail.com>
        <7e0d2bbf-71c2-395c-9a42-d3d6d3ee4fa4@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 06:59:22 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> On 2020/03/13 4:23, Dmitry Vyukov wrote:
> >> Or teach the fuzz tool not to do specific bad things.  
> > 
> > We do some of this.
> > But generally it's impossible for anything that involves memory
> > indirections, or depends on the exact type of fd (e.g. all ioctl's),
> > etc. Boils down to halting problem and ability to predict exact
> > behavior of arbitrary programs.  
> 
> I would like to enable changes like below only if CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y .
> 
> Since TASK_RUNNING threads are not always running on CPUs (in syzbot, the kernel is
> tested on a VM with only 2 CPUs, which means that many threads are simply waiting for
> CPU time to be assigned), dumping locks held by all threads gives us more clue when
> e.g. khungtask fired. But since lockdep_print_held_locks() is racy, I assume that
> this change won't be accepted unless CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y .
> 
> Also, for another example, limit number of memory pages /dev/ion driver can consume only if
> CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y ( https://github.com/google/syzkaller/issues/1267 ),
> for limiting number of memory pages is a user-visible change while we need to avoid false
> alarms caused by consuming all memory pages.
> 
> In other words, while majority of things CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y would
> do "disable this", there would be a few "enable this" and "change this".

I still fear that people will just disable large sections. I've seen this
before. Developers take the easy way out, and when someone adds a new
feature that may be dangerous, they will just say "oh turn off fuzzing" and
be done with it.

As Linus likes to say, when you need to make changes to the kernel to test
it, you are no longer testing production kernels.

> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 32406ef0d6a2..1bc7878768fc 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -695,6 +695,7 @@ static void print_lock(struct held_lock *hlock)
>  static void lockdep_print_held_locks(struct task_struct *p)
>  {
>  	int i, depth = READ_ONCE(p->lockdep_depth);
> +	bool unreliable;
>  
>  	if (!depth)
>  		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
> @@ -705,10 +706,12 @@ static void lockdep_print_held_locks(struct task_struct *p)
>  	 * It's not reliable to print a task's held locks if it's not sleeping
>  	 * and it's not the current task.
>  	 */
> -	if (p->state == TASK_RUNNING && p != current)
> -		return;
> +	unreliable = p->state == TASK_RUNNING && p != current;
>  	for (i = 0; i < depth; i++) {
> -		printk(" #%d: ", i);
> +		if (unreliable)
> +			printk(" #%d?: ", i);
> +		else
> +			printk(" #%d: ", i);

Have you tried submitting this? Has Peter nacked it?

-- Steve

>  		print_lock(p->held_locks + i);
>  	}
>  }

