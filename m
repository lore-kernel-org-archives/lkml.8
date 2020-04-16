Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19009C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B3C21841
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633039AbgDPLYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:24:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:39622 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633001AbgDPLU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:20:56 -0400
Received: from [192.168.15.163]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1jP2ZF-0003vx-HH; Thu, 16 Apr 2020 14:20:25 +0300
Subject: Re: [PATCH v4] mm/ksm: Fix NULL pointer dereference when KSM zero
 page is enabled
To:     Markus Elfring <Markus.Elfring@web.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <20200416025034.29780-1-songmuchun@bytedance.com>
 <20200415195841.da4361916f662a0136a271a5@linux-foundation.org>
 <516df5d7-b514-11dc-130e-f1a2edce0108@web.de>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e620f913-d0fb-7d48-b6b2-d4c6b433b563@virtuozzo.com>
Date:   Thu, 16 Apr 2020 14:20:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <516df5d7-b514-11dc-130e-f1a2edce0108@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.2020 09:14, Markus Elfring wrote:
> …
>>> +++ b/mm/ksm.c
>>> @@ -2112,8 +2112,15 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
> …
>>> +		if (vma)
>>> +			err = try_to_merge_one_page(vma, page,
>>> +					ZERO_PAGE(rmap_item->address));
>>> +		else
>>> +			/**
>>> +			 * If the vma is out of date, we do not need to
>>> +			 * continue.
>>> +			 */
>>> +			err = 0;
>>>  		up_read(&mm->mmap_sem);
> …
>> It's conventional to put braces around multi-line blocks such as this.
> 
> Are there different views to consider around the usage of single statements
> together with curly brackets in if branches?

For me Andrew's conversion is the best readable. I try to comment the code
the same way myself. I even thought it's kernel default style :)

Kirill

