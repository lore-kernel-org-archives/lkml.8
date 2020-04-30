Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC65F20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HGgxy6OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgD3QQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:16:22 -0400
Received: from mail.efficios.com ([167.114.26.124]:38382 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgD3QQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:16:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8853028FB2F;
        Thu, 30 Apr 2020 12:16:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xDaO_UPW64z2; Thu, 30 Apr 2020 12:16:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2862728FB2E;
        Thu, 30 Apr 2020 12:16:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2862728FB2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588263380;
        bh=3peYxHoeMxttyPs/kK0oeQFnIA8w0ML3Z5mFQwUuuw4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HGgxy6OFkI+B2RtYLYDdQuTTa12hQjnYMjWP4XHHzt99nrJfOJKd7p/4232pNS2M7
         BCjUTQ8ggo2ws08s2w/ThMutUQmT2qdsOhSfz1qROwCzDm/ZCCUQLAfXAC3i1RoNAY
         fvhCZ8MprAIwkattoi3Vl09m7b3e3DUtVP659pFiHRhIce9mu7yxaA+WpxWbcm3SRx
         Va3Wyw3OSBlDA2mcoJJpfMV8jbqwDnJhJWBvyANajN+efL1gMzF/UPaL9wnRcL6x18
         30tgT0g6kcMUCk8rIUSn2WvfY75abPj9OgNkEtW7lRZ8VZvsV3KWPoqyp2lw8ZL7vt
         okhQiAZIln0XQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cVUp0jkXj21a; Thu, 30 Apr 2020 12:16:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1614F28F79B;
        Thu, 30 Apr 2020 12:16:20 -0400 (EDT)
Date:   Thu, 30 Apr 2020 12:16:20 -0400 (EDT)
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
Message-ID: <505666080.77869.1588263380070.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200430121136.6d7aeb22@gandalf.local.home>
References: <20200429054857.66e8e333@oasis.local.home> <20200429105941.GQ30814@suse.de> <20200429082854.6e1796b5@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de> <20200430121136.6d7aeb22@gandalf.local.home>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: lAOrEjXtq/pzs5xj09aTYCikDgN7cA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 30, 2020, at 12:11 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 30 Apr 2020 16:11:21 +0200
> Joerg Roedel <jroedel@suse.de> wrote:
> 
>> Hi,
>> 
>> On Wed, Apr 29, 2020 at 10:07:31AM -0400, Steven Rostedt wrote:
>> > Talking with Mathieu about this on IRC, he pointed out that my code does
>> > have a vzalloc() that is called:
>> > 
>> > in trace_pid_write()
>> > 
>> > 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
>> > 
>> > This is done when -P1,2 is on the trace-cmd command line.
>> 
>> Okay, tracked it down, some instrumentation in the page-fault and
>> double-fault handler gave me the stack-traces. Here is what happens:
>> 
>> As already pointed out, it all happens because of page-faults on the
>> vzalloc'ed pid bitmap. It starts with this stack-trace:
>> 
>>  RIP: 0010:trace_event_ignore_this_pid+0x23/0x30
> 
> Interesting. Because that function is this:
> 
> bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
> {
>	struct trace_array *tr = trace_file->tr;
>	struct trace_array_cpu *data;
>	struct trace_pid_list *no_pid_list;
>	struct trace_pid_list *pid_list;
> 
>	pid_list = rcu_dereference_raw(tr->filtered_pids);
>	no_pid_list = rcu_dereference_raw(tr->filtered_no_pids);
> 
>	if (!pid_list && !no_pid_list)
>		return false;
> 
>	data = this_cpu_ptr(tr->array_buffer.data);
> 
>	return data->ignore_pid;
> }
> 
> Where it only sees if the pid masks exist. That is, it looks to see if
> there's pointers to them, it doesn't actually touch the vmalloc'd area.
> This check is to handle a race between allocating and deallocating the
> buffers and setting the ignore_pid bit. The reading of these arrays is done
> at sched_switch time, which sets or clears the ignore_pid field.
> 
> That said, since this only happens on buffer instances (it does not trigger
> on the top level instance, which uses the same code for the pid masks)
> 
> Could this possibly be for the tr->array_buffer.data, which is allocated
> with:
> 
> allocate_trace_buffer() {
>	[..]
>	buf->data = alloc_percpu(struct trace_array_cpu);
> 
> That is, the bug isn't the vmalloc being a problem, but perhaps the per_cpu
> allocation. This would explain why this crashes with the buffer instance
> and not with the top level instance. If it was related to the pid masks,
> then it would trigger for either (because they act the same in allocating
> at time of use). But when an instance is made, the tr->array_buffer.data is
> created. Which for the top level happens at boot up and the pages would
> have been synced long ago. But for a newly created instance, this happens
> just before its used. This could possibly explain why it's not a problem
> when doing it manually by hand, because the time between creating the
> instance, and the time to start and stop the tracing, is long enough for
> something to sync them page tables.
> 
> tl;dr; It's not an issue with the vmalloc, it's an issue with per_cpu
> allocations!

Did I mention that alloc_percpu uses:

static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
{
        if (WARN_ON_ONCE(!slab_is_available()))
                return NULL;

        if (size <= PAGE_SIZE)
                return kzalloc(size, gfp);
        else
                return __vmalloc(size, gfp | __GFP_ZERO, PAGE_KERNEL);
}

So yeah, it's vmalloc'd memory when size > PAGE_SIZE.

Thanks,

Mathieu




-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
