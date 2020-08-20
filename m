Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A7522B49
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgHTMaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:30:55 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49010 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729791AbgHTJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:51:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U6IvpVk_1597917064;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6IvpVk_1597917064)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Aug 2020 17:51:05 +0800
Subject: Re: [RFC PATCH v2 4/5] mm: Split release_pages work into 3 passes
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042730.23414.41309.stgit@localhost.localdomain>
 <15edf807-ce03-83f7-407d-5929341b2b4e@linux.alibaba.com>
 <CAKgT0UepdfjXn=j8e4xEBFmsNJdzJyN57em8dscr-Er4OBZCOg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a88eef1b-242d-78c6-fecb-35ea00cd739b@linux.alibaba.com>
Date:   Thu, 20 Aug 2020 17:49:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UepdfjXn=j8e4xEBFmsNJdzJyN57em8dscr-Er4OBZCOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/19 下午10:57, Alexander Duyck 写道:
>>>       lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>> the lock bounce is better with the patch, would you like to do further
>> like using add_lruvecs to reduce bounce more?
>>
>> Thanks
>> Alex
> I'm not sure how much doing something like that would add. In my case
> I had a very specific issue that this is addressing which is the fact
> that every compound page was taking the LRU lock and zone lock
> separately. With this patch that is reduced to one LRU lock per 15
> pages and then the zone lock per page. By adding or sorting pages by
> lruvec I am not sure there will be much benefit as I am not certain
> how often we will end up with pages being interleaved between multiple
> lruvecs. In addition as I am limiting the quantity to a pagevec which
> limits the pages to 15 I am not sure there will be much benefit to be
> seen for sorting the pages beforehand.
> 

the relock will unlock and get another lock again, the cost in that, the 2nd
lock need to wait for fairness for concurrency lruvec locking.
If we can do sort before, we should remove the fairness waiting here. Of course, 
perf result depends on scenarios.

Thanks
Alex
