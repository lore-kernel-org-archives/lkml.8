Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346F0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A4B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IGoVIp4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHQMc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgHQMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:32:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB727C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9dJsBDxp3+Djbu7YBDh5TRA8/3MZbTfEdnmWNS/qdNw=; b=IGoVIp4c393rfkQMU831b1MmJM
        z2MjqETsv8D8U+eNazLM0aKsehBdmizUxYTxpv7mU+eC3zyog5Qh2FOCZq7aCWPn1EnKEBPWuKGpl
        cAwyZ8s7zt39XSX8uJ7amjO0X5ug9KS0JyQm4j8w9umEhUozfFiBA/K+Z75+IyLx/FZSBorZ7bLuD
        UEdnndwM+cm0ENXEwHHqT8l081+VMF34L5aer0sMinHzGv6Crae+ZkCLG6ciOBcUb+BfRre7tCqJw
        EkrQFiysVaJXUZW55ITA+/btey1DmNVJFaUGqG4x1+IsAlQAOSEaUAPxQudnHUnykFY8Y4e9lSDw9
        JrIZN0oQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7eJf-0007Jm-BS; Mon, 17 Aug 2020 12:32:43 +0000
Date:   Mon, 17 Aug 2020 13:32:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Message-ID: <20200817123243.GJ17456@casper.infradead.org>
References: <20200817115933.44565-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817115933.44565-1-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 07:59:33AM -0400, Miaohe Lin wrote:
> There is no need to check if this process has the right to modify the
> specified process when they are same.

We should probably also skip the security hook call if a process is
modifying its own pages.

How about this instead?

diff --git a/mm/migrate.c b/mm/migrate.c
index f37729673558..84dc1f42161d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1797,33 +1797,22 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
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
+	if (!pid) {
+		mmget(current->mm);
+		*mem_nodes = cpuset_mems_allowed(current);
+		return current->mm;
+	}
 
-	/* Find the mm_struct */
 	rcu_read_lock();
-	task = pid ? find_task_by_vpid(pid) : current;
+	task = find_task_by_vpid(pid);
 	if (!task) {
 		rcu_read_unlock();
-		return -ESRCH;
+		return ERR_PTR(-ESRCH);
 	}
 	get_task_struct(task);
 
@@ -1833,22 +1822,49 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
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
 
-	task_nodes = cpuset_mems_allowed(task);
+	*mem_nodes = cpuset_mems_allowed(task);
 	mm = get_task_mm(task);
+out:
 	put_task_struct(task);
 
 	if (!mm)
+		mm = ERR_PTR(-EINVAL);
+	return mm;
+}
+
+/*
+ * Move a list of pages in the address space of the specified
+ * process (pid of 0 means current).
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
@@ -1857,10 +1873,6 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
 
 	mmput(mm);
 	return err;
-
-out:
-	put_task_struct(task);
-	return err;
 }
 
 SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,

