Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A392521744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgHFByd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:54:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50662 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgHFByc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:54:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4t6vRJ_1596678867;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4t6vRJ_1596678867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Aug 2020 09:54:28 +0800
Subject: Re: [PATCH v17 13/21] mm/lru: introduce TestClearPageLRU
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-14-git-send-email-alex.shi@linux.alibaba.com>
 <9b906469-38fb-8a4e-9a47-d617c7669579@linux.alibaba.com>
 <CAKgT0Ud1+FkJcTXR0MxZYFxd7mr=opdXfXKTqkmiu4NNMyT4bg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f9fa46a4-b341-2470-ce18-03379b9ea5c2@linux.alibaba.com>
Date:   Thu, 6 Aug 2020 09:54:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud1+FkJcTXR0MxZYFxd7mr=opdXfXKTqkmiu4NNMyT4bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/6 上午6:43, Alexander Duyck 写道:
>> @@ -878,9 +877,8 @@ void release_pages(struct page **pages, int nr)
>>                                 spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
>>                         }
>>
>> -                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>> -                       VM_BUG_ON_PAGE(!PageLRU(page), page);
>>                         __ClearPageLRU(page);
>> +                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
>>                 }
>>
> The more I look at this piece it seems like this change wasn't really
> necessary. If anything it seems like it could catch potential bugs as
> it was testing for the PageLRU flag before and then clearing it
> manually anyway. In addition it doesn't reduce the critical path by
> any significant amount so I am not sure these changes are providing
> any benefit.

Don't know hat kind of bug do you mean here, since the page is no one using, means
no one could ClearPageLRU in other place,  so if you like to keep the VM_BUG_ON_PAGE,
that should be ok.

Thanks!
Alex
