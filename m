Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59976C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CA620717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgGVIJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:09:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgGVIJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E65E5AFEA;
        Wed, 22 Jul 2020 08:09:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jul 2020 10:08:59 +0200
From:   osalvador@suse.de
To:     =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4?=
         =?UTF-8?Q?=E4=B9=9F=29?= <naoya.horiguchi@nec.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <MHocko@suse.com>,
        linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <OSalvador@suse.com>
Subject: Re: [PATCH v4 12/15] mm,hwpoison: Rework soft offline for in-use
 pages
In-Reply-To: <c19693eb3600832976f44ffa746a263a@suse.de>
References: <20200716123810.25292-1-osalvador@suse.de>
 <20200716123810.25292-13-osalvador@suse.de>
 <f7387d64d0024d15a1bc821a8e19b8f0@DB7PR04MB5180.eurprd04.prod.outlook.com>
 <c19693eb3600832976f44ffa746a263a@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <3b2231bf69133bb7bb8936c74b4e9c9f@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-20 10:27, osalvador@suse.de wrote:
> On 2020-07-17 08:55, HORIGUCHI NAOYA wrote:
>> I ran Quan Cai's test program (https://github.com/cailca/linux-mm) on 
>> a
>> small (4GB memory) VM, and weiredly found that (1) the target 
>> hugepages
>> are not always dissolved and (2) dissovled hugetpages are still 
>> counted
>> in "HugePages_Total:". See below:
>> 
>>     $ ./random 1
>>     - start: migrate_huge_offline
>>     - use NUMA nodes 0,1.
>>     - mmap and free 8388608 bytes hugepages on node 0
>>     - mmap and free 8388608 bytes hugepages on node 1
>>     madvise: Cannot allocate memory
>> 
>>     $ cat /proc/meminfo
>>     MemTotal:        4026772 kB
>>     MemFree:          976300 kB
>>     MemAvailable:     892840 kB
>>     Buffers:           20936 kB
>>     Cached:            99768 kB
>>     SwapCached:         5904 kB
>>     Active:            84332 kB
>>     Inactive:         116328 kB
>>     Active(anon):      27944 kB
>>     Inactive(anon):    68524 kB
>>     Active(file):      56388 kB
>>     Inactive(file):    47804 kB
>>     Unevictable:        7532 kB
>>     Mlocked:               0 kB
>>     SwapTotal:       2621436 kB
>>     SwapFree:        2609844 kB
>>     Dirty:                56 kB
>>     Writeback:             0 kB
>>     AnonPages:         81764 kB
>>     Mapped:            54348 kB
>>     Shmem:              8948 kB
>>     KReclaimable:      22744 kB
>>     Slab:              52056 kB
>>     SReclaimable:      22744 kB
>>     SUnreclaim:        29312 kB
>>     KernelStack:        3888 kB
>>     PageTables:         2804 kB
>>     NFS_Unstable:          0 kB
>>     Bounce:                0 kB
>>     WritebackTmp:          0 kB
>>     CommitLimit:     3260612 kB
>>     Committed_AS:     828196 kB
>>     VmallocTotal:   34359738367 kB
>>     VmallocUsed:       19260 kB
>>     VmallocChunk:          0 kB
>>     Percpu:             5120 kB
>>     HardwareCorrupted:  5368 kB
>>     AnonHugePages:     18432 kB
>>     ShmemHugePages:        0 kB
>>     ShmemPmdMapped:        0 kB
>>     FileHugePages:         0 kB
>>     FilePmdMapped:         0 kB
>>     CmaTotal:              0 kB
>>     CmaFree:               0 kB
>>     HugePages_Total:    1342     // still counted as hugetlb pages.
>>     HugePages_Free:        0     // all hugepage are still allocated
>> (or leaked?)
>>     HugePages_Rsvd:        0
>>     HugePages_Surp:      762     // some are counted in surplus.
>>     Hugepagesize:       2048 kB
>>     Hugetlb:         2748416 kB
>>     DirectMap4k:      112480 kB
>>     DirectMap2M:     4081664 kB
>> 
>> 
>>     $ page-types -b hwpoison
>>                  flags      page-count       MB  symbolic-flags
>>              long-symbolic-flags
>>     0x0000000000080008             421        1
>> ___U_______________X_______________________      uptodate,hwpoison
>>     0x00000000000a8018               1        0
>> ___UD__________H_G_X_______________________
>> uptodate,dirty,compound_head,huge,hwpoison
>>     0x00000000000a801c             920        3
>> __RUD__________H_G_X_______________________
>> referenced,uptodate,dirty,compound_head,huge,hwpoison
>>                  total            1342        5
>> 
>> This means that some hugepages are dissolved, but the others not,
>> maybe which is not desirable.
>> I'll dig this more later but just let me share at first.
>> 
>> A few minor comment below ...
> 
> 
> Uhm, weird.
> 
> I will be taking a look today.

After some digging up I __think__ I found the problem.
I will try to fix it up and I will be running tests.

I might reach out to you once I am done because I remember you had a 
test-suite that worked quite well, so you can give it a spin there.

Thanks


