Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5638BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339D12073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCFNao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:30:44 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59917 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbgCFNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:30:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TrpcGV2_1583501424;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrpcGV2_1583501424)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Mar 2020 21:30:25 +0800
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
To:     Hugh Dickins <hughd@google.com>, Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <20200306033850.GO29971@bombadil.infradead.org>
 <97EE83E1-FEC9-48B6-98E8-07FB3FECB961@lca.pw>
 <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cc6a3125-779c-13c0-bec3-dc92deab19f6@linux.alibaba.com>
Date:   Fri, 6 Mar 2020 21:30:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/6 下午12:17, Hugh Dickins 写道:
>>>
>>> Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg
>>
>> I don’t see it on lore.kernel or anywhere. Private email?
> 
> You're right, sorry I didn't notice, lots of ccs but
> neither lkml nor linux-mm were on that thread from the start:

My fault, I thought people would often give comments on each patch, will care this from now on.

> 
> And now the bad news.
> 
> Andrew, please revert those six (or seven as they ended up in mmotm).
> 5.6-rc4-mm1 without them runs my tmpfs+loop+swapping+memcg+ksm kernel
> build loads fine (did four hours just now), but 5.6-rc4-mm1 itself
> crashed just after starting - seconds or minutes I didn't see,
> but it did not complete an iteration.
> 
> I thought maybe those six would be harmless (though I've not looked
> at them at all); but knew already that the full series is not good yet:
> I gave it a try over 5.6-rc4 on Monday, and crashed very soon on simpler
> testing, in different ways from what hits mmotm.
> 
> The first thing wrong with the full set was when I tried tmpfs+loop+
> swapping kernel builds in "mem=700M cgroup_disabled=memory", of course
> with CONFIG_DEBUG_LIST=y. That soon collapsed in a splurge of OOM kills
> and list_del corruption messages: __list_del_entry_valid < list_del <
> __page_cache_release < __put_page < put_page < __try_to_reclaim_swap <
> free_swap_and_cache < shmem_free_swap < shmem_undo_range.

I have been run kernel build with a "mem=700M cgroup_disabled=memory" qemu-kvm
with a swapfile for 3 hours, Hope I could catch sth while waiting for your 
kindly reproduce scripts. Thanks Hugh!

> 
> When I next tried with "mem=1G" and memcg enabled (but not being used),
> that managed some iterations, no OOM kills, no list_del warnings (was
> it swapping? perhaps, perhaps not, I was trying to go easy on it just
> to see if "cgroup_disabled=memory" had been the problem); but when
> rebooting after that, again list_del corruption messages and crash
> (I didn't note them down).
> 
> So I didn't take much notice of what the mmotm crash backtrace showed
> (but IIRC shmem and swap were in it).

Is there some place to get mmotm's crash backtrace?

> 
> Alex, I'm afraid you're focusing too much on performance results,
> without doing the basic testing needed - I thought we had given you
> some hints on the challenging areas (swapping, move_charge_at_immigrate,
> page migration) when we attached a *correctly working* 5.3 version back
> on 23rd August:
> 
> https://lore.kernel.org/linux-mm/alpine.LSU.2.11.1908231736001.16920@eggly.anvils/
> 
> (Correctly working, except missing two patches I'd mistakenly dropped
> as unnecessary in earlier rebases: but our discussions with Johannes
> later showed to be very necessary, though their races rarely seen.)
> 

Did you mean the Johannes's question of race on page->memcg in previous email?

"> I don't see what prevents the lruvec from changing under compaction,
> neither in your patches nor in Hugh's. Maybe I'm missing something?"

https://lkml.org/lkml/2019/11/22/2153

From then on, I have tired 2 solutions to protect page->memcg, 
first use lock_page_memcg(wrong) and 2nd new solution, taking PageLRU bit as page 
isoltion precondition which may work for memcg migration, and page 
migration in compaction etc. Could you like to give some comments on this?

> I have not had the time (and do not expect to have the time) to review
> your series: maybe it's one or two small fixes away from being complete,
> or maybe it's still fundamentally flawed, I do not know.  I had naively
> hoped that you would help with a patchset that worked, rather than
> cutting it down into something which does not.> 

Sorry, Hugh, I didn't know you have per memcg lru_lock patchset before I sent 
out my first verion.

> Submitting your series to routine testing is much easier for me than
> reviewing it: but then, yes, it's a pity that I don't find the time
> to report the results on intervening versions, which also crashed.
> 
> What I have to do now, is set aside time today and tomorrow, to package
> up the old scripts I use, describe them and their environment, and send
> them to you (cc akpm in case I fall under a bus): so that you can
> reproduce the crashes for yourself, and get to work on them.
> 

Thanks advance for your coming testing scripts, I believe it will help a lot.

BTW, I try my best to orgnize this patches to make it stright, a senior experts
like you, won't cost much time to go through whole patches. and give some precious
comment! 

I am looking forward to hear comments from you. :)

Thanks
Alex
