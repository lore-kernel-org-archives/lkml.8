Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21273C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE53A206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgICJPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:15:14 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55682 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgICJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:15:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7nf1cO_1599124504;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7nf1cO_1599124504)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 17:15:05 +0800
Subject: Re: [PATCH v4 1/4] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
 <fb8ae5e8-1480-fe22-6872-f2484bcadbed@redhat.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <7b68847f-89c2-5470-5cf0-fc2e225176bc@linux.alibaba.com>
Date:   Thu, 3 Sep 2020 17:14:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fb8ae5e8-1480-fe22-6872-f2484bcadbed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/3 下午4:19, David Hildenbrand 写道:
> On 03.09.20 09:01, Alex Shi wrote:
>> pageblock_flags is used as long, since every pageblock_flags is just 4
>> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
>> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
>> flags. It would cause long waiting for sync.
>>
>> If we could change the pageblock_flags variable as char, we could use
>> char size cmpxchg, which just sync up with 2 pageblock flags. it could
>> relief the false sharing in cmpxchg.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
> 
> Could you please
> 
> 1. Send a cover letter and indicate the changees between versions. I
> cannot find any in my mailbox or on -mm - is there any? (also, is there
> a patch 4 ?)

Hi David,

Thanks for comments!
I thought a short patchset don't need a cover. Here it's:

cmpxchg is a lockless way to update data by check and compare the target
data after updated and retry if target data is changed during that action.

So we should just compare the exact size of target data. If the data is only
byte, but cmpxchg compare a long word, that leads to a cmpxchg level flase
sharing, cause more try which lock memory more times. That's a clearly
logical error and should be fixed.

v1, the initial version
v2, fix the armv6 cmpxchgb missing issue.
v3, fix more arch cmpxchg missing issue on armv6, sh2, sparc32, xtensa
v4, redo cmpxchgb fix by NO_CMPXCHG_BYTE into arch/Kconfig 

> 
> 2. Report proper performance numbers as requested, especially, over
> multiple runs. This should go into patch 1/2. Are they buried somewhere?

There are some result sent on
https://lkml.org/lkml/2020/8/30/95

> 
> 3. Clarify what patch 3 does: Do we actually waste 8*sizeof(long) where
> we only need 4 bits?

No, no waste, current kernel pack the 4 bits into long, that cause cmpxchg
compare 8 pageblock flags which 7 of them are not needed.

> 
> Also, breaking stuff in patch 1 and fixing it in patch 3 is not
> acceptable. This breaks git bisect. Skimming over the patches I think
> this is the case.

Got it, thanks!
> 
> I am not convinced yet that we need and want this. As Alex mentioned, we
> touch pageblock flags while holding the zone lock already in most cases
> -  and as Mel mentiones, updates should be rare.
> 

yes, not too much, but there are still a few. and cmpxchg retry will lock memory
 which I believe the less the better.

Thanks
Alex

