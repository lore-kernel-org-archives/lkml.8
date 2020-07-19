Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F291C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 03:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3AF207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 03:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGSD7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 23:59:43 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56930 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbgGSD7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 23:59:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U36eCsi_1595131176;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U36eCsi_1595131176)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Jul 2020 11:59:37 +0800
Subject: Re: [PATCH v16 15/22] mm/compaction: do page isolation first in
 compaction
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
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-16-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Ue72SfAmxCS+tay1NjioW9WBOvVgrhwUtVPz2aDCrcHPQ@mail.gmail.com>
 <e724c44b-4135-3302-16fa-1df624fa81fa@linux.alibaba.com>
 <CAKgT0UcbvTid8RqDgsZjewdEo1wTD8BDjPHo59UX9gKQEkZUtA@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <dd0a75b5-c8b2-8b66-79b9-0f6ce259e227@linux.alibaba.com>
Date:   Sun, 19 Jul 2020 11:59:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcbvTid8RqDgsZjewdEo1wTD8BDjPHo59UX9gKQEkZUtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/18 上午12:09, Alexander Duyck 写道:
>>> I wonder if it wouldn't make sense to combine these two atomic ops
>>> with tests and the put_page into a single inline function? Then it
>>> could be possible to just do one check and if succeeds you do the
>>> block of code below, otherwise you just fall-through into the -EBUSY
>>> case.
>>>
>> Uh, since get_page changes page->_refcount, TestClearPageLRU changes page->flags,
>> So I don't know how to combine them, could you make it more clear with code?
> Actually it is pretty straight forward. Something like this:
> static inline bool get_page_unless_zero_or_nonlru(struct page *page)
> {
>     if (get_page_unless_zero(page)) {
>         if (TestClearPageLRU(page))
>             return true;
>         put_page(page);
>     }
>     return false;
> }
> 
> You can then add comments as necessary. The general idea is you are
> having to do this in two different spots anyway so why not combine the
> logic? Although it does assume you can change the ordering of the
> other test above.


It doesn't look different with original code, does it?

Thanks
Alex
