Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C67CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5262420838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCDOnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:43:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:56663 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgCDOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:43:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 06:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="gz'50?scan'50,208,50";a="234138510"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2020 06:43:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9VFB-000Glo-5p; Wed, 04 Mar 2020 22:43:29 +0800
Date:   Wed, 4 Mar 2020 22:42:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.29a 43/43] kernel/rcu/tasks.h:212:18: error:
 'struct task_struct' has no member named 'rcu_tasks_holdout'
Message-ID: <202003042232.vuJCoHgi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.29a
head:   61f7110d6b78f4c84ea5d5480185740840889af7
commit: 61f7110d6b78f4c84ea5d5480185740840889af7 [43/43] rcu-tasks: Add an RCU-tasks rude variant
config: nios2-3c120_defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 61f7110d6b78f4c84ea5d5480185740840889af7
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11:0,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h: In function 'check_holdout_task':
>> kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:285:17: note: in definition of macro '__READ_ONCE'
     union { typeof(x) __val; char __c[1]; } __u;   \
                    ^
>> kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
>> kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:287:22: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                         ^
>> kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
>> kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:287:42: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                                             ^
>> kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
>> kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:289:30: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                 ^
>> kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
>> kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:289:50: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                     ^
>> kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   In file included from kernel/rcu/update.c:562:0:
>> kernel/rcu/tasks.h:213:7: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
         t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
          ^~
>> kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
          !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
                               ^~
   In file included from include/linux/kernel.h:11:0,
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
>> kernel/rcu/tasks.h:218:19: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
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
>> kernel/rcu/tasks.h:239:38: warning: 'struct rcu_tasks' declared inside parameter list will not be visible outside of this definition or declaration
    static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
                                         ^~~~~~~~~
   kernel/rcu/tasks.h: In function 'rcu_tasks_wait_gp':
   kernel/rcu/tasks.h:271:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
       t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
        ^~
   In file included from include/linux/kernel.h:11:0,
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
>> kernel/rcu/tasks.h:286:20: error: 'tasks_rcu_exit_srcu' undeclared (first use in this function)
     synchronize_srcu(&tasks_rcu_exit_srcu);
                       ^~~~~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:286:20: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/kernel.h:11:0,
                    from kernel/rcu/update.c:21:
>> kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function); did you mean 'rcu_cpu_stall_reset'?
      rtst = READ_ONCE(rcu_task_stall_timeout);
                       ^
   include/linux/compiler.h:285:17: note: in definition of macro '__READ_ONCE'
     union { typeof(x) __val; char __c[1]; } __u;   \
                    ^
   kernel/rcu/tasks.h:313:10: note: in expansion of macro 'READ_ONCE'
      rtst = READ_ONCE(rcu_task_stall_timeout);
             ^~~~~~~~~
>> include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
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
>> kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
>> include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
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
>> kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
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
   In file included from include/linux/kernel.h:11:0,
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
     ^~~~~~~~~~~~
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^~~~~~~~~~
   include/linux/list.h:689:7: note: in expansion of macro 'list_next_entry'
      n = list_next_entry(pos, member);   \
          ^~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^~~~~~~~~~
   include/linux/list.h:689:7: note: in expansion of macro 'list_next_entry'
      n = list_next_entry(pos, member);   \
          ^~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/kernel.h:988:6: note: in expansion of macro '__same_type'
        !__same_type(*(ptr), void),   \
         ^~~~~~~~~~~
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)

vim +212 kernel/rcu/tasks.h

6b80543d90000c Paul E. McKenney 2020-03-02  205  
6b80543d90000c Paul E. McKenney 2020-03-02  206  /* See if tasks are still holding out, complain if so. */
6b80543d90000c Paul E. McKenney 2020-03-02  207  static void check_holdout_task(struct task_struct *t,
6b80543d90000c Paul E. McKenney 2020-03-02  208  			       bool needreport, bool *firstreport)
6b80543d90000c Paul E. McKenney 2020-03-02  209  {
6b80543d90000c Paul E. McKenney 2020-03-02  210  	int cpu;
6b80543d90000c Paul E. McKenney 2020-03-02  211  
6b80543d90000c Paul E. McKenney 2020-03-02 @212  	if (!READ_ONCE(t->rcu_tasks_holdout) ||
6b80543d90000c Paul E. McKenney 2020-03-02 @213  	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
6b80543d90000c Paul E. McKenney 2020-03-02  214  	    !READ_ONCE(t->on_rq) ||
6b80543d90000c Paul E. McKenney 2020-03-02  215  	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
6b80543d90000c Paul E. McKenney 2020-03-02 @216  	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
6b80543d90000c Paul E. McKenney 2020-03-02  217  		WRITE_ONCE(t->rcu_tasks_holdout, false);
6b80543d90000c Paul E. McKenney 2020-03-02 @218  		list_del_init(&t->rcu_tasks_holdout_list);
6b80543d90000c Paul E. McKenney 2020-03-02  219  		put_task_struct(t);
6b80543d90000c Paul E. McKenney 2020-03-02  220  		return;
6b80543d90000c Paul E. McKenney 2020-03-02  221  	}
6b80543d90000c Paul E. McKenney 2020-03-02  222  	rcu_request_urgent_qs_task(t);
6b80543d90000c Paul E. McKenney 2020-03-02  223  	if (!needreport)
6b80543d90000c Paul E. McKenney 2020-03-02  224  		return;
6b80543d90000c Paul E. McKenney 2020-03-02  225  	if (*firstreport) {
6b80543d90000c Paul E. McKenney 2020-03-02  226  		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
6b80543d90000c Paul E. McKenney 2020-03-02  227  		*firstreport = false;
6b80543d90000c Paul E. McKenney 2020-03-02  228  	}
6b80543d90000c Paul E. McKenney 2020-03-02  229  	cpu = task_cpu(t);
6b80543d90000c Paul E. McKenney 2020-03-02  230  	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
6b80543d90000c Paul E. McKenney 2020-03-02  231  		 t, ".I"[is_idle_task(t)],
6b80543d90000c Paul E. McKenney 2020-03-02  232  		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
6b80543d90000c Paul E. McKenney 2020-03-02  233  		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
6b80543d90000c Paul E. McKenney 2020-03-02  234  		 t->rcu_tasks_idle_cpu, cpu);
6b80543d90000c Paul E. McKenney 2020-03-02  235  	sched_show_task(t);
6b80543d90000c Paul E. McKenney 2020-03-02  236  }
6b80543d90000c Paul E. McKenney 2020-03-02  237  
61f7110d6b78f4 Paul E. McKenney 2020-03-02  238  /* Wait for one RCU-tasks grace period. */
61f7110d6b78f4 Paul E. McKenney 2020-03-02 @239  static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
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
6b80543d90000c Paul E. McKenney 2020-03-02 @286  	synchronize_srcu(&tasks_rcu_exit_srcu);
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
6b80543d90000c Paul E. McKenney 2020-03-02 @319  		list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
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
61f7110d6b78f4 Paul E. McKenney 2020-03-02  346  void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
61f7110d6b78f4 Paul E. McKenney 2020-03-02 @347  DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
61f7110d6b78f4 Paul E. McKenney 2020-03-02  348  
61f7110d6b78f4 Paul E. McKenney 2020-03-02  349  /**
61f7110d6b78f4 Paul E. McKenney 2020-03-02  350   * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
61f7110d6b78f4 Paul E. McKenney 2020-03-02  351   * @rhp: structure to be used for queueing the RCU updates.
61f7110d6b78f4 Paul E. McKenney 2020-03-02  352   * @func: actual callback function to be invoked after the grace period
61f7110d6b78f4 Paul E. McKenney 2020-03-02  353   *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  354   * The callback function will be invoked some time after a full grace
61f7110d6b78f4 Paul E. McKenney 2020-03-02  355   * period elapses, in other words after all currently executing RCU
61f7110d6b78f4 Paul E. McKenney 2020-03-02  356   * read-side critical sections have completed. call_rcu_tasks() assumes
61f7110d6b78f4 Paul E. McKenney 2020-03-02  357   * that the read-side critical sections end at a voluntary context
61f7110d6b78f4 Paul E. McKenney 2020-03-02  358   * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
61f7110d6b78f4 Paul E. McKenney 2020-03-02  359   * or transition to usermode execution.  As such, there are no read-side
61f7110d6b78f4 Paul E. McKenney 2020-03-02  360   * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
61f7110d6b78f4 Paul E. McKenney 2020-03-02  361   * this primitive is intended to determine that all tasks have passed
61f7110d6b78f4 Paul E. McKenney 2020-03-02  362   * through a safe state, not so much for data-strcuture synchronization.
61f7110d6b78f4 Paul E. McKenney 2020-03-02  363   *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  364   * See the description of call_rcu() for more detailed information on
61f7110d6b78f4 Paul E. McKenney 2020-03-02  365   * memory ordering guarantees.
61f7110d6b78f4 Paul E. McKenney 2020-03-02  366   */
61f7110d6b78f4 Paul E. McKenney 2020-03-02  367  void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
61f7110d6b78f4 Paul E. McKenney 2020-03-02  368  {
61f7110d6b78f4 Paul E. McKenney 2020-03-02 @369  	call_rcu_tasks_generic(rhp, func, &rcu_tasks);
6b80543d90000c Paul E. McKenney 2020-03-02  370  }
61f7110d6b78f4 Paul E. McKenney 2020-03-02  371  EXPORT_SYMBOL_GPL(call_rcu_tasks);
61f7110d6b78f4 Paul E. McKenney 2020-03-02  372  
61f7110d6b78f4 Paul E. McKenney 2020-03-02  373  /**
61f7110d6b78f4 Paul E. McKenney 2020-03-02  374   * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
61f7110d6b78f4 Paul E. McKenney 2020-03-02  375   *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  376   * Control will return to the caller some time after a full rcu-tasks
61f7110d6b78f4 Paul E. McKenney 2020-03-02  377   * grace period has elapsed, in other words after all currently
61f7110d6b78f4 Paul E. McKenney 2020-03-02  378   * executing rcu-tasks read-side critical sections have elapsed.  These
61f7110d6b78f4 Paul E. McKenney 2020-03-02  379   * read-side critical sections are delimited by calls to schedule(),
61f7110d6b78f4 Paul E. McKenney 2020-03-02  380   * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
61f7110d6b78f4 Paul E. McKenney 2020-03-02  381   * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
61f7110d6b78f4 Paul E. McKenney 2020-03-02  382   *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  383   * This is a very specialized primitive, intended only for a few uses in
61f7110d6b78f4 Paul E. McKenney 2020-03-02  384   * tracing and other situations requiring manipulation of function
61f7110d6b78f4 Paul E. McKenney 2020-03-02  385   * preambles and profiling hooks.  The synchronize_rcu_tasks() function
61f7110d6b78f4 Paul E. McKenney 2020-03-02  386   * is not (yet) intended for heavy use from multiple CPUs.
61f7110d6b78f4 Paul E. McKenney 2020-03-02  387   *
61f7110d6b78f4 Paul E. McKenney 2020-03-02  388   * See the description of synchronize_rcu() for more detailed information
61f7110d6b78f4 Paul E. McKenney 2020-03-02  389   * on memory ordering guarantees.
61f7110d6b78f4 Paul E. McKenney 2020-03-02  390   */
61f7110d6b78f4 Paul E. McKenney 2020-03-02  391  void synchronize_rcu_tasks(void)
61f7110d6b78f4 Paul E. McKenney 2020-03-02  392  {
61f7110d6b78f4 Paul E. McKenney 2020-03-02 @393  	synchronize_rcu_tasks_generic(&rcu_tasks);
6b80543d90000c Paul E. McKenney 2020-03-02  394  }
61f7110d6b78f4 Paul E. McKenney 2020-03-02  395  EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
61f7110d6b78f4 Paul E. McKenney 2020-03-02  396  

:::::: The code at line 212 was first introduced by commit
:::::: 6b80543d90000c684123b05f075ac1433d99fa85 tasks-rcu: Move Tasks RCU to its own file

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/gcYrD/9lZMAAA==

--Nq2Wo0NMKNjxTN9z--
