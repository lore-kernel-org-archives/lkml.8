Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD09C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ACE20757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oXbeAeLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgEANWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:22:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:55422 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgEANWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:22:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ABCB6298434;
        Fri,  1 May 2020 09:22:36 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iL4cIEka1-fY; Fri,  1 May 2020 09:22:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1AD36298246;
        Fri,  1 May 2020 09:22:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1AD36298246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588339356;
        bh=LEmVs61FhgzGZXAKl/rwYmLQxleDl27Bo/IyH/5oiLQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oXbeAeLBCv9yFZ1+LLaZWmXvqE7Wfdd+sc37/DutUSmIM7NNvPiRoTaml2H5aR6E5
         X7oEMpi96M47OstEm05nLiVa5/1kgwmqrWDL68EmyKWu3mTHobxl7SW34KV+ZV1V+m
         QJCNUhDlEl3HRm9eYuQJAKkvz678KAjrrpm7lLk5YTwZYKesUvLW5NJQ/leeAWNQnF
         8AOq1MT+2eu3pw/uYzlWMr16VTMT9Jhz2baK7lID3nbiEFG7jHwGO/Eirm6dIpqrWj
         7ZipoI6uhhS2AaPcx1m8BNZWM7uZZeCysJINpjafMXWUY1yIzx08s9gVRqSHI7N/7a
         fN+DAXTi9MHXg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WNF6oUzLq71a; Fri,  1 May 2020 09:22:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E9D9B298245;
        Fri,  1 May 2020 09:22:35 -0400 (EDT)
Date:   Fri, 1 May 2020 09:22:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
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
Message-ID: <2063204938.79085.1588339355917.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200501002018.76f1e4b6@gandalf.local.home>
References: <20200429054857.66e8e333@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de> <20200430121136.6d7aeb22@gandalf.local.home> <20200430191434.GC8135@suse.de> <20200430211308.74a994dc@oasis.local.home> <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com> <20200501002018.76f1e4b6@gandalf.local.home>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: +WJIQIn3E4E6JPKVFCgT+1kFaeVmhg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 1, 2020, at 12:20 AM, rostedt rostedt@goodmis.org wrote:

> On Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> The tracers just have to make sure they perform their vmalloc'd memory
>> allocation before registering the tracepoint which can touch it, else they
>> need to issue vmalloc_sync_mappings() on their own before making the
>> newly allocated memory observable by instrumentation.
> 
> What gets me is that I added the patch below (which adds a
> vmalloc_sync_mappings() just after the alloc_percpu()), but I also recorded
> all instances of vmalloc() with a stackdump, and I get this:
> 
>          colord-1673  [002] ....    84.764804: __vmalloc_node_range+0x5/0x2c0: vmalloc
>          called here
>          colord-1673  [002] ....    84.764807: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => module_alloc+0x7e/0xd0
> => bpf_jit_binary_alloc+0x70/0x110
> => bpf_int_jit_compile+0x139/0x40a
> => bpf_prog_select_runtime+0xa3/0x120
> => bpf_prepare_filter+0x533/0x5a0
> => sk_attach_filter+0x13/0x50
> => sock_setsockopt+0xd2f/0xf90
> => __sys_setsockopt+0x18a/0x1a0
> => __x64_sys_setsockopt+0x20/0x30
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> 
> 
> [ the above is from before the tracing started ]
> 
>       trace-cmd-1687  [002] ....   103.908850: __vmalloc_node_range+0x5/0x2c0: vmalloc
>       called here
>       trace-cmd-1687  [002] ....   103.908856: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => vzalloc+0x48/0x50
> => trace_pid_write+0x23d/0x2b0
> => pid_write.isra.62+0xd1/0x2f0
> => vfs_write+0xa8/0x1b0
> => ksys_write+0x67/0xe0
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
>       trace-cmd-1697  [003] ....   104.088950: __vmalloc_node_range+0x5/0x2c0: vmalloc
>       called here
>       trace-cmd-1697  [003] ....   104.088954: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => vzalloc+0x48/0x50
> => trace_pid_write+0x23d/0x2b0
> => pid_write.isra.62+0xd1/0x2f0
> => vfs_write+0xa8/0x1b0
> => ksys_write+0x67/0xe0
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
>       trace-cmd-1697  [003] ....   104.089666: __vmalloc_node_range+0x5/0x2c0: vmalloc
>       called here
>       trace-cmd-1697  [003] ....   104.089669: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => vzalloc+0x48/0x50
> => trace_pid_write+0xc1/0x2b0
> => pid_write.isra.62+0xd1/0x2f0
> => vfs_write+0xa8/0x1b0
> => ksys_write+0x67/0xe0
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
>       trace-cmd-1697  [003] ....   104.098920: __vmalloc_node_range+0x5/0x2c0: vmalloc
>       called here
>       trace-cmd-1697  [003] ....   104.098924: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => vzalloc+0x48/0x50
> => trace_pid_write+0xc1/0x2b0
> => pid_write.isra.62+0xd1/0x2f0
> => vfs_write+0xa8/0x1b0
> => ksys_write+0x67/0xe0
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
>       trace-cmd-1697  [003] ....   104.114518: __vmalloc_node_range+0x5/0x2c0: vmalloc
>       called here
>       trace-cmd-1697  [003] ....   104.114520: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => vzalloc+0x48/0x50
> => trace_pid_write+0xc1/0x2b0
> => pid_write.isra.62+0xd1/0x2f0
> => vfs_write+0xa8/0x1b0
> => ksys_write+0x67/0xe0
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
>       trace-cmd-1697  [003] ....   104.130705: __vmalloc_node_range+0x5/0x2c0: vmalloc
>       called here
>       trace-cmd-1697  [003] ....   104.130707: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => vzalloc+0x48/0x50
> => trace_pid_write+0x23d/0x2b0
> => event_pid_write.isra.30+0x21b/0x3b0
> => vfs_write+0xa8/0x1b0
> => ksys_write+0x67/0xe0
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
>       trace-cmd-1687  [001] ....   106.000510: __vmalloc_node_range+0x5/0x2c0: vmalloc
>       called here
>       trace-cmd-1687  [001] ....   106.000514: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => vzalloc+0x48/0x50
> => trace_pid_write+0x23d/0x2b0
> => pid_write.isra.62+0xd1/0x2f0
> => vfs_write+0xa8/0x1b0
> => ksys_write+0x67/0xe0
> => do_syscall_64+0x60/0x230
> => entry_SYSCALL_64_after_hwframe+0x49/0xb3
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> => 0
> 
> The above is the calls to adding pids to set_event_pid. (I see I should
> probably make that code a bit more efficient, it calls the vmalloc code a
> bit too much).
> 
> But what is missing, is the call to vmalloc from alloc_percpu(). In fact, I
> put in printks in the vmalloc() that's in alloc_percpu() and it doesn't
> trigger from the tracing code, and it does show up in my trace from other
> areas of the kernel:
> 
>     kworker/1:3-204   [001] ....    42.888340: __vmalloc_node_range+0x5/0x2c0:
>     vmalloc called here
>     kworker/1:3-204   [001] ....    42.888342: <stack trace>
> => __ftrace_trace_stack+0x161/0x1a0
> => __vmalloc_node_range+0x4d/0x2c0
> => __vmalloc+0x30/0x40
> => pcpu_create_chunk+0x77/0x220
> => pcpu_balance_workfn+0x407/0x650
> => process_one_work+0x25e/0x5c0
> => worker_thread+0x30/0x380
> => kthread+0x139/0x160
> => ret_from_fork+0x3a/0x50
> 
> So I'm still not 100% sure why the percpu data is causing a problem?

I suspect that this is simply because alloc_percpu is calling __vmalloc()
to allocate a "chunk" before you even started tracing, possibly early at
boot. Then it happens that your own alloc_percpu allocation fits in an
already vmallocated area which is still "free".

Thanks,

Mathieu

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8d2b98812625..10e4970a150c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8486,6 +8486,7 @@ allocate_trace_buffer(struct trace_array *tr, struct
> array_buffer *buf, int size
> 		return -ENOMEM;
> 
> 	buf->data = alloc_percpu(struct trace_array_cpu);
> +	vmalloc_sync_mappings();
> 	if (!buf->data) {
> 		ring_buffer_free(buf->buffer);
> 		buf->buffer = NULL;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9a8227afa073..489cf0620edc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2543,6 +2543,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned
> long align,
> 	void *addr;
> 	unsigned long real_size = size;
> 
> +	trace_printk("vmalloc called here\n");
> +	trace_dump_stack(0);
> 	size = PAGE_ALIGN(size);
> 	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
>  		goto fail;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
