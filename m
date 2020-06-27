Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D5EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992CC214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593246561;
	bh=szGmIZlJg1bl0CWzihjEryyq/q9lpa2iAJMU4Ws0+Ww=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VA5IrZyIOVcdpXy6llbpNlMn7y/kZ0mzlxJF80qLs0cSf/yGj1hpHbIwI/FqqR/NK
	 SDPjgTmscOWaY2Ug2KxFu/gD/vO+lVxKZ2Z3++fwzG7LerVWtb4xSSoFcc4oPbi+aW
	 cx7LlCTVJ0RzpbhTUM3O87+DSdeTFY5u2+FnC3Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgF0I3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgF0I3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:29:19 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CBB821473;
        Sat, 27 Jun 2020 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593246559;
        bh=szGmIZlJg1bl0CWzihjEryyq/q9lpa2iAJMU4Ws0+Ww=;
        h=From:To:Cc:Subject:Date:From;
        b=N5F7k/CrH1XaTSp9J/4JvKG7kglu+keTAdP0jKMECpQS2/iXx+KQr8YBJ8KRTm5/m
         xBYn+D7Tayl7FNK6gFSNC6JhMBPtxy0uoupnxigd8pMiDyt7KrVuKG3bykxH0LMaEg
         IH5CnXdlFYVfDweuVkeBytC8qtYKnFXifh0YWFes=
From:   Mike Rapoport <rppt@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RESEND PATCH] sched: fix build with GCC_PLUGIN_RANDSTRUCT
Date:   Sat, 27 Jun 2020 11:29:12 +0300
Message-Id: <20200627082912.28303-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Since the commit a148866489fb ("sched: Replace rq::wake_list")
task_struct and CSD_TYPE_TTWU objects can be on the same queue and this
requires that have "layout similar enough".

This assumption is broken when CONFIG_GCC_PLUGIN_RANDSTRUCT is enabled:

  CHK     include/generated/compile.h
  CC      kernel/smp.o
In file included from arch/x86/include/asm/atomic.h:5,
                 from include/linux/atomic.h:7,
                 from include/linux/llist.h:51,
                 from include/linux/irq_work.h:5,
                 from kernel/smp.c:10:
kernel/smp.c: In function ‘smp_init’:
include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_157’ declared with attribute error: BUILD_BUG_ON failed: offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) != offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist)
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
  373 |    prefix ## suffix();    \
      |    ^~~~~~
include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
kernel/smp.c:687:2: note: in expansion of macro ‘BUILD_BUG_ON’
  687 |  BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
      |  ^~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:280: kernel/smp.o] Error 1
make[1]: *** [Makefile:1764: kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory '/home/mike/build/kernel'
make: *** [Makefile:185: __sub-make] Error 2

Move 'wake_entry' and 'wake_entry_type' fiels of task_struct out of the
randomized fields to keep their layout intact.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/sched.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..c885573669ac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -641,6 +641,15 @@ struct task_struct {
 	/* -1 unrunnable, 0 runnable, >0 stopped: */
 	volatile long			state;
 
+	/*
+	 * The layout of these fields must match the layout CSD_TYPE_TTWU
+	 * so they can be on the same @call_single_queue
+	 */
+#ifdef CONFIG_SMP
+	struct llist_node		wake_entry;
+	unsigned int			wake_entry_type;
+#endif
+
 	/*
 	 * This begins the randomizable portion of task_struct. Only
 	 * scheduling-critical items should be added above here.
@@ -654,8 +663,6 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct llist_node		wake_entry;
-	unsigned int			wake_entry_type;
 	int				on_cpu;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
-- 
2.25.4

