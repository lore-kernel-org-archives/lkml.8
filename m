Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5E9C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC6C2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qR4RLWGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgEANf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:35:56 -0400
Received: from mail.efficios.com ([167.114.26.124]:58952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbgEANfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:35:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8D94C297E2D;
        Fri,  1 May 2020 09:35:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lALD4i1XGzXA; Fri,  1 May 2020 09:35:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0D649298074;
        Fri,  1 May 2020 09:35:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0D649298074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588340148;
        bh=9zgLlBvem0lrQo9AqW6gmK+0n639wii96EkbnjfVzQA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qR4RLWGlzWoyFbEw9BkjUvV/KhxWSoTPrvLDBvsdkv1L9XkgBHAlfcXVr2ikFf0Tc
         h0tvNM0GNaPSJ9RQymEyghGeSM/ZzakVF9uABhEF/gHuo1fhkYDl1iaeAuSHaA0+Ue
         8aY+WnTRrdPi8VRWOV5RkNcjbCEiEkSk03NYxHRibgJA8rs9cg8r0IHaapAIVeZZTC
         UVvP/BhyLvSvPZDn7XKxCfcxUAT2fsKIy7nS1X9bAuS4HKcHU9zBxc2CDaEA6CbJPr
         IhHYEfVI3F9l2fYTLcP5y5m+l8OYPBXm59uJVVUM1OBqO4/tq61qZfrWadshRUy3TH
         YOQo4gPR3De+g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S8aE3zyv-Z_P; Fri,  1 May 2020 09:35:48 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EDEC629806B;
        Fri,  1 May 2020 09:35:47 -0400 (EDT)
Date:   Fri, 1 May 2020 09:35:47 -0400 (EDT)
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
Message-ID: <908581092.79109.1588340147892.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200430223919.50861011@gandalf.local.home>
References: <20200429054857.66e8e333@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de> <20200430121136.6d7aeb22@gandalf.local.home> <20200430191434.GC8135@suse.de> <20200430211308.74a994dc@oasis.local.home> <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com> <20200430223919.50861011@gandalf.local.home>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: bQkSzwkFvspykBAdeX1ij+5/obehkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 30, 2020, at 10:39 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Apr 30, 2020, at 9:13 PM, rostedt rostedt@goodmis.org wrote:
>> 
>> > [ Joerg, sending again this time not just to you. (hit reply to sender
>> >  and not reply to all). Feel free to resend what you wrote before to this ]
>> > 
>> > On Thu, 30 Apr 2020 21:14:34 +0200
>> > Joerg Roedel <jroedel@suse.de> wrote:
>> >   
>> >> And alloc_percpu() calls down into pcpu_alloc(), which allocates new
>> >> percpu chunks using vmalloc() on x86. And there we are again in the
>> >> vmalloc area.
>> > 
>> > So after a vmalloc() is made, should the page tables be synced?
>> 
>> Why should it ? Usually, the page fault handler is able to resolve the
>> resulting minor page faults lazily.
>> 
>> > 
>> > This is a rather subtle bug, and I don't think it should be the caller of
>> > percpu_alloc() that needs to call vmalloc_sync_mappings().
>> 
>> Who said tracing was easy ? ;-)
> 
> But anyone can hook to a tracepoint, and then if they hook to one that is
> in the page fault handler, and they use vmalloc, they can lock up the
> machine.

True.

> 
>> 
>> > What's your suggestion for a fix?
>> 
>> I know the question is not addressed to me, but here are my 2 cents:
>> 
>> It's subtle because ftrace is tracing the page fault handler through
>> tracepoints. It would not make sense to slow down all vmalloc or
>> percpu_alloc() just because tracing recurses when tracing page faults.
> 
> What's so damn special about alloc_percpu()? It's definitely not a fast
> path. And it's not used often.

If it's not fastpath, then we might want to do this in pcpu_mem_zalloc()
which is used to allocate the percpu chunks:

static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
{
        if (WARN_ON_ONCE(!slab_is_available()))
                return NULL;

        if (size <= PAGE_SIZE) {
                return kzalloc(size, gfp);
        } else {
                void *p = __vmalloc(size, gfp | __GFP_ZERO, PAGE_KERNEL);
                vmalloc_sync_mappings();
                return p;
        }
}

However this would not solve the entire problem for vmap(), vmalloc() and
friends.

> 
>> 
>> I think the right approach to solve this is to call vmalloc_sync_mappings()
>> before any vmalloc'd memory ends up being observable by instrumentation.
>> This can be achieved by adding a vmalloc_sync_mappings call on tracepoint
>> registration like I proposed in my patchset a few week ago:
>> 
>> https://lore.kernel.org/r/20200409193543.18115-2-mathieu.desnoyers@efficios.com
>> 
>> The tracers just have to make sure they perform their vmalloc'd memory
>> allocation before registering the tracepoint which can touch it, else they
>> need to issue vmalloc_sync_mappings() on their own before making the
>> newly allocated memory observable by instrumentation.
>> 
>> This approach is not new: register_die_notifier() does exactly that today.
>> 
> 
> I'll give the answer I gave to Joerg when he replied to my accidental
> private (not public) email:
> 
> Or even my original patch would be better than having the generic tracing
> code understanding the intrinsic properties of vmalloc() and
> alloc_percpu() on x86_64. I really don't think it is wise to have:
> 
>	foo = alloc_percpu();
> 
>	/*
>	 * Because of some magic with the way alloc_percpu() works on
>	 * x86_64, we need to synchronize the pgd of all the tables,
>	 * otherwise the trace events that happen in x86_64 page fault
>	 * handlers can't cope with accessing the chance that a
>	 * alloc_percpu()'d memory might be touched in the page fault trace
>	 * event. Oh, and we need to audit all alloc_percpu() and vmalloc()
>	 * calls in tracing, because something might get triggered within a
>	 * page fault trace event!
>	 */
>	vmalloc_sync_mappings();
> 
> That would be exactly what I add as a comment if it were to be added in the
> generic tracing code.

Yeah, I've myself sprinkled vmalloc_sync_all() for years in LTTng to handle
these corner-cases. Note that module memory is vmalloc'd as well!

> 
> And we would need to audit any percpu alloc'd code in all tracing, or
> anything that might git hooked into something that hooks to the page fault
> trace point.

Indeed, tracing the page fault handler is really tricky exactly because
of minor faults vs vmalloc'd memory interactions.

> 
> Since this worked for a decade without this, I'm strongly against adding it
> in the generic code due to some issues with a single architecture.

I'm really OK with making all this more robust. I think it's however important
that we are careful not slowing down or adding extra memory overhead to
existing workloads as we do this, especially if the only motivation is
to make tracing marginally simpler.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
