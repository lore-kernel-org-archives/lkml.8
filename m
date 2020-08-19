Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A37C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AADB20772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHSIeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:34:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbgHSIes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:34:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BBB24E4CCA2E7D39B94A;
        Wed, 19 Aug 2020 16:34:44 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 16:34:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/migrate: Avoid possible unnecessary process right check in kernel_move_pages()
Date:   Wed, 19 Aug 2020 04:33:31 -0400
Message-ID: <20200819083331.19012-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check if this process has the right to modify the
specified process when they are same. And we could also skip the security
hook call if a process is modifying its own pages. Add helper function to
handle these.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 71 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 34a842a8eb6a..9026876a27dc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1869,33 +1869,27 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 	return nr_pages ? -EFAULT : 0;
 }
 
-/*
- * Move a list of pages in the address space of the currently executing
- * process.
- */
-static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
-			     const void __user * __user *pages,
-			     const int __user *nodes,
-			     int __user *status, int flags)
+static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	int err;
-	nodemask_t task_nodes;
-
-	/* Check flags */
-	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
-		return -EINVAL;
 
-	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_NICE))
-		return -EPERM;
+	/*
+	 * There is no need to check if current process has the right to modify
+	 * the specified process when they are same.
+	 */
+	if (!pid) {
+		mmget(current->mm);
+		*mem_nodes = cpuset_mems_allowed(current);
+		return current->mm;
+	}
 
 	/* Find the mm_struct */
 	rcu_read_lock();
-	task = pid ? find_task_by_vpid(pid) : current;
+	task = find_task_by_vpid(pid);
 	if (!task) {
 		rcu_read_unlock();
-		return -ESRCH;
+		return ERR_PTR(-ESRCH);
 	}
 	get_task_struct(task);
 
@@ -1905,22 +1899,47 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
 	 */
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
 		rcu_read_unlock();
-		err = -EPERM;
+		mm = ERR_PTR(-EPERM);
 		goto out;
 	}
 	rcu_read_unlock();
 
- 	err = security_task_movememory(task);
- 	if (err)
+	mm = ERR_PTR(security_task_movememory(task));
+	if (IS_ERR(mm))
 		goto out;
-
-	task_nodes = cpuset_mems_allowed(task);
+	*mem_nodes = cpuset_mems_allowed(task);
 	mm = get_task_mm(task);
+out:
 	put_task_struct(task);
-
 	if (!mm)
+		mm = ERR_PTR(-EINVAL);
+	return mm;
+}
+
+/*
+ * Move a list of pages in the address space of the currently executing
+ * process.
+ */
+static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
+			     const void __user * __user *pages,
+			     const int __user *nodes,
+			     int __user *status, int flags)
+{
+	struct mm_struct *mm;
+	int err;
+	nodemask_t task_nodes;
+
+	/* Check flags */
+	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
 		return -EINVAL;
 
+	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	mm = find_mm_struct(pid, &task_nodes);
+	if (IS_ERR(mm))
+		return PTR_ERR(mm);
+
 	if (nodes)
 		err = do_pages_move(mm, task_nodes, nr_pages, pages,
 				    nodes, status, flags);
@@ -1929,10 +1948,6 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
 
 	mmput(mm);
 	return err;
-
-out:
-	put_task_struct(task);
-	return err;
 }
 
 SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
-- 
2.19.1

