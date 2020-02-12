Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A74EC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6324221734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550812;
	bh=W9gObeRR3OqvSDjRQ7edssBKQyg7Lgf5yFimgV+3pXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TMvPFOzzRPU8Vl5xEpaMaE3vyK/KvoWCK0GwR/eeq+OXwJS3F7Rl5xchhEZ8g+83D
	 oHRltEL+vH7KwQ1iYfSd8ZlH8EQvbUrIoI4R2vXYP10jgCCkXQdd+OS0raxyR/HaCg
	 EOV+VE87MoYaJ3jtyUjb/B7vE+6A+jN9nOxYNW/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgBLXkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:40:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45538 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgBLXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:40:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2001816pfg.12;
        Wed, 12 Feb 2020 15:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWH2/XfpqHoXeEJcQbZVzZEZcw7B8tmo1ECvMd0jYwE=;
        b=bWREWAVI4HhSS5OM8Zqnl6gUsWQ9sN96jWhHNUjWcDBFA+Q6mJrx/4g19dOVfs9Ye4
         tPbmB8ynizGVZ8zI3npJCb7EInnYDMvogtNBHXlD8ulDggfqinu1JOMndy90RTXYX3OL
         bf0AX7gTt96+smPkoh8nTE8pu2WxkB2BtMtZEX/lg/bKppFe2pHIvft8NcjttFkYInCd
         xiTQixj7Dt1p7nbqf0yhVY5Y5tUCHY4PBFB41gEeUz8KgQoE4djWOzIJI6dVjnEm2bPS
         bD6zpMXu/madz4nXCNpu3PFIk2a/gkgO2xiGKTYT2Rl2GE3gkdPpZFzocuWl2sVHoHBA
         U2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pWH2/XfpqHoXeEJcQbZVzZEZcw7B8tmo1ECvMd0jYwE=;
        b=CeQzVICdrulC4nssAIrhCtI6IJXbvTxPVHdps6gXyiq1CavRjerdktQX/Wa2Z4QYJH
         SRfEtneGZQoN3SrCsSUn1WTGXmSktTsejdUVgWE0GgtbaRwdBlXtwan4IG9I8TgcZVZ/
         tx6O3R8HLVpBj0BMXXApPaNZGvrDFtlawMLlfyeYbUB7V4JwUY40mHQBBvO8WPseziWq
         xcY+N6vsGm/Ta1J3TOs0hU7oSmC/mJcLYls2DFU86BQxs2uQlA66rVnSHHk0PS1DBSjy
         tJsVJSn0jqYYS2mvnF9zz4ixksPwAE+A8DiCcOqc7pOgJtXoLON1nSxbQGOsRsHjdgm5
         xMOw==
X-Gm-Message-State: APjAAAVp130QKOMMEifKJZD9R9auXA97t2LFyYr0kZEBPYFMKKSejh5G
        dL+cxmcQfRyjo0K4zD7+00M=
X-Google-Smtp-Source: APXvYqyY0iR439WjIBFBQq68OmnI91robzRKkjf22DYwp60HBsJfY4DO0T5AXsqGpHdDMPCO6BXMzg==
X-Received: by 2002:a62:18c9:: with SMTP id 192mr10746365pfy.117.1581550806888;
        Wed, 12 Feb 2020 15:40:06 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:40:06 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH v4 8/8] mm: support both pid and pidfd for process_madvise
Date:   Wed, 12 Feb 2020 15:39:46 -0800
Message-Id: <20200212233946.246210-9-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212233946.246210-1-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a demand[1] to support pid as well pidfd for process_madvise
to reduce unnecessary syscall to get pidfd if the user has control of
the target process(ie, they could guarantee the process is not gone
or pid is not reused. Or, it might be okay to give a hint to wrong
process).

This patch aims for supporting both options like waitid(2). So, the
syscall is currently,

	int process_madvise(int which, pid_t pid, void *addr,
		size_t length, int advise, unsigned long flag);

@which is actually idtype_t for userspace libray and currently,
it supports P_PID and P_PIDFD.

[1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/

Cc: Christian Brauner <christian@brauner.io>
Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/syscalls.h |  3 ++-
 mm/madvise.c             | 34 ++++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e4cd2c2f8bb4..f5ada20e2943 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -876,7 +876,8 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
-asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
+
+asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
 			size_t len, int behavior, unsigned long flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
diff --git a/mm/madvise.c b/mm/madvise.c
index b1237466657e..32833d0ba574 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1190,11 +1190,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current, start, len_in, behavior);
 }
 
-SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
+SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid, unsigned long, start,
 		size_t, len_in, int, behavior, unsigned long, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	struct task_struct *task;
 	struct mm_struct *mm;
@@ -1205,20 +1204,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
 	if (!process_madvise_behavior_valid(behavior))
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!f.file)
-		return -EBADF;
+	switch (which) {
+	case P_PID:
+		if (upid <= 0)
+			return -EINVAL;
+
+		pid = find_get_pid(upid);
+		if (!pid)
+			return -ESRCH;
+		break;
+	case P_PIDFD:
+		if (upid < 0)
+			return -EINVAL;
 
-	pid = pidfd_pid(f.file);
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto fdput;
+		pid = pidfd_get_pid(upid);
+		if (IS_ERR(pid))
+			return PTR_ERR(pid);
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
 		ret = -ESRCH;
-		goto fdput;
+		goto put_pid;
 	}
 
 	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
@@ -1231,7 +1241,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
 	mmput(mm);
 release_task:
 	put_task_struct(task);
-fdput:
-	fdput(f);
+put_pid:
+	put_pid(pid);
 	return ret;
 }
-- 
2.25.0.225.g125e21ebc7-goog

