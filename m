Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70024C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC7C207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tp6mc21p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCEWHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:07:11 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37034 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:07:10 -0500
Received: by mail-yw1-f73.google.com with SMTP id e65so483463ywb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2LVcA//xMsKOt9mjU3OYra05ePTxLPNjdiCeiJ24xHk=;
        b=tp6mc21pjpEVC/Bxg5uRQ8lu2TqFDqX0UYwIzbpG9H0v6lN7bVZ5iU89ZnmJOWtxRC
         9kmZCFUw4iqgudvVlYlcmANtnCyebknVFaq85mFKgMxmte4F5NPbmBJSiXK/B0MndD2Q
         VBMfJTALe0+UOb8gVyi+TXs8KfXucmUnzJwzuBSJqdhm2TzdXdBBwN5UgFpbKF22J9nC
         t11291VMg25ZF42xds17jWLhJZI6kZksAawC1DYfsVE0c09KEfbtWr526+j0MaNUHFBT
         P1/4MQ85DHTY3oE0QSgQI/gptaqqq2uRb3u4RpeqCK9Dne3JzGcPW4UFhG3KE/XbyGmr
         f96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2LVcA//xMsKOt9mjU3OYra05ePTxLPNjdiCeiJ24xHk=;
        b=UMveBiNdRDiFivBYO/zT8tuG7O9yBkfQhq/Do7iO048qdU5BXzO7u3sjrK6yyxGToD
         7jys5DlBuVeTZ9tbustgBrqq35eaX972bFhTLzE07Ya4hOnuLUdaU7v/eZ8r4uFcBB+T
         Dz/mMHLU3ODgFJl23Z5LupU4Usi8K9HCHxaWUmL4qN1DLncy/9/TGKl1gBXh+i9UCovr
         fgXV3g++N4lnsTkhzKnu+QhpmTedJ+LykFRMZVP90TOdlO9JrLwjyq2OQcFbuXQ0HASi
         N8THb6seEdW3sBMWi5inabhMZI/dn6Za02MrS3RHeS3rJnvN4hhvuvgHNmd9SnWBUgdy
         GIwA==
X-Gm-Message-State: ANhLgQ1K7E3zCYQk6reWK4FsYBwmegq3oSW5bgGKAcmB9qgDNpqz5akD
        dTqKCrBwed8Y+HerSvmx1zj1bwznEg==
X-Google-Smtp-Source: ADFU+vvRvYVdkAKhRDokkTvwayFr2Hw4PUNZmqDX0wQnxghSeCcr9NsJsEGMJAFxV5QbdEXng9Cd6YHpZw==
X-Received: by 2002:a25:7355:: with SMTP id o82mr497694ybc.140.1583446029978;
 Thu, 05 Mar 2020 14:07:09 -0800 (PST)
Date:   Thu,  5 Mar 2020 23:06:57 +0100
Message-Id: <20200305220657.46800-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] exit: Move preemption fixup up, move blocking operations down
From:   Jann Horn <jannh@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
non-preemptible context look untidy; after the main oops, the kernel prints
a "sleeping function called from invalid context" report because
exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
fixup.

It looks like the same thing applies to profile_task_exit() and
kcov_task_exit().

Fix it by moving the preemption fixup up and the calls to
profile_task_exit() and kcov_task_exit() down.

Fixes: 1dc0fffc48af ("sched/core: Robustify preemption leak checks")
Signed-off-by: Jann Horn <jannh@google.com>
---
As so often, I have no idea which tree this should go through. tip? mm?

v2: now without adding redundant whitespace...

 kernel/exit.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 2833ffb0c211..eb42d49fd99d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -713,8 +713,12 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
-	profile_task_exit(tsk);
-	kcov_task_exit(tsk);
+	/*
+	 * We can get here from a kernel oops, sometimes with preemption off.
+	 * Start by checking for critical errors.
+	 * Then fix up important state like USER_DS and preemption.
+	 * Then do everything else.
+	 */
 
 	WARN_ON(blk_needs_flush_plug(tsk));
 
@@ -732,6 +736,16 @@ void __noreturn do_exit(long code)
 	 */
 	set_fs(USER_DS);
 
+	if (unlikely(in_atomic())) {
+		pr_info("note: %s[%d] exited with preempt_count %d\n",
+			current->comm, task_pid_nr(current),
+			preempt_count());
+		preempt_count_set(PREEMPT_ENABLED);
+	}
+
+	profile_task_exit(tsk);
+	kcov_task_exit(tsk);
+
 	ptrace_event(PTRACE_EVENT_EXIT, code);
 
 	validate_creds_for_do_exit(tsk);
@@ -749,13 +763,6 @@ void __noreturn do_exit(long code)
 
 	exit_signals(tsk);  /* sets PF_EXITING */
 
-	if (unlikely(in_atomic())) {
-		pr_info("note: %s[%d] exited with preempt_count %d\n",
-			current->comm, task_pid_nr(current),
-			preempt_count());
-		preempt_count_set(PREEMPT_ENABLED);
-	}
-
 	/* sync mm's RSS info before statistics gathering */
 	if (tsk->mm)
 		sync_mm_rss(tsk->mm);

base-commit: 9f65ed5fe41ce08ed1cb1f6a950f9ec694c142ad
-- 
2.25.0.265.gbab2e86ba0-goog

