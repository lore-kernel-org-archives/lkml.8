Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD6C20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4482yxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgERQLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:11:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgERQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RMyYli+uYcg6GiJKKmuAIgS2Y/Kzt9nNBmazS9TcZzg=; b=F4482yxM4+Z7u9gmgoOYTqjX1j
        jvn7nL6ik4SWbWbg/CL5d3F7r1XQteo89Y5PF7hA4Y3BSGqROFNUYsyMSwATr+RzgN8yPBJRchXJk
        HiAEsT4h7JwfQuhXhXgiypPqBhdmDL7Jq3X2/I4hpUx33+FSwJYZgn13QWlS3JlPS3QeGQ9wdmtjN
        /UvzrBzoox628yUDDyj+8TD7Tou4TybZwiWbELZVVbDqGMyiSAR1pzKYd/le4YjBBznXEYEp5+LfL
        FtcSmtt6El1d6AAxMv8klTXZYm6YN5q8FR8y3iZEwBKyRpYLwOUSNPS4xgSRazsWvrawnbB0Wai6R
        bQuuxlQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaiJ6-0006qD-IV; Mon, 18 May 2020 16:08:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D22643008A8;
        Mon, 18 May 2020 18:07:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A184C2105F3B6; Mon, 18 May 2020 18:07:50 +0200 (CEST)
Date:   Mon, 18 May 2020 18:07:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
Message-ID: <20200518160750.GA279861@hirez.programming.kicks-ass.net>
References: <20200515234547.710474468@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515234547.710474468@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So on top of you entry-v8-full; I had to chase one of those
instrumentation_end() escapes an (extended) basic block chase (again!).

How about we do something like the below; that fixes the current case
(rcu_eqs_enter) but also kills the entire class.

---
 arch/x86/include/asm/bug.h     |  2 +-
 include/linux/compiler.h       | 16 +++++++++++++---
 include/linux/compiler_types.h |  4 ----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f128e5c2ed42..fb34ff641e0a 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -79,8 +79,8 @@ do {								\
 do {								\
 	instrumentation_begin();				\
 	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
-	instrumentation_end();					\
 	annotate_reachable();					\
+	instrumentation_end();					\
 } while (0)
 
 #include <asm-generic/bug.h>
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7db5902f8f6e..b4c248e6b76a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,25 +120,35 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(.rodata..c_jump_table)
 
+#ifdef CONFIG_DEBUG_ENTRY
+/* Section for code which can't be instrumented at all */
+#define noinstr								\
+	noinline notrace __attribute((__section__(".noinstr.text")))
+
 /* Begin/end of an instrumentation safe region */
-#define instrumentation_begin() ({						\
+#define instrumentation_begin() ({					\
 	asm volatile("%c0:\n\t"						\
 		     ".pushsection .discard.instr_begin\n\t"		\
 		     ".long %c0b - .\n\t"				\
 		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
 
-#define instrumentation_end() ({							\
-	asm volatile("%c0:\n\t"						\
+#define instrumentation_end() ({					\
+	asm volatile("%c0: nop\n\t"					\
 		     ".pushsection .discard.instr_end\n\t"		\
 		     ".long %c0b - .\n\t"				\
 		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
+#endif /* CONFIG_DEBUG_ENTRY */
 
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
 #define __annotate_jump_table
+#endif
+
+#ifndef noinstr
+#define noinstr noinline notrace
 #define instrumentation_begin()		do { } while(0)
 #define instrumentation_end()		do { } while(0)
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ea15ea99efb4..6ed0612bc143 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -118,10 +118,6 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
-/* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))
-
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
