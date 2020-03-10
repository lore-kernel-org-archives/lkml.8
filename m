Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AEDC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CF7215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583856402;
	bh=QaB1DLMLzYVmS7NOzAyfnAV62dQxl/Io1eNsemn2W1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P/IL+QX1b7wIViQPVfo5oJPpbiU04KxTzPE4YeZWLUTOav30hyN9SKa7UkhUyb3PW
	 l2YunT5VWT2BQA3ocXi3slr7mOcXXNS9vn1nGas8zmSXchLyfhud10Yy8wIgxLw2pH
	 ur68mBM76dD1BTZlCEyGsaUqxU0D8Ukq1cYZwCvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgCJQGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJQGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:06:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B015820873;
        Tue, 10 Mar 2020 16:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583856399;
        bh=QaB1DLMLzYVmS7NOzAyfnAV62dQxl/Io1eNsemn2W1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ynOndZMfdVzZq7sozSoaZ0uDLdIPIPfVDGTPa8HJ5ZdDpsTZjuSGzbQEgViPqptWi
         MjNDaQLs2aT1lZQHfnnlj+ZRPO5hJxwfXNmWmsidKbFA+HusiYmoFBRAiK+4JK1clf
         wwrmzNBz73ksDoiiylKgUYLLDo7SQem45kanjPjQ=
Date:   Wed, 11 Mar 2020 01:06:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: Instrumentation and RCU
Message-Id: <20200311010633.dea4de0ae9c0f28340a56752@kernel.org>
In-Reply-To: <87pndk5tb4.fsf@nanos.tec.linutronix.de>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
        <20200309141546.5b574908@gandalf.local.home>
        <87fteh73sp.fsf@nanos.tec.linutronix.de>
        <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
        <87pndk5tb4.fsf@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 12:43:27 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Masami,
> 
> Masami Hiramatsu <mhiramat@kernel.org> writes:
> > On Mon, 09 Mar 2020 19:59:18 +0100
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> >> #2) Breakpoint utilization
> >> >> 
> >> >>     As recent findings have shown, breakpoint utilization needs to be
> >> >>     extremly careful about not creating infinite breakpoint recursions.
> >> >> 
> >> >>     I think that's pretty much obvious, but falls into the overall
> >> >>     question of how to protect callchains.
> >> >
> >> > This is rather unique, and I agree that its best to at least get to a point
> >> > where we limit the tracing within breakpoint code. I'm fine with making
> >> > rcu_nmi_exit() nokprobe too.
> >> 
> >> Yes, the break point stuff is unique, but it has nicely demonstrated how
> >> much of the code is affected by it.
> >
> > I see. I had followed the callchain several times, and always found new function.
> > So I agree with the off-limit section idea. That is a kind of entry code section
> > but more generic one. It is natural to split such sensitive code in different
> > place.
> >
> > BTW, what about kdb stuffs? (+Cc Jason)
> 
> That's yet another area of wreckage which nobody every looked at.
> 
> >> >> #4 Protecting call chains
> >> >> 
> >> >>    Our current approach of annotating functions with notrace/noprobe is
> >> >>    pretty much broken.
> >> >> 
> >> >>    Functions which are marked NOPROBE or notrace call out into functions
> >> >>    which are not marked and while this might be ok, there are enough
> >> >>    places where it is not. But we have no way to verify that.
> >
> > Agreed. That's the reason why I haven't add kprobe-fuzzer yet.
> > It is easy to make a fuzzer for kprobes by ftrace (note that we need
> > to enable CONFIG_KPROBE_EVENTS_ON_NOTRACE=y to check notrace functions),
> > but there is no way to kick the target code. In the result, most of the
> > kprobed functions are just not hit. I'm not sure such test code is
> > reasonable or not.
> 
> Well, test code is always reasonable, but you have to be aware that code
> coverage is a really hard to solve problem with a code base as complex
> as the kernel.

Yes, especially, the corner case which we need to find is hard to cover.

> >> which is also in section "text" then the analysis tool will find the
> >> missing offlimit_safecall() - or what ever method we chose to annotate
> >> that stuff. Surely not an annotation on the called function itself
> >> because that might be safe to call in one context but not in another.
> >
> > Hmm, what the offlimit_safecall() does? and what happen if the 
> > do_fragile_stuff_on_enter() invokes a library code? I think we also need
> > to tweak kbuild to duplicate some library code to the off-limit text
> > area.
> 
> That's why we want the sections and the annotation. If something calls
> out of a noinstr section into a regular text section and the call is not
> annotated at the call site, then objtool can complain and tell you. What
> Peter and I came up with looks like this:
> 
> noinstr foo()
> 	do_protected(); <- Safe because in the noinstr section
> 
> 	instr_begin();	<- Marks the begin of a safe region, ignored
>         		   by objtool
> 
>         do_stuff();     <- All good   
> 
>         instr_end();    <- End of the safe region. objtool starts
> 			   looking again
> 
>         do_other_stuff();  <- Unsafe because do_other_stuff() is
>         		      not protected
> and:
> 
> noinstr do_protected()
>         bar();		<- objtool will complain here
> 
> See?

OK, so this is for what the instr_begin() and instr_end() ensure the
instrumentation safeness. Would you think this will also applied to
notrace functons? I mean, how can large this section be.

It seems there are several different aspect (or level), RCU idle,
kprobes recursive call(NOKPROBE), and ftrace recursive call(notrace).
Would the offlimit section include all of them or some specific cases?

> >> These annotations are halfways easy to monitor for abuse and they should
> >> be prominent enough in the code that at least for the people dealing
> >> with that kind of code they act as a warning flag.
> >
> > This off-limit text will be good for entries, but I think we still not
> > able to remove all NOKPROBE_SYMBOLS with this.
> >
> > For example __die() is marked a NOKPROBE because if we hit a recursive
> > int3, it calls BUG() to dump stacks etc for debug. So that function
> > must NOT probed. (I think we also should mark all backtrace functions
> > in this case, but not yet) Would we move those backtrace related
> > functions (including printk, and console drivers?) into the offlimit
> > text too?
> 
> That's something we need to figure out and decide on. Some of this stuff
> sureley wants to be in the noinstr section. Other things might end up
> still being explicitely annotated, but that should be the exception not
> the rule.

I think some library code can be duplicated in the offlimit section if
needed. And stacktrace can also be a part of offlimit as like as a
"service" call from normal world, since usually, stacktrace is for
debugging.

> > Hmm, if there is a bust_kprobes(), that can be easy to fix this issue.
> 
> That might help, but is obviously racy as hell.

I tried something like below. It needs a new set_memory_rw()
like function which can be called from int3 context.

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4d7022a740ab..7ab5bbc69cc9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -619,6 +619,9 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(setup_singlestep);
 
+int __read_mostly kprobe_oops_in_progress;
+extern int __set_page_rw_raw(unsigned long addr);
+
 /*
  * We have reentered the kprobe_handler(), since another probe was hit while
  * within the handler. We save the original kprobes variables and just single
@@ -635,6 +638,17 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 		setup_singlestep(p, regs, kcb, 1);
 		break;
 	case KPROBE_REENTER:
+		if (unlikely(kprobe_oops_in_progress)) {
+			/*
+			 * We do not sync cores but there is no way to send
+			 * IPI from here. If other core hits int3, they can
+			 * recover by themselves.
+			 */
+			__set_page_rw_raw((unsigned long)p->addr);
+			*(p->addr) = p->ainsn.insn[0];
+			return 1;
+		}
+
 		/* A probe has been hit in the codepath leading up to, or just
 		 * after, single-stepping of a probed instruction. This entire
 		 * codepath should strictly reside in .kprobes.text section.
@@ -643,6 +657,8 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 		 */
 		pr_err("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
+		/* Any further non-optimized kprobes are disabled forcibly */
+		kprobe_oops_in_progress++;
 		BUG();
 	default:
 		/* impossible cases */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index abbdecb75fad..0f550b1aad29 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/kprobes.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1345,6 +1346,60 @@ int kern_addr_valid(unsigned long addr)
 	return pfn_valid(pte_pfn(*pte));
 }
 
+int __set_page_rw_raw(unsigned long addr)
+{
+	unsigned long above = ((long)addr) >> __VIRTUAL_MASK_SHIFT;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	if (above != 0 && above != -1UL)
+		return 0;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		return 0;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return 0;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return 0;
+
+	if (pud_large(*pud)) {
+		if (!pfn_valid(pud_pfn(*pud)))
+			return 0;
+		pud_mkwrite(*pud);
+		goto flush;
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return 0;
+
+	if (pmd_large(*pmd)) {
+		if (!pfn_valid(pmd_pfn(*pmd)))
+			return 0;
+		pmd_mkwrite(*pmd);
+		goto flush;
+	}
+
+	pte = pte_offset_kernel(pmd, addr);
+	if (pte_none(*pte) || !pfn_valid(pte_pfn(*pte)))
+		return 0;
+
+	pte_mkwrite(*pte);
+
+flush:
+	__flush_tlb_one_kernel(addr);
+	return 1;
+}
+NOKPROBE_SYMBOL(__set_page_rw_raw);
+
 /*
  * Block size is the minimum amount of memory which can be hotplugged or
  * hotremoved. It must be power of two and must be equal or larger than


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
