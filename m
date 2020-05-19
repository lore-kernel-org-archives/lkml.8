Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0486DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD77A2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GvILhhcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgESJCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESJCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:02:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ECBC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QVvLau/9rnCPsCtt46lwjQQtMKtK/oxJF//68Ttv+kc=; b=GvILhhcIZtJOf8m0a2HgOo2CTD
        4y13cf35CqBx7M4Wk5ISf0byOEUzHU3ihh3Tr1yPD1F4Lye9HtppxWVr2F0Uf7PbXq6MFEcqhaVyP
        THqXaMJa6ODe6RTRH98GNbagiBN8yFYSz9Px2NAHzIL9Yw69vvj6VCXfOAZAqJ+keN7IL3kZQKXsL
        qLg9Mae1MOV+b2JJ/OfKg3ILTLF7SuvCBo83wZgqPNy9jX7RXws7m6UwkE/uZDX6TjE3pPIdfXF63
        HqPfMou0yV6xotCYd1i30tKPQ4rjuVNuPhuOBChcGud/LAH2lNZsLYEPXu4p+inUH23CmX6WOp55E
        tN6pmksw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jay8r-0002i1-Fo; Tue, 19 May 2020 09:02:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EEC130067C;
        Tue, 19 May 2020 11:02:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37A9D2105F3AF; Tue, 19 May 2020 11:02:26 +0200 (CEST)
Date:   Tue, 19 May 2020 11:02:26 +0200
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
Message-ID: <20200519090226.GD279861@hirez.programming.kicks-ass.net>
References: <20200518160750.GA279861@hirez.programming.kicks-ass.net>
 <87367xvvmy.fsf@nanos.tec.linutronix.de>
 <20200519083826.GC279861@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519083826.GC279861@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:38:26AM +0200, Peter Zijlstra wrote:
> $ make CC=gcc-9 O=defconfig-build/ vmlinux -j40 -s
> vmlinux.o: warning: objtool: exc_debug()+0x158: call to trace_hwlat_timestamp() leaves .noinstr.text section
> vmlinux.o: warning: objtool: exc_nmi()+0x190: call to trace_hwlat_timestamp() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_machine_check()+0x46: call to mce_rdmsrl() leaves .noinstr.text section
> $
> 
> (it really isn't defconfig, but your config-fail + DEBUG_ENTRY)
> 

With comment on, as requested.

---
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
index 7db5902f8f6e..4b8fabed46ae 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,25 +120,61 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(.rodata..c_jump_table)
 
+#ifdef CONFIG_DEBUG_ENTRY
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
+/*
+ * Because instrumentation_{begin,end}() can nest, objtool validation considers
+ * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
+ * When the value is greater than 0, we consider instrumentation allowed.
+ *
+ * There is a problem with code like:
+ *
+ * noinstr void foo()
+ * {
+ *	instrumentation_begin();
+ *	...
+ *	if (cond) {
+ *		instrumentation_begin();
+ *		...
+ *		instrumentation_end();
+ *	}
+ *	bar();
+ *	instrumentation_end();
+ * }
+ *
+ * If instrumentation_end() would be an empty label, like all the other
+ * annotations, the inner _end(), which is at the end of a conditional block,
+ * would land on the instruction after the block.
+ *
+ * If we then consider the sum of the !cond path, we'll see that the call to
+ * bar() is with a 0-value, even though, we meant it to happen with a positive
+ * value.
+ *
+ * To avoid this, have _end() be a NOP instruction, this ensures it will be
+ * part of the condition block and does not escape.
+ */
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
+#ifndef instrumentation_begin
 #define instrumentation_begin()		do { } while(0)
 #define instrumentation_end()		do { } while(0)
 #endif
