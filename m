Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C588C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1B4207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INphVoOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETTDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:03:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13778C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:03:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx22so1756290pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0IhV4Cj9LhItTYxHJX7mGl2oZDNoRZx3jWUOP9zzNE=;
        b=INphVoOh8roquUhyGm3X+EBOqylIipg/0UZHgBqUeCJELmYSLQdYLlJTk03mKhA3oM
         aOBJrSCwJaa09lwtokihwf9/7/UA3U8dncZcBl18fJG9xLjRjAJdjBOVP2KstBpEJyD4
         eo4XcP/pCA0W3AZvvl8UzG2Uf1RQWDfR3dez3mUoyvkkbF1cdy+mpwZVweUFL65fivdp
         zKPOJ2wVh3VTkk7CWiCl9UzY8RONTtpayTFz86o3KA5FaeVLbb+Zc62yw5PkB5/qDfO2
         najC5+myaaJjviV/Vu7Fqhow3HGxWYyuRHQgrGpp2VKlZpCaLNyYRBmSwQzL1mkcDCWi
         AzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j0IhV4Cj9LhItTYxHJX7mGl2oZDNoRZx3jWUOP9zzNE=;
        b=L4SiZwkS18YLTzh/qlOckinOPA0danlGGC4ceNFbYmpqbzq1vma8OV95RJIxYsthWQ
         /2kh6xN5HrJm92GVG0L4BnEx3KdF6S0dZjRk66m21T3A0O8stv8AtyG8GkhEfKStKMpj
         4/pHGO97HScdfZ5NwoXTFEOTL+O3IlrqjMxyosttmITBM20o2b2sBkc/BwngOHz4ASO2
         NbvfnU1QB1QYYIIDIFYfJSf0OZ84Ca7G19/qByZdEQVUBpljCegGpPedZh/zuYpThaFE
         3LL/TMBb88v+gyKKzg8L+kRnCmuEvJ66eySul251P1XzuLurbe1GScAioF+ZZClIGggd
         1bNw==
X-Gm-Message-State: AOAM530RP9GKAQikgolZ2K7Puk8VAJ+N1LLAWUIoIEI/wEymKHLxGrjv
        T/SplXez1PbWvk6JdxNAs50=
X-Google-Smtp-Source: ABdhPJykfTPS8QWxnCox+vJC0xvgw318hv937VIWvRrA0oXTY/No0jTLAYVzzpt3BBHdSKoBwhtM7Q==
X-Received: by 2002:a17:90a:648c:: with SMTP id h12mr7217891pjj.229.1590001414557;
        Wed, 20 May 2020 12:03:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i8sm2360740pgr.82.2020.05.20.12.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 12:03:33 -0700 (PDT)
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
To:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net> <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <20200520170306.GG1118872@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <6034a1b5-d4f6-c836-142c-9b3b06db3246@roeck-us.net>
Date:   Wed, 20 May 2020 12:03:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520170306.GG1118872@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 10:03 AM, Mike Rapoport wrote:
> On Mon, May 18, 2020 at 09:37:15AM +0100, Will Deacon wrote:
>> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
>>> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
>>>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
>>>>> Now that the page table allocator can free page table allocations
>>>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
>>>>> to avoid needlessly wasting memory.
>>>>>
>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Signed-off-by: Will Deacon <will@kernel.org>
>>>>
>>>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
>>>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
>>>> does reverting the rest of the series.
>>>>
>>> Actually, turns out I see the same pattern (lots of scheduling while atomic
>>> followed by 'killing interrupt handler' in cryptomgr_test) with several
>>> powerpc boot tests.  I am currently bisecting those crashes. I'll report
>>> the results here as well as soon as I have it.
>>
>> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
>> issues. However, linux-next is a different story, where I don't get very far
>> at all:
>>
>> BUG: Bad page state in process swapper  pfn:005b4
>  
> This is caused by c03584e30534 ("mm: memmap_init: iterate over memblock
> regions rather that check each PFN"). The commit sha is valid for
> v5.7-rc6-mmots-2020-05-19-21-52, so it will change in a day or so :)
> 
> As it seems, sparc32 never registered the memory occupied by the kernel
> image with memblock_add() and it only reserves this memory with
> meblock_reserve(). 
> 
> I don't know what would happen on real HW, but with 
> 
> qemu-system-sparc -kernel /path/to/kernel
> 
> the memory occupied by the kernel is reserved in openbios and removed
> from mem.available. The prom setup code in the kernel used mem.available
> to set up the memory banks and essentially there is a hole for the
> memory occupied by the kernel.
> 
> Later in bootmem_init() this memory is memblock_reserve()d.
> 
> Before the problematic commit, memmap initialization would call
> __init_single_page() for the pages in that hole, the
> free_low_memory_core_early() would mark them as resrved and everything
> would be Ok.
> 
> After the change in memmap initialization, the hole is skipped and the
> page structs for it are not inited. And when they are passed from
> memblock to page allocator as reserved it gets confused.
> 
> Simply registering the memory occupied by the kernel with memblock_add()
> resolves this issue, at least for qemu-system-arm and I cannot see how
> it can harm any other setup.
> 
> If all that makes sense I'll send a proper patch :)
> 
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index 906eda1158b4..3cb3dffcbcdc 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -193,6 +193,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
>  	/* Reserve the kernel text/data/bss. */
>  	size = (start_pfn << PAGE_SHIFT) - phys_base;
>  	memblock_reserve(phys_base, size);
> +	memblock_add(phys_base, size);
>  
>  	size = memblock_phys_mem_size() - memblock_reserved_size();
>  	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
> 
>> Will
> 

With above patch applied on top of Ira's patch, I get:

BUG: spinlock recursion on CPU#0, S01syslogd/139
 lock: 0xf5448350, .magic: dead4ead, .owner: S01syslogd/139, .owner_cpu: 0
CPU: 0 PID: 139 Comm: S01syslogd Not tainted 5.7.0-rc6-next-20200518-00002-gb178d2d56f29-dirty #1
[f0067a64 :
do_raw_spin_lock+0xa8/0xd8 ]
[f00d5034 :
copy_page_range+0x328/0x804 ]
[f0025be4 :
dup_mm+0x334/0x434 ]
[f0027124 :
copy_process+0x1224/0x12b0 ]
[f0027344 :
_do_fork+0x54/0x30c ]
[f0027670 :
do_fork+0x5c/0x6c ]
[f000de44 :
sparc_do_fork+0x18/0x38 ]
[f000b7f4 :
do_syscall+0x34/0x40 ]
[5010cd4c :
0x5010cd4c ]

Looks like yet another problem.

I can not revert c03584e30534 because it results in a compile failure.

Guenter
