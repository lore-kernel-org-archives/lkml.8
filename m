Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0748C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AEE20637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgCWSva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:51:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46952 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgCWSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:51:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGSAZ-0013hQ-EJ; Mon, 23 Mar 2020 18:51:27 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/7] [parisc, s390, sparc64] no need for access_ok() in futex handling
Date:   Mon, 23 Mar 2020 18:51:23 +0000
Message-Id: <20200323185127.252501-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
References: <20200323185057.GE23230@ZenIV.linux.org.uk>
 <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

access_ok() is always true on those

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/include/asm/futex.h   | 3 ---
 arch/s390/include/asm/futex.h     | 2 --
 arch/sparc/include/asm/futex_64.h | 2 --
 3 files changed, 7 deletions(-)

diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
index c10cc9010cc1..c459f656c8c3 100644
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
index ed965c3ecd5b..26f9144562c9 100644
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
index 84fffaaf59d3..72de967318d7 100644
--- a/arch/sparc/include/asm/futex_64.h
+++ b/arch/sparc/include/asm/futex_64.h
@@ -35,8 +35,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret, tem;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
 	if (unlikely((((unsigned long) uaddr) & 0x3UL)))
 		return -EINVAL;
 
-- 
2.11.0

