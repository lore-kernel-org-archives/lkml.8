Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9FBC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639EB2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC1LGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:06:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55623 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgC1LGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9IB-0003uJ-KE; Sat, 28 Mar 2020 12:06:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3CBB21C0470;
        Sat, 28 Mar 2020 12:06:19 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:18 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] [parisc, s390, sparc64] no need for access_ok()
 in futex handling
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357885.28353.8864155593102585973.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dc88588990945b14d6f7ed45b70ef7b1814a5f3e
Gitweb:        https://git.kernel.org/tip/dc88588990945b14d6f7ed45b70ef7b1814a5f3e
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sun, 16 Feb 2020 10:26:50 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:52 -04:00

[parisc, s390, sparc64] no need for access_ok() in futex handling

access_ok() is always true on those

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/include/asm/futex.h   | 3 ---
 arch/s390/include/asm/futex.h     | 2 --
 arch/sparc/include/asm/futex_64.h | 2 --
 3 files changed, 7 deletions(-)

diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
index c10cc90..c459f65 100644
--- a/arch/parisc/include/asm/futex.h
+++ b/arch/parisc/include/asm/futex.h
@@ -39,9 +39,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	int oldval, ret;
 	u32 tmp;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	_futex_spin_lock_irqsave(uaddr, &flags);
 
 	ret = -EFAULT;
diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index ed965c3..26f9144 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -28,8 +28,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	int oldval = 0, newval, ret;
 	mm_segment_t old_fs;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
 	old_fs = enable_sacf_uaccess();
 	switch (op) {
 	case FUTEX_OP_SET:
diff --git a/arch/sparc/include/asm/futex_64.h b/arch/sparc/include/asm/futex_64.h
index 84fffaa..72de967 100644
--- a/arch/sparc/include/asm/futex_64.h
+++ b/arch/sparc/include/asm/futex_64.h
@@ -35,8 +35,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret, tem;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
 	if (unlikely((((unsigned long) uaddr) & 0x3UL)))
 		return -EINVAL;
 
