Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5152083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgG2Ot2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:49:28 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49614 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbgG2Ot1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:49:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U4A94nS_1596034160;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4A94nS_1596034160)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 22:49:20 +0800
Subject: Re: [PATCH v17 00/21] per memcg lru lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <49d4f3bf-ccce-3c97-3a4c-f5cefe2d623a@linux.alibaba.com>
Message-ID: <c00ac587-7f69-768a-84ea-53cbf7469ae9@linux.alibaba.com>
Date:   Wed, 29 Jul 2020 22:49:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <49d4f3bf-ccce-3c97-3a4c-f5cefe2d623a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any comments or suggestion for this patchset?
Any hints will be very appreciated.

Thanks
Alex

在 2020/7/27 下午1:40, Alex Shi 写道:

> A standard for new page isolation steps like the following:
> 1, get_page(); #pin the page avoid be free
> 2, TestClearPageLRU(); #serialize other isolation, also memcg change
> 3, spin_lock on lru_lock; #serialize lru list access
> The step 2 could be optimzed/replaced in scenarios which page is unlikely
> be accessed by others.
> 
> 
> 
> 在 2020/7/25 下午8:59, Alex Shi 写道:
>> The new version which bases on v5.8-rc6. It includes Hugh Dickins fix in 
>> mm/swap.c and mm/mlock.c fix which Alexander Duyck pointed out, then
>> removes 'mm/mlock: reorder isolation sequence during munlock' 
>>
>> Hi Johanness & Hugh & Alexander & Willy,
>>
>> Could you like to give a reviewed by since you address much of issue and
>> give lots of suggestions! Many thanks!
