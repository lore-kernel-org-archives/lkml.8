Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527F9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A020838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgCDOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:43:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:13003 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgCDOnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:43:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 06:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="gz'50?scan'50,208,50";a="263621938"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2020 06:43:30 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9VFB-000Gog-M8; Wed, 04 Mar 2020 22:43:29 +0800
Date:   Wed, 4 Mar 2020 22:43:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.29a 43/43] kernel/rcu/tasks.h:313:20: error:
 'rcu_task_stall_timeout' undeclared
Message-ID: <202003042222.GBTOCQ9I%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.29a
head:   61f7110d6b78f4c84ea5d5480185740840889af7
commit: 61f7110d6b78f4c84ea5d5480185740840889af7 [43/43] rcu-tasks: Add an RCU-tasks rude variant
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 61f7110d6b78f4c84ea5d5480185740840889af7
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

     213 |      t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
         |       ^~
   kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
     216 |       !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
         |                            ^~
   In file included from include/linux/kernel.h:11,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     217 |   WRITE_ONCE(t->rcu_tasks_holdout, false);
         |               ^~
   include/linux/compiler.h:310:17: note: in definition of macro 'WRITE_ONCE'
     310 |  union { typeof(x) __val; char __c[1]; } __u = \
         |                 ^
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     217 |   WRITE_ONCE(t->rcu_tasks_holdout, false);
         |               ^~
   include/linux/compiler.h:311:30: note: in definition of macro 'WRITE_ONCE'
     311 |   { .__val = (__force typeof(x)) (val) }; \
         |                              ^
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     217 |   WRITE_ONCE(t->rcu_tasks_holdout, false);
         |               ^~
   include/linux/compiler.h:312:22: note: in definition of macro 'WRITE_ONCE'
     312 |  __write_once_size(&(x), __u.__c, sizeof(x)); \
         |                      ^
   kernel/rcu/tasks.h:217:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     217 |   WRITE_ONCE(t->rcu_tasks_holdout, false);
         |               ^~
   include/linux/compiler.h:312:42: note: in definition of macro 'WRITE_ONCE'
     312 |  __write_once_size(&(x), __u.__c, sizeof(x)); \
         |                                          ^
   In file included from kernel/rcu/update.c:562:
   kernel/rcu/tasks.h:218:19: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     218 |   list_del_init(&t->rcu_tasks_holdout_list);
         |                   ^~
   In file included from include/linux/kernel.h:15,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:233:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
     233 |    t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
         |     ^~
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     300 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   kernel/rcu/tasks.h:233:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     233 |    t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
         |                                   ^~
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     300 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   kernel/rcu/tasks.h:234:5: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
     234 |    t->rcu_tasks_idle_cpu, cpu);
         |     ^~
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     300 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   In file included from kernel/rcu/update.c:562:
   kernel/rcu/tasks.h: At top level:
   kernel/rcu/tasks.h:239:38: warning: 'struct rcu_tasks' declared inside parameter list will not be visible outside of this definition or declaration
     239 | static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
         |                                      ^~~~~~~~~
   kernel/rcu/tasks.h: In function 'rcu_tasks_wait_gp':
   kernel/rcu/tasks.h:271:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
     271 |    t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
         |     ^~
   In file included from include/linux/kernel.h:11,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     272 |    WRITE_ONCE(t->rcu_tasks_holdout, true);
         |                ^~
   include/linux/compiler.h:310:17: note: in definition of macro 'WRITE_ONCE'
     310 |  union { typeof(x) __val; char __c[1]; } __u = \
         |                 ^
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     272 |    WRITE_ONCE(t->rcu_tasks_holdout, true);
         |                ^~
   include/linux/compiler.h:311:30: note: in definition of macro 'WRITE_ONCE'
     311 |   { .__val = (__force typeof(x)) (val) }; \
         |                              ^
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     272 |    WRITE_ONCE(t->rcu_tasks_holdout, true);
         |                ^~
   include/linux/compiler.h:312:22: note: in definition of macro 'WRITE_ONCE'
     312 |  __write_once_size(&(x), __u.__c, sizeof(x)); \
         |                      ^
   kernel/rcu/tasks.h:272:16: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     272 |    WRITE_ONCE(t->rcu_tasks_holdout, true);
         |                ^~
   include/linux/compiler.h:312:42: note: in definition of macro 'WRITE_ONCE'
     312 |  __write_once_size(&(x), __u.__c, sizeof(x)); \
         |                                          ^
   In file included from kernel/rcu/update.c:562:
   kernel/rcu/tasks.h:273:15: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     273 |    list_add(&t->rcu_tasks_holdout_list,
         |               ^~
   kernel/rcu/tasks.h:286:20: error: 'tasks_rcu_exit_srcu' undeclared (first use in this function)
     286 |  synchronize_srcu(&tasks_rcu_exit_srcu);
         |                    ^~~~~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:286:20: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/kernel.h:11,
                    from kernel/rcu/update.c:21:
>> kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function)
     313 |   rtst = READ_ONCE(rcu_task_stall_timeout);
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:285:17: note: in definition of macro '__READ_ONCE'
     285 |  union { typeof(x) __val; char __c[1]; } __u;   \
         |                 ^
   kernel/rcu/tasks.h:313:10: note: in expansion of macro 'READ_ONCE'
     313 |   rtst = READ_ONCE(rcu_task_stall_timeout);
         |          ^~~~~~~~~
   include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     987 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
     374 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
     394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     987 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
     987 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     493 |  container_of(ptr, type, member)
         |  ^~~~~~~~~~~~
   include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
     504 |  list_entry((ptr)->next, type, member)
         |  ^~~~~~~~~~
   include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
     688 |  for (pos = list_first_entry(head, typeof(*pos), member), \
         |             ^~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
     319 |   list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:990:21: note: in expansion of macro 'offsetof'
     990 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     493 |  container_of(ptr, type, member)
         |  ^~~~~~~~~~~~
   include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
     504 |  list_entry((ptr)->next, type, member)
         |  ^~~~~~~~~~
   include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
     688 |  for (pos = list_first_entry(head, typeof(*pos), member), \
         |             ^~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
     319 |   list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/update.c:21:
   include/linux/list.h:537:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     537 |  list_entry((pos)->member.next, typeof(*(pos)), member)
         |                  ^~
   include/linux/kernel.h:986:26: note: in definition of macro 'container_of'
     986 |  void *__mptr = (void *)(ptr);     \
         |                          ^~~
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     537 |  list_entry((pos)->member.next, typeof(*(pos)), member)
         |  ^~~~~~~~~~
   include/linux/list.h:689:7: note: in expansion of macro 'list_next_entry'
     689 |   n = list_next_entry(pos, member);   \
         |       ^~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
     319 |   list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from kernel/rcu/update.c:21:
   include/linux/list.h:537:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     537 |  list_entry((pos)->member.next, typeof(*(pos)), member)
         |                  ^~
   include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
     374 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
     394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     987 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
     987 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     493 |  container_of(ptr, type, member)
         |  ^~~~~~~~~~~~
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'

vim +/rcu_task_stall_timeout +313 kernel/rcu/tasks.h

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
6b80543d90000c Paul E. McKenney 2020-03-02 @273  			list_add(&t->rcu_tasks_holdout_list,
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

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/B+LBmt2dkkAAA==

--FCuugMFkClbJLl1L--
