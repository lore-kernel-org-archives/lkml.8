Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18ECC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADE820717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gdNwdhE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGQOth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:49:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4EC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:49:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id r22so8924726qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A66V2KRK62sL/snt5baONpGuOgTBqfW+z+y3pLQIumo=;
        b=gdNwdhE0+HERTG++gSy8w7F2IndoLW+xAUhyBi6KBdbwKCFXywtB64z6yF/+YcR4Z/
         fLMpu03Y3RfohyYJbj8YzH2F8J0kD1nHCI/XQmlWXuOYZiUgiP0AQfP7xIjTG+H4rW5V
         BMshSEvBwp+zz2RcLIFNbdpAyQUoZBllpu4Ba58alcRK+JB8q3RtYixnFtvp2ZUpmV25
         YhOlAd6EGpxobXMHu2LubQYp8FHL0NOwPFgLgqCcOH1zZPMV5x2WCMSYBg1vV0rfH1nh
         5Fv8DLYtiVGUf3rp2Wb1kq4JCLgNdj6rGZOQVtXCI+q84koaJ88J6B4LNPZ/CilG2Cun
         ukaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A66V2KRK62sL/snt5baONpGuOgTBqfW+z+y3pLQIumo=;
        b=oQ/EREkm2FxTGSVG5IfO0HbCt4RUjf+NHMtmj4n9EKMECYSCo0Etyl8FG4yHpC0Q47
         eBFguSCMfubxa5sVFHRbqXEHUj5ZdunMmqTZ1AwjzSj+kIMyZPR37n2qO8Mq3wnox1dG
         7NBCsAE0KQSdeWDTocSYUOGXwFG5g8y/tcDYFzwE7HcQFJSNkCxYszjLEoazxq7CdkNu
         Vsps/KGeSW9/9fnQ9Ca0PxQJ1flicVzMS6EQyx7iRqnbzPyCducdQs5EY84eiyEHLJ1S
         QjNidQUy0sl9Gckw9OPt5T3t6KFOdUROHlujFvmCZRcQZJpQBPYxB5mlzVziacsQiw91
         63pA==
X-Gm-Message-State: AOAM533D/6KTjC4XsCvoKqT0IkGwWCnTv9f2RuSZXo4caNKM5YKhPMIf
        z/oo5kscS/V0bBUrYIr2/hNGPQ==
X-Google-Smtp-Source: ABdhPJyGUQSijRyxpVS7ufrcKdsSZran8vQDeUHm3Mn2W2SxkiEU9dQSi36/eTlTNmfjMQ+vJrmHew==
X-Received: by 2002:a37:b4d:: with SMTP id 74mr9434789qkl.477.1594997375449;
        Fri, 17 Jul 2020 07:49:35 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g22sm9415056qkm.97.2020.07.17.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:49:35 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:49:28 -0400
From:   Qian Cai <cai@lca.pw>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        mike.kravetz@oracle.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] Hwpoison soft-offline rework
Message-ID: <20200717144913.GA31206@lca.pw>
References: <20200716123810.25292-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716123810.25292-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:37:54PM +0200, Oscar Salvador wrote:
> Hi all,
> 
> this is a follow-up version on [1].
> That version had some flaws wrt. handling hugetlb pages, so this version
> fixes it.
> I checked that the case reported by Qian seems to work fine now.

I am still getting EIO from madvise on some x86 NUMA systems with next-20200717
which includes this patchset.

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make

# ./random 1
- start: migrate_huge_offline
- use NUMA nodes 0,3.
- mmap and free 8388608 bytes hugepages on node 0
- mmap and free 8388608 bytes hugepages on node 3
madvise: Input/output error

== serial console output ==
[  100.149531][ T1644] Soft offlining pfn 0x3a5000 at process virtual address 0x7f1bf7e00000
[  100.193804][ T1644] Soft offlining pfn 0x3a5200 at process virtual address 0x7f1bf8000000
[  100.263446][ T1644] Soft offlining pfn 0x1fa3e00 at process virtual address 0x7f1bf7e00000
[  100.302745][ T1644] __get_any_page: 0x1fa3e00 free huge page
[  100.330226][ T1644] Soft offlining pfn 0x3bd600 at process virtual address 0x7f1bf8000000
[  100.373717][ T1644] Soft offlining pfn 0x202dc00 at process virtual address 0x7f1bf7e00000
[  100.414605][ T1644] Soft offlining pfn 0x1fa3c00 at process virtual address 0x7f1bf8000000
[  100.457675][ T1644] Soft offlining pfn 0x1fd3a00 at process virtual address 0x7f1bf7e00000
[  100.498519][ T1644] Soft offlining pfn 0x1fd3800 at process virtual address 0x7f1bf8000000
[  100.541750][ T1644] Soft offlining pfn 0x1fa3800 at process virtual address 0x7f1bf7e00000
[  100.582207][ T1644] Soft offlining pfn 0x1ffde00 at process virtual address 0x7f1bf8000000
[  100.625221][ T1644] Soft offlining pfn 0x1f7fe00 at process virtual address 0x7f1bf7e00000
[  100.665768][ T1644] Soft offlining pfn 0x1f7fc00 at process virtual address 0x7f1bf8000000
[  100.712181][ T1644] Soft offlining pfn 0x202d800 at process virtual address 0x7f1bf7e00000
[  100.753815][ T1644] Soft offlining pfn 0x205da00 at process virtual address 0x7f1bf8000000
[  100.796807][ T1644] Soft offlining pfn 0x1f7fa00 at process virtual address 0x7f1bf7e00000
[  100.837403][ T1644] Soft offlining pfn 0x1f7f800 at process virtual address 0x7f1bf8000000
[  100.880442][ T1644] Soft offlining pfn 0x1ffd800 at process virtual address 0x7f1bf7e00000
[  100.921584][ T1644] Soft offlining pfn 0x1fd3600 at process virtual address 0x7f1bf8000000
[  100.964444][ T1644] Soft offlining pfn 0x1fa3600 at process virtual address 0x7f1bf7e00000
[  101.005009][ T1644] Soft offlining pfn 0x1fa3400 at process virtual address 0x7f1bf8000000
[  101.047984][ T1644] Soft offlining pfn 0x1f7f400 at process virtual address 0x7f1bf7e00000
[  101.088665][ T1644] Soft offlining pfn 0x205d600 at process virtual address 0x7f1bf8000000
[  101.131368][ T1644] Soft offlining pfn 0x202d600 at process virtual address 0x7f1bf7e00000
[  101.171717][ T1644] Soft offlining pfn 0x202d400 at process virtual address 0x7f1bf8000000
[  101.216780][ T1644] Soft offlining pfn 0x1fa3000 at process virtual address 0x7f1bf7e00000
[  101.258755][ T1644] Soft offlining pfn 0x1fd3200 at process virtual address 0x7f1bf8000000
[  101.302585][ T1644] Soft offlining pfn 0x1ffd600 at process virtual address 0x7f1bf7e00000
[  101.344729][ T1644] Soft offlining pfn 0x1ffd400 at process virtual address 0x7f1bf8000000
[  101.388958][ T1644] Soft offlining pfn 0x205d000 at process virtual address 0x7f1bf7e00000
[  101.430995][ T1644] Soft offlining pfn 0x1f7f200 at process virtual address 0x7f1bf8000000
[  101.474513][ T1644] Soft offlining pfn 0x1fd2e00 at process virtual address 0x7f1bf7e00000
[  101.515333][ T1644] Soft offlining pfn 0x1fd2c00 at process virtual address 0x7f1bf8000000
[  101.558119][ T1644] Soft offlining pfn 0x1fa2c00 at process virtual address 0x7f1bf7e00000
[  101.600051][ T1644] Soft offlining pfn 0x202d200 at process virtual address 0x7f1bf8000000
[  101.643046][ T1644] Soft offlining pfn 0x1ffd200 at process virtual address 0x7f1bf7e00000
[  101.683842][ T1644] Soft offlining pfn 0x1ffd000 at process virtual address 0x7f1bf8000000
[  101.730551][ T1644] Soft offlining pfn 0x205cc00 at process virtual address 0x7f1bf7e00000
[  101.772575][ T1644] Soft offlining pfn 0x1f7ee00 at process virtual address 0x7f1bf8000000
[  101.818438][ T1644] Soft offlining pfn 0x1fd2a00 at process virtual address 0x7f1bf7e00000
[  101.861488][ T1644] Soft offlining pfn 0x1fd2800 at process virtual address 0x7f1bf8000000
[  101.904410][ T1644] Soft offlining pfn 0x1fa2800 at process virtual address 0x7f1bf7e00000
[  101.946639][ T1644] Soft offlining pfn 0x202ce00 at process virtual address 0x7f1bf8000000
[  101.989523][ T1644] Soft offlining pfn 0x1ffce00 at process virtual address 0x7f1bf7e00000
[  102.030092][ T1644] Soft offlining pfn 0x1ffcc00 at process virtual address 0x7f1bf8000000
[  102.076592][ T1644] Soft offlining pfn 0x437600 at process virtual address 0x7f1bf7e00000
[  102.116941][ T1644] Soft offlining pfn 0x433800 at process virtual address 0x7f1bf8000000
[  102.161314][ T1644] Soft offlining pfn 0x1f7e800 at process virtual address 0x7f1bf7e00000
[  102.200495][ T1644] Soft offlining pfn 0x1fa2a00 at process virtual address 0x7f1bf8000000
[  102.247260][ T1644] Soft offlining pfn 0x1fd2600 at process virtual address 0x7f1bf7e00000
[  102.290189][ T1644] Soft offlining pfn 0x1fd2400 at process virtual address 0x7f1bf8000000
[  102.328558][ T1644] __get_any_page: 0x1fd2400: unknown zero refcount page type 3bfffc000000000

# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 24 25 26 27 28 29
node 0 size: 15646 MB
node 0 free: 14779 MB
node 1 cpus: 6 7 8 9 10 11 30 31 32 33 34 35
node 1 size: 31966 MB
node 1 free: 29825 MB
node 2 cpus: 12 13 14 15 16 17 36 37 38 39 40 41
node 2 size: 32253 MB
node 2 free: 31029 MB
node 3 cpus: 18 19 20 21 22 23 42 43 44 45 46 47
node 3 size: 32252 MB
node 3 free: 31360 MB
node distances:
node   0   1   2   3 
  0:  10  21  21  21 
  1:  21  10  21  21 
  2:  21  21  10  21 
  3:  21  21  21  10

# cat /proc/meminfo 
MemTotal:       114809324 kB
MemFree:        109554164 kB
MemAvailable:   109256800 kB
Buffers:            5376 kB
Cached:           166932 kB
SwapCached:            0 kB
Active:           119804 kB
Inactive:         107788 kB
Active(anon):      56356 kB
Inactive(anon):     9308 kB
Active(file):      63448 kB
Inactive(file):    98480 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:               108 kB
Writeback:             0 kB
AnonPages:         55296 kB
Mapped:            82252 kB
Shmem:             10380 kB
KReclaimable:     114784 kB
Slab:            4401424 kB
SReclaimable:     114784 kB
SUnreclaim:      4286640 kB
KernelStack:       18560 kB
PageTables:         5648 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    61547760 kB
Committed_AS:     286384 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      168220 kB
VmallocChunk:          0 kB
Percpu:            39424 kB
HardwareCorrupted:   196 kB
AnonHugePages:     10240 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
HugePages_Total:      50
HugePages_Free:        2
HugePages_Rsvd:        0
HugePages_Surp:       25
Hugepagesize:       2048 kB
Hugetlb:          102400 kB
DirectMap4k:      578044 kB
DirectMap2M:    22358016 kB
DirectMap1G:    113246208 kB

> 
> Cover letter:
> 
> This patchset was initially based on Naoya's hwpoison rework [1], so
> thanks to him for the initial work.
> I would also like to think Naoya for testing the patchset off-line,
> and report any issues he found, that was quite helpful.
> 
> This patchset aims to fix some issues laying in soft-offline handling,
> but it also takes the chance and takes some further steps to perform 
> cleanups and some refactoring as well.
> 
> 
>  - Motivation:
> 
>    A customer and I were facing an issue were processes were killed
>    after having soft-offlined some of their pages.
>    This should not happen when soft-offlining, as it is meant to be non-disruptive.
>    I was able to reproduce the issue when I stressed the memory +
>    soft offlining pages in the meantime.
> 
>    After debugging the issue, I saw that the problem was that pages were returned
>    back to user-space after having offlined them properly.
>    So, when those pages were faulted in, the fault handler returned VM_FAULT_POISON
>    all the way down to the arch handler, and it simply killed the process.
> 
>    After a further anaylsis, it became clear that the problem was that when
>    kcompactd kicked in to migrate pages over, compaction_alloc callback
>    was handing poisoned pages to the migrate routine.
> 
>    All this could happen because isolate_freepages_block and
>    fast_isolate_freepages just check for the page to be PageBuddy,
>    and since 1) poisoned pages can be part of a higher order page
>    and 2) poisoned pages are also Page Buddy, they can sneak in easily.
> 
>    I also saw some other problems with sawap pages, but I suspected it
>    to be the same sort of problem, so I did not follow that trace.
> 
>    The above refers to soft-offline.
>    But I also saw problems with hard-offline, specially hugetlb corruption,
>    and some other weird stuff. (I could paste the logs)
> 
>    The full explanation refering to the soft-offline case can be found at [2].
> 
>  - Approach:
> 
>    The taken approach is to contain those pages and never let them hit 
>    neither pcplists nor buddy freelists.
>    Only when they are completely out of reach, we flag them as poisoned.
> 
>    A full explanation of this can be found in patch#11 and patch#12
> 
>  - Outcome:
> 
>    With this patchset, I no longer see the issues with soft-offline.
> 
> [1] https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> [2] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u
> 
> Naoya Horiguchi (6):
>   mm,hwpoison: cleanup unused PageHuge() check
>   mm, hwpoison: remove recalculating hpage
>   mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
>   mm,hwpoison-inject: don't pin for hwpoison_filter
>   mm,hwpoison: remove MF_COUNT_INCREASED
>   mm,hwpoison: remove flag argument from soft offline functions
> 
> Oscar Salvador (9):
>   mm,madvise: Refactor madvise_inject_error
>   mm,hwpoison: Un-export get_hwpoison_page and make it static
>   mm,hwpoison: Kill put_hwpoison_page
>   mm,hwpoison: Unify THP handling for hard and soft offline
>   mm,hwpoison: Rework soft offline for free pages
>   mm,hwpoison: Rework soft offline for in-use pages
>   mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
>   mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
>   mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
> 
>  drivers/base/memory.c      |   2 +-
>  include/linux/mm.h         |  12 +-
>  include/linux/page-flags.h |   6 +-
>  include/ras/ras_event.h    |   3 +
>  mm/hugetlb.c               |  60 +++++++-
>  mm/hwpoison-inject.c       |  18 +--
>  mm/madvise.c               |  37 ++---
>  mm/memory-failure.c        | 307 +++++++++++++++----------------------
>  mm/migrate.c               |  11 +-
>  mm/page_alloc.c            |  70 +++++++--
>  10 files changed, 270 insertions(+), 256 deletions(-)
> 
> -- 
> 2.26.2
> 
> 
