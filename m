Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC5EC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8DA2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgICFfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:35:53 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34292 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbgICFft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:35:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U7nAZp3_1599111342;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7nAZp3_1599111342)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 13:35:43 +0800
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in
 pageblock_flags
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
 <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com>
 <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
 <CAKgT0UcXRB2HH4S+k=SmTz0Dgw9pKp=i4kT4U+yy8MFVC6_JWQ@mail.gmail.com>
 <e2bda56b-445d-f2a3-3a3c-3193d65cc743@linux.alibaba.com>
 <CAKgT0UdwOiFocPO5GtjeysPGtOPVVp3E507Wedwz69Em=ejqXw@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8a7a698b-1d36-897d-7ef0-75ec022663c1@linux.alibaba.com>
Date:   Thu, 3 Sep 2020 13:35:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdwOiFocPO5GtjeysPGtOPVVp3E507Wedwz69Em=ejqXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/31 上午4:32, Alexander Duyck 写道:
>> Right that the different level to fix this problem, but narrow the cmpxchg
>> comparsion is still needed and helpful.
> What I was getting at though is that I am not sure that is the case.
> Normally I believe we are always holding the zone lock when updating
> the migrate type. The skip flag is a one-off operation that could
> easily be addressed by changing the logic to use atomic_and or
> atomic_or for the cases where we are updating single bit flags and
> setting the mask value to all 1's or all 0's. So adding this extra
> complexity which only really applies to the skip bit may not provide
> much value, especially as there are a number of possible paths that
> don't use the skip bit anyway.


Using atomic bit set is only helpful for skip bit. but migrate bits are still
do the false sharing sync large.

And actully, for this issue on cmpxchg, it's cross arch issue which it's better
addressed in kernel. I see much of cmpxchg is using in kernel, but no one mentioned
the shortage on this. On this pointer, this problem should be resovled in kernel.

Thanks
Alex
