Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A9220767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s55dRaaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIBNza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIBNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:46:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB8C061261
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cK0SzLUGgTPud8Bio5a951X67ujynxVhPO2GV7yRpvc=; b=s55dRaaDX+O2Kt2tSD0EOZ0scv
        HwHGaZp0iwNUWm8dO8SzZpz0TW6eryFJpG2dE05FMT/sYuqtlJx1GIFWk/TOdcXy9aYrwdekRNvXX
        Zbm5HR0ogduXY0yAStqQgHGdB/E8YU3rFQelJpYbAnuCCScjOojyPb7bOwJyJrKvIRcMx9BzksX0t
        HJGDLAknv4mxCYXD42B16N2qp9a+InJd9p9zNiObEUVrpmaJBqb38bgcHyIdrF/XJAvPtfvCXxl+p
        s9O1mE/ZaTxPlmo1SOPKNyiM5xRkT40B4MrxyeXPfw9zWdznfj0qH00lCQKhWW+oAlnlXl878mOYd
        EUNRfbKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxq-0003Za-SQ; Wed, 02 Sep 2020 13:38:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A05DA30767C;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB60E29A82C21; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133201.233022474@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 10/13] x86/debug: Remove aout_dump_debugregs()
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused remnants for the bit-bucket.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/debugreg.h |    2 --
 arch/x86/kernel/hw_breakpoint.c |   36 ------------------------------------
 2 files changed, 38 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -90,8 +90,6 @@ static __always_inline bool hw_breakpoin
 	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
 }
 
-extern void aout_dump_debugregs(struct user *dump);
-
 extern void hw_breakpoint_restore(void);
 
 static __always_inline unsigned long local_db_save(void)
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -442,42 +442,6 @@ int hw_breakpoint_arch_parse(struct perf
 }
 
 /*
- * Dump the debug register contents to the user.
- * We can't dump our per cpu values because it
- * may contain cpu wide breakpoint, something that
- * doesn't belong to the current task.
- *
- * TODO: include non-ptrace user breakpoints (perf)
- */
-void aout_dump_debugregs(struct user *dump)
-{
-	int i;
-	int dr7 = 0;
-	struct perf_event *bp;
-	struct arch_hw_breakpoint *info;
-	struct thread_struct *thread = &current->thread;
-
-	for (i = 0; i < HBP_NUM; i++) {
-		bp = thread->ptrace_bps[i];
-
-		if (bp && !bp->attr.disabled) {
-			dump->u_debugreg[i] = bp->attr.bp_addr;
-			info = counter_arch_bp(bp);
-			dr7 |= encode_dr7(i, info->len, info->type);
-		} else {
-			dump->u_debugreg[i] = 0;
-		}
-	}
-
-	dump->u_debugreg[4] = 0;
-	dump->u_debugreg[5] = 0;
-	dump->u_debugreg[6] = current->thread.debugreg6;
-
-	dump->u_debugreg[7] = dr7;
-}
-EXPORT_SYMBOL_GPL(aout_dump_debugregs);
-
-/*
  * Release the user breakpoints used by ptrace
  */
 void flush_ptrace_hw_breakpoint(struct task_struct *tsk)


