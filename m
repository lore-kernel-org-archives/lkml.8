Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1EB2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594845905;
	bh=DhK6b8I/1ss0W4MzzdX02SLszvZEsAiNuD4UF+ErW80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X0Q8Tt/Y2Ron3e5N26APofllWDDqpB962L7H/qCZ0ClqakyGtKVylRWt0tTj0ZVbc
	 kvfujr/j6XdTki69Y7XqbK0Jdtyv+Ya1Fs8eJlONTv8ptr67h96fZ6D5+q/+GiCT+o
	 JTKO+0/AhAeEsEimkjrLNMIwaL5Bu1kzYBa72UzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgGOUpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgGOUpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:45:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C81E72067D;
        Wed, 15 Jul 2020 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594845899;
        bh=DhK6b8I/1ss0W4MzzdX02SLszvZEsAiNuD4UF+ErW80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdM+pJB4xeHusWvm1eoMCtIMJBK1krsd2g7/Kmlvs2ZA9kSq243NpwjTqBjrDD703
         Bujfqyl7pMDhr38aQllgCT7mNSeUoEDzUtKeqbINxNfl561Glpuf3U88XoDhh2wDw5
         ThzBTHuZCT/Huv2+pwcY0N472ZQJ7Y/sBmETlThA=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] stacktrace: Remove reliable argument from arch_stack_walk() callback
Date:   Wed, 15 Jul 2020 21:28:19 +0100
Message-Id: <20200715202821.12220-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715202821.12220-1-broonie@kernel.org>
References: <20200715202821.12220-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the callback passed to arch_stack_walk() has an argument called
reliable passed to it to indicate if the stack entry is reliable, a comment
says that this is used by some printk() consumers. However in the current
kernel none of the arch_stack_walk() implementations ever set this flag to
true and the only callback implementation we have is in the generic
stacktrace code which ignores the flag. It therefore appears that this
flag is redundant so we can simplify and clarify things by removing it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/s390/kernel/stacktrace.c |  4 ++--
 arch/x86/kernel/stacktrace.c  | 10 +++++-----
 include/linux/stacktrace.h    |  5 +----
 kernel/stacktrace.c           |  8 +++-----
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index fc5419ac64c8..7f1266c24f6b 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -19,7 +19,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 
 	unwind_for_each_frame(&state, task, regs, 0) {
 		addr = unwind_get_return_address(&state);
-		if (!addr || !consume_entry(cookie, addr, false))
+		if (!addr || !consume_entry(cookie, addr))
 			break;
 	}
 }
@@ -56,7 +56,7 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			return -EINVAL;
 #endif
 
-		if (!consume_entry(cookie, addr, false))
+		if (!consume_entry(cookie, addr))
 			return -EINVAL;
 	}
 
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 6ad43fc44556..5c30999fc705 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -18,13 +18,13 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	struct unwind_state state;
 	unsigned long addr;
 
-	if (regs && !consume_entry(cookie, regs->ip, false))
+	if (regs && !consume_entry(cookie, regs->ip))
 		return;
 
 	for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
 	     unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
-		if (!addr || !consume_entry(cookie, addr, false))
+		if (!addr || !consume_entry(cookie, addr))
 			break;
 	}
 }
@@ -73,7 +73,7 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 		if (!addr)
 			return -EINVAL;
 
-		if (!consume_entry(cookie, addr, false))
+		if (!consume_entry(cookie, addr))
 			return -EINVAL;
 	}
 
@@ -119,7 +119,7 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 {
 	const void __user *fp = (const void __user *)regs->bp;
 
-	if (!consume_entry(cookie, regs->ip, false))
+	if (!consume_entry(cookie, regs->ip))
 		return;
 
 	while (1) {
@@ -133,7 +133,7 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			break;
 		if (!frame.ret_addr)
 			break;
-		if (!consume_entry(cookie, frame.ret_addr, false))
+		if (!consume_entry(cookie, frame.ret_addr))
 			break;
 		fp = frame.next_fp;
 	}
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index b7af8cc13eda..50e2df30b0aa 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -29,14 +29,11 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
  * stack_trace_consume_fn - Callback for arch_stack_walk()
  * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
  * @addr:	The stack entry address to consume
- * @reliable:	True when the stack entry is reliable. Required by
- *		some printk based consumers.
  *
  * Return:	True, if the entry was consumed or skipped
  *		False, if there is no space left to store
  */
-typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
-				       bool reliable);
+typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr);
 /**
  * arch_stack_walk - Architecture specific function to walk the stack
  * @consume_entry:	Callback which is invoked by the architecture code for
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 946f44a9e86a..9f8117c7cfdd 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -78,8 +78,7 @@ struct stacktrace_cookie {
 	unsigned int	len;
 };
 
-static bool stack_trace_consume_entry(void *cookie, unsigned long addr,
-				      bool reliable)
+static bool stack_trace_consume_entry(void *cookie, unsigned long addr)
 {
 	struct stacktrace_cookie *c = cookie;
 
@@ -94,12 +93,11 @@ static bool stack_trace_consume_entry(void *cookie, unsigned long addr,
 	return c->len < c->size;
 }
 
-static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr,
-					      bool reliable)
+static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr)
 {
 	if (in_sched_functions(addr))
 		return true;
-	return stack_trace_consume_entry(cookie, addr, reliable);
+	return stack_trace_consume_entry(cookie, addr);
 }
 
 /**
-- 
2.20.1

