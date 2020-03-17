Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADFFC0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D1120679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgCQCHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:07:10 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46833 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgCQCHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 22:07:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tsp8nCr_1584410758;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tsp8nCr_1584410758)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Mar 2020 10:06:00 +0800
Subject: Re: [v2 PATCH 1/2] mm: swap: make page_evictable() inline
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1584397455-28701-1-git-send-email-yang.shi@linux.alibaba.com>
 <CALvZod72O-9Qm5bvr2MWKPRiDV3oFCmujawr28DnsSdJx+PmjQ@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d4036ddf-388d-bfeb-f36a-2ead20f5793f@linux.alibaba.com>
Date:   Mon, 16 Mar 2020 19:05:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod72O-9Qm5bvr2MWKPRiDV3oFCmujawr28DnsSdJx+PmjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/20 4:46 PM, Shakeel Butt wrote:
> On Mon, Mar 16, 2020 at 3:24 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>> When backporting commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more
>> skipping pagevecs") to our 4.9 kernel, our test bench noticed around 10%
>> down with a couple of vm-scalability's test cases (lru-file-readonce,
>> lru-file-readtwice and lru-file-mmap-read).  I didn't see that much down
>> on my VM (32c-64g-2nodes).  It might be caused by the test configuration,
>> which is 32c-256g with NUMA disabled and the tests were run in root memcg,
>> so the tests actually stress only one inactive and active lru.  It
>> sounds not very usual in mordern production environment.
>>
>> That commit did two major changes:
>> 1. Call page_evictable()
>> 2. Use smp_mb to force the PG_lru set visible
>>
>> It looks they contribute the most overhead.  The page_evictable() is a
>> function which does function prologue and epilogue, and that was used by
>> page reclaim path only.  However, lru add is a very hot path, so it
>> sounds better to make it inline.  However, it calls page_mapping() which
>> is not inlined either, but the disassemble shows it doesn't do push and
>> pop operations and it sounds not very straightforward to inline it.
>>
>> Other than this, it sounds smp_mb() is not necessary for x86 since
>> SetPageLRU is atomic which enforces memory barrier already, replace it
>> with smp_mb__after_atomic() in the following patch.
>>
>> With the two fixes applied, the tests can get back around 5% on that
>> test bench and get back normal on my VM.  Since the test bench
>> configuration is not that usual and I also saw around 6% up on the
>> latest upstream, so it sounds good enough IMHO.
>>
>> The below is test data (lru-file-readtwice throughput) against the v5.6-rc4:
>>          mainline        w/ inline fix
>>            150MB            154MB
>>
>> With this patch the throughput gets 2.67% up.  The data with using
>> smp_mb__after_atomic() is showed in the following patch.
>>
>> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>
> So, I tested on a real machine with limiting the 'dd' on a single node
> and reading 100 GiB sparse file (less than a single node). I just ran
> a single instance to not cause the lru lock contention. The cmd I used
> is "dd if=file-100GiB of=/dev/null bs=4k". I ran the cmd 10 times with
> drop_caches in between and measured the time it took.
>
> Without patch: 56.64143 +- 0.672 sec
>
> With patches: 56.10 +- 0.21 sec
>
> Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>

Thanks Shakeel. It'd better to add your test result in the commit log too.

