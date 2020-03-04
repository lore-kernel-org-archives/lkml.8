Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38CCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8822620848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbgCDPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:07:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:15316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbgCDPHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:07:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 07:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="gz'50?scan'50,208,50";a="234146391"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2020 07:07:35 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9VcU-000HZ9-N9; Wed, 04 Mar 2020 23:07:34 +0800
Date:   Wed, 4 Mar 2020 23:06:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.29a 43/43] kernel/rcu/tasks.h:313:20: error:
 'rcu_task_stall_timeout' undeclared; did you mean 'rcu_cpu_stall_timeout'?
Message-ID: <202003042328.7MpvzC0L%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.29a
head:   61f7110d6b78f4c84ea5d5480185740840889af7
commit: 61f7110d6b78f4c84ea5d5480185740840889af7 [43/43] rcu-tasks: Add an RCU-tasks rude variant
config: i386-defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
reproduce:
        git checkout 61f7110d6b78f4c84ea5d5480185740840889af7
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
      WRITE_ONCE(t->rcu_tasks_holdout, false);
                  ^
   include/linux/compiler.h:310:17: note: in definition of macro 'WRITE_ONCE'
     union { typeof(x) __val; char __c[1]; } __u = \
                    ^
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
      WRITE_ONCE(t->rcu_tasks_holdout, false);
                  ^
   include/linux/compiler.h:311:30: note: in definition of macro 'WRITE_ONCE'
      { .__val = (__force typeof(x)) (val) }; \
                                 ^
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
      WRITE_ONCE(t->rcu_tasks_holdout, false);
                  ^
   include/linux/compiler.h:312:22: note: in definition of macro 'WRITE_ONCE'
     __write_once_size(&(x), __u.__c, sizeof(x)); \
                         ^
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
      WRITE_ONCE(t->rcu_tasks_holdout, false);
                  ^
   include/linux/compiler.h:312:42: note: in definition of macro 'WRITE_ONCE'
     __write_once_size(&(x), __u.__c, sizeof(x)); \
                                             ^
   In file included from kernel/rcu/update.c:562:0:
   kernel/rcu/tasks.h:218:19: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
      list_del_init(&t->rcu_tasks_holdout_list);
                      ^~
   In file included from include/linux/kernel.h:15:0,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:233:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
       t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
        ^
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                      ^~~~~~~~~~~
   kernel/rcu/tasks.h:233:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
       t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
                                      ^
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                      ^~~~~~~~~~~
   kernel/rcu/tasks.h:234:5: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
       t->rcu_tasks_idle_cpu, cpu);
        ^
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                      ^~~~~~~~~~~
   In file included from kernel/rcu/update.c:562:0:
   kernel/rcu/tasks.h: At top level:
   kernel/rcu/tasks.h:239:38: warning: 'struct rcu_tasks' declared inside parameter list will not be visible outside of this definition or declaration
    static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
                                         ^~~~~~~~~
   kernel/rcu/tasks.h: In function 'rcu_tasks_wait_gp':
   kernel/rcu/tasks.h:271:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
       t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
        ^~
   In file included from include/linux/export.h:43:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
       WRITE_ONCE(t->rcu_tasks_holdout, true);
                   ^
   include/linux/compiler.h:310:17: note: in definition of macro 'WRITE_ONCE'
     union { typeof(x) __val; char __c[1]; } __u = \
                    ^
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
       WRITE_ONCE(t->rcu_tasks_holdout, true);
                   ^
   include/linux/compiler.h:311:30: note: in definition of macro 'WRITE_ONCE'
      { .__val = (__force typeof(x)) (val) }; \
                                 ^
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
       WRITE_ONCE(t->rcu_tasks_holdout, true);
                   ^
   include/linux/compiler.h:312:22: note: in definition of macro 'WRITE_ONCE'
     __write_once_size(&(x), __u.__c, sizeof(x)); \
                         ^
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
       WRITE_ONCE(t->rcu_tasks_holdout, true);
                   ^
   include/linux/compiler.h:312:42: note: in definition of macro 'WRITE_ONCE'
     __write_once_size(&(x), __u.__c, sizeof(x)); \
                                             ^
   In file included from kernel/rcu/update.c:562:0:
   kernel/rcu/tasks.h:273:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
       list_add(&t->rcu_tasks_holdout_list,
                  ^~
   kernel/rcu/tasks.h:286:20: error: 'tasks_rcu_exit_srcu' undeclared (first use in this function)
     synchronize_srcu(&tasks_rcu_exit_srcu);
                       ^~~~~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:286:20: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/export.h:43:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from kernel/rcu/update.c:21:
>> kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function); did you mean 'rcu_cpu_stall_timeout'?
      rtst = READ_ONCE(rcu_task_stall_timeout);
                       ^
   include/linux/compiler.h:285:17: note: in definition of macro '__READ_ONCE'
     union { typeof(x) __val; char __c[1]; } __u;   \
                    ^
   kernel/rcu/tasks.h:313:10: note: in expansion of macro 'READ_ONCE'
      rtst = READ_ONCE(rcu_task_stall_timeout);
             ^~~~~~~~~
   include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                                      ^
   include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member), \
                ^~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                      ^
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:990:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member), \
                ^~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/update.c:21:0:
   include/linux/list.h:537:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     list_entry((pos)->member.next, typeof(*(pos)), member)
                     ^
   include/linux/kernel.h:986:26: note: in definition of macro 'container_of'
     void *__mptr = (void *)(ptr);     \
                             ^~~
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^~~~~~~~~~
   include/linux/list.h:689:7: note: in expansion of macro 'list_next_entry'
      n = list_next_entry(pos, member);   \
          ^~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/export.h:43:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from kernel/rcu/update.c:21:
   include/linux/list.h:537:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     list_entry((pos)->member.next, typeof(*(pos)), member)
                     ^
   include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)

vim +313 kernel/rcu/tasks.h

6b80543d90000c Paul E. McKenney 2020-03-02  237  
61f7110d6b78f4 Paul E. McKenney 2020-03-02  238  /* Wait for one RCU-tasks grace period. */
61f7110d6b78f4 Paul E. McKenney 2020-03-02  239  static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
6b80543d90000c Paul E. McKenney 2020-03-02  240  {
6b80543d90000c Paul E. McKenney 2020-03-02  241  	struct task_struct *g, *t;
6b80543d90000c Paul E. McKenney 2020-03-02  242  	unsigned long lastreport;
6b80543d90000c Paul E. McKenney 2020-03-02  243  	LIST_HEAD(rcu_tasks_holdouts);
6b80543d90000c Paul E. McKenney 2020-03-02  244  	int fract;
6b80543d90000c Paul E. McKenney 2020-03-02  245  
6b80543d90000c Paul E. McKenney 2020-03-02  246  	/*
61f7110d6b78f4 Paul E. McKenney 2020-03-02  247  	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
61f7110d6b78f4 Paul E. McKenney 2020-03-02  248  	 * to complete.  Invoking synchronize_rcu() suffices because all
61f7110d6b78f4 Paul E. McKenney 2020-03-02  249  	 * these transitions occur with interrupts disabled.  Without this
61f7110d6b78f4 Paul E. McKenney 2020-03-02  250  	 * synchronize_rcu(), a read-side critical section that started
61f7110d6b78f4 Paul E. McKenney 2020-03-02  251  	 * before the grace period might be incorrectly seen as having
61f7110d6b78f4 Paul E. McKenney 2020-03-02  252  	 * started after the grace period.
6b80543d90000c Paul E. McKenney 2020-03-02  253  	 *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  254  	 * This synchronize_rcu() also dispenses with the need for a
61f7110d6b78f4 Paul E. McKenney 2020-03-02  255  	 * memory barrier on the first store to t->rcu_tasks_holdout,
61f7110d6b78f4 Paul E. McKenney 2020-03-02  256  	 * as it forces the store to happen after the beginning of the
61f7110d6b78f4 Paul E. McKenney 2020-03-02  257  	 * grace period.
6b80543d90000c Paul E. McKenney 2020-03-02  258  	 */
6b80543d90000c Paul E. McKenney 2020-03-02  259  	synchronize_rcu();
6b80543d90000c Paul E. McKenney 2020-03-02  260  
6b80543d90000c Paul E. McKenney 2020-03-02  261  	/*
61f7110d6b78f4 Paul E. McKenney 2020-03-02  262  	 * There were callbacks, so we need to wait for an RCU-tasks
61f7110d6b78f4 Paul E. McKenney 2020-03-02  263  	 * grace period.  Start off by scanning the task list for tasks
61f7110d6b78f4 Paul E. McKenney 2020-03-02  264  	 * that are not already voluntarily blocked.  Mark these tasks
61f7110d6b78f4 Paul E. McKenney 2020-03-02  265  	 * and make a list of them in rcu_tasks_holdouts.
6b80543d90000c Paul E. McKenney 2020-03-02  266  	 */
6b80543d90000c Paul E. McKenney 2020-03-02  267  	rcu_read_lock();
6b80543d90000c Paul E. McKenney 2020-03-02  268  	for_each_process_thread(g, t) {
61f7110d6b78f4 Paul E. McKenney 2020-03-02  269  		if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
6b80543d90000c Paul E. McKenney 2020-03-02  270  			get_task_struct(t);
6b80543d90000c Paul E. McKenney 2020-03-02  271  			t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
6b80543d90000c Paul E. McKenney 2020-03-02  272  			WRITE_ONCE(t->rcu_tasks_holdout, true);
6b80543d90000c Paul E. McKenney 2020-03-02  273  			list_add(&t->rcu_tasks_holdout_list,
6b80543d90000c Paul E. McKenney 2020-03-02  274  				 &rcu_tasks_holdouts);
6b80543d90000c Paul E. McKenney 2020-03-02  275  		}
6b80543d90000c Paul E. McKenney 2020-03-02  276  	}
6b80543d90000c Paul E. McKenney 2020-03-02  277  	rcu_read_unlock();
6b80543d90000c Paul E. McKenney 2020-03-02  278  
6b80543d90000c Paul E. McKenney 2020-03-02  279  	/*
61f7110d6b78f4 Paul E. McKenney 2020-03-02  280  	 * Wait for tasks that are in the process of exiting.  This
61f7110d6b78f4 Paul E. McKenney 2020-03-02  281  	 * does only part of the job, ensuring that all tasks that were
61f7110d6b78f4 Paul E. McKenney 2020-03-02  282  	 * previously exiting reach the point where they have disabled
61f7110d6b78f4 Paul E. McKenney 2020-03-02  283  	 * preemption, allowing the later synchronize_rcu() to finish
61f7110d6b78f4 Paul E. McKenney 2020-03-02  284  	 * the job.
6b80543d90000c Paul E. McKenney 2020-03-02  285  	 */
6b80543d90000c Paul E. McKenney 2020-03-02  286  	synchronize_srcu(&tasks_rcu_exit_srcu);
6b80543d90000c Paul E. McKenney 2020-03-02  287  
6b80543d90000c Paul E. McKenney 2020-03-02  288  	/*
61f7110d6b78f4 Paul E. McKenney 2020-03-02  289  	 * Each pass through the following loop scans the list of holdout
61f7110d6b78f4 Paul E. McKenney 2020-03-02  290  	 * tasks, removing any that are no longer holdouts.  When the list
61f7110d6b78f4 Paul E. McKenney 2020-03-02  291  	 * is empty, we are done.
6b80543d90000c Paul E. McKenney 2020-03-02  292  	 */
6b80543d90000c Paul E. McKenney 2020-03-02  293  	lastreport = jiffies;
6b80543d90000c Paul E. McKenney 2020-03-02  294  
61f7110d6b78f4 Paul E. McKenney 2020-03-02  295  	/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
6b80543d90000c Paul E. McKenney 2020-03-02  296  	fract = 10;
6b80543d90000c Paul E. McKenney 2020-03-02  297  
6b80543d90000c Paul E. McKenney 2020-03-02  298  	for (;;) {
6b80543d90000c Paul E. McKenney 2020-03-02  299  		bool firstreport;
6b80543d90000c Paul E. McKenney 2020-03-02  300  		bool needreport;
6b80543d90000c Paul E. McKenney 2020-03-02  301  		int rtst;
6b80543d90000c Paul E. McKenney 2020-03-02  302  		struct task_struct *t1;
6b80543d90000c Paul E. McKenney 2020-03-02  303  
6b80543d90000c Paul E. McKenney 2020-03-02  304  		if (list_empty(&rcu_tasks_holdouts))
6b80543d90000c Paul E. McKenney 2020-03-02  305  			break;
6b80543d90000c Paul E. McKenney 2020-03-02  306  
6b80543d90000c Paul E. McKenney 2020-03-02  307  		/* Slowly back off waiting for holdouts */
6b80543d90000c Paul E. McKenney 2020-03-02  308  		schedule_timeout_interruptible(HZ/fract);
6b80543d90000c Paul E. McKenney 2020-03-02  309  
6b80543d90000c Paul E. McKenney 2020-03-02  310  		if (fract > 1)
6b80543d90000c Paul E. McKenney 2020-03-02  311  			fract--;
6b80543d90000c Paul E. McKenney 2020-03-02  312  
6b80543d90000c Paul E. McKenney 2020-03-02 @313  		rtst = READ_ONCE(rcu_task_stall_timeout);
61f7110d6b78f4 Paul E. McKenney 2020-03-02  314  		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
6b80543d90000c Paul E. McKenney 2020-03-02  315  		if (needreport)
6b80543d90000c Paul E. McKenney 2020-03-02  316  			lastreport = jiffies;
6b80543d90000c Paul E. McKenney 2020-03-02  317  		firstreport = true;
6b80543d90000c Paul E. McKenney 2020-03-02  318  		WARN_ON(signal_pending(current));
6b80543d90000c Paul E. McKenney 2020-03-02  319  		list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
6b80543d90000c Paul E. McKenney 2020-03-02  320  					 rcu_tasks_holdout_list) {
6b80543d90000c Paul E. McKenney 2020-03-02  321  			check_holdout_task(t, needreport, &firstreport);
6b80543d90000c Paul E. McKenney 2020-03-02  322  			cond_resched();
6b80543d90000c Paul E. McKenney 2020-03-02  323  		}
6b80543d90000c Paul E. McKenney 2020-03-02  324  	}
6b80543d90000c Paul E. McKenney 2020-03-02  325  
6b80543d90000c Paul E. McKenney 2020-03-02  326  	/*
61f7110d6b78f4 Paul E. McKenney 2020-03-02  327  	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
61f7110d6b78f4 Paul E. McKenney 2020-03-02  328  	 * memory barriers prior to them in the schedule() path, memory
61f7110d6b78f4 Paul E. McKenney 2020-03-02  329  	 * reordering on other CPUs could cause their RCU-tasks read-side
61f7110d6b78f4 Paul E. McKenney 2020-03-02  330  	 * critical sections to extend past the end of the grace period.
61f7110d6b78f4 Paul E. McKenney 2020-03-02  331  	 * However, because these ->nvcsw updates are carried out with
61f7110d6b78f4 Paul E. McKenney 2020-03-02  332  	 * interrupts disabled, we can use synchronize_rcu() to force the
61f7110d6b78f4 Paul E. McKenney 2020-03-02  333  	 * needed ordering on all such CPUs.
6b80543d90000c Paul E. McKenney 2020-03-02  334  	 *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  335  	 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
61f7110d6b78f4 Paul E. McKenney 2020-03-02  336  	 * accesses to be within the grace period, avoiding the need for
61f7110d6b78f4 Paul E. McKenney 2020-03-02  337  	 * memory barriers for ->rcu_tasks_holdout accesses.
6b80543d90000c Paul E. McKenney 2020-03-02  338  	 *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  339  	 * In addition, this synchronize_rcu() waits for exiting tasks
61f7110d6b78f4 Paul E. McKenney 2020-03-02  340  	 * to complete their final preempt_disable() region of execution,
61f7110d6b78f4 Paul E. McKenney 2020-03-02  341  	 * cleaning up after the synchronize_srcu() above.
6b80543d90000c Paul E. McKenney 2020-03-02  342  	 */
6b80543d90000c Paul E. McKenney 2020-03-02  343  	synchronize_rcu();
61f7110d6b78f4 Paul E. McKenney 2020-03-02  344  }
6b80543d90000c Paul E. McKenney 2020-03-02  345  

:::::: The code at line 313 was first introduced by commit
:::::: 6b80543d90000c684123b05f075ac1433d99fa85 tasks-rcu: Move Tasks RCU to its own file

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--NzB8fVQJ5HfG6fxh--
