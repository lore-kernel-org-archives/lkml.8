Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A815C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392492076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgHDGO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:14:26 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47747 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgHDGOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:14:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0U4ikaQA_1596521656;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4ikaQA_1596521656)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 14:14:16 +0800
Subject: Re: [PATCH v17 00/21] per memcg lru lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <49d4f3bf-ccce-3c97-3a4c-f5cefe2d623a@linux.alibaba.com>
 <c00ac587-7f69-768a-84ea-53cbf7469ae9@linux.alibaba.com>
 <alpine.LSU.2.11.2007291105570.4649@eggly.anvils>
 <08c8797d-1935-7b41-b8db-d22f054912ac@linux.alibaba.com>
 <20200803150704.GV5174@dhcp22.suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <70a88c67-d612-783b-b392-f572b7a0d4d9@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 14:14:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200803150704.GV5174@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/3 下午11:07, Michal Hocko 写道:
> On Thu 30-07-20 10:16:13, Alex Shi wrote:
>>
>>
>> 在 2020/7/30 上午2:06, Hugh Dickins 写道:
>>> On Wed, 29 Jul 2020, Alex Shi wrote:
>>>>
>>>> Is there any comments or suggestion for this patchset?
>>>> Any hints will be very appreciated.
>>>
>>> Alex: it is now v5.8-rc7, obviously too late for this patchset to make
>>> v5.9, so I'm currently concentrated on checking some patches headed for
>>> v5.9 (and some bugfix patches of my own that I don't get time to send):
>>> I'll get back to responding on lru_lock in a week or two's time.
>>
>> Hi Hugh,
>>
>> Thanks a lot for response! It's fine to wait longer.
>> But thing would be more efficient if review get concentrated...
>> I am still too new in mm area.
> 
> I am sorry and owe you a review but it is hard to find time for that.
> This is a large change and the review will be really far from trivial.
> If this version is mostly stable then I would recommend not posting new
> versions and simply remind people you expect the review from by a
> targeted ping.
> 

hi Michal,

Thanks a lot for reminder!

Except a update on patch [PATCH v17 18/21] mm/lru: introduce the relock_page_lruvec function
from Alexander, the patchset is stable on 5.8.

Just on linux-next, there are changes on hpage_nr_pages -> thp_nr_pages func name change, and
lru_note_cost changes that they need a new update.
And I have another 3 more patches, following this patchset which do clean up and optimzing.

Is it worth for a new patchset? or let me just update here?

Thanks
Alex
