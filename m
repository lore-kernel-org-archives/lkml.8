Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914EAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A101206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lTzVnsTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgEDP2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:28:48 -0400
Received: from mail.efficios.com ([167.114.26.124]:59166 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgEDP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:28:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ED7E0292F0B;
        Mon,  4 May 2020 11:28:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id c2lNyzY5r39f; Mon,  4 May 2020 11:28:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8D6DA292ACF;
        Mon,  4 May 2020 11:28:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8D6DA292ACF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588606126;
        bh=HVoeTAS1zFD+nqyGkFZRP8VbhfOZ9R9nv2gX4jekaQQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lTzVnsTR9A5Y35+oTuv6jQ3GMdgF8yTEi9e3wFwJyr4DP1ijoJUwCAe5gNldkBOU8
         pKFx38WmSk6CTUly6XkUeSHhW7KuLmbgxK+tWyiU/0lqAEShRODQbn9nhbK0Zca4Eg
         ErS2RtyKVtPNS/kvIFoCBNswY7fC62+2vj2j3DNhEOu63O21ZD6CHtJNRk01eNjdRZ
         ILxKfdRPjEI9cFsFZvgRDNC7osipafGyCN0diJ0IZxfi8XTk+HC+6D7rxHbGmpKNwE
         ZmaGhV3Y+5YnNwbpkYvlHmsWTvizZDNO9RjGe8uP/oxBhIbh1UnScFK09im8+hd7+g
         vcuUKvKP57Akw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j8ZHVOw8rOlj; Mon,  4 May 2020 11:28:46 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7B556292E0B;
        Mon,  4 May 2020 11:28:46 -0400 (EDT)
Date:   Mon, 4 May 2020 11:28:46 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     rostedt <rostedt@goodmis.org>,
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
Message-ID: <99290786.82178.1588606126392.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200504151236.GI8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home> <20200430141120.GA8135@suse.de> <20200430121136.6d7aeb22@gandalf.local.home> <20200430191434.GC8135@suse.de> <20200430211308.74a994dc@oasis.local.home> <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com> <20200430223919.50861011@gandalf.local.home> <20200504151236.GI8135@suse.de>
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: percpu: Sync vmalloc mappings in pcpu_alloc() and free_percpu()
Thread-Index: 1U6piaX2V3pxdrDVcz9v3OVLS55MpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 4, 2020, at 11:12 AM, Joerg Roedel jroedel@suse.de wrote:

> On Thu, Apr 30, 2020 at 10:39:19PM -0400, Steven Rostedt wrote:
>> What's so damn special about alloc_percpu()? It's definitely not a fast
>> path. And it's not used often.
> 
> Okay, I fixed it in the percpu code. It is definitly not a nice
> solution, but having to call vmalloc_sync_mappings/unmappings() is not a
> nice solution at any place in the code. Here is the patch which fixes
> this issue for me. I am also not sure what to put in the Fixes tag, as
> it is related to tracing code accessing per-cpu data from the page-fault
> handler, not sure when this got introduced. Maybe someone else can
> provide a meaningful Fixes- or stable tag.
> 
> I also have an idea in mind how to make this all more robust and get rid
> of the vmalloc_sync_mappings/unmappings() interface, will show more when
> I know it works the way I think it does.
> 
> Regards,
> 
>	Joerg
> 
> From c616a9a09499f9c9d682775767d3de7db81fb2ed Mon Sep 17 00:00:00 2001
> From: Joerg Roedel <jroedel@suse.de>
> Date: Mon, 4 May 2020 17:11:41 +0200
> Subject: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
> free_percpu()
> 
> Sync the vmalloc mappings for all page-tables in the system when
> allocating and freeing per-cpu memory. This is necessary for
> architectures which use page-faults on vmalloc areas.
> 
> The page-fault handlers accesses per-cpu data when tracing is enabled,
> and fauling again in the page-fault handler on a vmalloc'ed per-cpu area
> will result in a recursive fault.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> mm/percpu.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index d7e3bc649f4e..6ab035bc6977 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1710,6 +1710,20 @@ static void __percpu *pcpu_alloc(size_t size, size_t
> align, bool reserved,
> 	trace_percpu_alloc_percpu(reserved, is_atomic, size, align,
> 			chunk->base_addr, off, ptr);
> 
> +	/*
> +	 * The per-cpu buffers might be allocated in the vmalloc area of the
> +	 * address space. When the architecture allows faulting on the vmalloc
> +	 * area and the memory allocated here is accessed in the page-fault
> +	 * handler, the vmalloc area fault may be recursive and could never be
> +	 * resolved.
> +	 * This happens for example in the tracing code which allocates per-cpu
> +	 * and accesses them when tracing page-faults.
> +	 * To prevent this, make sure the per-cpu buffers allocated here are
> +	 * mapped in all PGDs so that the page-fault handler will never fault
> +	 * again on them.
> +	 */
> +	vmalloc_sync_mappings();

Placing this here is inefficient. It syncs mappings for each percpu allocation.
I would recommend moving it right after __vmalloc() is called to allocate the
underlying memory chunk instead:

static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
{
        if (WARN_ON_ONCE(!slab_is_available()))
                return NULL;

        if (size <= PAGE_SIZE)
                return kzalloc(size, gfp);
        else {
                void *p = __vmalloc(size, gfp | __GFP_ZERO, PAGE_KERNEL);
                /* Add comments here ... */
                vmalloc_sync_mappings();
                return p;
        }
}

> +
> 	return ptr;
> 
> fail_unlock:
> @@ -1958,6 +1972,12 @@ void free_percpu(void __percpu *ptr)
> 
> 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
> 
> +	/*
> +	 * See comment at the vmalloc_sync_mappings() call in pcpu_alloc() for
> +	 * why this is necessary.
> +	 */
> +	vmalloc_sync_unmappings();

I wonder why we'd ever need to explicitly invoke vmalloc_sync_unmappings().
Leaving a stale PTE mapping in place to be lazily unmapped does not seem to
hurt even the tracing use-cases. Why add this call to vmalloc_sync_unmappings()
at all ?

*If* this ends up being needed, it should be moved to:

static void pcpu_mem_free(void *ptr)
{
        /* Add comments here... */
        if (is_vmalloc_addr(ptr))
                vmalloc_sync_unmappings();
        kvfree(ptr);
}

So it is only called before the underlying vmalloc'd chunk is freed, rather than
at each and every percpu free.

Thanks,

Mathieu


> +
> 	spin_unlock_irqrestore(&pcpu_lock, flags);
> 
> 	if (need_balance)
> --
> 2.12.3

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
