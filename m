Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE21820774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgFHCtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:49:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgFHCtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:49:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF2978E29D725983B698;
        Mon,  8 Jun 2020 10:49:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 10:49:31 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>,
        <xiexiuqi@huawei.com>, <mark.rutland@arm.com>, <hch@infradead.org>,
        <wcohen@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mtk.manpages@gmail.com>, <wezhang@redhat.com>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <bobo.shaobowang@huawei.com>
Subject: [RESEND PATCH] sys_personality: Add optional arch hook arch_check_personality
Date:   Mon, 8 Jun 2020 10:49:25 +0800
Message-ID: <20200608024925.42510-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently arm64 personality syscall uses wrapper __arm64_sys_personality
to redirect to __arm64_sys_arm64_personality, it's easily confused,
Whereas using an normal hook arch_check_personality() can reject
additional settings like this for special case of different architectures.

This makes code clean and easier for subsequent modification.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/arm64/kernel/sys.c  |  7 +++----
 include/linux/syscalls.h | 10 ----------
 kernel/exec_domain.c     | 14 +++++++++++++-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index d5ffaaab31a7..5c01816d7a77 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -28,12 +28,13 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
-SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
+int arch_check_personality(unsigned int personality)
 {
 	if (personality(personality) == PER_LINUX32 &&
 		!system_supports_32bit_el0())
 		return -EINVAL;
-	return ksys_personality(personality);
+
+	return 0;
 }
 
 asmlinkage long sys_ni_syscall(void);
@@ -46,8 +47,6 @@ asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused)
 /*
  * Wrappers to pass the pt_regs argument.
  */
-#define __arm64_sys_personality		__arm64_sys_arm64_personality
-
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
 #include <asm/unistd.h>
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..3dbbad498027 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1393,16 +1393,6 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
 	return do_sys_truncate(pathname, length);
 }
 
-static inline unsigned int ksys_personality(unsigned int personality)
-{
-	unsigned int old = current->personality;
-
-	if (personality != 0xffffffff)
-		set_personality(personality);
-
-	return old;
-}
-
 /* for __ARCH_WANT_SYS_IPC */
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index 33f07c5f2515..f3682f4bf205 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -35,9 +35,21 @@ static int __init proc_execdomains_init(void)
 module_init(proc_execdomains_init);
 #endif
 
+int __weak arch_check_personality(unsigned int personality)
+{
+	return 0;
+}
+
 SYSCALL_DEFINE1(personality, unsigned int, personality)
 {
-	unsigned int old = current->personality;
+	int err;
+	unsigned int old;
+
+	err = arch_check_personality(personality);
+	if (err)
+		return err;
+
+	old = current->personality;
 
 	if (personality != 0xffffffff)
 		set_personality(personality);
-- 
2.17.1

