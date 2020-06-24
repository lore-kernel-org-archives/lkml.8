Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF51C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC8020702
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406116AbgFXTSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:18:11 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55626 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404563AbgFXTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:18:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0cnbjv_1593026284;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U0cnbjv_1593026284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jun 2020 03:18:06 +0800
Subject: Re: [PATCH] mm: filemap: clear idle flag for writes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hannes@cmpxchg.org, riel@surriel.com, shakeelb@google.com,
        gavin.dg@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1593020612-13051-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200624115317.792d8fc6369d421d2898ab2f@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b1959a9b-d660-3a99-df37-fea141eda44d@linux.alibaba.com>
Date:   Wed, 24 Jun 2020 12:18:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200624115317.792d8fc6369d421d2898ab2f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/20 11:53 AM, Andrew Morton wrote:
> On Thu, 25 Jun 2020 01:43:32 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Since commit bbddabe2e436aa7869b3ac5248df5c14ddde0cbf ("mm: filemap:
>> only do access activations on reads"), mark_page_accessed() is called
>> for reads only.  But the idle flag is cleared by mark_page_accessed() so
>> the idle flag won't get cleared if the page is write accessed only.
>>
>> Basically idle page tracking is used to estimate workingset size of
>> workload, noticeable size of workingset might be missed if the idle flag
>> is not maintained correctly.
>>
>> It seems good enough to just clear idle flag for write operations.
>>
>> ...
>>
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/delayacct.h>
>>   #include <linux/psi.h>
>>   #include <linux/ramfs.h>
>> +#include <linux/page_idle.h>
>>   #include "internal.h"
>>   
>>   #define CREATE_TRACE_POINTS
>> @@ -1630,6 +1631,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>>   
>>   	if (fgp_flags & FGP_ACCESSED)
>>   		mark_page_accessed(page);
>> +	else if (fgp_flags & FGP_WRITE) {
>> +		/* Clear idle flag for buffer write */
>> +		if (page_is_idle(page))
>> +			clear_page_idle(page);
>> +	}
>>   
>>   no_page:
>>   	if (!page && (fgp_flags & FGP_CREAT)) {
> The kerneldoc comment for pagecache_get_page() could do with some
> updating - it fails to mention FGP_WRITE, FGP_NOFS and FGP_NOWAIT.

Yes, will propose a separate patch later on.

>
> This change seems correct but also will have runtime effects.  What are
> they?

Other than a couple of extra cycles when idle page tracking is enabled, 
I didn't think of other effects. It should be negligible. The idle flag 
doesn't play a role in page reclaim algorithm, so it won't have impact 
on that.


