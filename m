Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 10:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B796623B1C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592649773;
	bh=vr08zGSX4iKcuVGDMstJbaasHUd8GanPlLYX4Jpo9as=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iTGMPg7ocQG3Pw9hBim9yeAPak5JXF2LztmeNUE/or29k7+AM3biVNj8YyL4wvQK2
	 yx1b3BgWFW3/gkng0jV+78uu73eEgF5aJmTFCCVNyH6irNAhCzX0eSpXJgCjWq586R
	 ClHCWg5iNfuSP5dcjdTmLqy7TyHToHmESb1D1YTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgFTKlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 06:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgFTKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 06:41:44 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849D22388E;
        Sat, 20 Jun 2020 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592649704;
        bh=vr08zGSX4iKcuVGDMstJbaasHUd8GanPlLYX4Jpo9as=;
        h=From:To:Cc:Subject:Date:From;
        b=hER0vTb1Sm9lgDTW1JWJS/VHW2xTJIxy2r4/TnZ/KUb3MClGi8YgsoJUkXotTkNhe
         tVqtf1jZyUTnL7FlnuYaLO1MbXsmBYFkCj0XmXCPNh4g1HFZcEXjFA7fPl8Y1F6Hp/
         0QiLTkWpfJWvrnzJASXTXkftawh2ZXnq6LCRSuJc=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] sched: fix build with GCC_PLUGIN_RANDSTRUCT
Date:   Sat, 20 Jun 2020 13:41:36 +0300
Message-Id: <20200620104136.12195-1-rppt@kernel.org>
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
+	 * so they can be on the same the @call_single_queue
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

