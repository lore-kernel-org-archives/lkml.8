Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752F6206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597841433;
	bh=82c0M4r2v9vmu+J3LNGEZvNsiX4xegCRnclRjTkc4/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7xUt+V1A7C93erNbK0d2kbWE2V864JQeznFG3f0ADEUi35gkD5al+k9achEjsWy9
	 uBmY1i/wu/lnjN/S2Dh6vq9kBmn9gTjN0FNSOMK776uyGD0zWN4M4N+hwHNeGxI0ru
	 X99HAPJpxEseptZuQ7jrJFFBrpT/CMoZ1CFHe1UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHSMuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgHSMuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:50:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48142072D;
        Wed, 19 Aug 2020 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597841408;
        bh=82c0M4r2v9vmu+J3LNGEZvNsiX4xegCRnclRjTkc4/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCvFuqYGPhA5OkY9xU5vcakYoj7CV5UZ/02wgyzH3Y923BsCuIabyjusLnV8woih5
         KdQHgWMzfE/56q/SNxxTz7WITLnqBAeao0ALlxRl5Gmys/ei8oXQJsOhQ21831/Z2C
         P3fQuv/Zav+3BQHatfh5/FNatgVdECK1JLUM0y7U=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] arm64: stacktrace: Make stack walk callback consistent with generic code
Date:   Wed, 19 Aug 2020 13:49:12 +0100
Message-Id: <20200819124913.37261-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819124913.37261-1-broonie@kernel.org>
References: <20200819124913.37261-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with the generic arch_stack_walk() code the arm64 stack walk code takes
a callback that is called per stack frame. Currently the arm64 code always
passes a struct stackframe to the callback and the generic code just passes
the pc, however none of the users ever reference anything in the struct
other than the pc value. The arm64 code also uses a return type of int
while the generic code uses a return type of bool though in both cases the
return value is a boolean value.

In order to reduce code duplication when arm64 is converted to use
arch_stack_walk() change the signature of the arm64 specific callback to
match that of the generic code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/stacktrace.h |  2 +-
 arch/arm64/kernel/perf_callchain.c  |  6 +++---
 arch/arm64/kernel/return_address.c  |  8 ++++----
 arch/arm64/kernel/stacktrace.c      | 11 +++++------
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index fc7613023c19..eb29b1fe8255 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -63,7 +63,7 @@ struct stackframe {
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
 extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
-			    int (*fn)(struct stackframe *, void *), void *data);
+			    bool (*fn)(void *, unsigned long), void *data);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			   const char *loglvl);
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index b0e03e052dd1..bd2a91bd9e9e 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -137,11 +137,11 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
  * whist unwinding the stackframe and is like a subroutine return so we use
  * the PC.
  */
-static int callchain_trace(struct stackframe *frame, void *data)
+static bool callchain_trace(void *data, unsigned long pc)
 {
 	struct perf_callchain_entry_ctx *entry = data;
-	perf_callchain_store(entry, frame->pc);
-	return 0;
+	perf_callchain_store(entry, pc);
+	return false;
 }
 
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index a5e8b3b9d798..6434427a827a 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -18,16 +18,16 @@ struct return_address_data {
 	void *addr;
 };
 
-static int save_return_addr(struct stackframe *frame, void *d)
+static bool save_return_addr(void *d, unsigned long pc)
 {
 	struct return_address_data *data = d;
 
 	if (!data->level) {
-		data->addr = (void *)frame->pc;
-		return 1;
+		data->addr = (void *)pc;
+		return true;
 	} else {
 		--data->level;
-		return 0;
+		return false;
 	}
 }
 NOKPROBE_SYMBOL(save_return_addr);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 2dd8e3b8b94b..743cf11fbfca 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -118,12 +118,12 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 NOKPROBE_SYMBOL(unwind_frame);
 
 void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
-		     int (*fn)(struct stackframe *, void *), void *data)
+			     bool (*fn)(void *, unsigned long), void *data)
 {
 	while (1) {
 		int ret;
 
-		if (fn(frame, data))
+		if (fn(data, frame->pc))
 			break;
 		ret = unwind_frame(tsk, frame);
 		if (ret < 0)
@@ -139,17 +139,16 @@ struct stack_trace_data {
 	unsigned int skip;
 };
 
-static int save_trace(struct stackframe *frame, void *d)
+static bool save_trace(void *d, unsigned long addr)
 {
 	struct stack_trace_data *data = d;
 	struct stack_trace *trace = data->trace;
-	unsigned long addr = frame->pc;
 
 	if (data->no_sched_functions && in_sched_functions(addr))
-		return 0;
+		return false;
 	if (data->skip) {
 		data->skip--;
-		return 0;
+		return false;
 	}
 
 	trace->entries[trace->nr_entries++] = addr;
-- 
2.20.1

