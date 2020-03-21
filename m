Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A7C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6F220781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgCUPak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38877 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCUPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg51-0004wf-Jx; Sat, 21 Mar 2020 16:30:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 280B81C22E5;
        Sat, 21 Mar 2020 16:30:31 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:30 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Rename ___preempt_schedule
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320115858.995685950@infradead.org>
References: <20200320115858.995685950@infradead.org>
MIME-Version: 1.0
Message-ID: <158480463081.28353.17673265563956442627.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     46db36abc32dfd18041c57d571fe4945fc0057fe
Gitweb:        https://git.kernel.org/tip/46db36abc32dfd18041c57d571fe4945fc0057fe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Mar 2020 12:56:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:53 +01:00

x86/entry: Rename ___preempt_schedule

Because moar '_' isn't always moar readable.

git grep -l "___preempt_schedule\(_notrace\)*" | while read file;
do
	sed -ie 's/___preempt_schedule\(_notrace\)*/preempt_schedule\1_thunk/g' $file;
done

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200320115858.995685950@infradead.org

---
 arch/x86/entry/thunk_32.S      | 8 ++++----
 arch/x86/entry/thunk_64.S      | 8 ++++----
 arch/x86/include/asm/preempt.h | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index e010d4a..3a07ce3 100644
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
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index c5c3b6e..dbe4493 100644
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
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 3d4cb83..69485ca 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -103,14 +103,14 @@ static __always_inline bool should_resched(int preempt_offset)
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
