Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB50AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9F0207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593329239;
	bh=dUqBBxgnP5eS6BruCJpKa8f5WXAIBflVt4Sm1RNBnwA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EFvrdON4JRQqpumnm83EZ+dx3i1z2F1HczE2RifOp5QiB0JWQprvqzAfoq5qd+2L+
	 ywBov0W7QBzobKnsjcm5LV5WBPJX4GzDbVZPDKn4FMwo3WyrXRmHjOtIQKT8L5AvOp
	 ZwcTxqOO6WP+Lrse8yDMmOSwpHCHsKW/7NBL5YIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgF1H1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgF1H1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:27:17 -0400
Received: from hump.s81c.com (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EFE420768;
        Sun, 28 Jun 2020 07:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593329237;
        bh=dUqBBxgnP5eS6BruCJpKa8f5WXAIBflVt4Sm1RNBnwA=;
        h=From:To:Cc:Subject:Date:From;
        b=eGKjm/8Spg2HXSxSoNvLXNgD5QW5W5kh022avLDwpc2rN+s9U8bLBT3kA3XMxoUFh
         9tvSF+ENB444laMXd8nyL6gn5cIRn8wAwF6RRDnbqgco3wuy8EgtrgnbLqz8ku9Jwg
         aQrWddyKY3yRzPJdc+beVndSmoknDG5HkGvCEVhs=
From:   Mike Rapoport <rppt@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched: fix build with GCC_PLUGIN_RANDSTRUCT
Date:   Sun, 28 Jun 2020 10:27:02 +0300
Message-Id: <20200628072702.1249815-1-rppt@kernel.org>
X-Mailer: git-send-email 2.25.4
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
requires that have layout similar enough.

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

Wrap 'wake_entry' and 'wake_entry_type' fiels of task_struct in an
anonymous struct to keep their relative layout intact during
randomization.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

v2: use anonymous struct as Steven suggested.

 include/linux/sched.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..7e30a09df616 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -654,8 +654,15 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct llist_node		wake_entry;
-	unsigned int			wake_entry_type;
+       /*
+        * The layout of these fields must match the layout of CSD_TYPE_TTWU
+        * so they can be on the same @call_single_queue
+        */
+	struct {
+		struct llist_node		wake_entry;
+		unsigned int			wake_entry_type;
+	};
+
 	int				on_cpu;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
-- 
2.25.4

