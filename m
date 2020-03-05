Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F477208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgCEFoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:44:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:26226 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCEFoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:44:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 21:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="263857461"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2020 21:43:59 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9jIc-0004Nh-L7; Thu, 05 Mar 2020 13:43:58 +0800
Date:   Thu, 05 Mar 2020 13:43:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.29a] BUILD REGRESSION
 61f7110d6b78f4c84ea5d5480185740840889af7
Message-ID: <5e609188.Hl+KSndTIea2sA36%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.29a
branch HEAD: 61f7110d6b78f4c84ea5d5480185740840889af7  rcu-tasks: Add an RCU-tasks rude variant

Regressions in current branch:

include/linux/compiler_types.h:129:35: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
include/linux/kernel.h:1012:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
include/linux/kernel.h:987:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
include/linux/kernel.h:994:51: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
include/linux/list.h:537:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
include/linux/list.h:689:7: note: in expansion of macro 'list_next_entry'
kernel/rcu/tasks.h:212:18: error: 'struct task_struct' has no member named 'rcu_tasks_holdout'
kernel/rcu/tasks.h:212:2: note: in expansion of macro 'if'
kernel/rcu/tasks.h:212:7: note: in expansion of macro 'READ_ONCE'
kernel/rcu/tasks.h:213:7: error: 'struct task_struct' has no member named 'rcu_tasks_nvcsw'
kernel/rcu/tasks.h:216:28: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
kernel/rcu/tasks.h:218:19: error: 'struct task_struct' has no member named 'rcu_tasks_holdout_list'
kernel/rcu/tasks.h:239:38: warning: 'struct rcu_tasks' declared inside parameter list
kernel/rcu/tasks.h:239:38: warning: 'struct rcu_tasks' declared inside parameter list will not be visible outside of this definition or declaration
kernel/rcu/tasks.h:239:38: warning: its scope is only this definition or declaration, which is probably not what you want
kernel/rcu/tasks.h:286:20: error: 'tasks_rcu_exit_srcu' undeclared (first use in this function)
kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function)
kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function); did you mean 'rcu_cpu_stall_reset'?
kernel/rcu/tasks.h:313:20: error: 'rcu_task_stall_timeout' undeclared (first use in this function); did you mean 'rcu_cpu_stall_timeout'?
kernel/rcu/tasks.h:319:3: note: in expansion of macro 'list_for_each_entry_safe'
kernel/rcu/tasks.h:347:1: error: type defaults to 'int' in declaration of 'DEFINE_RCU_TASKS' [-Werror=implicit-int]
kernel/rcu/tasks.h:347:1: warning: data definition has no type or storage class
kernel/rcu/tasks.h:347:1: warning: parameter names (without types) in function declaration
kernel/rcu/tasks.h:369:2: error: implicit declaration of function 'call_rcu_tasks_generic' [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:369:2: error: implicit declaration of function 'call_rcu_tasks_generic'; did you mean 'call_rcu_tasks'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:369:37: error: 'rcu_tasks' undeclared (first use in this function)
kernel/rcu/tasks.h:369:37: error: 'rcu_tasks' undeclared (first use in this function); did you mean 'rt_task'?
kernel/rcu/tasks.h:393:2: error: implicit declaration of function 'synchronize_rcu_tasks_generic' [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:393:2: error: implicit declaration of function 'synchronize_rcu_tasks_generic'; did you mean 'synchronize_rcu_tasks'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:412:2: error: implicit declaration of function 'rcu_spawn_tasks_kthread_generic' [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:412:2: error: implicit declaration of function 'rcu_spawn_tasks_kthread_generic'; did you mean 'rcu_spawn_tasks_kthread'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:461:37: error: 'rcu_tasks_rude' undeclared (first use in this function)
kernel/rcu/tasks.h:461:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_be_rude'?

Error ids grouped by kconfigs:

recent_errors
|-- alpha-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arc-alldefconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arc-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-at91_dt_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-bcm2835_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-cm_x300_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-imx_v6_v7_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-ixp4xx_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-lubbock_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-mps2_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-multi_v4t_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-multi_v7_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-mvebu_v7_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-mxs_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-netwinder_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-omap2plus_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-shmobile_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-spear6xx_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-sunxi_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-tct_hammer_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-versatile_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-vexpress_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-xcep_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm64-alldefconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm64-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- c6x-evmc6474_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- c6x-evmc6678_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- c6x-randconfig-a001-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- csky-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- h8300-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- h8300-edosk2674_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- h8300-h8300h-sim_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- h8300-h8s-sim_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- h8300-randconfig-a001-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- h8300-randconfig-a001-20200305
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-alldefconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-b003-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-c003-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-d003-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-e001-20200305
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-e003-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-if
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-f001-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-f003-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-g003-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- ia64-alldefconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- ia64-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- ia64-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-apollo_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-m5272c3_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-m5475evb_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-multi_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-q40_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-sun3_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- microblaze-mmu_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- microblaze-nommu_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- mips-32r2_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- mips-64r6el_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:its-scope-is-only-this-definition-or-declaration-which-is-probably-not-what-you-want
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list
|-- mips-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- mips-ath25_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- mips-fuloong2e_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:its-scope-is-only-this-definition-or-declaration-which-is-probably-not-what-you-want
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list
|-- mips-ip32_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- mips-malta_kvm_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:its-scope-is-only-this-definition-or-declaration-which-is-probably-not-what-you-want
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list
|-- mips-maltasmvp_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:its-scope-is-only-this-definition-or-declaration-which-is-probably-not-what-you-want
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list
|-- mips-maltasmvp_eva_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   `-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|-- mips-qi_lb60_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   `-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|-- mips-rm200_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:its-scope-is-only-this-definition-or-declaration-which-is-probably-not-what-you-want
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list
|-- mips-sb1250_swarm_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- nds32-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- nios2-10m50_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- nios2-3c120_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- openrisc-or1ksim_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- openrisc-simple_smp_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- parisc-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- parisc-generic-32bit_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- parisc-generic-64bit_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-arches_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-icon_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-pmac32_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-ppc64_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-ps3_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-redwood_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-rhel-kconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-socrates_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-storcenter_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-tqm5200_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-tqm8xx_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- riscv-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- riscv-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- riscv-nommu_virt_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- riscv-randconfig-a001-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-if
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- riscv-rv32_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- s390-alldefconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- s390-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- s390-zfcpdump_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- sh-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- sh-rsk7269_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- sh-se7712_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- sparc-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- sparc-randconfig-a001-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-if
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- sparc64-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- sparc64-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- um-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- um-i386_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- um-x86_64_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- x86_64-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- x86_64-randconfig-a001-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-if
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- x86_64-randconfig-c002-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-if
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- x86_64-randconfig-d002-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- x86_64-randconfig-f002-20200304
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- x86_64-randconfig-s1-20200305
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_timeout
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:its-scope-is-only-this-definition-or-declaration-which-is-probably-not-what-you-want
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   |-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- xtensa-common_defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- xtensa-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
|   |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
|   |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
|   |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
|   |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
|   |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
|   |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
`-- xtensa-iss_defconfig
    |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
    |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
    |-- include-linux-list.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
    |-- include-linux-list.h:note:in-expansion-of-macro-list_next_entry
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-call_rcu_tasks_generic-did-you-mean-call_rcu_tasks
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-rcu_spawn_tasks_kthread_generic-did-you-mean-rcu_spawn_tasks_kthread
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-synchronize_rcu_tasks_generic-did-you-mean-synchronize_rcu_tasks
    |-- kernel-rcu-tasks.h:error:rcu_task_stall_timeout-undeclared-(first-use-in-this-function)-did-you-mean-rcu_cpu_stall_reset
    |-- kernel-rcu-tasks.h:error:rcu_tasks-undeclared-(first-use-in-this-function)-did-you-mean-rt_task
    |-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_be_rude
    |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout
    |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_holdout_list
    |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idle_cpu
    |-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_nvcsw
    |-- kernel-rcu-tasks.h:error:tasks_rcu_exit_srcu-undeclared-(first-use-in-this-function)
    |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RCU_TASKS
    |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-READ_ONCE
    |-- kernel-rcu-tasks.h:note:in-expansion-of-macro-list_for_each_entry_safe
    |-- kernel-rcu-tasks.h:warning:data-definition-has-no-type-or-storage-class
    |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
    `-- kernel-rcu-tasks.h:warning:struct-rcu_tasks-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration

elapsed time: 994m

configs tested: 181
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
parisc                           allyesconfig
ia64                                defconfig
powerpc                             defconfig
csky                                defconfig
mips                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
sh                          rsk7269_defconfig
i386                              allnoconfig
s390                       zfcpdump_defconfig
sparc64                          allmodconfig
riscv                             allnoconfig
sh                               allmodconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allyesconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200304
x86_64               randconfig-a002-20200304
x86_64               randconfig-a003-20200304
i386                 randconfig-a001-20200304
i386                 randconfig-a002-20200304
i386                 randconfig-a003-20200304
alpha                randconfig-a001-20200304
m68k                 randconfig-a001-20200304
mips                 randconfig-a001-20200304
nds32                randconfig-a001-20200304
parisc               randconfig-a001-20200304
riscv                randconfig-a001-20200304
c6x                  randconfig-a001-20200305
h8300                randconfig-a001-20200305
microblaze           randconfig-a001-20200305
nios2                randconfig-a001-20200305
sparc64              randconfig-a001-20200305
c6x                  randconfig-a001-20200304
h8300                randconfig-a001-20200304
microblaze           randconfig-a001-20200304
nios2                randconfig-a001-20200304
sparc64              randconfig-a001-20200304
csky                 randconfig-a001-20200304
openrisc             randconfig-a001-20200304
s390                 randconfig-a001-20200304
sh                   randconfig-a001-20200304
xtensa               randconfig-a001-20200304
x86_64               randconfig-b001-20200304
x86_64               randconfig-b002-20200304
x86_64               randconfig-b003-20200304
i386                 randconfig-b001-20200304
i386                 randconfig-b002-20200304
i386                 randconfig-b003-20200304
x86_64               randconfig-b001-20200305
x86_64               randconfig-b002-20200305
x86_64               randconfig-b003-20200305
i386                 randconfig-b001-20200305
i386                 randconfig-b002-20200305
i386                 randconfig-b003-20200305
x86_64               randconfig-c001-20200304
x86_64               randconfig-c002-20200304
x86_64               randconfig-c003-20200304
i386                 randconfig-c001-20200304
i386                 randconfig-c002-20200304
i386                 randconfig-c003-20200304
x86_64               randconfig-d001-20200304
x86_64               randconfig-d002-20200304
x86_64               randconfig-d003-20200304
i386                 randconfig-d001-20200304
i386                 randconfig-d002-20200304
i386                 randconfig-d003-20200304
x86_64               randconfig-e001-20200304
x86_64               randconfig-e002-20200304
x86_64               randconfig-e003-20200304
i386                 randconfig-e001-20200304
i386                 randconfig-e002-20200304
i386                 randconfig-e003-20200304
x86_64               randconfig-e001-20200305
x86_64               randconfig-e002-20200305
x86_64               randconfig-e003-20200305
i386                 randconfig-e001-20200305
i386                 randconfig-e002-20200305
i386                 randconfig-e003-20200305
x86_64               randconfig-f001-20200304
x86_64               randconfig-f002-20200304
x86_64               randconfig-f003-20200304
i386                 randconfig-f001-20200304
i386                 randconfig-f002-20200304
i386                 randconfig-f003-20200304
x86_64               randconfig-g001-20200304
x86_64               randconfig-g002-20200304
x86_64               randconfig-g003-20200304
i386                 randconfig-g001-20200304
i386                 randconfig-g002-20200304
i386                 randconfig-g003-20200304
x86_64               randconfig-h001-20200304
x86_64               randconfig-h002-20200304
x86_64               randconfig-h003-20200304
i386                 randconfig-h001-20200304
i386                 randconfig-h002-20200304
i386                 randconfig-h003-20200304
arc                  randconfig-a001-20200304
ia64                 randconfig-a001-20200304
sparc                randconfig-a001-20200304
arm                  randconfig-a001-20200304
arm64                randconfig-a001-20200304
powerpc              randconfig-a001-20200304
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
sh                                allnoconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
