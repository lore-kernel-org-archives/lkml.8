Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB88C2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHQMAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:00:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbgHQMAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:00:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6ADAEE713FB79A561007;
        Mon, 17 Aug 2020 20:00:44 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 20:00:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/migrate: Avoid possible unnecessary ptrace_may_access() call in kernel_move_pages()
Date:   Mon, 17 Aug 2020 07:59:33 -0400
Message-ID: <20200817115933.44565-1-linmiaohe@huawei.com>
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
specified process when they are same.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 34a842a8eb6a..342c1ce0b433 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1903,7 +1903,7 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
 	 * Check if this process has the right to modify the specified
 	 * process. Use the regular "ptrace_may_access()" checks.
 	 */
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+	if (pid && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
 		rcu_read_unlock();
 		err = -EPERM;
 		goto out;
-- 
2.19.1

