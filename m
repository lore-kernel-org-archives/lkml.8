Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76258C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4158520671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPmRy4Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgERSJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbgERSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:09:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0810C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:09:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so196181pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qkGegF0HlZd1yNtrn2tHPxLREf4CjGE5/VigPXKU1dk=;
        b=aPmRy4BcKvm2F3R+UIqG1AjLpeVvBWVN5BEjDX0hisyxmltPQntOvdTG6BIuXgiTpg
         /4mzuBxBNHd2y4I3rlmxlNwsWL8zR85gkZ+95pUxkLV0DmE0y5iw1IpQVka2PyK28Npu
         h0WWd79mwflUDqaz7KRu/DDj5mgzWT7JA7HSUGEZB1oPq3ay7uQnA8mHKljcsx+Ny9hU
         acZG/3yzeqO10M11rVAcdnoLDj7HsRjddNZ8UviYko5366Pe+KztIiihiD1Sx1Xbtuj6
         KDYDlCHb98cqoQtA8Pims9+HzW8aHet3JmkrYGyaceig31R34oU6eCWiQmaeDlOvM15M
         YXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qkGegF0HlZd1yNtrn2tHPxLREf4CjGE5/VigPXKU1dk=;
        b=j3vP/f+i3oiSHb+wQ20fKtqwUIsPK/yck0VB6lRxdestVB9yfHvgUYwqnmRemy+GIn
         sUr25HCgov8B28EdbflVABMZ9Fqt26syd5TgfqtF1s1BQDBId3CmuZ4uLHtLIRQwCNpx
         VVvMTCkFVNaS5z+81Iu75hIYhkHquTORWk0hCbuFs/8/v78eFz7ooO9T9jOw2JxptkRq
         gkMUp9YuK9gK88/yfEyTanl2P3TvhOQbAnEJ3nwt1vFmzExP3o3OtgZY4I8IU4/Y0++s
         CrOANFCNwrm1A+aIauX/U+zxJajcOGPkJPWsEogpwRqyv1FWM4zplFvuR32Ce7PqUotg
         WOGw==
X-Gm-Message-State: AOAM533ly03lOuVs5bKQp0LNdPeicqofXilRtstT1JogA6My85+DVh4g
        sq/B9yWd/Mb47yJl22S4bm0=
X-Google-Smtp-Source: ABdhPJxuSqJexZFKS0+etca2h5LgXO84MCB9mmxbdVLxHhGkGh8TiE9oqMVlJdQPiUIpTsnHKMNiMQ==
X-Received: by 2002:a17:90b:f0a:: with SMTP id br10mr618362pjb.145.1589825388425;
        Mon, 18 May 2020 11:09:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y6sm190420pjw.15.2020.05.18.11.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 11:09:47 -0700 (PDT)
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net> <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <418aa44b-6fb3-c3d8-a920-1a26e5edec62@roeck-us.net>
 <20200518142310.GC1118872@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b171fbbd-f5b2-ac17-24e5-7188f6ce80f0@roeck-us.net>
Date:   Mon, 18 May 2020 11:09:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518142310.GC1118872@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/20 7:23 AM, Mike Rapoport wrote:
> On Mon, May 18, 2020 at 02:48:18AM -0700, Guenter Roeck wrote:
>> On 5/18/20 1:37 AM, Will Deacon wrote:
>>> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
>>>> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
>>>>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
>>>>>> Now that the page table allocator can free page table allocations
>>>>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
>>>>>> to avoid needlessly wasting memory.
>>>>>>
>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>>> Signed-off-by: Will Deacon <will@kernel.org>
>>>>>
>>>>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
>>>>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
>>>>> does reverting the rest of the series.
>>>>>
>>>> Actually, turns out I see the same pattern (lots of scheduling while atomic
>>>> followed by 'killing interrupt handler' in cryptomgr_test) with several
>>>> powerpc boot tests.  I am currently bisecting those crashes. I'll report
>>>> the results here as well as soon as I have it.
>>>
>>> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
>>> issues. However, linux-next is a different story, where I don't get very far
>>> at all:
>>>
>>> BUG: Bad page state in process swapper  pfn:005b4
> 
> This one seems to be due to commit 24aab577764f ("mm: memmap_init:
> iterate over memblock regions rather that check each PFN") and reverting
> it and partially reverting the next cleanup commits makes those
> dissapear. sparc32 boot still fails on today's linux-next and mmotm for me with
> 
> Run /sbin/init as init process
>   with arguments:
>     /sbin/init
>   with environment:
>     HOME=/
>     TERM=linux
> Starting init: /sbin/init exists but couldn't execute it (error -14)
> 
> I've tried to bisect mmotm and I've got the first bad commits in
> different places in the middle of arch/kmap series [1] so I've added Ira
> to CC as well :)
> 
> I'll continue to look into "bad page" on sparc32
> 
> [1] https://lore.kernel.org/dri-devel/20200507150004.1423069-11-ira.weiny@intel.com/
> 
>> Here are the bisect results for ppc:
>>
>> # bad: [bdecf38f228bcca73b31ada98b5b7ba1215eb9c9] Add linux-next specific files for 20200515
>> # good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
>> git bisect start 'HEAD' 'v5.7-rc5'
> 
> ...
> 
>> # good: [9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011] arch-kmap_atomic-consolidate-duplicate-code-checkpatch-fixes
>> git bisect good 9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011
>> # bad: [89194ba5ee31567eeee9c81101b334c8e3248198] arch/kmap: define kmap_atomic_prot() for all arch's
>> git bisect bad 89194ba5ee31567eeee9c81101b334c8e3248198
>> # good: [022785d2bea99f8bc2a37b7b6c525eea26f6ac59] arch-kunmap_atomic-consolidate-duplicate-code-checkpatch-fixes
>> git bisect good 022785d2bea99f8bc2a37b7b6c525eea26f6ac59
>> # good: [a13c2f39e3f0519ddee57d26cc66ec70e3546106] arch/kmap: don't hard code kmap_prot values
>> git bisect good a13c2f39e3f0519ddee57d26cc66ec70e3546106
>> # first bad commit: [89194ba5ee31567eeee9c81101b334c8e3248198] arch/kmap: define kmap_atomic_prot() for all arch's
>>
>> I don't know if that is accurate either. Maybe things are so broken
>> that bisect gets confused, or the problem is due to interaction
>> between different patch series.
> 
> My results with the workaround for sparc32 boot look similar:
> 
> # bad: [2bbf0589bfeb27800c730b76eacf34528eee5418] pci: test for unexpectedly disabled bridges
> git bisect bad 2bbf0589bfeb27800c730b76eacf34528eee5418
> # good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
> git bisect good 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8
> # bad: [e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35] mm-add-debug_wx-support-fix
> git bisect bad e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35
> # bad: [e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35] mm-add-debug_wx-support-fix
> git bisect bad e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35
> # good: [e27369856a2d42ae4d84bc2c4ddac1e696c40d7c] mm: remove the prot argument from vm_map_ram
> git bisect good e27369856a2d42ae4d84bc2c4ddac1e696c40d7c
> # good: [6911f2b29f6daae2c4b51e6a37f794056d8afabd] mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty
> git bisect good 6911f2b29f6daae2c4b51e6a37f794056d8afabd
> # good: [8cef4726f20ae37c3cf3f7a449f5b8a088247a27] hugetlbfs: clean up command line processing
> git bisect good 8cef4726f20ae37c3cf3f7a449f5b8a088247a27
> # good: [94f38895e0a68ceac3ceece6528123ed3129cedd] arch/kmap: ensure kmap_prot visibility
> git bisect good 94f38895e0a68ceac3ceece6528123ed3129cedd
> # skip: [fcc77c28bf9155c681712b25c0f5e6125d10ba2e] kmap: consolidate kmap_prot definitions
> git bisect skip fcc77c28bf9155c681712b25c0f5e6125d10ba2e
> # bad: [175a67be7ee750b2aa2a4a2fedeff18fdce787ac] kmap-consolidate-kmap_prot-definitions-checkpatch-fixes
> git bisect bad 175a67be7ee750b2aa2a4a2fedeff18fdce787ac
> # bad: [54db8ed321d66a00b6c69bbd5bf7c59809b3fd42] drm: vmwgfx: include linux/highmem.h
> git bisect bad 54db8ed321d66a00b6c69bbd5bf7c59809b3fd42
> # bad: [6671299c829d19c6ceb0fd1a14b690f6115c6d3d] arch/kmap: define kmap_atomic_prot() for all arch's
> git bisect bad 6671299c829d19c6ceb0fd1a14b690f6115c6d3d
> # bad: [f800fb6e517710e04391821e4b1908606c8a6b24] arch/kmap: don't hard code kmap_prot values
> git bisect bad f800fb6e517710e04391821e4b1908606c8a6b24
> # first bad commit: [f800fb6e517710e04391821e4b1908606c8a6b24] arch/kmap: don't hard code kmap_prot values
> 
> 

Below is another set of bisect results, from next-20200518. It points to one
of your commits. This is for microblaze (big endian) boot failures.

Guenter

---
# bad: [72bc15d0018ebfbc9c389539d636e2e9a9002b3b] Add linux-next specific files for 20200518
# good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
git bisect start 'HEAD' 'v5.7-rc5'
# good: [b5b9a1a40fcf10db8f140c987b715e6816e1292d] Merge remote-tracking branch 'crypto/master'
git bisect good b5b9a1a40fcf10db8f140c987b715e6816e1292d
# good: [6a349e7cf4cec11b63ca8e3095c990e146f48784] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 6a349e7cf4cec11b63ca8e3095c990e146f48784
# good: [0c5e27cea5e173afc1971ce9a521e022c288548c] Merge remote-tracking branch 'staging/staging-next'
git bisect good 0c5e27cea5e173afc1971ce9a521e022c288548c
# good: [7e90955569a080b17030161db6152917f3b0e061] Merge remote-tracking branch 'hyperv/hyperv-next'
git bisect good 7e90955569a080b17030161db6152917f3b0e061
# good: [c0218a9a3a60cf081f5545302d0fc28a8d68059b] fs/buffer.c: add debug print for __getblk_gfp() stall problem
git bisect good c0218a9a3a60cf081f5545302d0fc28a8d68059b
# good: [bcda3c9d968d3a8b596904fb2ff8009717ffb6ef] Merge branch 'akpm-current/current'
git bisect good bcda3c9d968d3a8b596904fb2ff8009717ffb6ef
# good: [5b271f59a6aee147db3d7137f6132f74977131c1] kernel: use show_stack_loglvl()
git bisect good 5b271f59a6aee147db3d7137f6132f74977131c1
# good: [dec7b12bacc0859e689c4a42714c7bf4d0b98cfd] mm/mmap.c: add more sanity checks to get_unmapped_area()
git bisect good dec7b12bacc0859e689c4a42714c7bf4d0b98cfd
# bad: [feda7bcd5e1846039cc1a999bf4090b1fee890e8] mm: fix build error for mips of process_madvise
git bisect bad feda7bcd5e1846039cc1a999bf4090b1fee890e8
# good: [0533da2f2fa20c28ac5b4573bd6bb0d445638c6a] x86/mm: simplify init_trampoline() and surrounding logic
git bisect good 0533da2f2fa20c28ac5b4573bd6bb0d445638c6a
# bad: [2b166035a0202b90f5860178b8ae43d41a42117f] mm: consolidate pud_index() and pud_offset() definitions
git bisect bad 2b166035a0202b90f5860178b8ae43d41a42117f
# bad: [01f489acfb0783379cc764d503477c0f6df49a0b] mm: consolidate pte_index() and pte_offset_*() definitions
git bisect bad 01f489acfb0783379cc764d503477c0f6df49a0b
# bad: [c57a43e52bf5fdc4152bb17db6e9c5d35569dcfd] mm: pgtable: add shortcuts for accessing kernel PMD and PTE
git bisect bad c57a43e52bf5fdc4152bb17db6e9c5d35569dcfd
# first bad commit: [c57a43e52bf5fdc4152bb17db6e9c5d35569dcfd] mm: pgtable: add shortcuts for accessing kernel PMD and PTE


