Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4772072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDxUGGqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCEWAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:00:19 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:35756 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:00:19 -0500
Received: by mail-yw1-f73.google.com with SMTP id s11so454835ywk.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5TpiOs/CZ4PoK1LsIVmnyP3Y8uFJTt3BgygQ8sZY0DA=;
        b=YDxUGGqt8DLRSg9dgKI+CfCYlOY44nZUOH43B1036aFfTvwysGQze2WldwfAnw42Y5
         sGf6agMgib7cR1dDlkBq+Tk4lxgOla8ngsDpV1HUusbxzwQCRDrwj6HrJqMgjpghPSFm
         /weHD8c8Xdy8BWkpOm5H3llTqGOtMqDhAaQb5ud25D50tmrbC4eHQvUnRUMbVqFOZGE6
         7stoF9pyCe7p17Xxt7MpiRLDy7RZ+SydAdJHIn3jO1PEEwqKtVQOxSxwPTV/kGm/8B/7
         oyexR0tha8X87y1Hxxgu41d/q5pmoUN8f735gAHfv0Fv86Q4JZnPD9tVOQ+NxzGMxFLo
         PnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5TpiOs/CZ4PoK1LsIVmnyP3Y8uFJTt3BgygQ8sZY0DA=;
        b=fYnWmXtAa5W+LGSURxodLWWOzi4goRs4RtSal/WeurGJXwhKDfC/qV6tejk0xLOohP
         vgKGVVCTt3PPEqfX2N03ohPLNexOLgWnTN59hWSTuf6+YVGj7NmmRo1QCy8Im1n0dSeD
         mXAMAqqbnC5G5p37KxjswEOEOK6rBXfuzI5C/YP65okWR5cEJPEIuSJX3Qthki7uyRhx
         uJIbinJoZRyknPcKIqf7XnbJvkBpld/LHOsmX1Z8Uu99VtjULFIjZlVNJUXFbHm5/IXg
         cEUn+xrCIB/7AYrU1nS1SSOSgQ0OJlk3Vq2+vfm2HwZ0suvLXR8AnDxqjeEbBqpxjf+N
         iqXA==
X-Gm-Message-State: ANhLgQ3ezZpYVjFwYvqwN/oD6pooRNFx9F4RwZJFr42tabsTDYqgezqO
        JW/V5xOUrRjxczyERi09ohL1rbWM9w==
X-Google-Smtp-Source: ADFU+vv1usKccoTHol1m5z9R7TkENz1z5AZsDghphqP7u2ZcCg0pM03ImOCStN70iry7GjIAsWkl5N5fHg==
X-Received: by 2002:a25:bb4f:: with SMTP id b15mr410621ybk.175.1583445618155;
 Thu, 05 Mar 2020 14:00:18 -0800 (PST)
Date:   Thu,  5 Mar 2020 22:59:53 +0100
Message-Id: <20200305215953.257399-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] exit: Move preemption fixup up, move blocking operations down
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

 kernel/exit.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 2833ffb0c211..db77c540aa92 100644
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
 
@@ -732,6 +736,17 @@ void __noreturn do_exit(long code)
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
+
 	ptrace_event(PTRACE_EVENT_EXIT, code);
 
 	validate_creds_for_do_exit(tsk);
@@ -749,13 +764,6 @@ void __noreturn do_exit(long code)
 
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

