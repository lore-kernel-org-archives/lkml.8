Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72161C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5315420637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCWSvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:51:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46954 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgCWSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:51:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGSAZ-0013hj-NA; Mon, 23 Mar 2020 18:51:27 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 6/7] generic arch_futex_atomic_op_inuser() doesn't need access_ok()
Date:   Mon, 23 Mar 2020 18:51:26 +0000
Message-Id: <20200323185127.252501-6-viro@ZenIV.linux.org.uk>
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

uses get_user() and put_user() for memory accesses

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-generic/futex.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 3eab7ba912fc..f4c3470480c7 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -33,8 +33,6 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 	int oldval, ret;
 	u32 tmp;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
 	preempt_disable();
 
 	ret = -EFAULT;
-- 
2.11.0

