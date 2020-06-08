Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6ACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8652068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgFHWUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:20:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C50C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 15:20:55 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jiQ7j-0000OO-90; Tue, 09 Jun 2020 00:20:08 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8ACDF101181; Tue,  9 Jun 2020 00:20:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Zhao Yakui <yakui.zhao@intel.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on irqstack
In-Reply-To: <20200608160144.GA987@lca.pw>
References: <20200521200513.656533920@linutronix.de> <20200521202117.763775313@linutronix.de> <20200605171816.GA4259@lca.pw> <20200605173622.GL3976@hirez.programming.kicks-ass.net> <20200608160144.GA987@lca.pw>
Date:   Tue, 09 Jun 2020 00:20:06 +0200
Message-ID: <87pna98ajt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian,

can you please ensure that people who got cc'ed because the problem
affects their subsystem are included on your replies even if you are
replying to a different subthread?

I explicitely did:

     Cc:+ Alexander

at the very beginning of my reply:

   https://lore.kernel.org/r/87v9k3jdc6.fsf@nanos.tec.linutronix.de

to make you aware of that.

Yes, email sucks, but it sucks even more when people are careless.

Qian Cai <cai@lca.pw> writes:
> On Fri, Jun 05, 2020 at 07:36:22PM +0200, Peter Zijlstra wrote:
>
> Even after I trimmed the .config [1] to the barely minimal, a subset of LTP
> test still unable to finish on those AMD servers with page_owner=on.

What a surprise...

> [1]:
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
>
> It looks like because this new IRQ entry introduced by this patch,
>
> </IRQ>
> asm_call_on_stack at arch/x86/entry/entry_64.S:710
> handle_edge_irq at kernel/irq/chip.c:832
>
> which will running out of the stack depot limit due to nested loops
> below.
>
> which has this loop,
>
> 	do {
> 		...
> 		handle_irq_event(desc);
> 		...
> 	} while ((desc->istate & IRQS_PENDING) &&
> 		!irqd_irq_disabled(&desc->irq_data));

This loop has absolutely nothing to do with stack entry usage. 

foo()
  do {
     bar();
  } while (condition);
}

If you take a stack trace inside bar() it will be the same stack trace
for every single loop iteration. And that stack trace will not be any
different from:

foo()
{
  bar():
}

assumed that the call chain leading to foo() is the same in both cases.

And you can add even more loops in subsequent call chains within
bar(). They do not matter at all.

>  Here has a nested loop,
>
>	    for_each_action_of_desc(desc, action) {
>		    ...
>		    res = action->handler(irq, action->dev_id);
>		    ...
>	    }

And this one is completely irrelevant because the interrupt which we are
looking at is a PCI interrupt which CANNOT be shared. IOW, the number of
loop iterations and the number of handlers invoked is exactly ONE.

I seriously have no idea what you are trying to demonstrate by finding
loops in a SINGLE callchain.

> Here has one more nested loop,
>
> 	while (table->orig_nents) {
> 		...
> 		free_fn(sgl, alloc_size);
> 		...
> 	}
>
> free_fn() will call kmem_cache_free(). Since we have page_owner=on, it
> will call save_stack() to save the each free stack trace.

That stack trace for each invocation of free_fn() in this loop is
exactly the same stack trace. The same stack trace is not eating up any
memory because the hash matches, i.e. the stack trace in the depot is
already known.

Here is the simplified difference between the old code and the new code:

  Old                             New

  handle_edge_irq                 handle_edge_irq
  do_IRQ	                  asm_call_on_stack
  common_interrupt                common_interrupt
                                  asm_common_interrupt

IOW, for every _UNIQUE_ interrupt related call chain, there is exactly
ONE stack entry more than before.

For a loop which generates the exact same stack trace for every
iteration this extra entry is not a problem.

But what matters is that interrupts can hit any random code path. So the
amount of possible non-unique call chains is pretty much unlimited. And
with a high number of non-unique call chains the extra entry starts to
matter.

It's trival math, isn't it?

TS  = Total Size of depot
as  = average size of all stored unique stack traces
ms  = maximum number of unqiue stack traces which fit in TS

    ms_old = TS / as

Lets further assume that the vast majority of stack traces are taken
from interrupt context. That means with the new code this results in:

    ms_new = TS / (as + 1)

==> ms_new = ms_old * as / (as + 1)

Depending on the value of 'as' the +1 can shave off a significant
percentage of capacity. IOW, the capacity is simply too small now for
the test scenario you are running. Truly a surprising outcome, right?

To get facts instead of useless loop theories, can you please apply the
patch below, enable DEBUGFS and provide the output of

       /sys/kernel/debug/stackdepot/info

for a kernel before that change and after? Please read out that file at
periodically roughly the same amounts of time after starting your test
scenario.

Note, that I doubled the size of the stack depot so that we get real
numbers and not the cutoff by the size limit. IOW, the warning should
not trigger anymore. If it triggers nevertheless then the numbers will
still tell us an interesting story.

Thanks,

        tglx
---
 lib/stackdepot.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -31,6 +31,7 @@
 #include <linux/stackdepot.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/debugfs.h>
 
 #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
 
@@ -42,7 +43,7 @@
 					STACK_ALLOC_ALIGN)
 #define STACK_ALLOC_INDEX_BITS (DEPOT_STACK_BITS - \
 		STACK_ALLOC_NULL_PROTECTION_BITS - STACK_ALLOC_OFFSET_BITS)
-#define STACK_ALLOC_SLABS_CAP 8192
+#define STACK_ALLOC_SLABS_CAP 16384
 #define STACK_ALLOC_MAX_SLABS \
 	(((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_SLABS_CAP) ? \
 	 (1LL << (STACK_ALLOC_INDEX_BITS)) : STACK_ALLOC_SLABS_CAP)
@@ -70,6 +71,7 @@ static void *stack_slabs[STACK_ALLOC_MAX
 static int depot_index;
 static int next_slab_inited;
 static size_t depot_offset;
+static unsigned long unique_stacks;
 static DEFINE_SPINLOCK(depot_lock);
 
 static bool init_stack_slab(void **prealloc)
@@ -138,6 +140,7 @@ static struct stack_record *depot_alloc_
 	stack->handle.valid = 1;
 	memcpy(stack->entries, entries, size * sizeof(unsigned long));
 	depot_offset += required_size;
+	unique_stacks++;
 
 	return stack;
 }
@@ -340,3 +343,41 @@ unsigned int filter_irq_stacks(unsigned
 	return nr_entries;
 }
 EXPORT_SYMBOL_GPL(filter_irq_stacks);
+
+static int debug_show(struct seq_file *m, void *p)
+{
+	unsigned long unst;
+	int didx, doff;
+
+	spin_lock_irq(&depot_lock);
+	unst = unique_stacks;
+	didx = depot_index;
+	doff = depot_offset;
+	spin_unlock_irq(&depot_lock);
+
+	seq_printf(m, "Unique stacks: %lu\n", unst);
+	seq_printf(m, "Depot index:   %d\n", didx);
+	seq_printf(m, "Depot offset:  %d\n", doff);
+	return 0;
+}
+
+static int debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_ops = {
+	.open		= debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init debugfs_init(void)
+{
+	struct dentry *root_dir = debugfs_create_dir("stackdepot", NULL);
+
+	debugfs_create_file("info", 0444, root_dir, NULL, &dfs_ops);
+	return 0;
+}
+__initcall(debugfs_init);


