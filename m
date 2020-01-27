Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D1FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D7B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0RA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:00:29 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:59862 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgA0RA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:00:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tocs7WW_1580144404;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tocs7WW_1580144404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jan 2020 01:00:06 +0800
Subject: Re: [PATCH] mm: mempolicy: use VM_BUG_ON_VMA in
 queue_pages_test_walk()
To:     Li Xinhai <lixinhai.lxh@gmail.com>,
        akpm <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1579068565-110432-1-git-send-email-yang.shi@linux.alibaba.com>
 <2020011520081970082765@gmail.com>
 <2a9ad6d6-af98-987a-0878-6058702db912@linux.alibaba.com>
 <20200116235250155994144@gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <70b6680c-7d3c-e04e-9e12-aab69a906d19@linux.alibaba.com>
Date:   Mon, 27 Jan 2020 08:59:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200116235250155994144@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/20 7:52 AM, Li Xinhai wrote:
> On 2020-01-16 at 01:27 Yang Shi wrote:
>>
>> On 1/15/20 4:08 AM, Li Xinhai wrote:
>>> On 2020-01-15 at 14:09 Yang Shi wrote:
>>>> The VM_BUG_ON() is already used by queue_pages_test_walk(), it sounds
>>>> better to dump more debug information by using VM_BUG_ON_VMA() to help
>>>> debugging.
>>>>
>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>> The .test_walk() is to be called from pagewalk with the rule that 'start'
>>> and 'end' must within range of vma, in case the rule is broke, we detect
>>> it. This is not quite relevant to a bug of particular vma.
>> But when you run into VMA range check failure, isn't it helpful to dump
>> the VMA range information to ease debugging? And, VM_BUG_ON is already
>> used in the code, I'm supposed the users may prefer more debug
>> information dumped for debug kernel.
>>
> Got your point, it is already used better put more information.

Hi Andrew,

Would you like to take this patch for v5.6 or v5.7? It looks Xinhai 
agrees with my point.

Thanks,
Yang

>>>> ---
>>>> mm/mempolicy.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>>>> index 067cf7d..801d45d 100644
>>>> --- a/mm/mempolicy.c
>>>> +++ b/mm/mempolicy.c
>>>> @@ -621,7 +621,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>>>> unsigned long flags = qp->flags;
>>>>
>>>> /* range check first */
>>>> -	VM_BUG_ON((vma->vm_start > start) || (vma->vm_end < end));
>>>> +	VM_BUG_ON_VMA((vma->vm_start > start) || (vma->vm_end < end), vma);
>>>>
>>>> if (!qp->first) {
>>>> qp->first = vma;
>>>> --
>>>> 1.8.3.1
>>>>
>>>>
> >

