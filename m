Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A93C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089792073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgCDQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:41:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:58655 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgCDQlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:41:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 08:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="gz'50?scan'50,208,50";a="232674571"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Mar 2020 08:41:07 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9X50-000C4e-BD; Thu, 05 Mar 2020 00:41:06 +0800
Date:   Thu, 5 Mar 2020 00:40:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.29a 43/43] kernel/rcu/tasks.h:369:2: error:
 implicit declaration of function 'call_rcu_tasks_generic'
Message-ID: <202003050056.FTPARGaw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.29a
head:   61f7110d6b78f4c84ea5d5480185740840889af7
commit: 61f7110d6b78f4c84ea5d5480185740840889af7 [43/43] rcu-tasks: Add an RCU-tasks rude variant
config: mips-rm200_defconfig (attached as .config)
compiler: mipsel-linux-gcc (GCC) 5.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 61f7110d6b78f4c84ea5d5480185740840889af7
        # save the attached .config to linux build tree
        GCC_VERSION=5.5.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

     union { typeof(x) __val; char __c[1]; } __u;   \
                    ^
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:287:22: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                         ^
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:287:42: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                                             ^
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:289:30: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                 ^
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:289:50: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                     ^
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^
   In file included from kernel/rcu/update.c:562:0:
   kernel/rcu/tasks.h:213:7: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
         t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
          ^
   kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
          !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
                               ^
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
   kernel/rcu/tasks.h:218:19: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
      list_del_init(&t->rcu_tasks_holdout_list);
                      ^
   In file included from include/linux/kernel.h:15:0,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:233:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
       t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
        ^
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                      ^
   kernel/rcu/tasks.h:233:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
       t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
                                      ^
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                      ^
   kernel/rcu/tasks.h:234:5: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
       t->rcu_tasks_idle_cpu, cpu);
        ^
   include/linux/printk.h:300:35: note: in definition of macro 'pr_alert'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                      ^
   In file included from kernel/rcu/update.c:562:0:
   kernel/rcu/tasks.h: At top level:
>> kernel/rcu/tasks.h:239:38: warning: 'struct rcu_tasks' declared inside parameter list
    static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
                                         ^
>> kernel/rcu/tasks.h:239:38: warning: its scope is only this definition or declaration, which is probably not what you want
   kernel/rcu/tasks.h: In function 'rcu_tasks_wait_gp':
   kernel/rcu/tasks.h:271:5: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
       t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
        ^
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
                  ^
   kernel/rcu/tasks.h:286:20: error: 'tasks_rcu_exit_srcu' undeclared (first use in this function)
     synchronize_srcu(&tasks_rcu_exit_srcu);
                       ^
   kernel/rcu/tasks.h:286:20: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/kernel.h:11:0,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function)
      rtst = READ_ONCE(rcu_task_stall_timeout);
                       ^
   include/linux/compiler.h:285:17: note: in definition of macro '__READ_ONCE'
     union { typeof(x) __val; char __c[1]; } __u;   \
                    ^
   kernel/rcu/tasks.h:313:10: note: in expansion of macro 'READ_ONCE'
      rtst = READ_ONCE(rcu_task_stall_timeout);
             ^
   include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                                      ^
   include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^
   include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^
   include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^
   include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member), \
                ^
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                      ^
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   include/linux/kernel.h:990:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:504:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^
   include/linux/list.h:688:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member), \
                ^
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
--
     ^
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
          pos = n, n = list_next_entry(n, member))
                       ^
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^
   include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                                      ^
   include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^
   include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^
   include/linux/kernel.h:987:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
          pos = n, n = list_next_entry(n, member))
                       ^
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^
   include/linux/list.h:537:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
     list_entry((pos)->member.next, typeof(*(pos)), member)
                     ^
   include/linux/compiler.h:374:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^
   include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/kernel.h:987:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^
   include/linux/kernel.h:988:6: note: in expansion of macro '__same_type'
        !__same_type(*(ptr), void),   \
         ^
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
          pos = n, n = list_next_entry(n, member))
                       ^
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
    #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                      ^
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   include/linux/kernel.h:990:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^
   include/linux/list.h:493:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:537:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:691:20: note: in expansion of macro 'list_next_entry'
          pos = n, n = list_next_entry(n, member))
                       ^
   kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
      list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
      ^
   In file included from kernel/rcu/update.c:562:0:
   kernel/rcu/tasks.h: At top level:
   kernel/rcu/tasks.h:347:1: warning: data definition has no type or storage class
    DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
    ^
   kernel/rcu/tasks.h:347:1: error: type defaults to 'int' in declaration of 'DEFINE_RCU_TASKS' [-Werror=implicit-int]
   kernel/rcu/tasks.h:347:1: warning: parameter names (without types) in function declaration
   kernel/rcu/tasks.h: In function 'call_rcu':
>> kernel/rcu/tasks.h:369:2: error: implicit declaration of function 'call_rcu_tasks_generic' [-Werror=implicit-function-declaration]
     call_rcu_tasks_generic(rhp, func, &rcu_tasks);
     ^
>> kernel/rcu/tasks.h:369:37: error: 'rcu_tasks' undeclared (first use in this function)
     call_rcu_tasks_generic(rhp, func, &rcu_tasks);
                                        ^
   kernel/rcu/tasks.h: In function 'synchronize_rcu':
>> kernel/rcu/tasks.h:393:2: error: implicit declaration of function 'synchronize_rcu_tasks_generic' [-Werror=implicit-function-declaration]
     synchronize_rcu_tasks_generic(&rcu_tasks);
     ^
   kernel/rcu/tasks.h:393:33: error: 'rcu_tasks' undeclared (first use in this function)
     synchronize_rcu_tasks_generic(&rcu_tasks);
                                    ^
   kernel/rcu/tasks.h: In function 'rcu_spawn_tasks_kthread':
>> kernel/rcu/tasks.h:412:2: error: implicit declaration of function 'rcu_spawn_tasks_kthread_generic' [-Werror=implicit-function-declaration]
     rcu_spawn_tasks_kthread_generic(&rcu_tasks);
     ^
   kernel/rcu/tasks.h:412:35: error: 'rcu_tasks' undeclared (first use in this function)
     rcu_spawn_tasks_kthread_generic(&rcu_tasks);
                                      ^
   kernel/rcu/tasks.h: At top level:
   kernel/rcu/tasks.h:432:43: warning: 'struct rcu_tasks' declared inside parameter list
    static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
                                              ^
   kernel/rcu/tasks.h:439:1: warning: data definition has no type or storage class
    DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
    ^
   kernel/rcu/tasks.h:439:1: error: type defaults to 'int' in declaration of 'DEFINE_RCU_TASKS' [-Werror=implicit-int]
   kernel/rcu/tasks.h:439:1: warning: parameter names (without types) in function declaration
   kernel/rcu/tasks.h: In function 'call_rcu_tasks_rude':
>> kernel/rcu/tasks.h:461:37: error: 'rcu_tasks_rude' undeclared (first use in this function)
     call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
                                        ^
   kernel/rcu/tasks.h: In function 'synchronize_rcu_tasks_rude':
   kernel/rcu/tasks.h:485:33: error: 'rcu_tasks_rude' undeclared (first use in this function)
     synchronize_rcu_tasks_generic(&rcu_tasks_rude);
                                    ^
   kernel/rcu/tasks.h: In function 'rcu_spawn_tasks_rude_kthread':
   kernel/rcu/tasks.h:504:35: error: 'rcu_tasks_rude' undeclared (first use in this function)
     rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
                                      ^
   kernel/rcu/update.c: At top level:
   kernel/rcu/tasks.h:239:13: warning: 'rcu_tasks_wait_gp' defined but not used [-Wunused-function]
    static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
                ^
   cc1: some warnings being treated as errors

vim +/call_rcu_tasks_generic +369 kernel/rcu/tasks.h

   237	
   238	/* Wait for one RCU-tasks grace period. */
 > 239	static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
   240	{
   241		struct task_struct *g, *t;
   242		unsigned long lastreport;
   243		LIST_HEAD(rcu_tasks_holdouts);
   244		int fract;
   245	
   246		/*
   247		 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
   248		 * to complete.  Invoking synchronize_rcu() suffices because all
   249		 * these transitions occur with interrupts disabled.  Without this
   250		 * synchronize_rcu(), a read-side critical section that started
   251		 * before the grace period might be incorrectly seen as having
   252		 * started after the grace period.
   253		 *
   254		 * This synchronize_rcu() also dispenses with the need for a
   255		 * memory barrier on the first store to t->rcu_tasks_holdout,
   256		 * as it forces the store to happen after the beginning of the
   257		 * grace period.
   258		 */
   259		synchronize_rcu();
   260	
   261		/*
   262		 * There were callbacks, so we need to wait for an RCU-tasks
   263		 * grace period.  Start off by scanning the task list for tasks
   264		 * that are not already voluntarily blocked.  Mark these tasks
   265		 * and make a list of them in rcu_tasks_holdouts.
   266		 */
   267		rcu_read_lock();
   268		for_each_process_thread(g, t) {
   269			if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
   270				get_task_struct(t);
   271				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
   272				WRITE_ONCE(t->rcu_tasks_holdout, true);
   273				list_add(&t->rcu_tasks_holdout_list,
   274					 &rcu_tasks_holdouts);
   275			}
   276		}
   277		rcu_read_unlock();
   278	
   279		/*
   280		 * Wait for tasks that are in the process of exiting.  This
   281		 * does only part of the job, ensuring that all tasks that were
   282		 * previously exiting reach the point where they have disabled
   283		 * preemption, allowing the later synchronize_rcu() to finish
   284		 * the job.
   285		 */
   286		synchronize_srcu(&tasks_rcu_exit_srcu);
   287	
   288		/*
   289		 * Each pass through the following loop scans the list of holdout
   290		 * tasks, removing any that are no longer holdouts.  When the list
   291		 * is empty, we are done.
   292		 */
   293		lastreport = jiffies;
   294	
   295		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
   296		fract = 10;
   297	
   298		for (;;) {
   299			bool firstreport;
   300			bool needreport;
   301			int rtst;
   302			struct task_struct *t1;
   303	
   304			if (list_empty(&rcu_tasks_holdouts))
   305				break;
   306	
   307			/* Slowly back off waiting for holdouts */
   308			schedule_timeout_interruptible(HZ/fract);
   309	
   310			if (fract > 1)
   311				fract--;
   312	
   313			rtst = READ_ONCE(rcu_task_stall_timeout);
   314			needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
   315			if (needreport)
   316				lastreport = jiffies;
   317			firstreport = true;
   318			WARN_ON(signal_pending(current));
   319			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
   320						 rcu_tasks_holdout_list) {
   321				check_holdout_task(t, needreport, &firstreport);
   322				cond_resched();
   323			}
   324		}
   325	
   326		/*
   327		 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
   328		 * memory barriers prior to them in the schedule() path, memory
   329		 * reordering on other CPUs could cause their RCU-tasks read-side
   330		 * critical sections to extend past the end of the grace period.
   331		 * However, because these ->nvcsw updates are carried out with
   332		 * interrupts disabled, we can use synchronize_rcu() to force the
   333		 * needed ordering on all such CPUs.
   334		 *
   335		 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
   336		 * accesses to be within the grace period, avoiding the need for
   337		 * memory barriers for ->rcu_tasks_holdout accesses.
   338		 *
   339		 * In addition, this synchronize_rcu() waits for exiting tasks
   340		 * to complete their final preempt_disable() region of execution,
   341		 * cleaning up after the synchronize_srcu() above.
   342		 */
   343		synchronize_rcu();
   344	}
   345	
   346	void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
   347	DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
   348	
   349	/**
   350	 * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
   351	 * @rhp: structure to be used for queueing the RCU updates.
   352	 * @func: actual callback function to be invoked after the grace period
   353	 *
   354	 * The callback function will be invoked some time after a full grace
   355	 * period elapses, in other words after all currently executing RCU
   356	 * read-side critical sections have completed. call_rcu_tasks() assumes
   357	 * that the read-side critical sections end at a voluntary context
   358	 * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
   359	 * or transition to usermode execution.  As such, there are no read-side
   360	 * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
   361	 * this primitive is intended to determine that all tasks have passed
   362	 * through a safe state, not so much for data-strcuture synchronization.
   363	 *
   364	 * See the description of call_rcu() for more detailed information on
   365	 * memory ordering guarantees.
   366	 */
   367	void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
   368	{
 > 369		call_rcu_tasks_generic(rhp, func, &rcu_tasks);
   370	}
   371	EXPORT_SYMBOL_GPL(call_rcu_tasks);
   372	
   373	/**
   374	 * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
   375	 *
   376	 * Control will return to the caller some time after a full rcu-tasks
   377	 * grace period has elapsed, in other words after all currently
   378	 * executing rcu-tasks read-side critical sections have elapsed.  These
   379	 * read-side critical sections are delimited by calls to schedule(),
   380	 * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
   381	 * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
   382	 *
   383	 * This is a very specialized primitive, intended only for a few uses in
   384	 * tracing and other situations requiring manipulation of function
   385	 * preambles and profiling hooks.  The synchronize_rcu_tasks() function
   386	 * is not (yet) intended for heavy use from multiple CPUs.
   387	 *
   388	 * See the description of synchronize_rcu() for more detailed information
   389	 * on memory ordering guarantees.
   390	 */
   391	void synchronize_rcu_tasks(void)
   392	{
 > 393		synchronize_rcu_tasks_generic(&rcu_tasks);
   394	}
   395	EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
   396	
   397	/**
   398	 * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
   399	 *
   400	 * Although the current implementation is guaranteed to wait, it is not
   401	 * obligated to, for example, if there are no pending callbacks.
   402	 */
   403	void rcu_barrier_tasks(void)
   404	{
   405		/* There is only one callback queue, so this is easy.  ;-) */
   406		synchronize_rcu_tasks();
   407	}
   408	EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
   409	
   410	static int __init rcu_spawn_tasks_kthread(void)
   411	{
 > 412		rcu_spawn_tasks_kthread_generic(&rcu_tasks);
   413		return 0;
   414	}
   415	core_initcall(rcu_spawn_tasks_kthread);
   416	
   417	////////////////////////////////////////////////////////////////////////
   418	//
   419	// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
   420	// passing an empty function to schedule_on_each_cpu().  This approach
   421	// provides an asynchronous call_rcu_rude() API and batching of concurrent
   422	// calls to the synchronous synchronize_rcu_rude() API.  This sends IPIs
   423	// far and wide and induces otherwise unnecessary context switches on all
   424	// online CPUs, whether online or not.
   425	
   426	// Empty function to allow workqueues to force a context switch.
   427	static void rcu_tasks_be_rude(struct work_struct *work)
   428	{
   429	}
   430	
   431	// Wait for one rude RCU-tasks grace period.
   432	static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
   433	{
   434		schedule_on_each_cpu(rcu_tasks_be_rude);
   435	}
   436	EXPORT_SYMBOL_GPL(rcu_tasks_rude_wait_gp);
   437	
   438	void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
   439	DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
   440	
   441	/**
   442	 * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
   443	 * @rhp: structure to be used for queueing the RCU updates.
   444	 * @func: actual callback function to be invoked after the grace period
   445	 *
   446	 * The callback function will be invoked some time after a full grace
   447	 * period elapses, in other words after all currently executing RCU
   448	 * read-side critical sections have completed. call_rcu_tasks_rude()
   449	 * assumes that the read-side critical sections end at context switch,
   450	 * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
   451	 * there are no read-side primitives analogous to rcu_read_lock() and
   452	 * rcu_read_unlock() because this primitive is intended to determine
   453	 * that all tasks have passed through a safe state, not so much for
   454	 * data-strcuture synchronization.
   455	 *
   456	 * See the description of call_rcu() for more detailed information on
   457	 * memory ordering guarantees.
   458	 */
   459	void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
   460	{
 > 461		call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
   462	}
   463	EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
   464	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/9DWx/yDrRhgMJTb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
LgEA

--/9DWx/yDrRhgMJTb--
