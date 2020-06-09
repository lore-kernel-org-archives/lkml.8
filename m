Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3687C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE00E20775
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgFICW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:22:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726749AbgFICW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:22:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 64ADC966C59515A7AA11;
        Tue,  9 Jun 2020 10:22:56 +0800 (CST)
Received: from localhost (10.175.101.6) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 9 Jun 2020
 10:22:51 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <christian.brauner@ubuntu.com>, <akpm@linux-foundation.org>,
        <tglx@linutronix.de>, <lizefan@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next] kernel/fork.c: annotate data races for copy_process
Date:   Tue, 9 Jun 2020 11:08:01 +0800
Message-ID: <20200609030801.272704-1-chenweilong@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check is only there to stop root fork bombs.

BUG: KCSAN: data-race in copy_process / copy_process

write to 0xffffffff86f87d20 of 4 bytes by task 7121 on cpu 5:
 copy_process+0x2e1a/0x3af0 kernel/fork.c:2285
 _do_fork+0xf7/0x790 kernel/fork.c:2430
 __do_sys_clone+0xf9/0x130 kernel/fork.c:2585
 __se_sys_clone kernel/fork.c:2566 [inline]
 __x64_sys_clone+0x6c/0x80 kernel/fork.c:2566
 do_syscall_64+0xc7/0x3b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffffff86f87d20 of 4 bytes by task 7125 on cpu 3:
 copy_process+0x9eb/0x3af0 kernel/fork.c:1967
 _do_fork+0xf7/0x790 kernel/fork.c:2430
 __do_sys_clone+0xf9/0x130 kernel/fork.c:2585
 __se_sys_clone kernel/fork.c:2566 [inline]
 __x64_sys_clone+0x6c/0x80 kernel/fork.c:2566
 do_syscall_64+0xc7/0x3b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..efc5493203ae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1977,7 +1977,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 * to stop root fork bombs.
 	 */
 	retval = -EAGAIN;
-	if (nr_threads >= max_threads)
+	if (data_race(nr_threads >= max_threads))
 		goto bad_fork_cleanup_count;
 
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
-- 
2.17.1

