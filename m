Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D80C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5A521D56
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583342661;
	bh=onLSiV9BAgZDNuwZoJku3JjifKp4a3Xe/h4Qtg+/+pM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aPut2h2ioA1bRQrQbhdyKyibXT8py65wurYniDf4RQcRuqjmHEdozb30lJZytlU7Z
	 ddZGUmZomzTQGA6i5InVQVej2bYvOmv4dDRPIi0nnT3BYnTdR5pY3+TpYPjYSrpJXz
	 ng5tmUhBMXVnrSSnpYBiOtrcZNvEw90PaCCQ82Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgCDRYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDRYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:24:19 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18F7217F4;
        Wed,  4 Mar 2020 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342657;
        bh=onLSiV9BAgZDNuwZoJku3JjifKp4a3Xe/h4Qtg+/+pM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0mr9VLQ8rWDjN6ONTz5G/J6TmdiyW+ZqKwCgpnM2mLj8eU/hqii15SWSOabfn1s1B
         pqC49QuCjB3WSgS4iNQ9l3rYxrHb+/E4AEFkNwu6kIGOT2XYXIqp0OA4eOhM8x2SGD
         UkL4hSuih263m4nfIw+GeQFASkvA/xZkqhxwRgR8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 963F43522731; Wed,  4 Mar 2020 09:24:17 -0800 (PST)
Date:   Wed, 4 Mar 2020 09:24:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.02.29a 43/43] kernel/rcu/tasks.h:369:2: error:
 implicit declaration of function 'call_rcu_tasks_generic'
Message-ID: <20200304172417.GC2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202003050056.FTPARGaw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003050056.FTPARGaw%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 12:40:11AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.29a
> head:   61f7110d6b78f4c84ea5d5480185740840889af7
> commit: 61f7110d6b78f4c84ea5d5480185740840889af7 [43/43] rcu-tasks: Add an RCU-tasks rude variant
> config: mips-rm200_defconfig (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 5.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 61f7110d6b78f4c84ea5d5480185740840889af7
>         # save the attached .config to linux build tree
>         GCC_VERSION=5.5.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

This is for an obsolete branch.  I believe that the replacement commit
8dd788e3ab55 ("rcu-tasks: Add an RCU-tasks rude variant") fixes this.

							Thanx, Paul

> All error/warnings (new ones prefixed by >>):
> 
>      union { typeof(x) __val; char __c[1]; } __u;   \
>                     ^
>    kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>           ^
>    kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>                      ^
>    include/linux/compiler.h:287:22: note: in definition of macro '__READ_ONCE'
>       __read_once_size(&(x), __u.__c, sizeof(x));  \
>                          ^
>    kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>           ^
>    kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>                      ^
>    include/linux/compiler.h:287:42: note: in definition of macro '__READ_ONCE'
>       __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                              ^
>    kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>           ^
>    kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>                      ^
>    include/linux/compiler.h:289:30: note: in definition of macro '__READ_ONCE'
>       __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                  ^
>    kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>           ^
>    kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>                      ^
>    include/linux/compiler.h:289:50: note: in definition of macro '__READ_ONCE'
>       __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                      ^
>    kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
>      if (!READ_ONCE(t->rcu_tasks_holdout) ||
>           ^
>    In file included from kernel/rcu/update.c:562:0:
>    kernel/rcu/tasks.h:213:7: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
>          t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
>           ^
>    kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
>           !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
>                                ^
>    In file included from include/linux/kernel.h:11:0,
>                     from kernel/rcu/update.c:21:
>    kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>       WRITE_ONCE(t->rcu_tasks_holdout, false);
>                   ^
>    include/linux/compiler.h:310:17: note: in definition of macro 'WRITE_ONCE'
>      union { typeof(x) __val; char __c[1]; } __u = \
>                     ^
>    kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>       WRITE_ONCE(t->rcu_tasks_holdout, false);
>                   ^
>    include/linux/compiler.h:311:30: note: in definition of macro 'WRITE_ONCE'
>       { .__val = (__force typeof(x)) (val) }; \
>                                  ^
>    kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>       WRITE_ONCE(t->rcu_tasks_holdout, false);
>                   ^
>    include/linux/compiler.h:312:22: note: in definition of macro 'WRITE_ONCE'
>      __write_once_size(&(x), __u.__c, sizeof(x)); \
>                          ^
>    kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>       WRITE_ONCE(t->rcu_tasks_holdout, false);
>                   ^
>    include/linux/compiler.h:312:42: note: in definition of macro 'WRITE_ONCE'
>      __write_once_size(&(x), __u.__c, sizeof(x)); \
>                                              ^
>    In file included from kernel/rcu/update.c:562:0:
>    kernel/rcu/tasks.h:218:19: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
>       list_del_init(&t->rcu_tasks_holdout_list);
>                       ^
>    In file included from include/linux/kernel.h:15:0,
>                     from kernel/rcu/update.c:21:
>    kernel/rcu/tasks.h:233:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
>        t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
>         ^
>    include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
>      printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>                                       ^
>    kernel/rcu/tasks.h:233:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>        t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
>                                       ^
>    include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
>      printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>                                       ^
>    kernel/rcu/tasks.h:234:5: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
>        t->rcu_tasks_idle_cpu, cpu);
>         ^
>    include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
>      printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>                                       ^
>    In file included from kernel/rcu/update.c:562:0:
>    kernel/rcu/tasks.h: At top level:
> >> kernel/rcu/tasks.h:239:38: warning: 'struct rcu_tasks' declared inside parameter list
>     static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>                                          ^
> >> kernel/rcu/tasks.h:239:38: warning: its scope is only this definition or declaration, which is probably not what you want
>    kernel/rcu/tasks.h: In function 'rcu_tasks_wait_gp':
>    kernel/rcu/tasks.h:271:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
>        t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
>         ^
>    In file included from include/linux/kernel.h:11:0,
>                     from kernel/rcu/update.c:21:
>    kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>        WRITE_ONCE(t->rcu_tasks_holdout, true);
>                    ^
>    include/linux/compiler.h:310:17: note: in definition of macro 'WRITE_ONCE'
>      union { typeof(x) __val; char __c[1]; } __u = \
>                     ^
>    kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>        WRITE_ONCE(t->rcu_tasks_holdout, true);
>                    ^
>    include/linux/compiler.h:311:30: note: in definition of macro 'WRITE_ONCE'
>       { .__val = (__force typeof(x)) (val) }; \
>                                  ^
>    kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>        WRITE_ONCE(t->rcu_tasks_holdout, true);
>                    ^
>    include/linux/compiler.h:312:22: note: in definition of macro 'WRITE_ONCE'
>      __write_once_size(&(x), __u.__c, sizeof(x)); \
>                          ^
>    kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
>        WRITE_ONCE(t->rcu_tasks_holdout, true);
>                    ^
>    include/linux/compiler.h:312:42: note: in definition of macro 'WRITE_ONCE'
>      __write_once_size(&(x), __u.__c, sizeof(x)); \
>                                              ^
>    In file included from kernel/rcu/update.c:562:0:
>    kernel/rcu/tasks.h:273:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
>        list_add(&t->rcu_tasks_holdout_list,
>                   ^
>    kernel/rcu/tasks.h:286:20: error: 'tasks_rcu_exit_srcu' undeclared (first use in this function)
>      synchronize_srcu(&tasks_rcu_exit_srcu);
>                        ^
>    kernel/rcu/tasks.h:286:20: note: each undeclared identifier is reported only once for each function it appears in
>    In file included from include/linux/kernel.h:11:0,
>                     from kernel/rcu/update.c:21:
>    kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function)
>       rtst = READ_ONCE(rcu_task_stall_timeout);
>                        ^
>    include/linux/compiler.h:285:17: note: in definition of macro '__READ_ONCE'
>      union { typeof(x) __val; char __c[1]; } __u;   \
>                     ^
>    kernel/rcu/tasks.h:313:10: note: in expansion of macro 'READ_ONCE'
>       rtst = READ_ONCE(rcu_task_stall_timeout);
>              ^
>    include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                                                       ^
>    include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
>       if (!(condition))     \
>             ^
>    include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^
>    include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>      ^
>    include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                        ^
>    include/linux/list.h:493:2: note: in expansion of macro 'container_of'
>      container_of(ptr, type, member)
>      ^
>    include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
>      list_entry((ptr)->next, type, member)
>      ^
>    include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
>      for (pos = list_first_entry(head, typeof(*pos), member), \
>                 ^
>    kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
>       list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
>       ^
>    In file included from <command-line>:0:0:
>    include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
>     #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>                                       ^
>    include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
>     #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
>                                    ^
>    include/linux/kernel.h:990:21: note: in expansion of macro 'offsetof'
>      ((type *)(__mptr - offsetof(type, member))); })
>                         ^
>    include/linux/list.h:493:2: note: in expansion of macro 'container_of'
>      container_of(ptr, type, member)
>      ^
>    include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
>      list_entry((ptr)->next, type, member)
>      ^
>    include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
>      for (pos = list_first_entry(head, typeof(*pos), member), \
>                 ^
>    kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
>       list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
> --
>      ^
>    include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
>      list_entry((pos)->member.next, typeof(*(pos)), member)
>      ^
>    include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
>           pos = n, n = list_next_entry(n, member))
>                        ^
>    kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
>       list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
>       ^
>    include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                                                       ^
>    include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
>       if (!(condition))     \
>             ^
>    include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^
>    include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>      ^
>    include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                        ^
>    include/linux/list.h:493:2: note: in expansion of macro 'container_of'
>      container_of(ptr, type, member)
>      ^
>    include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
>      list_entry((pos)->member.next, typeof(*(pos)), member)
>      ^
>    include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
>           pos = n, n = list_next_entry(n, member))
>                        ^
>    kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
>       list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
>       ^
>    include/linux/list.h:537:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
>      list_entry((pos)->member.next, typeof(*(pos)), member)
>                      ^
>    include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
>       if (!(condition))     \
>             ^
>    include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^
>    include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>      ^
>    include/linux/kernel.h:988:6: note: in expansion of macro '__same_type'
>         !__same_type(*(ptr), void),   \
>          ^
>    include/linux/list.h:493:2: note: in expansion of macro 'container_of'
>      container_of(ptr, type, member)
>      ^
>    include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
>      list_entry((pos)->member.next, typeof(*(pos)), member)
>      ^
>    include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
>           pos = n, n = list_next_entry(n, member))
>                        ^
>    kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
>       list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
>       ^
>    In file included from <command-line>:0:0:
>    include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
>     #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>                                       ^
>    include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
>     #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
>                                    ^
>    include/linux/kernel.h:990:21: note: in expansion of macro 'offsetof'
>      ((type *)(__mptr - offsetof(type, member))); })
>                         ^
>    include/linux/list.h:493:2: note: in expansion of macro 'container_of'
>      container_of(ptr, type, member)
>      ^
>    include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
>      list_entry((pos)->member.next, typeof(*(pos)), member)
>      ^
>    include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
>           pos = n, n = list_next_entry(n, member))
>                        ^
>    kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
>       list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
>       ^
>    In file included from kernel/rcu/update.c:562:0:
>    kernel/rcu/tasks.h: At top level:
>    kernel/rcu/tasks.h:347:1: warning: data definition has no type or storage class
>     DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
>     ^
>    kernel/rcu/tasks.h:347:1: error: type defaults to 'int' in declaration of 'DEFINE_RCU_TASKS' [-Werror=implicit-int]
>    kernel/rcu/tasks.h:347:1: warning: parameter names (without types) in function declaration
>    kernel/rcu/tasks.h: In function 'call_rcu':
> >> kernel/rcu/tasks.h:369:2: error: implicit declaration of function 'call_rcu_tasks_generic' [-Werror=implicit-function-declaration]
>      call_rcu_tasks_generic(rhp, func, &rcu_tasks);
>      ^
> >> kernel/rcu/tasks.h:369:37: error: 'rcu_tasks' undeclared (first use in this function)
>      call_rcu_tasks_generic(rhp, func, &rcu_tasks);
>                                         ^
>    kernel/rcu/tasks.h: In function 'synchronize_rcu':
> >> kernel/rcu/tasks.h:393:2: error: implicit declaration of function 'synchronize_rcu_tasks_generic' [-Werror=implicit-function-declaration]
>      synchronize_rcu_tasks_generic(&rcu_tasks);
>      ^
>    kernel/rcu/tasks.h:393:33: error: 'rcu_tasks' undeclared (first use in this function)
>      synchronize_rcu_tasks_generic(&rcu_tasks);
>                                     ^
>    kernel/rcu/tasks.h: In function 'rcu_spawn_tasks_kthread':
> >> kernel/rcu/tasks.h:412:2: error: implicit declaration of function 'rcu_spawn_tasks_kthread_generic' [-Werror=implicit-function-declaration]
>      rcu_spawn_tasks_kthread_generic(&rcu_tasks);
>      ^
>    kernel/rcu/tasks.h:412:35: error: 'rcu_tasks' undeclared (first use in this function)
>      rcu_spawn_tasks_kthread_generic(&rcu_tasks);
>                                       ^
>    kernel/rcu/tasks.h: At top level:
>    kernel/rcu/tasks.h:432:43: warning: 'struct rcu_tasks' declared inside parameter list
>     static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>                                               ^
>    kernel/rcu/tasks.h:439:1: warning: data definition has no type or storage class
>     DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
>     ^
>    kernel/rcu/tasks.h:439:1: error: type defaults to 'int' in declaration of 'DEFINE_RCU_TASKS' [-Werror=implicit-int]
>    kernel/rcu/tasks.h:439:1: warning: parameter names (without types) in function declaration
>    kernel/rcu/tasks.h: In function 'call_rcu_tasks_rude':
> >> kernel/rcu/tasks.h:461:37: error: 'rcu_tasks_rude' undeclared (first use in this function)
>      call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
>                                         ^
>    kernel/rcu/tasks.h: In function 'synchronize_rcu_tasks_rude':
>    kernel/rcu/tasks.h:485:33: error: 'rcu_tasks_rude' undeclared (first use in this function)
>      synchronize_rcu_tasks_generic(&rcu_tasks_rude);
>                                     ^
>    kernel/rcu/tasks.h: In function 'rcu_spawn_tasks_rude_kthread':
>    kernel/rcu/tasks.h:504:35: error: 'rcu_tasks_rude' undeclared (first use in this function)
>      rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
>                                       ^
>    kernel/rcu/update.c: At top level:
>    kernel/rcu/tasks.h:239:13: warning: 'rcu_tasks_wait_gp' defined but not used [-Wunused-function]
>     static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>                 ^
>    cc1: some warnings being treated as errors
> 
> vim +/call_rcu_tasks_generic +369 kernel/rcu/tasks.h
> 
>    237	
>    238	/* Wait for one RCU-tasks grace period. */
>  > 239	static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>    240	{
>    241		struct task_struct *g, *t;
>    242		unsigned long lastreport;
>    243		LIST_HEAD(rcu_tasks_holdouts);
>    244		int fract;
>    245	
>    246		/*
>    247		 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
>    248		 * to complete.  Invoking synchronize_rcu() suffices because all
>    249		 * these transitions occur with interrupts disabled.  Without this
>    250		 * synchronize_rcu(), a read-side critical section that started
>    251		 * before the grace period might be incorrectly seen as having
>    252		 * started after the grace period.
>    253		 *
>    254		 * This synchronize_rcu() also dispenses with the need for a
>    255		 * memory barrier on the first store to t->rcu_tasks_holdout,
>    256		 * as it forces the store to happen after the beginning of the
>    257		 * grace period.
>    258		 */
>    259		synchronize_rcu();
>    260	
>    261		/*
>    262		 * There were callbacks, so we need to wait for an RCU-tasks
>    263		 * grace period.  Start off by scanning the task list for tasks
>    264		 * that are not already voluntarily blocked.  Mark these tasks
>    265		 * and make a list of them in rcu_tasks_holdouts.
>    266		 */
>    267		rcu_read_lock();
>    268		for_each_process_thread(g, t) {
>    269			if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
>    270				get_task_struct(t);
>    271				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
>    272				WRITE_ONCE(t->rcu_tasks_holdout, true);
>    273				list_add(&t->rcu_tasks_holdout_list,
>    274					 &rcu_tasks_holdouts);
>    275			}
>    276		}
>    277		rcu_read_unlock();
>    278	
>    279		/*
>    280		 * Wait for tasks that are in the process of exiting.  This
>    281		 * does only part of the job, ensuring that all tasks that were
>    282		 * previously exiting reach the point where they have disabled
>    283		 * preemption, allowing the later synchronize_rcu() to finish
>    284		 * the job.
>    285		 */
>    286		synchronize_srcu(&tasks_rcu_exit_srcu);
>    287	
>    288		/*
>    289		 * Each pass through the following loop scans the list of holdout
>    290		 * tasks, removing any that are no longer holdouts.  When the list
>    291		 * is empty, we are done.
>    292		 */
>    293		lastreport = jiffies;
>    294	
>    295		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
>    296		fract = 10;
>    297	
>    298		for (;;) {
>    299			bool firstreport;
>    300			bool needreport;
>    301			int rtst;
>    302			struct task_struct *t1;
>    303	
>    304			if (list_empty(&rcu_tasks_holdouts))
>    305				break;
>    306	
>    307			/* Slowly back off waiting for holdouts */
>    308			schedule_timeout_interruptible(HZ/fract);
>    309	
>    310			if (fract > 1)
>    311				fract--;
>    312	
>    313			rtst = READ_ONCE(rcu_task_stall_timeout);
>    314			needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
>    315			if (needreport)
>    316				lastreport = jiffies;
>    317			firstreport = true;
>    318			WARN_ON(signal_pending(current));
>    319			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
>    320						 rcu_tasks_holdout_list) {
>    321				check_holdout_task(t, needreport, &firstreport);
>    322				cond_resched();
>    323			}
>    324		}
>    325	
>    326		/*
>    327		 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
>    328		 * memory barriers prior to them in the schedule() path, memory
>    329		 * reordering on other CPUs could cause their RCU-tasks read-side
>    330		 * critical sections to extend past the end of the grace period.
>    331		 * However, because these ->nvcsw updates are carried out with
>    332		 * interrupts disabled, we can use synchronize_rcu() to force the
>    333		 * needed ordering on all such CPUs.
>    334		 *
>    335		 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
>    336		 * accesses to be within the grace period, avoiding the need for
>    337		 * memory barriers for ->rcu_tasks_holdout accesses.
>    338		 *
>    339		 * In addition, this synchronize_rcu() waits for exiting tasks
>    340		 * to complete their final preempt_disable() region of execution,
>    341		 * cleaning up after the synchronize_srcu() above.
>    342		 */
>    343		synchronize_rcu();
>    344	}
>    345	
>    346	void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
>    347	DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
>    348	
>    349	/**
>    350	 * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
>    351	 * @rhp: structure to be used for queueing the RCU updates.
>    352	 * @func: actual callback function to be invoked after the grace period
>    353	 *
>    354	 * The callback function will be invoked some time after a full grace
>    355	 * period elapses, in other words after all currently executing RCU
>    356	 * read-side critical sections have completed. call_rcu_tasks() assumes
>    357	 * that the read-side critical sections end at a voluntary context
>    358	 * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
>    359	 * or transition to usermode execution.  As such, there are no read-side
>    360	 * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
>    361	 * this primitive is intended to determine that all tasks have passed
>    362	 * through a safe state, not so much for data-strcuture synchronization.
>    363	 *
>    364	 * See the description of call_rcu() for more detailed information on
>    365	 * memory ordering guarantees.
>    366	 */
>    367	void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
>    368	{
>  > 369		call_rcu_tasks_generic(rhp, func, &rcu_tasks);
>    370	}
>    371	EXPORT_SYMBOL_GPL(call_rcu_tasks);
>    372	
>    373	/**
>    374	 * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
>    375	 *
>    376	 * Control will return to the caller some time after a full rcu-tasks
>    377	 * grace period has elapsed, in other words after all currently
>    378	 * executing rcu-tasks read-side critical sections have elapsed.  These
>    379	 * read-side critical sections are delimited by calls to schedule(),
>    380	 * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
>    381	 * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
>    382	 *
>    383	 * This is a very specialized primitive, intended only for a few uses in
>    384	 * tracing and other situations requiring manipulation of function
>    385	 * preambles and profiling hooks.  The synchronize_rcu_tasks() function
>    386	 * is not (yet) intended for heavy use from multiple CPUs.
>    387	 *
>    388	 * See the description of synchronize_rcu() for more detailed information
>    389	 * on memory ordering guarantees.
>    390	 */
>    391	void synchronize_rcu_tasks(void)
>    392	{
>  > 393		synchronize_rcu_tasks_generic(&rcu_tasks);
>    394	}
>    395	EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
>    396	
>    397	/**
>    398	 * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
>    399	 *
>    400	 * Although the current implementation is guaranteed to wait, it is not
>    401	 * obligated to, for example, if there are no pending callbacks.
>    402	 */
>    403	void rcu_barrier_tasks(void)
>    404	{
>    405		/* There is only one callback queue, so this is easy.  ;-) */
>    406		synchronize_rcu_tasks();
>    407	}
>    408	EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
>    409	
>    410	static int __init rcu_spawn_tasks_kthread(void)
>    411	{
>  > 412		rcu_spawn_tasks_kthread_generic(&rcu_tasks);
>    413		return 0;
>    414	}
>    415	core_initcall(rcu_spawn_tasks_kthread);
>    416	
>    417	////////////////////////////////////////////////////////////////////////
>    418	//
>    419	// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
>    420	// passing an empty function to schedule_on_each_cpu().  This approach
>    421	// provides an asynchronous call_rcu_rude() API and batching of concurrent
>    422	// calls to the synchronous synchronize_rcu_rude() API.  This sends IPIs
>    423	// far and wide and induces otherwise unnecessary context switches on all
>    424	// online CPUs, whether online or not.
>    425	
>    426	// Empty function to allow workqueues to force a context switch.
>    427	static void rcu_tasks_be_rude(struct work_struct *work)
>    428	{
>    429	}
>    430	
>    431	// Wait for one rude RCU-tasks grace period.
>    432	static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>    433	{
>    434		schedule_on_each_cpu(rcu_tasks_be_rude);
>    435	}
>    436	EXPORT_SYMBOL_GPL(rcu_tasks_rude_wait_gp);
>    437	
>    438	void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
>    439	DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
>    440	
>    441	/**
>    442	 * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
>    443	 * @rhp: structure to be used for queueing the RCU updates.
>    444	 * @func: actual callback function to be invoked after the grace period
>    445	 *
>    446	 * The callback function will be invoked some time after a full grace
>    447	 * period elapses, in other words after all currently executing RCU
>    448	 * read-side critical sections have completed. call_rcu_tasks_rude()
>    449	 * assumes that the read-side critical sections end at context switch,
>    450	 * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
>    451	 * there are no read-side primitives analogous to rcu_read_lock() and
>    452	 * rcu_read_unlock() because this primitive is intended to determine
>    453	 * that all tasks have passed through a safe state, not so much for
>    454	 * data-strcuture synchronization.
>    455	 *
>    456	 * See the description of call_rcu() for more detailed information on
>    457	 * memory ordering guarantees.
>    458	 */
>    459	void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
>    460	{
>  > 461		call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
>    462	}
>    463	EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
>    464	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


