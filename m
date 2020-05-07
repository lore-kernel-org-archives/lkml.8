Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA4BC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964402145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buLQEpFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEGSKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbgEGSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:10:19 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF5C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:10:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v18so7680767qtq.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KCzP4bl+LsDIRE9Q4UUvX6EBmJ7sU8y+C6Dq7vCJhH8=;
        b=buLQEpFYJXDRA5yOOUN1Qv439Td9XdcBA8tv5KPRARKKfvPpsCXa/OGiesg1VlmuUi
         blDGxmJsXai8UyPSMxrDHjhxkit77Jj/4ySr1XgMT2k9ikcR9bYF4eRJXN97Oym5x3Mm
         g0d0AdY8/H2rxNvlriy3bU09kZxmXVHdY1EUyAt2D0ICjogDvlWZ8SaS4SxgowHGXnrJ
         zjVYurnBZTOolQWBNn0L3DoWL1ggGFySbJtZJ+WKh6PIs99yIJsX7LyUDI+D5NCruQhp
         XFuqjRQC5gpzIwYswzujFnzxHjlbr+c3SJpXiKKAwAJJz9fqFKP43I56hHQ3byQqbplU
         ujag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KCzP4bl+LsDIRE9Q4UUvX6EBmJ7sU8y+C6Dq7vCJhH8=;
        b=SMjUvNzNPZRFVeDfP2GRqbNT6Z1NLLUw1yjTfkC2RqplyyeJ+eL7P8O14lc3kYqdZY
         8HCnpI22YTFOJTWV+ZajPJ5W9abycRothJXxmleJOhE9KgVychXQR7KIej7VmD3iVQRR
         jBuIfUCC4BNFNsFhjJL72D0dQWAZ4sblm27XZdL5iD1UJ2CV3WwAOrlkfR5JfVkZD1CN
         6gQcoadv9I8JtAYlskq1Ys2feQzkwwdmi1YJMOr10tHmU3Lqwfy9Qk54kEJZOZyevYnH
         3sWA/LcoL5tG+q/V1QAdwhDOOvcHm+Ab7FR3urBZIZ2Oyo41XwTRql51mnxkL41Q4m44
         uh/w==
X-Gm-Message-State: AGi0PuZPO/d20Qq3x96zUj3Rwc6esl4oTGNIz9TZx119l7ZM0C7+JbsU
        Wma4eXEi3CeRfoiEB9Pwla8unrSqVF8uv/cs7CRDtMrgH9abQuOeYwKKr8tNzT9sy1g4frNPjUk
        +p8BZY6nnWvktVRagxQHXlmDszygQLrifbR1b38Adulr4OM/ozvoVbD+o+CVnU7Zli+3CBwP9
X-Google-Smtp-Source: APiQypKQhmCNyPtVGvHVeJln2UQbjcMKFZZasRoGbfH9naq6fFRrNf4dZOwRdFtzNL/pINDfbcBonxYb3hAe
X-Received: by 2002:ad4:50c3:: with SMTP id e3mr13732268qvq.116.1588875017166;
 Thu, 07 May 2020 11:10:17 -0700 (PDT)
Date:   Thu,  7 May 2020 19:09:59 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-2-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 01/14] sched: Provide sched_set_deadline()
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all the sched_setscheduler*() exports have been removed, introduce
sched_set_deadline() on the model of sched_set_fifo() to enable modules
to create SCHED_DEADLINE tasks.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c0da93a26f62..63c8ae7a0dd8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1630,6 +1630,8 @@ extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sc
 extern void sched_set_fifo(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
 extern void sched_set_normal(struct task_struct *p, int nice);
+extern int sched_set_deadline(struct task_struct *p, u64 runtime, u64 deadline,
+			      u64 period, u64 flags);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7324f3b0f8d2..dbaf3f63df22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5136,6 +5136,23 @@ void sched_set_normal(struct task_struct *p, int nice)
 }
 EXPORT_SYMBOL_GPL(sched_set_normal);
 
+int sched_set_deadline(struct task_struct *p, u64 runtime, u64 deadline,
+		       u64 period, u64 flags)
+{
+	struct sched_attr attr = {
+		.size		= sizeof(struct sched_attr),
+		.sched_policy	= SCHED_DEADLINE,
+		.sched_flags	= flags,
+		.sched_nice	= 0,
+		.sched_priority	= 0,
+		.sched_runtime	= runtime,
+		.sched_deadline = deadline,
+		.sched_period	= period,
+	};
+	return sched_setattr_nocheck(p, &attr);
+}
+EXPORT_SYMBOL_GPL(sched_set_deadline);
+
 static int
 do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
-- 
2.26.2.526.g744177e7f7-goog

