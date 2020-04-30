Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D756C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64091208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgD3Q0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgD3Q0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:26:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C13E20873;
        Thu, 30 Apr 2020 16:26:00 +0000 (UTC)
Date:   Thu, 30 Apr 2020 12:25:58 -0400
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
Message-ID: <20200430122558.406c9755@gandalf.local.home>
In-Reply-To: <505666080.77869.1588263380070.JavaMail.zimbra@efficios.com>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200430141120.GA8135@suse.de>
        <20200430121136.6d7aeb22@gandalf.local.home>
        <505666080.77869.1588263380070.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 12:16:20 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 30, 2020, at 12:11 PM, rostedt rostedt@goodmis.org wrote:
> 
> > On Thu, 30 Apr 2020 16:11:21 +0200
> > Joerg Roedel <jroedel@suse.de> wrote:
> >   
> >> Hi,
> >> 
> >> On Wed, Apr 29, 2020 at 10:07:31AM -0400, Steven Rostedt wrote:  
> >> > Talking with Mathieu about this on IRC, he pointed out that my code does
> >> > have a vzalloc() that is called:
> >> > 
> >> > in trace_pid_write()
> >> > 
> >> > 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
> >> > 
> >> > This is done when -P1,2 is on the trace-cmd command line.  
> >> 
> >> Okay, tracked it down, some instrumentation in the page-fault and
> >> double-fault handler gave me the stack-traces. Here is what happens:
> >> 
> >> As already pointed out, it all happens because of page-faults on the
> >> vzalloc'ed pid bitmap. It starts with this stack-trace:
> >> 
> >>  RIP: 0010:trace_event_ignore_this_pid+0x23/0x30  
> > 
> > Interesting. Because that function is this:
> > 
> > bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
> > {
> >	struct trace_array *tr = trace_file->tr;
> >	struct trace_array_cpu *data;
> >	struct trace_pid_list *no_pid_list;
> >	struct trace_pid_list *pid_list;
> > 
> >	pid_list = rcu_dereference_raw(tr->filtered_pids);
> >	no_pid_list = rcu_dereference_raw(tr->filtered_no_pids);
> > 
> >	if (!pid_list && !no_pid_list)
> >		return false;
> > 
> >	data = this_cpu_ptr(tr->array_buffer.data);
> > 
> >	return data->ignore_pid;
> > }
> > 
> > Where it only sees if the pid masks exist. That is, it looks to see if
> > there's pointers to them, it doesn't actually touch the vmalloc'd area.
> > This check is to handle a race between allocating and deallocating the
> > buffers and setting the ignore_pid bit. The reading of these arrays is done
> > at sched_switch time, which sets or clears the ignore_pid field.
> > 
> > That said, since this only happens on buffer instances (it does not trigger
> > on the top level instance, which uses the same code for the pid masks)
> > 
> > Could this possibly be for the tr->array_buffer.data, which is allocated
> > with:
> > 
> > allocate_trace_buffer() {
> >	[..]
> >	buf->data = alloc_percpu(struct trace_array_cpu);
> > 
> > That is, the bug isn't the vmalloc being a problem, but perhaps the per_cpu
> > allocation. This would explain why this crashes with the buffer instance
> > and not with the top level instance. If it was related to the pid masks,
> > then it would trigger for either (because they act the same in allocating
> > at time of use). But when an instance is made, the tr->array_buffer.data is
> > created. Which for the top level happens at boot up and the pages would
> > have been synced long ago. But for a newly created instance, this happens
> > just before its used. This could possibly explain why it's not a problem
> > when doing it manually by hand, because the time between creating the
> > instance, and the time to start and stop the tracing, is long enough for
> > something to sync them page tables.
> > 
> > tl;dr; It's not an issue with the vmalloc, it's an issue with per_cpu
> > allocations!  
> 
> Did I mention that alloc_percpu uses:
> 
> static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
> {
>         if (WARN_ON_ONCE(!slab_is_available()))
>                 return NULL;
> 
>         if (size <= PAGE_SIZE)
>                 return kzalloc(size, gfp);
>         else
>                 return __vmalloc(size, gfp | __GFP_ZERO, PAGE_KERNEL);
> }
> 
> So yeah, it's vmalloc'd memory when size > PAGE_SIZE.
> 

I certainly hope that struct trace_array_cpu is not bigger than PAGE_SIZE!

-- Steve
