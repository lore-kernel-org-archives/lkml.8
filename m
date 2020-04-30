Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171FDC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF88B2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OtKLuo67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgD3Qfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:35:36 -0400
Received: from mail.efficios.com ([167.114.26.124]:43716 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3Qff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:35:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E540228FB75;
        Thu, 30 Apr 2020 12:35:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z1GqY8BLFzv7; Thu, 30 Apr 2020 12:35:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9977C28F7CF;
        Thu, 30 Apr 2020 12:35:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9977C28F7CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588264534;
        bh=oP0ySd/C10g2du7jih56rgqzcsTpAP1agLKm0fyXMSg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OtKLuo67yS2RuQWnC379KkWAVdoX7xysKD2DDs9KBqsCM5y7ISSnJ+RfrUrWBXx8E
         WhkRh8+J3xXGLy/K9srCl4wwXcOgF0n1UjM+tr8/No/DvhC/GzjoIrD5wJQ3+SsBtw
         ikS0c641NEDSe509SeazXd8XfjdmnC2JqUa9g908q5phrsgll0TAiXbT9rXraZMiCt
         4NJtMGIM5Jy1EJLc6CJvWz6rq0JRm7GJMG0a41UXVwX04RLJ4P0J2csLFcq3gl6+uP
         vn/qDqP2UiuwtRIupwIjmUOGuBPgmwimRAyJKL6pK6UfcY+67YTHB9odtAcPNP8rTc
         Vcg5t07undrrQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n6ykwUjOdPE1; Thu, 30 Apr 2020 12:35:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 897CE290002;
        Thu, 30 Apr 2020 12:35:34 -0400 (EDT)
Date:   Thu, 30 Apr 2020 12:35:34 -0400 (EDT)
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
Message-ID: <1877450632.77955.1588264534446.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200430123034.5705cd47@gandalf.local.home>
References: <20200429054857.66e8e333@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de> <20200430145057.GB8135@suse.de> <2026887875.77814.1588260015439.JavaMail.zimbra@efficios.com> <20200430121627.682061e2@gandalf.local.home> <947455570.77870.1588263502669.JavaMail.zimbra@efficios.com> <20200430123034.5705cd47@gandalf.local.home>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: +PuMHowgGmPM1/VUMnVVDDjIrQWjJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 30, 2020, at 12:30 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 30 Apr 2020 12:18:22 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Apr 30, 2020, at 12:16 PM, rostedt rostedt@goodmis.org wrote:
>> 
>> > On Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> >   
>> >> > The right fix is to call vmalloc_sync_mappings() right after allocating
>> >> > tracing or perf buffers via v[zm]alloc().
>> >> 
>> >> Either right after allocation, or right before making the vmalloc'd data
>> >> structure visible to the instrumentation. In the case of the pid filter,
>> >> that would be the rcu_assign_pointer() which publishes the new pid filter
>> >> table.
>> >> 
>> >> As long as vmalloc_sync_mappings() is performed somewhere *between* allocation
>> >> and publishing the pointer for instrumentation, it's fine.
>> >> 
>> >> I'll let Steven decide on which approach works best for him.
>> > 
>> > As stated in the other email, I don't see it having anything to do with
>> > vmalloc, but with the per_cpu() allocation. I'll test this theory out by
>> > not even allocating the pid masks and touching the per cpu data at every
>> > event to see if it crashes.
>> 
>> As pointed out in my other email, per-cpu allocation uses vmalloc when
>> size > PAGE_SIZE.
> 
> And as I replied:
> 
>	buf->data = alloc_percpu(struct trace_array_cpu);
> 
> struct trace_array_cpu {
>	atomic_t		disabled;
>	void			*buffer_page;	/* ring buffer spare */
> 
>	unsigned long		entries;
>	unsigned long		saved_latency;
>	unsigned long		critical_start;
>	unsigned long		critical_end;
>	unsigned long		critical_sequence;
>	unsigned long		nice;
>	unsigned long		policy;
>	unsigned long		rt_priority;
>	unsigned long		skipped_entries;
>	u64			preempt_timestamp;
>	pid_t			pid;
>	kuid_t			uid;
>	char			comm[TASK_COMM_LEN];
> 
>	bool			ignore_pid;
> #ifdef CONFIG_FUNCTION_TRACER
>	bool			ftrace_ignore_pid;
> #endif
> };
> 
> That doesn't look bigger than PAGE_SIZE to me.

Let me point you to:

pcpu_alloc()
  calling pcpu_create_chunk()

which is then responsible for calling the underlying 
pcpu_mem_zalloc() which then uses vmalloc. So batching
those allocations can be responsible for using vmalloc'd
memory rather than kmalloc'd even though the allocation
size is smaller than 4kB.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
