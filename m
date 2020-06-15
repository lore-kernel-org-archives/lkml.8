Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C7B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgFONCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbgFONC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:02:28 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F89206B7;
        Mon, 15 Jun 2020 13:02:24 +0000 (UTC)
Subject: Re: [PATCH 04/21] mm: free_area_init: use maximal zone PFNs rather
 than zone sizes
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, bhe@redhat.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, rppt@linux.ibm.com
References: <20200412194859.12663-5-rppt@kernel.org>
 <f53e68db-ed81-6ef6-5087-c7246d010ea2@linux-m68k.org>
 <20200615062234.GA7882@kernel.org>
 <24563231-ed19-6f4f-617e-4d6bfc7553e4@linux-m68k.org>
 <20200615082937.GB7882@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <5cae945c-1d15-9857-f7a5-defa884f7b3c@linux-m68k.org>
Date:   Mon, 15 Jun 2020 23:02:21 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615082937.GB7882@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 15/6/20 6:29 pm, Mike Rapoport wrote:
> (reduced the spam list)
> 
> On Mon, Jun 15, 2020 at 05:17:28PM +1000, Greg Ungerer wrote:
>> On 15/6/20 4:22 pm, Mike Rapoport wrote:
>>> On Mon, Jun 15, 2020 at 01:53:42PM +1000, Greg Ungerer wrote:
>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>> Currently, architectures that use free_area_init() to initialize memory map
>>>>> and node and zone structures need to calculate zone and hole sizes. We can
>>>>> use free_area_init_nodes() instead and let it detect the zone boundaries
>>>>> while the architectures will only have to supply the possible limits for
>>>>> the zones.
>>>>>
>>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>>
>>>> This is causing some new warnings for me on boot on at least one non-MMU m68k target:
>>>
>>> There were a couple of changes that cause this. The free_area_init()
>>> now relies on memblock data and architectural limits for zone sizes
>>> rather than on explisit pfns calculated by the arch code. I've update
>>> motorola variant and missed coldfire. Angelo sent a fix for mcfmmu.c
>>> [1] and I've updated it to include nommu as well
>>>
>>> [1] https://lore.kernel.org/linux-m68k/20200614225119.777702-1-angelo.dureghello@timesys.com
>>>
>>>>  From 55b8523df2a5c4565b132c0691990f0821040fec Mon Sep 17 00:00:00 2001
>>> From: Angelo Dureghello <angelo.dureghello@timesys.com>
>>> Date: Mon, 15 Jun 2020 00:51:19 +0200
>>> Subject: [PATCH] m68k: fix registration of memory regions with memblock
>>>
>>> Commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
>>> introduced assumption that UMA systems have their memory at node 0 and
>>> updated most of them, but it forgot nommu and coldfire variants of m68k.
>>>
>>> The later change in free area initialization in commit fa3354e4ea39 ("mm:
>>> free_area_init: use maximal zone PFNs rather than zone sizes") exposed that
>>> and caused a lot of "BUG: Bad page state in process swapper" reports.
>>
>> Even with this patch applied I am still seeing the same messages.
> 
> Argh, it was to early in the morning...
> Can you please try the one below?
> 
> It seems that coldfire didn't register all its physical memory with
> memblock and the pfn list was damaged because of that.
> 
> 
> diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> index e779b19e0193..f66f4b1d062e 100644
> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -138,7 +138,8 @@ void __init setup_arch(char **cmdline_p)
>   	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
>   		 __bss_stop, memory_start, memory_start, memory_end);
>   
> -	memblock_add(memory_start, memory_end - memory_start);
> +	memblock_add(_rambase, memory_end - _rambase);
> +	memblock_reserve(_rambase, memory_start - _rambase);
>   
>   	/* Keep a copy of command line */
>   	*cmdline_p = &command_line[0];

Yep, thats got it. Boots clean again with this one.

Regards
Greg


