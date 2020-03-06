Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019E5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37F62073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFL63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:58:29 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34532 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgCFL63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:58:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Trpc5Qt_1583495899;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Trpc5Qt_1583495899)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Mar 2020 19:58:20 +0800
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     aarcange@redhat.com, daniel.m.jordan@oracle.com,
        hannes@cmpxchg.org, hughd@google.com, khlebnikov@yandex-team.ru,
        kirill@shutemov.name, kravetz@us.ibm.com, mhocko@kernel.org,
        mm-commits@vger.kernel.org, tj@kernel.org, vdavydov.dev@gmail.com,
        willy@infradead.org, yang.shi@linux.alibaba.com
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <b123f1d8-eab0-4689-9400-ba1f853728b7@linux.alibaba.com>
Message-ID: <f37b9b6b-730b-09b0-dd6b-5acba53e71e6@linux.alibaba.com>
Date:   Fri, 6 Mar 2020 19:58:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b123f1d8-eab0-4689-9400-ba1f853728b7@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/6 下午5:04, Alex Shi 写道:
> 
> 
> 在 2020/3/6 上午11:32, Qian Cai 写道:
>>
>>> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
>>>
>>>
>>> The patch titled
>>>     Subject: mm/vmscan: remove unnecessary lruvec adding
>>> has been removed from the -mm tree.  Its filename was
>>>     mm-vmscan-remove-unnecessary-lruvec-adding.patch
>>>
>>> This patch was dropped because it had testing failures
>> Andrew, do you have more information about this failure? I hit a bug
>> here under memory pressure and am wondering if this is related
>> which might save me some time digging…
>>
>> [ 4389.727184][ T6600] mem_cgroup_update_lru_size(00000000bb31aaed, 0, -7): lru_size -1
> 
> This bug seems failed due to a update_lru_size() missing or misplace, but
> what's I changed on this patch seems unlike to cause this bug.
> 
> Anyway, Qian, could you do me a favor to remove this patch and try again?

Compare to this patch's change, the 'c8cba0cc2a80 mm/thp: narrow lru locking' is more
likely bad. Maybe it's due to lru unlock was moved before ClearPageCompound() from
before remap_page(head); guess this unlock should be move after ClearPageCompound or
move back to origin place.

But I still can not reproduce this bug. Awkward!

Alex

---
line 2605 mm/huge_memory.c:
        spin_unlock_irqrestore(&pgdat->lru_lock, flags);

        ClearPageCompound(head);

        split_page_owner(head, HPAGE_PMD_ORDER);

        /* See comment in __split_huge_page_tail() */
        if (PageAnon(head)) {
                /* Additional pin to swap cache */
                if (PageSwapCache(head)) {
                        page_ref_add(head, 2);
                        xa_unlock(&swap_cache->i_pages);
                } else {
                        page_ref_inc(head);
                }
        } else {
                /* Additional pin to page cache */
                page_ref_add(head, 2);
                xa_unlock(&head->mapping->i_pages);
        }

        remap_page(head);

