Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F7FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846D12087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIAJbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:31:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgIAJbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:31:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6AF11EA56FCAAD2861CD;
        Tue,  1 Sep 2020 17:31:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Sep 2020 17:31:30 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <tglx@linutronix.de>
CC:     <arnd@arndb.de>, Zeng Tao <prime.zeng@hisilicon.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] time: Avoid undefined behaviour in timespec64_to_ns
Date:   Tue, 1 Sep 2020 17:30:13 +0800
Message-ID: <1598952616-6416-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got into this:
================================================================================
UBSAN: Undefined behaviour in ./include/linux/time64.h:127:27
signed integer overflow:
17179869187 * 1000000000 cannot be represented in type 'long long int'
CPU: 0 PID: 4265 Comm: syz-executor.0 Not tainted 5.6.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xc6/0x11e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:154
 handle_overflow+0x119/0x130 lib/ubsan.c:184
 timespec64_to_ns include/linux/time64.h:127 [inline]
 set_cpu_itimer+0x65c/0x880 kernel/time/itimer.c:180
 do_setitimer+0x8e/0x740 kernel/time/itimer.c:245
 __do_sys_setitimer kernel/time/itimer.c:353 [inline]
 __se_sys_setitimer kernel/time/itimer.c:336 [inline]
 __x64_sys_setitimer+0x14c/0x2c0 kernel/time/itimer.c:336
 do_syscall_64+0xa1/0x540 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4674d9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f63de999c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000026
RAX: ffffffffffffffda RBX: 000000000074bf00 RCX: 00000000004674d9
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000000000001
RBP: 00007f63de99a6bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000a1c R14: 00000000004cb300 R15: 0000000000701660
================================================================================
when i ran the syzkaller.

Since commit bd40a175769d ("y2038: itimer: change implementation to timespec64")
we have break the time clamping which handles the potential overflow.
In this patch, we fix it in the timespec64_to_ns because there is
possiblity to cause the same undefined behaviour on overflow whenever
the function is called.

Fixes: bd40a175769d ("y2038: itimer: change implementation to timespec64")
Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 include/linux/time64.h | 3 +++
 kernel/time/itimer.c   | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index c9dcb3e..3215593 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -124,6 +124,9 @@ static inline bool timespec64_valid_settod(const struct timespec64 *ts)
  */
 static inline s64 timespec64_to_ns(const struct timespec64 *ts)
 {
+	if ((unsigned long long)ts->tv_sec >= KTIME_SEC_MAX)
+		return KTIME_MAX;
+
 	return ((s64) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
 }
 
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index ca4e6d5..00629e6 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -172,10 +172,6 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 	u64 oval, nval, ointerval, ninterval;
 	struct cpu_itimer *it = &tsk->signal->it[clock_id];
 
-	/*
-	 * Use the to_ktime conversion because that clamps the maximum
-	 * value to KTIME_MAX and avoid multiplication overflows.
-	 */
 	nval = timespec64_to_ns(&value->it_value);
 	ninterval = timespec64_to_ns(&value->it_interval);
 
-- 
2.8.1

