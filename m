Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8552BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4E206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zBUTeTu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgHHVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHHVny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:43:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C440C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 14:43:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so2705068pjd.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ob2QP37RLgezFVyX3w2G2VcGlyjy7XL6IfmIT/KAVYE=;
        b=zBUTeTu6BCDOah74lEjuHLPnYciK9mL/nwvFolTpQJ/dVEAdbZn+7RceBmTJRCZeQ2
         hUMSNf5kNvxSjpf9gNR0k4xySdaPKrE1W+9TSqKQDHJgJNpcHBKH7VkicnRGwgbHjzhw
         oAn13OvWDjK8Tt6rkwHJ+NxX8zvsORdOsoVfuJdcrTKocukLQXOfFgHZvzZJMkEphFPO
         zSDxTmLLVOOJuPVwjHJR+9oBjtXU/qhZaCw1FipgOrGjwUzvzSrWdtwcOvyyuui1T4HE
         Pjh/evfHL0nSUHxsOuy/lXQ5UCx9Tsni3Df/pBJYkinFdQ4YkDeOpE6XMXYN9W1Xah0a
         q6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ob2QP37RLgezFVyX3w2G2VcGlyjy7XL6IfmIT/KAVYE=;
        b=HDDYO+3ru0SSZVJkT3qaqH/CPoEWmQ3h289NXpG3HsroTDsvDRB08gsxBR/5P4T5rN
         4lDNQHDOTdlnYNimMuEpV3P4Iz28g2aI2FZieVMWRHau4/Pz7v49Ai3xcceZZZjHaVrv
         LnyC2MEc2Nq101AXMEH3QaKvXH7Oe8WltDF7J+hqdgyWj1itzOzhI0c/utswKKwSWVJk
         rZMQ9rvIFvQeNQ2lCg4fLGJNugX5fnPU1dx3EXPE9o2c2SrjgX21xQ8Ar38ZWL+ild+X
         gMtO+dz2oqrWAfeVyKa8JBK1UW0tO0xfhoqeZl+0mZS81pQhyjjRkoB2lbI9ZjRyy/Kr
         Prfg==
X-Gm-Message-State: AOAM530kefMwXAf/+mxAfByTdKHHJ1vgEP7UF3LuVcXiZvaMjbNLq2rf
        y3aKGjWWpxtM6YGMYxi/guV3FitvNJg=
X-Google-Smtp-Source: ABdhPJxbuqLwNwT/CWVgooi+/9riT5XA8Q9Qna2zxIIT1MZYkMHAijzxBE2v4k1AkYiX9MNOW5ryqQ==
X-Received: by 2002:a17:90b:1b45:: with SMTP id nv5mr20366519pjb.35.1596923033719;
        Sat, 08 Aug 2020 14:43:53 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e3sm15017726pgu.40.2020.08.08.14.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2020 14:43:52 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] kernel: update callers of task_work_add() to use TWA_RESUME
Message-ID: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
Date:   Sat, 8 Aug 2020 15:43:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any pre-existing caller of this function uses 'true' to signal to use
notifications or not, but we now also have signaled notifications.
Update existing callers that specify 'true' for notify to use the
updated TWA_RESUME instead.

This was noted in the original commit as well:

e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 14e4b4d17ee5..615a34d697df 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1345,7 +1345,7 @@ void noinstr do_machine_check(struct pt_regs *regs)
 		current->mce_kill_me.func = kill_me_maybe;
 		if (kill_it)
 			current->mce_kill_me.func = kill_me_now;
-		task_work_add(current, &current->mce_kill_me, true);
+		task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3f844f14fc0a..2c022eee122d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -561,7 +561,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * callback has been invoked.
 	 */
 	atomic_inc(&rdtgrp->waitcount);
-	ret = task_work_add(tsk, &callback->work, true);
+	ret = task_work_add(tsk, &callback->work, TWA_RESUME);
 	if (ret) {
 		/*
 		 * Task is exiting. Drop the refcount and free the callback.
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..8360f8d6be65 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -879,7 +879,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 			estatus_node->task_work.func = ghes_kick_task_work;
 			estatus_node->task_work_cpu = smp_processor_id();
 			ret = task_work_add(current, &estatus_node->task_work,
-					    true);
+					    TWA_RESUME);
 			if (ret)
 				estatus_node->task_work.func = NULL;
 		}
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f50c5f182bb5..d4a11eaeed91 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2251,7 +2251,7 @@ static void binder_deferred_fd_close(int fd)
 	__close_fd_get_file(fd, &twcb->file);
 	if (twcb->file) {
 		filp_close(twcb->file, current->files);
-		task_work_add(current, &twcb->twork, true);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
 	} else {
 		kfree(twcb);
 	}
diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a..709ada3151da 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -339,7 +339,7 @@ void fput_many(struct file *file, unsigned int refs)
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
 			init_task_work(&file->f_u.fu_rcuhead, ____fput);
-			if (!task_work_add(task, &file->f_u.fu_rcuhead, true))
+			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_RESUME))
 				return;
 			/*
 			 * After this task has run exit_task_work(),
diff --git a/fs/namespace.c b/fs/namespace.c
index 4a0f600a3328..8b072349fe28 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1191,7 +1191,7 @@ static void mntput_no_expire(struct mount *mnt)
 		struct task_struct *task = current;
 		if (likely(!(task->flags & PF_KTHREAD))) {
 			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
-			if (!task_work_add(task, &mnt->mnt_rcu, true))
+			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
 				return;
 		}
 		if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5f8b0c52fd2e..10e35c08b44d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1823,7 +1823,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
 
 	t->utask->dup_xol_addr = area->vaddr;
 	init_task_work(&t->utask->dup_xol_work, dup_xol_work);
-	task_work_add(t, &t->utask->dup_xol_work, true);
+	task_work_add(t, &t->utask->dup_xol_work, TWA_RESUME);
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9..cce1ab6b62a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2923,7 +2923,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 		curr->node_stamp += period;
 
 		if (!time_before(jiffies, curr->mm->numa_next_scan))
-			task_work_add(curr, work, true);
+			task_work_add(curr, work, TWA_RESUME);
 	}
 }
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 9febd37a168f..ed86310ffcd4 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1693,7 +1693,7 @@ long keyctl_session_to_parent(void)
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
-	ret = task_work_add(parent, newwork, true);
+	ret = task_work_add(parent, newwork, TWA_RESUME);
 	if (!ret)
 		newwork = NULL;
 unlock:
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 536c99646f6a..06e226166aab 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -99,7 +99,7 @@ static void report_access(const char *access, struct task_struct *target,
 	info->access = access;
 	info->target = target;
 	info->agent = agent;
-	if (task_work_add(current, &info->work, true) == 0)
+	if (task_work_add(current, &info->work, TWA_RESUME) == 0)
 		return; /* success */
 
 	WARN(1, "report_access called from exiting task");

-- 
Jens Axboe

