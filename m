Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D112065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593192085;
	bh=ITdNEEY+ZHKHsjx3oMsm/9Nbn6kiG/EkZjcuFwym5no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWVeFaSq/qq84NUaopfrN/rsRfUbsciFxdemTHMPn746Zzv6rEe3788x1UfRrY/RS
	 ZmG+29ftUyecb4ZH04QEHTXpmy8vXLhbWTIRCE5GWVG12hc/86izVUi5Wzg5kwrMK9
	 gmd45b6TrVy2s/EqOzJU2ydUcDFpuvaOxX3EuD84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFZRVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgFZRVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:21:20 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231C720823;
        Fri, 26 Jun 2020 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192080;
        bh=ITdNEEY+ZHKHsjx3oMsm/9Nbn6kiG/EkZjcuFwym5no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPPamoIx+AvB5/BkRh8J+OwzXuhJ6XadVUjCoHniecDZyTU/JCZlkEWcZvTHr9esU
         wMUZw0TVkIWnHOKXyiaCmLxKf6bOf/nO7xElHnQmqpB533lzQEoxN8rXAfgnncVryd
         NA1Y6aknx9bEQXsiyRC0QY0PPJI/BNRvau6p4m7U=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/6] x86/entry: Assert that syscalls are on the right stack
Date:   Fri, 26 Jun 2020 10:21:11 -0700
Message-Id: <52059e42bb0ab8551153d012d68f7be18d72ff8e.1593191971.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593191971.git.luto@kernel.org>
References: <cover.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the entry stack is a full page, it's too easy to regress
the system call entry code and end up on the wrong stack without
noticing.  Assert that all system calls (SYSCALL64, SYSCALL32,
SYSENTER, and INT80) are on the right stack and have pt_regs in the
right place.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f14175193..ed8ccc820995 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -45,6 +45,15 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+/* Check that the stack and regs on entry from user mode are sane. */
+static void check_user_regs(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		WARN_ON_ONCE(!on_thread_stack());
+		WARN_ON_ONCE(regs != task_pt_regs(current));
+	}
+}
+
 #ifdef CONFIG_CONTEXT_TRACKING
 /**
  * enter_from_user_mode - Establish state when coming from user mode
@@ -127,9 +136,6 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	unsigned long ret = 0;
 	u32 work;
 
-	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-		BUG_ON(regs != task_pt_regs(current));
-
 	work = READ_ONCE(ti->flags);
 
 	if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
@@ -346,6 +352,8 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
+	check_user_regs(regs);
+
 	enter_from_user_mode();
 	instrumentation_begin();
 
@@ -409,6 +417,8 @@ static void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
+	check_user_regs(regs);
+
 	enter_from_user_mode();
 	instrumentation_begin();
 
@@ -460,6 +470,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 					vdso_image_32.sym_int80_landing_pad;
 	bool success;
 
+	check_user_regs(regs);
+
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
-- 
2.25.4

