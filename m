Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C19920820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgFIGUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:20:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbgFIGUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:20:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 60BDBDA984993C9E617F;
        Tue,  9 Jun 2020 14:20:17 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 9 Jun 2020 14:20:08 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <ebiederm@xmission.com>, <keescook@chromium.org>,
        <ak@linux.intel.com>
CC:     <nixiaoming@huawei.com>, <alex.huangjianhui@huawei.com>,
        <linzichang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sysctl: Delete the code of sys_sysctl
Date:   Tue, 9 Jun 2020 14:20:05 +0800
Message-ID: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 61a47c1ad3a4dc ("sysctl: Remove the sysctl system call"),
sys_sysctl has lost its actual role: any input can only return an error.

Delete the code and return -ENOSYS directly at the function entry

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 kernel/sysctl_binary.c | 146 +------------------------------------------------
 1 file changed, 2 insertions(+), 144 deletions(-)

diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
index 7d550cc..41a88f8 100644
--- a/kernel/sysctl_binary.c
+++ b/kernel/sysctl_binary.c
@@ -1,126 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/stat.h>
 #include <linux/sysctl.h>
-#include "../fs/xfs/xfs_sysctl.h"
-#include <linux/sunrpc/debug.h>
-#include <linux/string.h>
 #include <linux/syscalls.h>
-#include <linux/namei.h>
-#include <linux/mount.h>
-#include <linux/fs.h>
-#include <linux/nsproxy.h>
-#include <linux/pid_namespace.h>
-#include <linux/file.h>
-#include <linux/ctype.h>
-#include <linux/netdevice.h>
-#include <linux/kernel.h>
-#include <linux/uuid.h>
-#include <linux/slab.h>
 #include <linux/compat.h>
 
-static ssize_t binary_sysctl(const int *name, int nlen,
-	void __user *oldval, size_t oldlen, void __user *newval, size_t newlen)
-{
-	return -ENOSYS;
-}
-
-static void deprecated_sysctl_warning(const int *name, int nlen)
-{
-	int i;
-
-	/*
-	 * CTL_KERN/KERN_VERSION is used by older glibc and cannot
-	 * ever go away.
-	 */
-	if (nlen >= 2 && name[0] == CTL_KERN && name[1] == KERN_VERSION)
-		return;
-
-	if (printk_ratelimit()) {
-		printk(KERN_INFO
-			"warning: process `%s' used the deprecated sysctl "
-			"system call with ", current->comm);
-		for (i = 0; i < nlen; i++)
-			printk(KERN_CONT "%d.", name[i]);
-		printk(KERN_CONT "\n");
-	}
-	return;
-}
-
-#define WARN_ONCE_HASH_BITS 8
-#define WARN_ONCE_HASH_SIZE (1<<WARN_ONCE_HASH_BITS)
-
-static DECLARE_BITMAP(warn_once_bitmap, WARN_ONCE_HASH_SIZE);
-
-#define FNV32_OFFSET 2166136261U
-#define FNV32_PRIME 0x01000193
-
-/*
- * Print each legacy sysctl (approximately) only once.
- * To avoid making the tables non-const use a external
- * hash-table instead.
- * Worst case hash collision: 6, but very rarely.
- * NOTE! We don't use the SMP-safe bit tests. We simply
- * don't care enough.
- */
-static void warn_on_bintable(const int *name, int nlen)
-{
-	int i;
-	u32 hash = FNV32_OFFSET;
-
-	for (i = 0; i < nlen; i++)
-		hash = (hash ^ name[i]) * FNV32_PRIME;
-	hash %= WARN_ONCE_HASH_SIZE;
-	if (__test_and_set_bit(hash, warn_once_bitmap))
-		return;
-	deprecated_sysctl_warning(name, nlen);
-}
-
-static ssize_t do_sysctl(int __user *args_name, int nlen,
-	void __user *oldval, size_t oldlen, void __user *newval, size_t newlen)
-{
-	int name[CTL_MAXNAME];
-	int i;
-
-	/* Check args->nlen. */
-	if (nlen < 0 || nlen > CTL_MAXNAME)
-		return -ENOTDIR;
-	/* Read in the sysctl name for simplicity */
-	for (i = 0; i < nlen; i++)
-		if (get_user(name[i], args_name + i))
-			return -EFAULT;
-
-	warn_on_bintable(name, nlen);
-
-	return binary_sysctl(name, nlen, oldval, oldlen, newval, newlen);
-}
-
 SYSCALL_DEFINE1(sysctl, struct __sysctl_args __user *, args)
 {
-	struct __sysctl_args tmp;
-	size_t oldlen = 0;
-	ssize_t result;
-
-	if (copy_from_user(&tmp, args, sizeof(tmp)))
-		return -EFAULT;
-
-	if (tmp.oldval && !tmp.oldlenp)
-		return -EFAULT;
-
-	if (tmp.oldlenp && get_user(oldlen, tmp.oldlenp))
-		return -EFAULT;
-
-	result = do_sysctl(tmp.name, tmp.nlen, tmp.oldval, oldlen,
-			   tmp.newval, tmp.newlen);
-
-	if (result >= 0) {
-		oldlen = result;
-		result = 0;
-	}
-
-	if (tmp.oldlenp && put_user(oldlen, tmp.oldlenp))
-		return -EFAULT;
-
-	return result;
+	return -ENOSYS;
 }
 
 
@@ -138,34 +23,7 @@ struct compat_sysctl_args {
 
 COMPAT_SYSCALL_DEFINE1(sysctl, struct compat_sysctl_args __user *, args)
 {
-	struct compat_sysctl_args tmp;
-	compat_size_t __user *compat_oldlenp;
-	size_t oldlen = 0;
-	ssize_t result;
-
-	if (copy_from_user(&tmp, args, sizeof(tmp)))
-		return -EFAULT;
-
-	if (tmp.oldval && !tmp.oldlenp)
-		return -EFAULT;
-
-	compat_oldlenp = compat_ptr(tmp.oldlenp);
-	if (compat_oldlenp && get_user(oldlen, compat_oldlenp))
-		return -EFAULT;
-
-	result = do_sysctl(compat_ptr(tmp.name), tmp.nlen,
-			   compat_ptr(tmp.oldval), oldlen,
-			   compat_ptr(tmp.newval), tmp.newlen);
-
-	if (result >= 0) {
-		oldlen = result;
-		result = 0;
-	}
-
-	if (compat_oldlenp && put_user(oldlen, compat_oldlenp))
-		return -EFAULT;
-
-	return result;
+	return -ENOSYS;
 }
 
 #endif /* CONFIG_COMPAT */
-- 
1.8.5.6

