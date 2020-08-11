Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE951C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A311F20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHKBuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:50:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbgHKBuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:50:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D89131BCE288B65FB54;
        Tue, 11 Aug 2020 09:50:14 +0800 (CST)
Received: from [10.174.179.61] (10.174.179.61) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 11 Aug 2020 09:50:10 +0800
Subject: Re: [PATCH] mm/slub: remove useless kmem_cache_debug
From:   Abel Wu <wuyun.wu@huawei.com>
To:     David Rientjes <rientjes@google.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <liu.xiang6@zte.com.cn>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200810080758.940-1-wuyun.wu@huawei.com>
 <alpine.DEB.2.23.453.2008101244090.2938695@chino.kir.corp.google.com>
 <63ee904c-f6b7-3a00-c51d-3ff0feabc9d6@huawei.com>
Message-ID: <aea0039e-9b34-572c-7cd1-0bfce22a961f@huawei.com>
Date:   Tue, 11 Aug 2020 09:50:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <63ee904c-f6b7-3a00-c51d-3ff0feabc9d6@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/11 9:29, Abel Wu wrote:
> 
> 
> On 2020/8/11 3:44, David Rientjes wrote:
>> On Mon, 10 Aug 2020, wuyun.wu@huawei.com wrote:
>>
>>> From: Abel Wu <wuyun.wu@huawei.com>
>>>
>>> The commit below is incomplete, as it didn't handle the add_full() part.
>>> commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")
>>>
>>> Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
>>> ---
>>>  mm/slub.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index fe81773..0b021b7 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2182,7 +2182,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>>>  		}
>>>  	} else {
>>>  		m = M_FULL;
>>> -		if (kmem_cache_debug(s) && !lock) {
>>> +#ifdef CONFIG_SLUB_DEBUG
>>> +		if (!lock) {
>>>  			lock = 1;
>>>  			/*
>>>  			 * This also ensures that the scanning of full
>>> @@ -2191,6 +2192,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>>>  			 */
>>>  			spin_lock(&n->list_lock);
>>>  		}
>>> +#endif
>>>  	}
>>>
>>>  	if (l != m) {
>>
>> This should be functionally safe, I'm wonder if it would make sense to 
>> only check for SLAB_STORE_USER here instead of kmem_cache_debug(), 
>> however, since that should be the only context in which we need the 
>> list_lock for add_full()?  It seems more explicit.
>> .
>>
> Yes, checking for SLAB_STORE_USER here can also get rid of noising macros.
> I will resend the patch later.
> 
> Thanks,
> 	Abel
> .
> 
Wait... It still needs CONFIG_SLUB_DEBUG to wrap around, but can avoid
locking overhead when SLAB_STORE_USER is not set (as what you said).
I will keep the CONFIG_SLUB_DEBUG in my new patch.
