Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE87BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C028E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ur9gYfFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCTMAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:00:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCTMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=t2LpZigdOi74PxD6VQThHgzM3J5yf9Gt391Lv9LGZWI=; b=Ur9gYfFnyEQQR6I6H7TGAvv6vC
        td+dgsfu+KVfaUx/H42BksTohk9qDNB69uAswAVLrGkl7MTosNG4My9urqnSDuShmQd4AH4dbk5A1
        pBrRJStPMKJIqwExyw0i2TZw92e+Kj+8Tdbw2at1JK5+3LvYEG3EI6aOTsaNXWNJiOGFKLm2xKVx1
        pEEUcb/4kX8855WRwsoESNRuMIYflC/4GhbreP8VJqEk6Hr7ZUCtpqYsfWTsNnrDfvZUqR7FKwvNx
        91NqNqA4C1nrSM2wqV0S1SIqgvmyNIW8OOVKWooSrsy4GYOziO0uwSrajZNnLOK2SO32EkrPVO449
        8i3CClqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFGK8-0008Gt-BK; Fri, 20 Mar 2020 12:00:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8D6230018B;
        Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 795562029F4C9; Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Message-Id: <20200320115858.995685950@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 12:56:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, will@kernel.org, peterz@infradead.org
Subject: [PATCH 1/4] Rename ___preempt_schedule
References: <20200320115638.737385408@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because moar '_' isn't always moar readable.

git grep -l "___preempt_schedule\(_notrace\)*" | while read file;
do
	sed -ie 's/___preempt_schedule\(_notrace\)*/preempt_schedule\1_thunk/g' $file;
done

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/thunk_32.S      |    8 ++++----
 arch/x86/entry/thunk_64.S      |    8 ++++----
 arch/x86/include/asm/preempt.h |    8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -35,9 +35,9 @@ SYM_CODE_END(\name)
 #endif
 
 #ifdef CONFIG_PREEMPTION
-	THUNK ___preempt_schedule, preempt_schedule
-	THUNK ___preempt_schedule_notrace, preempt_schedule_notrace
-	EXPORT_SYMBOL(___preempt_schedule)
-	EXPORT_SYMBOL(___preempt_schedule_notrace)
+	THUNK preempt_schedule_thunk, preempt_schedule
+	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
+	EXPORT_SYMBOL(preempt_schedule_thunk)
+	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 #endif
 
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -47,10 +47,10 @@ SYM_FUNC_END(\name)
 #endif
 
 #ifdef CONFIG_PREEMPTION
-	THUNK ___preempt_schedule, preempt_schedule
-	THUNK ___preempt_schedule_notrace, preempt_schedule_notrace
-	EXPORT_SYMBOL(___preempt_schedule)
-	EXPORT_SYMBOL(___preempt_schedule_notrace)
+	THUNK preempt_schedule_thunk, preempt_schedule
+	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
+	EXPORT_SYMBOL(preempt_schedule_thunk)
+	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 #endif
 
 #if defined(CONFIG_TRACE_IRQFLAGS) \
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -103,14 +103,14 @@ static __always_inline bool should_resch
 }
 
 #ifdef CONFIG_PREEMPTION
-  extern asmlinkage void ___preempt_schedule(void);
+  extern asmlinkage void preempt_schedule_thunk(void);
 # define __preempt_schedule() \
-	asm volatile ("call ___preempt_schedule" : ASM_CALL_CONSTRAINT)
+	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT)
 
   extern asmlinkage void preempt_schedule(void);
-  extern asmlinkage void ___preempt_schedule_notrace(void);
+  extern asmlinkage void preempt_schedule_notrace_thunk(void);
 # define __preempt_schedule_notrace() \
-	asm volatile ("call ___preempt_schedule_notrace" : ASM_CALL_CONSTRAINT)
+	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT)
 
   extern asmlinkage void preempt_schedule_notrace(void);
 #endif


