Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1FFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778DE20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCML0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:26:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgCML0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:26:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9FFD9AAC7;
        Fri, 13 Mar 2020 11:25:58 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/2] mm: mmap: add trace point of vm_unmapped_area
To:     Jaewon Kim <jaewon31.kim@samsung.com>, willy@infradead.org,
        walken@google.com, bp@suse.de, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Steven Rostedt <srostedt@vmware.com>
References: <20200313011420.15995-1-jaewon31.kim@samsung.com>
 <CGME20200313011430epcas1p436a6c02a262debcd755f3e1378331764@epcas1p4.samsung.com>
 <20200313011420.15995-3-jaewon31.kim@samsung.com>
Message-ID: <66137719-aa4d-ac40-f167-3bcb38f092db@suse.cz>
Date:   Fri, 13 Mar 2020 12:25:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313011420.15995-3-jaewon31.kim@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 2:14 AM, Jaewon Kim wrote:
> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
> Virtual memory space shortage of a task on mmap is reported to userspace
> as -ENOMEM. It can be confused as physical memory shortage of overall
> system.
> 
> The vm_unmapped_area can be called to by some drivers or other kernel
> core system like filesystem. In my platform, GPU driver calls to
> vm_unmapped_area and the driver returns -ENOMEM even in GPU side
> shortage. It can be hard to distinguish which code layer returns the
> -ENOMEM.
> 
> Create mmap trace file and add trace point of vm_unmapped_area.
> 
> i.e.)
> 265.214275: vm_unmapped_area: addr=fffffffffffffff4 err=-12 tvm=0xffb08 flags=0x1 len=0x100000 lo=0x8000 hi=0xf7182000 mask=0x0 ofs=0x22
> 265.214276: vm_unmapped_area: addr=fffffffffffffff4 err=-12 tvm=0xffb08 flags=0x0 len=0x100000 lo=0x40000000 hi=0xfffff000 mask=0x0 ofs=0x22

I think it's nicer to print addr as 0 if it was in fact an error.
Also "tvm" is cryptic, I would just use total_vm?

> 510.827472: vm_unmapped_area: addr=7377060000 err=0 tvm=0x262f flags=0x1 len=0x7f000 lo=0x8000 hi=0x73795f7000 mask=0x0 ofs=0x22
> 510.827668: vm_unmapped_area: addr=73794d1000 err=0 tvm=0x25cc flags=0x1 len=0x1000 lo=0x8000 hi=0x73795f7000 mask=0x0 ofs=0x22
> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  include/trace/events/mmap.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/mmap.c                   | 12 +++++++++--
>  2 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 include/trace/events/mmap.h
> 
> diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> new file mode 100644
> index 000000000000..a51dd8af6f8c
> --- /dev/null
> +++ b/include/trace/events/mmap.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM mmap
> +
> +#if !defined(_TRACE_MMAP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MMAP_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(vm_unmapped_area,
> +
> +	TP_PROTO(unsigned long addr, struct vm_unmapped_area_info *info),
> +
> +	TP_ARGS(addr, info),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long,	addr)
> +		__field(unsigned long,	error)

That seems wasteful to store both, coming from the same value.

> +		__field(unsigned long,	total_vm)
> +		__field(unsigned long,	flags)
> +		__field(unsigned long,	length)
> +		__field(unsigned long,	low_limit)
> +		__field(unsigned long,	high_limit)
> +		__field(unsigned long,	align_mask)
> +		__field(unsigned long,	align_offset)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->addr = addr;
> +		if (IS_ERR_VALUE(addr))
> +			__entry->error = addr;
> +		else
> +			__entry->error = 0;

fast_assign should be also as fast as possible, i.e. avoid these decision, just
store addr...

> +		__entry->total_vm = current->mm->total_vm;
> +		__entry->flags = info->flags;
> +		__entry->length = info->length;
> +		__entry->low_limit = info->low_limit;
> +		__entry->high_limit = info->high_limit;
> +		__entry->align_mask = info->align_mask;
> +		__entry->align_offset = info->align_offset;
> +	),
> +
> +	TP_printk("addr=%lx err=%ld tvm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
> +		__entry->addr, __entry->error, __entry->total_vm,

... and only here do the decisions if you print addr as zero and err as non-zero,
or vice versa. Something like the patch at the end of the e-mail.
Except then /sys/kernel/debug/tracing/events/mmap/vm_unmapped_area/format contains:

print fmt: "addr=%lx err=%ld tvm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx
", __builtin_expect(!!((unsigned long)(void *)(REC->addr) >= (unsigned long)-4095), 0) ? 0 : REC->addr, __builtin_expect(!!((unsigned long)(void *)(REC->addr) >= (unsigned long)-4095), 0) ? REC->addr : 0, REC->total_vm, REC->flags, REC->length, REC->low_limit, REC->high_limit, REC->align_mask, REC->align_offset

and trace-cmd doesn't like it:

           sleep-381   [001]    93.434157: vm_unmapped_area:     [FAILED TO PARSE] addr=0x7f7f32c47000 total_vm=0x2a flags=0x1 length=0x2d000 low_limit=0x1000 high_limit=0x7f7f32c74000 align_mask=0x0 align_offset=0x0

CC Steven, any idea? Does it not like the __builtin_epect, i.e. unlikely()
that's part of IS_ERR_VALUE?

Thanks,
Vlastimil

> +		__entry->flags, __entry->length, __entry->low_limit,
> +		__entry->high_limit, __entry->align_mask,
> +		__entry->align_offset)
> +);
> +#endif
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index eeaddb76286c..68ccbd7d5256 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -53,6 +53,9 @@
>  #include <asm/tlb.h>
>  #include <asm/mmu_context.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mmap.h>
> +
>  #include "internal.h"
>  
>  #ifndef arch_mmap_check
> @@ -2061,10 +2064,15 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>   */
>  unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
>  {
> +	unsigned long addr;
> +
>  	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
> -		return unmapped_area_topdown(info);
> +		addr = unmapped_area_topdown(info);
>  	else
> -		return unmapped_area(info);
> +		addr = unmapped_area(info);
> +
> +	trace_vm_unmapped_area(addr, info);
> +	return addr;
>  }
>  
>  #ifndef arch_get_mmap_end
> 


------8<------
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index a51dd8af6f8c..57cccf731721 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -15,7 +15,6 @@ TRACE_EVENT(vm_unmapped_area,
 
        TP_STRUCT__entry(
                __field(unsigned long,  addr)
-               __field(unsigned long,  error)
                __field(unsigned long,  total_vm)
                __field(unsigned long,  flags)
                __field(unsigned long,  length)
@@ -27,10 +26,6 @@ TRACE_EVENT(vm_unmapped_area,
 
        TP_fast_assign(
                __entry->addr = addr;
-               if (IS_ERR_VALUE(addr))
-                       __entry->error = addr;
-               else
-                       __entry->error = 0;
                __entry->total_vm = current->mm->total_vm;
                __entry->flags = info->flags;
                __entry->length = info->length;
@@ -41,8 +36,8 @@ TRACE_EVENT(vm_unmapped_area,
        ),
 
        TP_printk("addr=%lx err=%ld tvm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
-               __entry->addr, __entry->error, __entry->total_vm,
-               __entry->flags, __entry->length, __entry->low_limit,
+               IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr, IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
+               __entry->total_vm, __entry->flags, __entry->length, __entry->low_limit,
                __entry->high_limit, __entry->align_mask,
                __entry->align_offset)
 );
