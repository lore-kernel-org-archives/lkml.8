Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A92C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 04:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E4720857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 04:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEAEUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 00:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgEAEUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 00:20:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAC920836;
        Fri,  1 May 2020 04:20:20 +0000 (UTC)
Date:   Fri, 1 May 2020 00:20:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
Message-ID: <20200501002018.76f1e4b6@gandalf.local.home>
In-Reply-To: <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200430141120.GA8135@suse.de>
        <20200430121136.6d7aeb22@gandalf.local.home>
        <20200430191434.GC8135@suse.de>
        <20200430211308.74a994dc@oasis.local.home>
        <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The tracers just have to make sure they perform their vmalloc'd memory
> allocation before registering the tracepoint which can touch it, else they
> need to issue vmalloc_sync_mappings() on their own before making the
> newly allocated memory observable by instrumentation.

What gets me is that I added the patch below (which adds a
vmalloc_sync_mappings() just after the alloc_percpu()), but I also recorded
all instances of vmalloc() with a stackdump, and I get this:

          colord-1673  [002] ....    84.764804: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
          colord-1673  [002] ....    84.764807: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => module_alloc+0x7e/0xd0
 => bpf_jit_binary_alloc+0x70/0x110
 => bpf_int_jit_compile+0x139/0x40a
 => bpf_prog_select_runtime+0xa3/0x120
 => bpf_prepare_filter+0x533/0x5a0
 => sk_attach_filter+0x13/0x50
 => sock_setsockopt+0xd2f/0xf90
 => __sys_setsockopt+0x18a/0x1a0
 => __x64_sys_setsockopt+0x20/0x30
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0


[ the above is from before the tracing started ]

       trace-cmd-1687  [002] ....   103.908850: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
       trace-cmd-1687  [002] ....   103.908856: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => vzalloc+0x48/0x50
 => trace_pid_write+0x23d/0x2b0
 => pid_write.isra.62+0xd1/0x2f0
 => vfs_write+0xa8/0x1b0
 => ksys_write+0x67/0xe0
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
       trace-cmd-1697  [003] ....   104.088950: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
       trace-cmd-1697  [003] ....   104.088954: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => vzalloc+0x48/0x50
 => trace_pid_write+0x23d/0x2b0
 => pid_write.isra.62+0xd1/0x2f0
 => vfs_write+0xa8/0x1b0
 => ksys_write+0x67/0xe0
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
       trace-cmd-1697  [003] ....   104.089666: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
       trace-cmd-1697  [003] ....   104.089669: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => vzalloc+0x48/0x50
 => trace_pid_write+0xc1/0x2b0
 => pid_write.isra.62+0xd1/0x2f0
 => vfs_write+0xa8/0x1b0
 => ksys_write+0x67/0xe0
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
       trace-cmd-1697  [003] ....   104.098920: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
       trace-cmd-1697  [003] ....   104.098924: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => vzalloc+0x48/0x50
 => trace_pid_write+0xc1/0x2b0
 => pid_write.isra.62+0xd1/0x2f0
 => vfs_write+0xa8/0x1b0
 => ksys_write+0x67/0xe0
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
       trace-cmd-1697  [003] ....   104.114518: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
       trace-cmd-1697  [003] ....   104.114520: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => vzalloc+0x48/0x50
 => trace_pid_write+0xc1/0x2b0
 => pid_write.isra.62+0xd1/0x2f0
 => vfs_write+0xa8/0x1b0
 => ksys_write+0x67/0xe0
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
       trace-cmd-1697  [003] ....   104.130705: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
       trace-cmd-1697  [003] ....   104.130707: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => vzalloc+0x48/0x50
 => trace_pid_write+0x23d/0x2b0
 => event_pid_write.isra.30+0x21b/0x3b0
 => vfs_write+0xa8/0x1b0
 => ksys_write+0x67/0xe0
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
       trace-cmd-1687  [001] ....   106.000510: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
       trace-cmd-1687  [001] ....   106.000514: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => vzalloc+0x48/0x50
 => trace_pid_write+0x23d/0x2b0
 => pid_write.isra.62+0xd1/0x2f0
 => vfs_write+0xa8/0x1b0
 => ksys_write+0x67/0xe0
 => do_syscall_64+0x60/0x230
 => entry_SYSCALL_64_after_hwframe+0x49/0xb3
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0

The above is the calls to adding pids to set_event_pid. (I see I should
probably make that code a bit more efficient, it calls the vmalloc code a
bit too much).

But what is missing, is the call to vmalloc from alloc_percpu(). In fact, I
put in printks in the vmalloc() that's in alloc_percpu() and it doesn't
trigger from the tracing code, and it does show up in my trace from other
areas of the kernel:

     kworker/1:3-204   [001] ....    42.888340: __vmalloc_node_range+0x5/0x2c0: vmalloc called here
     kworker/1:3-204   [001] ....    42.888342: <stack trace>
 => __ftrace_trace_stack+0x161/0x1a0
 => __vmalloc_node_range+0x4d/0x2c0
 => __vmalloc+0x30/0x40
 => pcpu_create_chunk+0x77/0x220
 => pcpu_balance_workfn+0x407/0x650
 => process_one_work+0x25e/0x5c0
 => worker_thread+0x30/0x380
 => kthread+0x139/0x160
 => ret_from_fork+0x3a/0x50

So I'm still not 100% sure why the percpu data is causing a problem?

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d2b98812625..10e4970a150c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8486,6 +8486,7 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 		return -ENOMEM;
 
 	buf->data = alloc_percpu(struct trace_array_cpu);
+	vmalloc_sync_mappings();
 	if (!buf->data) {
 		ring_buffer_free(buf->buffer);
 		buf->buffer = NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9a8227afa073..489cf0620edc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2543,6 +2543,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	void *addr;
 	unsigned long real_size = size;
 
+	trace_printk("vmalloc called here\n");
+	trace_dump_stack(0);
 	size = PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
 		goto fail;
