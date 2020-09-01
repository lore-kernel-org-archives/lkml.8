Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE683C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB08D206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgIAMHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:07:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728043AbgIAL7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:59:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48FDF56F8CD6021042EF;
        Tue,  1 Sep 2020 19:59:21 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 19:59:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <christian.brauner@ubuntu.com>, <oleg@redhat.com>,
        <axboe@kernel.dk>, <ebiederm@xmission.com>,
        <madhuparnabhowmik10@gmail.com>, <gustavoars@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] signal: clean up codestyle
Date:   Tue, 1 Sep 2020 07:58:00 -0400
Message-ID: <20200901115800.7916-1-linmiaohe@huawei.com>
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

No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a38b3edc6851..10a31fafc35b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1115,8 +1115,8 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
-		switch ((unsigned long) info) {
-		case (unsigned long) SEND_SIG_NOINFO:
+		switch ((unsigned long)info) {
+		case (unsigned long)SEND_SIG_NOINFO:
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
@@ -1129,7 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 						 current_uid());
 			rcu_read_unlock();
 			break;
-		case (unsigned long) SEND_SIG_PRIV:
+		case (unsigned long)SEND_SIG_PRIV:
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
@@ -1314,7 +1314,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 	int sig = info->si_signo;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
-	action = &t->sighand->action[sig-1];
+	action = &t->sighand->action[sig - 1];
 	ignored = action->sa.sa_handler == SIG_IGN;
 	blocked = sigismember(&t->blocked, sig);
 	if (blocked || ignored) {
-- 
2.19.1

