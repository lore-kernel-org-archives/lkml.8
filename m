Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A860C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66221556
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgCDSJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:09:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:35803 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDSJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:09:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 10:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="gz'50?scan'50,208,50";a="258842464"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Mar 2020 10:09:35 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9YSc-000DaE-NQ; Thu, 05 Mar 2020 02:09:34 +0800
Date:   Thu, 5 Mar 2020 02:08:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.29a 43/43] kernel/rcu/tasks.h:212:2: note: in
 expansion of macro 'if'
Message-ID: <202003050249.qz9t2Xfp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.29a
head:   61f7110d6b78f4c84ea5d5480185740840889af7
commit: 61f7110d6b78f4c84ea5d5480185740840889af7 [43/43] rcu-tasks: Add an RCU-tasks rude variant
config: riscv-randconfig-a001-20200304 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 61f7110d6b78f4c84ea5d5480185740840889af7
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11:0,
                    from kernel/rcu/update.c:21:
   kernel/rcu/tasks.h: In function 'check_holdout_task':
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:213:7: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
         t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
          ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
          !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
                               ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:213:7: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
         t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
          ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
          !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
                               ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
   kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
          ^~~~~~~~~
   kernel/rcu/tasks.h:213:7: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
         t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
          ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
     ^~
   kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
          !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
                               ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
   kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
     if (!READ_ONCE(t->rcu_tasks_holdout) ||
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

vim +/if +212 kernel/rcu/tasks.h

6b80543d90000c Paul E. McKenney 2020-03-02  205  
6b80543d90000c Paul E. McKenney 2020-03-02  206  /* See if tasks are still holding out, complain if so. */
6b80543d90000c Paul E. McKenney 2020-03-02  207  static void check_holdout_task(struct task_struct *t,
6b80543d90000c Paul E. McKenney 2020-03-02  208  			       bool needreport, bool *firstreport)
6b80543d90000c Paul E. McKenney 2020-03-02  209  {
6b80543d90000c Paul E. McKenney 2020-03-02  210  	int cpu;
6b80543d90000c Paul E. McKenney 2020-03-02  211  
6b80543d90000c Paul E. McKenney 2020-03-02 @212  	if (!READ_ONCE(t->rcu_tasks_holdout) ||
6b80543d90000c Paul E. McKenney 2020-03-02  213  	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
6b80543d90000c Paul E. McKenney 2020-03-02  214  	    !READ_ONCE(t->on_rq) ||
6b80543d90000c Paul E. McKenney 2020-03-02  215  	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
6b80543d90000c Paul E. McKenney 2020-03-02  216  	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
6b80543d90000c Paul E. McKenney 2020-03-02  217  		WRITE_ONCE(t->rcu_tasks_holdout, false);
6b80543d90000c Paul E. McKenney 2020-03-02  218  		list_del_init(&t->rcu_tasks_holdout_list);
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

:::::: The code at line 212 was first introduced by commit
:::::: 6b80543d90000c684123b05f075ac1433d99fa85 tasks-rcu: Move Tasks RCU to its own file

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4E8DJ5ZB6uf/B8AvmcJhtgEA

--AqsLC8rIMeq19msA--
