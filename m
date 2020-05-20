Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB7EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1528B20748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BmN5Wc/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgETW0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:26:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:26:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n14so5334809qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbVOkXnw36ReH78r0yGYkfkzyZDslcPfdI9p6sK2a0o=;
        b=BmN5Wc/NG1okQhQ+4XLMaCD+lRChQIfDSZRcNS6OsFNifttrgJBrTEPPvn9H9mxcfS
         Ciah3iWwDUAcA+7Q0p71g8p3UJM2v7roAZDUzSho2QbetAROo05q4qQoADt0wnnSBZHZ
         s4Am1nUMq1TPp6ogpLcK0rQB6m5yIoovbas+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbVOkXnw36ReH78r0yGYkfkzyZDslcPfdI9p6sK2a0o=;
        b=RrKypcDH1+hxTmT3Uhs3qUP/LDDuy2CbqIPUXvwbfQ7VsqGINPRdgX1zE9+67I+X5a
         QE4ncvfo/yjWJuK3WtrTEYtGBtcEwwyBkUk9JU2qTIEB0oXStnoaLlGWOccizMePf5Su
         T+IdBYiXjX/7xrwmYdn6hxTxSThGqEv++VAson6lr9AU+FVUwQDdq1aVOcac89Wqj3XC
         YX1RscbyUDxgVRGF0yduISiJ0G/yQrgvwcKhISuBUZGaDy9MCUnhf8UYGVr/wdiLgXeL
         DZO8AmF+Lsm9H4dytOw/oQnvwED1JBMhgEqs5brZCvvDllvmU+ZtNLAgv9XyBYWvdh8S
         SEwA==
X-Gm-Message-State: AOAM531JxW2KIC80eP5CKQ/WXvLC4nEHSHBU7nLPUNlE2HQYQVnWagzF
        BW60PzV3j6ZDD5Fo5Yp8bWVntA==
X-Google-Smtp-Source: ABdhPJzDt2i/xELTggWdjAJdSQ5Vp0ilBhohLn47Ffj3B60xp+Y3hmcDYl8OvLqcQsyASLlXDhNdTw==
X-Received: by 2002:ae9:f701:: with SMTP id s1mr6827419qkg.334.1590013613738;
        Wed, 20 May 2020 15:26:53 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n42sm3615363qtf.51.2020.05.20.15.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:26:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>
Subject: [PATCH RFC] sched: Add a per-thread core scheduling interface
Date:   Wed, 20 May 2020 18:26:42 -0400
Message-Id: <20200520222642.70679-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a per-thread core scheduling interface which allows a thread to tag
itself and enable core scheduling. Based on discussion at OSPM with
maintainers, we propose a prctl(2) interface accepting values of 0 or 1.
 1 - enable core scheduling for the task.
 0 - disable core scheduling for the task.

Special cases:
(1)
The core-scheduling patchset contains a CGroup interface as well. In
order for us to respect users of that interface, we avoid overriding the
tag if a task was CGroup-tagged because the task becomes inconsistent
with the CGroup tag. Instead return -EBUSY.

(2)
If a task is prctl-tagged, allow the CGroup interface to override
the task's tag.

ChromeOS will use core-scheduling to securely enable hyperthreading.
This cuts down the keypress latency in Google docs from 150ms to 50ms
while improving the camera streaming frame rate by ~3%.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h      |  6 ++++
 include/uapi/linux/prctl.h |  3 ++
 kernel/sched/core.c        | 57 ++++++++++++++++++++++++++++++++++++++
 kernel/sys.c               |  3 ++
 4 files changed, 69 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fe6ae59fcadbe..8a40a093aa2ca 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1986,6 +1986,12 @@ static inline void rseq_execve(struct task_struct *t)
 
 #endif
 
+#ifdef CONFIG_SCHED_CORE
+int task_set_core_sched(int set, struct task_struct *tsk);
+#else
+int task_set_core_sched(int set, struct task_struct *tsk) { return -ENOTSUPP; }
+#endif
+
 void __exit_umh(struct task_struct *tsk);
 
 static inline void exit_umh(struct task_struct *tsk)
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e362..dba0c70f9cce6 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -238,4 +238,7 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Core scheduling per-task interface */
+#define PR_SET_CORE_SCHED		59
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 684359ff357e7..780514d03da47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3320,6 +3320,13 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 #ifdef CONFIG_SCHED_CORE
 	RB_CLEAR_NODE(&p->core_node);
+
+	/*
+	 * If task is using prctl(2) for tagging, do the prctl(2)-style tagging
+	 * for the child as well.
+	 */
+	if (current->core_cookie && ((unsigned long)current == current->core_cookie))
+		task_set_core_sched(1, p);
 #endif
 	return 0;
 }
@@ -7857,6 +7864,56 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 EXPORT_SYMBOL_GPL(__cant_sleep);
 #endif
 
+#ifdef CONFIG_SCHED_CORE
+
+/* Ensure that all siblings have rescheduled once */
+static int task_set_core_sched_stopper(void *data)
+{
+	return 0;
+}
+
+int task_set_core_sched(int set, struct task_struct *tsk)
+{
+	if (!tsk)
+		tsk = current;
+
+	if (set > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	/*
+	 * If cookie was set previously, return -EBUSY if either of the
+	 * following are true:
+	 * 1. Task was previously tagged by CGroup method.
+	 * 2. Task or its parent were tagged by prctl().
+	 *
+	 * Note that, if CGroup tagging is done after prctl(), then that would
+	 * override the cookie. However, if prctl() is done after task was
+	 * added to tagged CGroup, then the prctl() returns -EBUSY.
+	 */
+	if (!!tsk->core_cookie == set) {
+		if ((tsk->core_cookie == (unsigned long)tsk) ||
+		    (tsk->core_cookie == (unsigned long)tsk->sched_task_group)) {
+			return -EBUSY;
+		}
+	}
+
+	if (set)
+		sched_core_get();
+
+	tsk->core_cookie = set ? (unsigned long)tsk : 0;
+
+	stop_machine(task_set_core_sched_stopper, NULL, NULL);
+
+	if (!set)
+		sched_core_put();
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index d325f3ab624a9..5c3bcf40dcb34 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2514,6 +2514,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SET_CORE_SCHED:
+		error = task_set_core_sched(arg2, NULL);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.26.2.761.g0e0b3e54be-goog

