Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D866C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAFD20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgC0C2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:28:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47834 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgC0C2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:28:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHeje-003hGA-3v; Fri, 27 Mar 2020 02:28:38 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 7/8] generic arch_futex_atomic_op_inuser() doesn't need access_ok()
Date:   Fri, 27 Mar 2020 02:28:35 +0000
Message-Id: <20200327022836.881203-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
References: <x86: unsafe_put-style macro for sigmask>
 <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
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

