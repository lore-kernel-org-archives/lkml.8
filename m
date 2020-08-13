Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C891C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37432078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHYjh9yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHMRwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:52:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A76C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:52:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so3200075pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oTXiLQfCA7RppUvjuHzp7XF/FlnCYg8SGc+WrLKZ1ss=;
        b=mHYjh9yhDjNSVb7eMUcqzm3cabZo6xzRdCdi/wuuPGQNooNn4uhY9neV9IPJrmYhI6
         eSYOGcn5Q4ULaItopBueN3LvHhqSb9wWLIEB+fm4FmXS6DMYIN69o+NVq23JOekyiHOw
         Em7BSpUcmc2zfT9J89fHQLoqS6naJY84poxoSrGQQKUrlcDVA6X0/5iZnkZtjzYZC/2T
         dlsNAHt0u8SCK7rvSEsoFa/MejvSjXD3k5VO2LZXHb6jmv2NjL/ToXqc8NzcBJzCMeMw
         aMY0drsfJaesZ35kdG7xqliP8tmNjWjmVgblJSKlAlXkTgp5xSNfqBFzvp55vjizGwyz
         Upeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTXiLQfCA7RppUvjuHzp7XF/FlnCYg8SGc+WrLKZ1ss=;
        b=FJDo7U+CSJsA1y13OMUmcwNzGf11BFPri7WqNK5Z67GcO2ONVfPqCKtPD7tSukntNb
         WqcnIKm2EXZczviFlkUAb28VY2wC8SPv32DMW5HK7Jt4yvKvj8JiDRJWEWvowAqBXotj
         HvmFJInOsVmPlF+MHnWKyzk8DCcm4LZ/W6FSnDrFdIVeCJKH5kR88qgniaK0d45DrH0W
         Qx9rIwceBlUpeFyQ4DIZG/IFSrLLP+MTMk8i8VX5Ks6EYpUdiQsEiUPocXCaxzbOagnP
         3alBr2hUmyZsUAJDQFDRkHCJo+ulT+T2pk7+dvlfefoK1r8f83xb0BMoR3jZsJftPJV8
         34zQ==
X-Gm-Message-State: AOAM531YPx634eqv/2M9wVlmMfRE/kzdJGKqVLpAjMXS8XssMzNecUGT
        2b8wkDmdfNVGASPEVpm3fC++u8f0jlI=
X-Google-Smtp-Source: ABdhPJzbegF71I6iUuzSkrSfd50ZV3zGDNJDx3j2d6UlqOOTDIo3c1FcFrTX+mkolDiKuL6pyd3h8w==
X-Received: by 2002:a63:2543:: with SMTP id l64mr4866759pgl.164.1597341137336;
        Thu, 13 Aug 2020 10:52:17 -0700 (PDT)
Received: from [10.230.191.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x28sm6667561pfj.73.2020.08.13.10.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:52:16 -0700 (PDT)
Subject: Re: [PATCH] mm: include CMA pages in lowmem_reserve at boot
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597290698-24266-1-git-send-email-opendmb@gmail.com>
 <20200813111730.GH9477@dhcp22.suse.cz>
From:   Doug Berger <opendmb@gmail.com>
Message-ID: <a6a23d81-d24e-e425-e1cb-d7ef3ef69a38@gmail.com>
Date:   Thu, 13 Aug 2020 10:55:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813111730.GH9477@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/2020 4:17 AM, Michal Hocko wrote:
> On Wed 12-08-20 20:51:38, Doug Berger wrote:
>> The lowmem_reserve arrays provide a means of applying pressure
>> against allocations from lower zones that were targeted at
>> higher zones. Its values are a function of the number of pages
>> managed by higher zones and are assigned by a call to the
>> setup_per_zone_lowmem_reserve() function.
>>
>> The function is initially called at boot time by the function
>> init_per_zone_wmark_min() and may be called later by accesses
>> of the /proc/sys/vm/lowmem_reserve_ratio sysctl file.
>>
>> The function init_per_zone_wmark_min() was moved up from a
>> module_init to a core_initcall to resolve a sequencing issue
>> with khugepaged. Unfortunately this created a sequencing issue
>> with CMA page accounting.
>>
>> The CMA pages are added to the managed page count of a zone
>> when cma_init_reserved_areas() is called at boot also as a
>> core_initcall. This makes it uncertain whether the CMA pages
>> will be added to the managed page counts of their zones before
>> or after the call to init_per_zone_wmark_min() as it becomes
>> dependent on link order. With the current link order the pages
>> are added to the managed count after the lowmem_reserve arrays
>> are initialized at boot.
>>
>> This means the lowmem_reserve values at boot may be lower than
>> the values used later if /proc/sys/vm/lowmem_reserve_ratio is
>> accessed even if the ratio values are unchanged.
>>
>> In many cases the difference is not significant, but in others
>> it may have an affect.
> 
> Could you be more specific please?

One example might be a 1GB arm platform that defines a 256MB default CMA
region. The default zones might map as follows:
[    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]

At boot the memory info would be:
# echo m > /proc/sysrq-trigger
[   21.559673] sysrq: Show Memory
[   21.562758] Mem-Info:
[   21.565053] active_anon:9783 inactive_anon:770 isolated_anon:0
[   21.565053]  active_file:0 inactive_file:0 isolated_file:0
[   21.565053]  unevictable:0 dirty:0 writeback:0
[   21.565053]  slab_reclaimable:1827 slab_unreclaimable:1867
[   21.565053]  mapped:716 shmem:10363 pagetables:26 bounce:0
[   21.565053]  free:221995 free_pcp:444 free_cma:54917
[   21.596744] Node 0 active_anon:39132kB inactive_anon:3080kB
active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB mapped:2864kB dirty:0kB writeback:0kB shmem:41452kB
writeback_tmp:0kB kernel_stack:472kB all_unreclaimable? no
[   21.619650] DMA free:668312kB min:3288kB low:4108kB high:4928kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:786432kB managed:690364kB mlocked:0kB pagetables:104kB
bounce:0kB free_pcp:1776kB local_pcp:324kB free_cma:0kB
[   21.646810] lowmem_reserve[]: 0 0 0 0
[   21.650498] HighMem free:219668kB min:128kB low:128kB high:128kB
reserved_highatomic:0KB active_anon:39132kB inactive_anon:3080kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:262144kB managed:262144kB mlocked:0kB pagetables:0kB bounce:0kB
free_pcp:0kB local_pcp:0kB free_cma:219668kB
[   21.678184] lowmem_reserve[]: 0 0 0 0
[   21.681866] DMA: 20*4kB (UME) 9*8kB (UME) 7*16kB (UME) 6*32kB (M)
7*64kB (ME) 4*128kB (M) 7*256kB (UM) 7*512kB (ME) 6*1024kB (M) 8*2048kB
(UM) 156*4096kB (M) = 668296kB
[   21.696970] HighMem: 1*4kB (C) 3*8kB (C) 3*16kB (C) 4*32kB (C) 1*64kB
(C) 0*128kB 1*256kB (C) 0*512kB 0*1024kB 1*2048kB (C) 53*4096kB (C) =
219660kB
[   21.710328] 10363 total pagecache pages
[   21.714188] 0 pages in swap cache
[   21.717518] Swap cache stats: add 0, delete 0, find 0/0
[   21.722761] Free swap  = 0kB
[   21.725655] Total swap = 0kB
[   21.728549] 262144 pages RAM
[   21.731443] 65536 pages HighMem/MovableOnly
[   21.735641] 24017 pages reserved
[   21.738882] 65536 pages cma reserved

Here you can see that the lowmem_reserve array for the DMA zone is all
0's. This is because the HighMem zone is consumed by the CMA region
whose pages haven't been activated to increase the zone managed count
when init_per_zone_wmark_min() is invoked at boot.

If we access the /proc/sys/vm/lowmem_reserve_ratio sysctl with:
# cat /proc/sys/vm/lowmem_reserve_ratio
256     32      0       0

That is sufficient to recalculate the lowmem_reserve arrays which now show:
# echo m > /proc/sysrq-trigger
[   38.848640] sysrq: Show Memory
[   38.851712] Mem-Info:
[   38.854004] active_anon:9783 inactive_anon:773 isolated_anon:0
[   38.854004]  active_file:0 inactive_file:0 isolated_file:0
[   38.854004]  unevictable:0 dirty:0 writeback:0
[   38.854004]  slab_reclaimable:1835 slab_unreclaimable:1867
[   38.854004]  mapped:716 shmem:10363 pagetables:26 bounce:0
[   38.854004]  free:221984 free_pcp:444 free_cma:54914
[   38.885698] Node 0 active_anon:39132kB inactive_anon:3092kB
active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB mapped:2864kB dirty:0kB writeback:0kB shmem:41452kB
writeback_tmp:0kB kernel_stack:472kB all_unreclaimable? no
[   38.908605] DMA free:668280kB min:3288kB low:4108kB high:4928kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:786432kB managed:690364kB mlocked:0kB pagetables:104kB
bounce:0kB free_pcp:1776kB local_pcp:132kB free_cma:0kB
[   38.935765] lowmem_reserve[]: 0 0 256 0
[   38.939628] HighMem free:219656kB min:128kB low:128kB high:128kB
reserved_highatomic:0KB active_anon:39132kB inactive_anon:3092kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:262144kB managed:262144kB mlocked:0kB pagetables:0kB bounce:0kB
free_pcp:0kB local_pcp:0kB free_cma:219656kB
[   38.967310] lowmem_reserve[]: 0 0 0 0
[   38.970992] DMA: 20*4kB (UME) 9*8kB (UME) 6*16kB (UM) 6*32kB (M)
7*64kB (ME) 4*128kB (M) 7*256kB (UM) 7*512kB (ME) 6*1024kB (M) 8*2048kB
(UM) 156*4096kB (M) = 668280kB
[   38.986007] HighMem: 8*4kB (C) 5*8kB (C) 0*16kB 4*32kB (C) 1*64kB (C)
0*128kB 1*256kB (C) 0*512kB 0*1024kB 1*2048kB (C) 53*4096kB (C) = 219656kB
[   38.999016] 10363 total pagecache pages
[   39.002868] 0 pages in swap cache
[   39.006196] Swap cache stats: add 0, delete 0, find 0/0
[   39.011437] Free swap  = 0kB
[   39.014330] Total swap = 0kB
[   39.017223] 262144 pages RAM
[   39.020116] 65536 pages HighMem/MovableOnly
[   39.024314] 24017 pages reserved
[   39.027554] 65536 pages cma reserved

Here the lowmem_reserve back pressure for the DMA zone for allocations
that target the HighMem zone is now 256 pages. Now 1MB is still not a
lot of additional back pressure, but the watermarks on the HighMem zone
aren't very large either so User space allocations can easily start
consuming the DMA zone while kswapd starts trying to reclaim space in
HighMem. This excess pressure on DMA zone memory can potentially lead to
earlier triggers of OOM Killer and/or kernel fallback allocations into
CMA Movable pages which can interfere with the ability of CMA to obtain
larger size contiguous allocations.

All of that said, my main concern is that I don't like the inconsistency
between the boot time and run time results.

Thank you for taking the time to review and consider this patch,
    Doug
