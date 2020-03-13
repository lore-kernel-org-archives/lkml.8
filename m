Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F4EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0595C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCMTyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:54:12 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47393 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbgCMTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:54:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TsVCDSU_1584129245;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TsVCDSU_1584129245)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 14 Mar 2020 03:54:07 +0800
Subject: Re: [PATCH 1/2] mm: swap: make page_evictable() inline
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
 <CALvZod4W9kkh578Kix7+M9Jkwm1sxx2zvvPG+0Us3R8bEkpEpg@mail.gmail.com>
 <520b3295-9fb8-04a7-6215-9bfda4f1a268@linux.alibaba.com>
 <CALvZod6VQ4PWNh=LKifx-8CfUMeeafE0ZoEswG3x2pXxKbRAxA@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <94283259-a0ee-d134-48da-cf5400baaba1@linux.alibaba.com>
Date:   Fri, 13 Mar 2020 12:54:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6VQ4PWNh=LKifx-8CfUMeeafE0ZoEswG3x2pXxKbRAxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/20 12:50 PM, Shakeel Butt wrote:
> On Fri, Mar 13, 2020 at 12:46 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>
>>
>> On 3/13/20 12:33 PM, Shakeel Butt wrote:
>>> On Fri, Mar 13, 2020 at 11:34 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>>> When backporting commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more
>>>> skipping pagevecs") to our 4.9 kernel, our test bench noticed around 10%
>>>> down with a couple of vm-scalability's test cases (lru-file-readonce,
>>>> lru-file-readtwice and lru-file-mmap-read).  I didn't see that much down
>>>> on my VM (32c-64g-2nodes).  It might be caused by the test configuration,
>>>> which is 32c-256g with NUMA disabled and the tests were run in root memcg,
>>>> so the tests actually stress only one inactive and active lru.  It
>>>> sounds not very usual in mordern production environment.
>>>>
>>>> That commit did two major changes:
>>>> 1. Call page_evictable()
>>>> 2. Use smp_mb to force the PG_lru set visible
>>>>
>>>> It looks they contribute the most overhead.  The page_evictable() is a
>>>> function which does function prologue and epilogue, and that was used by
>>>> page reclaim path only.  However, lru add is a very hot path, so it
>>>> sounds better to make it inline.  However, it calls page_mapping() which
>>>> is not inlined either, but the disassemble shows it doesn't do push and
>>>> pop operations and it sounds not very straightforward to inline it.
>>>>
>>>> Other than this, it sounds smp_mb() is not necessary for x86 since
>>>> SetPageLRU is atomic which enforces memory barrier already, replace it
>>>> with smp_mb__after_atomic() in the following patch.
>>>>
>>>> With the two fixes applied, the tests can get back around 5% on that
>>>> test bench and get back normal on my VM.  Since the test bench
>>>> configuration is not that usual and I also saw around 6% up on the
>>>> latest upstream, so it sounds good enough IMHO.
>>>>
>>>> The below is test data (lru-file-readtwice throughput) against the v5.6-rc4:
>>>>           mainline        w/ inline fix
>>>>             150MB            154MB
>>>>
>>> What is the test setup for the above experiment? I would like to get a repro.
>> Just startup a VM with two nodes, then run case-lru-file-readtwice or
>> case-lru-file-readonce in vm-scalability in root memcg or with memcg
>> disabled.  Then get the average throughput (dd result) from the test.
>> Our test bench uses the script from lkp, but I just ran it manually.
>> Single node VM should be more obvious showed in my test.
>>
> Thanks, I will try this on a real machine

Real machine should be better. Our test bench is bare metal with NUMA 
disabled. On my test VM it is not that obvious.


