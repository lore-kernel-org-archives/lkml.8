Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C95C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5527204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UC7WaKDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgESIjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:39:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pFkikJXoNytc03Bw/n9lcc4TGxhSfdZavl/JejOAmLk=; b=UC7WaKDDjEIr7TIYnFWbPUQWgo
        aa/zGvqRFxdWMd7zrh07rAL3bykA9IgujuC+xi6pN5uVdxw625DDlQPT75fwVNFC2mQ49uiyzGLXz
        MFaJ1Z427lIhiHI11v37AbYnjk9ca0Z4j3lJMtQIWjf6SJV50syqRvZWTq42IQ5+qa31iS/EgudUX
        mrpJVQ5XA7lngySwuWiwqJkj1d6Wod7hc9mQ6wQXiF1rMlbB+MZK2yIxYLB0FG2F5kRaffSkervxY
        T8xXwQsUYgCDkko5au/0XTksLDnBNrGUToyUT0r9Q+n0pAQR0xawXQPLHFIY87FO0whrmiruaNJu+
        BRBDZ2QQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaxle-0000vZ-Ah; Tue, 19 May 2020 08:38:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28EF73008A8;
        Tue, 19 May 2020 10:38:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF2F82105F3AF; Tue, 19 May 2020 10:38:26 +0200 (CEST)
Date:   Tue, 19 May 2020 10:38:26 +0200
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
Message-ID: <20200519083826.GC279861@hirez.programming.kicks-ass.net>
References: <20200518160750.GA279861@hirez.programming.kicks-ass.net>
 <87367xvvmy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87367xvvmy.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:24:53PM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > So on top of you entry-v8-full; I had to chase one of those
> > instrumentation_end() escapes an (extended) basic block chase (again!).
> >
> > --- a/arch/x86/include/asm/bug.h
> > +++ b/arch/x86/include/asm/bug.h
> > @@ -79,8 +79,8 @@ do {								\
> >  do {								\
> >  	instrumentation_begin();				\
> >  	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
> > -	instrumentation_end();					\
> >  	annotate_reachable();					\
> > +	instrumentation_end();					\
> >  } while (0)
> 
> I just applied this part and rebuilt:
> 
>  vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.77()+0xa9: call to
>  rcu_preempt_deferred_qs() leaves .noinstr.text section
> 
> Did it go away after you disabled DEBUG_ENTRY perhaps?

Hehe, then all complaints would be gone :-)

So tglx/entry-v8-full + below patch:

$ make O=defconfig-build clean
...
$ make CC=gcc-9 O=defconfig-build/ vmlinux -j40 -s
vmlinux.o: warning: objtool: exc_debug()+0x158: call to trace_hwlat_timestamp() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_nmi()+0x190: call to trace_hwlat_timestamp() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0x46: call to mce_rdmsrl() leaves .noinstr.text section
$

(it really isn't defconfig, but your config-fail + DEBUG_ENTRY)

---
 arch/x86/include/asm/bug.h |  2 +-
 include/linux/compiler.h   | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index 7db5902f8f6e..f6f54e8e0797 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,25 +120,30 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
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
