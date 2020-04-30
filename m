Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761A4C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BE4207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgD3TOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:14:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:43872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD3TOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:14:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3C4DABC2;
        Thu, 30 Apr 2020 19:14:36 +0000 (UTC)
Date:   Thu, 30 Apr 2020 21:14:34 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200430191434.GC8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200430141120.GA8135@suse.de>
 <20200430121136.6d7aeb22@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430121136.6d7aeb22@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:11:36PM -0400, Steven Rostedt wrote:
> bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
> {
> 	struct trace_array *tr = trace_file->tr;
> 	struct trace_array_cpu *data;
> 	struct trace_pid_list *no_pid_list;
> 	struct trace_pid_list *pid_list;
> 
> 	pid_list = rcu_dereference_raw(tr->filtered_pids);
> 	no_pid_list = rcu_dereference_raw(tr->filtered_no_pids);
> 
> 	if (!pid_list && !no_pid_list)
> 		return false;
> 
> 	data = this_cpu_ptr(tr->array_buffer.data);
> 
> 	return data->ignore_pid;
> }
>
> [...]
> 
> tl;dr; It's not an issue with the vmalloc, it's an issue with per_cpu
> allocations!

Yes, looks like you are right, it faults on the return statement, so the
data-pointer seems not to be mapped. I looked at another instance:

The trapping instruction is:

	movzbl 0x7c(%rax),%eax

Which is a pointer-dereference, with %rax=0xffffe8ffffccc870. The 'data'
pointer is allocated with alloc_percpu().

And alloc_percpu() calls down into pcpu_alloc(), which allocates new
percpu chunks using vmalloc() on x86. And there we are again in the
vmalloc area.

Regards,

	Joerg
