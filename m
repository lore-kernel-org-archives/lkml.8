Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C9DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F85120888
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596244482;
	bh=yOeXJOwQS2nXRaRZE3BI/tz+02Fdz67TB48RJdo6i5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k4c0Hx8Ge7WfsDoz/zVGXHnuq2tRLw7Ul5wsnm//Ts0GNrLB6u5Jj2oYVR/k9sk3l
	 qJWZZqgUanON8x0EAjwEMDjQicrZaHev8wKBfDOoAwmEeyEPk87QBO30NTUnbgYDZT
	 GLoy6FnsHeP3HcHp9LfMF8Xmdi+Fm72WKv8JtiKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHABOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHABOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:40 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEF320888;
        Sat,  1 Aug 2020 01:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244479;
        bh=yOeXJOwQS2nXRaRZE3BI/tz+02Fdz67TB48RJdo6i5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAbGj9/tz3Wt6os/CvcgAch+lrob3O8xJrDZYvWQyWx+noElXxgS7EYPQMXX0Jcbj
         iioY+/QfFKaXAuL875rpVHtvn0vX/1fFdkGoBGg62jc9ruLVN9GUvc8ytcDQhUu5AG
         T2kAIIJTyEOHG5hIywWGA175T+DoJmJbNDuhHPOQ=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 01/13] csky: remove unusued thread_saved_pc and *_segments functions/macros
Date:   Sat,  1 Aug 2020 01:14:01 +0000
Message-Id: <1596244453-98575-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>

These are used nowhere in the tree (except for some architectures which
define them for their own use) and were already removed for other
architectures in:

commit 6474924e2b5d ("arch: remove unused macro/function thread_saved_pc()")
commit c17c02040bf0 ("arch: remove unused *_segments() macros/functions")

Remove them from arch/csky as well.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/processor.h |  6 ------
 arch/csky/kernel/process.c        | 10 ----------
 2 files changed, 16 deletions(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 24442d8..4800f65 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -82,12 +82,6 @@ static inline void release_thread(struct task_struct *dead_task)
 
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-#define forget_segments()		do { } while (0)
-
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 8b3fad0..3da63cf 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -30,16 +30,6 @@ asmlinkage void ret_from_kernel_thread(void);
  */
 void flush_thread(void){}
 
-/*
- * Return saved PC from a blocked thread
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	struct switch_stack *sw = (struct switch_stack *)tsk->thread.sp;
-
-	return sw->r15;
-}
-
 int copy_thread_tls(unsigned long clone_flags,
 		unsigned long usp,
 		unsigned long kthread_arg,
-- 
2.7.4

